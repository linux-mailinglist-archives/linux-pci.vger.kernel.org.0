Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581C71947D0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZTsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 15:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZTsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 15:48:14 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2EA206E6;
        Thu, 26 Mar 2020 19:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585252092;
        bh=b6FCW3WlxWo0SYwAFfFxDQ58Wf6zmyYpc8D2IBsWEnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K1kqVHD4FztmdpVIGWhY64PJmspLsqkW0Yb2M0hRvb7pCoZB99w2U/rN06ORAoevq
         +UpuIvl7wntDve6ws2txTDrE/fVyOZd9hxvd3XNh4WRWBOUDFWMrepgiHCUjfoZ1Na
         a+gNhGdJ1R23BBScpzUtqGyduvcUAnqjgbP9h6iY=
Date:   Thu, 26 Mar 2020 14:48:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: Re: [PATCH 1/3] PCI: iproc: fix out of bound array access
Message-ID: <20200326194810.GA11112@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585206447-1363-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change subject to match convention, e.g.,

  PCI: iproc: Fix out-of-bound array accesses

On Thu, Mar 26, 2020 at 12:37:25PM +0530, Srinath Mannam wrote:
> From: Bharat Gooty <bharat.gooty@broadcom.com>
> 
> Declare the full size array for all revisions of PAX register sets
> to avoid potentially out of bound access of the register array
> when they are being initialized in the 'iproc_pcie_rev_init'
> function.

s/the 'iproc_pcie_rev_init' function/iproc_pcie_rev_init()/

It's outside the scope of this patch, but I'm not really a fan of the
pcie->reg_offsets[] scheme this driver uses to deal with these
differences.  There usually seems to be *something* that keeps the
driver from referencing registers that don't exist, but it doesn't
seem like the mechanism is very consistent or robust:

  - IPROC_PCIE_LINK_STATUS is implemented by PAXB but not PAXC.
    iproc_pcie_check_link() avoids using it if "ep_is_internal", which
    is set for PAXC and PAXC_V2.  Not an obvious connection.

  - IPROC_PCIE_CLK_CTRL is implemented for PAXB and PAXC_V1, but not
    PAXC_V2.  iproc_pcie_perst_ctrl() avoids using it ep_is_internal",
    so it *doesn't* use it for PAXC_V1, which does implement it.
    Maybe a bug, maybe intentional; I can't tell.

  - IPROC_PCIE_INTX_EN is only implemented by PAXB (not PAXC), but
    AFAICT, we always call iproc_pcie_enable() and rely on
    iproc_pcie_write_reg() silently drop the write to it on PAXC.

  - IPROC_PCIE_OARR0 is implemented by PAXB and PAXB_V2 and used by
    iproc_pcie_map_ranges(), which is called if "need_ob_cfg", which
    is set if there's a "brcm,pcie-ob" DT property.  No clear
    connection to PAXB.

I think it would be more readable if we used a single variant
identifier consistently, e.g., the "pcie->type" already used in
iproc_pcie_msi_steer(), or maybe a set of variant-specific function
pointers as pcie-qcom.c does.

> Fixes: 06324ede76cdf ("PCI: iproc: Improve core register population")
> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 0a468c7..6972ca4 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -307,7 +307,7 @@ enum iproc_pcie_reg {
>  };
>  
>  /* iProc PCIe PAXB BCMA registers */
> -static const u16 iproc_pcie_reg_paxb_bcma[] = {
> +static const u16 iproc_pcie_reg_paxb_bcma[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
> @@ -318,7 +318,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
>  };
>  
>  /* iProc PCIe PAXB registers */
> -static const u16 iproc_pcie_reg_paxb[] = {
> +static const u16 iproc_pcie_reg_paxb[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
> @@ -334,7 +334,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
>  };
>  
>  /* iProc PCIe PAXB v2 registers */
> -static const u16 iproc_pcie_reg_paxb_v2[] = {
> +static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
> @@ -363,7 +363,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  };
>  
>  /* iProc PCIe PAXC v1 registers */
> -static const u16 iproc_pcie_reg_paxc[] = {
> +static const u16 iproc_pcie_reg_paxc[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_CLK_CTRL]		= 0x000,
>  	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
>  	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
> @@ -372,7 +372,7 @@ static const u16 iproc_pcie_reg_paxc[] = {
>  };
>  
>  /* iProc PCIe PAXC v2 registers */
> -static const u16 iproc_pcie_reg_paxc_v2[] = {
> +static const u16 iproc_pcie_reg_paxc_v2[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
>  	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
>  	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
> -- 
> 2.7.4
> 
