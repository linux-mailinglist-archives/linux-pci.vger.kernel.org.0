Return-Path: <linux-pci+bounces-21745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAFA3A063
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8773BC163
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964226A0D2;
	Tue, 18 Feb 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5npafFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB00286A1
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889696; cv=none; b=dTLabZqdemxeAY52d/f3Xh+DgxNXD60+N3REbVTp4WaQa+YJrFZx+S8eY9yHY5oZSbsOzsjyJ1dXbsgb4OMkNxKKn3J01iSNjPMAPqHEkkYzctJkOpgcH7TazVK9FqTyr/J2EVBLyrDts8J3lwY5NcxQ89bLW/WaGd9r7N/V/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889696; c=relaxed/simple;
	bh=lVC//oaIfvl6lsPznOhO049G/mRIeHfCQD1Y85ErtNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4ftKyfZD1Bn4AiB2VY+KnEx+zbMDVNnQ3HrbCHWrF9/vz4V+eN2BLLfroL0kwQqz61gVb8C4WF3J6KIPAaHaY+bY4OdHAED2iPXKm5Fi417zgZShxQe2yToWuFMCcrwZvQtg/LmT9OvgXoJrlW+j/YyysTeuimbY/gwycAU6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5npafFq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so113549335ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739889694; x=1740494494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=821eXPtnueOz/5A0gi+hS+KRWbjzmoLShlhzccBLQOg=;
        b=T5npafFqQYl1uySwWFumN/yGefLcMSStj6gPF35nhj+DpnbFQ/4hUTGbfCT0fM722e
         8omP2MSenKk71UGHQczM9/cgGuOe73seNSi3UHCnsUXN7NOrQgZO9yoM/2alWAqqM/Xr
         tmwp+4zi9ZJPlpnXsQOX6HGnPBQ2FK8u3PTQSQjm6Yp19vaAAtRbUjGl1hLy61PjKyDY
         halCQXyGU9IBlDpLFRlrGhs5T+TSpWQ9itZ1cQryblHTwQ8rG4jE4vUc+vuR3ODUdzfq
         Iq7PEjaookz2rpE544MSqdMS+NPSvjwD+1if//+qxKE1V53eAoXjsFw//BC4nYz6mYaN
         yj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889694; x=1740494494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=821eXPtnueOz/5A0gi+hS+KRWbjzmoLShlhzccBLQOg=;
        b=dNkZbQ/jze9HobEqU8+5Re4w9sOR61vVISLZDID/rsibl0k2oGHKbtTCzITRFyrFP0
         BZ/70tjbhNHKz6hhKJd6N0dduRA+OyOtTHayVTjbc0DKm3Xr5tXNiPc39SSUgZiICygh
         xRD+CxpikeaOFoMzGukbrzKKsvCcbnDa8dauqZzLk6jm5ScowbWTTDORkbhkgbc6hBb5
         iqvYXHUcQPyCLUMqZlg6lSBxIES/Z93ycHQhoWJGQ/OSSF78BB1V5xQvsAdjUgn8RMFS
         oR74m+ZjTmazKFALqQUEU77nVs7S/Hmf1OUvZLmgg8npdUNV/E09iGBPL+w8S5x35zCM
         8Q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt8tgtmtQFrRxaAAC0yGhEOH8hCaeOVkcYLBdcCssx3D7wu0g/KHg9lglqbkTjHAy1yiAroOt70FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tQCdfK3byW5icHTqWTo+9tnBdS5xxrN0F+Vfs6zNzs+mi+SH
	cmklO2QjDG+jbjfI8/l/qeYyryPoQpBxynC0ONUjYwiZybMrDK5jxOn2LaLk2Q==
X-Gm-Gg: ASbGncsQv4bLq3fS4p6bqRa07cskfObndmpMVwKBQ9oR8339aqPUgVoQd72hthN6k10
	ly205Un4+SrZ615M7x2g1z9qJ9As9gxWjueTjge8/isXDA4UdY+UNtqFWjCUq95srT9NoSS1qV7
	B1DjApbJSJebKuc0spQY4Xsrc+Bi3Wfw2SiziESPJnJVCXOoMnB3047TCy42gf63Te2/O+AdkSp
	dajM0onwOVYFcSOke3Hcd6bBgL9HxYdbOg7PRxsN5se4m96N7rtgoe0DUb1/uU9PpHheoQLRIun
	4GH5FT1MIYvYQwk7uyApvNtaOcU=
X-Google-Smtp-Source: AGHT+IH0JkhadLczcJSuFXXlAkhuVkxnff47A1GKB/6+c1aeO34seCTwYCrmBfEVuu+T8wBsuXlG1g==
X-Received: by 2002:a17:903:92:b0:220:c4f0:4ed9 with SMTP id d9443c01a7336-221040d6a62mr153962185ad.45.1739889693718;
        Tue, 18 Feb 2025 06:41:33 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5870e862sm9288410a12.44.2025.02.18.06.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:41:33 -0800 (PST)
Date: Tue, 18 Feb 2025 20:11:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 1/4] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250218144126.5kapvjj4e64bamvi@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889@epcas5p3.samsung.com>
 <20250214105007.97582-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214105007.97582-2-shradha.t@samsung.com>

On Fri, Feb 14, 2025 at 04:20:04PM +0530, Shradha Todi wrote:
> Add vendor specific extended configuration space capability search API
> using struct dw_pcie pointer for DW controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

I took this patch and modified to pass the 'struct dwc_pcie_vsec_id' to the API
to simplify the callers:
https://lore.kernel.org/linux-pci/20250218-pcie-qcom-ptm-v1-2-16d7e480d73e@linaro.org

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 19 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c..3588197ba2d7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -277,6 +277,25 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id, u16 vsec_cap)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
> +		return 0;
> +
> +	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +					PCI_EXT_CAP_ID_VNDR))) {
> +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> +
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  {
>  	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..02e94bd9b042 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -476,6 +476,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id, u16 vsec_cap);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

