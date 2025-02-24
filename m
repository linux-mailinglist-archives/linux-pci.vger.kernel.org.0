Return-Path: <linux-pci+bounces-22156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD2A415FF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0335716F183
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B01240608;
	Mon, 24 Feb 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1qumtSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D620B20A
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380934; cv=none; b=uIQ+7QnxCzsMTY7E32eRDLWLZ46TjwH1djvpk3ZTh1qV0RYaIPm08m/JpZsqibPFuZF0aIK+VR0zEn5u6czWRzjbfRO1Z7IZngDuTFTWNs6SFU+0IYRPw+Cc3tiDjc45DIKz3eAvN/a63TQvtQ0+Ujz1fDkZogF3K+sDIitbGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380934; c=relaxed/simple;
	bh=MkwbQ9LZo/6/lhuFfrtyiseDQAS/lGEZIPN9WcJGNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSW6+7r6i1YGE6eKU5TellWZR8sog/bBY/tI3Lks2mq4uHMDaSde/V6vOUHjsppSb/df2JDHz1JOfZHVwlbGLP/6O70jS69CHSVz1ySvhwZ21n1FUXWnIYW9exoMdDJ/fERDDlQ7gOPKXlDslOsEv/I4KdBYKYHgv2Pf+MiPEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1qumtSW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e6028214so84488275ad.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 23:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740380931; x=1740985731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0f/tMLiJYULZsRTUCEOnqKZM46qSBJY24xovvsvnuI=;
        b=k1qumtSW9obQQB0YMLHpSu1ds+oEQ7qufETEPGNO+AZ6Wk85LPXXDE2YirNvCaLoJk
         4949arjpZXuttWVITj9l0iErfq1noGg0QbrqBOjJuFvbJa2bj7iImt46eCxb7wr7DG4q
         V+YfAfh7zFT6mWip3cJm8aq9tdCWEV+OABRkKwzYOsWz1FxV5TuFcLlsSiJvXJufPPpn
         4TcS8YJz4/myEc15Tq6qiZ85G4wjlX8ZY5SQf87SiepswGUF1hdufoXARzbFqVmysYdX
         S/9gu19X2HxXtOgVqs8lH6KGJ06jGJp7Up8rMtk3oBLbJ1Lh7RzE+1bZKZoV+yCtBQhQ
         Gr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380931; x=1740985731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0f/tMLiJYULZsRTUCEOnqKZM46qSBJY24xovvsvnuI=;
        b=SieSgWaShZwPeJn944eGYr63PSe/ntp1e4qylrWf679IXdA4N3ET9xQjnZvGSCcbyJ
         02QA7bLWYvdmYbMOsQyEifqg/XB334Ra2JLsDlxf/Zc/MFrFSIsihYmzrFIL+28wqm46
         BxI8cIzrb34c7Iszykx/zcumdzkdtWc0s1Tb1ok4TbCdEo4dXgO0a1VoX/3O+n1YuFG7
         By/WjKYBNQWMQkvMhG/HIrqhIztPkHyvjQ2FFPJtK2YZc0GKTZw169zHsmk2z+TmVfi8
         oXuUv/gtiWlYD4JcIU/dPv0DcRQ3q4BzkoAw+s2EGB+y+hcEZFFOHaP0TCS4D67o16HL
         4c5g==
X-Forwarded-Encrypted: i=1; AJvYcCXD/DfpcydkJO7HNKoX4u6S5aPI3vxkM/5EqLK9kolKfHEIRQ8UqnlcE0EoT/OPfB6oFBCAxbSdgkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOTKw0krHkIz2m72wRJwWL5nJIlq3PG0bEi3GxCGxBcJJHp+R
	eWIQbIdJwFmGJ5UOq7lTdoWuR2Jvn0No9uyGnQMk9OpGOlfjerTM+MWreTp+Nw==
X-Gm-Gg: ASbGncslEl0WBHQXgAKgiVH9HyXoGRqWAfY7Wp5gsB/ejfbrfhWOFvxiKT9380t31JD
	tyT8TttdMq8YaYGScQIz5fQaoPfTHKV9TH9wfEGQmQA8TGLvH9o83sihd8b0fZ3z43hYMW/LsjY
	cascS0x9OQKwB9mYljtnp76CyJnqai48jzQ3rwtpj+4c5iKFhtySyRKxPfxtsFquzDaElc7F/Un
	Le5vdhPBoe3LcpRPQRmf3n0t7AZmPJhqkBsjt6LlyXTjRwSDUX7XOC0KZ4uAziYjmpLkwaaymae
	ZnnNh0PxQGDW2/NBTyEyY0DgsAfct+Ve/dob
X-Google-Smtp-Source: AGHT+IGYWVJJjdXNjc0YzDIJ7TnUfz9dHgBceb0HcOaXD4nstU0qRzoNxcUhZBsY8+NGXb55yZoadQ==
X-Received: by 2002:a17:903:2bcb:b0:216:60a3:b3fd with SMTP id d9443c01a7336-2219ff827c2mr185647485ad.3.1740380930797;
        Sun, 23 Feb 2025 23:08:50 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f12sm174698405ad.46.2025.02.23.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:08:50 -0800 (PST)
Date: Mon, 24 Feb 2025 12:38:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250224070845.6ocpyblzxk7cviro@thinkpad>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
 <20250217072713.635643-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217072713.635643-3-thippeswamy.havalige@amd.com>

On Mon, Feb 17, 2025 at 12:57:13PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the

What do you mean by 'Coherency' here? Cache coherency?

> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. Intx interrupt support is not available.

INTx

> 
> Currently in this commit platform specific Bridge errors support is not
> added.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> - Update commit message.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 48 ++++++++++++++++--------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..9b241c665f0a 100644
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
> @@ -493,18 +497,16 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  		   XILINX_CPM_PCIE_REG_IDR);
>  
>  	/*
> -	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> -	 * CPM SLCR block.
> +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to CPM SLCR block.

Spurious change.

>  	 */
>  	writel(variant->ir_misc_value,
>  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>  
> -	if (variant->ir_enable) {
> +	if (variant->ir_enable)
>  		writel(XILINX_CPM_PCIE_IR_LOCAL,
>  		       port->cpm_base + variant->ir_enable);
> -	}

Same here. You should not do these kind of the cleanups in this patch as this
patch is supposed to add only CPM5NC support.

>  
> -	/* Set Bridge enable bit */
> +		/* Set Bridge enable bit */

Same here.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

