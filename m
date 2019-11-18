Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC1100639
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfKRNLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 08:11:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfKRNLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 08:11:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB981FB;
        Mon, 18 Nov 2019 05:11:01 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E867E3F6C4;
        Mon, 18 Nov 2019 05:10:59 -0800 (PST)
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, shawn.lin@rock-chips.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <347bc3ef8399577e4cef3fdbf3af34d20b4ad27e.1573908530.git.robin.murphy@arm.com>
 <20191118115930.GC9761@sirena.org.uk>
 <a59da4a4-de88-62a5-5f44-001f8e30221e@arm.com>
 <20191118123951.GM43905@e119886-lin.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0e9a54e-4938-0afe-5059-bddf7e9ae1d9@arm.com>
Date:   Mon, 18 Nov 2019 13:10:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118123951.GM43905@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/11/2019 12:39 pm, Andrew Murray wrote:
> On Mon, Nov 18, 2019 at 12:20:10PM +0000, Robin Murphy wrote:
>> On 18/11/2019 11:59 am, Mark Brown wrote:
>>> On Sat, Nov 16, 2019 at 12:54:20PM +0000, Robin Murphy wrote:
>>>> Null checks are both cheaper and more readable than having !IS_ERR()
>>>> splattered everywhere.
>>>
>>>> -	if (IS_ERR(rockchip->vpcie3v3))
>>>> +	if (!rockchip->vpcie3v3)
>>>>    		return;
>>>>    	/*
>>>> @@ -611,6 +611,7 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>>>>    		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
>>>>    			return PTR_ERR(rockchip->vpcie12v);
>>>>    		dev_info(dev, "no vpcie12v regulator found\n");
>>>> +		rockchip->vpcie12v = NULL;
>>>
>>> According to the API NULL is a valid regulator.  We don't currently
>>> actually do this but it's storing up surprises if you treat it as
>>> invalid.
>>
>> Ah, OK - I'd assumed NULL wasn't valid based on regulator_enable()
>> immediately dereferencing its argument without any checks. If we'd rather
>> not bake in that assumption then this patch can happily be ignored.
> 
> I'd suggest we drop this patch.
> 
> "IS_ERR(ptr)" is not the same as "!ptr", for values of ptr between 0 and
> -4095 inclusive.

Hence the explicit initial "if (IS_ERR(ptr)) ptr = NULL;" condition 
quoted above ;)

But yeah, it was merely an attempt at a minor cosmetic cleanup, so let's 
just forget about it to avoid any possible confusion.

Cheers,
Robin.
