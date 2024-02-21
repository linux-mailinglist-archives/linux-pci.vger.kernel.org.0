Return-Path: <linux-pci+bounces-3806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C988685CFB4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D934FB218AE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659739AFE;
	Wed, 21 Feb 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsG6NBf5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E722F0C
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493708; cv=none; b=IXQstqzJIwwgj9s/hlyjRJeHKhLUPZECslAD2KKanLAj26jGLi79Jub552vnWzaXB1DI5EUBe48ye3HDMU6Uz+RjL/Elp8wIj9ZjjfXl+fermryH+f8wUGTA/btU3qBn0DZfF+fsB3Bl3AWPfytf+mF1QRGpo7tBPqXL7LWJO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493708; c=relaxed/simple;
	bh=r6zgvcn+F+40CdvzpyLEB2jfR6JRjSoUZ4GE4rAhELg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLvItPIk98cxCYkjBNUoGTImnYb5PRPs/tX7J1di07rYbyI7sOz/2bV52UZX4PK5M/gi7HBkmw0MnFxCBv6LaUQ3vl79ILYy468f2696/Ywkg/sx2tl9yyvlGGEJMzv9DRp97BS7bzCyDJlWKe96/vSpAa/Xlog80JAdNJ+uC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsG6NBf5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c0485fc8b8so5040723b6e.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 21:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708493706; x=1709098506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hhr4ArsjVqdB0DiyfSSELvRr7XQBdiTPeH39+KVLxE=;
        b=KsG6NBf589UxeFB0sCZ2G/DtrTLov2xIqmYuvvZJg66wISUJ/lidMqNKDkKcfEoahf
         KSQl6/XIpNJinCDcje82sOMTghZOwHOqiYE3SyRhqae7v6nYaNBonktr+XZu6vbW7ewJ
         +mW5JpIQXs4Ofan8ygt82g4/Z7yoBYfnnfg90taCwdv0HIZ0Zcaoql/Op2MFeAW0p7Vw
         +/+d/L+HYqBoLHaGuxc39EVdqTxYySUKXOANnI1FrUhSmHLLlXAMuzwYueCs9BvybtFG
         aBfgqkhl6cHg2qiy45t5aHGse7GVSxhHbTa0a6RubBH51sSqhuA2soqdjNISvScyg65f
         LyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708493706; x=1709098506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hhr4ArsjVqdB0DiyfSSELvRr7XQBdiTPeH39+KVLxE=;
        b=fmHNFz2IvmovXKzlLooxbo+PNUxxuS99Hs7ezLeDOuV6/TQZ28PAhXqIL9Llhhf22R
         2lwbXfhOURVwFzsWj9iLnzDQl5K1Tx+J4K9wgTOF/qF1kqz6BhN5jQh8bldugVFlixfO
         4nnol19IXy7Ik4WJ1ZhLFQDjbDWKyd8njrDlXSZTR3cFxkH5zRJn6uq7lX0RtvDHMJU9
         86dCAtTKomX5mWWiVRtAfsOZ6gDsCNR64xoyNRofh34ARoB4Bsh2PYcrHO8UjDO87itX
         wQgHnDpNHGPbk0Gc1l8KmT1C5Qa3b7crqOFMLnK0+h+9FrteZj6JqNF4ZFxo7zxRlSvM
         4GQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX481LIq3GaqcQFDZ3syyuNxsy0qyw5DaZXQ//PN0YFQJUV2H4uJikn9Rf3VcFskd0J5lmVqxxkc8fYCiFC/oqSCiAjvOR/gu0I
X-Gm-Message-State: AOJu0YyFE1YLQXZCsba6hmlGxndZf+ySV0V+kCZc6+69XL8C846WZakW
	mjhQeiDS9HUCdxrpTEC0bJ6PlQRK2CdwwDSVYrzxzUbrAk14WkygqiWTtWtvyA==
X-Google-Smtp-Source: AGHT+IHfq+3NGWy3J5i374ZZPFpMwfNrL45PZq0YLZf5MA0T+86521iKgf5TclQFlYXI+9s2KYHMWQ==
X-Received: by 2002:a05:6808:190e:b0:3c0:3ae7:48fa with SMTP id bf14-20020a056808190e00b003c03ae748famr22256951oib.38.1708493706001;
        Tue, 20 Feb 2024 21:35:06 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id fn16-20020a056a002fd000b006e3dfb2ef4esm6481314pfb.95.2024.02.20.21.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:35:05 -0800 (PST)
Date: Wed, 21 Feb 2024 11:04:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <20240221053457.GC11693@thinkpad>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
 <20240216-dw-hdma-v2-1-b42329003f43@linaro.org>
 <70a2f29f-301d-40c6-bc37-abab35286caa@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a2f29f-301d-40c6-bc37-abab35286caa@ti.com>

On Tue, Feb 20, 2024 at 05:41:41PM +0530, Siddharth Vadapalli wrote:
> On 24/02/16 11:04PM, Manivannan Sadhasivam wrote:
> > In order to add support for Hyper DMA (HDMA), let's refactor the existing
> > dw_pcie_edma_find_chip() API by moving the common code to separate
> > functions.
> > 
> > No functional change.
> > 
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++++++++++++++++++-----
> >  1 file changed, 33 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 250cf7f40b85..3a26dfc5368f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
> >  	.irq_vector = dw_pcie_edma_irq_vector,
> >  };
> >  
> > -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> > +{
> > +	pci->edma.dev = pci->dev;
> > +
> > +	if (!pci->edma.ops)
> > +		pci->edma.ops = &dw_pcie_edma_ops;
> > +
> > +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > +}
> > +
> > +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  
> > @@ -902,8 +912,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  
> >  	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> >  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > -
> > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> >  	} else if (val != 0xFFFFFFFF) {
> >  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> 
> Minor suggestion:
> 
> The above section prior to this patch was:
> 	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> 		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> 
> 		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> 	} else if (val != 0xFFFFFFFF) {
> 		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> 
> 		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> 	} else {
> 		return -ENODEV;
> 	}
> 
> And this patch is removing the call to dw_pcie_readl_dma() in the "if"
> condition above. So the curly braces after this patch will only be
> present because of the "else if" statement. So is the following change a
> good idea?
> 

Yes indeed. Actually, EDMA_MF_EDMA_LEGACY is the default mapping format (because
its value is 0x0), but setting it explicitly would also make sense.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

