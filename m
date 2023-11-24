Return-Path: <linux-pci+bounces-156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1027F70BA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FB1C20F11
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BE18046;
	Fri, 24 Nov 2023 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbOp1eJ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D81B6;
	Fri, 24 Nov 2023 02:03:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso2448801e87.1;
        Fri, 24 Nov 2023 02:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820205; x=1701425005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmNkkj8bOMsrzoaba81g1QSDAv4tnTjLgBhqzOK6UK4=;
        b=kbOp1eJ34ADnT/53m0tY0wZ7qNtupNh7+7n4BxWzkiT7hKXOdx5B7btsvFlw4Y6TKl
         sdD9TRvAJbbPc3XLYhdxYiKKUevAO5bCXBJ25/I4PuKScEXWdlYL3xVocQbO7LYRzcir
         xxlhnmDNn70VHG5bG39niXGxleuy3nGnJAr95ZpbXUhOuIH7QM4gzFVl9/QEepZbV2M1
         q38B7VnEVPHj50rg11uKqxzEB4SnNeiBUq9+tsrK7vkchPEFVqahVgqCFT45KtvnJ9St
         vBhm26FKZbqe4p/0BtBq+xQiR+7Hu961Hd95p4o+KWNsbmrW1eiRV573XcjOC5hg8Jk1
         1BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820205; x=1701425005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmNkkj8bOMsrzoaba81g1QSDAv4tnTjLgBhqzOK6UK4=;
        b=n2XE4152UHIcz/lGp6r2HPrDHb6eXRf37KYgqTog9J7QDVzEASg70B/9QggjlAt9/S
         DcdXI6413HXVsvB55sRLQFEc/YWLS89f5de/zmhBlg2pYs5LtcgZqMbBrIcSrQnXMHgl
         zE1ox2MiCYJc11b0iioZt4VV/S+fxvN3LwuaS5CXvW26mM6tysiHY2x5zhOZWV+RN0wY
         knCMlSbbzBHS0WX+cWWbKKjqSe7Y9RzJbgGQXPT3asnKn3maVgMpGTnAxTSfWezX+W57
         Q22wMRLbjXwFV/9qlRhi+IzxxrTDhF6v4z85pgO+mud0lBR9XnFMbwQcKx+eR1STCUVi
         mmPA==
X-Gm-Message-State: AOJu0Yy+7SV0v3JUJdhhALmOvvtyVB8X10YLdkC9Iih4v7/JzKALLJ32
	X7zX3UCsKCKm1weE7zfHZ5c=
X-Google-Smtp-Source: AGHT+IGKGiygZo1ggtDKRtbhF6qntEfAzuGcJlCZ7Ty9ql0DU8t3NC6/D4pEnRb/0csFDzpVt8tilA==
X-Received: by 2002:ac2:4284:0:b0:509:7301:5738 with SMTP id m4-20020ac24284000000b0050973015738mr1398924lfh.62.1700820204401;
        Fri, 24 Nov 2023 02:03:24 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g36-20020a0565123ba400b0050aaa7147b8sm464495lfv.141.2023.11.24.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:03:23 -0800 (PST)
Date: Fri, 24 Nov 2023 13:03:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
Message-ID: <bianfx2bkdgtecquvvzxcyjzqim3ristgipzosqrljmhls2cxg@wlifizchsz4o>
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

On Fri, Nov 24, 2023 at 10:21:21AM +0100, Krzysztof Kozlowski wrote:
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

[nip]

> diff --git a/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml b/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> index 624984d51c10..7f8d98226437 100644
> --- a/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> +++ b/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> @@ -125,7 +125,7 @@ examples:
>      clk25m: clock-oscillator-25m {
>        compatible = "fixed-clock";
>        #clock-cells = <0>;
> -      clock-frequency  = <25000000>;
> +      clock-frequency = <25000000>;
>        clock-output-names = "clk25m";
>      };
>  ...

For Baikal-T1 CCU PLL DT-schema
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

