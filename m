Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340253F6CD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiFGHDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiFGHDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 03:03:38 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC61A065;
        Tue,  7 Jun 2022 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654585415;
  x=1686121415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Tpqs5BQJ3oWYIsk4ytJGw76vqon2bF2z8AUrL59W+s=;
  b=VFbURqoFKtDRf4xncRrqnf1zI3VLV/neZEbyAURkTRugpJ8oPombZcwB
   JvMv7acMX/MVPWhujubT0u+6g7CmozVElxZt9/w2fx/dktAo2fONtWfCT
   xWec89HOrNEYV2M6NwQeWKiU2GEwAXv2qVEmrc7AplRFpOX4ZW+2Kg9TE
   /6zLcHxBjB/vDYRyJaWfkN7DU7VAssMlpEBU7oLnJBC68KOv6e48Wu6aj
   Xbip+2PHDk2TBOU9yAQ4rRYrDVWU+7xgpGFdIR3cxbZRInQliCBMJ1Nzq
   R87bvuQvWKHkMF2WpeST3JvKQJfXEmZFM0lIjO+/p4bNOE2wOCqy1DKlb
   A==;
Date:   Tue, 7 Jun 2022 09:03:32 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Wangseok Lee <wangseok.lee@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220607070332.GY18902@axis.com>
References: <20220603023452epcms2p22b81cfd1ee4866d5a6663c089ded6eac@epcms2p2>
 <20220603160314.GA76545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220603160314.GA76545@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 06:03:14PM +0200, Bjorn Helgaas wrote:
> In the subject, why do you tag this "axis"?  There's an existing
> pcie-artpec6.c that uses the driver name ""artpec6-pcie" and the
> subject line tag "artpec6".
> 
> This adds pcie-artpec8.c with driver name "artpec8-pcie", so the
> obvious choice would be "artpec8".
> 
> I assume you evaluated the possibility of extending artpec6 to support
> artpec8 in addition to the artpec6 and artpec7 it already supports?

I think that the artpec6 & 7 version of the IP is quite different
in IP version, IP configuration and the glue-logic around the DWC IP.
Obviously integration of the IP is Samsung based, which artpec6 and 7 wasn't.
Even the IP supported by the old Exynos version of the driver seems
quite different in it's intergration. :-(

> On Fri, Jun 03, 2022 at 11:34:52AM +0900, Wangseok Lee wrote:
> > +#define LTSSM_STATE_L0			0x11
> > +
> > +/* FSYS SYSREG Offsets */
> 
> The list below seems to inclue more than just register offsets.

... as I have some internal knowledge I can confirm that these are
glue logic registers and fields specific for ARTPEC-8, which
is what the comment "FSYS SYSREG Offsets" above very cryptically states.
Would this be clearer? "FSYS glue logic system registers"

> > +#define FSYS_PCIE_CON			0x424
> > +#define PCIE_PERSTN			BIT(5)
> > +#define FSYS_PCIE_DBI_ADDR_CON		0x428
> > +#define FSYS_PCIE_DBI_ADDR_OVR_CDM	0x00
> > +#define FSYS_PCIE_DBI_ADDR_OVR_SHADOW	0x12
> > +#define FSYS_PCIE_DBI_ADDR_OVR_ATU	0x36
> > +
> > +/* PMU SYSCON Offsets */

And similarly:
PMU glue logic system registers

> > +#define PMU_SYSCON_PCIE_ISOLATION	0x3200
> > +
> > +/* BUS P/S SYSCON Offsets */
> > +#define BUS_SYSCON_BUS_PATH_ENABLE	0x0
> > +
> > +int artpec8_pcie_dbi_addr_con[] = {
> > +	FSYS_PCIE_DBI_ADDR_CON
> > +};
> > +
> > +struct artpec8_pcie {
> > +	struct dw_pcie			*pci;
> > +	struct clk			*pipe_clk;
> > +	struct clk			*dbi_clk;
> > +	struct clk			*mstr_clk;
> > +	struct clk			*slv_clk;
> > +	const struct artpec8_pcie_pdata	*pdata;
> > +	void __iomem			*elbi_base;
> > +	struct regmap			*sysreg;
> > +	struct regmap			*pmu_syscon;
> > +	struct regmap			*bus_s_syscon;
> > +	struct regmap			*bus_p_syscon;
> > +	enum dw_pcie_device_mode	mode;
> > +	int				link_id;
> > +	/* For Generic PHY Framework */
> 
> Superfluous comment.
> 
> > +	struct phy			*phy;
> > +};
> > +
> > +struct artpec8_pcie_res_ops {
> > +	int (*get_mem_resources)(struct platform_device *pdev,
> > +				 struct artpec8_pcie *artpec8_ctrl);
> > +	int (*get_clk_resources)(struct platform_device *pdev,
> > +				 struct artpec8_pcie *artpec8_ctrl);
> > +	int (*init_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
> > +	void (*deinit_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
> > +};
> > +
> > +struct artpec8_pcie_pdata {
> > +	const struct dw_pcie_ops		*dwc_ops;
> > +	const struct dw_pcie_host_ops			*host_ops;
> 
> Fix indentation to match surrounding code.
> 
> > +	const struct artpec8_pcie_res_ops	*res_ops;
> > +	enum dw_pcie_device_mode		mode;
> > +};
> > +
> > +enum artpec8_pcie_isolation {
> > +	PCIE_CLEAR_ISOLATION = 0,
> > +	PCIE_SET_ISOLATION = 1
> > +};
> > +
> > +enum artpec8_pcie_reg_bit {
> > +	PCIE_REG_BIT_LOW = 0,
> > +	PCIE_REG_BIT_HIGH = 1
> > +};
> > +
> > +static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> > +				u32 reg, size_t size, u32 val);
> > +static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> > +				u32 reg, size_t size);
> > +static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg);
> 
> Can you reorder the function definitions to avoid the need for these
> forward declarations?
> 
> > +static int artpec8_pcie_get_subsystem_resources(struct platform_device *pdev,
> > +					struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +
> > +	/* External Local Bus interface(ELBI) Register */
> > +	artpec8_ctrl->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
> 
> Rewrap to fit in 80 columns.
> 
> > +	if (IS_ERR(artpec8_ctrl->elbi_base)) {
> > +		dev_err(dev, "failed to map elbi_base\n");
> > +		return PTR_ERR(artpec8_ctrl->elbi_base);
> > +	}
> > +
> > +	/* fsys sysreg regmap handle */
> 
> All these comments are superfluous since they only repeat the lookup
> arguments.
> 
> > +	artpec8_ctrl->sysreg =
> > +		syscon_regmap_lookup_by_phandle(dev->of_node,
> 
> The above two lines should fit on one line.
> 
> > +			"samsung,fsys-sysreg");
> > +	if (IS_ERR(artpec8_ctrl->sysreg)) {
> > +		dev_err(dev, "fsys sysreg regmap lookup failed.\n");
> > +		return PTR_ERR(artpec8_ctrl->sysreg);
> > +	}
> > +
> > +	/* pmu syscon regmap handle */
> > +	artpec8_ctrl->pmu_syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +			"samsung,syscon-phandle");
> > +	if (IS_ERR(artpec8_ctrl->pmu_syscon)) {
> > +		dev_err(dev, "pmu syscon regmap lookup failed.\n");
> > +		return PTR_ERR(artpec8_ctrl->pmu_syscon);
> > +	}
> > +
> > +	/* bus s syscon regmap handle */
> > +	artpec8_ctrl->bus_s_syscon =
> > +		syscon_regmap_lookup_by_phandle(dev->of_node,
> > +			"samsung,syscon-bus-s-fsys");
> > +	if (IS_ERR(artpec8_ctrl->bus_s_syscon)) {
> > +		dev_err(dev, "bus_s_syscon regmap lookup failed.\n");
> > +		return PTR_ERR(artpec8_ctrl->bus_s_syscon);
> > +	}
> > +
> > +	/* bus p syscon regmap handle */
> > +	artpec8_ctrl->bus_p_syscon =
> > +		syscon_regmap_lookup_by_phandle(dev->of_node,
> > +			"samsung,syscon-bus-p-fsys");
> > +	if (IS_ERR(artpec8_ctrl->bus_p_syscon)) {
> > +		dev_err(dev, "bus_p_syscon regmap lookup failed.\n");
> > +		return PTR_ERR(artpec8_ctrl->bus_p_syscon);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int artpec8_pcie_get_rc_mem_resources(struct platform_device *pdev,
> > +					     struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	struct dw_pcie *pci = artpec8_ctrl->pci;
> > +
> > +	/* Data Bus Interface(DBI) Register */
> > +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +	if (IS_ERR(pci->dbi_base))
> > +		return PTR_ERR(pci->dbi_base);
> > +
> > +	return 0;
> > +}
> > +
> > +static int artpec8_pcie_get_ep_mem_resources(struct platform_device *pdev,
> > +					  struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	struct dw_pcie_ep *ep;
> > +	struct dw_pcie *pci = artpec8_ctrl->pci;
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +
> > +	ep = &pci->ep;
> 
> Reorder the locals above:
> 
>   struct dw_pcie *pci = artpec8_ctrl->pci;
>   struct device *dev = &pdev->dev;
>   struct dw_pcie_ep *ep = &pci->ep;
>   struct resource *res;
> 
> Then they're in the order you use them and you don't need the extra
> "ep = &pci->ep".
> 
> > +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +	if (IS_ERR(pci->dbi_base)) {
> > +		dev_err(dev, "failed to map ep_dbics\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pci->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
> > +	if (IS_ERR(pci->dbi_base2)) {
> > +		dev_err(dev, "failed to map ep_dbics2\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > +	if (!res)
> > +		return -EINVAL;
> > +	ep->phys_base = res->start;
> > +	ep->addr_size = resource_size(res);
> > +
> > +	return 0;
> > +}
> > +
> > +static int artpec8_pcie_get_clk_resources(struct platform_device *pdev,
> > +				       struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +
> > +	artpec8_ctrl->pipe_clk = devm_clk_get(dev, "pipe_clk");
> > +	if (IS_ERR(artpec8_ctrl->pipe_clk)) {
> > +		dev_err(dev, "couldn't get pipe clock\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	artpec8_ctrl->dbi_clk = devm_clk_get(dev, "dbi_clk");
> > +	if (IS_ERR(artpec8_ctrl->dbi_clk)) {
> > +		dev_info(dev, "couldn't get dbi clk\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	artpec8_ctrl->slv_clk = devm_clk_get(dev, "slv_clk");
> > +	if (IS_ERR(artpec8_ctrl->slv_clk)) {
> > +		dev_err(dev, "couldn't get slave clock\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	artpec8_ctrl->mstr_clk = devm_clk_get(dev, "mstr_clk");
> > +	if (IS_ERR(artpec8_ctrl->mstr_clk)) {
> > +		dev_info(dev, "couldn't get master clk\n");
> 
> It'd be nice if the err/info messages matched the exact DT name:
> "pipe_clk", "dbi_clk", slv_clk", etc.
> 
> Why are some of the above dev_err() and others dev_info() when you
> return -EINVAL in all cases?
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int artpec8_pcie_init_clk_resources(struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	clk_prepare_enable(artpec8_ctrl->pipe_clk);
> > +	clk_prepare_enable(artpec8_ctrl->dbi_clk);
> > +	clk_prepare_enable(artpec8_ctrl->mstr_clk);
> > +	clk_prepare_enable(artpec8_ctrl->slv_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static void artpec8_pcie_deinit_clk_resources(struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	clk_disable_unprepare(artpec8_ctrl->slv_clk);
> > +	clk_disable_unprepare(artpec8_ctrl->mstr_clk);
> > +	clk_disable_unprepare(artpec8_ctrl->dbi_clk);
> > +	clk_disable_unprepare(artpec8_ctrl->pipe_clk);
> > +}
> > +
> > +static const struct artpec8_pcie_res_ops artpec8_pcie_rc_res_ops = {
> > +	.get_mem_resources	= artpec8_pcie_get_rc_mem_resources,
> > +	.get_clk_resources	= artpec8_pcie_get_clk_resources,
> > +	.init_clk_resources	= artpec8_pcie_init_clk_resources,
> > +	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
> > +};
> > +
> > +static const struct artpec8_pcie_res_ops artpec8_pcie_ep_res_ops = {
> > +	.get_mem_resources	= artpec8_pcie_get_ep_mem_resources,
> > +	.get_clk_resources	= artpec8_pcie_get_clk_resources,
> > +	.init_clk_resources	= artpec8_pcie_init_clk_resources,
> > +	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
> > +};
> > +
> > +static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg)
> > +{
> > +	writel(val, base + reg);
> > +}
> > +
> > +static u32 artpec8_pcie_readl(void __iomem *base, u32 reg)
> > +{
> > +	return readl(base + reg);
> > +}
> > +
> > +static int artpec8_pcie_config_phy_power_isolation(struct dw_pcie *pci,
> > +						enum artpec8_pcie_reg_bit val)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	int ret;
> > +
> > +	ret = regmap_write(artpec8_ctrl->pmu_syscon, PMU_SYSCON_PCIE_ISOLATION,
> > +			   val);
> > +
> > +	return ret;
> 
>   return regmap_write(artpec8_ctrl->pmu_syscon, ...);
> 
> > +}
> > +
> > +static int artpec8_pcie_config_bus_enable(struct dw_pcie *pci,
> > +						enum artpec8_pcie_reg_bit val)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	int ret;
> > +
> > +	ret = regmap_write(artpec8_ctrl->bus_p_syscon,
> > +			   BUS_SYSCON_BUS_PATH_ENABLE, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(artpec8_ctrl->bus_s_syscon,
> > +			   BUS_SYSCON_BUS_PATH_ENABLE, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret;
> 
>   return regmap_write(artpec8_ctrl->bus_s_syscon, ...);
> 
> > +}
> > +
> > +static int artpec8_pcie_config_isolation(struct dw_pcie *pci,
> > +					 enum artpec8_pcie_isolation val)
> > +{
> > +	int ret;
> > +	/* reg_val[0] : for phy power isolation */
> > +	/* reg_val[1] : for bus enable */
> > +	enum artpec8_pcie_reg_bit reg_val[2];
> > +
> > +	switch (val) {
> > +	case PCIE_CLEAR_ISOLATION:
> > +		reg_val[0] = PCIE_REG_BIT_LOW;
> > +		reg_val[1] = PCIE_REG_BIT_HIGH;
> > +		break;
> > +	case PCIE_SET_ISOLATION:
> > +		reg_val[0] = PCIE_REG_BIT_HIGH;
> > +		reg_val[1] = PCIE_REG_BIT_LOW;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = artpec8_pcie_config_phy_power_isolation(pci, reg_val[0]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = artpec8_pcie_config_bus_enable(pci, reg_val[1]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret;
> 
>   return artpec8_pcie_config_bus_enable(pci, ...);
> 
> > +}
> > +
> > +static int artpec8_pcie_config_perstn(struct dw_pcie *pci,
> > +				      enum artpec8_pcie_reg_bit val)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	unsigned int bits;
> > +	int ret;
> > +
> > +	if (val == PCIE_REG_BIT_HIGH)
> > +		bits = PCIE_PERSTN;
> > +	else
> > +		bits = 0;
> > +
> > +	ret = regmap_update_bits(artpec8_ctrl->sysreg, FSYS_PCIE_CON,
> > +				 PCIE_PERSTN, bits);
> > +
> > +	return ret;
> 
>   return regmap_update_bits(artpec8_ctrl->sysreg, ...):
> 
> > +}
> > +
> > +static void artpec8_pcie_stop_link(struct dw_pcie *pci)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	u32 val;
> > +
> > +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> > +				 PCIE_APP_LTSSM_ENABLE);
> > +
> > +	val &= ~PCIE_ELBI_LTSSM_ENABLE;
> > +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> > +			PCIE_APP_LTSSM_ENABLE);
> > +}
> > +
> > +static int artpec8_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	u32 val;
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	/* Equalization disable */
> > +	val = artpec8_pcie_read_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF,
> > +				    4);
> > +	artpec8_pcie_write_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF, 4,
> > +			       val | PCIE_GEN3_EQUALIZATION_DISABLE);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +	/* assert LTSSM enable */
> > +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> > +				 PCIE_APP_LTSSM_ENABLE);
> > +
> > +	val |= PCIE_ELBI_LTSSM_ENABLE;
> > +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> > +			PCIE_APP_LTSSM_ENABLE);
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t artpec8_pcie_msi_irq_handler(int irq, void *arg)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = arg;
> > +	struct dw_pcie *pci = artpec8_ctrl->pci;
> > +	struct pcie_port *pp = &pci->pp;
> > +	u32 val;
> > +
> > +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_STS);
> > +
> > +	if ((val & IRQ_MSI_ENABLE) == IRQ_MSI_ENABLE) {
> > +		val &= IRQ_MSI_ENABLE;
> > +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> > +				    PCIE_IRQ2_STS);
> > +		dw_handle_msi_irq(pp);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void artpec8_pcie_msi_init(struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	u32 val;
> > +
> > +	/* enable MSI interrupt */
> > +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_EN);
> > +	val |= IRQ_MSI_ENABLE;
> > +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val, PCIE_IRQ2_EN);
> > +}
> > +
> > +static void artpec8_pcie_enable_interrupts(struct artpec8_pcie *artpec8_ctrl)
> > +{
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		artpec8_pcie_msi_init(artpec8_ctrl);
> > +}
> > +
> > +static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> > +				u32 reg, size_t size)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	u32 val;
> > +	bool is_atu = false;
> > +
> > +	if (base == pci->atu_base) {
> > +		is_atu = true;
> > +		base = pci->dbi_base;
> > +		regmap_write(artpec8_ctrl->sysreg,
> > +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +				FSYS_PCIE_DBI_ADDR_OVR_ATU);
> > +	}
> > +
> > +	dw_pcie_read(base + reg, size, &val);
> > +
> > +	if (is_atu)
> > +		regmap_write(artpec8_ctrl->sysreg,
> > +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +				FSYS_PCIE_DBI_ADDR_OVR_CDM);
> > +
> > +	return val;
> > +}
> > +
> > +static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> > +				u32 reg, size_t size, u32 val)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	bool is_atu = false;
> > +
> > +	if (base == pci->atu_base) {
> > +		is_atu = true;
> > +		base = pci->dbi_base;
> > +		regmap_write(artpec8_ctrl->sysreg,
> > +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +				FSYS_PCIE_DBI_ADDR_OVR_ATU);
> > +	}
> > +
> > +	dw_pcie_write(base + reg, size, val);
> > +
> > +	if (is_atu)
> > +		regmap_write(artpec8_ctrl->sysreg,
> > +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +				FSYS_PCIE_DBI_ADDR_OVR_CDM);
> > +}
> > +
> > +static void artpec8_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
> > +				    u32 reg, size_t size, u32 val)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +
> > +	regmap_write(artpec8_ctrl->sysreg,
> > +		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +			FSYS_PCIE_DBI_ADDR_OVR_SHADOW);
> > +
> > +	dw_pcie_write(base + reg, size, val);
> > +
> > +	regmap_write(artpec8_ctrl->sysreg,
> > +		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> > +			FSYS_PCIE_DBI_ADDR_OVR_CDM);
> > +}
> > +
> > +static int artpec8_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
> > +				    int where, int size, u32 *val)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> > +
> > +	if (PCI_SLOT(devfn)) {
> > +		*val = ~0;
> 
>   PCI_SET_ERROR_RESPONSE(val);
> 
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> > +
> > +	*val = dw_pcie_read_dbi(pci, where, size);
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int artpec8_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
> > +				    int where, int size, u32 val)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> > +
> > +	if (PCI_SLOT(devfn))
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	dw_pcie_write_dbi(pci, where, size, val);
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static struct pci_ops artpec8_pci_ops = {
> > +	.read = artpec8_pcie_rd_own_conf,
> > +	.write = artpec8_pcie_wr_own_conf,
> > +};
> > +
> > +static int artpec8_pcie_link_up(struct dw_pcie *pci)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +	u32 val;
> > +
> > +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> > +			PCIE_ELBI_CXPL_DEBUG_00_31);
> > +
> > +	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
> > +}
> > +
> > +static int artpec8_pcie_host_init(struct pcie_port *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> > +
> > +	pp->bridge->ops = &artpec8_pci_ops;
> > +
> > +	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
> > +				(PCIE_GEN3_EQ_PHASE_2_3 |
> > +				 PCIE_GEN3_RXEQ_PH01_EN |
> > +				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
> > +
> > +	artpec8_pcie_enable_interrupts(artpec8_ctrl);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops artpec8_pcie_host_ops = {
> > +	.host_init = artpec8_pcie_host_init,
> > +};
> > +
> > +static u8 artpec8_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> > +	pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> > +
> > +	if (val == 0xffffffff)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void artpec8_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar;
> 
> Add blank line here and use usual multi-line comment style:
> 
>   /*
>    * Currently PCIe EP core is not ...
> 
> > +	/* Currently PCIe EP core is not setting iatu_unroll_enabled
> > +	 * so let's handle it here. We need to find proper place to
> > +	 * initialize this so that it can be used as for other EP
> 
>   ... can be used for ...
> 
> > +	 * controllers as well.
> > +	 */
> > +	pci->iatu_unroll_enabled = artpec8_pcie_iatu_unroll_enabled(pci);
> > +
> > +	for (bar = BAR_0; bar <= BAR_5; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +}
> > +
> > +static int artpec8_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > +				 enum pci_epc_irq_type type, u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		return -EINVAL;
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pci_epc_features artpec8_pcie_epc_features = {
> > +	.linkup_notifier = false,
> > +	.msi_capable = true,
> > +	.msix_capable = false,
> > +};
> > +
> > +static const struct pci_epc_features*
> > +artpec8_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &artpec8_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops artpec8_dw_pcie_ep_ops = {
> > +	.ep_init	= artpec8_pcie_ep_init,
> > +	.raise_irq	= artpec8_pcie_raise_irq,
> > +	.get_features	= artpec8_pcie_ep_get_features,
> > +};
> > +
> > +static int __init artpec8_add_pcie_ep(struct artpec8_pcie *artpec8_ctrl,
> > +		struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct dw_pcie_ep *ep;
> > +	struct dw_pcie *pci = artpec8_ctrl->pci;
> > +
> > +	ep = &pci->ep;
> 
> Reorder locals and initialize ep as above.
> 
> > +	ep->ops = &artpec8_dw_pcie_ep_ops;
> > +
> > +	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
> > +				(PCIE_GEN3_EQ_PHASE_2_3 |
> > +				 PCIE_GEN3_RXEQ_PH01_EN |
> > +				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
> > +
> > +	ret = dw_pcie_ep_init(ep);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init artpec8_add_pcie_port(struct artpec8_pcie *artpec8_ctrl,
> > +					struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci = artpec8_ctrl->pci;
> > +	struct pcie_port *pp = &pci->pp;
> > +	struct device *dev = &pdev->dev;
> > +	int ret;
> > +	int irq_flags;
> > +	int irq;
> 
> Reorder to be in order of use:
> 
>   struct dw_pcie *pci = artpec8_ctrl->pci;
>   struct pcie_port *pp = &pci->pp;
>   struct device *dev = &pdev->dev;
>   int irq;
>   int irq_flags;
>   int ret;
> 
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		irq = platform_get_irq_byname(pdev, "intr");
> > +		if (!irq)
> > +			return -ENODEV;
> > +
> > +		irq_flags = IRQF_SHARED | IRQF_NO_THREAD;
> > +
> > +		ret = devm_request_irq(dev, irq, artpec8_pcie_msi_irq_handler,
> > +				irq_flags, "artpec8-pcie", artpec8_ctrl);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Prevent core for messing with the IRQ, since it's muxed */
> 
>   Prevent core from ...
> 
> > +	pp->msi_irq = -ENODEV;
> > +
> > +	ret = dw_pcie_host_init(pp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
>   return dw_pcie_host_init(pp);
> 
> > +}
> > +
> > +static const struct dw_pcie_ops artpec8_dw_pcie_ops = {
> > +	.read_dbi	= artpec8_pcie_read_dbi,
> > +	.write_dbi	= artpec8_pcie_write_dbi,
> > +	.write_dbi2	= artpec8_pcie_write_dbi2,
> > +	.start_link	= artpec8_pcie_start_link,
> > +	.stop_link	= artpec8_pcie_stop_link,
> > +	.link_up	= artpec8_pcie_link_up,
> > +};
> > +
> > +static int artpec8_pcie_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct dw_pcie *pci;
> > +	struct pcie_port *pp;
> > +	struct artpec8_pcie *artpec8_ctrl;
> > +	enum dw_pcie_device_mode mode;
> > +	struct device *dev = &pdev->dev;
> > +	const struct artpec8_pcie_pdata *pdata;
> > +	struct device_node *np = dev->of_node;
> 
> Reorder in order of use.
> 
> > +	artpec8_ctrl = devm_kzalloc(dev, sizeof(*artpec8_ctrl), GFP_KERNEL);
> > +	if (!artpec8_ctrl)
> > +		return -ENOMEM;
> > +
> > +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > +	if (!pci)
> > +		return -ENOMEM;
> > +
> > +	pdata = (const struct artpec8_pcie_pdata *)
> 
> Unnecessary cast.
> 
> > +		of_device_get_match_data(dev);
> > +	if (!pdata)
> > +		return -ENODEV;
> > +
> > +	mode = (enum dw_pcie_device_mode)pdata->mode;
> > +
> > +	artpec8_ctrl->pci = pci;
> > +	artpec8_ctrl->pdata = pdata;
> > +	artpec8_ctrl->mode = mode;
> > +
> > +	pci->dev = dev;
> > +	pci->ops = pdata->dwc_ops;
> > +	pci->dbi_base2 = NULL;
> > +	pci->dbi_base = NULL;
> > +	pp = &pci->pp;
> > +	pp->ops = artpec8_ctrl->pdata->host_ops;
> > +
> > +	if (mode == DW_PCIE_RC_TYPE)
> > +		artpec8_ctrl->link_id = of_alias_get_id(np, "pcierc");
> > +	else
> > +		artpec8_ctrl->link_id = of_alias_get_id(np, "pcieep");
> > +
> > +	ret = artpec8_pcie_get_subsystem_resources(pdev, artpec8_ctrl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pdata->res_ops && pdata->res_ops->get_mem_resources) {
> > +		ret = pdata->res_ops->get_mem_resources(pdev, artpec8_ctrl);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (pdata->res_ops && pdata->res_ops->get_clk_resources) {
> > +		ret = pdata->res_ops->get_clk_resources(pdev, artpec8_ctrl);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = pdata->res_ops->init_clk_resources(artpec8_ctrl);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, artpec8_ctrl);
> > +
> > +	ret = artpec8_pcie_config_isolation(pci, PCIE_CLEAR_ISOLATION);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = artpec8_pcie_config_perstn(pci, PCIE_REG_BIT_HIGH);
> > +	if (ret)
> > +		return ret;
> > +
> > +	artpec8_ctrl->phy = devm_of_phy_get(dev, np, NULL);
> > +	if (IS_ERR(artpec8_ctrl->phy))
> > +		return PTR_ERR(artpec8_ctrl->phy);
> > +
> > +	phy_init(artpec8_ctrl->phy);
> > +	phy_reset(artpec8_ctrl->phy);
> > +
> > +	switch (mode) {
> > +	case DW_PCIE_RC_TYPE:
> > +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_RC,
> > +				PCIE_ARTPEC8_DEVICE_TYPE);
> > +		ret = artpec8_add_pcie_port(artpec8_ctrl, pdev);
> > +		if (ret < 0)
> 
> Are there positive return values that indicate success?  Most places
> above you assume "ret != 0" means failure, so just curious why you
> test "ret < 0" instead of just "ret".
> 
> > +			goto fail_probe;
> > +		break;
> > +	case DW_PCIE_EP_TYPE:
> > +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_EP,
> > +				PCIE_ARTPEC8_DEVICE_TYPE);
> > +
> > +		ret = artpec8_add_pcie_ep(artpec8_ctrl, pdev);
> > +		if (ret < 0)
> 
> Same question.
> 
> > +			goto fail_probe;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto fail_probe;
> > +	}
> > +
> > +	return 0;
> > +
> > +fail_probe:
> > +	phy_exit(artpec8_ctrl->phy);
> > +	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
> > +		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __exit artpec8_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct artpec8_pcie *artpec8_ctrl = platform_get_drvdata(pdev);
> > +	const struct artpec8_pcie_pdata *pdata = artpec8_ctrl->pdata;
> > +
> > +	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
> > +		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct artpec8_pcie_pdata artpec8_pcie_rc_pdata = {
> > +	.dwc_ops	= &artpec8_dw_pcie_ops,
> > +	.host_ops	= &artpec8_pcie_host_ops,
> > +	.res_ops	= &artpec8_pcie_rc_res_ops,
> > +	.mode		= DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static const struct artpec8_pcie_pdata artpec8_pcie_ep_pdata = {
> > +	.dwc_ops	= &artpec8_dw_pcie_ops,
> > +	.host_ops	= &artpec8_pcie_host_ops,
> > +	.res_ops	= &artpec8_pcie_ep_res_ops,
> > +	.mode		= DW_PCIE_EP_TYPE,
> > +};
> > +
> > +static const struct of_device_id artpec8_pcie_of_match[] = {
> > +	{
> > +		.compatible = "axis,artpec8-pcie",
> > +		.data = &artpec8_pcie_rc_pdata,
> > +	},
> > +	{
> > +		.compatible = "axis,artpec8-pcie-ep",
> > +		.data = &artpec8_pcie_ep_pdata,
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, artpec8_pcie_of_match);
> > +
> > +static struct platform_driver artpec8_pcie_driver = {
> > +	.probe	= artpec8_pcie_probe,
> > +	.remove		= __exit_p(artpec8_pcie_remove),
> > +	.driver = {
> > +		.name	= "artpec8-pcie",
> > +		.of_match_table = artpec8_pcie_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(artpec8_pcie_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Jaeho Cho <jaeho79.cho@samsung.com>");

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
