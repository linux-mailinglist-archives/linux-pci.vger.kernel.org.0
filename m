Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321F7127814
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLTJ0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 04:26:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:33849 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfLTJ0l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 04:26:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 01:26:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="298971795"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2019 01:26:39 -0800
Received: from [10.226.39.9] (unknown [10.226.39.9])
        by linux.intel.com (Postfix) with ESMTP id C428758042B;
        Fri, 20 Dec 2019 01:26:36 -0800 (PST)
Subject: Re: [PATCH v11 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
 <a276c1107d40917901a4265d4d8622dee060e4f5.1575860791.git.eswara.kota@linux.intel.com>
 <CAL_JsqJE=7P3z8AzWUfWu1PCV4EVC1PBJ+ZAu3vmAcq5G5D34g@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <621fb081-e3de-0c4f-3d3d-03c5ad19fa07@linux.intel.com>
Date:   Fri, 20 Dec 2019 17:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJE=7P3z8AzWUfWu1PCV4EVC1PBJ+ZAu3vmAcq5G5D34g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/20/2019 12:32 AM, Rob Herring wrote:
> On Sun, Dec 8, 2019 at 9:20 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>> Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
>> which is Synopsys DesignWare based PCIe core.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 +++++++++++++++++++++
>>   1 file changed, 138 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> new file mode 100644
>> index 000000000000..db605d8a387d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> @@ -0,0 +1,138 @@
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
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
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
>> +  linux,pci-domain: true
>> +
>> +  num-lanes:
>> +    maximum: 2
>> +    description: Number of lanes to use for this port.
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
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +      - enum: [ 1, 2, 3, 4 ]
>> +      - default: 1
>> +
>> +  bus-range:
>> +    description: Range of bus numbers associated with this controller.
>> +
>> +  reset-assert-ms:
>> +    description: |
>> +      Delay after asserting reset to the PCIe device.
>> +    maximum: 500
>> +    default: 100
>> +
>> +required:
>> +  - compatible
>> +  - device_type
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - reg
>> +  - reg-names
>> +  - ranges
>> +  - resets
>> +  - clocks
>> +  - phys
>> +  - phy-names
>> +  - reset-gpios
>> +  - '#interrupt-cells'
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/clock/intel,lgm-clk.h>
> I guess this is applied now as the example fails to build in
> linux-next as this header is missing.
>
> At this point I'd settle for just 'make dt_binding_check' passing on
> linux-next even though it should pass on maintainer trees too.
> However, it doesn't appear the clock driver with this header is close
> to being merged. The binding was sent on Aug 28 and not to the DT list
> so I hadn't seen it. Given that, I'd suggest a follow-up patch to
> remove the header dependency here. Just change LGM_GCLK_PCIE10 to the
> value.
Sure, i will send the patch.

Regards,
Dilip
>> +    pcie10: pcie@d0e00000 {
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
>> +      phys = <&cb0phy0>;
>> +      phy-names = "pcie";
>> +      reset-assert-ms = <500>;
>> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>> +      num-lanes = <2>;
>> +    };
>> --
>> 2.11.0
>>
