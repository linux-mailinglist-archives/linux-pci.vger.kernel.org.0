Return-Path: <linux-pci+bounces-4056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB8868254
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0E328619F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E623130E5E;
	Mon, 26 Feb 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGZNP0aB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1212F388;
	Mon, 26 Feb 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981248; cv=none; b=C7bfsT81AEA01indV9GgH9nTrTPlpRUpBLHqzZ3hullBFpgf6ONMVbjGV/7M+zDCXPb8WE+vvaPlAY4b8dATxsnmD+ssoRsWpwV3seNcMf373/j/a88ACbowravkHdgSIGyt/g/StFuUeIUL9x5+5Zg+wOhjXwPcYmoLOL06x5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981248; c=relaxed/simple;
	bh=+W/0O7WuVT+UyHpzMl4HcX6s22lBLQB0RYLJNwkggJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiZgCnKgChSx/dE6A52B95sApNDLiTZUCp5HoSYSta0wNDPjbLIKLbg4lj68a30MxtzL+V9JylmLeAEo/Ou/kAWoxUCcctjOjDuhaIquyPFX157j1M3auaGWe4j/ITkZAUP4VncoN6g51anN/UKsWSZBADM4eQU4ct1+3zPLjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGZNP0aB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512fd840142so1764476e87.2;
        Mon, 26 Feb 2024 13:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708981244; x=1709586044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0nKmbQkUe18dfPF3HGk5d2W421zTO2IH69qRYWbZuQ=;
        b=kGZNP0aBn2oDjjBP6e4kOSQaaSiaTSvSfrqMJGly/5S/I2BWsC5nugiY5/qtn2Tuwg
         Va8PidHyeOCcNt1OKlk/JHnNTvB4rmM/9pMAKaWa1G3//+8qUQS2d4DnryDVdRrgdyMf
         iWukPbGmiGnvHBO2SB3DM8m56c5qGaD0EOSBFPJoDRVssD10QU8AUYIXYdpeBu2Aq/v3
         uqxwwm4VHYPjxv7vGDuUrRtkKkqwe6uBs23hGvTwwHozSsjtvAJSOWWSRkDx7EMyGUmX
         NLYk1BdXEV68x9wxnd03Hu7wE9AJ1dHJMCPWHMJecQvxQjBc71bDAdQvadb2/kuH0m//
         Qilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708981244; x=1709586044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0nKmbQkUe18dfPF3HGk5d2W421zTO2IH69qRYWbZuQ=;
        b=oKX0ltQRWYtME9ODblWqavHpFJV7wK85UFAH+dKwBS2wU8RPNnqPpvW6dB7JWeQHkR
         jLgJ6ihw0Dh0riyYDwWcsbM5i2F6iY6mgWFCjblP7I1ldwh7YfVaK9NdczJ5Jj8bhkX0
         Z1a8VnonerC1pfANJHLRxHglp+6LYU5YYd1ZDC19k3bFssZ17sWiZvV3CRDpJycaf7MS
         V4czSy71MMOtkZZQHWAHjg0OuEy/0DMidplOCK/nbqaueAYReduSg54asNhWQ0X4r8S6
         le1NhBprln86E6rojAkHd1dGqWOLyxctrmZkk8GQGCST2UGsKTQvF252k0HmsEi6MywR
         0yqg==
X-Forwarded-Encrypted: i=1; AJvYcCVbue28cFi3NpHkTEf1SaIQSjG6cINB4yoQ28NQWT68xYLKCWgEBlEq3MoEFu9vB59XNTAIgwjLTZw9E83AarR2BllM5J6VgjoJaeijndsDKOQOLpbHmSnfLMYj4ISeukDgCbBBZcM9tBsmxd8UsfGSOK8ErtpD00RcV3vpUVL4/JKnH4pCYm6ooyVUrL9lhPKbt2Cz46tgBS1eMWCMMbHLCKm/v7WG7e5U
X-Gm-Message-State: AOJu0YxmK/mL5t5DzlJ7WIDJS/rOSxk2wBnh1qnwtnnJsUkJ84lE9KN9
	yePpovvfewjmdHIeyIvgEZsmipVjHz3qIjXKZQDsr6IUYxwwW5RX
X-Google-Smtp-Source: AGHT+IG2CImQkqVQxd6ssoaZRcwh+i9k2qjnbEW465k4VFAlfiuJmCJysPvX5Urg5QLGl0NPz44FlQ==
X-Received: by 2002:a05:6512:a95:b0:513:a6:2f4 with SMTP id m21-20020a0565120a9500b0051300a602f4mr2236792lfu.13.1708981244044;
        Mon, 26 Feb 2024 13:00:44 -0800 (PST)
Received: from mobilestation ([95.79.226.168])
        by smtp.gmail.com with ESMTPSA id br35-20020a056512402300b0051186a82fc1sm953312lfb.171.2024.02.26.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:00:43 -0800 (PST)
Date: Tue, 27 Feb 2024 00:00:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v3 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <6r7kquumuaga5j2hosyi6fla6frdzm5e4iobt7dtftjuwm7wku@7wij7dfhneob>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>
 <fielxplkgrvz5qmqrrq5ahmah5yqx7anjylrlcqyev2z2cl2wo@3ltyl242vkba>
 <20240226152757.GF8422@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226152757.GF8422@thinkpad>

On Mon, Feb 26, 2024 at 08:57:57PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 26, 2024 at 03:45:16PM +0300, Serge Semin wrote:
> > Hi Manivannan
> > 
> > On Mon, Feb 26, 2024 at 05:07:26PM +0530, Manivannan Sadhasivam wrote:
> > > In order to add support for Hyper DMA (HDMA), let's refactor the existing
> > > dw_pcie_edma_find_chip() API by moving the common code to separate
> > > functions.
> > > 
> > > No functional change.
> > > 
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 52 +++++++++++++++++++++-------
> > >  1 file changed, 39 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 250cf7f40b85..193fcd86cf93 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
> > >  	.irq_vector = dw_pcie_edma_irq_vector,
> > >  };
> > >  
> > > -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > > +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> > > +{
> > > +	pci->edma.dev = pci->dev;
> > > +
> > > +	if (!pci->edma.ops)
> > > +		pci->edma.ops = &dw_pcie_edma_ops;
> > > +
> > > +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > > +}
> > > +
> > > +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
> > >  {
> > >  	u32 val;
> > >  
> > > @@ -900,24 +910,27 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > >  	else
> > >  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > 
> > 
> > > -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > -		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > -
> > > -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > -	} else if (val != 0xFFFFFFFF) {
> > > -		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > > +	/* Set default mapping format here and update it below if needed */
> > > +	pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > >  
> > > +	if (val == 0xFFFFFFFF && pci->edma.reg_base)
> > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > +	else if (val != 0xFFFFFFFF)
> > >  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> > > -	} else {
> > > +	else
> > >  		return -ENODEV;
> > > -	}
> > 
> > Sorry for not posting my opinion about this earlier, but IMO v2 code
> > was more correct than this one. This version makes the code being not
> > linear as it was in v2, thus harder to comprehend:
> > 
> > 1. Setting up a default value and then overriding it or not makes the
> > reader to keep in mind the initialized value which is harder than to
> > just read what is done in the respective branch.
> > 
> 
> No, I disagree. Whether we set the default value or not, EDMA_MF_EDMA_LEGACY is
> indeed the default mapping format (this is one of the reasons why the enums
> should start from 1 instead of 0). So initializing it to legacy is not changing
> anything, rather making it explicit.
> 
> > 2. Splitting up the case clause with respective inits and the mapping
> > format setting up also makes it harder to comprehend what's going on.
> > In the legacy case the reg-base address and the mapping format init are
> > split up while they should have been done simultaneously only if (val
> > != 0xFFFFFFFF).
> > 
> 
> Well again, this doesn't matter since the default mapping format is legacy. But
> somewhat agree that the two clauses are setting different fields, but even if
> the legacy mapping format is set inside the second clause, it still differs from
> the first one since we are not setting reg_base.
> 
> > 3. The most of the current devices has the unrolled mapping (available
> > since v4.9 IP-core), thus having the mf field pre-initialized produces
> > a redundant store operation for the most of the modern devices.
> > 
> 
> Ok, this one I agree. We could avoid the extra assignment.
> 
> > 4. Getting rid from the curly braces isn't something what should be
> > avoided at any cost and doesn't give any optimization really. It
> > doesn't cause having less C-lines of the source code and doesn't
> > improve the code readability.
> > 
> 
> Yeah, there is no benefit other than a simple view of the code. But for point
> (3), I agree to roll back to v2 version.
> 
> > So to speak, I'd suggest to get back the v2 implementation here.
> > 
> > >  
> > > -	pci->edma.dev = pci->dev;
> > > +	return 0;
> > > +}
> > >  
> > > -	if (!pci->edma.ops)
> > > -		pci->edma.ops = &dw_pcie_edma_ops;
> > > +static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> > > +{
> > > +	u32 val;
> > >  
> > > -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > 
> > > +	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > > +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > +	else
> > > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > 
> > Just dw_pcie_readl_dma(pci, PCIE_DMA_CTRL)
> > 
> 
> 'val' is uninitialized. Why should the assignment be skipped?

The entire

+	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
+		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
+	else
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);

can be replaced with a single line

+	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);

since in the legacy case (reg_base = PCIE_DMA_VIEWPORT_BASE) and the
reg_base has been initialized by now.

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > >  
> > >  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> > >  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> > > @@ -930,6 +943,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > >  	return 0;
> > >  }
> > >  
> > > +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > > +{
> > > +	int ret;
> > > +
> > > +	dw_pcie_edma_init_data(pci);
> > > +
> > > +	ret = dw_pcie_edma_find_mf(pci);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return dw_pcie_edma_find_channels(pci);
> > > +}
> > > +
> > >  static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> > >  {
> > >  	struct platform_device *pdev = to_platform_device(pci->dev);
> > > 
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

