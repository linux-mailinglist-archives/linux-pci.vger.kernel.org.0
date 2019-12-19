Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC055126174
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLSMBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 07:01:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLSMBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 07:01:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJC19aq067272;
        Thu, 19 Dec 2019 06:01:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576756869;
        bh=UE9chI9mah0RhDqtfW9UyM7cHrHG5JmXTXk/JRmKmUU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RBr3umIPtIGbAZA44PEYUUII1Aj1fR/A7Yr+xSqCTYVJ+pDsy8gn7XJ7fzDv3/3v4
         HE5Pi+VyhIfm1Jufg2koqiypZJH6SXUKbcgdZ36S6dd7h2RbLO5jOKeMuvS/odQHzT
         G8jc1GfeOnFOLMnH5elgZJjtigM2evFq7tycs8pE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJC19J4051781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 06:01:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 06:01:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 06:01:08 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJC15YS047971;
        Thu, 19 Dec 2019 06:01:06 -0600
Subject: Re: [PATCH 06/13] PCI: cadence: Allow pci_host_bridge to have custom
 pci_ops
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-7-kishon@ti.com>
 <20191217123243.GC24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0176543a-bc9b-0584-537e-ea407f5340c2@ti.com>
Date:   Thu, 19 Dec 2019 17:32:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217123243.GC24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 17/12/19 6:02 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:40PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allows only 32-bit configuration
>> space access. In such cases pci_generic_config_read and
>> pci_generic_config_write cannot be used. Add support in Cadence core
>> to let pci_host_bridge have custom pci_ops.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 7 ++++---
>>  drivers/pci/controller/cadence/pcie-cadence.h      | 8 ++++++++
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0929554f5a81..2efc33b1cade 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -12,8 +12,8 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> -static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> -				      int where)
>> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +			       int where)
>>  {
>>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>>  	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
>> @@ -289,7 +289,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	list_splice_init(&resources, &bridge->windows);
>>  	bridge->dev.parent = dev;
>>  	bridge->busnr = pcie->bus;
>> -	bridge->ops = &cdns_pcie_host_ops;
>> +	if (!bridge->ops)
>> +		bridge->ops = &cdns_pcie_host_ops;
>>  	bridge->map_irq = of_irq_parse_and_map_pci;
>>  	bridge->swizzle_irq = pci_common_swizzle;
>>  
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 5171d0da37da..c879dd3d2893 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -472,11 +472,19 @@ static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
>>  
>>  #ifdef CONFIG_PCIE_CADENCE_HOST
>>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
>> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +			       int where);
> 
> The commit message doesn't explain why this change in visibility is needed).

So that platform drivers can write custom read() and write() ops and
re-use map_bus. Will add this info in commit message.
> 
>>  #else
>>  static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus,
>> +					     unsigned int devfn,
>> +					     int where)
>> +{
> 
> This still needs to return something right?

Right, thanks for spotting this.

Thanks
Kishon
