Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56884355A01
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbhDFRIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhDFRIn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 13:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93F25610CC;
        Tue,  6 Apr 2021 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617728915;
        bh=edUzF5nJv0vwtrQnLt0WqWx2dJz93v6JQ8nfxVFT+Pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EJEusLmGIB3wcSA1NdCl8ZZ5/H2kB+o0U7+LoQTb94T24cUw6JjuNEThslx1eBh/W
         TPZ/qGrO7GPmm1itdIVr4TcXkZtyKem6lC5qBAwiZPQyxVmVkgmO1KvFE0yDdzPkUf
         T6tyGxJrYRtiRzRIEeTdLXtrERmyzZgSLWC2oEMTRGtPQfND5hcclG7dIgH7x+0fK0
         3nZS+FeWta12S4uqiOqy/oRBSs5nyB4b6r0JEFKPJWQ1U+i5A5C4DXave8AgO77YoV
         BHkGoahkoI4CJ/zpcNGn8JmUp6Jceqkuq8o+Y2X0iUqTj30wBv5HE3nUaJXGLBm4bg
         qkDYKuGQixrsQ==
Date:   Tue, 6 Apr 2021 12:08:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jason Yan <yanaijie@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] PCI: dwc: Change the inheritance between the abstracted
 structures
Message-ID: <20210406170834.GA1716535@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406092825.24579-1-Zhiqiang.Hou@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 05:28:25PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Currently the core struct dw_pcie includes both struct pcie_port
> and dw_pcie_ep and the RC and EP platform drivers directly
> includes the dw_pcie. So it results in a RC or EP platform driver
> has 2 indirect parents pcie_port and dw_pcie_ep, but it doesn't
> make sense let RC platform driver includes the dw_pcie_ep and
> so does the EP platform driver.
> 
> This patch makes the struct pcie_port and dw_pcie_ep includes
> the core struct dw_pcie and the RC and EP platform drivers
> include struct pcie_port and dw_pcie_ep respectively.

I really like the way this patch is heading.  There's a lot of
historical cruft in these drivers and this is a good step to cleaning
it up.  Thanks a lot for working on this!

What does this patch apply to?  It doesn't apply cleanly to either my
"main" branch or the "next" branch.  Try to send things that apply to
"main" and if it needs to apply on top of something else, mention what
that is.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 12726c63366f..0e914df6eaba 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -85,7 +85,8 @@
>  #define PCIE_B0_B1_TSYNCEN				BIT(0)
>  
>  struct dra7xx_pcie {
> -	struct dw_pcie		*pci;
> +	struct pcie_port	*pp;
> +	struct dw_pcie_ep	*ep;

1) This is not related to your patch, but I think "pcie_port" used to
   make more sense before we had endpoint drivers, but now it's the
   wrong name.  Root Ports and Endpoints both have "PCIe Ports", but
   IIUC "struct pcie_port" only applies to Root Ports, and "struct
   dw_pcie_ep" is the analogue for Endpoints.

   It would be nice to coordinate these names with a separate patch,
   e.g., maybe "dw_pcie_rc" (or "dw_pcie_rp") and "dw_pcie_ep".

2) We allocate struct dra7xx_pcie for both RPs and EPs.  But IIUC, RPs
   only use "struct pcie_port", and EPs only use "struct dw_pcie_ep".
   It doesn't seem right to keep both pointers when only one is ever
   used.

3) I'm not sure why these should be pointers at all.  Why can't they
   be directly embedded, e.g., "struct pcie_port pp" instead of
   "struct pcie_port *pp"?  Obviously this would have to be done in a
   way that we allocate an RC-specific structure or an EP-specific
   one.

>  	void __iomem		*base;		/* DT ti_conf */
>  	int			phy_count;	/* DT phy-names count */
>  	struct phy		**phy;

> @@ -796,6 +798,17 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  
>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
> +		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);

We know "mode" right after the of_match_device() at the top of this
function.  I think we should allocate the RC or EP structure way up
there, ideally with a single alloc for everything we need
(dra7xx_pcie, pcie_port, dw_pcie_ep, etc).  That would be fewer allocs
and would simplify error handling because if the alloc fails we
wouldn't have to undo anything.

> +		if (!pp) {
> +			ret = -ENOMEM;
> +			goto err_gpio;
> +		}
> +
> +		pci = &pp->pcie;
> +		pci->dev = dev;
> +		pci->ops = &dw_pcie_ops;
> +		dra7xx->pp = pp;
> +
>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>  			ret = -ENODEV;
>  			goto err_gpio;
> @@ -813,6 +826,17 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  			goto err_gpio;
>  		break;
>  	case DW_PCIE_EP_TYPE:
> +		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +		if (!ep) {
> +			ret = -ENOMEM;
> +			goto err_gpio;
> +		}
> +
> +		pci = &ep->pcie;
> +		pci->dev = dev;
> +		pci->ops = &dw_pcie_ops;
> +		dra7xx->ep = ep;
> +
>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_EP)) {
>  			ret = -ENODEV;
>  			goto err_gpio;

> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -171,12 +171,44 @@ enum dw_pcie_device_mode {
>  	DW_PCIE_RC_TYPE,
>  };
>  
> +struct dw_pcie_ops {
> +	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> +	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> +			    size_t size);
> +	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> +			     size_t size, u32 val);
> +	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> +			      size_t size, u32 val);
> +	int	(*link_up)(struct dw_pcie *pcie);
> +	int	(*start_link)(struct dw_pcie *pcie);
> +	void	(*stop_link)(struct dw_pcie *pcie);
> +};

I *think* this is a pure code move.  It would make the patch easier to
read if you did the move in a separate patch to reduce the size of
this one.

> +struct dw_pcie {
> +	struct device		*dev;
> +	void __iomem		*dbi_base;
> +	void __iomem		*dbi_base2;
> +	/* Used when iatu_unroll_enabled is true */
> +	void __iomem		*atu_base;
> +	size_t			atu_size;
> +	u32			num_ib_windows;
> +	u32			num_ob_windows;
> +	const struct dw_pcie_ops *ops;
> +	unsigned int		version;
> +	int			num_lanes;
> +	int			link_gen;
> +	u8			n_fts[2];
> +	bool			iatu_unroll_enabled: 1;
> +	bool			io_cfg_atu_shared: 1;
> +};

Same here.

>  struct kirin_pcie {
> -	struct dw_pcie	*pci;
> -	void __iomem	*apb_base;
> -	void __iomem	*phy_base;
> -	struct regmap	*crgctrl;
> -	struct regmap	*sysctrl;
> -	struct clk	*apb_sys_clk;
> -	struct clk	*apb_phy_clk;
> -	struct clk	*phy_ref_clk;
> -	struct clk	*pcie_aclk;
> -	struct clk	*pcie_aux_clk;
> -	int		gpio_id_reset;
> +	struct pcie_port	*pp;
> +	void __iomem		*apb_base;
> +	void __iomem		*phy_base;
> +	struct regmap		*crgctrl;
> +	struct regmap		*sysctrl;
> +	struct clk		*apb_sys_clk;
> +	struct clk		*apb_phy_clk;
> +	struct clk		*phy_ref_clk;
> +	struct clk		*pcie_aclk;
> +	struct clk		*pcie_aux_clk;
> +	int			gpio_id_reset;

Put reformats like this in a separate patch that doesn't actually
change any code (no new or deleted members).  Then this patch will be
smaller and the important changes will be more obvious.
