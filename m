Return-Path: <linux-pci+bounces-17343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F619D97C0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DF4165EC9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28DB1D434F;
	Tue, 26 Nov 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUZNBKqo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224A1D416B
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625785; cv=none; b=sIzgcFwgu0223P0hY5fpXkSsWoB7sk4uYpst5I9nXM+BmkOwj5thrfyzTLFhXJ+bx55EDPclin5b6YgfCipAXyUsY9wFNiWc5+k1EPAAARaYfSz7ryXmvnPoYp+TSmOm/8TLqNHZykWsV/8dF4fIk6hKFg5IaVYqVhN4t+RqrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625785; c=relaxed/simple;
	bh=TfjTGWQaDFmp9+wS6+9ipI5j9jCprYMO03bsaV8msQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fArYyvnd48PSrfqbngv/lTvGfudNJijdgdE6G1nBYb3QRz0ncABHIH6rgJgfUBNWwzZHwcrQIEPaX8eHtRjNcWWcnqJ3GVWW+YeouHQat6vtTGbd+THlBPJDkE+THgqqZ028FvWdfcJ8dFM2YZE+E7+lugNEuf/f780Sud2MQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUZNBKqo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-214f6ed9f17so1575495ad.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732625783; x=1733230583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YY215mVBF/BsyIyjPcQ5YdAmE/7mcXahP/kNz5RyMwA=;
        b=tUZNBKqoYN5o9F2YcDoN5qwCVmv5Leka0vhz1kNI1bZLv13ecMRELbhRCZZ3XUi/jp
         HUqytxkeMOtxdO801G1fYdEC1Auy8x9BMlbqp/uCMBbPAjwl/c1iFDdypFHUTvJhRbAD
         6uNSTiUfOCRGL2lL0eoymokAJTVataOZvUSg3XfdtCNxN3wzi+foKhfzG5ZG5yI33Lpj
         Y6g08Lc1PQ4NpwAH41U0qLfDAN+evzz+rrGfi+CoZw8X94/j52kwKh3R1TRxgI2ryfzb
         bJkyTo1vURXOJew30cq87YH1R8usbHFAu+bsmzDDypXFjxshJX8Bb1rsJwnsNfyy7gQ5
         5MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625783; x=1733230583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY215mVBF/BsyIyjPcQ5YdAmE/7mcXahP/kNz5RyMwA=;
        b=fgclVg2dgGQxtWZKNbMsHT2mX7APtIgPGzkccnNv8cgo/URkvl+4562NuUD5epeDHI
         5l0Fl6FIduMByhZYYrnzoKOh59BOxlUjH4YG+wVbBX6kPUs95E2bB5LELwmAi/XOfVPc
         6cdLtr13FLFkjo54UfqfB9QzWrcLs1OgUAh2X17Ptg556wjHckpz4rlEAbSrhqrtsySP
         nEHNoLDLm7L5gq+6t02Dncmw4WLqs+v32g5UoYHjMcKzPJKzd471leyoQZLzfa1lloqm
         JMLXiPAHn8uctdK+GbFKtcdWc5Drv+sZqENumO5peUyevrsH1N6DisFbDuX1C9ag+M8G
         T00Q==
X-Forwarded-Encrypted: i=1; AJvYcCVILJrFZCJoDEMLLOD/l4NbxgyIwtIi+nwsr9ut4GQSv6aZQP+6OXwrVCC9F8zO7yGQuQuvbX4hgWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0teKtBzadggPxrCJbbRHyIa5zSGn2fg+P7hNAGq0aDbLEDKYv
	rbedW6uCXTxFTvMd3wgO1W7Rs6aYGxqbN/XXJjxKkTSoMrv+UjLt1ZFTfuvY1w==
X-Gm-Gg: ASbGnctK5pQqVPjMH+iVOYmm3nHgemB3E8tIW5WvEz8u97r5ig8n6Q58BJ4EkEceeTe
	e6QQE+XA2vwJMj+KCNXo+g9c7avS9RClJzDZ0rddpxphwRsIrIDYt8rL9NJ931woZf1hNhKh3a+
	1UdQ8r+p0fcNKZ+kKFWTFrh1Gbp/hJnts1dZibgpfSdna1kiiEKJxNi7Glpy6uf3NfZXxlNujwS
	CBaanW2TfPl8LpNV/UHJGdpE1EbUuZ4CTaz3yMAzlRhWnCbCDOcCHT9cd69
X-Google-Smtp-Source: AGHT+IFGZO6YwIydzhnaKn6anetOGg2+48yG+FxdkhfkcKfSo66F6npaVl3d/51tMhwslnENrkjuQA==
X-Received: by 2002:a17:902:fc4f:b0:20c:9821:69af with SMTP id d9443c01a7336-2129f797977mr204224095ad.45.1732625783658;
        Tue, 26 Nov 2024 04:56:23 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2210dsm83601765ad.245.2024.11.26.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:56:23 -0800 (PST)
Date: Tue, 26 Nov 2024 18:26:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <20241126125618.v7spvqvm4cdqpa5g@thinkpad>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:51AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 01ac3769ffa62ffb83c5c51878e2823e1982eb67..f394fadf11f9ac1f781d31f514946bd5060fa56f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2233,7 +2233,8 @@ pcie0: pcie@1c00000 {
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -2241,7 +2242,8 @@ pcie0: pcie@1c00000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  
>  			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>  				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> @@ -2365,7 +2367,8 @@ pcie1: pcie@1c08000 {
>  				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -2373,7 +2376,8 @@ pcie1: pcie@1c08000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  
>  			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>  				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

