Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0E1260F8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 12:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLSLja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 06:39:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52608 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSLj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 06:39:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJBdLW4089961;
        Thu, 19 Dec 2019 05:39:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576755561;
        bh=URjsFi4ZIoRLlymSfAHTpngfFolgDFyHrFhz0PlZAyo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rx7y9Jfgj8jUXKSsBe0ulubTK2CfDEEp0yo9BddnkYd411O9CQ+DzmWVziSFUNSLY
         bhHODvmYVl2YzlFMq4k+h18meSchksyKbYRLV9TW2+Y+ejxzkU3AxpHAnBaJIVXchl
         saGKTTsl1uvdk96dN/FmNzJ0W2dlqHyEj6DQ5Sgc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJBdL2l022773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:39:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 05:39:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 05:39:21 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJBdHch064637;
        Thu, 19 Dec 2019 05:39:18 -0600
Subject: Re: [PATCH 03/13] PCI: cadence: Add support to use custom read and
 write accessors
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-4-kishon@ti.com>
 <20191216140729.GX24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cdd13dd0-6595-c11c-72b2-6a1d140c2bbc@ti.com>
Date:   Thu, 19 Dec 2019 17:11:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216140729.GX24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 16/12/19 7:37 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:37PM +0530, Kishon Vijay Abraham I wrote:
>> Add support to use custom read and write accessors. Platforms that
>> doesn't support half word or byte access or any other constraint
> 
> s/doesn't/don't/
> 
>> while accessing registers can use this feature to populate custom
>> read and write accessors. These custom accessors are used for both
>> standard register access and configuration space register access.
> 
> You can put the following sentence underneath a --- as it's not needed
> in the commit message (but may be helpful to reviewers).
> 
>> This is in preparation for adding PCIe support in TI's J721E SoC which
>> uses Cadence PCIe core.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence.h | 99 +++++++++++++++++--
>>  1 file changed, 90 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index a2b28b912ca4..d0d91c69fa1d 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -223,6 +223,11 @@ enum cdns_pcie_msg_routing {
>>  	MSG_ROUTING_GATHER,
>>  };
>>  
>> +struct cdns_pcie_ops {
>> +	u32	(*read)(void __iomem *addr, int size);
>> +	void	(*write)(void __iomem *addr, int size, u32 value);
>> +};
>> +
>>  /**
>>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>>   * @reg_base: IO mapped register base
>> @@ -239,7 +244,7 @@ struct cdns_pcie {
>>  	int			phy_count;
>>  	struct phy		**phy;
>>  	struct device_link	**link;
>> -	const struct cdns_pcie_common_ops *ops;
> 
> What was cdns_pcie_common_ops? It's not defined in the current tree is it?

Yeah, it's spurious change that has got merged.
> 
>> +	const struct cdns_pcie_ops *ops;
>>  };
>>  
>>  /**
>> @@ -301,21 +306,47 @@ struct cdns_pcie_ep {
>>  /* Register access */
>>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>>  {
>> +	void __iomem *addr = pcie->reg_base + reg;
>> +
>> +	if (pcie->ops && pcie->ops->write) {
>> +		pcie->ops->write(addr, 0x1, value);
>> +		return;
>> +	}
>> +
>>  	writeb(value, pcie->reg_base + reg);
> 
> Can you use 'addr' here instead of 'pcie->reg_base + reg'? (And similar for the
> rest of them).

Sure.

Thanks
Kishon
