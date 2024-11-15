Return-Path: <linux-pci+bounces-16843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AFA9CDAFE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4102281144
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71C18B470;
	Fri, 15 Nov 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOUYuZh+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2A18E056
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661207; cv=none; b=M3jmQaRgJPG7CCLWWRKKQxco+bdNuAuB2a6GsNUO02V7IJ7xGghH9O/XBNxrLc3Tc/86g+9oOqzfPYUrjU+ZApGVnG2KJpfZkHL/XJ51TGb4UKSZhE2McCfAHGHDgwk9vRUc90XvM9v5Xca8iRf6NdYsmJsJOWdVJh5JPdGbkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661207; c=relaxed/simple;
	bh=UdYxlYY7XVIod+TARQznuR+mkZUTsh5bqYqVbVca8EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIFnvXaes5FCjLZtDyKUZ6whwsUTvNK0FFp327fL3cdWbAjoqj5kLSvO/5wR6p+0bkixlPvRNszFICKIfs9WoH6UJYYUFGodUDdbecu8bZr9CUuofdxc6Sp6C2fW/LD62vqoCNNOy0SCWUQGAUOM8SV1mjSfg6JKNd+UOhKunOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOUYuZh+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so1033434b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731661205; x=1732266005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6LO4Usr4YLCJ7gfFHS9SsbF18mDXFAaRhBjtGDvUq4=;
        b=cOUYuZh+5l3+R6efvoaKmN3ibBBDDZXizB6U/y5WoI96SJyCz1eVWBEMKFNA5q3kL/
         pFgH5if0da4bLMYcM4jPJO03ncUrEhp1JYoNrPcdE3Ljr/ongE6Yh5/kXLLManycwvCe
         vqXlPk1t+W0RCr63ARFQYMxhwLMfeTrjW/Y5icF4XBFwstN+pi9pfo8YuJHH5JM/bagy
         rjmFhebLLxSe6Pc2iyhyJPTAEBAd9bYnulwNozwpOrIcZEEwuY8/ihEPUZsDfos3YWnQ
         nfryfo3JGrdFkCAlv1h9BA3K4+kQrqKeqLw6SKVkOhDWzH/KfRtfK2xDVf+Hw5tvlIO2
         6bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661205; x=1732266005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6LO4Usr4YLCJ7gfFHS9SsbF18mDXFAaRhBjtGDvUq4=;
        b=wp6VsRYukQCvDtfKF2C8DnFANqZlaliMuvruF5iWIw8Vah1dPbPgdBXPtUX8eaACP9
         i6DjiNuhaemaK9kWcwp/ZpRTLDuUWOCKZXzoL89bRgijI3E1GwI8CLVZ961QsU4E3Aoi
         b5ax9VvMqQ7/7GA/jrIqTJdvxwSdb7YtRVmHvd73+I0gYd0GVBcyo6/6oOMv84/NkOpL
         0dN1t0tvDSJwW9KzbqT+0qWZnLOEeAc6wg3qGCAEuGtQn+kgqFRYnvUj/Sv1bL0EKQA9
         DHxGxy4SbbJWGQL3eJ+SHAZp+P87tlDOXeUuoEq2uSbP7dgt9raZhhEPJF7R2ElRx5ah
         ZSgg==
X-Forwarded-Encrypted: i=1; AJvYcCWO7SKBCwo3QKCME8WdfT8qvf02KJ4Nup25AIH1a7DUO3zPx44DsWuoVoxfd4rggtnKWzG7BZc2bFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lWeF6xN5Z5GAeDBzZf5QJkp57/1L563AqG2w2YO8uxHSPSgN
	usWzEO/hZxT1jXu77SxglL4iIRPmY20c3yB9qgINO6Wo8taqEsU45CE6Owg/tA==
X-Google-Smtp-Source: AGHT+IGXzc2k85nHigsVQvGCV/dEUXykSPtZP9SAjYxa8cXADj5jMo8+rVoyKMXLZcK2JnJ73FDM+Q==
X-Received: by 2002:a05:6a00:21ca:b0:71e:44f6:690f with SMTP id d2e1a72fcca58-724760cafa2mr4071933b3a.8.1731661204509;
        Fri, 15 Nov 2024 01:00:04 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771fc665sm883611b3a.173.2024.11.15.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:00:04 -0800 (PST)
Date: Fri, 15 Nov 2024 14:29:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] PCI: mediatek-gen3: rely on
 clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
Message-ID: <20241115085955.dbhi2v7qfuq3tmr4@thinkpad>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-2-0ea3a4af994f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109-pcie-en7581-fixes-v2-2-0ea3a4af994f@kernel.org>

On Sat, Nov 09, 2024 at 10:28:38AM +0100, Lorenzo Bianconi wrote:
> Squash clk_bulk_prepare() and clk_bulk_enable() in
> clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up() routine
> 

Perhaps use something like,

"Replace clk_bulk_prepare() and clk_bulk_enable() with clk_bulk_prepare_enable()
in mtk_pcie_en7581_power_up()."

'Squash' doesn't sound right since you are not squashing any code.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 0fac0b9fd785e463d26d29d695b923db41eef9cc..8c8c733a145634cdbfefd339f4a692f25a6e24de 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -903,12 +903,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> -	if (err) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_prepare;
> -	}
> -
>  	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> @@ -921,17 +915,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
>  	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
>  
> -	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> +	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (err) {
>  		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_enable;
> +		goto err_clk_init;

err_clk_prepare_enable?

But I usually prefer err labels to be named after their purpose. Like here,
'err_runtime_put_reset' so it gives the reader a sense of what the label is
supposed to do.

However, to keep the existing sematics, you can just name it
err_clk_prepare_enable.

- Mani

>  	}
>  
>  	return 0;
>  
> -err_clk_enable:
> -	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
> -err_clk_prepare:
> +err_clk_init:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	reset_control_assert(pcie->mac_reset);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

