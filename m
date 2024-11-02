Return-Path: <linux-pci+bounces-15849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407FF9BA199
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737901C20A39
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9391A7265;
	Sat,  2 Nov 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N68CZOT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC49171E76
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730567478; cv=none; b=MwBRAe9Tgdwo9qwiIjSqJw3rv6pTyPsSAMz3IqPzjbjfSC59fnKyIUe67eyia+bqQNVVBJ1b5i+koRtiHcW8OvuWbAQSiL8BRHr+HRjmdl1dFJ26zoM9c0WHPjH9i30b9UppTzg28os+QLRF7zwFbC43+u6cc6UDnAGo2W7R3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730567478; c=relaxed/simple;
	bh=k1KIRyvPe6KpMWttwuAoqiKm9nKOdtspGFDhZiasmY4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQjPD86i2FYBvyEBfum2nz1cbSKgZ0BuhxxtXJXFu+uR11AANm4u18I0ghewXOmSrAsVbuAHtDghbX1UeHPWn3UPVpk8Wbs3T85rCgYR6caKt5HEQRpe3dsQTWZRmVRcUce6yVlVjqptA9ql+GVrIXkb1au1FEmXGPDKFm7dWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N68CZOT6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2306754b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730567476; x=1731172276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naogVYCbfHgepmXtHeIUqBrExKR0wEfnf5gnXKOTnEI=;
        b=N68CZOT63uH3CFzvKlDJcK+d4AiWqyCwbIGCKx8XMu3OUlmDNmZLcpdkEzpZpU/FqJ
         1JjK9OMwrszXk905RZcbebTH8wexmRSsm9bA9qnNU9u8X51659HuWUbeZ5C5kmFKlsIZ
         05UcZqz4OTqk0vQ5b8xcKu14UwPZZND5m72MNEG/8bU0i2FFtkUhyFj9dsMOpy+WJbrG
         0+cIMifFc3UtRxQjZO1dMGBNgbr+YnDG75os98oY/99fGMWsUvRa0Hj2pBb6iXQ3T+yW
         25OKHtzai25Nnn8qiJdCN4YqbPIziYvAPqm1k0KvWaygIJmpZhiyqL8+9mCVh4pnjO7U
         2HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730567476; x=1731172276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naogVYCbfHgepmXtHeIUqBrExKR0wEfnf5gnXKOTnEI=;
        b=Pdbt1/BicMT8QBasnMmkanND7DZ8pUIfR2sUNuzlSBNuHBtU0VQSmwMkbocf/3sQjp
         CGOadAxTZTWrwrDcNPybnxxZgGkTrKENaJPLp87h2853BPFt+Kr2gsKJGXVM+L7DzAKE
         S+gge+mT4katwxnUse9d0XNuUxmPHi+5Mf0T6SSUI8jFZesNLXx5wHXJJ+oPqRiI69BI
         w6SaXDmovF1R6Vijp9yCrdmOfazIfTxjzqe4t/1PlsCWidJczeSiySkYCfJAh2pV+o8k
         oo2liCqn+n3SSmDOLM8JTxjplaQdRTjfAt6Wy1muBDR+Q7PRNAgWPzvjLAk4yjgubCqM
         07Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Mm6/2vwaLpZgN/R4pEq72YgM4qyOAWXryaCZFKIPrKpXi93TlmZJbR5K1jOkSeNgm8n09MtOoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfIRgqBRXHkOOVwNkoB7hfnt5Y7+rZ46WqhB74qOUj2W8s2eG
	36lRC0pVVVAqvQOJQheSXgSsRUhuT1kbbQ7w2CvNgPKR18tiK3rIfpEbuQTLzw==
X-Google-Smtp-Source: AGHT+IFGrKry0GXdqZw3UiEUAt/+TG/WgyYeK0gfkTWgNav+BbUqRjfMgVsN5xWLgwY90mfcxhLeXQ==
X-Received: by 2002:a05:6a21:1645:b0:1d9:2694:44df with SMTP id adf61e73a8af0-1d9a85354dbmr38139599637.43.1730567476034;
        Sat, 02 Nov 2024 10:11:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45296c97sm4042866a12.14.2024.11.02.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 10:11:15 -0700 (PDT)
Date: Sat, 2 Nov 2024 22:41:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: {qcom-ep/tegra194}: Move endpoint cleanups to
 PERST# deassert handler
Message-ID: <20241102171107.p7j44qsi6ojokrmz@thinkpad>
References: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>

On Sat, Aug 17, 2024 at 11:09:02AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series moves the call to endpoint cleanup functions (dw_pcie_ep_cleanup()
> pci_epc_deinit_notify()) to PERST# deassert handler in qcom-ep and tegra194
> drivers. It aims to fix a crash that is seen with Qcom endpoint SoCs when host
> asserts PERST# and the cleanup functions are called without refclk.
> 
> During the review of v1 [1], Bjorn suggested fixing up tegra194 driver as well
> as both drivers share the same design and require refclk from host for
> operation.
> 
> Testing
> =======
> 
> The Qcom patch is tested on SM8450 development board. For tegra194, I'm
> expecting someone in the Cc list or the community will do the testing.
> 
> [1] https://lore.kernel.org/linux-pci/20240815224717.GA53536@bhelgaas/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Can this series be merged for 6.13?

- Mani

> ---
> Manivannan Sadhasivam (2):
>       PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
>       PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()
> 
>  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 6 ++++--
>  drivers/pci/controller/dwc/pcie-tegra194.c | 7 ++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240817-pci-qcom-ep-cleanup-740745e21d87
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

