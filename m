Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F65324EDE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBYLL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 06:11:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhBYLLY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 06:11:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C12D6E;
        Thu, 25 Feb 2021 03:10:37 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143143F73D;
        Thu, 25 Feb 2021 03:10:34 -0800 (PST)
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Robin Murphy <robin.murphy@arm.con>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
 <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
 <20210224202538.GA2346950@infradead.org>
 <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
 <0e52b124-e5a8-cdea-9f15-11be8c20af2a@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0cca5246-065b-b52e-7005-b1b5229922a7@arm.com>
Date:   Thu, 25 Feb 2021 11:10:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0e52b124-e5a8-cdea-9f15-11be8c20af2a@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-02-25 10:29, Neil Armstrong wrote:
> On 24/02/2021 21:35, Florian Fainelli wrote:
>>
>>
>> On 2/24/2021 12:25 PM, Christoph Hellwig wrote:
>>> On Wed, Feb 24, 2021 at 08:55:10AM -0800, Florian Fainelli wrote:
>>>>> Working around kernel I/O accessors is all very well, but another
>>>>> concern for PCI in particular is when things like framebuffer memory can
>>>>> get mmap'ed into userspace (or even memremap'ed within the kernel). Even
>>>>> in AArch32, compiled code may result in 64-bit accesses being generated
>>>>> depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc.,
>>>>> so it's basically not safe to ever let that happen at all.
>>>>
>>>> Agreed, this makes finding a generic solution a tiny bit harder. Do you
>>>> have something in mind Nicolas?
>>>
>>> The only workable solution is a new
>>>
>>> bool 64bit_mmio_supported(void)

Note that to be sufficiently generic this would have to be a per-device 
property - a system could have an affected PCIe root complex but still 
have other devices elsewhere in the SoC that can, or even need to, use 
64-bit accesses.

>>> check that is used like:
>>>
>>> 	if (64bit_mmio_supported())
>>> 		readq(foodev->regs, REG_OFFSET);
>>> 	else
>>> 		lo_hi_readq(foodev->regs, REG_OFFSET);
>>>
>>> where 64bit_mmio_supported() return false for all 32-bit kernels,
>>> true for all non-broken 64-bit kernels and is an actual function
>>> for arm64 multiplatforms builds that include te RPi quirk.
>>>
>>> The above would then replace the existing magic from the
>>> <linux/io-64-nonatomic-lo-hi.h> and <linux/io-64-nonatomic-hi-lo.h>
>>> headers.
>>
>> That would work. The use case described by Robin is highly unlikely to
>> exist on the Pi4 given that you cannot easily access the PCIe bus and
>> plug an arbitrary GPU, so maybe there is nothing to do for framebuffer
>> memory.

Framebuffers are only the most obvious example - I don't feel the 
inclination to audit every driver/subsystem that can possibly make a 
non-iomem remapping or userspace mmap of a prefetchable BAR, but I'm 
sure there are more.

> Erf, not really, with the compute module ATX/ITX boards are being designed with a full PCIe connector like:
> https://www.indiegogo.com/projects/over-board-raspberry-pi-4-mini-itx-motherboard/#/

Right, this whole thread looks to have come about due to random 
endpoints getting connected to the exposed bus on compute modules. If it 
was an issue at all for the XHCI on standard Pi 4 boards I don't think 
people would just be starting to notice it now...

Robin.
