Return-Path: <linux-pci+bounces-24494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255ADA6D578
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536DA3AABE0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A982500DA;
	Mon, 24 Mar 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjgUCvOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7B13B797
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802786; cv=none; b=GJhyqAt/mgkmsSgpvdxQZHSE1SlmUE0pcmcngP7Slj+hNhopgJaWAEg4THWKMs/1yuocf2bslX5IDP4TjsCIEpzPqLJSE5V33FIF0FJKUtgOIuyDOcZWOJSR5iwO1VTGn6jtZgxORBIL1ZcuFWhzv8zB/w02EUi05JvAvm8CYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802786; c=relaxed/simple;
	bh=4Ea+mxTlq3Ce/OhMKbQU/KOrj+GAvnVEVIu2gZtDLPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm/DjJ7Qr+1SPezzYHvk/Asci/h7AJze6NmwOnReEG+c7877sIrouZNNFVk6ghQ8GZFXgma82QwbNi9FjF9Vt0bPzVszpLs9tkL56ZLiIN+QtS0tP/xlanZk8YW8+4adT2D6ZMWJKQ6dCKSw3WNk7HW+IqUBPQ9yvK3AN7JZzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjgUCvOc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225477548e1so70444305ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802785; x=1743407585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pb0coG8ELzx5NL39dsEd5n2HDvAmuNrsLf2r8J2plFk=;
        b=bjgUCvOcCu9+XvK1UCrl6iAAW30Sc1tTagzyq5T821wVV7cyk+nuLE3I9OsjGFmUFh
         yq3XzMtfElpkb0s7R2RgxF/hh9SAr8k+1ysC39RsmkA1Hnm91C3K+Bq7agkKuMWhU6Xs
         9nlsBMhG8zXP0SyONL8WYglj7AFdw2Ax3m0Q628BSSAH3qNjIcz17SH1+XyiOXOxd55m
         qiNkQFY22ETtyqwdf521GWaHJtaXmzRU3tCP3kaUYUk5JbF8fd/5i4Vp/jGrqefMxTOq
         Ds7VYeyg/x+l139LkWljqfakkMoVkUqJSu5qFDKHZV0idoRWfOU3rGNM4aEFm26J9/Ml
         xmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802785; x=1743407585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb0coG8ELzx5NL39dsEd5n2HDvAmuNrsLf2r8J2plFk=;
        b=pNypmFHSufpHfBGAav9bUHeVvFl8oRMcdLgPixlCAHaOTKp9Qtlb+LaDyCpx6n58h/
         lgiPfKJv1Y725m39xJEYKxsX/zhx0hNOGxzTMzh+TOlSY7hEuiGYJaizv4NgDb8nVZiL
         e3cgus0AMFpMZKrdvf4rdhDjlLlFy2g/6yQt/xrjWWBIf6k9P/NYXLvLjEf9dNScvBc9
         KU5xKqA+ADMTtOMMkOf+65HbYVr0EIUz6e5M4YIpVoTA/BmC0b/8j8YOTgFBGpdwtyS5
         i3Anf3LM//ni84Tf8cffbjIvdVB5WDbi2dAuoz/savjDIkYwt+f2yR7npWuSoW0Kyd82
         pb0A==
X-Forwarded-Encrypted: i=1; AJvYcCW7+Jh5dHTxKKT0Ao1D1bkvTA7FTyJrGdzZBj1lOi75mNp3Zkz8zKOlFOZk/kVPunr90tc6J61mFBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysR+4oJRLY1wBjsp96LfE1KzmlS+k+fPEZXHSscm2+dbzZHJIq
	LuyW4Ciceng+vdUs97Gajd8m7cf/6g1kglYdw9YEN3md5ix0v/8o3hTF8nxYDw==
X-Gm-Gg: ASbGncsDyitteBdthX/sMAmM3pNzoD9kgV9MoQwh8Yf+vTgKgMo7YiDQXtNGtuM/mEd
	pc36Edny7O8rYtmDhJRKe+L+vHQAqxNxUxIaMYmHr9e3jslLYQnZ5ORZY2zFHXb0Bw+aqsLaNr2
	mvZ0b7hPpNBjPYfo5IRly7EUiQXIjpd1D/TEqOY3h0MGBLcB6Vn2SwCw1DiF6X7dlSNVWboOWy1
	6fdYZqbpC4O1sOuKJEdS5vTQqo664UHZwSVkGQnyhO8lBiVvbya8Ur3W7KydHpYseFFhJ/Qt8jx
	r2gQIzZT0W0x3SgXuwVP0WPtQVwh35OUMu5E7i+0W0IvVh5bkuVYkOCN
X-Google-Smtp-Source: AGHT+IFuvV2cV8WX5aMgqIPZN8PMDNislgN7gD7Fd0kyz13UcCKy/E1fYKahvWMm/QdrilzlKJE56w==
X-Received: by 2002:a17:902:ebc6:b0:223:39ae:a98 with SMTP id d9443c01a7336-22780d825c4mr224115485ad.22.1742802784591;
        Mon, 24 Mar 2025 00:53:04 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f9a68sm64496325ad.241.2025.03.24.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:53:03 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:22:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: george.moussalem@outlook.com
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nitheesh Sekar <quic_nsekar@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	20250317100029.881286-2-quic_varada@quicinc.com, Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Message-ID: <uenisk2rrlx5sh6xagd7texx3dpxyav6yxpqxmk3fcdq44vb75@tk3pimdajilb>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-3-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321-ipq5018-pcie-v6-3-b7d659a76205@outlook.com>

On Fri, Mar 21, 2025 at 04:14:41PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 469b99fa0f0e..668ff03f2561 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5018
>            - qcom,pcie-ipq6018
>            - qcom,pcie-ipq8064
>            - qcom,pcie-ipq8064-v2
> @@ -168,6 +169,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq5018
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
>                - qcom,pcie-ipq9574
> @@ -324,6 +326,53 @@ allOf:
>              - const: ahb # AHB reset
>              - const: phy_ahb # PHY AHB reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq5018
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: iface # PCIe to SysNOC BIU clock
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: ahb # AHB clock
> +            - const: aux # Auxiliary clock
> +            - const: axi_bridge # AXI bridge clock
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sleep # Sleep reset
> +            - const: sticky # Core sticky reset
> +            - const: axi_m # AXI master reset
> +            - const: axi_s # AXI slave reset
> +            - const: ahb # AHB reset
> +            - const: axi_m_sticky # AXI master sticky reset
> +            - const: axi_s_sticky # AXI slave sticky reset
> +        interrupts:
> +          minItems: 9
> +          maxItems: 9
> +        interrupt-names:
> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3
> +            - const: msi4
> +            - const: msi5
> +            - const: msi6
> +            - const: msi7
> +            - const: global
> +
>    - if:
>        properties:
>          compatible:
> @@ -564,6 +613,7 @@ allOf:
>                enum:
>                  - qcom,pcie-apq8064
>                  - qcom,pcie-ipq4019
> +                - qcom,pcie-ipq5018
>                  - qcom,pcie-ipq8064
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
> 
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

