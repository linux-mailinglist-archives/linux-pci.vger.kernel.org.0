Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225424429C9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBItX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 04:49:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:55619 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhKBItW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 04:49:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mhpRK-0002yN-00; Tue, 02 Nov 2021 09:46:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AEE3DC27BF; Tue,  2 Nov 2021 09:42:41 +0100 (CET)
Date:   Tue, 2 Nov 2021 09:42:41 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102084241.GA6134@alpha.franken.de>
References: <20211101150405.14618-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101150405.14618-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> - The code relies on rc_pci_fixup being called, which only happens
>   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
>   this causes a booting failure with a non-obvious cause.
> - Update rc_pci_fixup to set the class properly, copying the
>   more modern style from other places
> - Correct the rc_pci_fixup comment
> 
> This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> controller.
> [..]

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 771ca53af06d..c8d51bd20b84 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -346,6 +346,7 @@ config MIPS_COBALT
>  	select CEVT_GT641XX
>  	select DMA_NONCOHERENT
>  	select FORCE_PCI
> +	select PCI_QUIRKS
>  	select I8253
>  	select I8259
>  	select IRQ_MIPS_CPU

this is enabled by default, via drivers/pci/Kconfig

config PCI_QUIRKS
        default y
        bool "Enable PCI quirk workarounds" if EXPERT
        help
          This enables workarounds for various PCI chipset bugs/quirks.
          Disable this only if your target machine is unaffected by PCI
          quirks.

> diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
> index 44be65c3e6bb..202f3a0bd97d 100644
> --- a/arch/mips/pci/fixup-cobalt.c
> +++ b/arch/mips/pci/fixup-cobalt.c
> @@ -36,6 +36,12 @@
>  #define VIA_COBALT_BRD_ID_REG  0x94
>  #define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
>  
> +/*
> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> + * is operating as a root complex this needs to be switched to
> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> + * the device. Decoding setup is handled by the orion code.
> + */
>  static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
>  {
>  	if (dev->devfn == PCI_DEVFN(0, 0) &&

this is not a PCIe controller, so how is this patch related ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
