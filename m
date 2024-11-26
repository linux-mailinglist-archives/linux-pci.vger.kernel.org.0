Return-Path: <linux-pci+bounces-17342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7B9D97BC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42676285FC9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A581D45EA;
	Tue, 26 Nov 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMYVFlay"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2911D4324
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625766; cv=none; b=sS7upyrOzcfeXq6Dxptq/h4L+h4Z8a74/oq6/AdUh8tqWQ+Hs4PZgLi0JfYZrKfAeThkxHOktHlXtxG93nk+ndZBOkUeWag8RNAkBkyukeDRRNjgQeze6TVLsCL2gDXb5O9t8LryuGUGI5CrcEiVYCkDx/nKESLdYMAOCrVVqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625766; c=relaxed/simple;
	bh=bzBJ5ySU8iyC+cTGOrqLjv/wf4htjtDCeE2Z/8l0Yew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UymuH9dT32bRqtWKmLlJ83y30Nzpz7GskaghZW+5W5FgdrRbtCgyur836Apqbl0zRNIfRu2ZN/oFv4qaC8z4VIYAfmHE5yxYE32ENGXJlVnkNxV6jCuoRJy1oZB44erHJPJAMTAnYXMjNaaWn04xwmS/kuj5/J0GBCrhPt92fUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMYVFlay; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71d4d3738cdso1049047a34.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 04:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732625764; x=1733230564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dXE3QYJ5LikeczgQTvHoKWrWw3sPXnz+0dNSvQEom74=;
        b=PMYVFlayZbYKDjEyVTe5fZj74kzP54VAZ/lHXm4fqVF/LvelXMGdUopWDfJG+A7TIH
         Wdc+NeTyppMffNMciIJvha4WFY03DoVCPJo4ecBg3U/waVbaxQdlLkKDVdJ45I1CNkAw
         3M+qZ6RrcME5lTjpnYFihsS8u8nlECyxbuo1PdKc18EukNyl0B3WmAsxe3K3E9u3aRKF
         Dk/Ff/tifeLb+TWZfcioitKpzsH3KY+dm5iEjXoS78Mxki+GMLqooWzksW8yBWj0jSM5
         E7g41da/hePC55oE3iCmQSYduxKwgQXFbfcT6WyXfBaotmly2kf1xwUXJEM6XyllQDd1
         l5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625764; x=1733230564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXE3QYJ5LikeczgQTvHoKWrWw3sPXnz+0dNSvQEom74=;
        b=sFMwuQRGss9x1UAZcXQLj8bekcTfFwVYbRijTDIyw5vXrZuGleuuv4ZYC9Yetcga8u
         RV8sGG5IiNe+UcUgJpkv0m2OMGt6x/ILiLZW661QXjQvGjRiEsMn1OHbvcWv30ojEUtA
         nD6QC4OGg2oO79ZupR1q0LTa1inQlFVhLTFmgsmbRtEkCJKHM+mz4YGf170bsXcnDYxF
         zamOS5ctbyToEMA/CBs0dLNvVf5E1voibRwRG5BykezuWfXKlMHkWQMKmblMIT8wA7XB
         J1DdEPdXgiaJlJGgwu2Qn54IwsKFsEW82/CQnNE8wJXMI9/lOhPL0itH7Xnkc5JCBl79
         F6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdaqtYWmT2MOI3z2+K/hrhwXl6drip9FyvTdTy9IMN8ChEfJrNdEuVOhruPNPDuHHbHpDOIXDiU4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpY2LB5rapBxUndLY146iigPfWFf0+O/57AxZ4FVC1RPHUsRMe
	77F+vv48mPJH4esCuJtRjikPLlNNfjNZifmNqt0QlSYZnwUNswnWS8kGpT2AXQ==
X-Gm-Gg: ASbGnctppaDB/WWN8c8blZUWgYU6BAO0fwEycLR8up4Gf97VB/snZ/DNDXDzrgKhq/1
	xGzuM8ig/lHKOfNiUL7uoUDQB4Z3XCoWpHMXQNuGGc2kLrCSNLtktTKQORo14zGYcQa3c6S87K+
	FxxP3cBqS8T88U8we6f5NS2VK4wYhOHN0MO0Moj+EJ5Y+VDVYwIS71RkAsPIKXRr4t/ceZbWF65
	nXp2WUsiGPQXNK3s4pQttC/RW2QXNqEsuJNR5io5B8+TOhycKKIQxzdaipA
X-Google-Smtp-Source: AGHT+IFNm2gT/rtGSM3QDKFPVSFCgKiQoR/R4Xr++om1Vj/nQzObB88rsH3X/oaoAwNa1JWVmpMuRw==
X-Received: by 2002:a05:6830:6403:b0:718:4073:62bf with SMTP id 46e09a7af769-71c04b7eecemr17953453a34.7.1732625764057;
        Tue, 26 Nov 2024 04:56:04 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3de284sm8598526a12.55.2024.11.26.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:56:03 -0800 (PST)
Date: Tue, 26 Nov 2024 18:25:56 +0530
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
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <20241126125556.oncvvkyrwj5s7u65@thinkpad>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:50AM +0100, Neil Armstrong wrote:
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
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9dc0ee3eb98f8711e01934e47331b99e3bb73682..44613fbe0c7f352ea0499782ca825cbe2a257aab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1734,7 +1734,8 @@ pcie0: pcie@1c00000 {
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -1742,7 +1743,8 @@ pcie0: pcie@1c00000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> @@ -1850,7 +1852,8 @@ pcie1: pcie@1c08000 {
>  				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -1858,7 +1861,8 @@ pcie1: pcie@1c08000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

