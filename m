Return-Path: <linux-pci+bounces-21871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBAFA3D203
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416DC7A78D0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8BD1E6DCF;
	Thu, 20 Feb 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNLZAx69"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EF1E5710
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035994; cv=none; b=euLJQgqZp3mLeMgXQ6NqgTDq1mnaghlNKBgUhfRdgyeZjkS5wFsSoK60vXVxEfEN4hG6vVFSE04LAtFKmEzbCf6znHRRjswVp1+TzyN+JkbHljORfx6EC+Gb+rqQ6dqPpsJxZvpVTo+5ocKb519PkISN6mQ9uIABWlDX4tzOQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035994; c=relaxed/simple;
	bh=dSKE5I1F5l6I4pWkjzFMa6oZu20U6ZVKkb/GOJ9jS3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izBrGFDtS3Fa8Ya6ONoLLxGoMIg4NQzR4kYX9ICifRBCdW61fxQSnixoN1al6zlFa4NjdLsrjWuBHO9hx8nvXdOSU+FMJyTR3nRQxegFYAwTsgl2KkNZbkJhnlsEAkuGM0kcM4EnktO1UUi3gZgo/Yf9a5rHha6Qz5sWBBJRaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNLZAx69; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c92c857aso10921885ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740035990; x=1740640790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ur9dFsKFbvJEs8mC6dKdEyGV45W+SbQs+6opIdZpbs=;
        b=VNLZAx69oomZ2UsY/9Cxo311gLJEFuu4zoHEWnn1HdOYJ9H10PWen//VB7OkXM8aji
         indTno01AIY1BtmqmZYus2N/06rkmcBhlI30jb5ajRX/zpxpUB6+mNx7tNSNqIVgRJVf
         vNZ30uYjL2fChu7wE58nPLJ3nBi7J7uOnv75wFOStLEwCDpAui1WcThIDnvjarRAJYQu
         /uvJzscP7FiTToS7UrurzWbRm3lRQpnROxA6I23IzQUHXaJMXHg50pnfbP2KSNNB7W96
         byLYJ26/72OF5AUZ85DUTrdOqZOtqL5mZ2euyH3V0FMx2hx+s1YW+gm5glkFveDzBGSw
         0d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035990; x=1740640790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ur9dFsKFbvJEs8mC6dKdEyGV45W+SbQs+6opIdZpbs=;
        b=uy3S2v3SThn4+zj7oRzpe/xVE3dprT4wCUGx3rrLvtM3ul9uQddhbac1OnjfQaC4qF
         Hbou2I3GAr6LqIBnnyN1SuzOurZJtyOf4hO51d/LS7btBGUh7lxe/n43wr/ekh57Jdgz
         /vGXxrm6GDZJAXwqcs7Zkb+44KvAnfroFVahzMISwBqJFBVm8gXPgmA/xm6zXMUxMbI6
         A6c+ngNM7v7oWxP298KRskzgNULSFN005siwOIZzLBunGODHu603Hir0UUFLvfwjzPK5
         3bsfwqLcTwn74vWjh7Be0tceMC3duZLYShYWS2L7Hm2p0TZ2HEoWBcpPHX5Z9EKA3DZJ
         ARHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNysKxwRIyI+RDQLQv9NosyEMlBUU/levzRFqBF0FCxr1hnUft/uAVzPbQHr8o6r4lBzRsWQX6PEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6V4lWsUOor5duO9csHresHYl4U7HGBACSzFMb6ybNegyr0yKX
	Xyh00SGJsKeRfwWZxxDaFu796Ibxg3tJttQ9laWoJOnqRoWSCRmNJPRA6I1sfg==
X-Gm-Gg: ASbGncuB00pBNiU63x26sI8kLWmXWNidcI1bZGrUduq6rRcGpQxC4VLJog4+/kyeAMm
	vIN3+fgLxOLL2etV2aBSAy6WFn1LoTLfqxiHxvHMzFnZFcfMYXvb4b/boDkbov+EYcSB/aXdfiz
	SPZTyAKTW7fi1D7cfbR5Bhzo15yQ9scGTsE6bgSP1Nz1b0V/Yawr9hTlJKexVk8KQag6jb7T53v
	MA/zY2elC8kHlfdBgzZ3sFdSzcwxXGin/qpTea/SxCinNlkng9R5VlGk/IFoWYbemh3YSEQUOhJ
	Sncp9ElQ9xI5LYeEYq/u+iEggg==
X-Google-Smtp-Source: AGHT+IF3yihejjwT/v8s1qaCn8nd+GpEMzld00Wlnl4a36L6UHNc/5ltRo3ZjwkDna6NDtWQ/sG8kQ==
X-Received: by 2002:a17:902:f54d:b0:216:271d:e06c with SMTP id d9443c01a7336-2218c3db4d8mr38128005ad.4.1740035990566;
        Wed, 19 Feb 2025 23:19:50 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537bd1asm115277265ad.102.2025.02.19.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:19:50 -0800 (PST)
Date: Thu, 20 Feb 2025 12:49:43 +0530
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
Subject: Re: [PATCH 1/6] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Message-ID: <20250220071943.edn6q65ijmeldnag@thinkpad>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-1-94b20ec70a14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-sar2130p-pci-v1-1-94b20ec70a14@linaro.org>

On Mon, Feb 17, 2025 at 08:56:13PM +0200, Dmitry Baryshkov wrote:
> Platforms which use eDMA for PCIe EP transfers (like SA8775P) also use
> IOMMU in order to setup transfer windows.

eDMA has nothing to do with IOMMU. In fact, it is not clear on what IOMMU does
on the endpoint side since we do not assign SID based on the RID from RC.

But the binding should describe it anyway since IOMMU does sit between DDR and
PCIe IP.

- Mani

> Fix the schema in order to
> allow specifying the IOMMU.
> 
> Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 1226ee5d08d1ae909b07b0d78014618c4c74e9a8..800accdf5947e7178ad80f0759cf53111be1a814 100644
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
> @@ -233,6 +236,20 @@ allOf:
>            minItems: 3
>            maxItems: 3
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sdx55-pcie-ep
> +    then:
> +      properties:
> +        iommus:
> +          false
> +
> +    else:
> +      required:
> +        - iommus
> +
>  unevaluatedProperties: false
>  
>  examples:
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

