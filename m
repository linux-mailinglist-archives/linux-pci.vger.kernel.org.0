Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC5462B62
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 05:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhK3EDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 23:03:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38234 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbhK3EDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 23:03:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AU406ic129785;
        Mon, 29 Nov 2021 22:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638244807;
        bh=7ZkdzRI5nkVOIxG6H0+3i6spUmwZrAtlweJRgbqGFcI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m7qu+3uXFRbmCvgCCnPdT8tJi3Pu5mQ5DGadb5Ia9Tolw6La06IGF2oBDs5n3QfMZ
         uQuNu2EJEE5KN9oqJR+Jtr3PvTyhc+gvDwOzz/NL5ueD2YtS6ZkRr/ltuaKc1AIDb8
         xS2FTJJMHVtQ1fRC4PkW+BsfsHhBf+UE9GeiiDDc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AU404D9061748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 22:00:06 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 22:00:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 22:00:06 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AU4035c075086;
        Mon, 29 Nov 2021 22:00:04 -0600
Subject: Re: [PATCH] dt-bindings: PCI: ti,j721e: Add device id for J721S2
To:     Rob Herring <robh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211119133253.18590-1-a-govindraju@ti.com>
 <YaVsaYqWIFCwHigK@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <0f705394-863f-3734-9e27-6317ad594112@ti.com>
Date:   Tue, 30 Nov 2021 09:30:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaVsaYqWIFCwHigK@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 30/11/21 5:42 am, Rob Herring wrote:
> On Fri, Nov 19, 2021 at 07:02:53PM +0530, Aswath Govindraju wrote:
>> Document the device id of J721S2 SoC.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> index cc900202df29..0411bf5a1700 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -71,6 +71,8 @@ properties:
>>            - const: 0xb00f
>>        - items:
>>            - const: 0xb010
>> +      - items:
>> +          - const: 0xb013
> 
> This can all be just an 'enum'.
> 

Sorry, for not noticing this. I have posted a v2 after making the
correction.

Thanks,
Aswath

>>  
>>    msi-map: true
>>  
>> -- 
>> 2.17.1
>>
>>

