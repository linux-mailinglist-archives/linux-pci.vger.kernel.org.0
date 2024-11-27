Return-Path: <linux-pci+bounces-17392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67DE9DA2DB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E3C282BE0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AE13CA95;
	Wed, 27 Nov 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coKRJxBn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926B81AD7
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691482; cv=none; b=bZ9Ql0r2YsW50Zn4nrTk+0n5UqCT+ywd7BS1aOThTvpdsGJ7ozvMcLsCJBUNK6ZnJVSZmQbHjWsa4vnX1GXTyaxzEKyIVtM06Cqrr3FXGgbFqywkje+roD9rdy9Sabf/hWsfzUvZLdsJ2EFMDko3OtsDOqqUIuyY2ZxLA+vF3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691482; c=relaxed/simple;
	bh=ivD7UxwWzG9dtXLJztiv9rqXpp5ouDj8Aug17VwaOzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C351txrHNERH2Km3za2jzFmyMOllCZ6PVIqzp6d+j6Xl81TgGpvchSFA4QE2y5gTdNNr5ml55e8OxeSHZlUtWZWsRGohMQ2Zw8dkIlpTzW+1Y79+aqnJ6ieLEE+FHyWULSDmU6hDJcuf6Ar1BUjnpSnFBkpWm1DXqSDcbHoArZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coKRJxBn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea9739647bso5081198a12.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732691479; x=1733296279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=daucoQGB4DoiUc17NmB3Dj2YlWLcbKbA0esHUojRdTc=;
        b=coKRJxBn70LKoPvHKW6gR8rv7hT6QLF+pGrRHDI63MHwDVSAFp2IDlvJOg/qFt4AD2
         OQO9Tzb8x+59EJtFhGYcNbdC8d5OT6jQOUTYYe44UL5EZsoq7/h9tcD1mbGmOIDgmIsi
         BLlEm5eJLYujB9U1mZMwroltiyOuFU+6vDHj/417yyeGPZSGkmweMQBidiVsDw599h0z
         OJ/nF+6sCfnUFRWnrwxecPlDmTqvPSb17lqUSTsoM2IPspENVxRgnnYcAVvbI+Mb691M
         iXvUk4iXXGOOamUqEEq4Vpk/BOBxJla25W2LBPKOZkgJ2L7oPZAz7FYElrxrVqFwh2o8
         oYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691479; x=1733296279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daucoQGB4DoiUc17NmB3Dj2YlWLcbKbA0esHUojRdTc=;
        b=SOXaiw8GPcav6yEr1Wt8+lxyCRGul3tKgQWL38Zmt5ii7SyUyGyEBwx4cN1Lj/WxQn
         iqcdIua9uovvpPTlEMgIH8GnGnylcU5/KGD/9g04lwu8w3qj9y1tYDYduwzABqIt3807
         7J23JB2VGs1W5QJn6LkkDUNsFjVrS1c20gl/xx+ijyTV3C+w8KAYjjDPzlGqyuGy/SuR
         iWeX4LiO6WGDTSqtWMOF+lgcBDY/GxwUP3dfgR+lHlPfjJSBQ3eAQWc72w9RNQzU0KZO
         RQwAbRI+5S6GgznfsOIHGo22c/MC05qiYab16FXN8LkGAN1gjNCmWUgxDY8ZqkKZHpzG
         NJnw==
X-Forwarded-Encrypted: i=1; AJvYcCX+sVJGltNyhoJHOFgKsGm5sBp5gkmOCJfgOeEI31lvVW/XHpZykkXcVUCjPNBE5DKqludC4g3Km0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1cM9gDljqvAS3pCfSShGUOs32zleJW33rZnBoGzzYtCdKGC+
	6cQwuScS9tZXAJMKhgkZVt1lA5uyfTGZy0yR9OWund3xaaCqxuNjVnDY/a3EXQ==
X-Gm-Gg: ASbGncuVPLxKYEYH76wbqbK5OzIwJVM2d9CuUqyLKzaz/+CIDUJKpRFnc+h2hCFZhhx
	XmQPrvXx33fsXW6MQ/0as/sKmj8e6McUhoqJUPYYioRGE0nuHc3Kb+MT+cyG5zZuUakcomwQI+F
	+vgV8tffVi1o7kUAnHn327CU0o4MNTa7BTDAN7RFipSVxBRQRHXoc2MTghXBHdPEUeuY+8xG01j
	p1IJTKAyhr9/93181/rTZbEKWf2Cazs0DdbV1FNMUQD0XSOCVFfu9EBaLAb
X-Google-Smtp-Source: AGHT+IHWy7Q7VFkcxIpfmx2rcCynplO1/ay/qa+iKjMCw6S0AITRT1IKri7UPa0AnYFRng/jE0U0lw==
X-Received: by 2002:a05:6a20:43a9:b0:1dc:e8d:c8f0 with SMTP id adf61e73a8af0-1e0e0b514e8mr3396053637.29.1732691479550;
        Tue, 26 Nov 2024 23:11:19 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b65sm9590341b3a.6.2024.11.26.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:11:19 -0800 (PST)
Date: Wed, 27 Nov 2024 12:41:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] PCI: dwc: ep: Add 'address' alignment to 'size'
 check in dw_pcie_prog_ep_inbound_atu()
Message-ID: <20241127071114.yel2d2aacntdfdi5@thinkpad>
References: <20241122115709.2949703-7-cassel@kernel.org>
 <20241122115709.2949703-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122115709.2949703-9-cassel@kernel.org>

On Fri, Nov 22, 2024 at 12:57:11PM +0100, Niklas Cassel wrote:
> dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
> "BAR Match Mode".
> 
> A memory address returned by e.g. kmalloc() is guaranteed to have natural
> alignment (aligned to the size of the allocation). It is however not
> guaranteed that pci_epc_set_bar() (and thus dw_pcie_prog_ep_inbound_atu())
> is supplied an address that has natural alignment. (An EPF driver can send
> in an arbitrary physical address to pci_epc_set_bar().)
> 
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> Add a check to ensure that the physical address programmed in the iATU is
> aligned to the size of the BAR (BAR_MASK+1), as without this, we can get
> hard to debug errors, as we could write to bits that are read-only (without
> getting a write error), which could cause the iATU to end up redirecting to
> a physical address that is different from the address that we intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++---
>  drivers/pci/controller/dwc/pcie-designware.c    | 5 +++--
>  drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 34d60142ffb5..ff4350e7adb6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -128,7 +128,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  
>  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> -				  dma_addr_t cpu_addr, enum pci_barno bar)
> +				  dma_addr_t cpu_addr, enum pci_barno bar,
> +				  size_t size)
>  {
>  	int ret;
>  	u32 free_win;
> @@ -145,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	}
>  
>  	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> -					  cpu_addr, bar);
> +					  cpu_addr, bar, size);
>  	if (ret < 0) {
>  		dev_err(pci->dev, "Failed to program IB window\n");
>  		return ret;
> @@ -265,7 +266,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	else
>  		type = PCIE_ATU_TYPE_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> +				     size);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c..3c683b6119c3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -597,11 +597,12 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  }
>  
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				int type, u64 cpu_addr, u8 bar)
> +				int type, u64 cpu_addr, u8 bar, size_t size)
>  {
>  	u32 retries, val;
>  
> -	if (!IS_ALIGNED(cpu_addr, pci->region_align))
> +	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
> +	    !IS_ALIGNED(cpu_addr, size))
>  		return -EINVAL;
>  
>  	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..fc0872711672 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -491,7 +491,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				int type, u64 cpu_addr, u8 bar);
> +				int type, u64 cpu_addr, u8 bar, size_t size);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

