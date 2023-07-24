Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D577175EF11
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjGXJZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGXJZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 05:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8945FD;
        Mon, 24 Jul 2023 02:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8F261007;
        Mon, 24 Jul 2023 09:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47250C433C8;
        Mon, 24 Jul 2023 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690190710;
        bh=8O9VQSiFMULv8D+ewifq1TPDI8/RywKN013pnVPM0bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rACGdXL5/fIIkJu+2P6LO6W6Ue+206wtwMVG3ajyFORIRxLDdKxGWSwhsSSA4V07v
         oR5H2qFkdnbCH443/eKEpO6QZZALhrOxGPGbtrNSp+xVr2ZP84ftlb3gYeiaU2Xx0q
         2mN5Oe/F7Abx06zxnBR1v3ahtxy1+pUAeKibUVWygnTQyLLQ7ptN/N0yT2GtEzNTNO
         76/1WAynuwkvjRGmiFArMAFLD9ZMPrMh8zs+s2y1YmS9PMdP92B8VyMfDkRrQZnlzv
         cPyjVSqy8t4mevwz67jdphAJeZW0DTvqYb4tyV8HABpcotkLN4DeyR/+uYxhyZHPb/
         GLAdSzB/R9KqQ==
Date:   Mon, 24 Jul 2023 14:54:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Message-ID: <20230724092454.GF6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:39PM +0900, Yoshihiro Shimoda wrote:
> The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> for DWC") added .func_conf_select() to get the configuration space of
> different PFs and assumed that the offsets between dbi and dbi2 would
> be the same. However, Renesas R-Car Gen4 PCIe controllers have different
> offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> the offset for dbi2, add .func_conf_select2() and
> dw_pcie_ep_func_select2().
> 

How about,

.get_dbi2_offset() and dw_pcie_ep_get_dbi2_offset()?

This would've been much simpler if dw_pcie_writeX_{dbi/dbi2} APIs accepted the
func_no argument, so that these offset calculations are contained in the API
definitions itself as it should. Then the APIs could just do "func_offset *
func_no" to get DBI base and "(func_offset * func_no) + dbi2_offset" to get DBI2
base, provided these offsets are passed by the vendor drivers.

It can be done in a separate cleanup series later.

> Notes that dw_pcie_ep_func_select2() will call .func_conf_select()

s/Notes/Note

> if .func_conf_select2() doesn't exist for backward compatibility.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1d24ebf9686f..bd57516d5313 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
>  	return func_offset;
>  }
>  
> +static unsigned int dw_pcie_ep_func_select2(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	unsigned int func_offset = 0;
> +
> +	if (ep->ops->func_conf_select2)
> +		func_offset = ep->ops->func_conf_select2(ep, func_no);
> +	else if (ep->ops->func_conf_select)	/* for backward compatibility */
> +		func_offset = ep->ops->func_conf_select(ep, func_no);
> +
> +	return func_offset;
> +}
> +
>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
>  				   enum pci_barno bar, int flags)
>  {
> -	u32 reg;
> -	unsigned int func_offset = 0;
> +	u32 reg, reg_dbi2;
> +	unsigned int func_offset, func_offset_dbi2;

Please maitain reverse Xmas tree order.

- Mani

>  	struct dw_pcie_ep *ep = &pci->ep;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
>  
>  	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> +	reg_dbi2 = func_offset_dbi2 + PCI_BASE_ADDRESS_0 + (4 * bar);
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
>  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
>  	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
> @@ -232,13 +246,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
> -	unsigned int func_offset = 0;
> +	unsigned int func_offset, func_offset_dbi2;
>  	int ret, type;
> -	u32 reg;
> +	u32 reg, reg_dbi2;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> +	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset_dbi2;
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		type = PCIE_ATU_TYPE_MEM;
> @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
>  	dw_pcie_writel_dbi(pci, reg, flags);
>  
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
>  		dw_pcie_writel_dbi(pci, reg + 4, 0);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 812c221b3f7c..94bc20f5f600 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -340,9 +340,10 @@ struct dw_pcie_ep_ops {
>  	 * access for different platform, if different func have different
>  	 * offset, return the offset of func. if use write a register way
>  	 * return a 0, and implement code in callback function of platform
> -	 * driver.
> +	 * driver. The func_conf_select2 is for dbi2.
>  	 */
>  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> +	unsigned int (*func_conf_select2)(struct dw_pcie_ep *ep, u8 func_no);
>  };
>  
>  struct dw_pcie_ep_func {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
