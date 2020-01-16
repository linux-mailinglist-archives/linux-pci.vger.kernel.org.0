Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9A13D8F2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAPL1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 06:27:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48494 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPL1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 06:27:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GBRGdj061689;
        Thu, 16 Jan 2020 05:27:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579174036;
        bh=myfrgAkACHwJfmdNtMcuEJNJskU9ZB6VVutnIR84JH4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nEFmlIIkHRmg720elyKMOm+dhwS+GmQz54J/Pk0oyMkOmh+nf69RXMnk221Fm2/e7
         NSzzCU2NpIciRM4d5s7zg63jd0GcYITe/s87EiYMWMO+9mg4DS68MEI0wBotVnoNJ0
         KvXPQQC6+eWZhLjEpa5vffjlE8C0JzoLPGRujhCI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00GBRGVV021247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:27:16 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 05:27:16 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 05:27:15 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GBR8Tb095885;
        Thu, 16 Jan 2020 05:27:11 -0600
Subject: Re: [PATCH 2/7] dt-bindings: PCI: cadence: Add binding to specify max
 virtual functions
To:     Rob Herring <robh@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191231113534.30405-1-kishon@ti.com>
 <20191231113534.30405-3-kishon@ti.com> <20200115014026.GA10726@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f0690395-4ce7-df93-e837-670829aafb03@ti.com>
Date:   Thu, 16 Jan 2020 16:59:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200115014026.GA10726@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 15/01/20 7:10 AM, Rob Herring wrote:
> On Tue, Dec 31, 2019 at 05:05:29PM +0530, Kishon Vijay Abraham I wrote:
>> Add binding to specify maximum number of virtual functions that can be
>> associated with each physical function.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt         | 2 ++
>>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>> index 4a0475e2ba7e..432578202733 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>> @@ -9,6 +9,8 @@ Required properties:
>>  
>>  Optional properties:
>>  - max-functions: Maximum number of functions that can be configured (default 1).
>> +- max-virtual-functions: Maximum number of virtual functions that can be
>> +    associated with each physical function.
>>  - phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
>>    than one in the list.  If only one PHY listed it must manage all lanes. 
>>  - phy-names:  List of names to identify the PHY.
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> index 4621c62016c7..1d4964ba494f 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> @@ -61,6 +61,12 @@ properties:
>>      minimum: 1
>>      maximum: 6
>>  
>> +  max-virtual-functions:
>> +    minItems: 1
>> +    maxItems: 6
> 
> Is there a PCIe spec limit to number of virtual functions per phy 
> function? Or 2^32 virtual functions is okay.

The PCIe spec provides a 16 bit field to specify number of virtual
functions in the SR-IOV extended capability.


> 
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> 
> I suspect this this be a common property.

Right now we don't have common EP property binding across all
controllers. Maybe should create one?

Thanks
Kishon
