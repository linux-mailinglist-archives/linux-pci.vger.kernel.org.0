Return-Path: <linux-pci+bounces-19343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E7A02D6D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D869B188159F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F150285;
	Mon,  6 Jan 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9hBXOsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7D7405A
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179809; cv=none; b=U12/spaw93m/QB5gmLhxP/LjeIRQp85imGVFoit9nRNuQdavrIiSVz6U/0b/jKxtrkCzIqqM6WaG2lA6DVlOVmsBTLoqNMkde73hTjGc/SNDYEKY0zk6BMwzGXp7EfbrjjxYrb/fozftBCrXf1UphLR3IO7PjEd1jYrByiLYZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179809; c=relaxed/simple;
	bh=w5Yel1wJYsFWeW0wLAjqewZMxGW2Jmj/sYREWUnMsjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaNw7ZhHsQPufFRzHElCE3QWv4NcgYpW7gFP64Ojjab3DNxIjKf0IIerkaYxBvqqTdbqVcxjQZhgwvxFGm5TnOfUd8ClYOjQCHNYduAHnWKgtu1VsKeUmb1Dm/1VhMcUn1UKcfKzBDuzmzi9LJVPay0288Hbiuth7FkBYwm1CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9hBXOsW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so190509115ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736179807; x=1736784607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbh70FNu5lHAZ2y3qFziORwGTSyKcYnNaY2OZrOn1ZY=;
        b=T9hBXOsWJ9sXTpYFVmm9dBd7gXG10UVWDw+nj00g21F7ZVHPOOVgl+BmHhtlrJf8X9
         AGIXiDTrST8vy1bPI88RD+SV7FLPfjCntYsZm0t+z+hFO/liePUB1NoGvKvwdi7SWemv
         exBv0D6TfPRF4dcxAhW3QhfqlAxv52Sf6KkWTGqXRulbEe8HL721E1H6o04mmxv/Chjo
         oMe8D9pnQkNDHqFe09kw3f6lfvX+sbotKLRjqsvlbZAstJ83Omv/YO6VHa8K5K9x7n5w
         1u/yRQp0Bl/IRmBL1sJuEXXrqjsW4w4P9tnnRYbmxd0X7r75E2XbbdPeWriHKZJ/KDgb
         Reqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179807; x=1736784607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbh70FNu5lHAZ2y3qFziORwGTSyKcYnNaY2OZrOn1ZY=;
        b=cNz5kKPo5ElOPZ6CHH7jgI8+zzUYfBgKrd8sdnmvfrQPqX6fvvGZM8dGTNfwVuJk5X
         CjKhqvHQvAsVDlev3RbkXTOsftloLAffudHKgivCkBjyUWw5gKhTr0VszERcK3ARSvje
         jxj54Vbm3IdrBRM2zoNS45xRqp6GUFfse6r55Xpp0SeAv4cjcIJSuLq0cQSU+Lx01wYv
         G0fX+wI/Wd5OsZ2A5HXJ6//YLd6ikSvVTzYaJU87T5unMwVFqSqGVVOoojy4/uIL2sMo
         vZvod1JRcnX/kMjuplKGu7xqF3Hq7pPtpOTFW6Nvj5eheA1AsXaSC6cDds3vYutmxuFR
         WP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWxxzyPk2QkTAOrJApgio9wJwkPa3SOtNCZVoDJIXySQFr7ZJM8beB4nGmPBc+xlyfzOnls1LD0m7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoCS63eifFnV6etpxNePolukj19QNgh2996qN8pJ5qRUx5Yz8
	RUbFgH9zRvuidB5NwqfsmwfCH4rBoT15oKE3lfyNLxLfOwdqWpGNWeWq/BDqyQ==
X-Gm-Gg: ASbGncsMjDPJd2rJtI9NfLkmNj7AuAVZZeQOn9VYc8OP3GnakIiwHVqMlR5pwRM/V/X
	zGaU9N+LfZijBQ5/QJZLBgPFoYk/XaTzNojNe1rkTGQ7sLp21wNfCyXYg8FU/WnNWaWs7LBrobI
	+Rh9VJLP+Nhi4R7+PqdvWSkKuLlxmSRTrQVflvy/cgcGszOi297mt3jWbPcQGcuU3PaAbyxteis
	jVKyf1g+zFYiohrzVS1YRfb2apZKzjSm+8uknp2NHewFkxaqSiMxnPRGsv6naudBcc=
X-Google-Smtp-Source: AGHT+IGWek+UwLvA7jIxaMXySnHt1P9khnFX7cna7RBNBSt0+o7sQhOK9pqBW8ZD3DQlUzuguSWTWA==
X-Received: by 2002:a05:6a21:2d04:b0:1e1:b224:74c0 with SMTP id adf61e73a8af0-1e5e0815ee4mr94198810637.38.1736179807211;
        Mon, 06 Jan 2025 08:10:07 -0800 (PST)
Received: from thinkpad ([120.60.61.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm32377915b3a.128.2025.01.06.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:10:06 -0800 (PST)
Date: Mon, 6 Jan 2025 21:39:50 +0530
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
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Message-ID: <20250106160950.uutcgs2vqnuve22k@thinkpad>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-4-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103060035.30688-4-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:13PM +0800, Jianjun Wang wrote:
> Disable ASPM L0s support because it does not significantly save power
> but impacts performance.
> 

You should disable ASPM only if it is causing any functional issues to the SoC
itself. For other reasons, users will use the existing sysfs/cmdline params to
disable ASPM based on usecase if required.

- Mani

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index ed3c0614486c..4bd3b39eebe2 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -84,6 +84,9 @@
>  #define PCIE_MSI_SET_ENABLE_REG		0x190
>  #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
>  
> +#define PCIE_LOW_POWER_CTRL_REG		0x194
> +#define PCIE_FORCE_DIS_L0S		BIT(8)
> +
>  #define PCIE_PIPE4_PIE8_REG		0x338
>  #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
>  #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> @@ -458,6 +461,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	val &= ~PCIE_INTX_ENABLE;
>  	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>  
> +	/*
> +	 * Disable L0s support because it does not significantly save power
> +	 * but impacts performance.
> +	 */
> +	val = readl_relaxed(pcie->base + PCIE_LOW_POWER_CTRL_REG);
> +	val |= PCIE_FORCE_DIS_L0S;
> +	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
> +
>  	/* Disable DVFSRC voltage request */
>  	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>  	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

