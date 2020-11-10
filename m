Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E840B2AE104
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKJUuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 15:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJUuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 15:50:23 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A0720674;
        Tue, 10 Nov 2020 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605041422;
        bh=WKPaItb7R+CrQbgIe5mDPrwwrDH4gEBxthXqj1ObDHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KG/CEcKIyD41PIkSQCVIPLNCKyz9sM1+gQsyb39IVrGL1d0ck3Wcilgz1hIZdsh2i
         odeNlQ0qBCsqxqQcDIfFcWvpuRv+QTj+l/eo7EKEU0uIxYzYbpotc9X6W/xT9NkQeP
         4W3+VrygmCBQGgfRn3OP63fC26zg+Pk1mRmIwGHs=
Date:   Tue, 10 Nov 2020 14:50:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, robh@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: dwc: Add support to configure for ECRC
Message-ID: <20201110205020.GA691818@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109192611.16104-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 12:56:11AM +0530, Vidya Sagar wrote:
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Modulo typos/formatting comments below,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for working through this.

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 50 ++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c2dea8fc97c8..ebdc37a58e94 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -225,6 +225,44 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  	dw_pcie_writel_atu(pci, offset + reg, val);
>  }
>  
> +static inline u32 dw_pcie_enable_ecrc(u32 val)
> +{
> +	/*
> +	 *     DesignWare core version 4.90A has this strange design issue
> +	 * where the 'TD' bit in the Control register-1 of the ATU outbound
> +	 * region acts like an override for the ECRC setting i.e. the presence
> +	 * of TLP Digest(ECRC) in the outgoing TLPs is solely determined by
> +	 * this bit. This is contrary to the PCIe spec which says that the
> +	 * enablement of the ECRC is solely determined by the AER registers.
> +	 *     Because of this, even when the ECRC is enabled through AER
> +	 * registers, the transactions going through ATU won't have TLP Digest
> +	 * as there is no way the AER sub-system could program the TD bit which
> +	 * is specific to DsignWare core.

s/DsignWare/DesignWare/

> +	 *    The best way to handle this scenario is to program the TD bit
> +	 * always. It affects only the traffic from root port to downstream
> +	 * devices.

Convention is to separate paragraphs with blank lines, not to indent
the first line.

> +	 * At this point,
> +	 *     When ECRC is enabled in AER registers, everything works
> +	 * normally
> +	 *     When ECRC is NOT enabled in AER registers, then,
> +	 * on Root Port:- TLP Digest (DWord size) gets appended to each packet
> +	 *                even through it is not required. Since downstream
> +	 *                TLPs are mostly for configuration accesses and BAR
> +	 *                accesses, they are not in critical path and won't
> +	 *                have much negative effect on the performance.
> +	 * on End Point:- TLP Digest is received for some/all the packets coming
> +	 *                from the root port. TLP Digest is ignored because,
> +	 *                as per the PCIe Spec r5.0 v1.0 section 2.2.3 "TLP Digest Rules",

Wrap to fit in 80 columns.

> +	 *                when an endpoint receives TLP Digest when its
> +	 *                ECRC check functionality is disabled in AER registers,
> +	 *                received TLP Digest is just ignored.
> +	 * Since there is no issue or error reported either side, best way to
> +	 * handle the scenario is to program TD bit by default.
> +	 */
> +
> +	return val | PCIE_ATU_TD;
> +}
> +
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  					     int index, int type,
>  					     u64 cpu_addr, u64 pci_addr,
> @@ -245,8 +283,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -				 type | PCIE_ATU_FUNC_NUM(func_no));
> +	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version == 0x490A)
> +		val = dw_pcie_enable_ecrc(val);
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>  				 PCIE_ATU_ENABLE);
>  
> @@ -292,8 +332,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version == 0x490A)
> +		val = dw_pcie_enable_ecrc(val);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>  
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9d2f511f13fa..285c0ae364ae 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -88,6 +88,7 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TD			BIT(8)
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_CR2			0x908
>  #define PCIE_ATU_ENABLE			BIT(31)
> -- 
> 2.17.1
> 
