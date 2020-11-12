Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7572AFE8F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 06:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgKLFjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 00:39:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32838 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLFZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 00:25:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC5PNjX043588;
        Wed, 11 Nov 2020 23:25:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605158723;
        bh=8h0Eaw5ISlxz1or35jD3guodViMLx1TX2NvCzewzZUk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qfe8moNLRxwm38idlzoRFrysOAQ4PIhBPN1ZV0FugsLJwuSHILkZjnIaV3NO39knH
         uCwgi9vMDVQqmvzmDfN2p3DElZ+o+fyJ/zLMpHaBJy7iZe87AK/q4kbrIrC2o5wQlM
         25lk5n81XdrWyRG3JKJazQexHtyzetKbqo4KoSuQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC5PNVo031826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 23:25:23 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 23:25:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 23:25:23 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC5PIDm029306;
        Wed, 11 Nov 2020 23:25:19 -0600
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: ti,j721e-system-controller.yaml:
 Document "syscon"
To:     Rob Herring <robh@kernel.org>
CC:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201109170409.4498-1-kishon@ti.com>
 <20201109170409.4498-2-kishon@ti.com> <20201111212857.GA2059063@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f6d1b886-5c78-842c-c33c-16b5b9325130@ti.com>
Date:   Thu, 12 Nov 2020 10:55:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111212857.GA2059063@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 12/11/20 2:58 am, Rob Herring wrote:
> On Mon, Nov 09, 2020 at 10:34:03PM +0530, Kishon Vijay Abraham I wrote:
>> Add binding documentation for "syscon" which should be a subnode of
>> the system controller (scm-conf).
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../mfd/ti,j721e-system-controller.yaml       | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> index 19fcf59fd2fe..0b115b707ab2 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> @@ -50,6 +50,38 @@ patternProperties:
>>        specified in
>>        Documentation/devicetree/bindings/mux/reg-mux.txt
>>  
>> +  "^syscon@[0-9a-f]+$":
>> +    type: object
>> +    description: |
> 
> Don't need '|' if there's no formatting.

Okay, will fix this.
> 
>> +      This is the system controller configuration required to configure PCIe
>> +      mode, lane width and speed.
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - ti,j721e-system-controller
>> +          - const: syscon
>> +          - const: simple-mfd
> 
> Humm, then what are this node's sub-nodes? And the same compatible as 
> the parent?
> 

This node doesn't have sub-nodes.

So one is the parent syscon node which has the entire system control
region and then sub-nodes for each of the modules. In this case the PCIe
in system control has only one 4 byte register that has to be configured.

Both the parent node and sub-node are syscon, so given the same
compatible for both.
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 1
>> +
>> +      ranges: true
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +      - ranges
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -72,5 +104,13 @@ examples:
>>              compatible = "mmio-mux";
>>              reg = <0x00004080 0x50>;
>>          };
>> +
>> +        pcie1_ctrl: syscon@4074 {
>> +            compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +            reg = <0x00004074 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges = <0x4074 0x4074 0x4>;
> 
> Must be packing a bunch of functions into 4 byte region!

For the PCIe case, it only has a 4 byte register to be configured. The
other option would be to get phandle to the parent syscon node and then
hard-code the offset in the driver.

Thank You,
Kishon
