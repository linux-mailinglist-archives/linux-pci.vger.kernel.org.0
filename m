Return-Path: <linux-pci+bounces-39756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B204C1EA59
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 07:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5C4E72F2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAF332907;
	Thu, 30 Oct 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4z8y0VB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352C330B3A;
	Thu, 30 Oct 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807327; cv=none; b=rwVojP32/Z1YAj0L3QH4GGR3eAcB7r4GoWbh489Nz4FM8q2EDVjLjz9ivKKLwx/okbqlAmVu7xgNmKf/mXeTNNQZuGT6cX2LMZvjh6/Wnd44l2sRIboLE/1NcY2JeXS+jPSqeSGfvV0iZ2pXDm1KSdGMrGrXUtKgavhizNpfAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807327; c=relaxed/simple;
	bh=yJNot/L1FZElavTVqRpdeHOkZHl+o+JVvxEJqvm2MOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crUT8RM4g4Bm7HY7N3OfPFxmAvnGQBJ2oGDk6tFcIVlxK78wKtlC8yDjomCqPDSBgCjCWfcx/tED32H6h0vnId/RCBuj5ycReOIJd0NI27wpsA3nnhAtYWnrwwYFB6VL81SU9z1sRBW+p/noRml2yqSNYwCBgcPrd0y0Tpnawpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4z8y0VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06620C4CEF1;
	Thu, 30 Oct 2025 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761807326;
	bh=yJNot/L1FZElavTVqRpdeHOkZHl+o+JVvxEJqvm2MOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4z8y0VBuCrokTzT4jIwmscyR8/HZ/pZTmMWRiX6kLaywSyxb4KZFhZZw+xeIsyd4
	 j/IOAoV06gxV5IiyOgLDgdxeTcZ0Ujzieq3GGz28IUmxY2t1Z0E4t4MezjN7Vxka3H
	 tU8vsvRaECsZaATOkiQ7IIQtGwcQvfJef+d4HvNynDNLb6tjtQRG2pKBoN+3erMZEp
	 7APYANH/CuK3Yu6A+ZceIc5YirMtctbZcKUC/oKvJ48eStXdgK3Sx6b2KmP2W/q5W0
	 WeF1fX6oWpdwjdZSpbKKNj8PZO+swfjmGS8hQznqM4/jJo+GwVFcESPNZjTxQ+Wvj8
	 6phfvtcWsu3uw==
Date: Thu, 30 Oct 2025 12:25:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com, amitk@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 1/8] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Message-ID: <vyetr5j5cjlfg7jr7duykwlid3eyzkbwd2giycb45v6ez57wri@i5orxtws4syg>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-1-68426de5844a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-qps615_v4_1-v7-1-68426de5844a@oss.qualcomm.com>

On Wed, Oct 29, 2025 at 04:59:54PM +0530, Krishna Chaitanya Chundru wrote:
> Add a device tree binding for the Toshiba TC9563 PCIe switch, which
> provides an Ethernet MAC integrated to the 3rd downstream port and
> two downstream PCIe ports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..82c902b67852d6c4b0305764a2231fe04e83458d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/toshiba,tc9563.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9563 PCIe switch
> +
> +maintainers:
> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> +
> +description: |
> +  Toshiba TC9563 PCIe switch has one upstream and three downstream ports.
> +  The 3rd downstream port has integrated endpoint device of Ethernet MAC.
> +  Other two downstream ports are supposed to connect to external device.
> +
> +  The TC9563 PCIe switch can be configured through I2C interface before
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
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the RESX# pin.

PCI binding already defines PERST# as 'reset-gpios'. Since this pin is called
RESX in the device reference manual, it'd be better to rename it to
'resx-gpios'.

With this,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

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
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle to the parent I2C node and the slave address of the device
> +      used to do configure tc9563 to change FTS, tx amplitude etc.
> +    items:
> +      - description: Phandle to the I2C controller node
> +      - description: I2C slave address
> +
> +patternProperties:
> +  "^pcie@[1-3],0$":
> +    description:
> +      child nodes describing the internal downstream ports
> +      the tc9563 switch.
> +    type: object
> +    allOf:
> +      - $ref: "#/$defs/tc9563-node"
> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    unevaluatedProperties: false
> +
> +$defs:
> +  tc9563-node:
> +    type: object
> +
> +    properties:
> +      toshiba,tx-amplitude-microvolt:
> +        description:
> +          Change Tx Margin setting for low power consumption.
> +
> +      toshiba,no-dfe-support:
> +        type: boolean
> +        description:
> +          Disable DFE (Decision Feedback Equalizer), which mitigates
> +          intersymbol interference and some reflections caused by impedance mismatches.
> +
> +required:
> +  - reset-gpios
> +  - vdd18-supply
> +  - vdd09-supply
> +  - vddc-supply
> +  - vddio1-supply
> +  - vddio2-supply
> +  - vddio18-supply
> +  - i2c-parent
> +
> +allOf:
> +  - $ref: "#/$defs/tc9563-node"
> +  - $ref: /schemas/pci/pci-bus-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
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
> +
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
> +                    compatible = "pciclass,0604";
> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x03 0xff>;
> +
> +                    toshiba,no-dfe-support;
> +                };
> +
> +                pcie@2,0 {
> +                    compatible = "pciclass,0604";
> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x04 0xff>;
> +                };
> +
> +                pcie@3,0 {
> +                    compatible = "pciclass,0604";
> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +                    bus-range = <0x05 0xff>;
> +
> +                    toshiba,tx-amplitude-microvolt = <10>;
> +
> +                    ethernet@0,0 {
> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> +                    };
> +
> +                    ethernet@0,1 {
> +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

