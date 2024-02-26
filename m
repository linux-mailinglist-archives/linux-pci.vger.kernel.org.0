Return-Path: <linux-pci+bounces-4060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C51868320
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5531F23B3F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543F132477;
	Mon, 26 Feb 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQKriiat"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3566131E40;
	Mon, 26 Feb 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983170; cv=none; b=TynX7SBOASm6GdBPMvDrryImELP4+KOxyRbCCRPKNa1jr8lgvw4bDimDngKLGXXOAhAdWMRPiHjoBUQs9F2Z5a/9E9G6EbApxqPcz8lvWTI48k4RyydxVlGu8P17iTE1yBtZtLlBF5CHgga2F41cSHlcvw6I7GVi8JQIcjH7co0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983170; c=relaxed/simple;
	bh=6jYoQspdkHGJLK0YUMFQ1JcVi1hhQ8mEQbVyui8iIj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuBGmZFFQ4m2tv2ybp4zpGt8FPYBAeStjgov52RByFit3JwbbM1mqGPYiQg6gYhUGdzzP3ZSzAzAjDBTdA5B8cqj7Wn06imQMsqphli/xmPYYXNlmmsuw1HFz1kebwOf7HzfrWESGYEgKyWic4/N2TTRw8BL2TO7Y1YB9r4TUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQKriiat; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d288bac3caso19989131fa.2;
        Mon, 26 Feb 2024 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983167; x=1709587967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8xzxpmRfOYpMJXfjSv2//ub/SLcVqWsue/aaIwJmAc=;
        b=FQKriiatg5mPDf+7Hm1fjqdku4zkV3kSinOQR8YYoUXLDN6QpH9HzaAwM6YsEAXkJR
         HfjU+n2XhECA2EQmRtDvT8nnYoBA/jt1+C2Qv8hweGc4rg9BDc9AnpCGAyLy1m2o5gJi
         yHzs3N5FbLULRMOkAGSy4gC1azcoOXUOyJP4nI2S7t03yQRxmOPsCj2AITOgsdu0fgqU
         Jw9glDmEdd62aU3ky9Yc7zVnz3qIiSB4StJTm1J//DB37X14dYAu3dUSjcEhMwNooSVR
         UAO8L1ULlD08UE1Rvv6MzEvwHQpuhsrR/5ZoDg6fHc0lmd1Mz/auYXjvBO/OLRQ9lvvV
         opGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983167; x=1709587967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8xzxpmRfOYpMJXfjSv2//ub/SLcVqWsue/aaIwJmAc=;
        b=Sr9ak38erG8tMe6Mpliwt9AfIayc7q60f99nDAzu9pEU2yH0gXv7dhoF5WItVeEB8M
         MH/Qta1tn+k0U3xiyp/IAn/pEQIkkkSDMp9fHwCx1lKJAtJoaH+FchtCh5qGvrcP61F9
         DhG0/fvBuvr7y9gVhoPgRNXT8dsrJv/BQ6HCWiARc6dTiCqQxrrL4ruU2lSScs8G1PA0
         1SeEgexKcd/FcTnCVX6tEDXk75Rglb/h62ErF+KBNNpt3m/Spjxxt4n6uUWNeodaSG9v
         SbY0oB4WaYPGM/OhbO4wzYKAbtYXBQhy/lWnW41tGnvZLvouKdDR07R0cU10/KjetgSC
         ixZw==
X-Forwarded-Encrypted: i=1; AJvYcCWt5gzWTl86x0vMTqFUGl0E7D+OPSqLAxiNBSa3/aXiL4JyTblGEPHP8ktnIqTzDFKK4jOHs6YaZb2LRDwdSGm/l9F4w14EbTFwCB0CfFk6N+UKocqU5jQ+LroEhYT/Ny0fe1TNY5QCidxUvehLC53qE9NjK0ojJGnRsB7SuoAHdiBQrIfMPBlkTPKOD/uQ9oIudb5X0pLDynmI2NvPd8FijTgxPc8q81ql
X-Gm-Message-State: AOJu0YyF7jsDkPn7qDIjHXBaUCxsCooSoG13TG3DMAPW144S+hyTTEyM
	UrMn798obEqyzOdgmcxU4PDRmnqtCktfux//Foa0IjWYjuCra6QJ
X-Google-Smtp-Source: AGHT+IFD8fVCLCZRuvlw4QUdTpUUxsb2xINlJ/9nipMrhgrXDqGF7m/mE8vmyJkgieG2WQnmTGcxxQ==
X-Received: by 2002:a2e:a495:0:b0:2d2:7d73:7b3b with SMTP id h21-20020a2ea495000000b002d27d737b3bmr4157845lji.3.1708983166865;
        Mon, 26 Feb 2024 13:32:46 -0800 (PST)
Received: from mobilestation ([95.79.226.168])
        by smtp.gmail.com with ESMTPSA id y5-20020a2e7d05000000b002d2474fdecesm997285ljc.35.2024.02.26.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:32:46 -0800 (PST)
Date: Tue, 27 Feb 2024 00:32:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <4p4z5eyhpdhxzi36drhrmz6z7krupszddudg6c2baypkbnnj7t@nqcmk2wdntts>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
 <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
 <20240226153014.GG8422@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226153014.GG8422@thinkpad>

On Mon, Feb 26, 2024 at 09:00:14PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 26, 2024 at 03:53:20PM +0300, Serge Semin wrote:
> > On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> > > In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> > > the drivers can auto detect the number of read/write channels as like its
> > > predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> > > have to pass the channels count during probe.
> > > 
> > > To accommodate that, let's skip finding the channels if the channels count
> > > were already passed by glue drivers. If the channels count passed were
> > > wrong in any form, then the existing sanity check will catch it.
> > > 
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 193fcd86cf93..ce273c3c5421 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> > >  {
> > >  	u32 val;
> > >  
> > > -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > > -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > -	else
> > > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > -
> > > -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > > -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > 
> > > +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> > 
> > Are you sure that the partly initialized case should be considered as
> > a request for the auto-detection? IMO &&-ing here and letting the
> > sanity check to fail further would be more correct since thus the
> > developer would know about improper initialized data.
> > 
> 
> We already have the check below. So the partly initialized case will fail
> anyway.

Not really. If the partly initialized case activates the
auto-detection procedure it will override both non-initialized and
_initialized_ number of channels with the values retrieved from the
hardware, which the glue driver has been willing not to use. This
prone to undefined behavior depending on the reasons of skipping the
auto-detection procedure. For instance, assume the DMA_CTRL register
reports an invalid number of read channels. A glue driver by mistake
or willingly overwrites the pci->edma.ll_rd_cnt field only. This won't
solve the problem since the auto-detection will be proceeded due to
the pci->edma.ll_wr_cnt field being left uninitialized.

So to speak it would be better to implement a strictly determined case
for activating the auto-detection procedure: both number of channels
aren't initialized; if only one field is initialized then report an
error.

Alternatively we can have the auto-detection executed on the
per-channel basis:

+	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		if (!pci->edma.ll_wr_cnt)
+			pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+
+		if (!pci->edma.ll_rd_cnt)
+			pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > > +		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > > +			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > +		else
> > > +			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > +
> > > +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > > +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > > +	}
> > >  
> > >  	/* Sanity check the channels count if the mapping was incorrect */
> > >  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> > > 
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

