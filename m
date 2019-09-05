Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FFA984F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 04:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIECXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 22:23:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:12819 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIECXZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 22:23:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 19:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,469,1559545200"; 
   d="scan'208";a="173781825"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2019 19:23:24 -0700
Received: from [10.226.39.8] (leichuan-mobl.gar.corp.intel.com [10.226.39.8])
        by linux.intel.com (Postfix) with ESMTP id DAFA658046E;
        Wed,  4 Sep 2019 19:23:20 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <54ec6a30-69d8-a4af-95fa-2f457d605142@linux.intel.com>
Date:   Thu, 5 Sep 2019 10:23:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dilip,

On 9/4/2019 6:10 PM, Dilip Kota wrote:
> The Intel PCIe RC controller is Synopsys Designware
> based PCIe core. Add YAML schemas for PCIe in RC mode
> present in Intel Universal Gateway soc.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> changes on v3:
> 	Add the appropriate License-Identifier
> 	Rename intel,rst-interval to 'reset-assert-us'
rst->interval to reset-assert-ms(should be typo error)
> 	Add additionalProperties: false
> 	Rename phy-names to 'pciephy'
> 	Remove the dtsi node split of SoC and board in the example
> 	Add #interrupt-cells = <1>; or else interrupt parsing will fail
> 	Name yaml file with compatible name
>
>   .../devicetree/bindings/pci/intel,lgm-pcie.yaml    | 137 +++++++++++++++++++++
>   1 file changed, 137 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
> new file mode 100644
> index 000000000000..5e5cc7fd66cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/intel-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel AXI bus based PCI express root complex
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pcie
> +
> +  device_type:
> +    const: pci
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Controller control and status registers.
> +      - description: PCIe configuration registers.
> +      - description: Controller application registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: app
> +
> +  ranges:
> +    description: Ranges for the PCI memory and I/O regions.
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    description: PCIe registers interface clock.
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pciephy
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  num-lanes:
> +    description: Number of lanes to use for this port.
> +
> +  linux,pci-domain:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: PCI domain ID.
> +
> +  interrupts:
> +    description: PCIe core integrated miscellaneous interrupt.
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  max-link-speed:
> +    description: Specify PCI Gen for link capability.
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
> +
> +  reset-assert-ms:
> +    description: |
> +      Device reset interval in ms.
> +      Some devices need an interval upto 500ms. By default it is 100ms.
> +
> +required:
> +  - compatible
> +  - device_type
> +  - reg
> +  - reg-names
> +  - ranges
> +  - resets
> +  - clocks
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +  - num-lanes
> +  - linux,pci-domain
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie10:pcie@d0e00000 {
> +      compatible = "intel,lgm-pcie";
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      reg = <
> +            0xd0e00000 0x1000
> +            0xd2000000 0x800000
> +            0xd0a41000 0x1000
> +            >;
> +      reg-names = "dbi", "config", "app";
> +      linux,pci-domain = <0>;
> +      max-link-speed = <4>;
> +      bus-range = <0x00 0x08>;
> +      interrupt-parent = <&ioapic1>;
> +      interrupts = <67 1>;
> +      #interrupt-cells = <1>;
> +      interrupt-map-mask = <0 0 0 0x7>;
> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
> +                      <0 0 0 2 &ioapic1 28 1>,
> +                      <0 0 0 3 &ioapic1 29 1>,
> +                      <0 0 0 4 &ioapic1 30 1>;
> +      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
> +      resets = <&rcu0 0x50 0>;
> +      clocks = <&cgu0 LGM_GCLK_PCIE10>;
> +      phys = <&cb0phy0>;
> +      phy-names = "pciephy";
> +      status = "okay";
> +      reset-assert-ms = <500>;
> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +      num-lanes = <2>;
> +    };
