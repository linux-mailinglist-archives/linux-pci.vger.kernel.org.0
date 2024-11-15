Return-Path: <linux-pci+bounces-16891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E809CF21D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CDB2ABC3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1B1BCA19;
	Fri, 15 Nov 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V00Oes+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304C16A395;
	Fri, 15 Nov 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687531; cv=none; b=sdhEwvQgJUP6uIphpGZZtGTV/Y4bCat0bL9AlVTeATuei+3i2WbqV7hoscyPopM6B3fjDlzaRkvpPDvEWcX8jppY0wJIxkpLhpMlDMjNuwp+NHafC6Y4+W2tcKYq4aWvi3O3vXwUuuHaQTRR+kUfmZDt8KTmUXFH88vNnddEkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687531; c=relaxed/simple;
	bh=eIt2dRvajOmIZWp7+5k5YIXv0JpSJpmis+4Jvj/A61U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOYGvi0BBzrsCuduHWuN8BHUMFuB9K4Ecfi7FrX10QLI8KsEYQrxLITaGCaJ+VgnaV9O0XwRZ0b6aXtulLRAqZNs+bUgqWIVglFr1tr1eOndkZBP6LQGjBOwCzAoAGuBLTVfezAXhvQ3tvjRU7IWbkuCQn7nreMrHE3q+/x3tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V00Oes+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A50C4CECF;
	Fri, 15 Nov 2024 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731687530;
	bh=eIt2dRvajOmIZWp7+5k5YIXv0JpSJpmis+4Jvj/A61U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V00Oes+zkkC5zL2nTxhoAeiUErUS7fy6LDcPtMiEhsrpTujwCpY6TFC7MzbWw4kNV
	 2D2BGNng8RHML7rad6XwF5t/O9LaYf9Orf3vCZLTi3gyf9BA+1SPJtsJlnUWG9f4Ui
	 hH7WBg2ZV6+QwI/Cy2WjPXwVnFSaSG/QN3WSETMvOz8VtsOZ+K4OAlG9/7k+1hnVdk
	 j9Lb3rpKB5TnVwxTy9BNJNeszFD3W1jEiHyFtcHfPhQFTYfXcDX5TtWjNvY5jGXIR7
	 mdIeAA9r7GIgFcwrbj58qAOcK3lt7rWlHyf+mPTRu1MnuFRISsGthoLtUciac/Lr3g
	 mwSzWFYKNXCeQ==
Date: Fri, 15 Nov 2024 10:18:48 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20241115161848.GA2961450-robh@kernel.org>
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

Don't need '|' if no formatting to preserve.

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

Is the PERST# or something else?

> +
> +  qps615,axi-clk-freq-hz:

qps615 is not a vendor prefix.

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

You have 3 ports. So isn't this fixed and limited to 0-2?

> +    description: child nodes describing the internal downstream ports
> +      the qps615 switch.

Please be consistent with starting after the ':' or on the next line.

And start with capital C.


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

These should probably be common being standard PCIe things. Though, why 
are they needed? I'm sure the timing is defined by the PCIe spec, so 
they are not compliant?

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

Also something common.

The problem I have with all these properties is you are using them on 
both the upstream and downstream sides of the PCIe links. They belong in 
either the device's node (downstream) or the bus's node (upstream). 

> +
> +    allOf:
> +      - $ref: /schemas/pci/pci-bus.yaml#

pci-pci-bridge.yaml is more specific and closer to what this device is.

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

There's a 2nd PCI-PCI bridge?

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

