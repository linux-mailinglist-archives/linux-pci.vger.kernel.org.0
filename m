Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E21A7AC5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501948AbgDNM2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 08:28:15 -0400
Received: from foss.arm.com ([217.140.110.172]:54386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501933AbgDNM2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 08:28:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BD91FB;
        Tue, 14 Apr 2020 05:28:10 -0700 (PDT)
Received: from [10.57.33.145] (unknown [10.57.33.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA6673F6C4;
        Tue, 14 Apr 2020 05:28:07 -0700 (PDT)
Subject: Re: [BUG] PCI: rockchip: rk3399: pcie switch support
To:     Soeren Moch <smoch@web.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de>
 <3e9d2c53-4f0d-0c97-fbfa-6d799e223747@arm.com>
 <b088ad0e-bab1-0cff-dc43-eb5709555902@web.de>
 <1f180d4b-9e5d-c829-555b-c9750940361e@web.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d02e0b72-5fb3-dd47-468c-08b86db07a9a@arm.com>
Date:   Tue, 14 Apr 2020 13:28:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f180d4b-9e5d-c829-555b-c9750940361e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-04-14 12:35 pm, Soeren Moch wrote:
> On 06.04.20 19:12, Soeren Moch wrote:
>> On 06.04.20 14:52, Robin Murphy wrote:
>>> On 2020-04-04 7:41 pm, Soeren Moch wrote:
>>>> I want to use a PCIe switch on a RK3399 based RockPro64 V2.1 board.
>>>> "Normal" PCIe cards work (mostly) just fine on this board. The PCIe
>>>> switches (I tried Pericom and ASMedia based switches) also work fine on
>>>> other boards. The RK3399 PCIe controller with pcie_rockchip_host driver
>>>> also recognises the switch, but fails to initialize the buses behind the
>>>> bridge properly, see syslog from linux-5.6.0.
>>>>
>>>> Any ideas what I do wrong, or any suggestions what I can test here?
>>> See the thread here:
>>>
>>> https://lore.kernel.org/linux-pci/CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+dfvmCrSnLL=K6Few@mail.gmail.com/
>>>
>> Thanks Robin!
>>
>> I also found out in the meantime that device enumeration fails in this
>> fatal way when probing non-existent devices. So if I hack my complete
>> bus topology into rockchip_pcie_valid_device, then all existing devices
>> come up properly. Of course this is not how PCIe should work.
>>> The conclusion there seems to be that the RK3399 root complex just
>>> doesn't handle certain types of response in a sensible manner, and
>>> there's not much that can reasonably be done to change that.
>> Hm, at least there is the promising suggestion to take over the SError
>> handler, maybe in ATF, as workaround.
> Unfortunately it seems to be not that easy. Only when PCIe device
> probing runs on one of the Cortex-A72 cores of rk3399 we see the SError.
> When probing runs on one of the A53 cores, we get a synchronous external
> abort instead.
> 
> Is this expected to see different error types on big.LITTLE systems? Or
> is this another special property of the rk3399 pcie controller?

As far as I'm aware, the CPU microarchitecture is indeed one of the 
factors in whether it takes a given external abort synchronously or 
asynchronously, so yes, I'd say that probably is expected. I wouldn't 
necessarily even rely on a single microarchitecture only behaving one 
way, since in principle it's possible that surrounding instructions 
might affect whether the core still has enough context left to take the 
exception synchronously or not at the point the abort does come back.

In general external aborts are a "should never happen" kind of thing, so 
they're not necessarily expected to be recoverable (I think the RAS 
extensions might add a more robustness in terms of reporting, but aren't 
relevant here either way).

At this point I'm starting to wonder whether it might be possible to do 
something similar to the Arm N1SDP workaround using the Cortex-M0, 
albeit with the complication that probing would realistically have to be 
explicitly invoked from the Linux driver due to clocks and external 
regulators... :/

Robin.
