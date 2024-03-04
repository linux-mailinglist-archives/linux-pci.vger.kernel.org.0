Return-Path: <linux-pci+bounces-4383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE686F9B8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 06:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888A7281294
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92698BA27;
	Mon,  4 Mar 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW8T/5sS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57620BA33
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531383; cv=none; b=TQFuDnu2O3FUekPYRRy1mlvoJVv3Mc/BDjQyO2DiVbWeR+py727EnZhhIy4pqUkCAQt7Tri1od9HmQoc5Cv1hzqyHSYVrVDG6FuOpfE9p8RpP0eV7vQrtkhZzQRJQInHA0M4EHJXPlOKyCpT9JMuaFA8ydsC+R5g4C1hP/urz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531383; c=relaxed/simple;
	bh=0lWW9AfozQqKBDt6Ue4iDfWuXKOlKqj5H3BkAFd4JsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xsjc4aYE5W7TJB+OpVYDumHB+Y2rrtwlVDnzgqS8VH5i4ksjcciJZ4KL8o1oWGLF05JEGH4/TQCnm05gqb0EIk3Rmh0ZqFmnuR6I37o5XY8B/lgPPJJGBQ5m8EiYvJuRMeJe0OKY7SuvhYiNEunZh6Hq2Y5NmuceezHaiKsGgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xW8T/5sS; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c1f173f76eso197032b6e.1
        for <linux-pci@vger.kernel.org>; Sun, 03 Mar 2024 21:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709531379; x=1710136179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eUCm3cHKUrzsBg+iebnTzHjVpJQ4bu98MP5OPl6dous=;
        b=xW8T/5sSd9tSjpPLOEOdcQTshvw8nhP8AJzWHI/vhdp+l34IZdL1+69QSOfwxSjx90
         /YyAGTsLnadLzgzX6ImgKBwl2YnJ/OV1+XzQcH8vuOKfdi3Fy9eu9HLhwpvUaKq4Pq21
         pXtIDEHHqlLc2P+7TC/FFTn+WG2r1FXR9TORbD0f5YQ4OqFv6xfAiWQhaj5wjYTAGt0s
         +nCzAVG91cK07J1p/jOIHnG8V6ebOP8eZTfSq3zOaMhD0sYgzNDlKpg9vNneHI1LU6vg
         gcTnD9rxMdNlTr0ZUPyZpuAe8ie24uUR2eq4u+9bSbY9zmAWLABxo6si1hMiu9QXbg5t
         mBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709531379; x=1710136179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUCm3cHKUrzsBg+iebnTzHjVpJQ4bu98MP5OPl6dous=;
        b=Cd7RP6UVupI1nhHAqFPjPAx83+qGRsR6onCiSLqUsXjUIgCXstlSDwCzLF5ArCnMEj
         ExDc7FkzmyOR6R2NL1QNDbhZ4WC/yF5Qt03KG1mKHmxw3A5TeXsR2XkQ70ImhBMeFeTE
         NSKQhjJvlvr22hAc+CHhimHeyI6sEzUefkDVPHt/bNvq/NkV/HMtRTMobgWG6EgYB0lp
         AqdpWsGY6+letb3q28+Jhv/YlqDGNi5FHKeHHDN9mZXQ4wIUmJTqEocNlvdOA1hRgt5+
         KA3W1r21FB2D0JXP1A35IjSXr01H9ApP8pDrV/v2yehe9ynBTUsLgbyF2J6fQs9b5mm+
         49+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh8NdtGvoalNM+cKo6mCEmDdbqyIb/PE2aEKeZosm+R+NhU08SznLPwH/crilB7UcWl8kycv0S0FwNbAOvcvQszF9hVUJCWpE/
X-Gm-Message-State: AOJu0Yz0tfpbMiz+IEFYUJQWPNHnzTi/dlUil/pOQkjmJg25QVOwtVLW
	u2GKzoC/U+tsxH8SaD1UbyuLfBL0rG7oFBmotRygsAcauQR2S5aVczma36nydA==
X-Google-Smtp-Source: AGHT+IGrhz7hfkOSFRicSn1ybgnXsi9KuNOUzMyw7lHfQRZv3dDJpwKFk4OY64adl6kfzl/7mLgV0A==
X-Received: by 2002:a05:6808:1782:b0:3c1:d903:fd40 with SMTP id bg2-20020a056808178200b003c1d903fd40mr8727895oib.55.1709531379437;
        Sun, 03 Mar 2024 21:49:39 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b006e091a254adsm6480796pfn.30.2024.03.03.21.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 21:49:39 -0800 (PST)
Date: Mon, 4 Mar 2024 11:19:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller
Message-ID: <20240304054932.GB2647@thinkpad>
References: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
 <20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org>

On Fri, Mar 01, 2024 at 06:59:01PM +0200, Abel Vesa wrote:
> Add dedicated schema for the PCIe controllers found on X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../bindings/pci/qcom,pcie-x1e80100.yaml           | 165 +++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> new file mode 100644
> index 000000000000..1074310a8e7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm X1E80100 PCI Express Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm X1E80100 SoC (and compatible) PCIe root complex controller is based on
> +  the Synopsys DesignWare PCIe IP.
> +
> +properties:
> +  compatible:
> +    const: qcom,pcie-x1e80100
> +
> +  reg:
> +    minItems: 5
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 5
> +    items:
> +      - const: parf # Qualcomm specific registers
> +      - const: dbi # DesignWare PCIe registers
> +      - const: elbi # External local bus interface registers
> +      - const: atu # ATU address space
> +      - const: config # PCIe configuration space
> +      - const: mhi # MHI registers
> +
> +  clocks:
> +    minItems: 7
> +    maxItems: 7
> +
> +  clock-names:
> +    items:
> +      - const: aux # Auxiliary clock
> +      - const: cfg # Configuration clock
> +      - const: bus_master # Master AXI clock
> +      - const: bus_slave # Slave AXI clock
> +      - const: slave_q2a # Slave Q2A clock
> +      - const: noc_aggr # Aggre NoC PCIe AXI clock
> +      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
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
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: pci # PCIe core reset
> +      - const: link_down # PCIe link down reset
> +
> +allOf:
> +  - $ref: qcom,pcie-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@1c08000 {
> +            compatible = "qcom,pcie-x1e80100";
> +            reg = <0 0x01c08000 0 0x3000>,
> +                  <0 0x7c000000 0 0xf1d>,
> +                  <0 0x7c000f40 0 0xa8>,
> +                  <0 0x7c001000 0 0x1000>,
> +                  <0 0x7c100000 0 0x100000>,
> +                  <0 0x01c0b000 0 0x1000>;
> +            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
> +            ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
> +                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
> +
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            linux,pci-domain = <0>;
> +            num-lanes = <2>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +
> +            clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
> +                     <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
> +                     <&gcc GCC_PCIE_4_MSTR_AXI_CLK>,
> +                     <&gcc GCC_PCIE_4_SLV_AXI_CLK>,
> +                     <&gcc GCC_PCIE_4_SLV_Q2A_AXI_CLK>,
> +                     <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
> +                     <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
> +            clock-names = "aux",
> +                          "cfg",
> +                          "bus_master",
> +                          "bus_slave",
> +                          "slave_q2a",
> +                          "noc_aggr",
> +                          "cnoc_sf_axi";
> +
> +            dma-coherent;
> +
> +            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +                              "msi4", "msi5", "msi6", "msi7";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0x7>;
> +            interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                            <0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                            <0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                            <0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +            interconnects = <&pcie_noc MASTER_PCIE_4 0 &mc_virt SLAVE_EBI1 0>,
> +                            <&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_4 0>;
> +            interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +            iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
> +                        <0x100 &apps_smmu 0x1401 0x1>;
> +
> +            phys = <&pcie4_phy>;
> +            phy-names = "pciephy";
> +
> +            pinctrl-0 = <&pcie0_default_state>;
> +            pinctrl-names = "default";
> +
> +            power-domains = <&gcc GCC_PCIE_4_GDSC>;
> +
> +            resets = <&gcc GCC_PCIE_4_BCR>;
> +            reset-names = "pci";
> +
> +            perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +            wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

