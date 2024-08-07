Return-Path: <linux-pci+bounces-11408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E625D949DFD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 05:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452A4B23429
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A22B667;
	Wed,  7 Aug 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIn7DQXc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD591C27
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999834; cv=none; b=IBGQJoRDUf8hpVD2rsMSvSfXvk8mzq2Q/oQywA+waN7lQR8in5L8qNhHhN3jXhBr5SpcFQGKdcqu3r7kLwoqnG9n2fiFBtpgicU7/i0RbRAjJfZL4X253PSKQIkvFzDPrpb5BZcETr/2zT4kbBq7OePt0TfpjSOfQeAsFr3XXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999834; c=relaxed/simple;
	bh=19zQ/CDmCArapw7Qvr+6KVZO2V9X/3YhzLrF500JI0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFtGEUEt+DLMS5ojBcwHU74Qf77dxxL5HRg8lGz5XDCWGg60fNOf2yL+CsgjbHwsfIvfhQEn5vtqKKJmvSJ8T6KBOItl9xUs+QJhxTwU6MCRxRT1ujsL1ZoPaZOodQDkR984oyyZp29qvZPlRN9M2p+5V6ZPoA+U5+EKmizdqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIn7DQXc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7bd16405aa7so593191a12.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722999832; x=1723604632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zuSFHpUoL2YYlkuYSjJEF2bIpqbWqy7BnB6SEFzqJNw=;
        b=BIn7DQXcWf2CI451oadZ+DqnTfDuNcRsU72QY4u0Vo/98yO1J/LEXqUiohsGciFVZH
         YC4Q6bb2FIc92acgdG4ZTffu333cFkIDwH/DdzlzfwNI7Xvt0OABWHCv0dZxiFxex9b/
         1Wb0SIxASZ2FxR7nujYz4EviQVuEUJb2PtTFNmBJ9b2ClTYqI8/wVxrDOyfKkUJGj3SM
         gvbGx+8hZ2MlbZnyamRIwK8smdr0axrN9+ZMc0pexiVRWCtc9LioI7d+1YpqkrXKt9yq
         SGRV4wr+NIZpxeM33qSwvi5jMkvgJLXBo0iB6NRItemDW9vO43YlYsrWt4TIRVQ0f4OJ
         6bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999832; x=1723604632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuSFHpUoL2YYlkuYSjJEF2bIpqbWqy7BnB6SEFzqJNw=;
        b=WuEI9woGpD6JQRAxdF/GiVs2Ks/UKD3w5c6DVccVs/B0EUhA/4hKWXc9+GVhVJc5df
         KL6Sovzv0LhhIhQkm8b/Ryjwn0EhOT1bsi3EUcl8JtP/qSSoGFHN4Ds+pInWb0BVzWcm
         CBMCYZaZaTB5836K+I7nZ348UX4XE4AReuBYV7lD1GAPNFOoCXORHu7zWTfnqiBQHrP6
         260LQ5ZhGxKa0tX+xKT/BhQg0x09RI8yFtQv+Cau8oaFmniPUyQaMvpAJcPyAwgGmpRS
         tTdqura+h3JaOoC1Js/tt6/viwPSOCCBLvITdGL4VH6GKP+FxkMkOo6eXEblHYobAyNV
         RHXw==
X-Gm-Message-State: AOJu0YxtBIhR6KnveZq6hc7X5kRWLg6iJ5eaORDdtpuiciW9VtKEjItA
	hmUiBmhq1KG/cyHroHol7n+odYuamB7UiyZRneBTmU+aA7E3LK7eekhODyik4A==
X-Google-Smtp-Source: AGHT+IEz28V+pQaJpXndCtgDVpWOs2o4+wkjG3HQ2R3vI8fbqY0Bv2xxm5JeBQo3gbEpFnyg4+fZWw==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id adf61e73a8af0-1c699559d86mr17649446637.19.1722999831794;
        Tue, 06 Aug 2024 20:03:51 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece4967sm7533616b3a.138.2024.08.06.20.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:03:51 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:33:42 +0530
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
Subject: Re: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
Message-ID: <20240807030342.GH3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-6-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-6-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:19PM -0400, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4d68fe318178..948fd4d176bc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge_reset;
> +	struct reset_control	*swinit_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->bridge_reset))
>  		return PTR_ERR(pcie->bridge_reset);
>  
> +	pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit_reset))
> +		return PTR_ERR(pcie->swinit_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
> +	if (pcie->swinit_reset) {

You already have a callback called 'bridge_sw_init_set', so this 'swinit_reset'
is different from 'bridge_sw_init'? If so, does it make sense to move this into
the callback itself to have all reset sequence in one place?

- Mani

> +		ret = reset_control_assert(pcie->swinit_reset);
> +		if (dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n"))
> +			goto clk_disable_unprepare;
> +
> +		/* HW team recommends 1us for proper sync and propagation of reset */
> +		udelay(1);
> +
> +		ret = reset_control_deassert(pcie->swinit_reset);
> +		if (dev_err_probe(&pdev->dev, ret,
> +				  "could not de-assert reset 'swinit' after asserting\n"))
> +			goto clk_disable_unprepare;
> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
>  		goto clk_disable_unprepare;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

