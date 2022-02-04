Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E24A9BA8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357690AbiBDPJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 10:09:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32964 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353431AbiBDPJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 10:09:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 214F8pLF063155;
        Fri, 4 Feb 2022 09:08:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643987331;
        bh=fGcvqj8pmu0/HuF9/g0VeMM9I4TaK3Vd9U+V3O4yrwU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=OILs61X1Jk1dwx/DtQ/3GgOH2neQgOkT+yICmFoAmg3bPOm4Spr0WD7Y3jB84EpHp
         vFdrwqJ35K4zgwbqXlCdisyddLisc487GmhoJkpTVCgWcgHf20LNfch/Cjmp/Xl4Uv
         0rUgyW8Bp/ZxGzE+JVtDnJ7Wn0dDiQOQd7d9n2Ok=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 214F8pp9040834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Feb 2022 09:08:51 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 4
 Feb 2022 09:08:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 4 Feb 2022 09:08:50 -0600
Received: from [10.250.233.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 214F8lBR081186;
        Fri, 4 Feb 2022 09:08:48 -0600
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR flag
 as IORESOURCE_UNSET
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-5-kishon@ti.com> <20220104155741.GA28358@lpieralisi>
 <f3a2c3f0-caf2-743c-a2f7-a99ea3ddb04f@ti.com>
Message-ID: <a07040ce-e043-22ac-2ee5-47a3bfdedd3b@ti.com>
Date:   Fri, 4 Feb 2022 20:38:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f3a2c3f0-caf2-743c-a2f7-a99ea3ddb04f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 11/01/22 11:53 am, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 04/01/22 9:27 pm, Lorenzo Pieralisi wrote:
>> On Fri, Nov 26, 2021 at 02:01:18PM +0530, Kishon Vijay Abraham I wrote:
>>> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
>>> both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
>>> enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
>>> Second boot up delay when it tries to write to undefined location.
>>>
>>> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
>>> msix_map_region() returns NULL for Root Complex and avoid un-desirable
>>> writes to MSI-X table.
>>
>> I don't think this is the right fix (it is not even a fix, just a
>> plaster to workaround an issue).
>>
>> What do you mean by "writing to an undefined location" ?
>>
>> What does "a hard coded BAR" mean ?
>>
>> What happens if we _rightly_ write into it (ie to size it) ?
> 
> There are two parts w.r.t setting the BAR; one is during the configuration and
> the other is during the enumeration.
> i) During the configuration, the size of the BAR is configured and the inbound
> ATU is configured to map the BAR to a physical memory.
> ii) During the enumeration, the size of the BAR is obtained and an address is
> allocated and programmed in the BAR.
> 
> In the case of RC, for (i) above, the BAR size is configured as '0'
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n556
> and the inbound ATU is not programmed at all.
> 
> However, in the case of AM654, the HW configures BAR0 for a fixed size of 1MB
> (irrespective of what SW programmed in [i]). While this was done more for a
> endpoint usecase, since the same IP is configured for both RC mode and EP mode,
> the fixed BAR size is seen with RC mode as well. AM654 also has MSI-X capability
> for RC mode (the IP should have been ideally configured to have MSI-X capability
> for EP mode). This results in PCIEPORTBUS doing some undesired access in
> msix_mask_all().
> 
> Here I configure IORESOURCE_UNSET so that memory is not allocated for RC BAR.

Do you need further clarifications on this?

Thank You,
Kishon

> 
> Thank You,
> Kishon
> 
> 
>>
>> Lorenzo
>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>> index 52d20fe17ee9..73e6626a0d8f 100644
>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>>> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>>>  		{ 0, },
>>>  	};
>>>  
>>> -	if (pci_is_root_bus(bus))
>>> +	if (pci_is_root_bus(bus)) {
>>>  		bridge = dev;
>>> +		if (pci_match_id(am6_pci_devids, bridge)) {
>>> +			struct resource *r = &dev->resource[0];
>>> +
>>> +			r->flags |= IORESOURCE_UNSET;
>>> +		}
>>> +	}
>>>  
>>>  	/* look for the host bridge */
>>>  	while (!pci_is_root_bus(bus)) {
>>> -- 
>>> 2.17.1
>>>
