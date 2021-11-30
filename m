Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1A4632B4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 12:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhK3Lqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 06:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbhK3Lqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 06:46:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4AC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 03:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B334EB81840
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 11:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB2C53FC7;
        Tue, 30 Nov 2021 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638272613;
        bh=cKxcJ9ObXwl8nHUKPhMz810cnyb/0e+CTILW+QM8coQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaQSywkR88jDG2sPWQyHgOjS3Zi8Sjn67bn+2r5CjPQBcUKaE8LluEoagKM/OvPkP
         zNEUuWyaY0FT8t1Xrfmu85A1PMwahF36lD2LEDURVJHNET/Z9HfjlDoachK2U22eoP
         QTXOd+lq7gPJkVRc1FZybx3V4WVeLOmhHCbMvoZTJnMv5TFvTn/CSQMyvt6bbOMtVM
         0FoLCnMAZYMvGG/K1QlSFGbhUg6ViPJdBAUqh1k1MCfK2MQDoRh8EqmVHvo/Cv7dod
         09mFiR1T/gGvNTZNw1ujj7kJYM9zMtWwInxD6Wa7Du5MNIPkIsUpOWoFsVvROTH8ff
         TZnEplp7U0/Cg==
Received: by pali.im (Postfix)
        id DCD527DF; Tue, 30 Nov 2021 12:43:29 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:43:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for
 PCI_ROM_ADDRESS1 on emulated bridge"
Message-ID: <20211130114329.c3cm46trb6gc7vol@pali>
References: <20211125160148.26029-1-kabel@kernel.org>
 <20211125160148.26029-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125160148.26029-3-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 25 November 2021 17:01:48 Marek Behún wrote:
> This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.
> 
> PCI Bridge which represents aardvark's PCIe Root Port has Expansion ROM
> Base Address register at offset 0x30, but its meaning is different than
> PCI's Expansion ROM BAR register, although the layout is the same.
> (This is why we thought it does the same thing.)
> 
> First: there is no ROM (or part of BootROM) in the A3720 SOC dedicated
> for PCIe Root Port (or controller in RC mode) containing executable code
> that would initialize the Root Port, suitable for execution in
> bootloader (this is how Expansion ROM BAR is used on x86).
> 
> Second: in A3720 spec the register (address D0070030) is not documented
> at all for Root Complex mode, but similar to other BAR registers, it has
> an "entangled partner" in register D0075920, which does address
> translation for the BAR in D0070030:
> - the BAR register sets the address from the view of PCIe bus
> - the translation register sets the address from the view of the CPU
> 
> The other BAR registers also have this entangled partner, and they
> can be used to:
> - in RC mode: address-checking on the receive side of the RC (they
>   can define address ranges for memory accesses from remote Endpoints
>   to the RC)
> - in Endpoint mode: allow the remote CPU to access memory on A3720
> 
> The Expansion ROM BAR has only the Endpoint part documented, but from
> the similarities we think that it can also be used in RC mode in that
> way.
> 
> So either Expansion ROM BAR has different meaning (if the hypothesis
> above is true), or we don't know it's meaning (since it is not
> documented for RC mode).
> 
> Remove the register from the emulated bridge accessing functions.
> 
> Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Seems that there is missing my tag, so I'm adding:

Reviewed-by: Pali Rohár <pali@kernel.org>

It is really a trap if device has register names and offsets same as in
PCIe spec, also syntax/content of registers is same, but then semantic,
meaning and usage is totally different.

> ---
>  drivers/pci/controller/pci-aardvark.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index baa62cdcaab4..e3001b3b3293 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -32,7 +32,6 @@
>  #define PCIE_CORE_DEV_ID_REG					0x0
>  #define PCIE_CORE_CMD_STATUS_REG				0x4
>  #define PCIE_CORE_DEV_REV_REG					0x8
> -#define PCIE_CORE_EXP_ROM_BAR_REG				0x30
>  #define PCIE_CORE_PCIEXP_CAP					0xc0
>  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> @@ -774,10 +773,6 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
>  		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  
> -	case PCI_ROM_ADDRESS1:
> -		*value = advk_readl(pcie, PCIE_CORE_EXP_ROM_BAR_REG);
> -		return PCI_BRIDGE_EMUL_HANDLED;
> -
>  	case PCI_INTERRUPT_LINE: {
>  		/*
>  		 * From the whole 32bit register we support reading from HW only
> @@ -810,10 +805,6 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
>  		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
>  		break;
>  
> -	case PCI_ROM_ADDRESS1:
> -		advk_writel(pcie, new, PCIE_CORE_EXP_ROM_BAR_REG);
> -		break;
> -
>  	case PCI_INTERRUPT_LINE:
>  		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
>  			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
> -- 
> 2.32.0
> 
