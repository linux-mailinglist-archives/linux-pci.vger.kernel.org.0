Return-Path: <linux-pci+bounces-7085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A428BBD61
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A8BB21264
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61435A4E9;
	Sat,  4 May 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib5xESo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D33CF63
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842835; cv=none; b=rocDg1eEEt1PgAiG5aiO4J8KxwozmQR1Zs3mLrAaSyIzhdPYViZes+zh4bDGKLrD3ar0oSP26SxDizlKAWVldtlL6iLXjYQNStj/5+pv3gLokRDOm3h58r5+ppKpooxwCgSkY9L+ialu+RerNyIFPFlxAJQCzw8IAwjkuDOu/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842835; c=relaxed/simple;
	bh=gBERJg/nmutB8WoHqMckSy1zac/CVeNSPN7yTxohxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOHu5uYNEf0KOfZzMUE8QsyFlT+dWKahqaqCLWd+0MVUZ9YDF1qlCI5/Ze/5T1ra+FRgk+GkGgpWR5B5zd+QWdS72dXIrkbTcpDI0rWFSj6R4IKiwU01bghoFMsLFxy4QcbaLtuMLY6HUv9jQWMMP2eP/utE14TKhyWfbcrLwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ib5xESo4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f44390e328so658053b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714842833; x=1715447633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6SfYlDnl8J6WZ0WsCtdQjjzp4VbWMxSWwvAKjPCrXc=;
        b=Ib5xESo4lBlP9CduvX4z0ccdTNaDpmrFodrczizz3vOvjeMwR2DticDF1DbmKerSLG
         rRKb7GFB/4qqoBm4znKfA6Nuja0Yje71qFWhCEYggpaBHw+OacXdICP7VcUHMseZr8WT
         C0Sf7AtdRwLMmEzjDevgF0n0AIivE9XgG4Yktua9J5MDjcjDHam8JGH81fgxhM8bCuNY
         Pd6Yqsb5btFuXdaet/u5WGHsFZmy+0N6u4/FocwXvWHSXXzwdtFPzHnuPewAoLN0V4BH
         CJocVH4zAAZoBGdWIb7A8KpT21vZMampYTHTFprx85QuTZ1Ehb2RbX9C6xWJErbw/f5k
         TJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714842833; x=1715447633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6SfYlDnl8J6WZ0WsCtdQjjzp4VbWMxSWwvAKjPCrXc=;
        b=iYo+HSQRBtdHZ7LJqmQidHj6vkASbSbvTOkqnrAGDLwJopw8EgkSwmK47WVcV6E4Qa
         4CSIw241VeqybGlcDroGJEAyD5bG0UdZ4fny7c0UlVtnTBh6kQgBW+CuniDOd/wiuhSG
         lNuYjd0xnWiflYVKpjJmODZz79UIguhGPv0ySyrhKxCCiPSzG7NaJdbZTe3EGQFosjSf
         /294xY12r+tFdXTtX/sNMgIudqOUZbtOqhBz93isO5YkWArbEOmRF6zwVSlykjwlBIfC
         vtMO5RNT19zCmYTYv96gZOE4i2vtxWllKqR+pxjRB4itulBjioO50kwfFFS8AiMQtvPN
         5/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXpVF6HJbdZJyvujl/PJIT5pxlvWYpEvIQWgr7j0vIdFjzdvylkGUEW7F8nYETbtqI8HwbRd+IDYgDN9Z+LtAGR5OdM6TUY7pXe
X-Gm-Message-State: AOJu0YwJBon0ptAs/s9rCoQGPgseQ/Dn/A1/if8BJis5FJU7prxqFZ6X
	ie5EtE1CAdgujXZ1zuVx0Z7mFJCk8Ojd4ZxgEyy+GMyUMTmxvVHZX9m7D0O+8Q==
X-Google-Smtp-Source: AGHT+IE4dylI7QXHHn5f/KCuBye5E93/83YHUHgLPJwVftLGMyfTRhG5xgQLthY65HGM6p1E/D68CA==
X-Received: by 2002:a05:6a00:9a5:b0:6ed:cd4c:cc1a with SMTP id u37-20020a056a0009a500b006edcd4ccc1amr7084861pfg.8.1714842833327;
        Sat, 04 May 2024 10:13:53 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a000b8200b006f4547cbd1asm2058335pfj.5.2024.05.04.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:13:52 -0700 (PDT)
Date: Sat, 4 May 2024 22:43:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 08/14] PCI: dw-rockchip: Add rockchip_pcie_ltssm()
 helper
Message-ID: <20240504171346.GE4315@thinkpad>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-8-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-8-a0f5ee2a77b6@kernel.org>

On Tue, Apr 30, 2024 at 02:01:05PM +0200, Niklas Cassel wrote:
> Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
> This helper will be used in additional places in follow-up patches.
> 

Please don't use 'patches' in commit logs. Once the patches get merged, they
become commits.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1993c430b90c..4023fd86176f 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -143,6 +143,11 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>  
> +static inline u32 rockchip_pcie_ltssm(struct rockchip_pcie *rockchip)

rockchip_pcie_get_ltssm()?

Also, no inline in C files, please. Compiler will inline functions with or
without the keyword anyway.

- Mani

> +{
> +	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +}
> +
>  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  {
>  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> @@ -152,7 +157,7 @@ static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> -	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +	u32 val = rockchip_pcie_ltssm(rockchip);
>  
>  	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
>  	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
> 
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

