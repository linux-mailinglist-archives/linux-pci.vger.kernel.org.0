Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43171959CB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgC0P1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 11:27:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56662 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgC0P1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 11:27:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RFR5Cc034074;
        Fri, 27 Mar 2020 10:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585322825;
        bh=JoSE4KS/EBjkD65NeBxt6yyL8T/GBsNherjOFrGs2kY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QeX12oQA01mdt0aCxMz6k1HBIXZWnc1xbuF992rNER6psMbqrKzR+G/c/+QKA+qX9
         +FL8BUDqeywrmILz4iX8PDrhNBI5ftOQbTnYA1UA49z0dD5hR12hb6TsCkOpcdIwTc
         wgRZhCl5ZfPMibm4Au2eT9Kq6M5CAW5k6CnsfAiQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RFR4l3087392;
        Fri, 27 Mar 2020 10:27:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 10:27:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 10:27:04 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RFR0Rk068295;
        Fri, 27 Mar 2020 10:27:01 -0500
Subject: Re: [PATCH 3/3] PCI: Cadence: Remove using
 "cdns,max-outbound-regions" DT property
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200327145417.GA30341@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <27e3eb0b-c7d0-7eb7-1fb8-1f98b729513a@ti.com>
Date:   Fri, 27 Mar 2020 20:57:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327145417.GA30341@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/27/2020 8:24 PM, Bjorn Helgaas wrote:
> Update subject to match capitalization of others:
> 
>   PCI: cadence: Remove "cdns,max-outbound-regions" DT property
> 
> On Fri, Mar 27, 2020 at 04:17:27PM +0530, Kishon Vijay Abraham I wrote:
>> "cdns,max-outbound-regions" device tree property provides the
>> maximum number of outbound regions supported by the Host PCIe
>> controller. However the outbound regions are configured based
>> on what is populated in the "ranges" DT property.
> 
> Looks like this is missing a blank line here?  Or it should be
> rewrapped as part of the above paragraph?  I think the below makes
> more sense as a separate paragraph, though.

I'll add a blank line for the next paragraph and re-post once I get Ack from
Rob on the DT binding patch.

Thanks for reviewing!

Regards
Kishon
> 
> Again, thanks for doing this; this is a great cleanup.
> 
>> Avoid using two properties for configuring outbound regions and
>> use only "ranges" property instead.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 6 ------
>>  drivers/pci/controller/cadence/pcie-cadence.h      | 2 --
>>  2 files changed, 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 60f912a657b9..8f72967f298f 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -140,9 +140,6 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  	for_each_of_pci_range(&parser, &range) {
>>  		bool is_io;
>>  
>> -		if (r >= rc->max_regions)
>> -			break;
>> -
>>  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
>>  			is_io = false;
>>  		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
>> @@ -221,9 +218,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	pcie = &rc->pcie;
>>  	pcie->is_rc = true;
>>  
>> -	rc->max_regions = 32;
>> -	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
>> -
>>  	if (!of_pci_dma_range_parser_init(&parser, np))
>>  		if (of_pci_range_parser_one(&parser, &range))
>>  			rc->no_bar_nbits = ilog2(range.size);
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index a2b28b912ca4..6bd89a21bb1c 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -251,7 +251,6 @@ struct cdns_pcie {
>>   * @bus_range: first/last buses behind the PCIe host controller
>>   * @cfg_base: IO mapped window to access the PCI configuration space of a
>>   *            single function at a time
>> - * @max_regions: maximum number of regions supported by the hardware
>>   * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
>>   *                translation (nbits sets into the "no BAR match" register)
>>   * @vendor_id: PCI vendor ID
>> @@ -262,7 +261,6 @@ struct cdns_pcie_rc {
>>  	struct resource		*cfg_res;
>>  	struct resource		*bus_range;
>>  	void __iomem		*cfg_base;
>> -	u32			max_regions;
>>  	u32			no_bar_nbits;
>>  	u16			vendor_id;
>>  	u16			device_id;
>> -- 
>> 2.17.1
>>
