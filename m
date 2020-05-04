Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072BE1C34F5
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEDIwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 04:52:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59540 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEDIwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 04:52:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0448qbRg096817;
        Mon, 4 May 2020 03:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588582357;
        bh=oLNWH+X1hs3YnhUrSb8y01crQB5nXm4tFtkF+k5FD4A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TNRnNkT9hx70ILqFW/Q7mk9b2zIIubTuhpnHg7oChBKB6JrodiPD96P54cRiqLSUE
         gPYnzX2Xshh63zGJWQNXqM3H3B0jVK4jcI+vC5IEiov/yewuoj/wEIU+EQoaxBejqI
         5ERCtICIgMrEdTFnUsu6h8jC8mdIefkBq39C+Z+0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0448qa3W047269;
        Mon, 4 May 2020 03:52:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 May
 2020 03:52:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 May 2020 03:52:36 -0500
Received: from [10.250.150.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0448qVrN036997;
        Mon, 4 May 2020 03:52:32 -0500
Subject: Re: [PATCH v2 4/4] PCI: cadence: Fix to read 32-bit Vendor ID/Device
 ID property from DT
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-5-kishon@ti.com>
 <20200501151131.GC7398@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <47cc8236-4bec-244d-4ab3-cda8eb37d4bf@ti.com>
Date:   Mon, 4 May 2020 14:22:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501151131.GC7398@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 5/1/2020 8:41 PM, Lorenzo Pieralisi wrote:
> On Fri, Apr 17, 2020 at 05:13:22PM +0530, Kishon Vijay Abraham I wrote:
>> The PCI Bus Binding specification (IEEE Std 1275-1994 Revision 2.1 [1])
>> defines both Vendor ID and Device ID to be 32-bits. Fix
>> pcie-cadence-host.c driver to read 32-bit Vendor ID and Device ID
>> properties from device tree.
>>
>> [1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 4 ++--
>>  drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> I don't see how you would use a 32-bit value for a 16-bit register so
> certainly the struct cdns_pcie_rc fields size is questionable anyway.
> 
> I *assume* you are referring to 4.1.2.1 and the property list
> encoded as "encode-int".
> 
> I would like to get RobH's opinion on this - I don't know myself
> whether the PCI OF bindings you added are still relevant and how
> they should be interpreted.

This change was made due to RobH's comment below [1]

[1] ->
https://lore.kernel.org/r/CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com/

Thanks
Kishon

> 
> Thanks
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 8f72967f298f..31e67c9c88cf 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -229,10 +229,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	}
>>  
>>  	rc->vendor_id = 0xffff;
>> -	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
>> +	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
>>  
>>  	rc->device_id = 0xffff;
>> -	of_property_read_u16(np, "device-id", &rc->device_id);
>> +	of_property_read_u32(np, "device-id", &rc->device_id);
>>  
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>>  	pcie->reg_base = devm_ioremap_resource(dev, res);
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 6bd89a21bb1c..df14ad002fe9 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -262,8 +262,8 @@ struct cdns_pcie_rc {
>>  	struct resource		*bus_range;
>>  	void __iomem		*cfg_base;
>>  	u32			no_bar_nbits;
>> -	u16			vendor_id;
>> -	u16			device_id;
>> +	u32			vendor_id;
>> +	u32			device_id;
>>  };
>>  
>>  /**
>> -- 
>> 2.17.1
>>
