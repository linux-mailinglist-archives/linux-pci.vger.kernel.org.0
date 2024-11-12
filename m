Return-Path: <linux-pci+bounces-16559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D959C5C6A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0D282296
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5420606A;
	Tue, 12 Nov 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t08XEE5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A120402C;
	Tue, 12 Nov 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426596; cv=none; b=EsT9m7OfRYDH8bZs5keh4XuoZZOLPfR0w3DyAuDU1jYwMPnad4W2oCmkI7ImgU6oBULcreih89HyKIB549ijfSLlG2KBUROw6sei821OBdpVgqcdYSAyvxplsLgRIAkY85T8u5JiCirHE4YmiJYaXIqOMsNvb0Jz8UaErlgAZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426596; c=relaxed/simple;
	bh=NHAnQSUL2/aylV2Ns82CTspJ8igarCg0VqlVO762LkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbizUDEn5t3hLPbzy+uR9R4uWTz169oXSDvs8EeAO3wxNOSH0zJhbxNYPozM3i9KGRF5pf/LvuKXiprMDJlYkQF51I1Vk84Oa+PjCaMjOQvwCbU13DuoxJR3BZwEGdNZhE8kvrbYhr4toEAj9Uof8B9GJ6ROmhvjK2fJ7loYh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t08XEE5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD2BC4CECD;
	Tue, 12 Nov 2024 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426596;
	bh=NHAnQSUL2/aylV2Ns82CTspJ8igarCg0VqlVO762LkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t08XEE5wlPypXrgKVLYYvo7gkFoMsSpJ2w3C1kJS06l6WSEOtMWdiGCeKGprjdNKk
	 8JrzD8OnyL9aX6aAg1OYlrKfOZtpnYV5nVNS/A80nERyuEnuFmhiosYs/6JU7n+T9x
	 xUC6mHBceaqYUH+0lymCorUlZVUe79Xh/kXoJvZs8w1SoRIW3LuZ3c+x4PhXFOxjGM
	 9dvGV3Lc0/3pMj7ynjZl9geF99rfGQ/j+hIzkciKbLFWqNPBgW4myIiLNB6IGIr9CW
	 iLk7oOknR/mPMlJhSwwfwjOahcm9mhmVrusjlhlsoc94R7QJlKOqDHRPA4tPiKhd9W
	 vylSD9YM//b2Q==
Date: Tue, 12 Nov 2024 09:49:53 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <zxvg4s6jr3dpcffflif33i7mi3womsfkml2yj5vwaoj74zp6cr@6a2uzacppvcw>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> Add binding describing the Qualcomm PCIe switch, QPS615,
> which provides Ethernet MAC integrated to the 3rd downstream port
> and two downstream PCIe ports.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
>  1 file changed, 205 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> new file mode 100644
> index 000000000000..e6a63a0bb0f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPS615 PCIe switch
> +
> +maintainers:
> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> +
> +description: |
> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> +  ports. The 3rd downstream port has integrated endpoint device of
> +  Ethernet MAC. Other two downstream ports are supposed to connect
> +  to external device.
> +
> +  The QPS615 PCIe switch can be configured through I2C interface before
> +  PCIe link is established to change FTS, ASPM related entry delays,
> +  tx amplitude etc for better power efficiency and functionality.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0623
> +
> +  reg:
> +    maxItems: 1
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      A phandle to the parent I2C node and the slave address of the device
> +      used to do configure qps615 to change FTS, tx amplitude etc.
> +    items:
> +      - description: Phandle to the I2C controller node
> +      - description: I2C slave address
> +
> +  vdd18-supply: true
> +
> +  vdd09-supply: true
> +
> +  vddc-supply: true
> +
> +  vddio1-supply: true
> +
> +  vddio2-supply: true
> +
> +  vddio18-supply: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the RESX# pin.
> +
> +  qps615,axi-clk-freq-hz:
> +    description:
> +      AXI clock rate which is internal bus of the switch
> +      The switch only runs in two frequencies i.e 250MHz and 125MHz.
> +    enum: [125000000, 250000000]
> +
> +allOf:
> +  - $ref: "#/$defs/qps615-node"
> +
> +patternProperties:
> +  "@1?[0-9a-f](,[0-7])?$":
> +    description: child nodes describing the internal downstream ports
> +      the qps615 switch.
> +    type: object
> +    $ref: "#/$defs/qps615-node"
> +    unevaluatedProperties: false
> +
> +$defs:
> +  qps615-node:
> +    type: object
> +
> +    properties:
> +      qcom,l0s-entry-delay-ns:
> +        description: Aspm l0s entry delay.
> +
> +      qcom,l1-entry-delay-ns:
> +        description: Aspm l1 entry delay.
> +
> +      qcom,tx-amplitude-millivolt:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Change Tx Margin setting for low power consumption.
> +
> +      qcom,no-dfe-support:
> +        type: boolean
> +        description: Disable DFE (Decision Feedback Equalizer), which mitigates
> +          intersymbol interference and some reflections caused by impedance mismatches.
> +
> +      qcom,nfts:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
> +          for bit and Symbol lock.
> +
> +    allOf:
> +      - $ref: /schemas/pci/pci-bus.yaml#
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - vdd18-supply
> +  - vdd09-supply
> +  - vddc-supply
> +  - vddio1-supply
> +  - vddio2-supply
> +  - vddio18-supply
> +  - i2c-parent
> +  - reset-gpios
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +            bus-range = <0x01 0xff>;
> +
> +            pcie@0,0 {
> +                compatible = "pci1179,0623";
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +                device_type = "pci";
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                bus-range = <0x02 0xff>;
> +
> +                i2c-parent = <&qup_i2c 0x77>;
> +
> +                vdd18-supply = <&vdd>;
> +                vdd09-supply = <&vdd>;
> +                vddc-supply = <&vdd>;
> +                vddio1-supply = <&vdd>;
> +                vddio2-supply = <&vdd>;
> +                vddio18-supply = <&vdd>;
> +
> +                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +
> +                pcie@1,0 {
> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x03 0xff>;
> +
> +                    qcom,no-dfe-support;
> +                };
> +
> +                pcie@2,0 {
> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x04 0xff>;
> +
> +                    qcom,nfts = <10>;
> +                };
> +
> +                pcie@3,0 {
> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x05 0xff>;
> +
> +                    qcom,tx-amplitude-millivolt = <10>;
> +                    pcie@0,0 {
> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> +                        #address-cells = <3>;
> +                        #size-cells = <2>;
> +                        device_type = "pci";
> +                        ranges;
> +
> +                        qcom,l1-entry-delay-ns = <10>;
> +                    };
> +
> +                    pcie@0,1 {
> +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
> +                        #address-cells = <3>;
> +                        #size-cells = <2>;
> +                        device_type = "pci";
> +                        ranges;
> +
> +                        qcom,l0s-entry-delay-ns = <10>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

