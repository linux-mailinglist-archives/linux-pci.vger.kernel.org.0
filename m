Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7E7AF999
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 06:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjI0ElT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjI0Ek1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 00:40:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6124130FD;
        Tue, 26 Sep 2023 20:59:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R3x8Hr033687;
        Tue, 26 Sep 2023 22:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695787148;
        bh=AEaQ7BHeJwnCKmAay/ffXmStdjuiZZGBGlYGggdty/M=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=aBDSjJ2Xj5T/fco3DkyXF93ezUloj1CbOVYfjGo8cZd81zBmmxdQiwi/yUJTRJTaX
         Z3xOpoLkZ2kKXorWIIIPugnl2C66esAwOD7Y7BLUOK/dNd2lp+RZheTfzM0fG4hJ4C
         +XHr3GBsbZ3kqiSWrE7z7PQ6Z/KUuEgMpO+NRccQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R3x8s3067180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 22:59:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 22:59:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 22:59:08 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R3x49M035254;
        Tue, 26 Sep 2023 22:59:05 -0500
Message-ID: <b204755f-0fa8-d945-fb14-1124ccefe8e6@ti.com>
Date:   Wed, 27 Sep 2023 09:29:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: keystone: Fix race condition when initializing
 PHYs
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230926063638.1005124-1-s-vadapalli@ti.com>
 <cb19cfd1-22ed-7880-9fe-8b31488b6bb1@linux.intel.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <cb19cfd1-22ed-7880-9fe-8b31488b6bb1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26/09/23 22:08, Ilpo Järvinen wrote:
> On Tue, 26 Sep 2023, Siddharth Vadapalli wrote:
> 
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
>>
>> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> NOTE: This patch is based on linux-next tagged next-20230925.
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
>>  drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 49aea6ce3e87..e4d43306a7e3 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -1218,12 +1218,24 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  		goto err_link;
>>  	}
>>  
>> +	/* Obtain reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
>> +
>>  	ret = ks_pcie_enable_phy(ks_pcie);
> 
> You could do the put loop here before checking ret to avoid duplicating 
> the put loop.

Right! Thank you for reviewing the patch and sharing this suggestion. I will
implement this and post the v3 patch.

> 
>>  	if (ret) {
>>  		dev_err(dev, "failed to enable phy\n");
>> +		/* Release reference(s) to the phy(s) */
>> +		for (i = 0; i < num_lanes; i++)
>> +			phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>> +
>>  		goto err_link;
>>  	}
>>  
>> +	/* Release reference(s) to the phy(s) */
>> +	for (i = 0; i < num_lanes; i++)
>> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>> +
>>  	platform_set_drvdata(pdev, ks_pcie);
>>  	pm_runtime_enable(dev);
>>  	ret = pm_runtime_get_sync(dev);
>>
> 

-- 
Regards,
Siddharth.
