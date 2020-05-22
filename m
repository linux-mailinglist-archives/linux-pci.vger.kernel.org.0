Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01B1DDF84
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEVFyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 01:54:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53008 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVFyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 01:54:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M5rquC068318;
        Fri, 22 May 2020 00:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590126832;
        bh=NshuB9n7qwMmk0C1n2A19PvAX8raMBe1CgqKMTbZRv8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AYQq070JKTsfBEbKIFPWTxHq9qYSEOhjzxZ3Uh0/ZFEQhzAlRCGREtpRYFpOuQD7C
         hz5I9YZjggvNCMFBCl+j4TeytsHzxqUrCpn1kYYnCFV8wUJADIu63T37pCnTrC7ZPc
         6jQYM955cFR1cjcIWEpdNo/l2HHSi0F0JHHkvZtI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M5rqub091641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 00:53:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 00:53:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 00:53:51 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M5rlfU114971;
        Fri, 22 May 2020 00:53:47 -0500
Subject: Re: [PATCH 01/19] dt-bindings: PCI: Endpoint: Add DT bindings for PCI
 EPF NTB Device
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20200514145927.17555-1-kishon@ti.com>
 <20200514145927.17555-2-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <73193475-5244-554d-df71-df600f70c0d9@ti.com>
Date:   Fri, 22 May 2020 11:23:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514145927.17555-2-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi RobH,

On 5/14/2020 8:29 PM, Kishon Vijay Abraham I wrote:
> Add device tree schema for PCI endpoint function bus to which
> endpoint function devices should be attached. Then add device tree
> schema for PCI endpoint function device to include bindings thats
> generic to all endpoint functions. Finally add device tree schema
> for PCI endpoint NTB function device by including the generic
> device tree schema for PCIe endpoint function.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/endpoint/pci-epf-bus.yaml    | 42 +++++++++++
>  .../bindings/pci/endpoint/pci-epf-device.yaml | 69 +++++++++++++++++++
>  .../bindings/pci/endpoint/pci-epf-ntb.yaml    | 68 ++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
> new file mode 100644
> index 000000000000..1c504f2e85e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCI Endpoint Function Bus
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  compatible:
> +    const: pci-epf-bus
> +
> +patternProperties:
> +  "^func@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      PCI Endpoint Function Bus node should have subnodes for each of
> +      the implemented endpoint function. It should follow the bindings
> +      specified for endpoint function in
> +      Documentation/devicetree/bindings/pci/endpoint/
> +
> +examples:
> +  - |
> +    epf_bus {
> +      compatible = "pci-epf-bus";
> +
> +      func@0 {
> +        compatible = "pci-epf-ntb";
> +        epcs = <&pcie0_ep>, <&pcie1_ep>;
> +        epc-names = "primary", "secondary";
> +        reg = <0>;

I'm not sure how to represent "reg" property properly for cases like this where
it represents ID and not a memory resource. I seem to get warning for
"reg_format" even after adding address-cells and size-cells property in
epf_bus. Can you give some hints here please?

> +        epf,vendor-id = /bits/ 16 <0x104c>;

I want to make vendor-id and device-id as 16 bits from the beginning at-least
for PCIe endpoint. So I'm prefixing these properties with "epf,". However I get
this "do not match any of the regexes:". Can we add "epf" as a standard prefix?

Thanks
Kishon
> +        epf,device-id = /bits/ 16 <0xb00d>;
> +        num-mws = <4>;
> +        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
> new file mode 100644
> index 000000000000..cee72864c8ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-device.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCI Endpoint Function Device
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  compatible:
> +    const: pci-epf-bus
> +
> +properties:
> +  $nodename:
> +    pattern: "^func@"
> +
> +  epcs:
> +    description:
> +      Phandle to the endpoint controller device. Should have "2" entries for
> +      NTB endpoint function and "1" entry for others.
> +    minItems: 1
> +    maxItems: 2
> +
> +  epc-names:
> +    description:
> +      Must contain an entry for each entry in "epcs" when "epcs" have more than
> +      one entry.
> +
> +  reg:
> +    maxItems: 0
> +    description: Must contain the index number of the function.
> +
> +  epf,vendor-id:
> +    description:
> +      The PCI vendor ID
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint16
> +
> +  epf,device-id:
> +    description:
> +      The PCI device ID
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint16
> +
> +  epf,baseclass-code:
> +    description: Code to classify the type of operation the function performs
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +
> +  epf,subclass-code:
> +    description:
> +      Specifies a base class sub-class, which identifies more specifically the
> +      operation of the Function
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +
> +  epf,subsys-vendor-id:
> +    description: Code to identify vendor of the add-in card or subsystem
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint16
> +
> +  epf,subsys-id:
> +    description: Code to specify an id that is specific to a vendor
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint16
> diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
> new file mode 100644
> index 000000000000..92c2e522b9e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-ntb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCI Endpoint NTB Function Device
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +allOf:
> +  - $ref: "pci-epf-device.yaml#"
> +
> +properties:
> +  compatible:
> +    const: pci-epf-ntb
> +
> +  epcs:
> +    minItems: 2
> +    maxItems: 2
> +
> +  epc-names:
> +    items:
> +      - const: primary
> +      - const: secondary
> +
> +  num-mws:
> +    description:
> +      Specify the number of memory windows
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    maximum: 4
> +
> +  mws-size:
> +    description:
> +      List of 'num-mws' entries containing size of each memory window.
> +    minItems: 1
> +    maxItems: 4
> +
> +required:
> +  - compatible
> +  - epcs
> +  - epc-names
> +  - epf,vendor-id
> +  - epf,device-id
> +  - num-mws
> +  - mws-size
> +
> +examples:
> +  - |
> +    epf_bus {
> +      compatible = "pci-epf-bus";
> +
> +      func@0 {
> +        compatible = "pci-epf-ntb";
> +        reg = <0>;
> +        epcs = <&pcie0_ep>, <&pcie1_ep>;
> +        epc-names = "primary", "secondary";
> +        epf,vendor-id = /bits/ 16 <0x104c>;
> +        epf,device-id = /bits/ 16 <0xb00d>;
> +        num-mws = <4>;
> +        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
> +      };
> +    };
> +...
> 
