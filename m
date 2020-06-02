Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C561EC08B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBQ6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBQ6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 12:58:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2639C05BD1E;
        Tue,  2 Jun 2020 09:58:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so1574567plo.7;
        Tue, 02 Jun 2020 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LIjfTJ4DdiiIcLP5CjE0lWVk9AhFk6AUOUnkDHt+370=;
        b=AeTRhTpSm3aw7y/d345Qq0V06bM1nHRj1nf4vTaRD8uBYXrXLS94pJpTuYduKVaF7C
         +W3VwRQeQ4ZhSAuXcmYeieLakcF/I2nvcTHNQ1FLZb6nVLXF5UHV1khxfBPPWNQldx5x
         Sbv81T9Czd962sohpoo3tvrX6dDRFskcRf9f2bG7CSwBqL6E5y4mPfWlB9uJdfQUBTh1
         ao0klsRuinJjsXRHqZne/PNq5XG546U65XYuIb3vkGLAz3Orh3EJiPlO6qKHvo4SP/2q
         sc3zBZ++bSrip5ufzP+i/i8n1fKFNEqPR9kTA3kU8Ceo6vyM14pfh4Kg2JQD59lugBya
         wl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIjfTJ4DdiiIcLP5CjE0lWVk9AhFk6AUOUnkDHt+370=;
        b=SWjvy+x14x+kBeiL7ErjpxVOFWX2VqG7u4CY9Q8ZE0wKC2wWymSTdUPyxZCurfwYgK
         A7ZdP46YL51kbu9up6sJXan7VhhYVuoecpjKAUIboRkEAMa9LAxwQWiqM5HjJQ5ZL2IP
         L+WAzC+ObAKpzAwOjb0ucwL36NHrsrpYGtsxMPUWaK9g+Ny68lphEcLTW6WQMG3x6VOA
         oDuZh12dqyanDyrYqNCp/NCtRGIsAPQQzieDfUiGfniJWhRbaiiKxynzB+wLohU8yEvP
         Ly2OWZOLF9nNxSbESPwPxvCH9KNv9vq9RscR+2LV0K3gYh7gyxAsWyxOiel7rpD9T/4i
         AwRA==
X-Gm-Message-State: AOAM5338kQ6K1BOHoEhKmOT8VXJamzP8HbolTGDVESbvG2qEXgJJzUDB
        oowfpvPd0B5lu34sdzU1nEw=
X-Google-Smtp-Source: ABdhPJzE+ZRVE+vWcGRIAamdV5nVx0mRpuM1p+EliwYXz+L/Cg6i9i/7PjnlvMzMsXNIu5PQAKVQpQ==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr15877182plr.285.1591117097444;
        Tue, 02 Jun 2020 09:58:17 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id a12sm2521202pjw.35.2020.06.02.09.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 09:58:16 -0700 (PDT)
Date:   Wed, 3 Jun 2020 00:58:09 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: controller: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <20200602165809.GA7011@nuc8i5>
References: <20200601143345.24965-1-zhengdejin5@gmail.com>
 <20200601222229.GA1613213@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601222229.GA1613213@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 01, 2020 at 04:22:29PM -0600, Rob Herring wrote:
> On Mon, Jun 01, 2020 at 10:33:45PM +0800, Dejin Zheng wrote:
> > Use devm_platform_ioremap_resource_byname() to simplify codes.
> > it contains platform_get_resource_byname() and devm_ioremap_resource().
> > 
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 3 +--
> >  drivers/pci/controller/cadence/pcie-cadence-host.c | 3 +--
> >  drivers/pci/controller/pci-tegra.c                 | 8 +++-----
> >  drivers/pci/controller/pci-xgene.c                 | 3 +--
> >  drivers/pci/controller/pcie-altera-msi.c           | 3 +--
> >  drivers/pci/controller/pcie-altera.c               | 9 +++------
> >  drivers/pci/controller/pcie-mediatek.c             | 4 +---
> >  drivers/pci/controller/pcie-rockchip.c             | 5 ++---
> >  drivers/pci/controller/pcie-xilinx-nwl.c           | 7 +++----
> >  9 files changed, 16 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index 1c15c8352125..74ffa03fde5f 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -408,8 +408,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
> >  
> >  	pcie->is_rc = false;
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> > -	pcie->reg_base = devm_ioremap_resource(dev, res);
> > +	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
> >  	if (IS_ERR(pcie->reg_base)) {
> >  		dev_err(dev, "missing \"reg\"\n");
> >  		return PTR_ERR(pcie->reg_base);
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index 8c2543f28ba0..dcc460a54875 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -225,8 +225,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >  	rc->device_id = 0xffff;
> >  	of_property_read_u32(np, "device-id", &rc->device_id);
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> > -	pcie->reg_base = devm_ioremap_resource(dev, res);
> > +	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
> >  	if (IS_ERR(pcie->reg_base)) {
> >  		dev_err(dev, "missing \"reg\"\n");
> >  		return PTR_ERR(pcie->reg_base);
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index e3e917243e10..3e608383df66 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -1462,7 +1462,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
> >  {
> >  	struct device *dev = pcie->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> > -	struct resource *pads, *afi, *res;
> > +	struct resource *res;
> >  	const struct tegra_pcie_soc *soc = pcie->soc;
> >  	int err;
> >  
> > @@ -1486,15 +1486,13 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
> >  		}
> >  	}
> >  
> > -	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
> > -	pcie->pads = devm_ioremap_resource(dev, pads);
> > +	pcie->pads = devm_platform_ioremap_resource_byname(pdev, "pads");
> >  	if (IS_ERR(pcie->pads)) {
> >  		err = PTR_ERR(pcie->pads);
> >  		goto phys_put;
> >  	}
> >  
> > -	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
> > -	pcie->afi = devm_ioremap_resource(dev, afi);
> > +	pcie->afi = devm_platform_ioremap_resource_byname(pdev, "afi");
> >  	if (IS_ERR(pcie->afi)) {
> >  		err = PTR_ERR(pcie->afi);
> >  		goto phys_put;
> > diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> > index d1efa8ffbae1..1431a18eb02c 100644
> > --- a/drivers/pci/controller/pci-xgene.c
> > +++ b/drivers/pci/controller/pci-xgene.c
> > @@ -355,8 +355,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
> >  	if (IS_ERR(port->csr_base))
> >  		return PTR_ERR(port->csr_base);
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > -	port->cfg_base = devm_ioremap_resource(dev, res);
> > +	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> >  	if (IS_ERR(port->cfg_base))
> >  		return PTR_ERR(port->cfg_base);
> >  	port->cfg_addr = res->start;
> > diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> > index 16d938920ca5..613e19af71bd 100644
> > --- a/drivers/pci/controller/pcie-altera-msi.c
> > +++ b/drivers/pci/controller/pcie-altera-msi.c
> > @@ -228,8 +228,7 @@ static int altera_msi_probe(struct platform_device *pdev)
> >  	mutex_init(&msi->lock);
> >  	msi->pdev = pdev;
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
> > -	msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
> > +	msi->csr_base = devm_platform_ioremap_resource_byname(pdev, "csr");
> >  	if (IS_ERR(msi->csr_base)) {
> >  		dev_err(&pdev->dev, "failed to map csr memory\n");
> >  		return PTR_ERR(msi->csr_base);
> > diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> > index 24cb1c331058..7200e40ffa26 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -696,17 +696,14 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
> >  {
> >  	struct device *dev = &pcie->pdev->dev;
> >  	struct platform_device *pdev = pcie->pdev;
> > -	struct resource *cra;
> > -	struct resource *hip;
> >  
> > -	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
> > -	pcie->cra_base = devm_ioremap_resource(dev, cra);
> > +	pcie->cra_base = devm_platform_ioremap_resource_byname(pdev, "Cra");
> >  	if (IS_ERR(pcie->cra_base))
> >  		return PTR_ERR(pcie->cra_base);
> >  
> >  	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
> > -		hip = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Hip");
> > -		pcie->hip_base = devm_ioremap_resource(&pdev->dev, hip);
> > +		pcie->hip_base =
> > +			devm_platform_ioremap_resource_byname(pdev, "Hip");
> >  		if (IS_ERR(pcie->hip_base))
> >  			return PTR_ERR(pcie->hip_base);
> >  	}
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index ebfa7d5a4e2d..d8e38276dbe3 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -905,7 +905,6 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
> >  			       int slot)
> >  {
> >  	struct mtk_pcie_port *port;
> > -	struct resource *regs;
> >  	struct device *dev = pcie->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	char name[10];
> > @@ -916,8 +915,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
> >  		return -ENOMEM;
> >  
> >  	snprintf(name, sizeof(name), "port%d", slot);
> > -	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > -	port->base = devm_ioremap_resource(dev, regs);
> > +	port->base = devm_platform_ioremap_resource_byname(pdev, name);
> >  	if (IS_ERR(port->base)) {
> >  		dev_err(dev, "failed to map port%d base\n", slot);
> >  		return PTR_ERR(port->base);
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index c53d1322a3d6..904dec0d3a88 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -45,9 +45,8 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >  			return -EINVAL;
> >  	}
> >  
> > -	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > -					    "apb-base");
> > -	rockchip->apb_base = devm_ioremap_resource(dev, regs);
> > +	rockchip->apb_base =
> > +		devm_platform_ioremap_resource_byname(pdev, "apb-base");
> >  	if (IS_ERR(rockchip->apb_base))
> >  		return PTR_ERR(rockchip->apb_base);
> >  
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 9bd1427f2fd6..06d5ca33d008 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -777,14 +777,13 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
> >  	struct device *dev = pcie->dev;
> >  	struct resource *res;
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
> > -	pcie->breg_base = devm_ioremap_resource(dev, res);
> > +	pcie->breg_base = devm_platform_ioremap_resource_byname(pdev, "breg");
> >  	if (IS_ERR(pcie->breg_base))
> >  		return PTR_ERR(pcie->breg_base);
> >  	pcie->phys_breg_base = res->start;
> >  
> > -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcireg");
> > -	pcie->pcireg_base = devm_ioremap_resource(dev, res);
> > +	pcie->pcireg_base =
> > +		devm_platform_ioremap_resource_byname(pdev, "pcireg");
> >  	if (IS_ERR(pcie->pcireg_base))
> >  		return PTR_ERR(pcie->pcireg_base);
> >  	pcie->phys_pcie_reg_base = res->start;
> 
> As 0-day pointed out, this hunk should be dropped as the phys address is 
> needed.
>
Rob, You are right, Sincerely thank you for helping me! I will sent the
patch v2.

BR,
Dejin
> Rob
