Return-Path: <linux-pci+bounces-25735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E8A872BF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CE7A6F42
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D3E57D;
	Sun, 13 Apr 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEpMHURg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE21BE871
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744563555; cv=none; b=KuMncn1ntGGfi39fdCM434O/kfnkbJwLyPdF9Kzy41i1Zggt9neQ3mDZMc0dL58NDCxK+OpMi+x/6kFey7BVl1whlY62uK1O8Lm3HtEittq2jV+rP+j5jahsn78N8xWez4rli8Eqi2FesmzuoMLQH5CaYHO8+R73cbN9v7s8qjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744563555; c=relaxed/simple;
	bh=i17QWzXCS6ZCHtMbXDJ6n/FUUDwlQQ1PwIa3RJGSpqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L399YSIR9Zr5Uj1UxVRrWCbFsX/7YO+h7Yf1rL4d6iyRQ/3HurMrKlaKtUq1hDTBipG3KRcKoVjlr5heRSRymEedznEKtIE3FSoAZoSflQjyuqpRCrn429Gp0t0T537Xjgg/HTxFruuxwrAJLgqSE1bDxv85CPujj1ZJes/Rh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEpMHURg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-226185948ffso37362355ad.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744563553; x=1745168353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=noK0IP3zHzbpqWrnS3yDqlfS/Gp7WWrDNNCpSJyHX2w=;
        b=wEpMHURg8jAWFtRtGsWPvA1S8ZMGwvnna4BQOC40Fq9b7lXDFuoyeQFLp4VIsxeiQ0
         eAdM6KtX1z1M8XT5KFHR/cw1Q6bZkUuLJ77oFIhZxQJwZsjrTJDfzWCLWtYZbl5OW22B
         HeextLyN1fED2/5hjmplApPOecRkZLCrTYoNuyXjYaL5YMF1bFoeVeDJXasGYmrTaNIO
         nWDYd14clOKoi9C+UYpe+/EMKhNuD56EyJ0N7NPWp2kvhvXJXnpIDHM/gv5zIfaLhC3w
         +lv8we9ONVou7nPzOtx0OxQX9oxD6hu9/qG7sB8VifKID0ccfaVGiOGWNbl2xgbtkwu7
         noEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744563553; x=1745168353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noK0IP3zHzbpqWrnS3yDqlfS/Gp7WWrDNNCpSJyHX2w=;
        b=YNXWvvlEUKUb2ibKppRHch7xWQADGUONV2Zj4yGMmLSzkXqF9gDxoI0oXDPY/OtLga
         extRHiTtSlknkMP/chOMsOCfMJwnWqc4KsKhf7J6qwepcdaHTvgw63j6cARg0ho3Lgns
         hKOf6/wq0tJpqQu7AVsFhK2IQg3UmEgGoyUbKkz5wUFB6yyxNVGrnDQjQW1cE7IW5Gg7
         pKHIvg7GgC8LS2fBC1sIWnkDxxZ4XAMP+bOeMvZp/zOEnhEukPW8VP7wvHGO06BjQxXN
         ajs0ajMXIStenIzVP/pLp1N63DPo8ufAs1xfZ0KPz/0I/9Bn96H0uzX7x2QqqwoU/Q44
         t1sw==
X-Forwarded-Encrypted: i=1; AJvYcCU84XnJ+uHOpEbx+wCmuOKsxLci3EA9Be4edTDTuxUYm0OIx5U03LJCqRH8mxVVAeuYCZWCrGLuyf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDc6Ko9dwejESlZawBsDykloYG7Z0mxvRoeDn1z1mp7ccf0w0
	Zad4gaE8UAHtLrXh9oYIDtX7iEZ+zrmp3qtH+EKH5CB4eelSMR3HLiFzwHAw/g==
X-Gm-Gg: ASbGncs2inkxdSuo5nayFlk185w7PTrnDmroZb4bWYDkuOfGNgkKAbOeUaYihQq7qG6
	FfGTlSOXs47vAa78kvLXAptTlxdSwy1aS7WV5ZuWdNiXGNmhUG9a8A6FT7PG5ZV0YsDktwEpqL4
	9Mr2sytzv/xL3In9vDmUzpBSRT2ne+jf1lQKOYOz7rjJUbiEFxt75Z5un1sRv22TksYNGQiGkEm
	fyfz0q5JvjoB1sdxZnQJ92b/lHApRq4rcZVDvn0FDClMpkqMls6cLx6yFDC9G4JJn70pDLtU0Gu
	SPIDdfMuZFPkRKF4LsQtgdSJ8fvrcQv0OhLovo/HW+z3nb6fcksm
X-Google-Smtp-Source: AGHT+IEuuztzcfI3tZMtG2ip7jalzWCYkQqUAle89wyt0wS3flTIjrnot513jepB3231SBdBpBbheQ==
X-Received: by 2002:a17:903:19ed:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-22bea4ade1fmr126350445ad.18.1744563553536;
        Sun, 13 Apr 2025 09:59:13 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8aff9sm84440595ad.79.2025.04.13.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 09:59:13 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:29:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 02/13] dt-bindings: pci: apple,pcie: Add t6020
 compatible string
Message-ID: <754d74knq32vrefkukv4ec7id33d6rvhuf5boccynljfgmn6hz@bzxc7uiqdbos>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-3-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:02AM +0100, Marc Zyngier wrote:
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> t6020 adds some register ranges compared to t8103, so requires
> a new compatible as well as the new PHY registers.
> 
> Thanks to Mark and Rob for their helpful suggestions in updating
> the binding.
> 
> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> [maz: added PHY registers, constraints]
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 33 +++++++++++++++----
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> index c8775f9cb0713..c0852be04f6de 100644
> --- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -17,6 +17,10 @@ description: |
>    implements its root ports.  But the ATU found on most DesignWare
>    PCIe host bridges is absent.
>  
> +  On systems derived from T602x, the PHY registers are in a region
> +  separate from the port registers. In that case, there is one PHY
> +  register range per port register range.
> +
>    All root ports share a single ECAM space, but separate GPIOs are
>    used to take the PCI devices on those ports out of reset.  Therefore
>    the standard "reset-gpios" and "max-link-speed" properties appear on
> @@ -30,16 +34,18 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - apple,t8103-pcie
> -          - apple,t8112-pcie
> -          - apple,t6000-pcie
> -      - const: apple,pcie
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apple,t8103-pcie
> +              - apple,t8112-pcie
> +              - apple,t6000-pcie
> +          - const: apple,pcie
> +      - const: apple,t6020-pcie
>  
>    reg:
>      minItems: 3
> -    maxItems: 6
> +    maxItems: 10
>  
>    reg-names:
>      minItems: 3
> @@ -50,6 +56,10 @@ properties:
>        - const: port1
>        - const: port2
>        - const: port3
> +      - const: phy0
> +      - const: phy1
> +      - const: phy2
> +      - const: phy3
>  
>    ranges:
>      minItems: 2
> @@ -98,6 +108,15 @@ allOf:
>            maxItems: 5
>          interrupts:
>            maxItems: 3
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: apple,t6020-pcie
> +    then:
> +      properties:
> +        reg-names:
> +          minItems: 10
>  
>  examples:
>    - |
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

