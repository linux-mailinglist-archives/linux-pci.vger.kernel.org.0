Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A248A7AC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 07:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiAKGXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 01:23:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35568 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiAKGXh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 01:23:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20B6NOEX071918;
        Tue, 11 Jan 2022 00:23:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641882204;
        bh=onGVWe+kytUJ//3nJPAEhq9Tc2P2n5qotrXyz24dlcs=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=K6+Sqhk7p1VRGNTmWiIRIceEwlMLzw54Vn9/Ccrk0V7r5G1p9kNZlBsZCFUsPybn8
         rACL72IWRTGkvlzRAp1aqxs+NloANWmLtpM0NCzzsPSI5PLZI4XZH7IjUKRVh9w8tH
         pdwLNBC+PTvyQZjd9wY/cQ6PZF+EGQ3vea80lQSs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20B6NOlK087461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jan 2022 00:23:24 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 11
 Jan 2022 00:23:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 11 Jan 2022 00:23:24 -0600
Received: from [10.250.233.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20B6NK3u099501;
        Tue, 11 Jan 2022 00:23:21 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 4/5] PCI: keystone: Add quirk to mark AM654 RC BAR flag
 as IORESOURCE_UNSET
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-5-kishon@ti.com> <20220104155741.GA28358@lpieralisi>
Message-ID: <f3a2c3f0-caf2-743c-a2f7-a99ea3ddb04f@ti.com>
Date:   Tue, 11 Jan 2022 11:53:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220104155741.GA28358@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 04/01/22 9:27 pm, Lorenzo Pieralisi wrote:
> On Fri, Nov 26, 2021 at 02:01:18PM +0530, Kishon Vijay Abraham I wrote:
>> AM654 RootComplex has a hard coded 64 bit BAR of size 1MB and also has
>> both MSI and MSI-X capability in it's config space. If PCIEPORTBUS is
>> enabled, it tries to configure MSI-X and msix_mask_all() adds about 10
>> Second boot up delay when it tries to write to undefined location.
>>
>> Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET so that
>> msix_map_region() returns NULL for Root Complex and avoid un-desirable
>> writes to MSI-X table.
> 
> I don't think this is the right fix (it is not even a fix, just a
> plaster to workaround an issue).
> 
> What do you mean by "writing to an undefined location" ?
> 
> What does "a hard coded BAR" mean ?
> 
> What happens if we _rightly_ write into it (ie to size it) ?

There are two parts w.r.t setting the BAR; one is during the configuration and
the other is during the enumeration.
i) During the configuration, the size of the BAR is configured and the inbound
ATU is configured to map the BAR to a physical memory.
ii) During the enumeration, the size of the BAR is obtained and an address is
allocated and programmed in the BAR.

In the case of RC, for (i) above, the BAR size is configured as '0'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n556
and the inbound ATU is not programmed at all.

However, in the case of AM654, the HW configures BAR0 for a fixed size of 1MB
(irrespective of what SW programmed in [i]). While this was done more for a
endpoint usecase, since the same IP is configured for both RC mode and EP mode,
the fixed BAR size is seen with RC mode as well. AM654 also has MSI-X capability
for RC mode (the IP should have been ideally configured to have MSI-X capability
for EP mode). This results in PCIEPORTBUS doing some undesired access in
msix_mask_all().

Here I configure IORESOURCE_UNSET so that memory is not allocated for RC BAR.

Thank You,
Kishon


> 
> Lorenzo
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 52d20fe17ee9..73e6626a0d8f 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -557,8 +557,14 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>>  		{ 0, },
>>  	};
>>  
>> -	if (pci_is_root_bus(bus))
>> +	if (pci_is_root_bus(bus)) {
>>  		bridge = dev;
>> +		if (pci_match_id(am6_pci_devids, bridge)) {
>> +			struct resource *r = &dev->resource[0];
>> +
>> +			r->flags |= IORESOURCE_UNSET;
>> +		}
>> +	}
>>  
>>  	/* look for the host bridge */
>>  	while (!pci_is_root_bus(bus)) {
>> -- 
>> 2.17.1
>>
