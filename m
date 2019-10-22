Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC3E01D3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfJVKPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 06:15:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:8000 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfJVKPo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 06:15:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 03:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="201625935"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2019 03:15:43 -0700
Received: from [10.226.39.21] (unknown [10.226.39.21])
        by linux.intel.com (Postfix) with ESMTP id E4EEA58029F;
        Tue, 22 Oct 2019 03:15:39 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
 <20191021111902.GO47056@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0394d6dd-e665-4f00-a600-21fd10acbd9d@linux.intel.com>
Date:   Tue, 22 Oct 2019 18:15:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021111902.GO47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew Murray,

On 10/21/2019 7:19 PM, Andrew Murray wrote:
> On Mon, Oct 21, 2019 at 02:39:18PM +0800, Dilip Kota wrote:
>> Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
> s/shcemas/schemas/
>
>> which is Synopsys DesignWare based PCIe core.
> The revision history below doesn't need to be in the commit mesage and
> so you should add a '---' before the following (and thanks for the
> detailed history).
>
> Besides that:
>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thank you for the review. I will fix the conventions

Regards,
Dilip

>
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
>>
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
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: PCIe registers interface clock.
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
>> +
>> +  bus-range:
>> +    description: Range of bus numbers associated with this controller.
>> +
>> +  reset-assert-ms:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Delay after asserting reset to the PCIe device.
>> +      Some devices need an interval upto 500ms. By default it is 100ms.
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
>> +  - linux,pci-domain
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pcie10:pcie@d0e00000 {
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
>> +      status = "okay";
>> +      reset-assert-ms = <500>;
>> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>> +      num-lanes = <2>;
>> +    };
>> -- 
>> 2.11.0
>>
