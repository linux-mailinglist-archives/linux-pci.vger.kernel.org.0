Return-Path: <linux-pci+bounces-250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C37FE110
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 21:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F907B211D0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12B60EF1;
	Wed, 29 Nov 2023 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382ED67;
	Wed, 29 Nov 2023 12:31:57 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b8929269a0so120026b6e.1;
        Wed, 29 Nov 2023 12:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289917; x=1701894717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3UcxPmOUBgoYRAN4nwqjieZhrpgvlcJhcBGE2O3Vbs=;
        b=wL6uCgAs68sjbH2viDuIjFaeipso9xcZREiQa1GmodkrMQcfp1FYGar2AgbOPWj1/j
         z+PeL+9H7it7YHCNoSNdayKt8miMgkWDhl/h5mcI5nGLBHIg7mGJNgz25QYUXbMCfdxr
         ridmNtE9GEsdEBJlcwrMwuSVSwqwRFbn2kieuAPxBJSIPkoirUP7tjJXpIEmvOTveMKk
         qWBhPEAk0KejV4hden0NrivHf6C2y3r7c2Ofw7MN3gQT8Jzo1zOnjuWtBOyd7hnwMBBs
         cNmaCl7riTXfItI3C0SVCBOR6PnPcjinQl007lyRrlMHXfa5SY+bsaIJTldUpqsEYYLf
         q02w==
X-Gm-Message-State: AOJu0Yymp+YIN8VR1T5Q4AmsxUVIae+oJN0KcdXq5gRX+l57oc/wfamZ
	HGm1PyCa3eT06cBBzeEfeZgbWB1pPw==
X-Google-Smtp-Source: AGHT+IHnKlWulB62HnwQlLD1tDuKg56VsN7YCRwmT/bk5Ncq/4Op+u8dd0ytaBscKEYQnjSNzOmboQ==
X-Received: by 2002:a05:6808:605:b0:3b8:958e:cd1 with SMTP id y5-20020a056808060500b003b8958e0cd1mr3221428oih.59.1701289916938;
        Wed, 29 Nov 2023 12:31:56 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w9-20020a056808140900b003b892a45d32sm511833oiv.4.2023.11.29.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:31:56 -0800 (PST)
Received: (nullmailer pid 3291682 invoked by uid 1000);
	Wed, 29 Nov 2023 20:31:55 -0000
Date: Wed, 29 Nov 2023 14:31:55 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
Message-ID: <170128990701.3291471.16328336597319307055.robh@kernel.org>
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>


On Fri, 24 Nov 2023 10:21:21 +0100, Krzysztof Kozlowski wrote:
> Use only one and exactly one space around '=' in DTS example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Merging idea: Rob's DT.
> Should apply cleanly on Rob's for-next.
> ---
>  .../devicetree/bindings/auxdisplay/hit,hd44780.yaml       | 2 +-
>  .../devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml | 6 +++---
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml       | 2 +-
>  .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml      | 2 +-
>  .../interrupt-controller/st,stih407-irq-syscfg.yaml       | 4 ++--
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml      | 2 +-
>  Documentation/devicetree/bindings/net/sff,sfp.yaml        | 2 +-
>  .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml    | 2 +-
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 6 +++---
>  .../devicetree/bindings/power/supply/richtek,rt9455.yaml  | 8 ++++----
>  .../devicetree/bindings/regulator/mps,mp5416.yaml         | 4 ++--
>  .../devicetree/bindings/regulator/mps,mpq7920.yaml        | 4 ++--
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml     | 8 ++++----
>  14 files changed, 27 insertions(+), 27 deletions(-)
> 

Applied, thanks!


