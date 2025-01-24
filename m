Return-Path: <linux-pci+bounces-20317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407CA1B13E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7C3AA812
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462631D9A7E;
	Fri, 24 Jan 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN59NOOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E21D47D9;
	Fri, 24 Jan 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705698; cv=none; b=KSf96ybGSAESsdrq/4J2qtuHDjO/ueh4JqFMtQ8JPjcDYX/jVxyD8portW1jAWG3Cb6YJX3KgyAAOk2NKIJCbBxVL+nttz6Nes2qAVuTeN1F2XTzXAzespCAFMCBXN439ZAFIv+7MKi+Zh9Umqh+RAFDus6Nrj8SR9QLtaUroPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705698; c=relaxed/simple;
	bh=joUEBABW0jh1/uqANjFESSNnUumv3QKlUTXLI8vc1qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiysaUC/NogMyPkm20nQ4ZyzQPbr8uOWvRB6UUVeI2kuN7uO8SJjnxVVVBwd4ECLL8Ja5XDNojTnjjzdjJ64Gc0DHD4YB4fyvrH6AwjSFIOANKZwH1defA25HCrHM7H/Zvj+MrOtzJ5epKl75ijDu56xFRowUnu+GfHnY2euaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN59NOOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DD8C4CED2;
	Fri, 24 Jan 2025 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737705697;
	bh=joUEBABW0jh1/uqANjFESSNnUumv3QKlUTXLI8vc1qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN59NOOXciYhfWmlc/4PrRP4MSd7jkI6ZwMVgyEWmmI0TI7Eyc84/kVEV8ct2QZ6V
	 qgcD+xHSXg/yuWYjAoSiQQVVeHHErHyNqLcLhEQ8Yy2E5qlU5WJ0LIAY8v0Mu8xrQP
	 1zm/nIRwIUmTcMTb9T30WvTHS8lCyltaB8B06CmH1elnhMGtF6kGQqcKyXggO7ke+8
	 2X47Z+rQ6CB2K1PjIIOzqAB59Ko75lEK24eGheptJAZyRaWIiApVGTOW1+vET7jQkp
	 uViBdS3hNs5RhtDcyKKyXKCa/XZ3LMjRpCweR+/hUrFN5uU/pOZki4Xi7rZt9ZXQkr
	 QBf7DJ/cS4UVQ==
Date: Fri, 24 Jan 2025 13:31:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Message-ID: <20250124080126.itc6qoutn65isnej@thinkpad>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20241126075702.4099164-3-hongxing.zhu@nxp.com>
 <20250119070246.yfxogn4vv3jqfvzb@thinkpad>
 <AS8PR04MB86762EA8219F8FE76CB48F358CE72@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86762EA8219F8FE76CB48F358CE72@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Jan 20, 2025 at 02:49:09AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2025年1月19日 15:03
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>; s.hauer@pengutronix.de;
> > festevam@gmail.com; imx@lists.linux.dev; kernel@pengutronix.de;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
> > 
> > On Tue, Nov 26, 2024 at 03:56:54PM +0800, Richard Zhu wrote:
> > > Add "ref" clock to enable reference clock. To avoid breaking DT
> > > backwards compatibility, i.MX95 REF clock might be optional. Use
> > > devm_clk_get_optional() to fetch i.MX95 PCIe optional clocks in driver.
> > >
> > > If use external clock, ref clock should point to external reference.
> > >
> > > If use internal clock, CREF_EN in LAST_TO_REG controls reference
> > > output, which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 385f6323e3ca..f7e928e0a018 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
> > >  	const char *gpr;
> > >  	const char * const *clk_names;
> > >  	const u32 clks_cnt;
> > > +	const u32 clks_optional_cnt;
> > >  	const u32 ltssm_off;
> > >  	const u32 ltssm_mask;
> > >  	const u32 mode_off[IMX_PCIE_MAX_INSTANCES]; @@ -1306,9 +1307,8
> > @@
> > > static int imx_pcie_probe(struct platform_device *pdev)
> > >  	struct device_node *np;
> > >  	struct resource *dbi_base;
> > >  	struct device_node *node = dev->of_node;
> > > -	int ret;
> > > +	int i, ret, req_cnt;
> > >  	u16 val;
> > > -	int i;
> > >
> > >  	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
> > >  	if (!imx_pcie)
> > > @@ -1358,9 +1358,13 @@ static int imx_pcie_probe(struct platform_device
> > *pdev)
> > >  		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
> > >
> > >  	/* Fetch clocks */
> > > -	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
> > > +	req_cnt = imx_pcie->drvdata->clks_cnt -
> > imx_pcie->drvdata->clks_optional_cnt;
> > > +	ret = devm_clk_bulk_get(dev, req_cnt, imx_pcie->clks);
> > >  	if (ret)
> > >  		return ret;
> > > +	imx_pcie->clks[req_cnt].clk = devm_clk_get_optional(dev, "ref");
> > > +	if (IS_ERR(imx_pcie->clks[req_cnt].clk))
> > > +		return PTR_ERR(imx_pcie->clks[req_cnt].clk);
> > 
> > I think you should just switch to devm_clk_bulk_get_all() instead of getting the
> > clks separately. As I told previously, the DT binding should ensure that correct
> > clocks for the platforms are defined in DT and the driver has no business in
> > validating it. Driver should trust the DT instead (unless there is a valid reason to not
> > do so).
> > 
> > >
> > >  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
> > >  		imx_pcie->phy = devm_phy_get(dev, "pcie-phy"); @@ -1509,6 +1513,7
> > > @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie",
> > > "pcie_aux"};  static const char * const imx8mq_clks[] = {"pcie_bus",
> > > "pcie", "pcie_phy", "pcie_aux"};  static const char * const
> > > imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
> > > static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
> > > +static const char * const imx95_clks[] = {"pcie_bus", "pcie",
> > > +"pcie_phy", "pcie_aux", "ref"};
> > 
> > And these static clock defines will go away too.
> > 
> Hi Mani:
> Thanks for your comments.
> The suggestions are very nice. How about kick off further optimization later?

Sure. This series got merged already.

>  Since the changes would impact all i.MX PCIes.
> Meanwhile, I'm a little worry about that there is no consensus yet on relying
>  entirely on the dt binding check.

Consensus between whom?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

