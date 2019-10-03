Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45074C984F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 08:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfJCGfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 02:35:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:24154 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfJCGfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 02:35:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 23:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="205546053"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2019 23:35:06 -0700
Received: from [10.226.39.36] (unknown [10.226.39.36])
        by linux.intel.com (Postfix) with ESMTP id 86F485803A5;
        Wed,  2 Oct 2019 23:35:03 -0700 (PDT)
Subject: Re: Fwd: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas
 for the PCIe RC controller
To:     Rob Herring <robh@kernel.org>
References: <bf5c8a24-e969-87d4-c62b-4032273e0824@linux.intel.com>
 <b7e549bb-b46c-c393-50ac-9ef3b198fd49@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <655892bd-6b62-ec2b-ff85-89ca1f86326e@linux.intel.com>
Date:   Thu, 3 Oct 2019 14:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b7e549bb-b46c-c393-50ac-9ef3b198fd49@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,


On 18/9/2019 2:56 PM, Dilip Kota wrote:
> On 9/18/2019 2:40 AM, Rob Herring wrote:
>> On Wed, Sep 04, 2019 at 06:10:30PM +0800, Dilip Kota wrote:
>>> The Intel PCIe RC controller is Synopsys Designware
>>> based PCIe core. Add YAML schemas for PCIe in RC mode
>>> present in Intel Universal Gateway soc.
>>>
>>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>>> ---
>>> changes on v3:
>>> Add the appropriate License-Identifier
>>> Rename intel,rst-interval to 'reset-assert-us'
>>> Add additionalProperties: false
>>> Rename phy-names to 'pciephy'
>>> Remove the dtsi node split of SoC and board in the example
>>> Add #interrupt-cells = <1>; or else interrupt parsing will fail
>>> Name yaml file with compatible name
>>>
>>> .../devicetree/bindings/pci/intel,lgm-pcie.yaml | 137 
>>> +++++++++++++++++++++
>>> 1 file changed, 137 insertions(+)
>>> create mode 100644 
>>> Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml 
>>> b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..5e5cc7fd66cd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>>> @@ -0,0 +1,137 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/intel-pcie.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Intel AXI bus based PCI express root complex
>>> +
>>> +maintainers:
>>> + - Dilip Kota <eswara.kota@linux.intel.com>
>>> +
>>> +properties:
>>> + compatible:
>>> + const: intel,lgm-pcie
>>> +
>>> + device_type:
>>> + const: pci
>>> +
>>> + "#address-cells":
>>> + const: 3
>>> +
>>> + "#size-cells":
>>> + const: 2
>> These all belong in a common schema.
>>
>>> +
>>> + reg:
>>> + items:
>>> + - description: Controller control and status registers.
>>> + - description: PCIe configuration registers.
>>> + - description: Controller application registers.
>>> +
>>> + reg-names:
>>> + items:
>>> + - const: dbi
>>> + - const: config
>>> + - const: app
>>> +
>>> + ranges:
>>> + description: Ranges for the PCI memory and I/O regions.
>> And this.
>>
>>> +
>>> + resets:
>>> + maxItems: 1
>>> +
>>> + clocks:
>>> + description: PCIe registers interface clock.
>>> +
>>> + phys:
>>> + maxItems: 1
>>> +
>>> + phy-names:
>>> + const: pciephy
>>> +
>>> + reset-gpios:
>>> + maxItems: 1
>>> +
>>> + num-lanes:
>>> + description: Number of lanes to use for this port.
>>> +
>>> + linux,pci-domain:
>>> + $ref: /schemas/types.yaml#/definitions/uint32
>>> + description: PCI domain ID.
>> These 2 also should be common.
>>
>>> +
>>> + interrupts:
>>> + description: PCIe core integrated miscellaneous interrupt.
>> How many? No need for description if there's only 1.
>>
>>> +
>>> + '#interrupt-cells':
>>> + const: 1
>>> +
>>> + interrupt-map-mask:
>>> + description: Standard PCI IRQ mapping properties.
>>> +
>>> + interrupt-map:
>>> + description: Standard PCI IRQ mapping properties.
>>> +
>>> + max-link-speed:
>>> + description: Specify PCI Gen for link capability.
>>> +
>>> + bus-range:
>>> + description: Range of bus numbers associated with this controller.
>> All common.
> You mean to remove all the common schema entries description!.
> In most of the Documention/devicetree/binding/pci documents all the 
> common entries are described so I followed the same.

If common schemas are removed, getting below warning during the 
dt_binding_check.

Documentation/devicetree/bindings/pci/intel,lgm-pcie.example.dt.yaml: 
pcie@d0e00000: '#address-cells', '#interrupt-cells', '#size-cells', 
'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 
'interrupt-parent', 'linux,pci-domain', 'ranges', 'reset-gpios' do not 
match any of the regexes: 'pinctrl-[0-9]+'

Regards,
Dilip

>>
>>> +
>>> + reset-assert-ms:
>>> + description: |
>>> + Device reset interval in ms.
>>> + Some devices need an interval upto 500ms. By default it is 100ms.
>> This is a property of a device, so it belongs in a device node. How
>> would you deal with this without DT?
> This property is for the PCIe RC to keep a delay before notifying the 
> reset to the device.
> If this entry is not present, PCIe driver will set a default value of 
> 100ms.
>>
>>> +
>>> +required:
>>> + - compatible
>>> + - device_type
>>> + - reg
>>> + - reg-names
>>> + - ranges
>>> + - resets
>>> + - clocks
>>> + - phys
>>> + - phy-names
>>> + - reset-gpios
>>> + - num-lanes
>>> + - linux,pci-domain
>>> + - interrupts
>>> + - interrupt-map
>>> + - interrupt-map-mask
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> + - |
>>> + pcie10:pcie@d0e00000 {
>>> + compatible = "intel,lgm-pcie";
>>> + device_type = "pci";
>>> + #address-cells = <3>;
>>> + #size-cells = <2>;
>>> + reg = <
>>> + 0xd0e00000 0x1000
>>> + 0xd2000000 0x800000
>>> + 0xd0a41000 0x1000
>>> + >;
>>> + reg-names = "dbi", "config", "app";
>>> + linux,pci-domain = <0>;
>>> + max-link-speed = <4>;
>>> + bus-range = <0x00 0x08>;
>>> + interrupt-parent = <&ioapic1>;
>>> + interrupts = <67 1>;
>>> + #interrupt-cells = <1>;
>>> + interrupt-map-mask = <0 0 0 0x7>;
>>> + interrupt-map = <0 0 0 1 &ioapic1 27 1>,
>>> + <0 0 0 2 &ioapic1 28 1>,
>>> + <0 0 0 3 &ioapic1 29 1>,
>>> + <0 0 0 4 &ioapic1 30 1>;
>>> + ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
>>> + resets = <&rcu0 0x50 0>;
>>> + clocks = <&cgu0 LGM_GCLK_PCIE10>;
>>> + phys = <&cb0phy0>;
>>> + phy-names = "pciephy";
>>> + status = "okay";
>>> + reset-assert-ms = <500>;
>>> + reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>>> + num-lanes = <2>;
>>> + };
>>> -- 2.11.0
>>>
