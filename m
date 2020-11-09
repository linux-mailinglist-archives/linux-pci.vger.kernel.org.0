Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A32ABE6E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 15:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgKIORY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 09:17:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIORX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 09:17:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9EHC3K040249;
        Mon, 9 Nov 2020 08:17:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604931432;
        bh=Wp7QEYjwDcoEzB1kc04C4YfUw/KaMcNtD5IHNJ49+2I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w5IOp6b+6S2S8m33TlPJPrQZ/ldEjELgm9GAyYEsKY6rX1tC8tzR5myo/LSFJITxf
         IvWCmEs1S8FCkLaVXFUe+ULRm0WEn5NGzRJSoID4/eiqDZoo2Uuf/bnWzgB5nUdAxs
         DxJzI3NX66usNzWSEoBH7zw+IC3qdx4azVeSF/+c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9EHCMo025563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 08:17:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 08:17:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 08:17:12 -0600
Received: from [10.250.213.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9EH2Ol125926;
        Mon, 9 Nov 2020 08:17:04 -0600
Subject: Re: [PATCH 1/8] dt-bindings: mfd: ti,j721e-system-controller.yaml:
 Document "pcie-ctrl"
To:     Rob Herring <robh@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-2-kishon@ti.com> <20201105165459.GB55814@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <07d327c6-54c7-23f9-b65e-bfd3455de47f@ti.com>
Date:   Mon, 9 Nov 2020 19:47:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105165459.GB55814@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 05/11/20 10:24 pm, Rob Herring wrote:
> On Mon, Nov 02, 2020 at 03:41:47PM +0530, Kishon Vijay Abraham I wrote:
>> Add binding documentation for "pcie-ctrl" which should be a subnode of
>> the system controller.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> index 19fcf59fd2fe..fd985794e419 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> @@ -50,6 +50,12 @@ patternProperties:
>>        specified in
>>        Documentation/devicetree/bindings/mux/reg-mux.txt
>>  
>> +  "^pcie-ctrl@[0-9a-f]+$":
> 
> Unit address, so it should have 'reg' too?
> 
> You don't need a node if there aren't any properties.

The subnodes are again a syscon node. I'll fix this up in the next revision.

Thank You,
Kishon
