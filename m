Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC68345C4E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCWKxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 06:53:45 -0400
Received: from foss.arm.com ([217.140.110.172]:43876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhCWKxh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 06:53:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A18A1042;
        Tue, 23 Mar 2021 03:53:37 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AC33F719;
        Tue, 23 Mar 2021 03:53:36 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:53:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Correct definition of
 ROCKCHIP_PCIE_EP_MSI_CTRL_ME
Message-ID: <20210323105331.GA29286@e121166-lin.cambridge.arm.com>
References: <1608771161-34681-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608771161-34681-1-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 24, 2020 at 08:52:41AM +0800, Shawn Lin wrote:
> ROCKCHIP_PCIE_EP_MSI_CTRL_ME should be BIT(0), and fix the flags
> to be u32 type.

We need two patches, two logical changes.

I will drop this patch waiting for those.

Lorenzo

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/controller/pcie-rockchip-ep.c | 7 ++++---
>  drivers/pci/controller/pcie-rockchip.h    | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 7631dc3..a25e212 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -313,7 +313,7 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags;
> +	u32 flags;
>  
>  	flags = rockchip_pcie_read(rockchip,
>  				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> @@ -333,7 +333,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags;
> +	u32 flags;
>  
>  	flags = rockchip_pcie_read(rockchip,
>  				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> @@ -417,7 +417,8 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  					 u8 interrupt_num)
>  {
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags, mme, data, data_mask;
> +	u16 mme, data, data_mask;
> +	u32 flags;
>  	u8 msi_count;
>  	u64 pci_addr, pci_addr_mask = 0xff;
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 1650a50..c668268 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -221,7 +221,7 @@
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
> -#define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(0)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
>  #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
>  #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
> -- 
> 2.7.4
> 
> 
> 
