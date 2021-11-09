Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD144B90C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhKIW4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 17:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243421AbhKIW4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 17:56:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E6061056;
        Tue,  9 Nov 2021 22:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636498415;
        bh=DUkrKohhmKxVrVwwxs6kR7+6zXwnkD0Xigqf6NXU+mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2CfTxYjVAuW5umhgVsey/yMOq6xldUesRxoyBAdZRIREM4WLDkaTNfkC8d76McLR
         93keuDP2okYE3b9OGoj5LZlKVdyp912s2nNqfDynK8OAoyJAMhBlNKfsar0pLZcyD5
         +wTPcmraaNr+56NqLMCjobV7kp2FXVJGkSZxr8ZT4AMEphdB6nXwIXPvEbTTL9JBDH
         EDJByOZx2X85sJYj6xGn9Zfxf2rmnMgG/wzbi/ELUlXAM4df8docvW5EVDlwXy7FS2
         39OeS5vuxJNVM4t6jrJTfPx5K21cb4UGO+AjXIqTWOwWW7wTOhJyyLEugLuJGofWZq
         oF6sVZSUc2j9Q==
Received: by pali.im (Postfix)
        id E24E3795; Tue,  9 Nov 2021 23:53:32 +0100 (CET)
Date:   Tue, 9 Nov 2021 23:53:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Marvell: Update PCIe fixup
Message-ID: <20211109225332.kqyfm4h4kwcnhhhl@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102171259.9590-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102171259.9590-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 18:12:58 Pali Rohár wrote:
> - The code relies on rc_pci_fixup being called, which only happens
>   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
>   this causes a booting failure with a non-obvious cause.
> - Update rc_pci_fixup to set the class properly, copying the
>   more modern style from other places
> - Correct the rc_pci_fixup comment
> 
> This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> PCI-E fixup") for all other Marvell ARM platforms which have same buggy
> PCIe controller and do not use pci-mvebu.c controller driver yet.
> 
> Long-term goal for these Marvell ARM platforms should be conversion to
> pci-mvebu.c controller driver and removal of these fixups in arch code.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: stable@vger.kernel.org

Hello! Patch 2/2 was already applied into mips-next. Could you review
also this patch 1/2?

> 
> ---
> Changes in v2:
> * Move MIPS change into separate patch
> * Add information that this patch is for platforms which do not use pci-mvebu.c
> ---
>  arch/arm/Kconfig              |  1 +
>  arch/arm/mach-dove/pcie.c     | 11 ++++++++---
>  arch/arm/mach-mv78xx0/pcie.c  | 11 ++++++++---
>  arch/arm/mach-orion5x/Kconfig |  1 +
>  arch/arm/mach-orion5x/pci.c   | 12 +++++++++---
>  5 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fc196421b2ce..9f157e973555 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -400,6 +400,7 @@ config ARCH_DOVE
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select GPIOLIB
>  	select HAVE_PCI
> +	select PCI_QUIRKS if PCI
>  	select MVEBU_MBUS
>  	select PINCTRL
>  	select PINCTRL_DOVE
> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> index ee91ac6b5ebf..ecf057a0f5ba 100644
> --- a/arch/arm/mach-dove/pcie.c
> +++ b/arch/arm/mach-dove/pcie.c
> @@ -135,14 +135,19 @@ static struct pci_ops pcie_ops = {
>  	.write = pcie_wr_conf,
>  };
>  
> +/*
> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> + * is operating as a root complex this needs to be switched to
> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> + * the device. Decoding setup is handled by the orion code.
> + */
>  static void rc_pci_fixup(struct pci_dev *dev)
>  {
> -	/*
> -	 * Prevent enumeration of root complex.
> -	 */
>  	if (dev->bus->parent == NULL && dev->devfn == 0) {
>  		int i;
>  
> +		dev->class &= 0xff;
> +		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
>  		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  			dev->resource[i].start = 0;
>  			dev->resource[i].end   = 0;
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index 636d84b40466..9362b5fc116f 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -177,14 +177,19 @@ static struct pci_ops pcie_ops = {
>  	.write = pcie_wr_conf,
>  };
>  
> +/*
> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> + * is operating as a root complex this needs to be switched to
> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> + * the device. Decoding setup is handled by the orion code.
> + */
>  static void rc_pci_fixup(struct pci_dev *dev)
>  {
> -	/*
> -	 * Prevent enumeration of root complex.
> -	 */
>  	if (dev->bus->parent == NULL && dev->devfn == 0) {
>  		int i;
>  
> +		dev->class &= 0xff;
> +		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
>  		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  			dev->resource[i].start = 0;
>  			dev->resource[i].end   = 0;
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index e94a61901ffd..7189a5b1ec46 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -6,6 +6,7 @@ menuconfig ARCH_ORION5X
>  	select GPIOLIB
>  	select MVEBU_MBUS
>  	select FORCE_PCI
> +	select PCI_QUIRKS
>  	select PHYLIB if NETDEVICES
>  	select PLAT_ORION_LEGACY
>  	help
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 76951bfbacf5..5145fe89702e 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -509,14 +509,20 @@ static int __init pci_setup(struct pci_sys_data *sys)
>  /*****************************************************************************
>   * General PCIe + PCI
>   ****************************************************************************/
> +
> +/*
> + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> + * is operating as a root complex this needs to be switched to
> + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> + * the device. Decoding setup is handled by the orion code.
> + */
>  static void rc_pci_fixup(struct pci_dev *dev)
>  {
> -	/*
> -	 * Prevent enumeration of root complex.
> -	 */
>  	if (dev->bus->parent == NULL && dev->devfn == 0) {
>  		int i;
>  
> +		dev->class &= 0xff;
> +		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
>  		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  			dev->resource[i].start = 0;
>  			dev->resource[i].end   = 0;
> -- 
> 2.20.1
> 
