Return-Path: <linux-pci+bounces-16849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10949CDB3E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F370B23703
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906A18EFD4;
	Fri, 15 Nov 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCRM5k72"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860918A922
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662070; cv=none; b=rH/SPsaUHq3Hz67qQ5k6CmjUEWbBu5orOGSgMbDYp+n6ZBokd3PnaLQy6wwr0aLvd7GpTJKeguCc/clSxABhAVB0139cB8NKhl5Gner3bV34g47GfbKYFa/H1nilUShHzlYZl27lcfga05Dkwn6h+cuj/ihjptgORDYdTO1adzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662070; c=relaxed/simple;
	bh=hwecmHve4AYzi3zhdSgFcUIpqnu5U8ofdUi5RzOnxe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ7ItCqrtfDshvN1/QlACz0HkTaJNiBIH24kukZoxSk7nyvEvuqPwpf9xnMmq+A++5+9I53J5/U6eTddOjxkJxhjg4sa5jRoJx3rEyG8sZ1KielXjT7zZzKP7syVbVX6beAtWhS504HGYB0vrJZdBRlVgd/ZYcxMfVJbVSC+msM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCRM5k72; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211a4682fcaso11911655ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662068; x=1732266868; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+Mfi619jV2ZU2LxquMSToNnF3nnJZBbCZyP7JQTlA0=;
        b=JCRM5k72LIDRgFmhxvVVkKD+eub55ZNmi5KEiLJJQpMuAGauuAdXpZS/kxqY3V5PtH
         MXHuxabF97/OjoE2GrC18EvkOuy2xQlW74ssbo9/QLXep/piQ4cYM2RxnuHEi5glg0Jd
         cQk5gB0Jeb4/nHqh+JjUjZIH5GOkP7/qx+TkkuFsYHlbqlRGTtIb53LAwBPq1tmb4BAB
         nuLFsd0W9A2MiolEONZBIPj8oz3oQYPbHV+pfUEj3uQZMUMxJ27AwztiAmGNgluy2XiQ
         T/Q93BRzBs8T8ZU1i7NKV9qmjJLUn6Qdi7GzEg3hYps/WBLuEhZT5TkAmTTDKtDyZF0J
         MV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662068; x=1732266868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+Mfi619jV2ZU2LxquMSToNnF3nnJZBbCZyP7JQTlA0=;
        b=dDp/u+HZVJMaaE34qdLx6nBx/E2QCnW7z4uq8Tet5vOmyQI3mpWAheB5wsHELJU/zx
         MSffVfl2t0vojCUxwCgSBSWX5630z89Xscj2jR1vRRyq5/ZT+ze6qghOB239AD561OEs
         vu3yGBfeU4XoRUx4PEHqnFWDbhkg2XYl5P733kBkzII3z94IysC3ZZmWj/SEElyTwUaG
         wcKy6a8uhPOJwAitMCvgNv1kMCazRKnm+8gzmPrCuAhkHdl/uZSe9fEo85up0k6Yh1z3
         jBpPxlxu//SVYGJ8VJzCQuAERo8vvxUOUcyxuyrJzfwZNDZWGl5vbvUUWKOD1tQdS0Va
         dGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFhjLDoVzmGbPH/lH2CmQHGKj8MlisOZ9och/Sd1+sLqu4NiwIc4C7dVnopoFatQ8dnQ5/+/RXQMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPZkq2koy8beieL0OboOYlNSmSnLGO0we9kDOW0uzmcOccAnB
	RuO5U/JDhhikquIKSicM3AbAGWrY0tT0jPFwfZXTLntzCsNZcXFkQ9n8PQoAMQ==
X-Google-Smtp-Source: AGHT+IFalRU+mwBU4W5KvAkQCdFoplxq4VGGIkYCsSP88HNIjh6dZDKwbkVdM9Nbr+j7d3y1wA/5bQ==
X-Received: by 2002:a17:902:d505:b0:20c:cf39:fe3c with SMTP id d9443c01a7336-211d0ebf209mr26364095ad.41.1731662067691;
        Fri, 15 Nov 2024 01:14:27 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f346e2sm8163945ad.141.2024.11.15.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:14:27 -0800 (PST)
Date: Fri, 15 Nov 2024 14:44:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 1/4] PCI: dwc: Export dwc MSI controller related APIs
Message-ID: <20241115091419.tc4p2jwukjdo56of@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-2-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106221341.2218416-2-quic_mrana@quicinc.com>

On Wed, Nov 06, 2024 at 02:13:38PM -0800, Mayank Rana wrote:
> To allow dwc PCIe controller based MSI functionality from ECAM pcie
> driver, export dw_pcie_msi_host_init(), dw_pcie_msi_init() and
> dw_pcie_msi_free() APIs. Also move MSI IRQ related initialization code
> into dw_pcie_msi_init() as this code executes before dw_pcie_msi_init()
> API to use with ECAM driver.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  | 14 +++++++
>  2 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..25020a090db8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -250,7 +250,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> -static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> +void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  {
>  	u32 ctrl;
>  
> @@ -263,19 +263,34 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
>  
> -static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> +void dw_pcie_msi_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	u64 msi_target = (u64)pp->msi_data;
> +	u32 ctrl, num_ctrls;
>  
>  	if (!pci_msi_enabled() || !pp->has_msi_ctrl)
>  		return;
>  
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	/* Initialize IRQ Status array */
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +				    pp->irq_mask[ctrl]);
> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +				    ~0);
> +	}
> +
>  	/* Program the msi_data */
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
>  
>  static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
>  {
> @@ -317,7 +332,7 @@ static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> -static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
> @@ -391,6 +406,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_msi_host_init);
>  
>  static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  {
> @@ -802,7 +818,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	u32 val, ctrl, num_ctrls;
> +	u32 val;
>  	int ret;
>  
>  	/*
> @@ -813,20 +829,6 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_setup(pci);
>  
> -	if (pp->has_msi_ctrl) {
> -		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -
> -		/* Initialize IRQ Status array */
> -		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
> -					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -					    pp->irq_mask[ctrl]);
> -			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
> -					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -					    ~0);
> -		}
> -	}
> -
>  	dw_pcie_msi_init(pp);
>  
>  	/* Setup RC BARs */
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..ef748d82c663 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -679,6 +679,9 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
> +void dw_pcie_msi_init(struct dw_pcie_rp *pp);
> +int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
> +void dw_pcie_free_msi(struct dw_pcie_rp *pp);
>  int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
>  int dw_pcie_host_init(struct dw_pcie_rp *pp);
>  void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
> @@ -691,6 +694,17 @@ static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  	return IRQ_NONE;
>  }
>  
> +static void dw_pcie_msi_init(struct dw_pcie_rp *pp)

Missing 'inline' here and below?

- Mani

> +{ }
> +
> +static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +{
> +	return -ENODEV;
> +}
> +
> +static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> +{ }
> +
>  static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  {
>  	return 0;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

