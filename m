Return-Path: <linux-pci+bounces-26812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7CAA9DC42
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730C3923EA5
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005202BD04;
	Sat, 26 Apr 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9khOaym"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D56FC5
	for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685444; cv=none; b=RcX4uwieMyR3FsEyS0DlJQd+UI2g3zcgvK2eC3feUV9P66xbXDI5hMh12lD+ppXYqugoVj4YylaOfUpl4CL60iKUKNm7mWY6Fgl6JI6TqbnszuDkm5enFaiCzjXrCsge9Rl7x8bHGpHS+rXBv1rMnFUYS4pAdIFMFBA4j9BKFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685444; c=relaxed/simple;
	bh=AQLvDcFu0u5hojHsdQsk5RQUNk8ss7dPl24bi1LvOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrCgZHM1D+akmk7XSPf+7vWiIUa5Avi3bueiYESX0+33p7BdAVT4yrCpy/q14Vhku9NhvWMtpSxVq6PdK9/17AWGGv7cW/kMMJVIiaMCRUZcjqun77AV4Ly/0rrFrqqem1KLdT0X7oPXzsMT8k+epfJOn7oTiyTyYZh45DBhOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9khOaym; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so4639075a91.3
        for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745685442; x=1746290242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBO+yo8qtG1t8OuviuDRDUOzweQIXzPrJJJJLil9oPU=;
        b=a9khOaymPtEAmk7V8A/e5LvSiQOKmcsAilpc0jVTc2Pf4D51N6z9/0PqwTlUu8K85+
         9Y0eXLLNddxbUNWhhCq+LkR5rdA2s+95iT3707JoV+AqXN8BZ6lN/729rJS5LMai+rQO
         85a+5phJeIGoqitldrLrcrxLkdSGB5pDNHKmK1U5cOv7k+MgiXtAa1rmfWv1pwSOdt2X
         auZKi+ABGJSPv+XVOZRci3j5PFphaShy9B6yIfvWxYhaMY2Hx8pu4DUYVocvykTywfQb
         AKhLHIGP0XGizHIWj8FRXHyrzpB1VlE2MGu+ptJ6RlGGyAMsXIOYi8oh05Yk4ZUyuuSJ
         WvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745685442; x=1746290242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBO+yo8qtG1t8OuviuDRDUOzweQIXzPrJJJJLil9oPU=;
        b=GLghKYmzlSQbzTta5MTIH4ubU2QVU7oRMexNciIKNLboSojq81ACLRUJGo5KalcnmY
         SIy8nFZEF1+hYt9LVl83JwhnywIKaCzDLJvRqJi7YJPdX/l5cF33StNfs0OJgfy3oIRL
         2CdSr6VVdPe30ksdssd11IGxUzfCgIQ1VT67DlSmwr0L4+9Nq7agPIFNiaN5hCVS2vFD
         ktLG2gahevADLkHuUOD9/H7zdN1aclQbr9RTUpHq9l8Xd9kzJFVfQHIik8v/kL+j+EGM
         bA7aRCp0JhLLhyIKPi9UitIr28H/JSnhvLdljnUEdBOcmxQzkMYDSNXJA0MA/LUb8NjV
         3G+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZl/Eg59ejXUrT2ClwLrEBddsSuhOOFP9PyaLjkJtJrzmbcJUHmt8JKNHc3UFEaJ8TpVuKJPgp/8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMU2neD9BOHbK2RvhnMr61EuCyJxlNwHZAaBABlvOv50vXhvR2
	0q7+6nN1KgbRAFb8cXFxx6bVmdCPnRQ0ntUUshNJuYURHP+3iSGN8+askQ5sfg==
X-Gm-Gg: ASbGnctGJUep4AtOfrPp56B6Z3kwJoqPjJkFYqfdDUFs90jvwDMEHLd3oyDBoXiuoAk
	BBTl8hZy06Q+skuXMEOh79faTjsELxqzKLLd7Ntlh5k45UtVz7WIGCfgJq1Ix+mUom2EzW6CNbQ
	FQ0TN2bO8C/8zRw7C+bVTJFQy70kNbhs6Btj6DEQElmOze2KyCL2Z9Vla5DFJFu4zXslMyRo6/y
	hP5c08AskQjKUPuEnpYXPg7GfU7cW9uZIbBi0Z3t/QGpSfGFkLYg654jTZzpKeOUPrZYSpBj0fZ
	S6rG1/5H5dDsZUccw00YfNKrqsTGj3u0Ttob/3F/zU2fC1o8qcc2v2xdAUbcnY8=
X-Google-Smtp-Source: AGHT+IFXKMHWf1SVJasg0DZUo4ESWUazBYbWUy8Iz3f3K02XzQJmHwLbqw703263vdImT6mLuKRF2g==
X-Received: by 2002:a17:90b:57c8:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-309f7dfddc6mr9788329a91.15.1745685442491;
        Sat, 26 Apr 2025 09:37:22 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097fa5sm5580351a91.23.2025.04.26.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:37:22 -0700 (PDT)
Date: Sat, 26 Apr 2025 22:07:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PCI: dw-rockchip: Enable L0S capability
Message-ID: <zrgc3s7lb2zrcjlfirf3lvldslxhc4khu2xkxdhtixowhspyla@krzj4rl46kez>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
 <1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com>

On Thu, Apr 17, 2025 at 08:35:10AM +0800, Shawn Lin wrote:
> L0S capability isn't enabled on all SoCs by default, so enabling it
> in order to make ASPM L0S work on Rockchip platforms. We have been
> testing it for quite a long time and found the default FTS number
> provided by DWC core doesn't work stable and make LTSSM switch between
> L0S and Recovery, leading to long exit latency, even fail to link
> sometimes. So override it to the max 255 which seems work fine under test
> for both PHYs used by Rockchip platforms.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> 
> Changes in v4:
> - Add Niklas's review tag
> 
> Changes in v3:
> - Add rockchip_pcie_enable_l0s() and called from .init()
> 
> Changes in v2:
> - Move n_fts to probe function
> - rewrite the commit message
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 21dc99c..e4519c0 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -182,6 +182,21 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> +{
> +	u32 cap, lnkcap;
> +
> +	/* Enable L0S capability for all SoCs */
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	if (cap) {
> +		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static int rockchip_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> @@ -231,6 +246,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>  
> +	rockchip_pcie_enable_l0s(pci);
> +
>  	return 0;
>  }
>  
> @@ -271,6 +288,8 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
> +	rockchip_pcie_enable_l0s(pci);
> +
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  };
> @@ -599,6 +618,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	rockchip->pci.ops = &dw_pcie_ops;
>  	rockchip->data = data;
>  
> +	/* Default N_FTS value (210) is broken, override it to 255 */
> +	rockchip->pci.n_fts[0] = 255; /* Gen1 */
> +	rockchip->pci.n_fts[1] = 255; /* Gen2+ */
> +
>  	ret = rockchip_pcie_resource_get(pdev, rockchip);
>  	if (ret)
>  		return ret;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

