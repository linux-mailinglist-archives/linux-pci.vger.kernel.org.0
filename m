Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37AE8348
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 09:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfJ2IeK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 04:34:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:35656 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfJ2IeK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 04:34:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 01:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="202775353"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 01:34:09 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 4518A58049B;
        Tue, 29 Oct 2019 01:34:04 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
 <20191025165352.GA30602@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <72d46086-0918-a5af-d798-7488b55a8e07@linux.intel.com>
Date:   Tue, 29 Oct 2019 16:34:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025165352.GA30602@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/26/2019 12:53 AM, Rob Herring wrote:
> On Mon, Oct 21, 2019 at 02:39:18PM +0800, Dilip Kota wrote:
>> Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
>> which is Synopsys DesignWare based PCIe core.
>>
>> changes on v4:
>> 	Add "snps,dw-pcie" compatible.
>> 	Rename phy-names property value to pcie.
>> 	And maximum and minimum values to num-lanes.
>> 	Add ref for reset-assert-ms entry and update the
>> 	 description for easy understanding.
>> 	Remove pcie core interrupt entry.
>>
>> changes on v3:
>>          Add the appropriate License-Identifier
>>          Rename intel,rst-interval to 'reset-assert-us'
>>          Add additionalProperties: false
>>          Rename phy-names to 'pciephy'
>>          Remove the dtsi node split of SoC and board in the example
>>          Add #interrupt-cells = <1>; or else interrupt parsing will fail
>>          Name yaml file with compatible name
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 +++++++++++++++++++++
>>   1 file changed, 135 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> Fails to validate:
>
> Error: Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dts:38.27-28 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:321: recipe for target 'Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml' failed
>
> Please run 'make -k dt_binding_check' (-k because there are some
> unrelated failures).
>
>> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> new file mode 100644
>> index 000000000000..49dd87ec1e3d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> @@ -0,0 +1,135 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/intel-gw-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PCIe RC controller on Intel Gateway SoCs
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: intel,lgm-pcie
>> +      - const: snps,dw-pcie
>> +
>> +  device_type:
>> +    const: pci
>> +
>> +  "#address-cells":
>> +    const: 3
>> +
>> +  "#size-cells":
>> +    const: 2
>> +
>> +  reg:
>> +    items:
>> +      - description: Controller control and status registers.
>> +      - description: PCIe configuration registers.
>> +      - description: Controller application registers.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: dbi
>> +      - const: config
>> +      - const: app
>> +
>> +  ranges:
>> +    description: Ranges for the PCI memory and I/O regions.
> How many entries do you expect? Add a 'maxItems' to define.
Agree will add it.
>
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: PCIe registers interface clock.
> How many clocks?
One. I will mention maxItems: 1
>
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: pcie
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  num-lanes:
>> +    minimum: 1
>> +    maximum: 2
>> +    description: Number of lanes to use for this port.
>> +
>> +  linux,pci-domain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: PCI domain ID.
> Just a value of 'true' is fine here.
Ok.
>
>> +
>> +  '#interrupt-cells':
>> +    const: 1
>> +
>> +  interrupt-map-mask:
>> +    description: Standard PCI IRQ mapping properties.
>> +
>> +  interrupt-map:
>> +    description: Standard PCI IRQ mapping properties.
>> +
>> +  max-link-speed:
>> +    description: Specify PCI Gen for link capability.
> Allowed values? Default?
Sure, will add it.
>
>> +
>> +  bus-range:
>> +    description: Range of bus numbers associated with this controller.
>> +
>> +  reset-assert-ms:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> Don't need a type for standard units.
Ok.
>
>> +    description: |
>> +      Delay after asserting reset to the PCIe device.
>> +      Some devices need an interval upto 500ms. By default it is 100ms.
> Express as a schema:
>
> maximum: 500
> default: 100
Sure i will update it.
>
>> +
>> +required:
>> +  - compatible
>> +  - device_type
>> +  - reg
>> +  - reg-names
>> +  - ranges
>> +  - resets
>> +  - clocks
>> +  - phys
>> +  - phy-names
>> +  - reset-gpios
>> +  - num-lanes
> Shouldn't be required. It should have a default.
Agree, will fix it.
>
>> +  - linux,pci-domain
> Is this really required? AIUI, domains are optional and only used if
> you have more than one host.
Yes, not required. I will update,
>
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pcie10:pcie@d0e00000 {
> space         ^
Agree, i will fix it.
>
>> +      compatible = "intel,lgm-pcie", "snps,dw-pcie";
>> +      device_type = "pci";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      reg = <0xd0e00000 0x1000>,
>> +            <0xd2000000 0x800000>,
>> +            <0xd0a41000 0x1000>;
>> +      reg-names = "dbi", "config", "app";
>> +      linux,pci-domain = <0>;
>> +      max-link-speed = <4>;
>> +      bus-range = <0x00 0x08>;
>> +      interrupt-parent = <&ioapic1>;
>> +      #interrupt-cells = <1>;
>> +      interrupt-map-mask = <0 0 0 0x7>;
>> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
>> +                      <0 0 0 2 &ioapic1 28 1>,
>> +                      <0 0 0 3 &ioapic1 29 1>,
>> +                      <0 0 0 4 &ioapic1 30 1>;
>> +      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
>> +      resets = <&rcu0 0x50 0>;
>> +      clocks = <&cgu0 LGM_GCLK_PCIE10>;
> You need to include any defines you use. That's why the example fails to
> build.
Yes, i will add it.
>
>> +      phys = <&cb0phy0>;
>> +      phy-names = "pcie";
>> +      status = "okay";
> Don't show status in examples.
OK, will fix it.

Thanks for reviewing it.

Regards,
Dilip
>
>> +      reset-assert-ms = <500>;
>> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>> +      num-lanes = <2>;
>> +    };
>> -- 
>> 2.11.0
>>
