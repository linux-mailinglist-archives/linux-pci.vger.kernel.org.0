Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F22BA1B0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 06:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgKTFKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 00:10:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKTFKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 00:10:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AK59kZl029627;
        Thu, 19 Nov 2020 23:09:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605848986;
        bh=X/EWUuQhSX3KVvXb+jMyhnoo1Rzdq4wVldJ2FGPNEBs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=stSIJwAhUprFRf8ffvPyY7QS3zdWchmAmNDzZMLnkdSF4BkAN1FL9HC0WlL20SEwv
         5Ik/aKnofJYANe86G9zrDoC73gXIv+cm4AEmgEuMb5D2CW5ZClSAwtE84OtOIJJCFD
         owSNshkvSyIZXDIAJGBlxOKpDYmvQV6BpkRg6QC0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AK59ki8123135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 23:09:46 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 23:09:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 23:09:45 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AK59SOx116902;
        Thu, 19 Nov 2020 23:09:29 -0600
Subject: Re: [PATCH 1/3] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl"
 to take argument
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1e9b0b56-a42d-bea0-704b-6209532b1abe@ti.com>
Date:   Fri, 20 Nov 2020 10:39:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118211139.GA1815279@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 19/11/20 2:41 am, Rob Herring wrote:
> On Mon, Nov 16, 2020 at 11:01:39PM +0530, Kishon Vijay Abraham I wrote:
>> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
>> argument. The argument is the register offset within "syscon" used to
>> configure PCIe controller.
>>
>> Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> 
> Link: Link: ?
> 
> AIUI, 'Link' is supposed to be a link to this patch. I guess more than 1 
> Link would be okay though.

Two Links was a typo, will fix it in the next revision. Nishanth as well
was asking about using "Link:" tag for a mailing list discussion.

I started using it after Lorenzo had asked me to use Link tag for
mailing list discussion here sometime back.

https://patchwork.kernel.org/project/linux-pci/patch/20171219083627.7904-1-kishon@ti.com/#21350261

> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
>>  2 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> index 3ae3e1a2d4b0..e9685c0bdc3e 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> @@ -29,9 +29,13 @@ properties:
>>        - const: mem
>>  
>>    ti,syscon-pcie-ctrl:
>> -    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> -                 and link speed.
>> -    $ref: /schemas/types.yaml#/definitions/phandle
>> +    allOf:
> 
> You no longer need allOf here.

hmm, don't we need it for specifying phandle with fixed cells? FWIW, I
was referring

https://github.com/devicetree-org/dt-schema/blob/master/test/schemas/good-example.yaml#L187

Thank You,
Kishon
