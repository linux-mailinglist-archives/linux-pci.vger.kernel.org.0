Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DE13D902
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgAPL3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 06:29:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44942 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAPL3f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 06:29:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GBTLp4025258;
        Thu, 16 Jan 2020 05:29:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579174161;
        bh=HoTADZtgqSuVtIDvlRPiDukZa+j2J/mrL6Wj0SyC6jI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=xC9TEoestm/zX+cXsk+U5M1RVszaN7BgXWgTmSPvKSpo7BtHTndJk7VL/4D+xlgpd
         kb5PrdJaCuRZ/DHlnUaHNqePrEvTUmupxh74nB0MstnmXKgH0Jh7icksY4vEhSnbw7
         KMLBW1mjSIcZuHBsNe0kVVfLqQnJNqxDDoLQUHSY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GBTLbQ007664;
        Thu, 16 Jan 2020 05:29:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 05:29:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 05:29:21 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GBTGoa010158;
        Thu, 16 Jan 2020 05:29:19 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: PCI: cadence: Add PCIe RC/EP DT
 schema for Cadence PCIe
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200106102058.19183-1-kishon@ti.com>
 <20200106102058.19183-2-kishon@ti.com> <20200108034314.GA5412@bogus>
 <3e2bfa1b-ff9e-93a0-a6b9-7985e0a76bf0@ti.com>
Message-ID: <025cc5cd-87a5-da64-9edd-536f7f7dac67@ti.com>
Date:   Thu, 16 Jan 2020 17:01:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3e2bfa1b-ff9e-93a0-a6b9-7985e0a76bf0@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hi Rob,

On 08/01/20 11:05 AM, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 08/01/20 9:13 AM, Rob Herring wrote:
>> On Mon, Jan 06, 2020 at 03:50:45PM +0530, Kishon Vijay Abraham I wrote:
>>> Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
>>> PCIe core library. Platforms using Cadence PCIe core can include the
>>> schemas added here in the platform specific schemas.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 ++++++++++++
>>>  .../bindings/pci/cdns-pcie-host.yaml          | 30 +++++++++++++++++
>>>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 32 +++++++++++++++++++
>>>  3 files changed, 82 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
>>
>> Need to remove the old files.
>>
>> Note that I posted a conversion of Cadence host[1]. Yours goes further, 
>> but please compare and add anything mine has that yours doesn't.
>>
>> [1] https://lore.kernel.org/linux-pci/20191231193903.15929-2-robh@kernel.org/
> 
> Sure, I'll look at this.
> 
> Recently we converted Cadence driver to a library since the same Cadence
> core can be used by multiple vendors. Here I'm trying to add the
> bindings for Cadence core which can be included in the platform specific
> schema.
> 
> So the existing cdns,cdns-pcie-host.yaml which is a Cadence platform
> using Cadence core should include cdns-pcie-host.yaml.
> 
> "[PATCH v2 10/14] dt-bindings: PCI: Add host mode dt-bindings for TI's
> J721E SoC" in this series includes "cdns-pcie-host.yaml" for TI platform
> using Cadence core.
> 
> That's why in the schema added here you don't see the compatible since
> that will be added in platform specific schema.

Does this approach look fine to you?

Thanks
Kishon

>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>>> new file mode 100644
>>> index 000000000000..36aaae5931c3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>>> @@ -0,0 +1,20 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>>> +%YAML 1.2
>>> +--
>>> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: Cadence PCIe Endpoint
>>> +
>>> +maintainers:
>>> +  - Tom Joseph <tjoseph@cadence.com>
>>> +
>>> +allOf:
>>> +  - $ref: "cdns-pcie.yaml#"
>>> +
>>> +properties:
>>> +  max-functions:
>>> +    description: Maximum number of functions that can be configured (default 1)
>>> +    allOf:
>>> +      - $ref: /schemas/types.yaml#/definitions/uint8
>>> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>>> new file mode 100644
>>> index 000000000000..78261bc4f0c5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>>> @@ -0,0 +1,30 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-host.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: Cadence PCIe Host
>>> +
>>> +maintainers:
>>> +  - Tom Joseph <tjoseph@cadence.com>
>>> +
>>> +allOf:
>>> +  - $ref: "/schemas/pci/pci-bus.yaml#"
>>> +  - $ref: "cdns-pcie.yaml#"
>>> +
>>> +properties:
>>> +  vendor-id:
>>> +    description: The PCI vendor ID (16 bits, default is design dependent)
>>> +
>>> +  device-id:
>>> +    description: The PCI device ID (16 bits, default is design dependent)
>>
>> While these got defined here as 16-bits, these should be fixed to 32-bit 
>> because they are established properties for a long time.
>>
>>> +
>>> +  cdns,no-bar-match-nbits:
>>> +    description: Set into the no BAR match register to configure the number
>>> +      of least significant bits kept during inbound (PCIe -> AXI) address
>>> +      translations (default 32)
>>> +    allOf:
>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>
>> What about compatible?
>>
>>> +
>>> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..497d3dc2e6f2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
>>> @@ -0,0 +1,32 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/pci/cdns-pcie.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: Cadence PCIe Core
>>> +
>>> +maintainers:
>>> +  - Tom Joseph <tjoseph@cadence.com>
>>> +
>>> +properties:
>>> +  max-link-speed:
>>> +    minimum: 1
>>> +    maximum: 3
>>> +
>>> +  num-lanes:
>>> +    minimum: 1
>>> +    maximum: 2
>>
>> Needs a type.
>>
>> The Cadence IP can't support x4, x8, or x16?
> 
> I'll fix this. I assume these can be overwritten in platform specific
> schema files?
> 
> Thanks
> Kishon
> 
