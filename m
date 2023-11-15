Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5B7EBEA9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 09:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjKOIin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 03:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 03:38:43 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E910D;
        Wed, 15 Nov 2023 00:38:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8cLlI074573;
        Wed, 15 Nov 2023 02:38:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700037501;
        bh=HQjvAKK8mR4gHr9pLyWPx3ruzZP+R+klVmQwwImkrdg=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=vUwCQfBZT1yxE8yZM+FuF8DPWU0xl4LradLCt0FFEqpOUFbeiJyVDgtxO9VfwZLPL
         R7B75LZbJHCMFlIoTAWMyyVnpU7HPezq+eH8UfO0PU36w71fUhta4mHSM0L30tiGis
         y3ZIRIP8g0bLgKKffU1cGMsZSRv5n4GVwd0yZCcI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF8cLvS051891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 02:38:21 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 02:38:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 02:38:21 -0600
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8cHv8036919;
        Wed, 15 Nov 2023 02:38:18 -0600
Message-ID: <9f0a8b4b-615c-42a3-b593-3c182ac2e447@ti.com>
Date:   Wed, 15 Nov 2023 14:08:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ilpo.jarvinen@linux.intel.com>, <vigneshr@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
Content-Language: en-US
To:     <bhelgaas@google.com>
References: <20230927041845.1222080-1-s-vadapalli@ti.com>
 <3f0ba0d6-6027-6f2c-b548-4bbd0f69bc89@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <3f0ba0d6-6027-6f2c-b548-4bbd0f69bc89@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

Could you please merge this patch?

On 28/09/23 13:21, Ravi Gunasekaran wrote:
> 
> 
> On 9/27/23 9:48 AM, Siddharth Vadapalli wrote:
>> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
>> function. The PHY in this case is the Serdes. It is possible that the
>> PCI instance is configured for 2 lane operation across two different
>> Serdes instances, using 1 lane of each Serdes. In such a configuration,
>> if the reference clock for one Serdes is provided by the other Serdes,
>> it results in a race condition. After the Serdes providing the reference
>> clock is initialized by the PCI driver by invoking its PHY APIs, it is
>> not guaranteed that this Serdes remains powered on long enough for the
>> PHY APIs based initialization of the dependent Serdes. In such cases,
>> the PLL of the dependent Serdes fails to lock due to the absence of the
>> reference clock from the former Serdes which has been powered off by the
>> PM Core.
>>
>> Fix this by obtaining reference to the PHYs before invoking the PHY
>> initialization APIs and releasing reference after the initialization is
>> complete.
> 
> Sounds reasonable.
> 
> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Ravi
>>
>> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> NOTE: This patch is based on linux-next tagged next-20230927.
>>
>> v2:
>> https://lore.kernel.org/r/20230926063638.1005124-1-s-vadapalli@ti.com/
>>
>> Changes since v2:
>> - Implement suggestion by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>   moving the phy_pm_runtime_put_sync() For-Loop section before the
>>   return value of ks_pcie_enable_phy(ks_pcie) is checked, thereby
>>   preventing duplication of the For-Loop.
>> - Rebase patch on next-20230927.
>>
>> v1:
>> https://lore.kernel.org/r/20230926054200.963803-1-s-vadapalli@ti.com/
>>
>> Changes since v1:
>> - Add code to release reference(s) to the phy(s) when
>>   ks_pcie_enable_phy(ks_pcie) fails.
>>
>> Regards,
>> Siddharth.
>>
>>  drivers/pci/controller/dwc/pci-keystone.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 49aea6ce3e87..0ec6720cc2df 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -1218,7 +1218,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  		goto err_link;
>>  	}
>>  
>> +	/* Obtain reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
>> +
>>  	ret = ks_pcie_enable_phy(ks_pcie);
>> +
>> +	/* Release reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>> +
>>  	if (ret) {
>>  		dev_err(dev, "failed to enable phy\n");
>>  		goto err_link;
> 

-- 
Regards,
Siddharth.
