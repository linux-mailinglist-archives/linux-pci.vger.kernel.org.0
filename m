Return-Path: <linux-pci+bounces-23441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D32A5C905
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B7F18841FA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2819125F782;
	Tue, 11 Mar 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0yA/FyC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77C25EFBA;
	Tue, 11 Mar 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708495; cv=none; b=vE9YzfdIX7VJLlmaMFZn4d158bMQ2nipx/kLaAwJ+FB+hCA/VD8Vl7Xauu+fqj1EL1En+vG8DNehnC6Jnuj92xS2sICuVcTp/s/KWTcmf55LiLIHamGOAaDSJKcMD+qm26Ue+OGcwPCL53qgOhRUFgu03x2hISVcojYyo/2fsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708495; c=relaxed/simple;
	bh=59F6J7gJoDFQunyroBn4G1SonEz9fZYnbkG7e7m9IQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=msejliKcXOnf1m/3JbVP+9aQxg9HqYCmYL3oAgHtHT/ZAWIg0CQOYsIKBGeT/oTnS30BgxwqGj+uR6BIrnttsjNaU5FZ96P3dmqzkYD9fliW/pdImJyTwm+v5mCPSOE4tt+sXxc5R+rTWG8J24h6A2FHaZZfa082huFAHibD8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0yA/FyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B81C4CEE9;
	Tue, 11 Mar 2025 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708494;
	bh=59F6J7gJoDFQunyroBn4G1SonEz9fZYnbkG7e7m9IQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t0yA/FyC7lczjY8YSNzsRaULUN+PBIZd2eGD73GoaovsruwvmZ8igVjOGsovn/t8c
	 2sFn8Vsmrd8uRE8LRmyBN+rIVHYAliR4OpPBIljRCC5KBTV3v8saF9DyI73ZsME04h
	 bbEznsUiUuxYBqW1U43M/5D29DCmk85we3nYORuXfYmR9iF3V+98GVPAefwbQ8xRsJ
	 5/9a9x3lUgVWq0ZkFxcO64LY4HTab44jiE5/PgSzK20DMdQfxrG8x+wgMlZNNF3jKC
	 ay84W9nFwOV/CHw2DfQrlBUwsJuPtyFK36F7WZ7afC8DhVt7EH4e21gmnV8CLKd/Kk
	 w2rnsiYaUEWzQ==
Date: Tue, 11 Mar 2025 10:54:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <20250311155452.GA629749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676E66BD40C37B2A7E390178CD12@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2025年3月10日 23:11
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.de;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
> > hardcodes
> > 
> > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > Use the domain number replace the hardcodes to uniquely identify
> > > different controller on i.MX8MQ platforms. No function changes.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 90ace941090f..ab9ebb783593 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -41,7 +41,6 @@
> > >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > >
> > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct platform_device
> > *pdev)
> > >  	struct dw_pcie *pci;
> > >  	struct imx_pcie *imx_pcie;
> > >  	struct device_node *np;
> > > -	struct resource *dbi_base;
> > >  	struct device_node *node = dev->of_node;
> > >  	int i, ret, req_cnt;
> > >  	u16 val;
> > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > platform_device *pdev)
> > >  			return PTR_ERR(imx_pcie->phy_base);
> > >  	}
> > >
> > > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0,
> > &dbi_base);
> > > -	if (IS_ERR(pci->dbi_base))
> > > -		return PTR_ERR(pci->dbi_base);
> > 
> > This makes me wonder.
> > 
> > IIUC this means that previously we set controller_id to 1 if the first item in
> > devicetree "reg" was 0x33c00000, and now we will set controller_id to 1 if
> > the devicetree "linux,pci-domain" property is 1.
> > This is good, but I think this new dependency on the correct
> > "linux,pci-domain" in devicetree should be mentioned in the commit log.
> > 
> > My bigger worry is that we no longer set pci->dbi_base at all.  I see that the
> > only use of pci->dbi_base in pci-imx6.c was to determine the controller_id,
> > but this is a DWC-based driver, and the DWC core certainly uses
> > pci->dbi_base.  Are we sure that none of those DWC core paths are
> > important to pci-imx6.c?
> Hi Bjorn:
> Thanks for your concerns.
> Don't worry about the assignment of pci->dbi_base.
> If pci-imx6.c driver doesn't set it. DWC core driver would set it when
>  dw_pcie_get_resources() is invoked.

Great, thanks!  Maybe we can amend the commit log to mention that and
the new "linux,pci-domain" dependency.

