Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF83107473
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKVO7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 09:59:10 -0500
Received: from foss.arm.com ([217.140.110.172]:48596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfKVO7K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 09:59:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07C22DA7;
        Fri, 22 Nov 2019 06:59:10 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C59D03F703;
        Fri, 22 Nov 2019 06:59:07 -0800 (PST)
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
To:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, maz@kernel.org,
        Phil Elwell <phil@raspberrypi.org>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Eric Anholt <eric@anholt.net>, mbrugger@suse.com,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-5-nsaenzjulienne@suse.de>
 <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
 <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de>
 <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
 <276d4160bbe6a4e8225bbd836f43d40da41d25f1.camel@suse.de>
 <CANCKTBuoSkmAiY4yUuNpT-GwhS7LJv79L910UvcrPgPpMz=YGg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <24e5302a-51c6-df39-5381-a790752f261d@arm.com>
Date:   Fri, 22 Nov 2019 14:59:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANCKTBuoSkmAiY4yUuNpT-GwhS7LJv79L910UvcrPgPpMz=YGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/11/2019 9:07 pm, Jim Quinlan wrote:
[...]
>> As for [...]_NUM_MASK_BITS I'm looking for a smart/generic way to calculate it
>> from the actual mask. No luck so far. If not, I think I'll simply leave it as
>> is for now.

HWEIGHT()?

>>>> FYI, What's happening here is that we have to save the CPU address range
>>>> (which
>>>> is already shifted right 20 positions) in two parts, the lower 12 bits go
>>>> into
>>>> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT while the higher 8 bits go into
>>>> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI or
>>>> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI.
>>>
>>> The hardware spec require bits 31:20 of the address, and the high registers
>>> require 39:32 right?
>>
>> Yes, that's it.
>>
>>> (Apologies, the indirection by the WR_FLD_** macros easily confuses me. These
>>> type of macros are helpful, or rather would be if the whole kernel used them.
>>> I think they can add confusion when each driver has its own set of similar
>>> macros. This is why its *really* helpful to use any existing macros in the
>>> kernel - and only invent new ones if needed).
>>
>> I agree it's pretty confusing, I think v3, using bitfield.h as much as
>> possible, looks substantially more welcoming.
> 
> The reason we use custom macros is because we'd like to keep the
> register names the same as the HW declares and our internal tools
> support.  As you may have noticed, our register names are unusually
> long and it is hard to fit a simple read or write field assignment
> within 80 columns w/o using custom macros tailored to our register
> names' format.
> 
> Perhaps Nicolas can pull a rabbit out of a hat and use Linux macros
> while keeping our long register names, but if he has to use his own
> shorter register names it will become harder for Broadcom developers
> to debug this driver.

Regardless of the length of the names, the standard bitfield helpers can 
still make things easier to reason about - in this particular case I 
think you could lose some boilerplate and indirection with essentially 
no change to the readability you're concerned for - compare:

#define REG_NAME ...
#define REG_NAME_FIELD_NAME_MASK ...
#define REG_NAME_FIELD_NAME_SHIFT ...

	val = RD_FIELD(base, REG_NAME,
		       FIELD_NAME);

vs.

#define REG_NAME ...
#define   FIELD_NAME ...

	reg = bcm_readl(base + REG_NAME);
	val = FIELD_GET(FIELD_NAME, reg);

Robin.
