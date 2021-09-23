Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D625415794
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 06:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhIWEfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 00:35:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59286 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhIWEfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 00:35:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18N4Xp8h080818;
        Wed, 22 Sep 2021 23:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632371631;
        bh=PEu1m0OtQZTIGJy7M0ri4vULRx7aaNibAq8x1p3ykys=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=xU0q1WSYv4UZuKeHK3get+fip2OY+Kq9GofTMfKAmFEpSMBoAOVKphjWSglrhb45i
         P33cbunfqZzZdsBL/zXtbzq9JdwIJtWxZAhxUQqnDWhH9hMIhWqoztEiUD6uByFPLA
         rt6QRV9i/PT5oVdsafjEyR4xXOUfdffqImz3cdDo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18N4Xpa5052074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Sep 2021 23:33:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Sep 2021 23:33:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Sep 2021 23:33:50 -0500
Received: from [10.250.234.35] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18N4XkHc080721;
        Wed, 22 Sep 2021 23:33:47 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to
 specify legacy interrupts
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
 <20210804132912.30685-2-kishon@ti.com> <YRapMFNb63MSPJ1E@robh.at.kernel.org>
 <d0f83129-4c9a-d9ff-380a-cab37a86e29e@ti.com>
Message-ID: <220bbd3c-304a-ba6a-d20e-634f23f4eed2@ti.com>
Date:   Thu, 23 Sep 2021 10:03:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d0f83129-4c9a-d9ff-380a-cab37a86e29e@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 18/08/21 7:28 pm, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 13/08/21 10:47 pm, Rob Herring wrote:
>> On Wed, Aug 04, 2021 at 06:59:10PM +0530, Kishon Vijay Abraham I wrote:
>>> Add bindings to specify interrupt controller for legacy interrupts.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../bindings/pci/ti,j721e-pci-host.yaml           | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> index cc900202df29..f461d7b4c0cc 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> @@ -74,6 +74,11 @@ properties:
>>>  
>>>    msi-map: true
>>>  
>>> +patternProperties:
>>> +  "interrupt-controller":
>>
>> Not a pattern unless you meant for foo-interrupt-controller-bar to be 
>> valid.
>>
>> Anything is allowed in the node?
> 
> It's same as whatever is defined in schemas/interrupt-controller.yaml,
> just that it should be a subnode of pcie@. Should I add whatever is
> present in schemas/interrupt-controller.yaml here?

Can you suggest how to include this?

Thanks,
Kishon

> 
> Thanks
> Kishon
>>
>>> +    type: object
>>> +    description: interrupt controller to handle legacy interrupts.
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -97,6 +102,8 @@ unevaluatedProperties: false
>>>  
>>>  examples:
>>>    - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>>      #include <dt-bindings/gpio/gpio.h>
>>>  
>>> @@ -131,5 +138,13 @@ examples:
>>>              ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
>>>                       <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
>>>              dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>> +
>>> +
>>> +            pcie0_intc: interrupt-controller {
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells = <1>;
>>> +                    interrupt-parent = <&gic500>;
>>> +                    interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
>>> +            };
>>>          };
>>>      };
>>> -- 
>>> 2.17.1
>>>
>>>
