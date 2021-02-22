Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F3321D96
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 17:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBVQ6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 11:58:09 -0500
Received: from foss.arm.com ([217.140.110.172]:56828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhBVQ5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 11:57:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EF9D1FB;
        Mon, 22 Feb 2021 08:56:35 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736DC3F73B;
        Mon, 22 Feb 2021 08:56:33 -0800 (PST)
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
Date:   Mon, 22 Feb 2021 16:56:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-02-22 15:47, Nicolas Saenz Julienne wrote:
> Hi everyone,
> Raspberry Pi 4, a 64bit arm system on chip, contains a PCIe bus that can't
> handle 64bit accesses to its MMIO address space, in other words, writeq() has
> to be split into two distinct writel() operations. This isn't ideal, as it
> misrepresents PCI's promise of being able to treat device memory as regular
> memory, ultimately breaking a bunch of PCI device drivers[1].
> 
> I'd like to have a go at fixing this in a way that can be distributed in a
> generic distro without prejudice to other users.
> 
> AFAIK there is no way to detect this limitation through generic PCIe
> capabilities, so one solution would be to expose it through firmware
> (devicetree in this case), and pass the limitations through 'struct device' so
> as for the drivers to choose the right access method in a way that doesn't
> affect performance much[2]. All in all, most of this doesn't need to be
> PCI-centric as the property could be applied to any MMIO bus.

It is indeed something that people can get wrong with internal buses as 
well - for example commit f2d9848aeb9f is such a workaround, also 
conveniently illustrating the case of significant functionality having 
to be disabled where the device *does* require 64-bit atomicity for 
correctness.

Working around kernel I/O accessors is all very well, but another 
concern for PCI in particular is when things like framebuffer memory can 
get mmap'ed into userspace (or even memremap'ed within the kernel). Even 
in AArch32, compiled code may result in 64-bit accesses being generated 
depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc., 
so it's basically not safe to ever let that happen at all.

Robin.

> 
> Thoughts? Opinions? Is it overkill just for a single SoC?
> 
> Regards,
> Nicolas
> 
> [1] https://github.com/raspberrypi/linux/issues/4158#issuecomment-782351510
> [2] Things might get even weirder as the order in which the 32bit operations
>      are performed might matter (low/high vs high/low).
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
