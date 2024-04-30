Return-Path: <linux-pci+bounces-6826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00598B69EF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 07:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEF31C21E91
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 05:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151F175BD;
	Tue, 30 Apr 2024 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGqmjBER"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E91759E
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455093; cv=none; b=YC7K5yIL24mn59P3CKnimZSQLD4PwyrBAO9ZbV7+9lAcOfrswTY+ymoK7WbN9UHD0thU3C2HCmPdOO4tj845UwK4pinPPn8SV9Pob/wAvm51ScZ9JtcwA0xMOMYsnekch+wiPwNxmLH2shZSXXhFqoRQ/zWJMnlLbdw0IzRy7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455093; c=relaxed/simple;
	bh=qizGv4q2/Fbfp1Vgltwn3jrxKqTwsXYZYMFjavraeFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV8fXH5skrTte7Y0/EBpqr8CkM1qT74xosu55ggkQwewkaQfvUerXESjZOCEVGKZ+TtX6bfs6xJSBCOUIUfBUUvHvlzoSevhnSr9Dw6LWvmKFv4XqczeXMwxNv8GHwDuRnhDdIOmBbXQqkwWccFnyT0KPJTBtEXBork0RfDBSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGqmjBER; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eb66b6953cso22840665ad.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714455092; x=1715059892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfHOB8SXAPuzmllcKSu0Zlo52yjCYkknhySEalAGkw4=;
        b=VGqmjBERlQU75bf/gEVtlTHZ3h0PBm349PuewppT189+OJoAv0D4YmHk84OT/XDP0R
         iuIgqoXdImczn0SSUWOrhDI9BMjCJMafw89AQNY4cW3mOGko2Eh6MfiUh4fNYSimkzH6
         JslnDcX4WBYWcQPQrLoCVQC2zy/0pi8kLtpB+8rKbJ7z4YcbJTf5ajm6tdrAMYxXMxFg
         kXTb6bPrgtchslLMUeL0bX0Yj1zNpoUPOt0tVIbiQQDgYc8KFbc7wAcH4w6/Xcv5FjBX
         DL6QwKmhw2GMsLuVEdpzoIgk0KCjUVz09Sk/EWtDQVYJoVceuwwWDb6XGUV4VEHCUpMH
         WWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714455092; x=1715059892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHOB8SXAPuzmllcKSu0Zlo52yjCYkknhySEalAGkw4=;
        b=JVXI156iwhIHCUUD/5P9wsPXCrYRBwiRp9MrEIyo3lLMy3PRKMd8IHH/d8lHtXPy/n
         Itmhjg7BNduWZ8GB8f6Q31AwrbEVQ2mxbHpa0Dtt7JiTcB9hA2GubC21w51gY8mAoao5
         rncCfhDfXHN+TKc63r6a3i9bo66MOlkZsNjMCbVPtyMzf4ITOiRoTMFIzHB5p1QWZduT
         O1951m+mkWTqUmvtYEp25kmtKjw4LTqOi93e9PPhc5BOBF9/2gK3+vm6Ai7O8OsV363G
         HIevhvM6iiZnSB3lz4hD5q/j4p5lAnWumXGAUtc6xGJ9jGcFB6l9iv3KpnBHwjEzKlNL
         Ivsw==
X-Forwarded-Encrypted: i=1; AJvYcCVFiMR9GRafeYyL66Tgl0L2ZWFOFMvlwX9jzkijIE7Rqc8sEb4ChFF9hVqgixYYQLX+V0HSSnrWR6VKdHmiccAZWI/wFkhjU6TY
X-Gm-Message-State: AOJu0YxFDxGZJuzs4xIYbhIoi4eyyVenx1wdDy5JSbAI76lUV8IhsVeA
	FF1NZKB8brQEa0v+HSfcHR5d+lcBBjbULJgEfARQiXUD+iNBtD7nIVFldYkrjA==
X-Google-Smtp-Source: AGHT+IErHY0aeCgYx3Eg8BZQUT5i4gOzQfyzK5nVz/+A9MaPVNIq3EbBBlsUSZlkwJMHRrYmAEOGtg==
X-Received: by 2002:a17:902:ba98:b0:1e3:f6dd:b04b with SMTP id k24-20020a170902ba9800b001e3f6ddb04bmr1503995pls.26.1714455091596;
        Mon, 29 Apr 2024 22:31:31 -0700 (PDT)
Received: from thinkpad ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001ebd72d55c0sm2925454pla.18.2024.04.29.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:31:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:01:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant
 'oneOf' sub-schema
Message-ID: <20240430053127.GF3301@thinkpad>
References: <20240417200431.3173953-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417200431.3173953-1-robh@kernel.org>

On Wed, Apr 17, 2024 at 03:04:30PM -0500, Rob Herring (Arm) wrote:
> The first entry in the 'oneOf' schema doesn't work because the top
> level schema requires exactly 8 interrupt entries. The 2nd entry is just
> redundant with the top level. Since 1 entry appears to have been a
> mistake, let's just drop the entire 'oneOf' rather than reworking the
> top-level to allow 1 entry.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../bindings/pci/qcom,pcie-sm8350.yaml        | 22 -------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> index 9eb6e457b07f..2a4cc41fc710 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> @@ -71,28 +71,6 @@ properties:
>      items:
>        - const: pci
>  
> -oneOf:
> -  - properties:
> -      interrupts:
> -        maxItems: 1
> -      interrupt-names:
> -        items:
> -          - const: msi
> -
> -  - properties:
> -      interrupts:
> -        minItems: 8
> -      interrupt-names:
> -        items:
> -          - const: msi0
> -          - const: msi1
> -          - const: msi2
> -          - const: msi3
> -          - const: msi4
> -          - const: msi5
> -          - const: msi6
> -          - const: msi7
> -
>  allOf:
>    - $ref: qcom,pcie-common.yaml#
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

