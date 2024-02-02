Return-Path: <linux-pci+bounces-3012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1384708F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ADB29718B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7815C4;
	Fri,  2 Feb 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcGUc6+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6166185A
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877860; cv=none; b=Vcj7LijEuSh9LEVv0fiVshuVwxBjwvsu0yLL+w90lYnEg8+SLrYd2TqpZ+S8wXiBcx9kzKOmqvpFtzuguGTt5ygYHoFGjNeTQ8L38XFodOB9HGEk3AHqSNoxIAwoQOvBTFl+VR2n/z6ZdiMIYG8bgaAyi/hk/InHfjDhCmVfqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877860; c=relaxed/simple;
	bh=AHccFh1vhbj9D8lNavBos4qXxlEB48XAwTNCBRo9exs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j32oMK8il9OST8I8gTuxepa5bCvpfjmL5P0iJBSbgTOuhVWSma0+npVRvuamQnG9i4LyLYEtOzCOpynpCWVS44bbVbotD1u+W/WYO9q6izhwSkr+zxhZfW1X4wTRz9rDo6NXpKUFGzvBcxbpjjY7NarsCshrrUIiYO65ta3kevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jcGUc6+J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d958e0d73dso6008605ad.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 04:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877858; x=1707482658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rm02oG7clY3fiBMowynDm3V+C/aVHnna+vNWkYG4Ykk=;
        b=jcGUc6+JT9suoeLfSDJHXl+0gc3jwfYIoCcpDzybVONGcjol96glU1Cig7h0o8smua
         o29O4cAPYEkdkIrScix/k1q8pKcM3CoiiRvNizPVUxYo/DlQwtRdVzg0mm4+GroWheVg
         zKvBkI2OIZZv35kryDK0kMlNDZRIyOsjYBMEwvzClVy6g8N/3BL+jdClYsdaaAIakDyZ
         QdqOCF3lioiIKF0KFEyVKkJF7xPnePM4JXy85YYwTa6k9MFzbcnn2GzUoHf4zkCFuILZ
         17k2A6UhdYMS4xUDAtCVkxALsTvMlLW7DHOeNdL5Ec/4xPYQDzh/cGhpkW+qZQppuXNs
         z1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877858; x=1707482658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm02oG7clY3fiBMowynDm3V+C/aVHnna+vNWkYG4Ykk=;
        b=EuRYPHAhWVfnQdi6FpLLnricK6a3N6qkH2qCEKjUcfTRoHow5AB5oxVS432uuXAoKT
         xOc8KJTAX6EkgNVakCX3XTSNwCBvJ/L8JVt70iVzeer/DoP8ZeKR+XtIRu5sZGqPmDoe
         cxQTTpLXskXguodLxX2FWM/flFGYHrM7sXvO0Qq/c6Y2rrVS4e1kTwSJk/pZYuU4pcQF
         4L58vUGava9Yt8iJhjP4zMGdjyzaahi3l0oAtAB9b4M/8+TIcT4JE0VLGGq24qjx+Xql
         UM/HOY+RJMuo1t9gjPzYnEq8fvfEvIVqvsoTKGXbrLNQ9+iS1tgLd2RypSvfjHcxvbNt
         vcFg==
X-Gm-Message-State: AOJu0YwtRPCRapsBVkJx3CSRjcrJFy6lhSZhjPXvOZ8tQc2EcH8ftev4
	JiRJQLH5AKFhLxEFK/SGeKOegjZvqJa8xOKAbEpThU77P1P2XahSyAb0Wvx2hg==
X-Google-Smtp-Source: AGHT+IGy9bAdHYdFNg1g9DDUGNxltAsmrrrmJY1U7q8ZmZPYcgJwS1tYM325jCVPGcRigXZYLKd+Zw==
X-Received: by 2002:a17:902:db11:b0:1d9:4143:5fe1 with SMTP id m17-20020a170902db1100b001d941435fe1mr2898553plx.0.1706877858240;
        Fri, 02 Feb 2024 04:44:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlxolnBRum91Y/AqKP2BCANY3KuTteRYOFf3lJx7luihX6UAtboZl9soeI4NSaT4AKy6oYWyyWbz5sEoKGMCJKR8uvEynUck+/7BOPKlxRTWbRJZZ2cKTifj+GMQmWKenC2L1ag5NegC8lWZrFA8Ad7pitBdw/+JYAB8Ir8w6JvDJNtyOZ7dpT1pYJjD0FCM3aUd5jw63zkAmkeK7i16cP1LH4nc+FPVk+AoQOY4IKHT0VSbihdO94RkzXy3YeBqWkNMJ0Gs3PhNNykwr/1FZQJHGpRzJLOOkOX5swMm/tAOfQRM4/SmoZFMRc
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id ml12-20020a17090334cc00b001d8f6ae51aasm1535215plb.64.2024.02.02.04.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:44:17 -0800 (PST)
Date: Fri, 2 Feb 2024 18:14:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller
Message-ID: <20240202124412.GF8020@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>

On Mon, Jan 29, 2024 at 01:10:26PM +0200, Abel Vesa wrote:
> Document the PCIe Controllers on the X1E80100 platform. They are similar
> to the ones found on SM8550, but they don't have SF QTB clock.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a93ab3b54066..7381e38b7398 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -41,6 +41,7 @@ properties:
>            - qcom,pcie-sm8450-pcie0
>            - qcom,pcie-sm8450-pcie1
>            - qcom,pcie-sm8550
> +          - qcom,pcie-x1e80100
>        - items:
>            - enum:
>                - qcom,pcie-sm8650
> @@ -227,6 +228,7 @@ allOf:
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>                - qcom,pcie-sm8550
> +              - qcom,pcie-x1e80100
>      then:
>        properties:
>          reg:
> @@ -826,6 +828,32 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-x1e80100
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: noc_aggr # Aggre NoC PCIe AXI clock
> +            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +        resets:
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: link_down # PCIe link down reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -884,6 +912,7 @@ allOf:
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>                - qcom,pcie-sm8550
> +              - qcom,pcie-x1e80100
>      then:
>        oneOf:
>          - properties:
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

