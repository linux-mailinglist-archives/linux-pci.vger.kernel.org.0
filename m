Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC392AA50F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGMsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Nov 2020 07:48:04 -0500
Received: from foss.arm.com ([217.140.110.172]:50800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgKGMsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Nov 2020 07:48:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 077871474;
        Sat,  7 Nov 2020 04:48:03 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15BA03F66E;
        Sat,  7 Nov 2020 04:48:00 -0800 (PST)
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
To:     Qu Wenruo <wqu@suse.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     heiko@sntech.de, linux-pci@vger.kernel.org,
        shawn.lin@rock-chips.com, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
 <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4885f7f6-f71e-7d07-6096-7eb061001815@arm.com>
Date:   Sat, 7 Nov 2020 12:47:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e8a91353-49ab-7581-f2a8-b8b4729072bf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-07 11:36, Qu Wenruo wrote:
> 
> 
> On 2019/11/21 上午1:05, Lorenzo Pieralisi wrote:
>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>> sense to treat them as non-optional and rely on dummy regulators if
>>> not explicitly described.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/pci/controller/pcie-rockchip-host.c | 69 ++++++++-------------
>>>   1 file changed, 25 insertions(+), 44 deletions(-)
>>
>> Applied to pci/rockchip, thanks.
> 
> Sorry, this commit is cause regression for RK3399 boards unable to
> detect the controller anymore.
> 
> The 1v8 (and 0v9) is causing -517 and reject the controller initialization.

That's -EPROBE_DEFER, which must mean that a regulator *is* described, 
but you're missing the relevant driver - that's an issue with your 
config/initrd. Being optional should only change the behaviour if the 
supply is totally absent (i.e. you get -ENODEV instead of a dummy 
regulator), so I don't see that it would make any difference in this 
situation anyway :/

> I'm not a PCI guy, but a quick google search shows these two voltages
> are not related to PCIE core functionality, especially considering the
> controller used in RK3399 are mostly to provide NVME support.

Unlike the 12V and 3V3 supplies to the slot, these supplies are to the 
PCIE_AVDD_0V9 and PCIE_AVDD_1V8 pins on the SoC itself, which the 
datasheet describe as "Supply voltage for PCIE". Having power is kind of 
important for the I/O circuits on all the signal pins to work.

Now it's almost certainly true that these supplies technically belong to 
the phy rather than the controller, but it's a bit late to change the 
bindings for the sake of semantics.

> This bug makes all RK3399 users who put root fs into NVME driver unable
> to boot the device.
> 
> I really hope some one could test the patch before affecting the end
> users or at least try to understand how most users would use the PCIE
> interface for.

I *am* that end user in this case - I use an M.2 NVME on my board, which 
prompted me to take a look at the regulator handling here in the first 
place, to see if it might be possible to shut up the annoying message 
about a 12V supply that is entirely irrelevant to a board without a 
full-size PCIe slot. I use a mainline-based distro, so I've been running 
this change for nearly a year since it landed in v5.5, and I'm sure many 
others have too. I've not heard of any other complaints in that time...

Robin.

> 
> Thanks,
> Qu
> 
>>
>> Lorenzo
>>
>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
>>> index ef8e677ce9d1..68525f8ac4d9 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>>>   		dev_info(dev, "no vpcie3v3 regulator found\n");
>>>   	}
>>>   
>>> -	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
>>> -	if (IS_ERR(rockchip->vpcie1v8)) {
>>> -		if (PTR_ERR(rockchip->vpcie1v8) != -ENODEV)
>>> -			return PTR_ERR(rockchip->vpcie1v8);
>>> -		dev_info(dev, "no vpcie1v8 regulator found\n");
>>> -	}
>>> +	rockchip->vpcie1v8 = devm_regulator_get(dev, "vpcie1v8");
>>> +	if (IS_ERR(rockchip->vpcie1v8))
>>> +		return PTR_ERR(rockchip->vpcie1v8);
>>>   
>>> -	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
>>> -	if (IS_ERR(rockchip->vpcie0v9)) {
>>> -		if (PTR_ERR(rockchip->vpcie0v9) != -ENODEV)
>>> -			return PTR_ERR(rockchip->vpcie0v9);
>>> -		dev_info(dev, "no vpcie0v9 regulator found\n");
>>> -	}
>>> +	rockchip->vpcie0v9 = devm_regulator_get(dev, "vpcie0v9");
>>> +	if (IS_ERR(rockchip->vpcie0v9))
>>> +		return PTR_ERR(rockchip->vpcie0v9);
>>>   
>>>   	return 0;
>>>   }
>>> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>>>   		}
>>>   	}
>>>   
>>> -	if (!IS_ERR(rockchip->vpcie1v8)) {
>>> -		err = regulator_enable(rockchip->vpcie1v8);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>>> -			goto err_disable_3v3;
>>> -		}
>>> +	err = regulator_enable(rockchip->vpcie1v8);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
>>> +		goto err_disable_3v3;
>>>   	}
>>>   
>>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>>> -		err = regulator_enable(rockchip->vpcie0v9);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> -			goto err_disable_1v8;
>>> -		}
>>> +	err = regulator_enable(rockchip->vpcie0v9);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> +		goto err_disable_1v8;
>>>   	}
>>>   
>>>   	return 0;
>>>   
>>>   err_disable_1v8:
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>>   err_disable_3v3:
>>>   	if (!IS_ERR(rockchip->vpcie3v3))
>>>   		regulator_disable(rockchip->vpcie3v3);
>>> @@ -897,8 +886,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>>>   
>>>   	rockchip_pcie_disable_clocks(rockchip);
>>>   
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>   
>>>   	return ret;
>>>   }
>>> @@ -908,12 +896,10 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>>>   	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>>>   	int err;
>>>   
>>> -	if (!IS_ERR(rockchip->vpcie0v9)) {
>>> -		err = regulator_enable(rockchip->vpcie0v9);
>>> -		if (err) {
>>> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> -			return err;
>>> -		}
>>> +	err = regulator_enable(rockchip->vpcie0v9);
>>> +	if (err) {
>>> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
>>> +		return err;
>>>   	}
>>>   
>>>   	err = rockchip_pcie_enable_clocks(rockchip);
>>> @@ -939,8 +925,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>>>   err_pcie_resume:
>>>   	rockchip_pcie_disable_clocks(rockchip);
>>>   err_disable_0v9:
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>   	return err;
>>>   }
>>>   
>>> @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>>   		regulator_disable(rockchip->vpcie12v);
>>>   	if (!IS_ERR(rockchip->vpcie3v3))
>>>   		regulator_disable(rockchip->vpcie3v3);
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>   err_set_vpcie:
>>>   	rockchip_pcie_disable_clocks(rockchip);
>>>   	return err;
>>> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>>>   		regulator_disable(rockchip->vpcie12v);
>>>   	if (!IS_ERR(rockchip->vpcie3v3))
>>>   		regulator_disable(rockchip->vpcie3v3);
>>> -	if (!IS_ERR(rockchip->vpcie1v8))
>>> -		regulator_disable(rockchip->vpcie1v8);
>>> -	if (!IS_ERR(rockchip->vpcie0v9))
>>> -		regulator_disable(rockchip->vpcie0v9);
>>> +	regulator_disable(rockchip->vpcie1v8);
>>> +	regulator_disable(rockchip->vpcie0v9);
>>>   
>>>   	return 0;
>>>   }
>>> -- 
>>> 2.17.1
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
