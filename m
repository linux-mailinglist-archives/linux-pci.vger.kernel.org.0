Return-Path: <linux-pci+bounces-17579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3E9E2732
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93695B38E34
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C31F668D;
	Tue,  3 Dec 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sX4mAhip"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4821DE2A1
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237649; cv=none; b=KfkSjgqkhjF+klFXLcYMKy+yu8jJzYvex1iP6XV96HTx6By0Kclou97j4nD2byy4kANZYxIxltGKodEHeE0P5HiJNXhScQ/yz8I1ybsOkoESVC/DirSh79Lml8NlpSs+loESU8vBQWu3PCL+WtcpR7c27r9WBq1IwQOovOaoGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237649; c=relaxed/simple;
	bh=3I67rMMe+vODDhqZTiQxaM4wt9T7Ty4kLEO+IS9uPeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjvBTBxO0g00BXqWFrb8f84oXY9b1Y91DRL046PWmSGisCKegERqE72PsSpV1Mo/+lrHn1mGzf4Hf8uJ6IhRbeqg7BixxVZUh6drEUhAi+HLSzAZqay2Z3bDGaBVCOD7OFaWPBfRU6bmnlmxmLAhdUBlMpx/YzEc6xdeHf+v2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sX4mAhip; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215a0390925so22487135ad.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733237647; x=1733842447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NxRWvpRh/XATlPemsVPOp1C/WgHKNO3eQaKjWVu9JCw=;
        b=sX4mAhip+zEXrfYltgIdHRgCxeewcytEWOwp9cCbh9VcbzOVrdWlA5KH13bwqOYyRn
         mtslYi6EeAEsYXASwXIHxp1idU8LUPChVSsnkSbEQJ46cm49bTwXabcjUPKi2/D1E2PU
         VwblT4g/uDSYZbwIkxwgib6hiwwJ1q6s80CGrf7Y1wnar3vqGrVBpfHj1Zl6zJ35oK4Q
         cCMeL5dUfokq75h2Q5+Qzjqlcg7Oq0ffFmx85HqywlA2qF+HqyC2Tf0x45GX7+3WXfHt
         Z2f+R+8T2JL2x1qwmoxdue0RKQ99J7paKs/NyneNL63ZL4bUQ95LwvW+nGHp9kUxRPN8
         scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237647; x=1733842447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxRWvpRh/XATlPemsVPOp1C/WgHKNO3eQaKjWVu9JCw=;
        b=H9z52gm/mDtiAyNAkUrNKClR/Q9B87v+bL4YJbbacAaO+u4MgqWx6hgt0BxDn5KOPF
         pfzjj+I22nFfmqgF/MmgD+1PVkNIXJeiVEdasdrRzjovKL7/d5vbIePmeC+reD4dQBi5
         H0HirUqow7khRnhLUjXEyDw3MLaAop81V+a6ONs69QaLyI0l0+CEwFv+hHh9ZRyFnMRg
         V7THlaCUnXL6Xbjya6aPMb5ntEejT1hgPypkZmWNuOabREMdcOPxIS1pSCIANtN7Y0nP
         CkpYCcOWhnTtXDTc2Mv5a7VCdI8Rgdl2M9br5qJfoKMzFu4GNxcki9i4rf7kWtTClWMR
         NPbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCuL4eqpke2z2u3gR2mJ1Xa5ZfcLcOsM5epYpskchWeTUgR8IJVBinSiIQBZDkyMM6xGu6rQY0vxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQXA9qtQjvJwILKURM1hVWakumuCt9rYSAM8Vv1d1d/guTaI8
	IX/LeYQltrkaC7lLAeQXCBj7PnyLhtSgXeOjDXI+zl2Zr8LOlcs0F4hZU8TR2A==
X-Gm-Gg: ASbGncvPtTm9D+3g2utBDekarzIS94LuFbod/upb3WLY+sZZgjStNO3K89lH78QO2E6
	c58zNJ7Y4Whvn0O/B8PpT5onbiJQGi7xPoReYxuDWf4t/rrpxqB5xbZ2ouBsnHn9lZMHGUuUq9r
	6GqFzjowxq0PmY/uqaTYplAoBvuIOTBsu46BjaCVG76dxgnMgYgvDHnBamZHpgQcfdsEZV7UVDZ
	9tXPxfLK3CIvAqxkuV8EYcJw1sjMJmmH34Wky/inhGMbpxSRdpUW9Kvf1xw
X-Google-Smtp-Source: AGHT+IG1jXS9xGAq/FRf8FrbfE+7Y1wmH9mz8EtqoFxLQOYNOcGvJFOa6X0SdbkbLcjrMI9kzEqtkw==
X-Received: by 2002:a17:902:f543:b0:20c:a44b:3221 with SMTP id d9443c01a7336-215bd1cb76emr33584985ad.15.1733237647391;
        Tue, 03 Dec 2024 06:54:07 -0800 (PST)
Received: from thinkpad ([120.60.48.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21565f24c59sm56675255ad.125.2024.12.03.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:54:06 -0800 (PST)
Date: Tue, 3 Dec 2024 20:24:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: PCI: Add STM32MP25 PCIe endpoint
 bindings
Message-ID: <20241203145401.7snlxk3sybufaqp2@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-4-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126155119.1574564-4-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:17PM +0100, Christian Bruel wrote:
> STM32MP25 PCIe Controller is based on the DesignWare core configured as
> end point mode from the SYSCFG register.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../bindings/pci/st,stm32-pcie-ep.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> new file mode 100644
> index 000000000000..0da3ee012ba8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP25 PCIe endpoint driver
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description:
> +  PCIe endpoint controller based on the Synopsys DesignWare PCIe core.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +  - $ref: /schemas/pci/st,stm32-pcie-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: addr_space
> +
> +required:
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    pcie-ep@48400000 {
> +        compatible = "st,stm32mp25-pcie-ep";
> +        num-lanes = <1>;
> +        reg = <0x48400000 0x400000>,
> +              <0x10000000 0x8000000>;
> +        reg-names = "dbi", "addr_space";
> +        clocks = <&rcc CK_BUS_PCIE>;
> +        phys = <&combophy PHY_TYPE_PCIE>;
> +        phy-names = "pcie-phy";
> +        resets = <&rcc PCIE_R>;
> +        pinctrl-names = "default", "init";
> +        pinctrl-0 = <&pcie_pins_a>;
> +        pinctrl-1 = <&pcie_init_pins_a>;
> +        reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
> +        access-controllers = <&rifsc 68>;
> +        power-domains = <&CLUSTER_PD>;
> +    };
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

