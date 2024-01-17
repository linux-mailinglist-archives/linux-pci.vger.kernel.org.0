Return-Path: <linux-pci+bounces-2266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7E8303E5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67071F27C08
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4101514AA8;
	Wed, 17 Jan 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UoCTlZAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BE1428D;
	Wed, 17 Jan 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488500; cv=none; b=mPTiNvp0qJweJMbP2XsNc6srFfdV1Gs0VoB6cOg6qQr4vXoX5I5AIlvJZm7AGfMhytWhUcEO4o7MRP0v9CzNJBQtWXlBilZ/YJtS6jJrtXoCWOws+uOgPGrinL0Wbg/twwbm7GACiV099IsAuDe6C+6SGTiywV6gwUhOKDLCnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488500; c=relaxed/simple;
	bh=IRtIPKrPrnPgK7udAFy1ECVgEAhcxlGb0ZzxkDNZeqk=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=EBBHC6bKh3D+kK0X58mZ4+i3lDtBzCbZDqtFD1v2RjYi/g0aVzjORF7jRB1OOcqogM+h+IyhqzoIHVgsj3bhq/GyhmKlcj5YeDMDkNtaTfNJuGPq50hKXstdQ+3Z3RVllTpS4pieq4r3ei/N5Nmudm3MF2hsR4QZ/NMf0Djbdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UoCTlZAU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAm5aI094593;
	Wed, 17 Jan 2024 04:48:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705488485;
	bh=a9repfQha27ojMZqc1rUcTlZNTIRH7v52A6zYo+wIZE=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=UoCTlZAUXcHhs+tNI1IRq810MUigORiqpXNxg9UbCNzMh4iNTLjr6h9kRgwTDB8uV
	 DXt+4c8ADDZ8K72aNV0O5Ea+TUsUIJSI5KPAyhztByS/2sa6CCVB1jCn1M6Am0PURu
	 2kqchHsgc2I+MtWSqNMqBRNaq5mCbwNUZx9KpoLo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAm5vN046838
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:48:05 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:48:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:48:04 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAm0pQ061384;
	Wed, 17 Jan 2024 04:48:01 -0600
Message-ID: <a25ea57b-4529-4a4c-9e0b-ccd85b0457d6@ti.com>
Date: Wed, 17 Jan 2024 16:17:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for
 num-lanes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-2-s-vadapalli@ti.com>
 <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Krzysztof,

On 17/01/24 16:04, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>> The existing implementation for validating the "num-lanes" property
>> based on the compatible(s) doesn't enforce it. Fix it by updating the
>> checks to handle both single-compatible and multi-compatible cases.
>>
>> Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
>> Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
>>  2 files changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> index 97f2579ea908..278e0892f8ac 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> @@ -68,8 +68,9 @@ allOf:
>>    - if:
>>        properties:
>>          compatible:
> 
> Missing contains:, instead of your change.

I did try the "contains" approach before determining that the implementation in
this patch is more suitable. Please consider the following:

For AM64 SoC the primary compatible is "ti,am64-pcie-ep" and fallback compatible
is "ti,j721e-pcie-ep". For J7200 SoC the primary compatible is
"ti,j7200-pcie-ep" while the fallback compatible is again "ti,j721e-pcie-ep".

Therefore, the device-tree nodes for AM64 and J7200 look like:

AM64:
    compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
    ...
    num-lanes = 1;

J7200:
    compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
    ...
    num-lanes = 4;

This implies that when the check for "num-lanes" is performed on the device-tree
node for PCIe in J7200, the fallback compatible of "ti,j721e-pcie-ep" within the
AM64's "compatible: contains:" check will match the schema and it will check the
existing "num-lanes" being described as "const: 1" against the value in J7200's
PCIe node resulting in a warning. Therefore, using "contains" will result in
errors if the check has to be performed for device-tree nodes with fallback
compatibles. The "items" based approach I have used in this patch ensures that
the schema matches *only* when both the primary and fallback compatible are
present in the device-tree node.

> 
>> -          enum:
>> -            - ti,am64-pcie-ep
>> +          items:
>> +            - const: ti,am64-pcie-ep
>> +            - const: ti,j721e-pcie-ep
> 
>>      then:
>>        properties:
>>          num-lanes:
>> @@ -78,9 +79,9 @@ allOf:
>>    - if:
>>        properties:
>>          compatible:
>> -          enum:
>> -            - ti,j7200-pcie-ep
>> -            - ti,j721e-pcie-ep
>> +          items:
>> +            - const: ti,j7200-pcie-ep
>> +            - const: ti,j721e-pcie-ep
> 
> "Ditto

Same explanation as above.

> 
>>      then:
>>        properties:
>>          num-lanes:
>> @@ -90,8 +91,19 @@ allOf:
>>    - if:
>>        properties:
>>          compatible:
>> -          enum:
>> -            - ti,j784s4-pcie-ep
>> +          items:
>> +            - const: ti,j721e-pcie-ep
>> +    then:
>> +      properties:
>> +        num-lanes:
>> +          minimum: 1
>> +          maximum: 4
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          items:
>> +            - const: ti,j784s4-pcie-ep
> 
> Why? Previous code was correct.

Though I used "patience diff", for some reason the addition of
"ti,j721e-pcie-ep" in the check has been treated as the removal of
"ti,j784s4-pcie-ep" first followed by adding the same later for generating the
diff in this patch. The diff above is equivalent to the addition of:

  - if:
      properties:
        compatible:
          items:
            - const: ti,j721e-pcie-ep
    then:
      properties:
        num-lanes:
          minimum: 1
          maximum: 4

-- 
Regards,
Siddharth.

