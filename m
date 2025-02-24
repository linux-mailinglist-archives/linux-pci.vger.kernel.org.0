Return-Path: <linux-pci+bounces-22149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8DA41568
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B907C1886A3D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8B1D5ABF;
	Mon, 24 Feb 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0glToU+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70F1AB531
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378814; cv=none; b=tewGbQqM3rVGSaQ5KmYyFNTz72brGUNxds9IqnZCWY3js2o1fHRc8b+m44+sTGsoQRPPOJlqDXFnC9pbLD8R6up8gnzilno4O6CjojlKgWxAGmX6aA9QjcYOe/rY9DNIx5QmMEsqUJppzQqy1y4uB57ZtnOA85IUOIPet7LtSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378814; c=relaxed/simple;
	bh=qE5Ooj/sRtrynocI5AMkTQZwp1X0muUARYAtXHlt/WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6I7cFvAOxK//2WcUncKOURW1LS0qu8DXvLKrj2f5HVqVnt0crxaSuKhvmvTESMumgwu0+eogk5by8xnQhB7E1I+ASht48mJ0dxwXAllJJszo5Hc5M9AqGHbFFdqp30W/TvQPMxJZX8i3povAcmz9Vy7/hH6ALf+J4Nosx88oTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0glToU+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so6230268a91.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 22:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740378812; x=1740983612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iqkad0gQXVEGWERnspJWUKhGckXkl0GYwi/NHjWdAHc=;
        b=t0glToU+I8W06Sk881ZEOClYi2eWve3caSbRSvwQDUt1RLvjVib9AyAgEKkr1HWqZP
         kAVmoMPEKfT4EsPHuCyJBmtkMOK0jc2gRs/E7TPfNCmpv31q3XULAvGPWst4kIOdljU2
         5e3GD1WklY9BfWDUHYpzTlPu5pk4WnMZaUR38O6FDvP0NzfXtAHNQJvjcw7liaHSFzWW
         X3VebADic2CtrQ6lHblXNu4g+I8PFLYvJr3+9kpw/QslrhWmHSlgzuvCXqz+mytALOU8
         URlJV8ErUYbQOGGxXTiWa90j0/JTpxsqR6UnjXwOHNxQdgrDIIKOuMjxvfZYKz1W1kON
         oVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378812; x=1740983612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqkad0gQXVEGWERnspJWUKhGckXkl0GYwi/NHjWdAHc=;
        b=hmwdurMDNrgtBcYOASNQ4Wv++fClWJ9p7OYbAot1f2CP7Kva3RsBIzGDjHUxjv+JNh
         zQOVcAzC9OPLJjLkQxwt5ihaavq2s0l0ubJ2efESojotv2t+KxKEsTYVI7I5uPwL94ST
         2ZoS8Il4pBR7lgCm66NVAlKwltLuoEePCGosiclJdNHIHgC8J5yoC18Olax9gkB4uVer
         v+3HSqPA+Afghsgi+HYEoPa+oq8C+dd5FjOe4I7Ybm3HVMO0su0AxNSbZouf6+JiHxsK
         O+TYV7l0qAWsvsDunV82WNHhe2JO3i/eNWRtWhnPpLimpESnIG7TVqzWqoEMTKqmCL/k
         hApA==
X-Forwarded-Encrypted: i=1; AJvYcCW3FDYDbSp2qdMe08kaJAo0jnQTvMnxj8/pf+SWtXO8RiJCBOASkmej9emY8Eu2MfrnXF1bzL7V2Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAWETkd7UPdIp4DEdeXeA0uf/ifZZkqxvTj8Z+4aMQGq+8pFG
	U5wIuOgtLTVEo52ARSzEzIxqyX/uPkfbwjlU2yCfNEfPXw/UZs6euaht2BVryQ==
X-Gm-Gg: ASbGncs3TcvZ6rBn3enUDYhcCaJU9BhubqkbFwBIaijSAfgvAHhqrHhYT8uF+5YgkjX
	U8RhDbWetRMvHs4mlGeUIOBr+NTYRYieKyrGScnYvJ20SjKZaiOLQ2puqc0hyJVnwHZobYjMG8r
	R1pbf8ZTwXntTqO1k/BuLsrS+ZAAFwRB1hM0y/yxWXQ4owN85pXtDZkwrCiaDVcOyOxCKCybJk4
	2ppXMtdnHGF4ZFoGD3zOXLGgxm9Zm83lEBaZH4joODy/hoRqHd20rxMlp3Ko2hoycNszfk55gfz
	zYfTNsQbaKnc59qnpmhQaODVzhTDqmSb8xm/
X-Google-Smtp-Source: AGHT+IEbRSe+OEOIF/Hwj1HtvuPcYE9SBc3HpXkK2iXWXr8X/DXMyLtMpCTDK0xPCr8xvjSxPvok1A==
X-Received: by 2002:a17:90b:35ce:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2fce78ad9ddmr19817303a91.20.1740378812014;
        Sun, 23 Feb 2025 22:33:32 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb12dc27sm5798212a91.45.2025.02.23.22.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 22:33:31 -0800 (PST)
Date: Mon, 24 Feb 2025 12:03:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	matthew.gerlach@altera.com, peter.colberg@altera.com
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: altera: Add binding for Agilex
Message-ID: <20250224063326.kbuknwwhx5kyhgad@thinkpad>
References: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>
 <20250221170452.875419-2-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221170452.875419-2-matthew.gerlach@linux.intel.com>

On Fri, Feb 21, 2025 at 11:04:51AM -0600, Matthew Gerlach wrote:
> Add the compatible bindings for the three variants of Agilex
> PCIe Hard IP.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v8:
>  - Removed patches unrelated to Agilex PCIe root port support from set.
>  - Removed patches related to a specific FPGA configuration from set.
> ---
>  .../devicetree/bindings/pci/altr,pcie-root-port.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> index 52533fccc134..1f93120d8eef 100644
> --- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -12,9 +12,19 @@ maintainers:
>  
>  properties:
>    compatible:
> +    description: Each family of socfpga has its own implementation
> +      of the pci controller. altr,pcie-root-port-1.0 is used for the Cyclone5
> +      family of chips. The Stratix10 family of chips is supported
> +      by altr,pcie-root-port-2.0. The Agilex family of chips has
> +      three, non-register compatible, variants of PCIe Hard IP referred to as
> +      the f-tile, p-tile, and r-tile, depending on the specific chip instance.
> +
>      enum:
>        - altr,pcie-root-port-1.0
>        - altr,pcie-root-port-2.0
> +      - altr,pcie-root-port-3.0-f-tile
> +      - altr,pcie-root-port-3.0-p-tile
> +      - altr,pcie-root-port-3.0-r-tile
>  
>    reg:
>      items:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

