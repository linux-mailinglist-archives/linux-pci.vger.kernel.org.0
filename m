Return-Path: <linux-pci+bounces-7533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2D8C6D9A
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F84F1F224BD
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2C15B129;
	Wed, 15 May 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvMHmA3T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502315B12F
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807615; cv=none; b=d7shIEIWY6KUETWV9/OJcQZ35xaPyZdC2ezfTbSq8BMGUEUJEAm5BmrmvwwV5dhJUl3+DoBxe3vjjbWqNvhaXn/jqnXTJeJhvA2YZprRuhJ/i1O+V0fz83az5mOVOp7qIi81fRem/nGbrRuPxmk+z5jdv7eOTqe+c2d6MMELgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807615; c=relaxed/simple;
	bh=rFJpsvZLu3B53+hXuHhtpjCVRgoxVKmUMLdtqsNpkeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lrHUsG2mO4aJJv3EbBOVMS9iPYJKNBhHbMeeKAan656743qGfdk1QzFJtWc+eBsMedfH63EQJfXM9wxE4DkBVnR+LhKeGfLAu4ob5NxXUSbwnykeOrW/Kk5GxZDqAyIKhGlxtHNM5Y/CInIuJnjjU47kCatE3X1N6xIwjaueW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvMHmA3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF2EC32782;
	Wed, 15 May 2024 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807615;
	bh=rFJpsvZLu3B53+hXuHhtpjCVRgoxVKmUMLdtqsNpkeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AvMHmA3TotqfOj46mJO2fXlZKTWA0V8T+/CpBsuIoL2fx426qnvSZgBZpvwDNzKL/
	 c8cRvRLBEdk1MVuZRcA7zgwVy0koTHrNwBdJdoS5fapEPpVnCGe80FlLZlc9QqquRE
	 zC8gYufDJ10TX1xM4d+0jADDntgXDUSX4RhvPzRh8csBw3IjediXg3kAE6S/Awyprs
	 c4e9gRm/frv8239dUtUOuWUPRyHJjrA9oD9sRt6qJB5u+8x68HuL8m95nxNQoTKLRU
	 CLAzMmLex4/KH5z0reLLOqX4QCDDv+g7E0HuB/HveTGp9oPWvTw+HYwbYF9JwErCnY
	 N67D33mv2VnXg==
Date: Wed, 15 May 2024 16:13:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lei Chuanhua <lchuanhua@maxlinear.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add error messages in .probe()s
 error paths
Message-ID: <20240515211333.GA2139026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515205735.GA2137771@bhelgaas>

On Wed, May 15, 2024 at 03:57:37PM -0500, Bjorn Helgaas wrote:
> On Tue, Feb 27, 2024 at 03:12:54PM +0100, Uwe Kleine-König wrote:
> > Drivers that silently fail to probe provide a bad user experience and
> > make it unnecessarily hard to debug such a failure. Fix it by using
> > dev_err_probe() instead of a plain return.
> > 
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
> 
> Krzysztof applied this to pci/controller/rockchip with Reviewed-by
> from Jesper and Mani, but his outgoing mail queue got stuck.  Trying
> to squeeze into v6.9.

Sorry, v6.10.  v6.9 is already done, obviously.

> > ---
> > Hello,
> > 
> > changes since (implicit) v1, sent with Message-Id:
> > 20240227111837.395422-2-ukleinek@debian.org:
> > 
> >  - use dev instead of rockchip->pci.dev as noticed by Serge Semin.
> >  - added Reviewed-by: tag for Heiko. I assume he agrees to above
> >    improvement and adding the tag despite the change is fine.
> > 
> > Best regards
> > Uwe
> > 
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index d6842141d384..a13ca83ce260 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -225,11 +225,15 @@ static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> >  
> >  	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
> >  	if (ret < 0)
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> >  
> >  	rockchip->clk_cnt = ret;
> >  
> > -	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> > +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> > +
> > +	return 0;
> >  }
> >  
> >  static int rockchip_pcie_resource_get(struct platform_device *pdev,
> > @@ -237,12 +241,14 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> >  {
> >  	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> >  	if (IS_ERR(rockchip->apb_base))
> > -		return PTR_ERR(rockchip->apb_base);
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->apb_base),
> > +				     "failed to map apb registers\n");
> >  
> >  	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> >  						     GPIOD_OUT_HIGH);
> >  	if (IS_ERR(rockchip->rst_gpio))
> > -		return PTR_ERR(rockchip->rst_gpio);
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst_gpio),
> > +				     "failed to get reset gpio\n");
> >  
> >  	rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
> >  	if (IS_ERR(rockchip->rst))
> > @@ -320,10 +326,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >  		rockchip->vpcie3v3 = NULL;
> >  	} else {
> >  		ret = regulator_enable(rockchip->vpcie3v3);
> > -		if (ret) {
> > -			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> > -			return ret;
> > -		}
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "failed to enable vpcie3v3 regulator\n");
> >  	}
> >  
> >  	ret = rockchip_pcie_phy_init(rockchip);
> > 
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

