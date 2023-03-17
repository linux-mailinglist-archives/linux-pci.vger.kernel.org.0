Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5966BE029
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 05:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCQE2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 00:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQE2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 00:28:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639E24495;
        Thu, 16 Mar 2023 21:28:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H4Rs77097856;
        Thu, 16 Mar 2023 23:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679027274;
        bh=S0qRl4CmWdXFxK2UH6mTRJjfvXYxHjbag3C0LYUvbA0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ra45kfxUE7TAStvukIk9VywQsWX78y0W0OhjtFwsUTO+aJiYQkfPBLJgXsUiulaAL
         OxaBUhwOX2BasTmd51pZgN0gbutNMvJ0SoDzlcqNU4R5aPbjVPNTjBjkZi1ej1eS5t
         YIrVPSD95Eglm/3tU1dKKquHBA1ZBQ4e2VCgh8w4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H4RsBZ017702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 23:27:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 23:27:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 23:27:53 -0500
Received: from [10.249.131.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H4RmSD073045;
        Thu, 16 Mar 2023 23:27:49 -0500
Message-ID: <4e430590-40f5-bc4a-d674-5b316c3a1586@ti.com>
Date:   Fri, 17 Mar 2023 09:57:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] PCI: cadence: Clear the ARI Capability Next Function
 Number of the last function
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>,
        <wojciech.jasko-EXT@continental-corporation.com>
References: <20230316071156.200888-1-a-verma1@ti.com>
 <11b83885-ff64-df78-e14c-137fffb5f7ce@ti.com>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <11b83885-ff64-df78-e14c-137fffb5f7ce@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/17/2023 9:38 AM, Vignesh Raghavendra wrote:
> 
> 
> On 16/03/23 12:41, Achal Verma wrote:
>> From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
>>
>> Next Function Number field in ARI Capability Register for last function
>> must be zero by default as per the PCIe specification, indicating there
>> is no next higher number function but that's not happening in our case,
>> so this patch clears the Next Function Number field for last function used.
>>
>> Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
>> Changes from v1:
>> * Fix commments in the code.
>>
>> Changes from v2:
>> * Rework the commit message.
>>
>>   drivers/pci/controller/cadence/pcie-cadence-ep.c | 14 +++++++++++++-
>>   drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index b8b655d4047e..8742b2f594fd 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>   	struct cdns_pcie *pcie = &ep->pcie;
>>   	struct device *dev = pcie->dev;
>>   	int max_epfs = sizeof(epc->function_num_map) * 8;
>> -	int ret, value, epf;
>> +	int ret, epf, last_fn;
>> +	u32 reg, value;
>>   
>>   	/*
>>   	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>> @@ -573,6 +574,17 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>   	 */
>>   	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
>>   
>> +	/*
>> +	 * Next function field in ARI_CAP_AND_CTR register for last function
>> +	 * should be 0.
>> +	 * Clearing Next Function Number field for the last function used.
>> +	 */
>> +	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
>> +	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
>> +	value  = cdns_pcie_readl(pcie, reg);
>> +	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
>> +	cdns_pcie_writel(pcie, reg, value);
>> +
>>   	if (ep->quirk_disable_flr) {
>>   		for (epf = 0; epf < max_epfs; epf++) {
>>   			if (!(epc->function_num_map & BIT(epf)))
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 190786e47df9..68c4c7878111 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -130,6 +130,12 @@
>>   #define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
>>   #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>>   
>> +/*
>> + * Endpoint PF Registers
>> + */
>> +#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
>> +#define CDNS_PCIE_ARI_CAP_NFN_MASK	GENMASK(15, 8)
>> +
>>   /*
>>    * Root Port Registers (PCI configuration space for the root port function)
>>    */
> 
> 
> 
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> FYI, there seems to be a duplicate patch [1], you may want to clarify
> which one to look at
> 
> 
> [1] https://lore.kernel.org/all/20230316065455.191785-1-a-verma1@ti.com/
Please consider this one.

Thanks,
Achal Verma
> 
