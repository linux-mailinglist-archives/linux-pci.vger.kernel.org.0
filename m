Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7095C3E3F16
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 06:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhHIEjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 00:39:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32782 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 00:39:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1794cvPi053042;
        Sun, 8 Aug 2021 23:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628483937;
        bh=hMEiItd4QIo4kUch+Bv4wxFa1pGf9jYfLXOUQKMNT9c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ya6hTTCh6Z7M+W/aQX7PqEmbNqGEx6NYfAWn1NIiZsMUiLRt4foKZqYuHG59j5RDx
         j2m8vmxGanp/w6jEORH1KCAfIfTzcuiXDuEpJhxcbycnFWxJoC9Z9gl+RK7nrCr9DM
         rXiMX/KLjYevkasV/uODWhOkrNN1TIkSRf9F43NQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1794cvLJ067738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Aug 2021 23:38:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 23:38:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sun, 8 Aug 2021 23:38:57 -0500
Received: from [10.250.235.70] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1794crVI008485;
        Sun, 8 Aug 2021 23:38:53 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to
 specify legacy interrupts
To:     Marc Zyngier <maz@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
 <20210804132912.30685-2-kishon@ti.com> <87im0lw8qy.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <14717d53-1727-509c-9a62-02c1e8c5736e@ti.com>
Date:   Mon, 9 Aug 2021 10:08:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87im0lw8qy.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 04/08/21 8:35 pm, Marc Zyngier wrote:
> On Wed, 04 Aug 2021 14:29:10 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
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
> 
> Are you sure about the edge signalling? How is the interrupt
> retriggered when the input is still high, which could well be the case
> for shared INTx?

There is a EOI register which is used for re-triggering the interrupt.
That functionality is broken in J721E but is fixed in J7200 (the
following two patches in the series deals with that).

Thanks,
Kishon
