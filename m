Return-Path: <linux-pci+bounces-9164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE239140FA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 06:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8418B1C2119A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1ED272;
	Mon, 24 Jun 2024 04:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8isRJ8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682A79EA
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202428; cv=none; b=gQdFwhRqT8tQtSnt9zixXXnO51Oi4PNgCyUGHZqh+oZDDxmXDaCMgP+ztzjESuyDe4GBl04l/2oEuabIacKsekz8LLNi41FAiKkUnplkiUFjpkG8eVheL/va6al06Jo2jk2lnDJOk+LyvAQQZ0STwGO7MHqIyfnCv90QKEPuCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202428; c=relaxed/simple;
	bh=g40p/038wh7aZoKP0QQSTY6JQqMKagXDwC16tPe4zhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjStlZyaECurHFIRh8b9FJxQ2qmRr5K1knjtsctX5MwbHHADRkWP2kXMnQ10vA+uljhRCP3Rt6AZdviIXrbPdTSi9yBX1WxBBOYHSDhXTC+VzaucsqfJobeL46chYb7xMsD8p+W4U34y9DcplknIp33aMkSxCJEB8ZSza2jWHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8isRJ8W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa07e4f44eso13175915ad.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2024 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719202425; x=1719807225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8cBzkTKbl++ipTccj+tqWjGiU8poirFQQErpQeRckjI=;
        b=I8isRJ8WsI8CdsASd+vWuGIv/oixor/Z/MwVtLx8yClY+RYsZPdtyuEHU2mKIDm9p7
         ly5m0XeNrc4m2J2c9DoDkGMyuDItKW8mo02K909+H0Zws7uLG4SjMU9xsql4ncfSEnqA
         3ueL2YiJuzuJdPZaTnla1f98NeXbA7KUf/yedYkpnLikIQdrsKo/CboLpq0UhSSDNCRs
         b7TlTaLdSUnejsAZQpD7TIeB9fid/ZfFasRTtIcPbdU/Ru5gz41gYZUzI2yFqs4olXaD
         3yeabTv0fIb/qDDKu3Gbzgtbj671i1q32xLuLx4MBAC4xtVB3gGSnVqEa2mROCSBwF8T
         L6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719202425; x=1719807225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cBzkTKbl++ipTccj+tqWjGiU8poirFQQErpQeRckjI=;
        b=eGUbxEJBafOIOprb7stK1a8/CW0T9yQK/fH1UBTDzkrnnQLyBuVON4+rJBnrB7Aetw
         j4EBmU0FvjOj9Ktui2vvR/D+qlWue6teX9hn5Mgidzzgw059f37AbS37I7vio/HY8kcV
         mCvqjlqdVZ9IagazOoWBwr3uP5GCSS5kdDjZ0e4L1RAYt148+yiWmm+0KwZWG+PKi2tW
         JUNySBEIdjoaIARpxBAnsVEThw0eYh5y5q/29VAWhbGmaD/RAdp258SSE/ly2LKWmtUi
         MBvNEEp+9J0udPGk3fBEz74LWazXDUVRCfZ7lswefGhqG4GU84bTIPBetj/89ajDZAeN
         dRug==
X-Forwarded-Encrypted: i=1; AJvYcCV660UWuCFukk7k17GZIfyT+YGPnxHr5507NlO2jOf78YxYkW4WHBgm8qi5b2STXuA/rxZzTv2Sjb4MIMFDtx8o+0ylNIOaFdiJ
X-Gm-Message-State: AOJu0YwdHnT6afDX/SFfzlVlGxMV6IlxoyzTXiL++5z8LCVMRrrsNIeg
	8vxdbEmS1jXfG5s+9+0BoaPOLTBu0EKkzi4X7lvN9ATGoYuAtqb4v/CegWDuSw==
X-Google-Smtp-Source: AGHT+IEFH6u4Phxu4XFbcP6oZlGouPp6ySyJ7RzMJnUbJnrqSy6lUpugRFFKO7YbCnXWz8uf73KoHg==
X-Received: by 2002:a17:902:cece:b0:1f4:9b2a:b337 with SMTP id d9443c01a7336-1fa238e4490mr46624255ad.3.1719202425410;
        Sun, 23 Jun 2024 21:13:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d8b7esm52445395ad.207.2024.06.23.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 21:13:45 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:43:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/8] dt-bindings: PCI: qcom: Add IPQ9574 PCIe
 controller
Message-ID: <20240624041339.GC10250@thinkpad>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
 <20240501040800.1542805-13-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501040800.1542805-13-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:07:54PM -0500, Alexandru Gagniuc wrote:
> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
> The difference is that the "iface" clock is replaced by the "snoc",
> and "anoc". The "sleep" reset is replaced by an "aux" reset.
> Document these differences along with the compatible string.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index cf9a6910b542..ac6d2b1b8702 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sdm845
> @@ -161,6 +162,7 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -397,6 +399,39 @@ allOf:
>              - const: axi_m_sticky # AXI Master Sticky reset
>              - const: axi_s_sticky # AXI Slave Sticky reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4

There are 6 clocks defined for this platform but binding just requires 4?

- Mani

> +        clock-names:
> +          items:
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: axi_bridge # AXI bridge clock
> +            - const: anoc
> +            - const: snoc
> +            - const: rchng
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: aux # AUX reset
> +            - const: sticky # Core Sticky reset
> +            - const: axi_m # AXI Master reset
> +            - const: axi_s # AXI Slave reset
> +            - const: axi_s_sticky # AXI Slave Sticky reset
> +            - const: axi_m_sticky # AXI Master Sticky reset
> +            - const: ahb # AHB Reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -507,6 +542,7 @@ allOf:
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
>                  - qcom,pcie-ipq8074-gen3
> +                - qcom,pcie-ipq9574
>                  - qcom,pcie-qcs404
>      then:
>        required:
> @@ -566,6 +602,7 @@ allOf:
>                - qcom,pcie-ipq8064-v2
>                - qcom,pcie-ipq8074
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>                - qcom,pcie-qcs404
>      then:
>        properties:
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

