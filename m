Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FEE16B89F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 05:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgBYE4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 23:56:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55192 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYE4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 23:56:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P4u4rJ005344;
        Mon, 24 Feb 2020 22:56:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582606564;
        bh=Hi3alq/PW0I95g8l0i49IRWre9otN2P6q1NyxVUBRIM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lRKk+qOVCrAFp2ZUgV9fdGqiLAneXtVAgGjDSU8tVxnLiNJsv2AiCuO39r+xqwvW/
         B0gqdYxfL+sN0NQywS0W8wwx/ryYigAvqzUufIHOYBvwpSLY0S6Ny8EQKa3xkh7ODA
         hYLtFFlCXV/7/R/+EPy4pOcuncOrWCvhNtFKLubs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P4u4X1051429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 22:56:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 22:56:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 22:56:03 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P4u01w018889;
        Mon, 24 Feb 2020 22:56:01 -0600
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200217111519.29163-1-kishon@ti.com>
 <20200217111519.29163-3-kishon@ti.com> <20200219203205.GA14068@bogus>
 <2b927c66-d640-fb11-878a-c69a459a28f8@ti.com>
 <CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9be3291f-b0a8-a30f-57ad-f38bc7a8197c@ti.com>
Date:   Tue, 25 Feb 2020 10:29:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

On 24/02/20 8:56 pm, Rob Herring wrote:
> On Mon, Feb 24, 2020 at 4:14 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 20/02/20 2:02 am, Rob Herring wrote:
>>> On Mon, Feb 17, 2020 at 04:45:19PM +0530, Kishon Vijay Abraham I wrote:
>>>> Include Cadence core DT schema and define the Cadence platform DT schema
>>>> for both Host and Endpoint mode. Note: The Cadence core DT schema could
>>>> be included for other platforms using Cadence PCIe core.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
>>>>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
>>>>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
>>>>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
>>>>  MAINTAINERS                                   |  2 +-
>>>>  5 files changed, 125 insertions(+), 94 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>>>>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>
>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>> new file mode 100644
>>>> index 000000000000..2f605297f862
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>> @@ -0,0 +1,76 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-host.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Cadence PCIe host controller
>>>> +
>>>> +maintainers:
>>>> +  - Tom Joseph <tjoseph@cadence.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>>> +  - $ref: "cdns-pcie-host.yaml#"
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: cdns,cdns-pcie-host
>>>> +
>>>> +  reg:
>>>> +    maxItems: 3
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: reg
>>>> +      - const: cfg
>>>> +      - const: mem
>>>> +
>>>> +  msi-parent: true
>>>> +
>>>> +required:
>>>> +  - reg
>>>> +  - reg-names
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    bus {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        pcie@fb000000 {
>>>> +            compatible = "cdns,cdns-pcie-host";
>>>> +            device_type = "pci";
>>>> +            #address-cells = <3>;
>>>> +            #size-cells = <2>;
>>>> +            bus-range = <0x0 0xff>;
>>>> +            linux,pci-domain = <0>;
>>>> +            cdns,max-outbound-regions = <16>;
>>>> +            cdns,no-bar-match-nbits = <32>;
>>>
>>>> +            vendor-id = /bits/ 16 <0x17cd>;
>>>> +            device-id = /bits/ 16 <0x0200>;
>>>
>>> Please make these 32-bit as that is what the spec says.
>>
>> Can you clarify this is mentioned in which spec? PCI spec has both of
>> these 16 bits and I checked the PCI binding doc but couldn't spot the
>> size of these fields.
>>
>> [1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> 
> Section 4.1.2.1. The key point is the type is 'encode-int' which means
> 32-bit. Keep in mind, that 16-bits was not a defined type when this
> spec was written. We added that for FDT.
> 
> Also, look at other instances of reading 'vendor-id' in the kernel.

Thanks for clarifying.

Regards
Kishon
