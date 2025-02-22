Return-Path: <linux-pci+bounces-22107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D3A40A39
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FBF18890C5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458A1D63C5;
	Sat, 22 Feb 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2Hk913w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41812D758
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242762; cv=none; b=FCXcbTp8IOkTPCSUaMf/fwXx0ODh8J6GHAD4tH76w3Xlir1lWCCFhEySPk7cHqTpTcLBRlDPdy9b4eIJtj9egvsMv9CfFqvLzwoQU2KjM+w7HmxrIoP4aKDCc8BF0YSqDU1LUa8GgMMzeFM4ugT3YzRO1Bof3VeXdnzao667zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242762; c=relaxed/simple;
	bh=HbhOkf5va9izRWN4DhX+2ILrR2FahUcR5Ju840IsDmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LylGDSKNX0b3PYeFn8Drvd0qXXVK0asEhwcsIs3qn8+Cj0+CfI74kALFJxMNuthuSaM7R02KSh4P1Se4z5+uBdNjsJO5TSvlAzQD3OC05Q7qgm7ty43AkBW7GUR1JOGwel/Oc79kcIsIEB+FyAQ9zFaN0JpTC2mdLSx+GMmFfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2Hk913w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22114b800f7so60229915ad.2
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242759; x=1740847559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npHEnlQklkIzG9S0yPJOdrGcjNp3Yqbn0DwAvN51LJ8=;
        b=K2Hk913wBWdCBXJqs6hHfxZNdbIiuQUPwSwJmT7Kdm63TTmkBCl1WUjoUGthjPHROg
         g7akvXbrEZyPAdB+ucrMT7O3oO2m/kkuKMwFbpvTpn0n3ABdJEHsOMiBk81hlef+DXkw
         lXoLq783N+ORHeFd9yZqcVCVkL0pcWHGBCfTX1o1TP4nHtDbBYnGs6LhDeVsx3ZvXNuF
         TkA01w2pMKEOvu94UF/ExX2OoEte+n+IXyqGaY4kwKmjabZnNTJtR9jZqlbpDt7z3Ei7
         X87oaIrrYDJ/RoF5yj0edUUngeI5Rdws8qHOsCz5/RqYeREXBXkNc+J4VUtjHkC24WRa
         txig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242759; x=1740847559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npHEnlQklkIzG9S0yPJOdrGcjNp3Yqbn0DwAvN51LJ8=;
        b=XenH55q450AU8B3QWJG3hhS7knFeBBHlFytzYTjWFlNyUto3oASF+VQB9V5E/3E2WG
         irk/FiGrls+rF+bzWyODzFh9XprLD5mtOiMXKh9l0YeDyhe+hB8ZPoxuWyGbjXqjIwEN
         /QSFwPF8+ieeiKIvv2bdES9FtZqWUwWI7224+OE1OBHow9Tj6bmzyNbJmahLKAnzMSbn
         KzRgreF2G4jGZTsb82OrLZU2EGYxBN2AtcRt5vYWQsnqXxABvKDmigQZCs6EXvqnhmik
         vG2aRFepuwgsYsKw05/2z5nR2guQlnXQ5AYlL+VSPxihC+Pam812qZSr9QeXUI2fp3LI
         kQUw==
X-Forwarded-Encrypted: i=1; AJvYcCWX92TKgwMwucGtfEQr6DAACoyyPDmjFlBhIeJKa3eWjiP62Mp9R/uxicV8PrxLzVRKU5vFrICr5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/Ysw08rBiDD8vuX2S379eb/IpTtbR7v0WAA0HQmU9DGiOF8H
	8Bhg5SW5PIY/ykDXgVRUNygzcd7QXvjpXAOREDLcJ8oUpFGnFMvtXoxdJgFlzA==
X-Gm-Gg: ASbGncvrNjfxU2v8dutJyic5rLNe7lvXrJ8Ic2nQvyACM/Swwk0cCFMN6a2CD6yitSs
	lajkaZIB9poSw5LVYjIwPYN9L7rdFuhcjKWTvYvXsH4YJCasa5p1y1JF88KyT3E/txrdzsLUfII
	gTU4Lnx+o2r8gIWk72kBRu4OObr/uDHh4YJx9unVDtxd7oiK6n/uPL5ThexzcLDt/QqDK73tddv
	t4v5P1s7/NSRnmi5WjDxPt2UPQyPXNcTIaUP/UtjYo3ZPI9wBfLkp+cZRrBxfaazFt4C/zXq79p
	57oUSBIDClolmtUZEZ1UchL2dMtc+gp/Q3b2dw==
X-Google-Smtp-Source: AGHT+IEAg9fXG3M0fKnjbzdl5VZ4lVQEn0XTGMRwRl+F+PVh6Z/VGrlb+f87puQR4ZYwRqZLtT0tTg==
X-Received: by 2002:a17:902:f550:b0:220:e63c:5b13 with SMTP id d9443c01a7336-2219fff4ef2mr110406945ad.46.1740242759049;
        Sat, 22 Feb 2025 08:45:59 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm152627855ad.112.2025.02.22.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:45:58 -0800 (PST)
Date: Sat, 22 Feb 2025 22:15:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Message-ID: <20250222164550.smiisjruiyyket6u@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-2-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-2-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:00PM +0200, Dmitry Baryshkov wrote:
> Some of Qualcomm platforms have an IOMMU unit between the PCIe IP and
> DDR. For example, SA8775P specifies the iommu alththough it is not a
> part of bindings. Change the schema in order to require the IOMMU for
> SA8775P and forbid it from being used on SDX55 (SM8450 will be handled
> in a later patch).
> 
> This fixes the following warning:
> 
> pcie-ep@1c10000: Unevaluated properties are not allowed ('iommus' was unexpected)
> 
> Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 0c2ca4cfa3b190b3fb204f0d7142370734fb3534..6075361348352bb8d607acecc76189e28b03dc5b 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -75,6 +75,9 @@ properties:
>        - const: doorbell
>        - const: dma
>  
> +  iommus:
> +    maxItems: 1
> +
>    reset-gpios:
>      description: GPIO used as PERST# input signal
>      maxItems: 1
> @@ -162,6 +165,7 @@ allOf:
>            maxItems: 2
>          interrupt-names:
>            maxItems: 2
> +        iommus: false
>  
>    - if:
>        properties:
> @@ -234,6 +238,8 @@ allOf:
>          interrupt-names:
>            minItems: 3
>            maxItems: 3
> +      required:
> +        - iommus
>  
>  unevaluatedProperties: false
>  
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

