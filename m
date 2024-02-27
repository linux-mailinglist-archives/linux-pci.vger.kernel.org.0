Return-Path: <linux-pci+bounces-4090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02096868AF8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFFB26712
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402A130E24;
	Tue, 27 Feb 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ga64HLIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388305645A
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023338; cv=none; b=KMCrKNQ6ICiBOz16TSch0xDD45XaNgz4lo+x/GJOGrNiCW635LdSBGnirvqaexZelZef7kqLEyTnQ0lkBEBURxcKkbWD1LEdqBmgzhA1+2Cg1rsBMP1hlg2cT8OaLVelCsWezuqFyTJbHIMjq5oK2O+qDRomaFYTQY6coTI10Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023338; c=relaxed/simple;
	bh=eviFAxTmvFwlj37aSBuJSsrrDTcrHP7vSfHXT8AnIMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGwf728o22emrIKazLfvNmYdXq7/RQmasB5nF0KJTLEcR0ooQTB9xwkqwWgNBbIYvYs7u4mA4ER9vuRcwN8tFWiH6jLRRPq891xKiJeCjQ4z37hV5h0j+HLEYdlsv27MrS8A6u9qnL+ImyhSM6oTYxCG7m2jyQFemqavaGoCQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ga64HLIj; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21ea1aae402so2080372fac.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709023334; x=1709628134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/cM19NrlUQE5f0uY2kEvyT2gAXXaqjXwTAFjxjKcMvc=;
        b=ga64HLIjacpKL8W3KvroR+Ly+2FvBDU8qK/mWIalbssknzvJfeIsyL99CnhJKeYMYP
         uiNa6wtqk2TsW9jhYEEQ3W3NdrPlvxL/KI7sKzxmSFnnMdeOwpwVKR9KFmiTghdXRoZK
         UZb0XLPGd+aIeUPE4yhqsc8VZRKmPxKS7JD8JHXpMm/gIlixYZrRJyDabGBxOL6Rip6A
         z3ZzKL7Rf2Dkh63Zj/Hd/KB47Ln+GkrkOnHstYh4jGs+ahmf9w2AsEGFY0hHmzUgLuxF
         Z7+Wa6UFPkbyjvl2D9B5OnshgQJiwF17q7qck9c7/cj8lt01Wbs0DRq+dic2M9opLHNr
         KUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023334; x=1709628134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cM19NrlUQE5f0uY2kEvyT2gAXXaqjXwTAFjxjKcMvc=;
        b=uH3aTlL+6neOpFiMfuYEQNthZwKhs4ZAcsyRG8gWqrq5B6o+LP0/Cn9W7ZyFHFP1y3
         ODLSLcypxxqyxnKx8q0Abys8PBt8JsCSMqi4GRfWPlBeqeu8rqSlphgVDshsyEfGqUSn
         HTkMCeSJg6mUMijag5yiwacbQV5LuZFCnTEuOiXL+kXqr5VosNH11MiMrVPsNNeN5uq6
         IH65UgDR9PYPZGSKbp9KRmr6NwAu7v7lbbfGSf37hmu9zFprqSA8W1PY99C6uy0fQwRz
         LSXNBeaf58nnvyY1aOLP9/Emh+pzmLLwJKHS2sLYm1uRR2c3UlMeVhoxD/NaYXEjYBqu
         hBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsB1BBgjJL8tHiQeVJIY6EHUBLcjkDwfJqyLNEf/8F7qaUziVUhdfrDKJ+y5RWE/E58UdB5IZV7uOfGRMF2HA26zt+jHwxJ/Qa
X-Gm-Message-State: AOJu0YwWPbqYeXaH4kfk1nn5KWZ2TDdo9z8697lCcd3ek8pnink1Zxvu
	DaulWUO/vWwudxI8q+V5RtT2NOsLXQfhsjLouS+Afr+VRaZ8KQJweot3JS2aqQ==
X-Google-Smtp-Source: AGHT+IHQ/416nfXXHvEHWnn79YnL2bV5h+6AxvQFvjmUWbUWtUrZWs6Wc0+h1xF3XxTWGAkfnuf60Q==
X-Received: by 2002:a05:6870:b021:b0:21e:7c86:665e with SMTP id y33-20020a056870b02100b0021e7c86665emr11563960oae.16.1709023334040;
        Tue, 27 Feb 2024 00:42:14 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id g8-20020a62f948000000b006e500cbb529sm4554957pfm.50.2024.02.27.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:42:13 -0800 (PST)
Date: Tue, 27 Feb 2024 14:12:04 +0530
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
Message-ID: <20240227084204.GI2587@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
 <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
 <20240226153014.GG8422@thinkpad>
 <4p4z5eyhpdhxzi36drhrmz6z7krupszddudg6c2baypkbnnj7t@nqcmk2wdntts>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4p4z5eyhpdhxzi36drhrmz6z7krupszddudg6c2baypkbnnj7t@nqcmk2wdntts>

On Tue, Feb 27, 2024 at 12:32:44AM +0300, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 09:00:14PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 03:53:20PM +0300, Serge Semin wrote:
> > > On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> > > > In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> > > > the drivers can auto detect the number of read/write channels as like its
> > > > predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> > > > have to pass the channels count during probe.
> > > > 
> > > > To accommodate that, let's skip finding the channels if the channels count
> > > > were already passed by glue drivers. If the channels count passed were
> > > > wrong in any form, then the existing sanity check will catch it.
> > > > 
> > > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> > > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 193fcd86cf93..ce273c3c5421 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> > > >  {
> > > >  	u32 val;
> > > >  
> > > > -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > > > -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > -	else
> > > > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > -
> > > > -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > > > -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > > 
> > > > +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> > > 
> > > Are you sure that the partly initialized case should be considered as
> > > a request for the auto-detection? IMO &&-ing here and letting the
> > > sanity check to fail further would be more correct since thus the
> > > developer would know about improper initialized data.
> > > 
> > 
> > We already have the check below. So the partly initialized case will fail
> > anyway.
> 
> Not really. If the partly initialized case activates the
> auto-detection procedure it will override both non-initialized and
> _initialized_ number of channels with the values retrieved from the
> hardware, which the glue driver has been willing not to use. This
> prone to undefined behavior depending on the reasons of skipping the
> auto-detection procedure. For instance, assume the DMA_CTRL register
> reports an invalid number of read channels. A glue driver by mistake
> or willingly overwrites the pci->edma.ll_rd_cnt field only. This won't
> solve the problem since the auto-detection will be proceeded due to
> the pci->edma.ll_wr_cnt field being left uninitialized.
> 
> So to speak it would be better to implement a strictly determined case
> for activating the auto-detection procedure: both number of channels
> aren't initialized; if only one field is initialized then report an
> error.
> 
> Alternatively we can have the auto-detection executed on the
> per-channel basis:
> 
> +	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +
> +		if (!pci->edma.ll_wr_cnt)
> +			pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> +
> +		if (!pci->edma.ll_rd_cnt)
> +			pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +	}
> 

Hmm, in this case there is no need to check for uninitialized channels count:

	/*
	 * Autodetect the read/write channels count only for non-HDMA platforms.
	 * HDMA platforms doesn't support autodetect, so the glue drivers should've
	 * passed the valid count already. If not, the below sanity check will
	 * catch it.
	 */
	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);

		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
	}

	/* Sanity check */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

