Return-Path: <linux-pci+bounces-5161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444AB88BC8D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 09:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8662E2CA6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E5101E6;
	Tue, 26 Mar 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDlg6BC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BE10A19
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442029; cv=none; b=KK8Sn/D/Qg5WR9JYNqLp+l/afJvj4Hn62MDlxZrph+PDfA42gH+lmj5a7Ry+zLo1xjwg/iDjk/IRrlf+ACWFnCKqz8p3T0yjBI8Ea0gucvhp//6JirZZoJKbsIm4D0HX2NQxma1SfPEwifzYgPflygxcECfWB4hKXIeQWIfujTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442029; c=relaxed/simple;
	bh=ekSZJD9CdDsC7N70aoX3Mzm0bRUXxt7Zdo8CRQJXlHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLV3UOnw8tKXzBWKquBqjP4B8oxp6+YiIF+cq7x1qGb+ogs3ue9dxxi+7nbA3e4SPgQyW49ITuiKBLuqkETsQLdSjCEBgPQ5SFKauLE2Dz1XRrXENFFeQVQ10s31i5BourZ8iDEcK8kvTw8zKWGC/eHr/5bdgBdCUAmtLOoarKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDlg6BC5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dfff641d10so35727135ad.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711442026; x=1712046826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQOtfcbnYc24Mh+gXI1bFDgfC9HlUS+Sxyvob3hinF4=;
        b=QDlg6BC5TpEpQSiYK/ywqBmTCeMtYFVoAGi71ZSLenNMLZixXzy4HpvxwCIH28UH0o
         UkYRKCOR3dkjAfHs78TTor3aXXJOQX5eE4dyOFbvcSQDlKIf6n7SmmJi0QD/OGo162ww
         EhucN79Z4dlppF8Xmb443dHNhx9JMsA+6COFtzg7zBAN2SOxoXtFHsW9IrzdALSMo+Fl
         N8FJAnJYpG74KiSs/Eeyg8hVsqeYwbsZehsYvdUHDSnxobC01i3WgT6OynfCNXX2VJT9
         spduE8GqiCfFxWIgovejwa+ANb9AibJCLbbWxlM1JiOkeHXcZoQ8Th/ACZ/yvP5XKFWX
         VxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442026; x=1712046826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQOtfcbnYc24Mh+gXI1bFDgfC9HlUS+Sxyvob3hinF4=;
        b=XjHLumnEbm/p7me4XKssOZLCXqjT+ealNyBgmM4lpJONE6KnDIZtAxGhGCf6rFUb4r
         KJhM0fUkvuc7m+lqIaP5rzibsd1FVZ8dIj2EXaSbIsD+dsCJCzKZ/zQI0XiSXaY6pBjh
         H40TVZan7b+YGP7VlQ+mJDBUejk+NmcQZct3bSiADeGBLp0pa7Rdo9X1exogsWw11k8Z
         kUFgVIq+CAtFtk1l0uI+AwoWTIsPxal7ZAJScLCXoj6bP6g2XJEFegK1o5BeFSBuVOgq
         0JT4XUkHq1Yi0nFUdNpgeFsLaUjjxI6cH1zrfQ8WLqgwkxsJVjoPAtTQQ/jA32VwfCDA
         4JGA==
X-Forwarded-Encrypted: i=1; AJvYcCXnk85uzvoyfaLWfat4Q6UgcrXh7pODEn3gN538tFPCrv+jTpAYwW0f6350u8jCm5BAEOXZ6giqatUa+LR8nUaZt2eF3TmFlMOv
X-Gm-Message-State: AOJu0Yw98v3p2/FhJtFohAK95u9pDN4gIwp5TE5igeeSGK4AuTDSbogV
	RfJ2VnVk8SHkp0VRS0e7Ha7LiTFn49rE9o+ZS7FZjKwCOqE6hdm5MdkE2cyJ5A==
X-Google-Smtp-Source: AGHT+IHM8PyfEgYVUSNeb8rAEehN4cswciWPXaugw1p1Nss4iAw4Hcpv2ciDq/JtT+SO2hYFDn/fhA==
X-Received: by 2002:a17:902:c952:b0:1df:f681:3cd8 with SMTP id i18-20020a170902c95200b001dff6813cd8mr2343690pla.12.1711442025839;
        Tue, 26 Mar 2024 01:33:45 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b001ddb505d50asm535867plg.244.2024.03.26.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:33:45 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:03:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/11] PCI: qcom-ep: Rework {start/stop}_link() callbacks
 implementation
Message-ID: <20240326083338.GI9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-10-6134e6c1d491@linaro.org>
 <Zf2tjht4TR7Irewd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2tjht4TR7Irewd@ryzen>

On Fri, Mar 22, 2024 at 05:10:54PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:49PM +0530, Manivannan Sadhasivam wrote:
> > DWC specific start_link() and stop_link() callbacks are supposed to start
> > and stop the link training of the PCIe bus. But the current implementation
> > of this driver enables/disables the PERST# IRQ.
> > 
> > Even though this is not causing any issues, this creates inconsistency
> > among the controller drivers. So for the sake of consistency, let's just
> > start/stop the link training in these callbacks.
> > 
> > Also, PERST# IRQ is now enabled from the start itself, thus allowing the
> > controller driver to initialize the registers when PERST# gets deasserted
> > without waiting for the user intervention though configfs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Nice change:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> If you dump LTSSM after a PERST assert + deassert,
> using e.g. dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1);
> to dump the debug registers (see dw_pcie_link_up())
> do you see that PCIE_PORT_DEBUG1_LINK_IN_TRAINING is set?
> 
> I was thinking that perhaps there was a thought behind
> this original design, that you had to explicitly set
> LTSSM_EN after a fundamental core reset, because it
> would get cleared?
> 

Well, you are right. I was hoping to get an answer from Kishon/Vidya, but you
throwed the light. I will drop these 2 patches.

Thanks!

- Mani

> (It it is implemented like signals and not registers,
> then this change should be fine.)
> 
> 
> Kind regards,
> Niklas
> 
> 
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 811f250e967a..653e4ace0a07 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -122,6 +122,9 @@
> >  /* PARF_CFG_BITS register fields */
> >  #define PARF_CFG_BITS_REQ_EXIT_L1SS_MSI_LTR_EN	BIT(1)
> >  
> > +/* PARF_LTSSM register fields */
> > +#define LTSSM_EN				BIT(8)
> > +
> >  /* ELBI registers */
> >  #define ELBI_SYS_STTS				0x08
> >  #define ELBI_CS2_ENABLE				0xa4
> > @@ -250,8 +253,12 @@ static int qcom_pcie_dw_link_up(struct dw_pcie *pci)
> >  static int qcom_pcie_dw_start_link(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > +	u32 val;
> >  
> > -	enable_irq(pcie_ep->perst_irq);
> > +	/* Enable LTSSM */
> > +	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> > +	val |= LTSSM_EN;
> > +	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
> >  
> >  	return 0;
> >  }
> > @@ -259,8 +266,12 @@ static int qcom_pcie_dw_start_link(struct dw_pcie *pci)
> >  static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > +	u32 val;
> >  
> > -	disable_irq(pcie_ep->perst_irq);
> > +	/* Disable LTSSM */
> > +	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> > +	val &= ~LTSSM_EN;
> > +	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
> >  }
> >  
> >  static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
> > @@ -484,11 +495,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> >  
> >  	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
> >  
> > -	/* Enable LTSSM */
> > -	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> > -	val |= BIT(8);
> > -	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
> > -
> >  	return 0;
> >  
> >  err_disable_resources:
> > @@ -707,7 +713,6 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
> >  	}
> >  
> >  	pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
> > -	irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
> >  	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
> >  					qcom_pcie_ep_perst_irq_thread,
> >  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > 
> > -- 
> > 2.25.1
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

