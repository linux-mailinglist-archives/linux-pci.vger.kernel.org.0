Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F93426F83
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhJHRZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 13:25:47 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42234 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHRZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 13:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=1yHLeRHO8pkno4brtqUYK5yg4ds6TZrbo20YZ5aS0ts=; b=TiRMQpU8VcTQ+j/z/VlnzBKt8r
        I4P+pAqbpS7QlVGx0LPZkdEEUTh2H3NcPSPxEHdyHSyEnGkdhF9AO6GCJ+teRQHod/BhGVNZIn5vE
        wpR+ax+BY69tQGrutRzEXaUkmcGBoccCrhQt3MuPt7s1az4Rraycv1wQJZF1Jew38sxBu/M4c04Yh
        dUchnTuyiN3gkPkdyF0VdkP+MFPyVbHOtB88Y2ONV1KQKD+etd9zMYnDz9hEuhbOJfFR1AArZGO0l
        myptODJ5ZbVg6eA4hMV6PrL2Q3TAlEHGa2CGLA8nlwBKOiB6hF4CCsNrQmfytyzdFsKzq4mKt7cFl
        2VVIHRWw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mYtb1-0005vv-Hb; Fri, 08 Oct 2021 11:23:48 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>, kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvincao@outlook.com
References: <20211008170550.GA1352932@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e60010f3-f803-e60b-3412-346ccc11a0fb@deltatee.com>
Date:   Fri, 8 Oct 2021 11:23:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008170550.GA1352932@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, kelvin.cao@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-10-08 11:05 a.m., Bjorn Helgaas wrote:
> On Fri, Sep 24, 2021 at 11:08:37AM +0000, kelvin.cao@microchip.com wrote:
>> From: Kelvin Cao <kelvin.cao@microchip.com>
>>
>> Hi,
>>
>> Please find a bunch of patches for the switchtec driver collected over the
>> last few months.
> 
> Question: Is there a reason this driver should be in drivers/pci/?
> 
> It doesn't use any internal PCI core interfaces, e.g., it doesn't
> include drivers/pci/pci.h, and AFAICT it's really just a driver for a
> PCI device that happens to be a switch.
> 
> I don't really *care* that it's in drivers/pci; I rely on Kurt and
> Logan to review changes.  The only problem it presents for me is that
> I have to write merge commit logs for the changes.  You'd think that
> would be trivial, but since I don't know much about the driver, it
> does end up being work for me.

We did discuss this when it was originally merged.

The main reason we want it in the PCI tree is so that it's in a sensible
spot in the Kconfig hierarchy (under PCI support). Seeing it is still
PCI hardware. Dropping it into the miscellaneous devices mess (or
similar) is less than desirable. Moreover, it's not like the maintainers
for misc have any additional knowledge that would make them better
qualified to merge these changes. In fact, I'm sure they'd have less
knowledge and we wouldn't have gotten to the bottom of this last issue
if it had been a different maintainer.

In the future I'll try to be more careful in my reviews to ensure we
have a better understanding and clearer commit messages. If there's
anything else we can do to make your job easier, please let us know.

Thanks,

Logan
