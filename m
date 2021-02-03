Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D330D770
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 11:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhBCK00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 05:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233640AbhBCK0U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 05:26:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B369B614A7;
        Wed,  3 Feb 2021 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612347939;
        bh=r7DX/QwPjeWNXWAAED2oxF9FZ3T3xXWSX0ALos9WL+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6yepVHC7kh2v7FfHhrX7DePfqL/0DCmVhSS32K9bFiMFB1rCprgPww2tb9kQWLHc
         lMfWqS++TB+B681kfuAr2xsChlWZgGrC3qdi7K3X+UozFeRumXGbfisSFS/e22NHhv
         vmN7AtXaJk0gjlRB71yy3yoQvhGtBg55KSySEoT0wmmaWifKY8l63xpDdPCJXiA2Ur
         DUOfwg66dq3ReDpbsyF53a6wSCbSTQE4TXpKBN95CeSGy4gM3FcSPQ4FIFNzJ0rCep
         xNAJBwkEUaF19MnfTq8v+pU8ZFuhKGPfAW5SXNraBL8qmLCduSWJuaMzk2X6vRsyJa
         RskglmqoXh8Vg==
Received: by pali.im (Postfix)
        id 3D06F949; Wed,  3 Feb 2021 11:25:37 +0100 (CET)
Date:   Wed, 3 Feb 2021 11:25:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pci-bridge-emul: fix array overruns, improve safety
Message-ID: <20210203102537.hfw3hioqsu4j5jdq@pali>
References: <E1l6z9W-0006Re-MQ@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1l6z9W-0006Re-MQ@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 February 2021 17:07:46 Russell King wrote:
> We allow up to PCI_EXP_SLTSTA2 registers to be accessed, but the
> PCIe behaviour (pcie_cap_regs_behavior) array only covers up to
> PCI_EXP_RTSTA. Expand this array to avoid walking off the end of it.
> 
> Do the same for pci_regs_behavior for consistency, and add a
> BUILD_BUG_ON() to also check the bridge->conf structure size.
> 
> Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks good!

Reviewed-by: Pali Rohár <pali@kernel.org>

Just to note that I'm planning to send a patch which adds missing
register definitions for pcie_cap_regs_behavior[].

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
