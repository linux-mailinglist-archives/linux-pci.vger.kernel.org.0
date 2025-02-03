Return-Path: <linux-pci+bounces-20659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50DA25EA2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88243AAB30
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13446209F45;
	Mon,  3 Feb 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRu0qJIn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3520897B
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596062; cv=none; b=noZ/2l3RYnBNaMP75qDf5OnVHX2FlZmTrBtCGpkVAwFgPx0DlDKfznVYDDbGbusEeK7XlwdjN9HA6+KIZbj6o8klPvXecWjZS3PKGoVOoUHgWIXbv+RxiVnGGZPeqT49t6eUMVOUuyqLb+s1RUHxwzG8AjOHyo4M/Wra2YVLNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596062; c=relaxed/simple;
	bh=1pk/fGGnQgOxwIyL078JGo17yd4G/o1v6YPLxHS7VdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZnEbQPKwXPJKzOz4vT9eKIopvmkcR6jNWzRu5YeeKzzKunT+MAeztp2+pGx9PsBW1t8gOPgPmjnmKfvejw2F4GJcZas9Y9JQY6y1lsVYVqCgULWh5MwVoWVKeg1MSb1UuPpacc5cVvI4NkY6kL924IKMBDieni06MfAzy9p9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRu0qJIn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216634dd574so52609045ad.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 07:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738596058; x=1739200858; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QBWhANjAr1OtmbGA6f8TwWPn8UUhnW9g2jYfFPH9TA=;
        b=qRu0qJInPUmAHKzq3a5kBOKBjuVaPMA58FwgGmx30Jcu3Xn7043NpDz1x+Y2aHVIgR
         LxenLOKt6YAHkkyJWmsdS0hRHlUJESCLgN0k4muZfsB3ZEaLmE2+jbGsg8xJwHn3mJTX
         TloHMjaUwuwvxpRqyJlv3MVqHf2zgvbWfGej4KAUciwZnJhCh3fhs+0Y6fkiSFGpuMbj
         9NI3T7oy99sXsZ3AFKRJ5lknnV6UXXHRRKKqEgo++oQsvmoEOcSKRTPQzXNk2DXduIH9
         fioz7lJgubcNAnYF79eEZwZcLoEn8T9oihPUh8ce7kGjtGLsIJWe/FZG1VOjvaCO6DFG
         u1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596058; x=1739200858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QBWhANjAr1OtmbGA6f8TwWPn8UUhnW9g2jYfFPH9TA=;
        b=lUVg08kgEnq3dPLupRaExefN8OetWPArPROMxmbGLioIblzpWTmI56lUH335GIGkZH
         lvdVPQ4G+CeQvah+p5cYNPGRwKqwHuYSoakqShL6tY241bm+e+hEgZnJUKcgOBeehTvG
         p85qXOfGk9EAfJndeMomu6beYhUR0jiY1EeEGRQdg8Exytq5HJY/81luF9BK33/wodqQ
         4YmXFL4XlqeFF2PkuEdYZjIekaClUFtVpxVXTyfFFjcADenhwzSBWXOxJ9NpXcSxPLU5
         xG3inCvzkC+pdkaYT6BFafDBGEOoyUhCaE0PwqdcKepigORt/Q6KHgijVrXlwPpC37+7
         1SHg==
X-Forwarded-Encrypted: i=1; AJvYcCXDeTltwYLr5T/M4fsTO5CZX157g4EWkGbXy9566mbnaLCFexdW5xvGs5VIuHwA5EpA2P0M7vpcrfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GQseBtpfgjRsDNaz+OKhS6sR9J84T9OKjKgu+US4icXo9F0W
	hMg/XhxdW9YsIgOKyV0U0Eps9D+8VBoOPgNiX/a3sYLrzAZLz2STTsvkD9rEEw==
X-Gm-Gg: ASbGncsDHaBglIPJG1DOzPxCNLpfLh4xdw3/dCFUNhg+15vgNdYqS2GmN9ULMBYJi4x
	XQ0+w9BKSusN/QbHKRvOoKSCXDVT3Imfq5pvj0SDMkhJdjoDUgQQAPXJXdpkOGGADjHJ3zpfxNu
	nKhc+1eYo+K3numoTes6/ZM/gyhvF/tjm5XfbgA1FkVDoimuUfE9oCjS8pwOQzSZSMLi4c1tKxW
	/c2QDd5AxKZ5SnGThj525rixA+pCNoireFNxUOycydFdPqm2HcDj2rAnwsOvOhCab92+hHr5ndt
	9kIaz6jFoVe2xJ6wbbADwFbEUA==
X-Google-Smtp-Source: AGHT+IGSJSMOvMrFBAciSyZK7WnnknN8UNArG9prlqW7rQYL/0HyxOSeul8ibO5cwBLiZ/VXl0y4dw==
X-Received: by 2002:a17:903:23c5:b0:216:30f9:93d4 with SMTP id d9443c01a7336-21dd7c55e5cmr196882845ad.8.1738596058155;
        Mon, 03 Feb 2025 07:20:58 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3306012sm77356935ad.179.2025.02.03.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:20:57 -0800 (PST)
Date: Mon, 3 Feb 2025 20:50:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Message-ID: <20250203152052.kwbmt6bhjzv55ddk@thinkpad>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
 <20250124-preset_v2-v4-3-0b512cad08e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124-preset_v2-v4-3-0b512cad08e1@oss.qualcomm.com>

On Fri, Jan 24, 2025 at 04:52:49PM +0530, Krishna Chaitanya Chundru wrote:
> Currently even if the number of lanes hardware supports is equal to
> the number lanes provided in the devicetree, the driver is trying to
> configure again the maximum number of lanes which is not needed.
> 
> Update number of lanes only when it is not equal to hardware capability.
> 
> And also if the num-lanes property is not present in the devicetree
> update the num_lanes with the maximum hardware supports.
> 
> Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
> width the hardware supports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
>  drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..2cd0acbf9e18 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	if (pci->num_lanes < 1)
> +		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c..acb2a963ae1a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -736,6 +736,16 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  
>  }
>  
> +int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
> +{
> +	u32 lnkcap;
> +	u8 cap;
> +
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
> +}
> +
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
>  	u32 lnkcap, lwsc, plc;
> @@ -1069,6 +1079,7 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
>  
>  void dw_pcie_setup(struct dw_pcie *pci)
>  {
> +	int num_lanes = dw_pcie_link_get_max_link_width(pci);
>  	u32 val;
>  
>  	dw_pcie_link_set_max_speed(pci);
> @@ -1102,5 +1113,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	val |= PORT_LINK_DLL_LINK_EN;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
> -	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> +	if (num_lanes != pci->num_lanes)

Move this check inside dw_pcie_link_set_max_link_width() where we are already
checking for !num_lanes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

