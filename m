Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC102C5443
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbgKZMxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 07:53:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45496 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbgKZMxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 07:53:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AQCrKGM023622;
        Thu, 26 Nov 2020 06:53:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606395200;
        bh=8/i0PLwLC3PRuf2Girkk7ibqMIDhWokbjMZAt9wBkBQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=HqpYXplKRSKhcYglOcByMX66sSMECwWSazz3TavTY8gVsDOzIO7NLcucUzMomuFA1
         pg8IN7CUEqvbN7LnN5lGcFiXSNy8X0aHbrSRCHG2E9hplmoRk6+yRLcSAZ+iEIfpLO
         3ZT1Wg+8+zVx6cMjTqw1UCv61J34/c0bee8KYxrU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AQCrK0e011046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 06:53:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 26
 Nov 2020 06:53:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 26 Nov 2020 06:53:20 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AQCrG9p031373;
        Thu, 26 Nov 2020 06:53:16 -0600
Subject: Re: [PATCH 1/3] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl"
 to take argument
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201116173141.31873-1-kishon@ti.com>
 <20201116173141.31873-2-kishon@ti.com> <20201118211139.GA1815279@bogus>
 <1e9b0b56-a42d-bea0-704b-6209532b1abe@ti.com>
Message-ID: <1ed82ab5-6171-108d-9b92-a18389044174@ti.com>
Date:   Thu, 26 Nov 2020 18:23:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e9b0b56-a42d-bea0-704b-6209532b1abe@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 20/11/20 10:39 am, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 19/11/20 2:41 am, Rob Herring wrote:
>> On Mon, Nov 16, 2020 at 11:01:39PM +0530, Kishon Vijay Abraham I wrote:
>>> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
>>> argument. The argument is the register offset within "syscon" used to
>>> configure PCIe controller.
>>>
>>> Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>>
>> Link: Link: ?
>>
>> AIUI, 'Link' is supposed to be a link to this patch. I guess more than 1 
>> Link would be okay though.
> 
> Two Links was a typo, will fix it in the next revision. Nishanth as well
> was asking about using "Link:" tag for a mailing list discussion.
> 
> I started using it after Lorenzo had asked me to use Link tag for
> mailing list discussion here sometime back.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20171219083627.7904-1-kishon@ti.com/#21350261
> 
>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
>>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
>>>  2 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> index 3ae3e1a2d4b0..e9685c0bdc3e 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> @@ -29,9 +29,13 @@ properties:
>>>        - const: mem
>>>  
>>>    ti,syscon-pcie-ctrl:
>>> -    description: Phandle to the SYSCON entry required for configuring PCIe mode
>>> -                 and link speed.
>>> -    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    allOf:
>>
>> You no longer need allOf here.
> 
> hmm, don't we need it for specifying phandle with fixed cells? FWIW, I
> was referring
> 
> https://github.com/devicetree-org/dt-schema/blob/master/test/schemas/good-example.yaml#L187

Can you clarify this please?

Thank You,
Kishon
