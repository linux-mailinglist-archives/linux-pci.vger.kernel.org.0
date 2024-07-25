Return-Path: <linux-pci+bounces-10753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A393BBCA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F33285A1F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868A18046;
	Thu, 25 Jul 2024 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYU2XTWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273491BC43
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882383; cv=none; b=fkb+TP9yYKFx4H2NKC+/tDz5sl/xIxbx7SEbIy+RZYIscOcuyw5K4N625nmfJIDgCahPujTld2/iiSWyCfLKud/cAbq/hkzgyt4Cj7xYWEyGz+/D1vy+NxARd+K6spzhZbgh3m1VjGr/8V6rMSHYyjby6Sowf6JlbiMCwR/e0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882383; c=relaxed/simple;
	bh=SPMnv3lDC0xqfx4BRZEkReyEw5kO4g3jUXU3L5htFp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgth6+YUaozwp17w5Uti5nguiKPb88LBvaSzrtS0aHCp4/37bxA5nKT6CRIBEECnnYdIhhTG7dJm/wC8hn5+X8QOCDdLn3Hotkc8YgyB0KLjOHW8LhWoRdhynhqCflog6HYPyUlWz+Bj77mD3BKDyljMwdYsh+GL6o7whgc3Tek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYU2XTWe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so363672a12.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882381; x=1722487181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lps+7wjUqBAaMZzAE44Gt34uJV/0AS3Ks07X8dKNdcM=;
        b=lYU2XTWeyaqQUFwFFq4rn9Xcgx0udavEleJK1Q+t1m7FfWWw0ysjpCBrW991ySh4bb
         XYxflPWAK9bPHa84SGqOBLdE9P3oXlpwV+1nKUq99mXvw0EMhSibVLiX4VYyWRcQmaKh
         dQMPnHrXJzJchLNN2T/tR8/OioZIzg+sFpRVi4gu8rWeLSBPxpe2K7ZA/6YLB5v1CqKZ
         6PZFpssP3puq2SaqdoVxhx0mlk0kmsmz8+y0W+uUso5jPtO7O7BfM4seXjLbEzssNof9
         qtKiRyW533xsYH2jwFAD+IDTheqdWq7Mnla73aIwHc30dhOGSJe6uo2qkNI34UV3zVcb
         G92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882381; x=1722487181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lps+7wjUqBAaMZzAE44Gt34uJV/0AS3Ks07X8dKNdcM=;
        b=jSTQ3H2axiaKiSly7x9k74zKt0LOxB1nRzRSmmHjqWdzJs86Hnrccez6rQVZSfDp6L
         Tl51UBwypkUn2q86mQtfQSdu7hLueOOgxU61Ls7rFVh+kVdszk+QrlsQ9lTRalLlD6gf
         aJgBTj6ZPOBQ871W+Z2Qry7ATTV96It+Bye1sdUYVTI/C6LAM1WqWnsst8h6P/XvlKXC
         YbEK0tYy6ryALX8zxIfX3FxJL8Hv2qMkjTm9+MiAVqqzmfGEup4vjxlYXMyjo5ii88Xc
         U8vBQvLt3UXE0nG72O23V1Xq0wyQkgSgGGE28LncaWnhwUKrt0uIZs+asQwOxGC0OVM5
         RnFA==
X-Gm-Message-State: AOJu0YyZpdM4FIvWkc8+h7epQYcecUGwJ4jcsbxd+Pp2jCq/XG5JeHQN
	xJlpwLSLTSYiO8ydX17laS9Vz6quvPklD3QgBWGQag13OplNLE2snV7XONt4/g==
X-Google-Smtp-Source: AGHT+IF/Bf11cCC8S+v4gyIAsbPKbW0UOrREoDtXpS8Wmqb1pIm0kiPvC8oaIUSChmKJ/lBJ/PxGPQ==
X-Received: by 2002:a05:6a20:7f87:b0:1c3:b2da:cdff with SMTP id adf61e73a8af0-1c47aca9b47mr829084637.0.1721882381242;
        Wed, 24 Jul 2024 21:39:41 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fb1accsm4078215ad.261.2024.07.24.21.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:39:40 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:09:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/12] PCI: brcmstb: Use swinit reset if available
Message-ID: <20240725043935.GF2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-6-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-6-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:20PM -0400, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 92816d8d215a..4dc2ff7f3167 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge;
> +	struct reset_control	*swinit;

Same comment as previous patch.

>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1633,12 +1634,27 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->bridge))
>  		return PTR_ERR(pcie->bridge);
>  
> +	pcie->swinit = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit))
> +		return PTR_ERR(pcie->swinit);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
>  
> +	ret = reset_control_assert(pcie->swinit);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
> +		goto clk_out;
> +	}

No delay required?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

