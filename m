Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED697685
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHUJ42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 05:56:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:35050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfHUJ42 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 05:56:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 02:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="169367262"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 02:56:27 -0700
Received: from [10.226.38.255] (ekotax-mobl.gar.corp.intel.com [10.226.38.255])
        by linux.intel.com (Postfix) with ESMTP id 43B36580144;
        Wed, 21 Aug 2019 02:56:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
 <5e6ee1245ee53a7726103a8de7c11a37ad99fbd6.1566208109.git.eswara.kota@linux.intel.com>
 <CAL_Jsq+pvKHtw-ARRbNW-xReQ2MVNan8z3tfJbx4taGDCvEr5g@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <cf47e8e8-9fbe-dfcb-60f3-76c48728328f@linux.intel.com>
Date:   Wed, 21 Aug 2019 17:56:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+pvKHtw-ARRbNW-xReQ2MVNan8z3tfJbx4taGDCvEr5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/20/2019 9:42 PM, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 4:40 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>> The Intel PCIe RC controller is Synopsys Designware
>> based PCIe core. Add YAML schemas for PCIe in RC mode
>> present in Intel Universal Gateway soc.
> Run 'make dt_binding_check' and fix all the warnings.
Sure, will run and fix them. Sorry for missing it.
>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   .../devicetree/bindings/pci/intel-pcie.yaml        | 133 +++++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/intel-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
>> new file mode 100644
>> index 000000000000..80caaaba5e2c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: GPL-2.0
> (GPL-2.0-only OR BSD-2-Clause) is preferred for new bindings.
Sure, will update it.
>
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
>> +    const: phy
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  num-lanes:
>> +    description: Number of lanes to use for this port.
>> +
>> +  linux,pci-domain:
>> +    description: PCI domain ID.
>> +
>> +  interrupts:
>> +    description: PCIe core integrated miscellaneous interrupt.
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
>> +  intel,rst-interval:
> Use 'reset-assert-us'

Sure.
I am thinking of 'reset-assert-ms' to remain in Milli seconds.
Please let me know your view.

>
>> +    description: |
>> +      Device reset interval in ms. Some devices need an interval upto 500ms.
>> +      By default it is 100ms.
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
>> +      interrupt-map-mask = <0 0 0 0x7>;
>> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
>> +                      <0 0 0 2 &ioapic1 28 1>,
>> +                      <0 0 0 3 &ioapic1 29 1>,
>> +                      <0 0 0 4 &ioapic1 30 1>;
>> +      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
>> +      resets = <&rcu0 0x50 0>;
>> +      clocks = <&cgu0 LGM_GCLK_PCIE10>;
>> +      phys = <&cb0phy0>;
>> +      phy-names = "phy";
>> +    };
>> +
>> +    &pcie10 {
> Don't show this soc/board split in examples. Just combine to one node.

Sure, will combine.

Thanks for the review comments.

Regards,
Dilip

>
>> +      status = "okay";
>> +      intel,rst-interval = <100>;
>> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
>> +      num-lanes = <2>;
>> +    };
>> --
>> 2.11.0
>>
