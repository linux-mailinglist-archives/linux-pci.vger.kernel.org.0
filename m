Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBF97EBEAC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjKOIjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 03:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 03:39:53 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE45F10D;
        Wed, 15 Nov 2023 00:39:49 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8dc73074810;
        Wed, 15 Nov 2023 02:39:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700037578;
        bh=RKGvrsGYEfQbD2wYlwy6LGrGZPioOXIr8ITeZvpxvrQ=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=HVA4TB+DqCFLEmaEQ3mSXJOcjEL3cW8Y492PB30/q92glX0li2Nk6hU9MVaICNxth
         fcOO2cW3cx/AsxRppBpW6j86V1BhBSNX/58o1hm8VLBubmz2cahl3vRceVXvSL+VQ+
         YSGhnpF+P6q8FjxTKDRRvSuNmU9C+FtrW6SgwHeg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF8dc0j061728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 02:39:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 02:39:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 02:39:38 -0600
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8cHv9036919;
        Wed, 15 Nov 2023 02:39:35 -0600
Message-ID: <6f380401-4ca5-40c2-9adb-b2a3c0b27bb4@ti.com>
Date:   Wed, 15 Nov 2023 14:09:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     Serge Semin <fancer.lancer@gmail.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Content-Language: en-US
To:     <bhelgaas@google.com>
References: <20231019081330.2975470-1-s-vadapalli@ti.com>
 <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 19/10/23 15:35, Serge Semin wrote:
> On Thu, Oct 19, 2023 at 01:43:30PM +0530, Siddharth Vadapalli wrote:
>> In the process of converting .scan_bus() callbacks to .add_bus(), the
>> ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
>> The .scan_bus() method belonged to ks_pcie_host_ops which was specific
>> to controller version 3.65a, while the .add_bus() method had been added
>> to ks_pcie_ops which is shared between the controller versions 3.65a and
>> 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
>> ks_pcie_v3_65_add_bus() method are applicable to the controller version
>> 4.90a which is present in AM654x SoCs.
>>
>> Thus, fix this by creating ks_pcie_am6_ops for the AM654x SoC which uses DW
>> PCIe IP-core version 4.90a controller and omitting the .add_bus() method
>> which is not applicable to the 4.90a controller. Update ks_pcie_host_init()
>> accordingly in order to set the pci_ops to ks_pcie_am6_ops if the platform
>> is AM654x SoC and to ks_pcie_ops otherwise, by making use of the "is_am6"
>> flag.
>>
>> Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> LGTM. Thanks!
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> One more note is further just to draw attention to possible driver
> simplifications.
> 
>> ---
>> Hello,
>>
>> This patch is based on linux-next tagged next-20231018.
>>
>> The v2 of this patch is at:
>> https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/
>>
>> Changes since v2:
>> - Implemented Serge's suggestion of adding a new pci_ops structure for
>>   AM654x SoC using DWC PCIe IP-core version 4.90a controller.
>> - Created struct pci_ops ks_pcie_am6_ops for AM654x SoC without the
>>   .add_bus method while retaining other ops from ks_pcie_ops.
>> - Updated ks_pcie_host_init() to set pci_ops to ks_pcie_am6_ops if the
>>   platform is AM654x and to ks_pcie_ops otherwise by making use of the
>>   already existing "is_am6" flag.
>> - Combined the section:
>> 	if (!ks_pcie->is_am6)
>>  		pp->bridge->child_ops = &ks_child_pcie_ops;
>>   into the newly added ELSE condition.
>>
>> The v1 of this patch is at:
>> https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
>>
>> While there are a lot of changes since v1 and this patch could have been
>> posted as a v1 patch itself, I decided to post it as the v2 of the patch
>> mentioned above since it aims to address the issue described by the v1
>> patch and is similar in that sense. However, the solution to the issue
>> described in the v1 patch appears to be completely different from what
>> was implemented in the v1 patch. Thus, the commit message and subject of
>> this patch have been modified accordingly.
>>
>> Changes since v1:
>> - Updated patch subject and commit message.
>> - Determined that issue is not with the absence of Link as mentioned in
>>   v1 patch. Even with Link up and endpoint device connected, if
>>   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
>>   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
>>   AER and PME services. The all Fs return value indicates that the MSI-X
>>   configuration is failing even if Endpoint device is connected. This is
>>   because the ks_pcie_v3_65_add_bus() function is not applicable to the
>>   AM654x SoC which uses DW PCIe IP-core version 4.90a.
>>
>> Regards,
>> Siddharth.
>>
>>  drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 49aea6ce3e87..66341a0b6c6b 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -487,6 +487,12 @@ static struct pci_ops ks_pcie_ops = {
>>  	.add_bus = ks_pcie_v3_65_add_bus,
>>  };
>>  
>> +static struct pci_ops ks_pcie_am6_ops = {
>> +	.map_bus = dw_pcie_own_conf_map_bus,
>> +	.read = pci_generic_config_read,
>> +	.write = pci_generic_config_write,
>> +};
>> +
>>  /**
>>   * ks_pcie_link_up() - Check if link up
>>   * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
>> @@ -804,9 +810,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>>  	int ret;
>>  
>> -	pp->bridge->ops = &ks_pcie_ops;
>> -	if (!ks_pcie->is_am6)
>> +	if (ks_pcie->is_am6) {
>> +		pp->bridge->ops = &ks_pcie_am6_ops;
>> +	} else {
> 
>> +		pp->bridge->ops = &ks_pcie_ops;
>>  		pp->bridge->child_ops = &ks_child_pcie_ops;
> 
> Bjorn, could you please clarify the next suggestion? I'm not that
> fluent in the PCIe core details, but based on the
> pci_host_bridge.child_ops and pci_host_bridge.ops names, the first ops
> will be utilized for the child (non-root) PCIe buses, meanwhile the
> later ones - for the root bus only (see pci_alloc_child_bus()). Right?
> 
> If so then either the pci_is_root_bus() check can be dropped from the
> ks_pcie_v3_65_add_bus() method since the ops it belong to will be
> utilized for the root bus anyway, or the entire ks_child_pcie_ops
> instance can be dropped since the ks_pcie_v3_65_add_bus() method will
> be no-op for the child buses anyway meanwhile ks_child_pcie_ops
> matches to ks_pcie_ops in the rest of the ops. After doing that I
> would have also changed the ks_pcie_v3_65_add_bus name to
> ks_pcie_v3_65_add_root_bus() in anyway. Am I right?
> 
> -Serge(y)
> 
>> +	}
>>  
>>  	ret = ks_pcie_config_legacy_irq(ks_pcie);
>>  	if (ret)
>> -- 
>> 2.34.1
>>

-- 
Regards,
Siddharth.
