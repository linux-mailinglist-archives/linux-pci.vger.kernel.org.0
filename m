Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0C3EB675
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbhHMOBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234353AbhHMOBp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 10:01:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB551042;
        Fri, 13 Aug 2021 07:01:18 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EC0A3F718;
        Fri, 13 Aug 2021 07:01:15 -0700 (PDT)
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com> <20210813135412.GA7722@kadam>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
Date:   Fri, 13 Aug 2021 15:01:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813135412.GA7722@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-13 14:54, Dan Carpenter wrote:
> On Fri, Aug 13, 2021 at 01:55:38PM +0100, Robin Murphy wrote:
>> On 2021-08-13 12:33, Dan Carpenter wrote:
>>> If devm_regulator_get_optional() returns an error pointer, then we
>>> should return it to the user.  The current code makes an exception
>>> for -ENODEV that will result in an error pointer dereference on the
>>> next line when it calls regulator_enable().  Remove the exception.
>>
>> Doesn't this break the apparent intent of the regulator being optional,
>> though?
> 
> Argh...  Crap.  My patch is wrong, but the bug is real.

Yeah, I guess this probably wants to follow the same pattern as 
rockchip_pcie_set_vpcie() in the older driver, where it's the regulator 
API calls which get wrapped in checks.

> This code should follow the standard kernel idiom of returning error
> pointers when there are errors and returning NULL when an optional
> feature is disabled.  The problem with returning a Special Error code
> to mean "disabled" is that someone will use the Special Error code to
> mean an error.
> 
> And that has already sort of happened, because _regulator_get() returns
> -ENODEV which would will cause the Oops I described in my patch.
> 
> Ugh...  The correct thing is to convert it to NULL/error pointers.  I
> have not looked at how hard that is though...

Indeed I've thought before that it would be nice if regulators worked 
like GPIOs, where the absence of an optional one does give you NULL, and 
most of the API is also NULL-safe. Probably a pretty big job though...

Thanks,
Robin.
