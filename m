Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474951CBA66
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 00:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEHWET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 18:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgEHWET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 18:04:19 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48981214D8;
        Fri,  8 May 2020 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588975458;
        bh=avZYZU8DXmnKvpPLGgUx20xCLw9v/4nfaCqlduZjnv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KBavIX4Pysh7EosejxjixI0cFqB9BEaEdy0QPxU3GCLD3fv51XYL6ZPBg4+wru/Er
         iTF08hKBfdE59zWgKOUG/OGLxgDA1qqRMG98awwWJ9J3AeALSzdxn3dxeHUiW9TRZN
         3oQrr5y84xuut4/pP2vgOKnUpc03F7YuEfgeVuOw=
Date:   Fri, 8 May 2020 17:04:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v8 5/5] MIPS: Loongson64: Switch to generic PCI driver
Message-ID: <20200508220416.GA96874@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508113414.3091532-5-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 07:34:05PM +0800, Jiaxun Yang wrote:
> We can now enable generic PCI driver in Kconfig, and remove legacy
> PCI driver code.
> 
> Radeon vbios quirk is moved to the platform folder to fit the
> new structure.

> diff --git a/arch/mips/loongson64/vbios_quirk.c b/arch/mips/loongson64/vbios_quirk.c
> new file mode 100644
> index 000000000000..1f0a462aeddd
> --- /dev/null
> +++ b/arch/mips/loongson64/vbios_quirk.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0

In arch/mips/pci/fixup-loongson3.c, pci_fixup_radeon() was under "GPL
version 2 or (at your option) any later version."

Documentation/process/license-rules.rst says that corresponds to
GPL-2.0+, not GPL-2.0.

> +static void pci_fixup_radeon(struct pci_dev *pdev)
> +{
> ...
> +}

> diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
> deleted file mode 100644
> index 8a741c2c6685..000000000000
> --- a/arch/mips/pci/fixup-loongson3.c
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -/*
> - * fixup-loongson3.c
> - *
> - * Copyright (C) 2012 Lemote, Inc.
> - * Author: Xiang Yu, xiangy@lemote.com
> - *         Chen Huacai, chenhc@lemote.com
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - *
> - * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - */
> -
> -#include <linux/pci.h>
> -#include <boot_param.h>
> -
> -static void print_fixup_info(const struct pci_dev *pdev)
> -{
> -	dev_info(&pdev->dev, "Device %x:%x, irq %d\n",
> -			pdev->vendor, pdev->device, pdev->irq);
> -}
> -
> -int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	print_fixup_info(dev);
> -	return dev->irq;
> -}
> -
> -static void pci_fixup_radeon(struct pci_dev *pdev)
> -{
> -	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
> -
> -	if (res->start)
> -		return;
> -
> -	if (!loongson_sysconf.vgabios_addr)
> -		return;
> -
> -	pci_disable_rom(pdev);
> -	if (res->parent)
> -		release_resource(res);
> -
> -	res->start = virt_to_phys((void *) loongson_sysconf.vgabios_addr);
> -	res->end   = res->start + 256*1024 - 1;
> -	res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> -		     IORESOURCE_PCI_FIXED;
> -
> -	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
> -		 PCI_ROM_RESOURCE, res);
> -}
> -
> -DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> -				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
> -
> -/* Do platform specific device initialization at pci_enable_device() time */
> -int pcibios_plat_dev_init(struct pci_dev *dev)
> -{
> -	return 0;
> -}
