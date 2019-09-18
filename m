Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6285DB5DAA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfIRG4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 02:56:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:24802 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfIRG4m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 02:56:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 23:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; 
   d="scan'208";a="189175320"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2019 23:56:40 -0700
Received: from [10.226.39.42] (unknown [10.226.39.42])
        by linux.intel.com (Postfix) with ESMTP id 5E79258012D;
        Tue, 17 Sep 2019 23:56:37 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <20190917184013.GB24684@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <bf5c8a24-e969-87d4-c62b-4032273e0824@linux.intel.com>
Date:   Wed, 18 Sep 2019 14:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190917184013.GB24684@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/18/2019 2:40 AM, Rob Herring wrote:
> On Wed, Sep 04, 2019 at 06:10:30PM +0800, Dilip Kota wrote:
>> The Intel PCIe RC controller is Synopsys Designware
>> based PCIe core. Add YAML schemas for PCIe in RC mode
>> present in Intel Universal Gateway soc.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> changes on v3:
>> 	Add the appropriate License-Identifier
>> 	Rename intel,rst-interval to 'reset-assert-us'
>> 	Add additionalProperties: false
>> 	Rename phy-names to 'pciephy'
>> 	Remove the dtsi node split of SoC and board in the example
>> 	Add #interrupt-cells = <1>; or else interrupt parsing will fail
>> 	Name yaml file with compatible name
>>
>>   .../devicetree/bindings/pci/intel,lgm-pcie.yaml    | 137 +++++++++++++++++++++
>>   1 file changed, 137 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>> new file mode 100644
>> index 000000000000..5e5cc7fd66cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>> @@ -0,0 +1,137 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/intel-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel AXI bus based PCI express root complex
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-pcie
>> +
>> +  device_type:
>> +    const: pci
>> +
>> +  "#address-cells":
>> +    const: 3
>> +
>> +  "#size-cells":
>> +    const: 2
> These all belong in a common schema.
>
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
> And this.
>
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
>> +    const: pciephy
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  num-lanes:
>> +    description: Number of lanes to use for this port.
>> +
>> +  linux,pci-domain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: PCI domain ID.
> These 2 also should be common.
>
>> +
>> +  interrupts:
>> +    description: PCIe core integrated miscellaneous interrupt.
> How many? No need for description if there's only 1.
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
>> +
>> +  bus-range:
>> +    description: Range of bus numbers associated with this controller.
> All common.
You mean to remove all the common schema entries description!.
In most of the Documention/devicetree/binding/pci documents all the 
common entries are described so I followed the same.
>
>> +
>> +  reset-assert-ms:
>> +    description: |
>> +      Device reset interval in ms.
>> +      Some devices need an interval upto 500ms. By default it is 100ms.
> This is a property of a device, so it belongs in a device node. How
> would you deal with this without DT?
This property is for the PCIe RC to keep a delay before notifying the 
reset to the device.
If this entry is not present, PCIe driver will set a default value of 100ms.
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
>> +  - linux,pci-domain
>> +  - interrupts
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pcie10:pcie@d0e00000 {
>> +      compatible = "intel,lgm-pcie";
>> +      device_type = "pci";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      reg = <
>> +            0xd0e00000 0x1000
>> +            0xd2000000 0x800000
>> +            0xd0a41000 0x1000
>> +            >;
>> +      reg-names = "dbi", "config", "app";
>> +      linux,pci-domain = <0>;
>> +      max-link-speed = <4>;
>> +      bus-range = <0x00 0x08>;
>> +      interrupt-parent = <&ioapic1>;
>> +      interrupts = <67 1>;
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
>> +      phy-names = "pciephy";
>> +      status = "okay";
>> +      reset-assert-ms = <500>;
>> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>> +      num-lanes = <2>;
>> +    };
>> -- 
>> 2.11.0
>>
