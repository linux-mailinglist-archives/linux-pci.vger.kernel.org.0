Return-Path: <linux-pci+bounces-6731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF318B455B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55EFB216A7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D504644E;
	Sat, 27 Apr 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ff4TjPQc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56645C0C
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714210305; cv=none; b=BHgy2M/vjtp5doVp/9Js2dX8HjfhorxBQ86HT+S6vqWmfYJd7LWOdGgq97fSNfOTejbK6VPeiCSI+dR1tutQwlWMdh6Hj2bI9nn/tYBp4Y/ssdCzvlzhi5qUiSQfYmS+21kGXwTacVt7x/kfqk7F8oqMtooEX1KDV/BlddvGqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714210305; c=relaxed/simple;
	bh=vhh5H2vOFTU8TUNbGQSR21C/gruMVYqytSa4SWxU+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ7ODNJIlEnGzz6KW2ox+FGnTE2ce6axrUkGOwMqAByWeOGcZlzLcDQ9HwcZZvKSK0uc1C4qLJo3jd3CVftIUyJfPju0W8g/Bw7XoVPiRqUk/kGyR0pQUyzub6lD60QvvIJ5mFTQkCpCCMwdGuhZRzZQ+ln0s2D0lAYEE+dNuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ff4TjPQc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso2699474b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714210303; x=1714815103; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYOHjjJvOYuP2OhXdEZddqymE0/QhchR9DMZrxwOyFM=;
        b=Ff4TjPQcUAzhsQ5eNWsF9tSOxX7yXVF5rEppx8xbdwWKjSaa1GW6QcDI3KrTXRCKCB
         fYrD961wmb8aJfYuV+CMyN0iyTbt9meBjyuB9iBTPavILmM7GF68qro3EQmHO4V5SxIQ
         l5PeaNGt9qJDJ4+bvbmb/vek+ddglxZvZkR3nVDHBijwFoC0dSbLLLp5HN5JA7fOOjrY
         xcmN4WssHPv4z8vekGbPPlCFQeN7fpmXJynvHECnyTvQQ2sOioLwywlHZmlvCe4He7fQ
         JrOZ1JgxZSnqR+ELjzSDsfuq+EAUa2KxGAh3itYL0Oz9DQVm8SIMd4mKT4uA/EFrpHlr
         BJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714210303; x=1714815103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYOHjjJvOYuP2OhXdEZddqymE0/QhchR9DMZrxwOyFM=;
        b=GLR3Oe9sYKuzdqkbbojjdxyFmTRi7Il9rKso2JOrRh79oGFb8EoX8Bqg/8su6NqWru
         /w4hizwmvDMHVYu7c9bKeZc3Lu5FatPgTBdlSHoy7aC9aft2BaZ+9eZ2o/umCnAAmIEU
         WGqNo4CXrZGGLUxVGfPCxbRddRW8hM3KZ/ffMv9JfVd5Ng2zxrR/QwqlgU4GY5CmFnvw
         +B9KKlB3+nTXyT2S3nm59DOLuoQxiYvRI+hzvPE2zbk6Ao7q+UwZLqUlH+ByOx+r5g0G
         NHrHuojGXFf3Z8o/YUtVHFERVqMG4sfhm72Xtwnf6hWGIj7vW+Z5KzyuH2nZPsxnPIr8
         w1og==
X-Forwarded-Encrypted: i=1; AJvYcCV3YFJBCP0IgKK2/tfWvwy9HBtVNmxSa5SJM/Is9NmHWjquPXYb7be2oEZXU/3fj6cMSBUpXLF0pBXBcFGJ7W8P7h+69uMqkQS3
X-Gm-Message-State: AOJu0YyqgorfSdTmbthxsMV+bwHyZk1sDfLT2B2/3siCkvnifG+6PWrP
	WLggY0kveiyjDG2CHPreyomu0AsoRSkuv3ci9B99WtfhEhj5VZEh4goPuOOa9A==
X-Google-Smtp-Source: AGHT+IEDEy5DOuk8n6kXlJvEA8g+7MUq9OgTqFu1xI+W8rd0Vtrs/hhQqEV4yIwn5e/6UYcNXRNLPQ==
X-Received: by 2002:a05:6a21:2d86:b0:1a9:d9bb:acdc with SMTP id ty6-20020a056a212d8600b001a9d9bbacdcmr5839673pzb.28.1714210303063;
        Sat, 27 Apr 2024 02:31:43 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b006e71aec34a8sm16043440pfr.167.2024.04.27.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:31:42 -0700 (PDT)
Date: Sat, 27 Apr 2024 15:01:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/11] PCI: imx6: Rename pci-imx6.c to pcie-imx.c
Message-ID: <20240427093133.GI1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-4-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-4-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:40AM -0400, Frank Li wrote:
> Update the filename from 'pci-imx6.c' to 'pcie-imx.c' to accurately reflect
> its applicability to all i.MX chips (i.MX6x, i.MX7x, i.MX8x, i.MX9x).
> Eliminate the '6' to prevent confusion. Additionally, correct the prefix
> from 'pci-' to 'pcie-'.
> 
> Retain the previous configuration CONFIG_PCI_IMX6 unchanged to maintain
> compatibility.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

You should not rename a driver as that will break existing userspace scripts
looking for module with old name.

- Mani

> ---
>  drivers/pci/controller/dwc/Makefile                   | 2 +-
>  drivers/pci/controller/dwc/{pci-imx6.c => pcie-imx.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bac103faa5237..eaea7abbabc2c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> -obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> +obj-$(CONFIG_PCI_IMX6) += pcie-imx.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pcie-imx.c
> similarity index 100%
> rename from drivers/pci/controller/dwc/pci-imx6.c
> rename to drivers/pci/controller/dwc/pcie-imx.c
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

