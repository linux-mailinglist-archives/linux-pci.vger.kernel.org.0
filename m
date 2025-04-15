Return-Path: <linux-pci+bounces-25910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF683A894C8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844623B6F6C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9319F438;
	Tue, 15 Apr 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrlNFjZ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B11F0E47
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701662; cv=none; b=Aboc47yDUzpCUUvmvgbNvELbFmsvuB3bWecYRHRayZESoL4RrkT27+M9RbYMp6UcyZay63/X+6rjoLr9oF1KzgXiy5ORt/Mhq2EL8MzQn7KJMaOjMnZZIt+rl3l1ZdfGP6/+Xgpk6Qz6Fq0Ce1LVBubYtMjAFnDWmFQhRRqMLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701662; c=relaxed/simple;
	bh=GEfBOA45QlWfcWHD5yzJuDstvply4eSmwqKjrGpmXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnDuonYwzXR2K51EcS7LiTodRtp+3F+DOnRmcaoPz6gX8/qfBx1bDApkQUW/a/IZfGYQsA2TjGd8H+zhkdwbIincMe1yCNNDCt1zcKeyhqUuDpR3oj4aALcO7CrR1Ch9GUNRkQ1zSIaAMoKG8RnJgW1poVKFP+isNoT9aZurpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrlNFjZ9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2295d78b433so54041595ad.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744701660; x=1745306460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XCNk9Rod1k+bgkwurUtIjlivzVvS2RJvCje5WjdRCTk=;
        b=qrlNFjZ9sCrJXI5cTQdCR+/laEgXYSV2r1Oauzx4cOKoNxLJMdG2zoZQRY3WMjlDQ3
         g4b9Br9o2of0QLOj/83VooUXEWSw4C1Bd19kf27waStgRxki4DAS68TJ7qEGpZqbPEBz
         GHloJdpnRVFRhjIkYQyoE+A2zLatJqk4bdrd1i2Z93bosZyc6Cu9RhcsenaW70Zo//oV
         dh9ovl+BxInOQwagNk5bQ5ORACw01eAplZAJ+wIE8ybIGlakUIQTaa37sTwEu3BP49vC
         7mASa1tSyi+mGGRRSVTqriPEJcBX3xJSbYlxthqY2FmVAxb1RdHBdli37bP2NeeGAZDx
         PxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701660; x=1745306460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCNk9Rod1k+bgkwurUtIjlivzVvS2RJvCje5WjdRCTk=;
        b=PZpqzMmFMIt3IKvlezv4IcQwznTSvLMYcxZh/cP+p0S7fS+AaSUP5gxEDoUQwsayyQ
         vi5SPvs++iGoRMQOtJusgZGYU2c5Sd8RCPcW6HyhVTKG193Oqb13kwlndVePNUvMcDsZ
         wKfAFX6XKa4aK/yLVtrwBUjgaNkOBJ6Z07YmB5wgqxz/31LfLBTpt6ywj/VPQod5NwWG
         haZyt7xFRfiv7a3y2bYHE8GVV9DRjQ84tlN6T417ZiDfD39CswRkC6fWZUtd6RX1DJot
         gHFg4owLMaYPsRwM54FDQdeYJoVyJw4+mvVADHlIxQoKphrZaDsj23LRVS2w1JaerRaz
         +HHw==
X-Forwarded-Encrypted: i=1; AJvYcCXYmprb96j2OPSXiEB+/lqSS36fGnk3MjhanYIZRBm1H9fVKtfhhrYwYnM6SSo1GlG21WTpOUx+UQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EPXcUY7we7XOflGMELqKpGCMwEGf3RXMgtg4xux5bDkbzBJ9
	wcV7HO157QdcmCWna040RoQZ3Ae3HgtNGNegjgbW4NCZwBEZyhY3ExlsjqyhWQ==
X-Gm-Gg: ASbGncvbzeKgPGnHCo00iuAunxmIkh5BDT7nOqsCNj8wJVZjc1WPKmS+XSbYWlVRSOj
	1nknv5SlKzaSQ4WXWS23wCXEETAxMI9gqBZmB9cZ04NyBR/po7H1L5SaTIJe8jMUZ5mNdtOoA+q
	m09B4o31OLyE7u7Qfaygc2+S8sf4kNoJO7PLBuUscT8Ip+qqLQe3jgfwOkYbbs2k+zn09DSpKhx
	Hn7L1N+VGCao5NNpXN4mWi45QJM91/bT9+Vwz5XRghD+a6clBFle/ftJJ1r1Meqi+/NbHz9t5VK
	b5zUqzY4DpeuLH/w4Xt1e3U1cnNt3tYYiKgZ2XW46/P9YXw/qNtAaJtdkVkx
X-Google-Smtp-Source: AGHT+IHwx8NytA4HfmHYqY+ucueZxWfnA77QXqfaKsQqKRz4c9hbWsTrqA2PwtFUSZmcoIQDMTuTwQ==
X-Received: by 2002:a17:903:1b6f:b0:224:c47:cb7 with SMTP id d9443c01a7336-22bea3f02aemr222574665ad.0.1744701659806;
        Tue, 15 Apr 2025 00:20:59 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cddfaesm111157005ad.257.2025.04.15.00.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:20:59 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:50:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Message-ID: <3wmkjmutepc2s2ookc3ces4eyxe6morhhwxzlpup4mkkoy5ocx@py6h36upgl75>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-7-hongxing.zhu@nxp.com>
 <uqrhqkmtp4yudmt4ys635vg3gh5sibhevu7gjtbbbizuheuk45@lhxywqhtbpak>
 <AS8PR04MB867619A464E923655EDEF4878CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867619A464E923655EDEF4878CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Apr 14, 2025 at 03:16:46AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2025年4月13日 23:33
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
> > PCIe
> > 
> > On Tue, Apr 08, 2025 at 10:59:29AM +0800, Richard Zhu wrote:
> > > Add PLL clock lock check for i.MX95 PCIe.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 28
> > > +++++++++++++++++++++++++--
> > >  1 file changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 7dcc9d88740d..c1d128ec255d 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -45,6 +45,9 @@
> > >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > >
> > > +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> > > +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
> > > +
> > >  #define IMX95_PCIE_SS_RW_REG_0			0xf0
> > >  #define IMX95_PCIE_REF_CLKEN			BIT(23)
> > >  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> > > @@ -479,6 +482,23 @@ static void
> > imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
> > >  		dev_err(dev, "PCIe PLL lock timeout\n");  }
> > >
> > > +static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie
> > > +*imx_pcie) {
> > > +	u32 val;
> > > +	struct device *dev = imx_pcie->pci->dev;
> > > +
> > > +	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
> > > +				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
> > > +				     val & IMX95_PCIE_PHY_MPLL_STATE,
> > > +				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> > > +				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
> > > +		dev_err(dev, "PCIe PLL lock timeout\n");
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)  {
> > >  	unsigned long phy_rate = 0;
> > > @@ -824,6 +844,8 @@ static int imx95_pcie_core_reset(struct imx_pcie
> > *imx_pcie, bool assert)
> > >  		regmap_read_bypassed(imx_pcie->iomuxc_gpr,
> > IMX95_PCIE_RST_CTRL,
> > >  				     &val);
> > >  		udelay(10);
> > > +	} else {
> > > +		return imx95_pcie_wait_for_phy_pll_lock(imx_pcie);
> > 
> > Is this PLL lock related to COLD_RESET? It doesn't look like it. If unrelated, it
> > should be called wherever required. imx95_pcie_core_reset() is supposed to
> > only assert/deassert the COLD_RESET.
> > 
> > If related, please explain how.
> Thanks for your kindly review.
> To make sure the HW state is correct to continue the sequential initializations.
> The PLL lock or not check would be kicked off after the COLD_RESET is
>  de-asserted for i.MX95 PCIe.
> So, the PLL lock check is added at the end of de-assertion in
>  imx95_pcie_core_reset() function.
> 

But imx95_pcie_core_reset() is not doing anything for deassert other than
waiting for PLL lock. Hence my question.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

