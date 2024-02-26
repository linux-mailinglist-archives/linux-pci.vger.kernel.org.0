Return-Path: <linux-pci+bounces-4021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B1867A4F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9D91F21D90
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5712B153;
	Mon, 26 Feb 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mu6GM4X1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39412B17B
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961423; cv=none; b=YkFq//IM6CDjvOlOndB0OzVI6jW/HbNqwY3BOmzQ5wSWJcW6BMuumSj4wAVppDLFIegC9HH4imDj5IwG7R9eQoquqz4d+K7nS9TxK3O4HWX0rcGsQsOLcB4Eud7rQ8gnzbJbuE54f7DJMQnfesw/enIPsb8Tm/d3ZESQ4zB9Jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961423; c=relaxed/simple;
	bh=oFEMIGef+CE6PLlxuRtHfu5D8EheQ9NXKbB1G1jvTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrIt/6gKE9qsqiv7DmlKfX+l0EF0KHQswHJFW3YBDWyT3vnaDp4+fyA516U1TO+ZdvM6QmPTfn1mkL8SFxWllCUMOVZIxyxenAbh9CCggtM5E76yyFDeRMOdhOquL8vx8RbeWSukHZIFguQgIdrMBXC+va5/2D6XohSyv3L687s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mu6GM4X1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dc20645871so1978844a12.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708961421; x=1709566221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nloYymieV56TsCLMArqRtZpx2dEpi1P4zJgPvO3bsZI=;
        b=mu6GM4X1ElC67/WHVxsbz5/5JIgj1REJVMMVrYfxfCKMfhVsNbJmxJHNExz+nXy1C7
         ipFGBGYe5bVP7wVd9BSpU9XnQYuxysGIo9laAUGCDtLHX66wPGlocI321U+U6dlX5now
         +jS1MbQBINv1hMoE/e2InsVKEvrYVq2yjbpGiul4qVIbSK2cA6XfMC7GQs0KZezhwGI+
         5GWIvQivVO/OYUY0Z/VIlcwUPxz09AxIgEhlP1eSuPFxcAHCqAK49aWh9wWppDf6hEpg
         QzspzcFkECpnbAx2TxANzWi28B/8u44xGYLcP3u2fCvP1sJn+hTtey8f+wvFnQbCfEEn
         X3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961421; x=1709566221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nloYymieV56TsCLMArqRtZpx2dEpi1P4zJgPvO3bsZI=;
        b=CEnUd+dnQ0UY7wEzgd1zWemsLUjQwMiG091NAIboqsMqDSH7hithRUswDRb8LXrH48
         3LRfi0SqGaGmrH2kQSxYhiao24w5U8M6pvOku3RZFjAfU/rGeTqK8/T69P93VGYrrLdj
         u3Kg5Au7OMQ0PXIbKoNn+ZTloU0igH4J9fRjIqHIyTTcdqpRU0QS4PQDuRU83AdoYbfg
         yMI4JQFhKTjyRDW5e9jVgA2p105d4GCjKwfoRYItNNTJil1kw1tCqqg6yU5H7hF1h4ZD
         bbcjqOWAKQhEDlpiKmfmRELU4Cyuw7Injae6f6KhP/KdggNDnxq1bEqnHGHNLnxnOdWw
         0Hdg==
X-Forwarded-Encrypted: i=1; AJvYcCXKpDSfqLpz21ZnrJ1j635dSxOY7VYusEiBmXpIyqUaMf7FkPDUNDaf9vmXyGIWel1TOpy6kiQSGTpDW0nQCpUVqFJMtg9kkxqP
X-Gm-Message-State: AOJu0Yy+6Xthn+epbnkreQA7U1D2ZIgT1w/LTlpEL+TDfwlPnZ3zV3V8
	37qpUtorXGck1s79YTs/UerIgEwnuHC98bcr85nMLMVw8G/OdvCohvqHjxNW/09dLcgdQNNy3F4
	=
X-Google-Smtp-Source: AGHT+IHBP2KQq2wlwcOVJTgkmJGQFKU/wQBEoc9dJwWSd4e5dH5JjnwXusBfF71v01BaIbPLTD8j5Q==
X-Received: by 2002:a17:902:ea0b:b0:1dc:7101:58c0 with SMTP id s11-20020a170902ea0b00b001dc710158c0mr10543808plg.22.1708961421157;
        Mon, 26 Feb 2024 07:30:21 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id km6-20020a17090327c600b001dbae7b85b1sm4087272plb.237.2024.02.26.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:30:20 -0800 (PST)
Date: Mon, 26 Feb 2024 21:00:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <20240226153014.GG8422@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
 <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>

On Mon, Feb 26, 2024 at 03:53:20PM +0300, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> > In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> > the drivers can auto detect the number of read/write channels as like its
> > predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> > have to pass the channels count during probe.
> > 
> > To accommodate that, let's skip finding the channels if the channels count
> > were already passed by glue drivers. If the channels count passed were
> > wrong in any form, then the existing sanity check will catch it.
> > 
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 193fcd86cf93..ce273c3c5421 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  
> > -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > -	else
> > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > -
> > -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> 
> > +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> 
> Are you sure that the partly initialized case should be considered as
> a request for the auto-detection? IMO &&-ing here and letting the
> sanity check to fail further would be more correct since thus the
> developer would know about improper initialized data.
> 

We already have the check below. So the partly initialized case will fail
anyway.

- Mani

> -Serge(y)
> 
> > +		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > +			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > +		else
> > +			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > +
> > +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > +	}
> >  
> >  	/* Sanity check the channels count if the mapping was incorrect */
> >  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

