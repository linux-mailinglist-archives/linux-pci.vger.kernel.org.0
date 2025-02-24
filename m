Return-Path: <linux-pci+bounces-22167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19179A416E5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B4E17065B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E1241689;
	Mon, 24 Feb 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJRF8M03"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06D1D90DF
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384414; cv=none; b=VRz/wNj8Lx2h4x4PhYTts0SCgJepMCbEDAwoKO1MwQO/QRQ8E1LyCg0lQGoPkQF1zqlnRShpnRPgJPIxRYndXQlEfvUAE6K2uodP3+2zaCTtH7iM9MIbOqRFjB4N7zLmMTF+pNZUEiyYXx8khvgt/sPHLG+bwdqWpJr09ISh5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384414; c=relaxed/simple;
	bh=rX0kr9FoxMFMj5Li+t2NvDWyaIZeQGbAJTkHmyg8qjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EevY7dEYbyC1WQ/OBhKOpC/pc5BgZv1hHpTEM/UAQjyoBAf3QIpXSNtVXf52WA3LFBYRrePzeZiJn9UnYYEb0+E7Kirn7hYdLEuP3T7X7ttkSt6zXubqcFqiqslB4p2wgGzMEEUd9pZE/bE1T+EUrwcGhLEoefdYgPTi31a4PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJRF8M03; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ecbdb4c2so110897835ad.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384411; x=1740989211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8q33JjqIID2gxUPanrFtnNDEQuq+2F7BIt1N3kOUDpQ=;
        b=BJRF8M03GsVSZ4MjbTBRmIVkLPw+RhoikPAaCEG/9E7eAvyMuS8bz9cxn/pUqwwGRq
         c4vuehZDfIKkFn7PdkLqvAo2uIwf/0GsmFbGqp2YzuSLWdp1GG6H35Oebc05llo4GmgX
         fEVtd8x27ehPJKZzuL1IXio3uCWrZdAwwc4Qd5uDMHfpyZwm6z4iR2WNXAAUQAGmXlSu
         C/oZLqN5sueRX5ju5zuP39Jwi+dGawEWt2yBzTu55kUo+gApt8IjQRly3iBA3diAWUY1
         QX/gL+GXAotip2XRMa7tmjJchXZ6vTeuiDeiHr0+HqzQ8qNDEFow0VPc9WzD4GFIaYeC
         CsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384411; x=1740989211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q33JjqIID2gxUPanrFtnNDEQuq+2F7BIt1N3kOUDpQ=;
        b=oHXbQutumq76W7XK6Pm8kf9hYvFTiWMkDwwTG5wIHcd/bhE1sVVHTBDM1BVgNpMsWg
         AQ9n3Nzp7qP5eerjViougDyNBK2OFfbYnsGAqhe218ekLYq1NmKF7ruWrFlpSQ+sMI4B
         gxNAxK3Fw+w6ZQkwBkkBOSPvHfRD1DWtGchdr81TjpU0Rlgn34e7duY0KeXGz6fhW7Kx
         mIHRbimUaiSqoOw0lK2pUmHrYbvbjSwiW6EvHm5WfNFIQy92Kup1041xrdaoN56PK9TV
         a55BFRyWzUvzVIg3JV0pBbs2wuCw/IC4nrzdBeI+Eff/kJPDsx9/P5gA1z0Dt8uwJ2WU
         UB0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7NvqxIDHWodjPYhNvAiFuxY43MsxqjnbPDmzd9Ud4OGiNNfNCrTa4xlrpK3knPg3M+O50dilDaXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzZZRZs7jPwbEMHCxY/CU7CVfNeMXedl8PaOHQwRv1RtMYuUn
	oH+vNQx8B71D8G3IUFqtaVy25Gi0KdJXsSGtEw7cGMcvzuD8qsifMwPQRJx12g==
X-Gm-Gg: ASbGnctJaRyp+LBNmi3SyeS9/+/rwWbhiPClD/AfSjalR4dbwBmy+fAYGmuMkwje7MN
	RHJt1cUQAtGKSJ+ROdCiHWT/z0k54jsMIknVHDt6RwgKfXXSbXizpnXtyR/l7I6c998vqcXtPpL
	VyvHHGKv7sVa6r9QnndseKwJF1rlMV4Q3FlzZ1NO/jZp9gxE6HDUJMwQ2kxPlwycx3H/W6/NW0X
	z6B1/D76PfLjQFmpwTMvm5RxfM26FagRdHJ+4xLWqpeSanYnmNzJZCurhDNRW4KNCeqx00znfL1
	q/wFybAaiJubUSMaZqnuvgoYpLilGGCQfk8V
X-Google-Smtp-Source: AGHT+IET6pCBDcr0viuI6ieEFwCQCFyPovYrU/eJqP+MyvqJc2aeSgcyD79kTf8ygnfu6RR2t6/OwA==
X-Received: by 2002:a17:902:e88d:b0:21d:dfae:300b with SMTP id d9443c01a7336-221a0ec46ffmr204596825ad.10.1740384410819;
        Mon, 24 Feb 2025 00:06:50 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596115sm175105635ad.258.2025.02.24.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:06:50 -0800 (PST)
Date: Mon, 24 Feb 2025 13:36:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250224080644.ldgltonirrtfzrgp@thinkpad>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
 <20250224074143.767442-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224074143.767442-3-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 01:11:43PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. INTx interrupt support is not available.
> 
> Currently in this commit platform specific Bridge errors support is not
> added.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below which is not related to *this* patch, but should be fixed
separately (ideally before this patch).

> ---
> Changes in v2:
> - Update commit message.
> Changes in v3:
> - Address review comments.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 40 +++++++++++++++++-------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..a0815c5010d9 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -84,6 +84,7 @@ enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
>  	CPM5_HOST1,
> +	CPM5NC_HOST,
>  };
>  
>  /**
> @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
>  
> +	if (variant->version != CPM5NC_HOST)
> +		return;
> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -578,16 +582,18 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  
>  	port->dev = dev;
>  
> -	err = xilinx_cpm_pcie_init_irq_domain(port);
> -	if (err)
> -		return err;
> +	port->variant = of_device_get_match_data(dev);
> +
> +	if (port->variant->version != CPM5NC_HOST) {
> +		err = xilinx_cpm_pcie_init_irq_domain(port);
> +		if (err)
> +			return err;
> +	}
>  
>  	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>  	if (!bus)
>  		return -ENODEV;

Here, xilinx_cpm_free_irq_domains() should be called in the error path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

