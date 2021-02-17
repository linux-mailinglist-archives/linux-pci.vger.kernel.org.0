Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0646231E301
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 00:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBQXas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 18:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBQXas (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 18:30:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6E09600EF;
        Wed, 17 Feb 2021 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613604606;
        bh=CT6bpmyVS41KdJy4ZUvkLaBaOaGujeUrFveQxG0XL2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OTD4XYRLiCymow838KzcZ9GxU5SGtKdmtQ8b0ZQlCpWVp6ZNqJSSt0AcB+MMKWGq7
         YcN4oJmwoGEjvsx0PGHkZinXdZbe5SXm+YQeOP5N4nVvyq4Lub/x+uojqwGnnESx7p
         ciRaRNgKgt47NU3+dEYOzzhdhnwqomAQjgd6qH/6CTA7kTE8ToG4wy5b8ZG06QbUlf
         yj1zXvwOe13E208UMF7gUHV7a1ynrDKHWspKMhIMO8z9frGbpeb50UqNp+EbfCDsz3
         ODNalPan3gN5nKuHoPFAwGBLX3rqgLchxhfSrg1IyrSFmVAupDMmoB41YSA+76PI6v
         wzToe13hftOQw==
Date:   Wed, 17 Feb 2021 17:30:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Pali Roh__r <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pci-bridge-emul: fix array overruns, improve safety
Message-ID: <20210217233004.GA924023@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1l6z9W-0006Re-MQ@rmk-PC.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 05:07:46PM +0000, Russell King wrote:
> We allow up to PCI_EXP_SLTSTA2 registers to be accessed, but the
> PCIe behaviour (pcie_cap_regs_behavior) array only covers up to
> PCI_EXP_RTSTA. Expand this array to avoid walking off the end of it.
> 
> Do the same for pci_regs_behavior for consistency, and add a
> BUILD_BUG_ON() to also check the bridge->conf structure size.
> 
> Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied with Pali's Reviewed-by to pci/enumeration for v5.12, thanks!

> ---
>  drivers/pci/pci-bridge-emul.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index 139869d50eb2..fdaf86a888b7 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -21,8 +21,9 @@
>  #include "pci-bridge-emul.h"
>  
>  #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
> +#define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
>  #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
> -#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
> +#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
>  
>  /**
>   * struct pci_bridge_reg_behavior - register bits behaviors
> @@ -46,7 +47,8 @@ struct pci_bridge_reg_behavior {
>  	u32 w1c;
>  };
>  
> -static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
> +static const
> +struct pci_bridge_reg_behavior pci_regs_behavior[PCI_STD_HEADER_SIZEOF / 4] = {
>  	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
>  	[PCI_COMMAND / 4] = {
>  		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> @@ -164,7 +166,8 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
>  	},
>  };
>  
> -static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
> +static const
> +struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] = {
>  	[PCI_CAP_LIST_ID / 4] = {
>  		/*
>  		 * Capability ID, Next Capability Pointer and
> @@ -260,6 +263,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
>  int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
>  			 unsigned int flags)
>  {
> +	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
> +
>  	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
>  	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
>  	bridge->conf.cache_line_size = 0x10;
> -- 
> 2.20.1
> 
