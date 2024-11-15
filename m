Return-Path: <linux-pci+bounces-16864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ACA9CDD11
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA3C280C7D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CEF1B4F24;
	Fri, 15 Nov 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmiIuDwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CD136338
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668156; cv=none; b=GigYWDYJ+eO491COdryGLS3zMGrroOc4Dma90FCJgB7HyA3GP1KAzPbBLOV5SIDFm6ADd0yOwijBE2f1xtUya4O1c283N3UMo/5HdmRNUbMGIJhJ7bPAEMSxnywQ8oGxfho+8zYT221z8boXOgyCxOh39whpQusvKbFFsjENFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668156; c=relaxed/simple;
	bh=yv+L77fsMXdJZp8xBmhx5sk4NgH78Eg0JH6adSKr6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOuC4uqioyMwBphnGO7vKYR2sA4qSt7do+wgy/ow3ZzXo3LZ8gZb+QTI1LrQMbYXKWsL7T7aPhQW8Mu6d8vwmSjMdaRpu8bk6QJm1RUHZJEkQCvWHh/byLCzGXDBhUQquNiDxB0WsuV5cMep2oE2kBLom/LOYHnLpRo995Iucbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SmiIuDwd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so1071351a12.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731668154; x=1732272954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fyp6Vv06X8QaJJQ2SCE2o27IO66FeYIB5lx0bKBn09o=;
        b=SmiIuDwdBp+gcwFc18mSWjWhq7ImCAHJnh8MS0Kz2E09EPQdkejbYiV5vk+X4eCl3L
         s3ux7a414JbKw91kQm7AKwLB5eyJKNYXe4K3p6a07AI2ATMtZdXuGiadG9kocs9biTnA
         W3qtpbXjvGf0AmbRbgV1VYWBbu6by54xW9ieVXwt5c+oPJBf+DxYSwnoUc5tikgri65E
         uAtx9+928NHkIRrgNQzBE5SCHVhMdLC+WoPhIEAA+3pfugLpa83uToETb2IlzOzxSlig
         kVs4V6FZYeAGecDHJoI8oKQE608Q39UY5xzJTlBF/l9+iT8sU3SUUUgLUQSEiA7Umt9A
         Xjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668154; x=1732272954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyp6Vv06X8QaJJQ2SCE2o27IO66FeYIB5lx0bKBn09o=;
        b=gQaXWTs5TxCas8MzhaoE88VNGx1+XZnSqWe4cDiEfOYKg+UWH62XFq0skPBe0UaAYa
         /nV61DXnWix7OFg21XHzQQYwIl4br9UTIjQy8ELHS3+NSmVOK8Vhg2KnQ4GX3/nohd0T
         XKWnDkOEyZemPVc3s0nGAfnefUVGgWpBdEqmGgNoAaUiEeMHjTEAAZcAlpj1pbxA+amG
         a6L6edSsKhpUMn639IG4CLgeOivKcoyEsfbtNdO3o0/zabU8hMJZgaAt1VNwc8fVZlJy
         GukOGjXF3SEAuFfOR1rbRptF86XLEZ9haBjUyDwZpkRsMHYFxodFWSZmuGIgCGY6fYke
         PhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwrQZ6DuSk+uaLk90NSm33BU3BCXGCrfbByg418GQeS/rNuEjiGs0P36XuR8z6Sv/9rz97FFcEBXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVlI6XMk8OMkYZTGp9B3fINIUGaDSOgmg1DqmYfjEmPIPdL8s
	WcNQ7sGJdgOF1moUTKuLKAeYz6eLc+d4Yuz0KoF4+KxP1q+qBYfr1ZgNOIzW2g==
X-Google-Smtp-Source: AGHT+IFKHjiwYWUryAJnXc6viXkuytymPjZ05zS1fGUIKdRqFJ+LJl9Co7F7n3NkThimaKRfh0K2GA==
X-Received: by 2002:a05:6a20:9c91:b0:1dc:32a:d409 with SMTP id adf61e73a8af0-1dc90bf4683mr2847893637.39.1731668154657;
        Fri, 15 Nov 2024 02:55:54 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024c06fbsm2672588a91.43.2024.11.15.02.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:55:54 -0800 (PST)
Date: Fri, 15 Nov 2024 16:25:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document
 ECAM compliant PCIe root complex
Message-ID: <20241115105546.77l3ie5iuajpbuof@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-4-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106221341.2218416-4-quic_mrana@quicinc.com>

On Wed, Nov 06, 2024 at 02:13:40PM -0800, Mayank Rana wrote:
> On SA8255p, PCIe root complex is managed by firmware using power-domain
> based handling. This root complex is configured as ECAM compliant.
> Document required configuration to enable PCIe root complex.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> new file mode 100644
> index 000000000000..9b09c3923ba0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sa8255p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
> +  DesignWare PCIe IP which is managed by firmware, and configured in ECAM mode.
> +
> +properties:
> +  compatible:
> +    const: qcom,pcie-sa8255p
> +
> +  reg:
> +    description:
> +      The Configuration Space base address and size, as accessed from the parent
> +      bus. The base address corresponds to the first bus in the "bus-range"
> +      property. If no "bus-range" is specified, this will be bus 0 (the
> +      default).

I don't think the 'no bus-range' configuration is supported. You can get rid if
this statement.

> +    maxItems: 1
> +
> +  ranges:
> +    description:
> +      As described in IEEE Std 1275-1994, but must provide at least a
> +      definition of non-prefetchable memory. One or both of prefetchable Memory
> +      may also be provided.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 8
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: msi0
> +      - const: msi1
> +      - const: msi2
> +      - const: msi3
> +      - const: msi4
> +      - const: msi5
> +      - const: msi6
> +      - const: msi7
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +  iommu-map: true

Can't you add 'msi-map' also since the hardware supports it?

- Mani

> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - power-domains
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pci@1c00000 {
> +           compatible = "qcom,pcie-sa8255p";
> +           reg = <0x4 0x00000000 0 0x10000000>;
> +           device_type = "pci";
> +           #address-cells = <3>;
> +           #size-cells = <2>;
> +           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
> +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
> +           bus-range = <0x00 0xff>;
> +           dma-coherent;
> +           linux,pci-domain = <0>;
> +           power-domains = <&scmi5_pd 0>;
> +           iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
> +                       <0x100 &pcie_smmu 0x0001 0x1>;
> +           interrupt-parent = <&intc>;
> +           interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +                                  "msi4", "msi5", "msi6", "msi7";
> +        };
> +    };
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

