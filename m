Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E2198A8F
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 05:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCaDiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 23:38:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50900 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgCaDiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 23:38:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02V3cGGG073613;
        Mon, 30 Mar 2020 22:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585625896;
        bh=qXhJwnXiI11Btcsok36Z3zck48iG5vt+ZvZfiwL9bnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZclICBXyWUj+xxoVQ7hiTAi4DNUlHr3o7Yf3ESENRUhjEFVTCByQzh5OvjwL7Cigx
         VuWzJVVXlLm0U1lHRA5DkYK6YI3d1kY+AB4/a4VlI4n9OqJEGn5qLK7A2LkwRH5+qC
         qmkA2F+DFCUqdO1dnN3U7vsfYw88vpGO5JRPTAEg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02V3cG0M114636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Mar 2020 22:38:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Mar 2020 22:38:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Mar 2020 22:38:15 -0500
Received: from [10.250.133.232] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02V3cClL095960;
        Mon, 30 Mar 2020 22:38:13 -0500
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cadence: Deprecate inbound/outbound
 specific bindings
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200327104727.4708-1-kishon@ti.com>
 <20200327104727.4708-2-kishon@ti.com> <20200330160142.GA6259@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2a18a228-9248-24a8-c9cd-a041c62aa381@ti.com>
Date:   Tue, 31 Mar 2020 09:08:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330160142.GA6259@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 3/30/2020 9:31 PM, Rob Herring wrote:
> On Fri, Mar 27, 2020 at 04:17:25PM +0530, Kishon Vijay Abraham I wrote:
>> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
>> host mode as both these could be derived from "ranges" and "dma-ranges"
>> property. "cdns,max-outbound-regions" property would still be required
>> for EP mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
>>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
>>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
>>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
>>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
>>  5 files changed, 37 insertions(+), 11 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> index 2996f8d4777c..50ce5d79d2c7 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> @@ -10,7 +10,7 @@ maintainers:
>>    - Tom Joseph <tjoseph@cadence.com>
>>  
>>  allOf:
>> -  - $ref: "cdns-pcie.yaml#"
>> +  - $ref: "cdns-pcie-ep.yaml#"
>>    - $ref: "pci-ep.yaml#"
>>  
>>  properties:
>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> index cabbe46ff578..84a8f095d031 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> @@ -45,8 +45,6 @@ examples:
>>              #size-cells = <2>;
>>              bus-range = <0x0 0xff>;
>>              linux,pci-domain = <0>;
>> -            cdns,max-outbound-regions = <16>;
>> -            cdns,no-bar-match-nbits = <32>;
>>              vendor-id = <0x17cd>;
>>              device-id = <0x0200>;
>>  
>> @@ -57,6 +55,7 @@ examples:
>>  
>>              ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
>>                       <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
>> +            dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
>>  
>>              #interrupt-cells = <0x1>;
>>  
>> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>> new file mode 100644
>> index 000000000000..6150a7a7bdbf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>> @@ -0,0 +1,25 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Cadence PCIe Device
>> +
>> +maintainers:
>> +  - Tom Joseph <tjoseph@cadence.com>
>> +
>> +allOf:
>> +  - $ref: "cdns-pcie.yaml#"
>> +
>> +properties:
>> +  cdns,max-outbound-regions:
>> +    description: maximum number of outbound regions
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 32
>> +    default: 32
> 
> I have a feeling that as the PCI endpoint binding evolves this won't be 
> necessary. I can see a common need to define the number of BARs for an 
> endpoint and then this will again just be error checking.

For every buffer given by the host, we have to create a new outbound
translation. If there are no outbound regions, we have to report the error to
the endpoint function driver. At-least for reporting the error, we'd need to
have this binding no?
> 
> What's the result if you write to a non-existent region in register 
> CDNS_PCIE_AT_OB_REGION_PCI_ADDR0/1? If the register is non-existent and 
> doesn't abort, you could detect this instead.

I'm not sure if we should ever try to write to a non-existent register though
the behavior could be different in different platforms. IMHO maximum number of
outbound regions is a HW property and is best described in device tree.

Thanks
Kishon
