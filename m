Return-Path: <linux-pci+bounces-20633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAAA24DF4
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DEF3A07FB
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653D1D63D5;
	Sun,  2 Feb 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQtiRviz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482F15ECD7
	for <linux-pci@vger.kernel.org>; Sun,  2 Feb 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738499137; cv=none; b=DBduQhXFxUl6kymt2mDWL6X7Bf1uP8wBcoo4u+9R67DyUcATP/8njTTxZaM8cKzjSylY2+fw6PW9jjCSdTZ4J3L+D+sfBK7NNLKugVGnFnYoMmN4k8/G7xk7YTVqA5N5wEplt15IaZ2m2NppYUc461nHf+TsQavNbmMJp0Q94Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738499137; c=relaxed/simple;
	bh=AKrFDaqSespToDeYf5ycPRVqYqGb0AuEW2tYGwEf1kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY0frqT7g52wb35tn+4y+SZBT1Suoy54yBXQFOHZ4bvEoPeaugQTPlip5o6bO/H84W4GO2Az24iMv86lUNiQqhz31bX/2Erq3Hhg0uvb/je96JVfSfkmJ/2YEQNqHNskSYay1Tg8HQI2PZ5ePokr3dqfvP7ipHsj7Nx2vXAHfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQtiRviz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so62707605ad.0
        for <linux-pci@vger.kernel.org>; Sun, 02 Feb 2025 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738499135; x=1739103935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uETwJAYLiI++YAvvMckAL69wPehGQ7drAEjc1+6UWe4=;
        b=vQtiRvizOxYKfQl1CTz9S7bZCUyc7ZO7Dz019a8tswW9nTyECUON6AGexA+umu1pVZ
         Yoh9pjSwtFKBywBAtDOl5mWioXsomPA6mutsEXV/GPWNpSwt9o+VGprS5lVA5QWqJnQs
         xPBIy547F993gbBikw0vIzMwc7uTuXK44k5JbxGYOV+tqLvcDguA2bDnZbbuAtuU4dtb
         RJHLXbGzJfa9albRRhllgQ98lv+E6FgsolrSvZRnia6XVOZbcf+yfezMZglDCd7+yLzS
         iFwfMrMasxHyBjAEhvUtX7O6vNJ3VJyXkrRoiODX9GKCzAnG8aH8jFQSxCUEREDkspDH
         TwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738499135; x=1739103935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uETwJAYLiI++YAvvMckAL69wPehGQ7drAEjc1+6UWe4=;
        b=CNr4Co5hyPLjQj/YACOtxMJrfUZgoKZA89eVWIG7/rKbSI710I2vl1T120O/T5EsGx
         KVBDZjcFp3quECLCwlvufXfqQQu6IIhvo33414dLBt/SO1FyCSyFzmuu19OlsBOoaZNj
         i8Ca1qgVkT26/LWpB//nVTLZy/dL3Bhi0qDP6r3VqRRDF7779NmrTspsu96AS4kDrVid
         0k4fY9dOxcvzDl3/bRm9C/Cdt8jxo+jvvJOTZavuaF+KtcbhxM8yjryXU7s0av4/c+Ls
         KYN+/e9kMpzr8e7mgTebIdJ9p3EzWMr7sWenSzAxppMDsT6Xm7CohAmB1ewiERFKtLj0
         cgDA==
X-Forwarded-Encrypted: i=1; AJvYcCWSWUefHqQZPV01fIZ6g8gtsNRJXPcsfTT87pkKBhPHvMuqdfcZ+z7oHAOrWpOP1Iqh5lJ4h4vwy54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuKC72HmnL2PTWY++/et8XQL6nWi0LuhJ5JBxN/Qnb1Luei0z
	o1NCS/fzpOyE7FlCLrLXRmpR2oAWcVM/MjWVGggd6NnEwvd189lSDGK9s6anyA==
X-Gm-Gg: ASbGnct0PpVg440D9YD/1TnNiS7paL/X9dzU2Gx8r5Cc5uS+nQJYGZ42g3kIMMIsSkP
	QkHTab43CEz+NOUYeqfPuoiHpoBz0TfiwvOwpxX6+Fjgd9aaV1e/5JE28dnWusxmmtVL6yKJDgh
	SP0XpxOBXhr5a824EUR/ZYRd6my12f28l+m/2zOC052Ei/9xtHtmAKbgTqz7/VGj0f4lEz8hPKm
	ZDsxlLU2RZuPI2ZJxZ29lF6dmI1TSLZ1bqHAA2ZhFzpmkOqnk/Xt+kzbJcIKQRB00gOpe7Njvbi
	HVM6Y2kqyRvLBYoqkjIC1mbz0DI=
X-Google-Smtp-Source: AGHT+IFWA1PkbYOvPhddgrggwj4vKffI2QbvJQaiOGMB+TdTMcR+A/IqI39Yf7APF00zFjplkX/PAQ==
X-Received: by 2002:a05:6a00:3a01:b0:725:9cc4:2354 with SMTP id d2e1a72fcca58-72fd0be1847mr24747903b3a.10.1738499135407;
        Sun, 02 Feb 2025 04:25:35 -0800 (PST)
Received: from thinkpad ([120.60.136.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ccea1sm6411268b3a.122.2025.02.02.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:25:34 -0800 (PST)
Date: Sun, 2 Feb 2025 17:55:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	jingoohan1@gmail.com, p.zabel@pengutronix.de,
	johan+linaro@kernel.org, quic_schintav@quicinc.com,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add STM32MP25 PCIe Root
 Complex bindings
Message-ID: <20250202122527.ggy5ccz7o4umyhif@thinkpad>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128120745.334377-2-christian.bruel@foss.st.com>

On Tue, Jan 28, 2025 at 01:07:36PM +0100, Christian Bruel wrote:

[...]

> +    pcie@48400000 {
> +        compatible = "st,stm32mp25-pcie-rc";
> +        device_type = "pci";
> +        reg = <0x48400000 0x400000>,
> +              <0x10000000 0x10000>;
> +        reg-names = "dbi", "config";
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
> +                 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
> +                 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
> +        dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
> +        clocks = <&rcc CK_BUS_PCIE>;
> +        resets = <&rcc PCIE_R>;
> +        msi-parent = <&v2m0>;
> +        wakeup-source;

Does this property really need to be present? If the WAKE# gpio is supported,
isn't it implied that the RC is a wakeup source?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

