Return-Path: <linux-pci+bounces-15739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F229B813F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1E1F24572
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABC1BDA85;
	Thu, 31 Oct 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQpQ/H+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A515CD4A
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395894; cv=none; b=h22xtWMel+byn3FiA4YV5mmMoznbbRXQ4aQsdozWygpXnI30R/KgVvnZkBlvsZY8/PIwtSqfjubOHQ5mTTfCBgTzTtf8Vs7Ur50/5irYoXoL9aDneUjVsfIgVB5hIXK3KbnAj1iXG9t4Jep8WBEQzWM1Go7W97RHZKGHDvNZb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395894; c=relaxed/simple;
	bh=YUJwsZUfrMySM+3vlPmEDu+Z3Es4dZG8lxvoG9MFcLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te34+cPExR0aJSZWjX57F1V4a7cSmBnjGDwd7t/UVKLKh96V1AIgR481V3g05RA2UQKK8GQzV9E4d2qrPJxtczbfeypNr7cYe2F39L4d8v6c+2TAtuWgx/EYI7MUx3tcJWi+EByGQOhlbHVTohM0NRDJvhP7s42PxhIa2osmIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQpQ/H+j; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso12865121fa.0
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730395890; x=1731000690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTCMKqDX862JKvIefb6wqPBDi9r52Z0WGiE4eHxFlOI=;
        b=QQpQ/H+jggS218dQc8c6+1DNmwW9WaUW6IZhCd5rr12/ThWUPJMQMXzst019tbxtxp
         JwfD4dgtHA5/e5MQS4KXw628IgZLLWV3TE9RaIwfxWxJ2U+tfEuVEhqM78u6/g+oMlIA
         GdcXdJ6uRRdooLdYZ4JQunC6Kun2f4qM6Tubgiv1kKcZpXz163HrJB87zuQYBu8o3iXa
         tlvAgobib2Gi3CW/cN0nTlidtGN5gdEw3lUkeXmB0LrdTmpCOCCwRUMhUvhOaAf7Bpi+
         gRaQCrEUZqBIT45TuFdqT5hYNvCDpvoZp3L4FdhSuZS2XIZYX5neCACgb2ZIayUGO00R
         Oi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395890; x=1731000690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTCMKqDX862JKvIefb6wqPBDi9r52Z0WGiE4eHxFlOI=;
        b=L/knGtQDyLqZc30ypyM7f9I/Ryh4gvXpsTA+FFS2pKzb+VD8JW5FX+FgYb/LEhQNUF
         EgZZwj83qukXCS6aXMx6qJ7iVoeRFTV43FziVlOhvdjkEivbH3j/Zm5kCHKKS++Ohq3Z
         1V/TTjMOrCgNBUSJKCSlqkNX6wqedW++rft1faqwRvfALPatA+LguMxmrfIADuq/GMbR
         71CGX903mpkMd+H2X49QY1BoiteR9LPP0jgmJvONnfPgg9q+74y133Kdblpqg1vtn5Cd
         523inoeuXjFcNs7AHXS5bILzlGh26ZCsAEM6ZL5H2pehlik5n5Wzr3yuC24SHHqARc8A
         WJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZl104TXWQB20v1Rlr/FX7gCgNxQ20gHQ6ep1r7hG+GVyGH8OTtHvcNKA2knP717eVMnXOBAcV4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBUTMqKAdbeXZ4OD4tgvSH/WnI4u8jveh011Na5OJ4tJ+0cSN
	H/+XBltu0Mu5lD4NnuQ1SWZRWolu2IxYa46bj+akvHKQPEQwLIqDWD+NtXv4JxE=
X-Google-Smtp-Source: AGHT+IGShhZ+/nEIa9+9orhTu9s2pEivwD3IJg+SgKln+wQA1vTjdlK55q1QgE4C95fqmPAPR065Dg==
X-Received: by 2002:a05:651c:19a7:b0:2fb:6243:321d with SMTP id 38308e7fff4ca-2fdef231473mr10982491fa.5.1730395890232;
        Thu, 31 Oct 2024 10:31:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c3099sm2677191fa.104.2024.10.31.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:31:28 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:31:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Message-ID: <dbwd3eioykfugnmspbkgojxukkb5oafhhq77q3k7tncjkfinqt@xwpzhjscrr3t>
References: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>

On Thu, Oct 17, 2024 at 09:04:47PM +0300, Dmitry Baryshkov wrote:
> On the Qualcomm SAR2130P platform the PCIe host is compatible with the
> DWC controller present on the SM8550 platorm, just using one additional
> clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Gracious ping, the patch has been acked by DT maintainers, but is still
not present in linux-next and got no other reviews.

> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> index 24cb38673581d7391f877d3af5fadd6096c8d5be..2b5498a35dcc1707e6ba7356389c33b3fcce9d0f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> @@ -20,6 +20,7 @@ properties:
>        - const: qcom,pcie-sm8550
>        - items:
>            - enum:
> +              - qcom,sar2130p-pcie
>                - qcom,pcie-sm8650
>            - const: qcom,pcie-sm8550
>  
> @@ -39,7 +40,7 @@ properties:
>  
>    clocks:
>      minItems: 7
> -    maxItems: 8
> +    maxItems: 9
>  
>    clock-names:
>      minItems: 7
> @@ -52,6 +53,7 @@ properties:
>        - const: ddrss_sf_tbu # PCIe SF TBU clock
>        - const: noc_aggr # Aggre NoC PCIe AXI clock
>        - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +      - const: qmip_pcie_ahb # QMIP PCIe AHB clock
>  
>    interrupts:
>      minItems: 8
> 
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-pci-dc0c22bea87e
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

