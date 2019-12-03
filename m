Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFA1102D7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 17:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCQsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 11:48:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfLCQsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 11:48:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9C531B;
        Tue,  3 Dec 2019 08:48:40 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26B13F68E;
        Tue,  3 Dec 2019 08:48:38 -0800 (PST)
Subject: Re: [PATCH v3 4/7] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.com, linux-pci@vger.kernel.org, phil@raspberrypi.org,
        linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-5-nsaenzjulienne@suse.de>
 <ddab6abd-68fb-543d-bb8e-057d92ac15ed@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dda72ec5-3e05-a423-bfce-da34addc922c@arm.com>
Date:   Tue, 3 Dec 2019 16:48:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ddab6abd-68fb-543d-bb8e-057d92ac15ed@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/12/2019 4:31 pm, Jeremy Linton wrote:
> Hi,
> 
> On 11/26/19 3:19 AM, Nicolas Saenz Julienne wrote:
>> From: Jim Quinlan <james.quinlan@broadcom.com>
>>
>> This adds a basic driver for Broadcom's STB PCIe controller, for now
>> aimed at Raspberry Pi 4's SoC, bcm2711.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> ---
>>
>> Changes since v2:
>>    - Correct rc_bar2_offset sign
>>    - Invert IRQ clear and masking in setup code
>>    - Use bitfield.h, redo all register ops while keeping the register
>>      names intact
>>    - Remove all SHIFT register definitions
>>    - Get rid of all _RB writes
>>    - Get rid of of_data
>>    - Don't iterate over inexisting dma-ranges
>>    - Add comment regarding dma-ranges validation
>>    - Small cosmetic cleanups
>>    - Fix license mismatch
>>    - Set driver Kconfig tristate
>>    - Didn't add any comment about the controller not being I/O coherent
>>      for now as I wait for Jeremy's reply
> 
> I guess its fine.. In answer to the original query. It seems that this 
> PCIe bridge requires explicit cache operations for DMA from PCIe 
> endpoints. This wasn't obvious to me at first reading because I was 
> assuming the custom DMA ops were strictly to deal with the stated DMA 
> limits.

FWIW, although it might seem anathema to server folks, non-coherent PCI 
is the overwhelming norm in embedded SoCs. Either way, provided the 
presence or absence of coherency is correctly described via the DT 
"dma-coherent" or ACPI _CCA property, then it's transparently handled by 
the DMA API for the endpoint drivers and irrelevant to the host bridge 
itself - after all, in principle the exact same root complex IP could be 
integrated both coherently and non-coherently in different SoCs.

Robin.

> So if you end up respinning, it still might be worthy mentioning 
> somewhere that this is a non-coherent PCIe implementation. I still hold 
> much of my original reservations about pieces of this driver. 
> Particularly, how it might look if someone wanted to boot the RPi using 
> ACPI on linux. But, I was shown a clever bit of AML recently, which 
> solves those problems for the RPi and the attached XHCI.
> 
> So, given how much time I've looked at the root port configuration/etc 
> sections of this driver and I've not found a serious bug:
> 
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> 
>>
>> Changes since v1:
>>    - Fix Kconfig
>>    - Remove pci domain check
>>    - Remove all MSI related code
>>    - Remove supend/resume code
>>    - Simplify link state wait routine
>>    - Prefix all functions
>>    - Use of_device_get_match_data()
>>    - Use devm_clk_get_optional()
>>    - Get rid of irq variable
>>    - Use STB all over the driver
>>    - Simplify map_bus() function
>>    - Fix license mismatch
>>    - Remove unused register definitions
>>    - Small cleanups, spell errors
>>
>> This is based on Jim's original submission[1] but adapted and tailored
>> specifically to bcm2711's needs (that's the Raspberry Pi 4). Support for
>> the rest of the brcmstb family will soon follow once we get support for
>> multiple dma-ranges in dma/direct.
>>
>> [1] https://patchwork.kernel.org/patch/10605959/
>>
>>   drivers/pci/controller/Kconfig        |   8 +
>>   drivers/pci/controller/Makefile       |   1 +
>>   drivers/pci/controller/pcie-brcmstb.c | 753 ++++++++++++++++++++++++++
>>   3 files changed, 762 insertions(+)
>>   create mode 100644 drivers/pci/controller/pcie-brcmstb.c
>>
> 
> Thanks,
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
