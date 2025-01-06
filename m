Return-Path: <linux-pci+bounces-19344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76309A02D7C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778553A2D02
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AB1DE4C8;
	Mon,  6 Jan 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kT59MZLU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2ED1DE4F1
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180220; cv=none; b=uB7abs8K2aoVGGuvozHSpDh54yVMOdkZ10V/BNgO4fXv5tmgIok8wFH3yncBsqYnHYad1wErWxuksVo43VCFEyYlHgDJzFpzWu+xAuiJmzCoCU8rWxeEShLRXGX8zFMzbikv1l2OebeOK4kaio3q7TSXamv/wwKaq2EOMpf6pBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180220; c=relaxed/simple;
	bh=jR0rtiAFDgif5wPqwtmomqJBgFXe+11Fti0M+vMT9lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEgDpnYYpLLhvgLiybgWdLbM9HWzBGrL5CWpk8M6oo8MwBD2JGhFvwcSRwaStawE2Yj4q8YbMBm+fGmmK2xRtRbnRZJyAdOhtBLdSHkrBnKWtBYO1tZAPGUq7yn0DaZGEC+5LIPQl6wpR9kMBcuaStUsiOIbqvWPxeeSR+0zjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kT59MZLU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216728b1836so190620525ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736180216; x=1736785016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ioU53vgoNQ0AoVqbDSui1lqyY/iBOmMjiyD6RqrD6B4=;
        b=kT59MZLUL7oK48eiJbBsGFtBdciUG9qpVaXUAi4tdUOqnIWzIxl4X+G+ycI6n5jMLF
         +fcVAjfXyZrCKkiMZTtw86jmp0s5bOgH+zVLnajiMB9WqZk9gNb3gJOxdODeTXNagtr4
         0NZG+KjDhtnxqOLMRNvw1+7O/oJ71CCUe37+yI5y6Ho7ORl8AsvbzCtHyVdW1jZ4uCae
         1RCYUjI0zWPVeW6tUYPoS+JGzDHyOQSrr5Gt4Ey4WiTpOzW+OfV67+TQg7E4+rgM+9E1
         PONn+IsnQ47elDD+qlEpEuVdhKKxaYvFxiHyh785eOWapE742MU2seFByBGR9RCZzpQZ
         5hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736180216; x=1736785016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioU53vgoNQ0AoVqbDSui1lqyY/iBOmMjiyD6RqrD6B4=;
        b=LUQ6A6HMzAV7xJTglKd81/fACilEhkxYpdaN6vEjCTP33wDPRND0BDeHsgr42hHv4e
         PZ1vjnqqw3JLlGOCM3QO4rYgb5A1hu4yvYpWbjc3FFiebCRmu5ly85bjlYIFg2C2eoAa
         kj7E+YY82DSLLexx+/r0OmQ+y7hLRcvMytoRqgls3/IQkbDTDFfozNSOhTV0Ydfx2lPX
         2S5IMFLYQ78GLQu9+ic+XvKBoS3dQMV73RpnrrSJDMfTH15kcwLV8KFEBIEoSk4613vF
         pUv/2w56zfR3QNT1AMcsy873PQWTMdF9Xj1iIucSGCWZr0ZKj4X61SHsXCV3kuDX6T+g
         Xqjg==
X-Forwarded-Encrypted: i=1; AJvYcCW5N8KqnNCwuVHCTDuwsVlPTK+PpUDMrJKOQcPwYBhCB5eOKF5lt5WW1U161gRM7yGEEaaJbkLyJ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHkTl0Zl+siHRt3jbAgsOgY5iWvY0Uuv+c4CSEFNjseRC5H6k
	9bNJGehktQJrOeuQLjtm/6zRraGsbDklkWISHGy2su9XfWOZl4WtlA38Fv3+8Q==
X-Gm-Gg: ASbGncvUrnycchzuFAW2XMMUbIxeHHcZlogqvJBjBpEYy9zy3yzRagl/fgfXxHEDUn7
	yhgd2Sjm2TNAEfJ5o/8fIjpksktDOsLv3RJqf3oKVUkEOOeMolAL+ddor6Zn63hkvHAPM89F+Kz
	+2bEViWRfWjs+LjsMHKjNOLrbPhuo61td7AFjYxzEEh6GpaqT4N5zlQAHF9Mhq0G/5y8qiJCfiK
	VhTWz8m5yAaK9oAF4+RfFFFu1XbiLJv4SP1lHtcezM/lQwPtAMyS+n0alpruwzKkHI=
X-Google-Smtp-Source: AGHT+IE0TclArATGV1Fu9QzdsMBgtnLWVMtYLElP8xxrkxbbzfBsYBkj0d5S+FS+C4fjsFRPAz2wxQ==
X-Received: by 2002:a17:903:1209:b0:216:36ff:ba33 with SMTP id d9443c01a7336-219e6ebcfc7mr772797425ad.26.1736180216074;
        Mon, 06 Jan 2025 08:16:56 -0800 (PST)
Received: from thinkpad ([120.60.61.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4fbcsm294633875ad.174.2025.01.06.08.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:16:55 -0800 (PST)
Date: Mon, 6 Jan 2025 21:46:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Message-ID: <20250106161639.4bgb7rhokoe22xpp@thinkpad>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-5-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103060035.30688-5-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:14PM +0800, Jianjun Wang wrote:
> There are some circumstances where the EP device will not respond to
> non-posted access from the root port (e.g., MMIO read). In such cases,
> the root port will reply with an AXI slave error, which will be treated

By 'reply with an AXI slave error', you meant that the root port responds to the
MMIO read by the CPU with AXI slave error? If so, please reword it as such to
avoid confusion.

> as a System Error (SError), causing a kernel panic and preventing us
> from obtaining any useful information for further debugging.
> 
> We have added a new bit in the PCIE_AXI_IF_CTRL_REG register to prevent
> PCIe AXI0 from replying with a slave error. Setting this bit on an older
> platform that does not support this feature will have no effect.
> 

But the issue is still present on the older SoCs, isn't it? If so, please add
this info to the comments below.

- Mani

> By preventing AXI0 from replying with a slave error, we can keep the
> kernel alive and debug using the information from AER.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 4bd3b39eebe2..48f83c2d91f7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -87,6 +87,9 @@
>  #define PCIE_LOW_POWER_CTRL_REG		0x194
>  #define PCIE_FORCE_DIS_L0S		BIT(8)
>  
> +#define PCIE_AXI_IF_CTRL_REG		0x1a8
> +#define PCIE_AXI0_SLV_RESP_MASK		BIT(12)
> +
>  #define PCIE_PIPE4_PIE8_REG		0x338
>  #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
>  #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> @@ -469,6 +472,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	val |= PCIE_FORCE_DIS_L0S;
>  	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
>  
> +	/*
> +	 * Prevent PCIe AXI0 from replying a slave error, as it will cause kernel panic
> +	 * and prevent us from getting useful information.
> +	 * Keep the kernel alive and debug using the information from AER.
> +	 */
> +	val = readl_relaxed(pcie->base + PCIE_AXI_IF_CTRL_REG);
> +	val |= PCIE_AXI0_SLV_RESP_MASK;
> +	writel_relaxed(val, pcie->base + PCIE_AXI_IF_CTRL_REG);
> +
>  	/* Disable DVFSRC voltage request */
>  	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>  	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

