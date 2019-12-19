Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A412616C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 12:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfLSL7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 06:59:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50150 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSL7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 06:59:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJBxQv3029312;
        Thu, 19 Dec 2019 05:59:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576756766;
        bh=yxnvtS3Y6dPrnMhLpxgcSG/4NfRE2DXlNbtemhtrESM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y4Y/y3I/vtDVqaru8Sb8k5lFOAcIPq6QsfYkosMiBcJ57TtTSq0dWCTol/3doRSMR
         1PO38ehyG9OpRZ0hDg21crEDpPFOIoHy41N+aFPL1bOXRyKlKscZsNqtqYzt6ZeVK9
         iJGeAuQBmOkiu8asV6Ges6w1RXfrjDIMh/PWicw4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJBxQJO118229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:59:26 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 05:59:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 05:59:25 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJBxLn4096682;
        Thu, 19 Dec 2019 05:59:22 -0600
Subject: Re: [PATCH 04/13] PCI: cadence: Add support to start link and verify
 link status
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-5-kishon@ti.com>
 <20191217115826.GA24359@e119886-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <16ffe86d-9061-1a9a-d536-561e20ecbdd7@ti.com>
Date:   Thu, 19 Dec 2019 17:31:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217115826.GA24359@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 17/12/19 5:28 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:38PM +0530, Kishon Vijay Abraham I wrote:
>> Add cdns_pcie_ops to start link and verify link status. The registers
>> to start link and to check link status is in Platform specific PCIe
>> wrapper. Add support for platform specific drivers to add callback
>> functions for the PCIe Cadence core to start link and verify link status.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-ep.c  |  8 ++++++
>>  .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++++++++++++
>>  3 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 560f22b4d165..088394b6be04 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -355,8 +355,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>  {
>>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct cdns_pcie *pcie = &ep->pcie;
>> +	struct device *dev = pcie->dev;
>>  	struct pci_epf *epf;
>>  	u32 cfg;
>> +	int ret;
>>  
>>  	/*
>>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>> @@ -367,6 +369,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>  		cfg |= BIT(epf->func_no);
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
>>  
>> +	ret = cdns_pcie_start_link(pcie, true);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to start link\n");
>> +		return ret;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index ccf55e143e1d..0929554f5a81 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -3,6 +3,7 @@
>>  // Cadence PCIe host controller driver.
>>  // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>  
>> +#include <linux/delay.h>
>>  #include <linux/kernel.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>> @@ -201,6 +202,23 @@ static int cdns_pcie_host_init(struct device *dev,
>>  	return err;
>>  }
>>  
>> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->dev;
>> +	int retries;
>> +
>> +	/* Check if the link is up or not */
>> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> +		if (cdns_pcie_is_link_up(pcie)) {
>> +			dev_info(dev, "Link up\n");
>> +			return 0;
>> +		}
>> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +	}
>> +
>> +	return -ETIMEDOUT;
>> +}
> 
> This patch looks fine, except this function (above) is identical to
> dw_pcie_wait_for_link, advk_pcie_wait_for_link and nwl_wait_for_link. Even
> the definitions of LINK_WAIT_USLEEP_xx are the same.
> 
> I don't see any justification to duplicating this again - can you consolidate
> these functions to something that all controller drivers can use?

This involves reading a register, so this in entirety cannot be in a
generic layer. We could add "ops" for checking the link status (in
pci_ops?), but I'm not sure if that's really required.

Thanks
Kishon
