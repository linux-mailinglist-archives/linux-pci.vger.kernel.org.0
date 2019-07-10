Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DAE64D52
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGJUOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 16:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfGJUOj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 16:14:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5772064A;
        Wed, 10 Jul 2019 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562789678;
        bh=wtm+DjyVQOY6e2saxu9q/9JBUtIjNNcNelSObGoKHtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjFZzsIvy/bV1Wm5fVzdmbDSd8Z4gZtj9UPorTpWXw2d2eh2xapf/1TmvBENz5JoO
         IQhrfXxZ/31Nz2SFTi4+beNghuV5Vmstb+tuc+L0txzAo55jxD0Tm5W/MPYVFDkLh4
         Q1rrsydh6lhtmpjujnq6DeFlPyLX/z0uJ8/XLRSs=
Date:   Wed, 10 Jul 2019 15:14:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V13 01/12] PCI: Add #defines for some of PCIe spec r4.0
 features
Message-ID: <20190710201433.GC35486@google.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710062212.1745-2-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 10, 2019 at 11:52:01AM +0530, Vidya Sagar wrote:
> Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
> features as defined in PCIe spec r4.0, sec 7.7.4 for Data Link Feature and
> sec 7.7.5 for Physical Layer 16.0 GT/s.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good, thanks!

> ---
> V13:
> * Updated commit message to include references from spec
> * Removed unused defines and moved some from pcie-tegra194.c file
> * Addressed review comments from Bjorn
> 
> V12:
> * None
> 
> V11:
> * None
> 
> V10:
> * None
> 
> V9:
> * None
> 
> V8:
> * None
> 
> V7:
> * None
> 
> V6:
> * None
> 
> V5:
> * None
> 
> V4:
> * None
> 
> V3:
> * Updated commit message and description to explicitly mention that defines are
>   added only for some of the features and not all.
> 
> V2:
> * None
> 
>  include/uapi/linux/pci_regs.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..d28d0319d932 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -713,7 +713,9 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> +#define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1053,4 +1055,14 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
>  
> +/* Data Link Feature */
> +#define PCI_DLF_CAP		0x04	/* Capabilities Register */
> +#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
> +
> +/* Physical Layer 16.0 GT/s */
> +#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
> +#define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
> +#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
> +#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
> +
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.17.1
> 
