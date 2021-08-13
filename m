Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B43EB74D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbhHMPBV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:01:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241033AbhHMPBV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:01:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EBE1042;
        Fri, 13 Aug 2021 08:00:54 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC443F718;
        Fri, 13 Aug 2021 08:00:51 -0700 (PDT)
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com> <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
 <20210813143250.GA5209@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <566c26bb-c488-8c86-f47e-6a748b9b6c77@arm.com>
Date:   Fri, 13 Aug 2021 16:00:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813143250.GA5209@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-13 15:32, Mark Brown wrote:
> On Fri, Aug 13, 2021 at 03:01:10PM +0100, Robin Murphy wrote:
> 
>> Indeed I've thought before that it would be nice if regulators worked like
>> GPIOs, where the absence of an optional one does give you NULL, and most of
>> the API is also NULL-safe. Probably a pretty big job though...
> 
> It also encourages *really* bad practice with error handling, and in
> general there are few use cases for optional regulators where there's
> not some other actions that need to be taken in the case where the
> supply isn't there (elimintating some operating points or features,
> reconfiguring power internally and so on).  If we genuninely don't need
> to do anything special one wonders why we're trying to turn the power on
> in the first place.

Sure, once you get into it, regulators are arguably a rather deeper area 
than GPIOs, so in terms of the NULL-safe aspect anything beyond 
enable/disable - for the sake of keeping trivial usage simple - would be 
pretty questionable for sure.

A lot of the usage of regulator_get_optional() seems to be just making 
sure some external thing is powered between probe() and remove() if it's 
not hard-wired already, so maybe something like a 
devm_regulator_get_optional_enabled() could be an answer to that 
argument without even touching the underlying API.

Robin.
