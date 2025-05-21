Return-Path: <linux-pci+bounces-28190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF24ABF03F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B11BA6548
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96432253940;
	Wed, 21 May 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WntjIGuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3F1A3BD7;
	Wed, 21 May 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820560; cv=none; b=fyvVCiLDY96JwWFEhJmczmoaIsQ/29+O2sBhZxIf+Vh5BFBo8UG1iWzkQMzfmCs/ro8axsvq/q9tvSFKSf6ebtpaUAbq0RaK9buu4mZJret7wgDFaeCO8rSglU+F7EF2lvIhTtpYcfjWMjC/tEhCP4q9hTs25ivL5Fv6XafBLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820560; c=relaxed/simple;
	bh=68q/IbPYPxygxx5c/OXPCNRFH7INdTpZGlMiYkPeW1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4T2F4ev8wF62/b7R1Ba96sgzcT/0WzzQjIgwqd7d9D1YQe9zKMwCz4olyJHBzzl5ji65iHoLy+dWTje/8mlYu5FZ0JMb7UwzRiBxw+vSXVvaAjFVeXIQjV6ZYx6ISJW3ke3sZidGzEUvZaHiYgzKmfSERffiNxWouL7QWwwkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WntjIGuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1D4C4CEEA;
	Wed, 21 May 2025 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820560;
	bh=68q/IbPYPxygxx5c/OXPCNRFH7INdTpZGlMiYkPeW1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WntjIGuQPDsKX/mYWYu0FkXFL+RSS/akUgmMVsho09NJNA8oqm6QVXC50ERtC+1cR
	 xxnTBvuXtaEQp7Q9aG1hMX4uE1CE0izhyGwlvuDDggKIG2XtmIW6xcA1JjVW66OTlM
	 ztiGD1J7QLNhQ0Sg5CTY4TM0GxqGRKXy23nUutf9x5bpCpu65I5WJVaELulRNyZ2ob
	 uXTy9Y6hWGRA3P8n37w1yH2TDtxUz5z0IqFLCGvn04Rf432erZzGL8h7KfQl+IlLYN
	 6UqscpWvGfqqr0VRcoLjCArY1LM0NIh/MzMJTOJ5nxL6uYecYR/pDiOxPJgoVd+9iU
	 Qi6qc2T+w9qLg==
Date: Wed, 21 May 2025 11:42:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 05/10] PCI: exynos: Add structure to hold resource
 operations
Message-ID: <20250521-nostalgic-fox-of-valor-f6d725@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4@epcas5p3.samsung.com>
 <20250518193152.63476-6-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-6-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:47AM GMT, Shradha Todi wrote:
> +struct samsung_res_ops {
> +	int (*init_regulator)(struct exynos_pcie *ep);
> +	irqreturn_t (*pcie_irq_handler)(int irq, void *arg);
>  };
>  
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> @@ -74,6 +81,36 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
>  	return readl(base + reg);
>  }
>  
> +static int samsung_regulator_enable(struct exynos_pcie *ep)
> +{
> +	struct device *dev = ep->pci.dev;
> +	int ret;
> +
> +	if (ep->supplies_cnt == 0)
> +		return 0;
> +
> +	ret = devm_regulator_bulk_get(dev, ep->supplies_cnt, ep->supplies);

No. Getting resources on every enable is making this much less readable.

NAK

Best regards,
Krzysztof


