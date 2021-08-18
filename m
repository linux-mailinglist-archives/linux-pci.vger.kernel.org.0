Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC83F057A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhHRN7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 09:59:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbhHRN7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 09:59:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IDwtkx030165;
        Wed, 18 Aug 2021 08:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629295135;
        bh=JcQTkmL2npVaq5oSIjOTaMiBBRi3bnk0fB3Mygg/7Hc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KXcMNJHH9Xl3hUN5856K9/sSv+bOt5Wzy5TN13m9/fgQLiL5XylwKuzIsyZuEVoFW
         WR5Woz9ygXDXAQ7l/s8sDEXrEmzRMlg+cw8i033cP5YdkTmG2yyYfJmJbKWUuamQwL
         s0fl7vXr36dEv5+L62pDr5wQj/SJ3jQNgUpL7BZU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IDwt2D121306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 08:58:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 08:58:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 08:58:54 -0500
Received: from [10.250.232.133] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IDwoP7043374;
        Wed, 18 Aug 2021 08:58:51 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to
 specify legacy interrupts
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d0f83129-4c9a-d9ff-380a-cab37a86e29e@ti.com>
Date:   Wed, 18 Aug 2021 19:28:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRapMFNb63MSPJ1E@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 13/08/21 10:47 pm, Rob Herring wrote:
> On Wed, Aug 04, 2021 at 06:59:10PM +0530, Kishon Vijay Abraham I wrote:
>> Add bindings to specify interrupt controller for legacy interrupts.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-host.yaml           | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> index cc900202df29..f461d7b4c0cc 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -74,6 +74,11 @@ properties:
>>  
>>    msi-map: true
>>  
>> +patternProperties:
>> +  "interrupt-controller":
> 
> Not a pattern unless you meant for foo-interrupt-controller-bar to be 
> valid.
> 
> Anything is allowed in the node?

It's same as whatever is defined in schemas/interrupt-controller.yaml,
just that it should be a subnode of pcie@. Should I add whatever is
present in schemas/interrupt-controller.yaml here?

Thanks
Kishon
> 
>> +    type: object
>> +    description: interrupt controller to handle legacy interrupts.
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -97,6 +102,8 @@ unevaluatedProperties: false
>>  
>>  examples:
>>    - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>      #include <dt-bindings/gpio/gpio.h>
>>  
>> @@ -131,5 +138,13 @@ examples:
>>              ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
>>                       <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
>>              dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>> +
>> +
>> +            pcie0_intc: interrupt-controller {
>> +                    interrupt-controller;
>> +                    #interrupt-cells = <1>;
>> +                    interrupt-parent = <&gic500>;
>> +                    interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
>> +            };
>>          };
>>      };
>> -- 
>> 2.17.1
>>
>>
