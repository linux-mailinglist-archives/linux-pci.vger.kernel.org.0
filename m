Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F512617E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 13:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSMCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 07:02:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 07:02:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJC2I7s030349;
        Thu, 19 Dec 2019 06:02:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576756938;
        bh=SJ4hNptUJk4P4x4SOwGjpOGBMqMzUELoedaw1b+jwHI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RFvRJCXO0HNrMEcTcs4Fcr3tvG2qzsk0ASlEc41wcAlIV1j1EOg9iX3ITF/TeAP62
         pNUMfAKHW+v53YNoTRjTq67JrWwAQXmYAH5BVzcf8Y/dCQPYFQzZls5F6DrLZbYE4x
         rJHv+WPgKFUV5JWWnd08mRG45SCctKuFBZZobeXk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJC2H8k014202;
        Thu, 19 Dec 2019 06:02:17 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 06:02:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 06:02:17 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJC2DRK102964;
        Thu, 19 Dec 2019 06:02:14 -0600
Subject: Re: [PATCH 07/13] PCI: cadence: Add new *ops* for CPU addr fixup
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-8-kishon@ti.com>
 <20191217124050.GD24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <936cd6d6-33fc-6432-6fec-2b5173cb9ca4@ti.com>
Date:   Thu, 19 Dec 2019 17:33:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217124050.GD24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 17/12/19 6:10 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:41PM +0530, Kishon Vijay Abraham I wrote:
>> Cadence driver uses "mem" memory resource to obtain the offset of
>> configuration space address region, memory space address region and
>> message space address region. The obtained offset is used to program
>> the Address Translation Unit (ATU). However certain platforms like TI's
>> J721E SoC require the absolute address to be programmed in the ATU and not
>> just the offset.
>>
>> The same problem was solved in designware driver using a platform specific
>> ops for CPU addr fixup in commit a660083eb06c5bb0 ("PCI: dwc: designware:
> 
> Thanks for this reference, though this doesn't need to be in the commit
> log, please put such comments underneath a ---.
> 
>> Add new *ops* for CPU addr fixup"). Follow a similar mechanism in
>> Cadence too instead of directly using "mem" memory resource in Cadence
>> PCIe core.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-host.c    | 15 ++++-----------
>>  drivers/pci/controller/cadence/pcie-cadence.c     |  8 ++++++--
>>  drivers/pci/controller/cadence/pcie-cadence.h     |  1 +
>>  3 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 2efc33b1cade..cf817be237af 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -105,15 +105,14 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  {
>>  	struct cdns_pcie *pcie = &rc->pcie;
>> -	struct resource *mem_res = pcie->mem_res;
>>  	struct resource *bus_range = rc->bus_range;
>>  	struct resource *cfg_res = rc->cfg_res;
>>  	struct device *dev = pcie->dev;
>>  	struct device_node *np = dev->of_node;
>>  	struct of_pci_range_parser parser;
>> +	u64 cpu_addr = cfg_res->start;
>>  	struct of_pci_range range;
>>  	u32 addr0, addr1, desc1;
>> -	u64 cpu_addr;
>>  	int r, err;
>>  
>>  	/*
>> @@ -126,7 +125,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>>  
>> -	cpu_addr = cfg_res->start - mem_res->start;
>> +	if (pcie->ops->cpu_addr_fixup)
>> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>> +
> 
> Won't this patch cause a breakage for existing users that won't have defined a
> cpu_addr_fixup? The offset isn't being calculated and so cpu_addr will be wrong?

Correct, this will need an additional patch in pcie-cadence-plat.c.

Thanks
Kishon
