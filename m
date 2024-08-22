Return-Path: <linux-pci+bounces-11991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97795B22A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6781F24235
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684F1891BA;
	Thu, 22 Aug 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5ZNT5Lk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897161865FD
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319773; cv=none; b=o8/Yk7keDc96PdVNGxUgZMwmENQws2Jj+2qtFZNJ4bkKEt2l2SsQWUQdxMyp2SHzzBeIisailQj2UByIsbsdVnnQRdBwLCRn54dsTRJd5NlFrI2jqBoXGDmDEWziCsGx15qKGxZrzlwZhdJu3MsKwKtkrGAoFHnmLEpHoBZDayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319773; c=relaxed/simple;
	bh=addi5O1iO8rPzp7Xba1I/SVDBMpDp0inLY71MiioA78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2mrEOvZdY0qOZakXFqZqcNIhN3VPrP+LdWfWBbg3yM4gF/ckSKbyjLqQmrZzX3Y160xZu6y/onU90YLTAGllT6TrSVmtuDuLFiPUA8zo47Hj5yYIb3QJDBUvbwKBLtcKOt4KgfDtvoB+xanMdQ5YI6Bwg1UMw0d/sLLfwlAABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5ZNT5Lk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fec34f94abso5611115ad.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724319771; x=1724924571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rT9nphr3FBy8w8TlOkDTcSqop/iUievOqu1C/QTIuD4=;
        b=c5ZNT5Lkf7Woof+RDwAmTdBCUkGwgHzZJ9vwFSQfvVVMcEj+aQF2Tvdh5Q+5d1zeM+
         sa6RP9LuW9h300308GXQ4kTk3urVDoD1/R9BhINzL0A6V/SVCbL/6g5Qy4L9Rngtuu0t
         0HKMCpj1dD2CUGxcdJ/Ri/KlRayIEnVp8E9gM2yocv90gCEVKNJ9VnPgPGSVauW+bOUn
         lOLzkatrVy4P5EUXxLUu6kEWcQGyA4j6QvDTvK/6lmVuxya86EgPaQvwOJnjIIjL7Es8
         gpTnuKnfM/c5YBgVvJWCOTc+QoxyCKBx3zCDTVgKynK5CHnTQAYP62EZ2obzI/IwWLtS
         Oe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319771; x=1724924571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT9nphr3FBy8w8TlOkDTcSqop/iUievOqu1C/QTIuD4=;
        b=eUZSOBGuSypoucQWYS5l2Ug2p3yNzkPYeXQr0TEcoh/U3fCm5vPsJHhEsitHeqe0TA
         DF6YPhCkBmOhhroTbALRl5oG3Z+1NO9jS3GhFUnyzfscVXR14eIlQ/fcfEbOMVBaCIBZ
         wIQWepRtHxC0dPzZJG+u2pI81nW69x+5vBU5u/U/KEckwjt070/7MVYXQRglNaYHvOcT
         2n+MObf/C21uV5gxBHbFFzIsaJjXps0t9g9XxN5N3m3Jobexod00wH7FT64oomgdc0Tm
         wBJ8iACqZpEoQBa0tZb9ywX0UUlelhsyFusXux2dMoqEXjCbLVg+5HQT+3fzQRWIlNhY
         RyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU415o7X2DqCJMgGf4kgs3TBwqCX+zV3ZSe0rdL3PTcVBVQhZLuKIhNl8FvMCkRytIyg01JQ2aS6IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZ1fqB+x51JZxVh+fIR2CaivCBEq/SvUqMM+N2I+KDjz8ii+F
	YH0XnpO0AB1hbXgI8nslXewz/Ch/Huat7IzEZoewWC6+N4p4zTCAQmZlwGl5qw==
X-Google-Smtp-Source: AGHT+IHfsANLzJW+TqoOiWeWY8HxcLe//pwPC8OGFSSjXI3DlfJLCyXQY4eLQyLzlBfwBgYxNwVtwA==
X-Received: by 2002:a17:903:22cc:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-203881f3792mr15614615ad.5.1724319770860;
        Thu, 22 Aug 2024 02:42:50 -0700 (PDT)
Received: from thinkpad ([117.213.99.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038b7ebe0dsm6850535ad.287.2024.08.22.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:42:50 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:12:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <20240822094243.b7crebodnbb542te@thinkpad>
References: <20240723151328.684-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723151328.684-1-johan+linaro@kernel.org>

On Tue, Jul 23, 2024 at 05:13:28PM +0200, Johan Hovold wrote:
> Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> bindings, which results in DT checker warnings like:
> 
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
>         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> 
> Note that this property has been part of the Qualcomm PCIe bindings
> since 2018 and would need to be deprecated rather than simply removed if
> there is a desire to replace it with 'vpcie3v3' which is used for some
> non-Qualcomm controllers.
> 
> Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 3 +++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 3 ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 3 +++
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> index 0a39bbfcb28b..2b6f5a171f20 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> @@ -78,6 +78,9 @@ properties:
>      description: GPIO controlled connection to WAKE# signal
>      maxItems: 1
>  
> +  vddpe-3v3-supply:
> +    description: PCIe endpoint power supply
> +
>  required:
>    - reg
>    - reg-names
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> index 634da24ec3ed..7ed46a929d73 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> @@ -66,9 +66,6 @@ properties:
>      items:
>        - const: pci
>  
> -  vddpe-3v3-supply:
> -    description: PCIe endpoint power supply
> -
>  allOf:
>    - $ref: qcom,pcie-common.yaml#
>  
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
> index 25c9f13ae977..15ba2385eb73 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
> @@ -58,9 +58,6 @@ properties:
>      items:
>        - const: pci
>  
> -  vddpe-3v3-supply:
> -    description: A phandle to the PCIe endpoint power supply
> -
>  required:
>    - interconnects
>    - interconnect-names
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index f867746b1ae5..ffabbac57fc1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -91,6 +91,9 @@ properties:
>    vdda_refclk-supply:
>      description: A phandle to the core analog power supply for IC which generates reference clock
>  
> +  vddpe-3v3-supply:
> +    description: A phandle to the PCIe endpoint power supply
> +
>    phys:
>      maxItems: 1
>  
> -- 
> 2.44.2
> 

-- 
மணிவண்ணன் சதாசிவம்

