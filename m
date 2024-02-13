Return-Path: <linux-pci+bounces-3405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC948535DD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386A2287EF5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE35F85B;
	Tue, 13 Feb 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFcgPe9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD955F856;
	Tue, 13 Feb 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841218; cv=none; b=WHA9qVPuS4pG/LHgOvjNaKB1MzQ9ndVPtxGI3u4v0WrFZ/fEBB8o1L3icKY5IKvUM2fr6iu85Ybw4OQnKhYQPB0/gGSyG+svoCBqWJl7i5j2BxuGl2AqTR7qdHPw7ixuIjqqYTcGhS96Nd6Pii/bj75ZNLdH5UOcJZfv0z1RSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841218; c=relaxed/simple;
	bh=c8A66FpezMmJ/dIlhwWg0VG1aAG6UpKigFfPKlDGS6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkOt9oht4fqU9l33O0RrPihnPQjp0ryUvgtB2RS5q/zx5eHbQax86x2dwteejM6Tk/vu9KTTocsRsqnvg1mkm13IQVWzlI2q6JdqzgYG8XaJUnQD6G0bniWGffZRnMhI+JffXha7wbhju4DZLvdX156dm6clv+mm0AmK3Phfi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFcgPe9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6006C433C7;
	Tue, 13 Feb 2024 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841218;
	bh=c8A66FpezMmJ/dIlhwWg0VG1aAG6UpKigFfPKlDGS6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFcgPe9mFGBX700RPmtjmMA1SehN74aLXr+Jtdc0Q4E1QQPPDPbHtLsxQF0M1bHeP
	 NIIUkf3LedjxF9gYWsPtxR4aX8AWINgXApg20e0kBx9qxEUtb7aZog23dZS7Brg8+r
	 Q3h9QluUOCW0yfJHUxgW/3uclWCGW6/7l9Gr3q3QbgvUyK++GSpwS+RPbaqPsHjhVi
	 b/V641B9fr/YGGL+2g/HAHAblvzIdGJzfmkwPU0Wk5ozeCTkT9zne8bBfDMbT6EsDJ
	 S1IvnxigBIOBc8ue8AgVkcKLZyS1YOCYPiSU+D/PLsqJgli7paA2deUIWxpdrhZaQB
	 d+ej/vwZpve1g==
Date: Tue, 13 Feb 2024 17:20:10 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 01/14] PCI: imx6: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <ZcuWuntrvlkvOVrZ@lpieralisi>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <20240205173335.1120469-2-Frank.Li@nxp.com>
 <ZcuLSkvPuyMXsQeD@lpieralisi>
 <ZcuRiQ0brp2SfmNU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuRiQ0brp2SfmNU@lizhi-Precision-Tower-5810>

On Tue, Feb 13, 2024 at 10:58:01AM -0500, Frank Li wrote:
> On Tue, Feb 13, 2024 at 04:31:22PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Feb 05, 2024 at 12:33:22PM -0500, Frank Li wrote:
> > > Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
> > > clk_bulk*() api simplify the code.
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v9 to v10
> > >     - fixed missed delete a case, which need failthrough to next one.
> > >     Change from v8 to v9
> > >     - change clks names
> > >     - Add Manivannan's review tag
> > >     
> > >     Change from v7 to v8
> > >     - update comment message
> > >     - using ARRAY_SIZE to count clk_names.
> > >     Change from v6 to v7
> > >     - none
> > >     Change from v4 to v5
> > >     - update commit message
> > >     - direct using clk name list, instead of macro
> > >     - still keep caculate clk list count because sizeof return pre allocated
> > >     array size.
> > >     
> > >     Change from v3 to v4
> > >     - using clk_bulk_*() API
> > >     Change from v1 to v3
> > >     - none
> > >     
> > >     Change from v4 to v5
> > >     - update commit message
> > >     - direct using clk name list, instead of macro
> > >     - still keep caculate clk list count because sizeof return pre allocated
> > >     array size.
> > >     
> > >     Change from v3 to v4
> > >     - using clk_bulk_*() API
> > >     Change from v1 to v3
> > >     - none
> > >     
> > >     Change from v8 to v9
> > >     - change clks names
> > >     - Add Manivannan's review tag
> > >     
> > >     Change from v7 to v8
> > >     - update comment message
> > >     - using ARRAY_SIZE to count clk_names.
> > >     Change from v6 to v7
> > >     - none
> > >     Change from v4 to v5
> > >     - update commit message
> > >     - direct using clk name list, instead of macro
> > >     - still keep caculate clk list count because sizeof return pre allocated
> > >     array size.
> > >     
> > >     Change from v3 to v4
> > >     - using clk_bulk_*() API
> > >     Change from v1 to v3
> > >     - none
> > >     
> > >     Change from v4 to v5
> > >     - update commit message
> > >     - direct using clk name list, instead of macro
> > >     - still keep caculate clk list count because sizeof return pre allocated
> > >     array size.
> > >     
> > >     Change from v3 to v4
> > >     - using clk_bulk_*() API
> > >     Change from v1 to v3
> > >     - none
> > > 
> > >  drivers/pci/controller/dwc/pci-imx6.c | 138 ++++++++++----------------
> > >  1 file changed, 50 insertions(+), 88 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 74703362aeec7..82854e94c5621 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -61,12 +61,16 @@ enum imx6_pcie_variants {
> > >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> > >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > >  
> > > +#define IMX6_PCIE_MAX_CLKS       6
> > > +
> > >  struct imx6_pcie_drvdata {
> > >  	enum imx6_pcie_variants variant;
> > >  	enum dw_pcie_device_mode mode;
> > >  	u32 flags;
> > >  	int dbi_length;
> > >  	const char *gpr;
> > > +	const char * const *clk_names;
> > > +	const u32 clks_cnt;
> > >  };
> > >  
> > >  struct imx6_pcie {
> > > @@ -74,11 +78,7 @@ struct imx6_pcie {
> > >  	int			reset_gpio;
> > >  	bool			gpio_active_high;
> > >  	bool			link_is_up;
> > > -	struct clk		*pcie_bus;
> > > -	struct clk		*pcie_phy;
> > > -	struct clk		*pcie_inbound_axi;
> > > -	struct clk		*pcie;
> > > -	struct clk		*pcie_aux;
> > > +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> > 
> > Why can't you allocate this dynamically ?
> 
> Engineer choose. clk_bulk_data is small data struct, two pointers (16byte
> in 64bit system). clks in imx is 3-4, Over half already used(compared 6).
> waste case only wast 48byte.
>  
> Dynamically allocate can't save much memory, there are some extra manage
> meta data for dynamical memory, which may bigger than 48byte.
> 
> Frank
> 
> > 
> > >  	struct regmap		*iomuxc_gpr;
> > >  	u16			msi_ctrl;
> > >  	u32			controller_id;
> > > @@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> > >  
> > >  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
> > >  {
> > > -	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> > > +	unsigned long phy_rate = 0;
> > >  	int mult, div;
> > >  	u16 val;
> > > +	int i;
> > >  
> > >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> > >  		return 0;
> > >  
> > > +	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
> > > +		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
> > > +			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
> > > +
> > >  	switch (phy_rate) {
> > >  	case 125000000:
> > >  		/*
> > > @@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
> > >  
> > >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >  {
> > > -	struct dw_pcie *pci = imx6_pcie->pci;
> > > -	struct device *dev = pci->dev;
> > >  	unsigned int offset;
> > >  	int ret = 0;
> > >  
> > >  	switch (imx6_pcie->drvdata->variant) {
> > >  	case IMX6SX:
> > > -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > > -		if (ret) {
> > > -			dev_err(dev, "unable to enable pcie_axi clock\n");
> > > -			break;
> > > -		}
> > > -
> > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> > >  		break;
> > > @@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >  	case IMX8MQ_EP:
> > >  	case IMX8MP:
> > >  	case IMX8MP_EP:
> > > -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > > -		if (ret) {
> > > -			dev_err(dev, "unable to enable pcie_aux clock\n");
> > > -			break;
> > > -		}
> > > -
> > >  		offset = imx6_pcie_grp_offset(imx6_pcie);
> > >  		/*
> > >  		 * Set the over ride low and enabled
> > > @@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >  {
> > >  	switch (imx6_pcie->drvdata->variant) {
> > > -	case IMX6SX:
> > > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > -		break;
> > >  	case IMX6QP:
> > >  	case IMX6Q:
> > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > @@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > >  		break;
> > > -	case IMX8MM:
> > > -	case IMX8MM_EP:
> > > -	case IMX8MQ:
> > > -	case IMX8MQ_EP:
> > > -	case IMX8MP:
> > > -	case IMX8MP_EP:
> > > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > > -		break;
> > >  	default:
> > >  		break;
> > >  	}
> > > @@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> > >  	struct device *dev = pci->dev;
> > >  	int ret;
> > >  
> > > -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> > > -	if (ret) {
> > > -		dev_err(dev, "unable to enable pcie_phy clock\n");
> > > +	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> > > +	if (ret)
> > >  		return ret;
> > > -	}
> > > -
> > > -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> > > -	if (ret) {
> > > -		dev_err(dev, "unable to enable pcie_bus clock\n");
> > > -		goto err_pcie_bus;
> > > -	}
> > > -
> > > -	ret = clk_prepare_enable(imx6_pcie->pcie);
> > > -	if (ret) {
> > > -		dev_err(dev, "unable to enable pcie clock\n");
> > > -		goto err_pcie;
> > > -	}
> > >  
> > >  	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> > >  	if (ret) {
> > > @@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> > >  	return 0;
> > >  
> > >  err_ref_clk:
> > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > -err_pcie:
> > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > -err_pcie_bus:
> > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> > >  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> > >  {
> > >  	imx6_pcie_disable_ref_clk(imx6_pcie);
> > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> > >  }
> > >  
> > >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > > @@ -1252,6 +1212,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  	struct device_node *node = dev->of_node;
> > >  	int ret;
> > >  	u16 val;
> > > +	int i;
> > >  
> > >  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> > >  	if (!imx6_pcie)
> > > @@ -1305,32 +1266,20 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  		return imx6_pcie->reset_gpio;
> > >  	}
> > >  
> > > -	/* Fetch clocks */
> > > -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> > > -	if (IS_ERR(imx6_pcie->pcie_bus))
> > > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> > > -				     "pcie_bus clock source missing or invalid\n");
> > > +	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
> > > +		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
> > 
> > Same question as above, this should not fail if the clks array is
> > dynamically allocated according to imx6_pcie->drvdata->clks_cnt.
> 
> Devm_kzalloc also may return NULL. Still need check. This safe check only
> meanful when add new platform. imx6_pcie->drvdata->clks_cnt is static data.
> 
> It should never failure at running time. But, devm_kzalloc may failure
> at run time.
> 
> It is not big deal. It's most likely personal tast. For small static data,
> I perfer use static memory.

It is fine to keep the static data (but meanful, tast and perfer aren't
English words, a spell checker would fix them, if I may suggest).

Thanks,
Lorenzo

