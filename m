Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4A2AB7A7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgKIMAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 07:00:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIMAq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 07:00:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CF9101E;
        Mon,  9 Nov 2020 04:00:45 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5087A3F718;
        Mon,  9 Nov 2020 04:00:44 -0800 (PST)
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
 <4885f7f6-f71e-7d07-6096-7eb061001815@arm.com>
 <b96b1149-d2fd-c131-c329-3e1c0cf3689d@suse.com>
 <510f7f70-f6cf-0a5f-4aef-500619f237f2@suse.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <74abf5b6-4595-fc72-6029-e4475fef1a1f@arm.com>
Date:   Mon, 9 Nov 2020 12:00:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <510f7f70-f6cf-0a5f-4aef-500619f237f2@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-07 13:30, Qu Wenruo wrote:
> 
> 
> On 2020/11/7 下午8:54, Qu Wenruo wrote:
>>
>>
>> On 2020/11/7 下午8:47, Robin Murphy wrote:
>>> On 2020-11-07 11:36, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2019/11/21 上午1:05, Lorenzo Pieralisi wrote:
>>>>> On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
>>>>>> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
>>>>>> are thus fundamental to PCIe being usable at all. As such, it makes
>>>>>> sense to treat them as non-optional and rely on dummy regulators if
>>>>>> not explicitly described.
>>>>>>
>>>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>>>> ---
>>>>>>    drivers/pci/controller/pcie-rockchip-host.c | 69
>>>>>> ++++++++-------------
>>>>>>    1 file changed, 25 insertions(+), 44 deletions(-)
>>>>>
>>>>> Applied to pci/rockchip, thanks.
>>>>
>>>> Sorry, this commit is cause regression for RK3399 boards unable to
>>>> detect the controller anymore.
>>>>
>>>> The 1v8 (and 0v9) is causing -517 and reject the controller
>>>> initialization.
>>>
>>> That's -EPROBE_DEFER, which must mean that a regulator *is* described,
>>> but you're missing the relevant driver - that's an issue with your
>>> config/initrd. Being optional should only change the behaviour if the
>>> supply is totally absent (i.e. you get -ENODEV instead of a dummy
>>> regulator), so I don't see that it would make any difference in this
>>> situation anyway :/
>>>
>>>> I'm not a PCI guy, but a quick google search shows these two voltages
>>>> are not related to PCIE core functionality, especially considering the
>>>> controller used in RK3399 are mostly to provide NVME support.
>>>
>>> Unlike the 12V and 3V3 supplies to the slot, these supplies are to the
>>> PCIE_AVDD_0V9 and PCIE_AVDD_1V8 pins on the SoC itself, which the
>>> datasheet describe as "Supply voltage for PCIE". Having power is kind of
>>> important for the I/O circuits on all the signal pins to work.
>>>
>>> Now it's almost certainly true that these supplies technically belong to
>>> the phy rather than the controller, but it's a bit late to change the
>>> bindings for the sake of semantics.
>>>
>>>> This bug makes all RK3399 users who put root fs into NVME driver unable
>>>> to boot the device.
>>>>
>>>> I really hope some one could test the patch before affecting the end
>>>> users or at least try to understand how most users would use the PCIE
>>>> interface for.
>>>
>>> I *am* that end user in this case - I use an M.2 NVME on my board, which
>>> prompted me to take a look at the regulator handling here in the first
>>> place, to see if it might be possible to shut up the annoying message
>>> about a 12V supply that is entirely irrelevant to a board without a
>>> full-size PCIe slot. I use a mainline-based distro, so I've been running
>>> this change for nearly a year since it landed in v5.5, and I'm sure many
>>> others have too. I've not heard of any other complaints in that time...
>>
>> Sorry for the wrong wording, thank you for your contribution first.
>>
>> It really makes RK3399 the primary testing bed for 64K page size, and
>> save me a lot of time.
>>
>> I'm wondering how the -EPROBE_DEFER happens.
>> I have only tested two kernel versions, v5.9-rc4 and v5.10-rc2.
>> The config works for rc4, unless something big changed in rc2, it
>> shouldn't change much, right?
>>
>> The 1v8 and 0v9 is just alwayson regulator, IMHO it doesn't really need
>> special driver.
>> Or does it?
> 
> Not a regulator guys by all means, but the dtsi shows the 1v8 and 0v9
> are all provided by rk808, while the dmesg shows:
> 
> [    0.195604] reg-fixed-voltage vcc3v3-pcie-regulator: Looking up
> vin-supply from device tree
> [    0.196096] reg-fixed-voltage vcc3v3-pcie-regulator: vcc3v3_pcie
> supplying 3300000uV
> [    0.197724] reg-fixed-voltage vcc5v0-host-regulator: Looking up
> vin-supply from device tree
> [    0.198211] reg-fixed-voltage vcc5v0-host-regulator: vcc5v0_host
> supplying 0uV
> [    0.198581] reg-fixed-voltage vcc5v0-typec-regulator: Looking up
> vin-supply from device tree
> [    0.199082] reg-fixed-voltage vcc5v0-typec-regulator: vcc5v0_typec
> supplying 0uV
> [    0.199395] reg-fixed-voltage vcc3v3-phy-regulator: vcc_lan supplying
> 3300000uV
> [    1.074253] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
> [    1.086470] pwm-regulator vdd-log: Looking up pwm-supply from device tree
> [    1.086484] pwm-regulator vdd-log: Looking up pwm-supply property in
> node /vdd-log failed
> [    1.086501] vdd_log: supplied by regulator-dummy
> [    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
> [    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
> [    1.419856] rk808 0-001b: failed to register 12 regulator
> [    1.422801] rk808-regulator: probe of rk808-regulator failed with
> error -22
> 
> So this means something wrong with the rk808, resulting no voltage
> provided from rk808 and screwing up the pcie controller?

Frankly PCIe is the least of your worries there - if the system PMIC is 
failing to probe then pretty much everything will be degraded: cpufreq 
won't work, some SD card modes won't work, on some boards entire 
peripherals like ethernet might not work if they're wired up to use the 
opposite I/O domain voltage setting from the SoC's power-on default.

Focusing on PCIe getting probe-deferred seems a bit like complaining 
that the carpets on the Titanic are wet ;)

Robin.
