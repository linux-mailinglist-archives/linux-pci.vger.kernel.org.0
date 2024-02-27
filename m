Return-Path: <linux-pci+bounces-4085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E6868A17
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E271F231F7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257E54F8F;
	Tue, 27 Feb 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAzeuhSk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F15467C
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019943; cv=none; b=id7zb5nYvXzKgOOKGUoMgSCVS+JQ7AIsjXhm7dy+8vUG7bGd4UTP7azVNKeqyMHFVqkmzDk2JPejs2wqBrczPcUZdajl2fIDOwgM+pCJu8Pn4MCcoQOFhhrc7Zwb2HA62nN1aJYH9WaxayTiuE4aBkFT1XEYYi2GwVG1fisBns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019943; c=relaxed/simple;
	bh=LHY1soh3TSDneqtCq2eVyxDXi8p5oUsCqKFJ1MDn28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiO5hTY6HqWhPFeWxcZjcshCOxf6BrXusNUFzHp9p6MOACOzx0uZTnQEkaj8DhNJ6uY4DvDpTL+vr17qwrW65icUnhC5urc3OED/sthqG/tUn7U/L16puj/pv7Rw+y0PGfsdLs+jPNmTgYArlrTR+IGHJG+Sb1ckn/UjkCVvga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAzeuhSk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94b222a3aso40444505ad.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 23:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709019942; x=1709624742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vz+b24keEy8SKVGT/zsCqIzqYg8F8QonmdaHU6M1RMQ=;
        b=uAzeuhSkOi5XC1Q0+LXKPKFqfcxiFqsB8qz0ePNLB5Ake664f9qZtlJr11kjCjTM3k
         5XSJOvLPth+sySUqR76VsavJ38Ce2Wb77YyOw++TwqOkGmAs7n24lYUwfJPMOZfeTjUB
         jbVH1AKHaV/NlTPoPUnC5inlX0LGqhmIQao1TdsAoSoFrYF1D6OHK5cT+kflJzY5VdkJ
         /148x+GZ5g6WmLtcOPQVkpuEZRgH6EIiR1Tg1NZAnz03+ZWZ9YdUq+isPrk9d2fUVReK
         yHYMfKVXQ1qSFTdYD0MPAK8JaWLFrK6ceXpTVMJtVYCHdqTAVCf9ImO5iIRxAkjnUJH5
         gvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019942; x=1709624742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vz+b24keEy8SKVGT/zsCqIzqYg8F8QonmdaHU6M1RMQ=;
        b=uI5UTZ5tA+DXUK55kcVxTa+tatj/fglUqtt8Ey5c6ae6K4BC6KExpBp3tyXowoDR8N
         5HTZLKAspJLU0nfkUtwsossFQM45365H3cmnf1zaA4/KVj+Xd+RZPlykHLirLvhfv03a
         v8ULPCjTa+9r6LwCE3mJ+u1wVqsPgC7jamVu5UuLQyZV2KhojgObAFe8mHTlQwxCmOIO
         x79W/5Cf9rFenCCs2dA6NoCvZUcyULALH+w/6Z2ZNmI/yyGoLEhLZd5qLxTNrjkxuMNM
         YhHueNWBBaamraDvIPEofjdjxpiwn7sUzbHJ9I5YBdhj205XklBxvHcAwyYpVl5QetEA
         MteQ==
X-Forwarded-Encrypted: i=1; AJvYcCWspFXG8nMU8tDU3ReIyir4I1Ieu8TJRt6LQgSNrJa+9t0uy96TUz3JAHYXFBxmnH0lD/80d1ZRrSTLU2+/f0I5ToH4r2qwE8in
X-Gm-Message-State: AOJu0YxgWpX2i4ZCbVrZsHOyDts16uSGWAxB9BNo5r6z19NaCdox+35H
	sjYlPz+AaeRbajmYyaZ2zzAJqsbm2zwvtc34N7joudfQe1bfC33U3kXBvk7RLA==
X-Google-Smtp-Source: AGHT+IGoPWkNE6JIjVJz1XqdnjAP9lGvBAm0VujbexvNFkLOg4OzNepoOaOycaMqUlL+eVesMoK8lA==
X-Received: by 2002:a17:902:db0e:b0:1dc:b77e:1973 with SMTP id m14-20020a170902db0e00b001dcb77e1973mr1593245plx.53.1709019941652;
        Mon, 26 Feb 2024 23:45:41 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b001d71729ec9csm884589plc.188.2024.02.26.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:45:41 -0800 (PST)
Date: Tue, 27 Feb 2024 13:15:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
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
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <20240227074533.GH2587@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
 <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>

On Mon, Feb 26, 2024 at 11:30:13AM -0500, Frank Li wrote:
> On Mon, Feb 26, 2024 at 05:07:28PM +0530, Manivannan Sadhasivam wrote:
> > Instead of maintaining a separate capability for glue drivers that cannot
> > support auto detection of the eDMA mapping format, let's pass the mapping
> > format directly from them.
> 
> Sorry, what's mapping? is it register address layout?
> 

Memory map containing the register layout for iATU, DMA etc...

- Mani

> Frank
> 
> > 
> > This will simplify the code and also allow adding HDMA support that also
> > doesn't support auto detection of mapping format.
> > 
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> >  drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
> >  3 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index ce273c3c5421..3e90b9947a13 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  
> > +	/*
> > +	 * Bail out finding the mapping format if it is already set by the glue
> > +	 * driver. Also ensure that the edma.reg_base is pointing to a valid
> > +	 * memory region.
> > +	 */
> > +	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
> > +		return pci->edma.reg_base ? 0 : -ENODEV;
> > +
> >  	/*
> >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> >  	 * thus no space is now reserved for the eDMA channels viewport and
> >  	 * former DMA CTRL register is no longer fixed to FFs.
> > -	 *
> > -	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> > -	 * have zeros in the eDMA CTRL register even though the HW-manual
> > -	 * explicitly states there must FFs if the unrolled mapping is enabled.
> > -	 * For such cases the low-level drivers are supposed to manually
> > -	 * activate the unrolled mapping to bypass the auto-detection procedure.
> >  	 */
> > -	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> > +	if (dw_pcie_ver_is_ge(pci, 540A))
> >  		val = 0xFFFFFFFF;
> >  	else
> >  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 26dae4837462..995805279021 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -51,9 +51,8 @@
> >  
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
> > -#define DW_PCIE_CAP_EDMA_UNROLL		1
> > -#define DW_PCIE_CAP_IATU_UNROLL		2
> > -#define DW_PCIE_CAP_CDM_CHECK		3
> > +#define DW_PCIE_CAP_IATU_UNROLL		1
> > +#define DW_PCIE_CAP_CDM_CHECK		2
> >  
> >  #define dw_pcie_cap_is(_pci, _cap) \
> >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > index e9166619b1f9..3c535ef5ea91 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
> >  	rcar->dw.ops = &dw_pcie_ops;
> >  	rcar->dw.dev = dev;
> >  	rcar->pdev = pdev;
> > -	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > +	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
> >  	dw_pcie_cap_set(&rcar->dw, REQ_RES);
> >  	platform_set_drvdata(pdev, rcar);
> >  
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

