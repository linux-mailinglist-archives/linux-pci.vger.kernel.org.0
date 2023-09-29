Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA97B380F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2Qkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjI2Qkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 12:40:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D0A1B0;
        Fri, 29 Sep 2023 09:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFqvE556XZ8pVQnRKWlWjgEw4tKA0uSnDc3c7TLGnQZedk7CqOCD0s2SRt6lwhC6rZeRatkJPACBkHZ5U5G4szsPOTRHyDJBXdbe96W8reAAP2BwtASiUOa0DBxCGROfOLidhWUbNiiCeEyKoqUU4gOXP1XBxiUpvXg99uo0GKrnlek2M2mRaNksMrImGjjQCbx7smAnVLMlFlsTUPJrRuGH+6Bv/07JcWGcwuDx4Re+bKqShEpKWj2VYfhGOvasjBOk6QhxvMoQGXN5MrBTEJc2avY+J8DjuyTOaZUPj5Rj/9AqqL+UnuiYdRSoVz4pTyM653SXmIUrEkEpRJ/JjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUFLMqqKnEnl9tRot53y7/PnTOYv5IJgHfV2/HASwmY=;
 b=JelWfJ6tunHE0zB2snYNt18vuoUmoXuM5NVProrDzeHIQ0+vN2A/Uqcbg4BB63KonKGHrBDOL4ejJXzaBgVVbnr0Nu1K5ili9ow1NAf1+clwp3jpcP6JloE5a1VuW3P7RSw7IObZgKo8+tTOzzcR5no9/jsR7W7xSxYes2dzq7TVraL2lhpE/ft7ixuxVk2U7wK53sDMuk95bZrj8bl1BOInMO48gfGkawALE1chnwj4dDdukGSscIF+84O6H7MYk3kuIUv4YWkWNVjnP6MK3tVz9xueJiM0/vS2zsOs2dAPe0Nnglee+JGVAIdEvUXIDAs6QAjTiNBlonMg3M6nlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUFLMqqKnEnl9tRot53y7/PnTOYv5IJgHfV2/HASwmY=;
 b=gZRhdrtht1jxhDjlJcCeMqNsQ0vs5xzvDnJWohyNNqcG8gqHc1rOQtYkUYukzXmF/8rWr0GFGgzP5BUVMbIfZzZMLDEOCToGShscJH+Ex7pdFO1wXT+27ZZRqWFaL5OJzPYKLAnwFFmL30Vz5xmSR/Upsq8dOy/dAuBx8rSB17g=
Received: from CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 16:40:36 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:610:55:cafe::68) by CH2PR18CA0038.outlook.office365.com
 (2603:10b6:610:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Fri, 29 Sep 2023 16:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 29 Sep 2023 16:40:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 11:40:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 09:40:35 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 11:40:34 -0500
Message-ID: <cf831eb0-2f21-37eb-f9a3-66ba61aba1bb@amd.com>
Date:   Fri, 29 Sep 2023 09:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] PCI: of_property: Fix uninitialized variable when
 of_irq_parse_raw() failed
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@huawei.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <20230929162702.GA511467@bhelgaas>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230929162702.GA511467@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f71f03-a49d-477c-740b-08dbc10ace84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JINzkHOKSUJA/+b+7fnq+EiIqJa0ytG2K73kUcEmjWO3KKns4tO70Yu8OxPIxHyijssFBvDo0P/q6NVFPukK4prumUmnP06+pRx/AZi2MtGCM4zOhtBw30/PLw+A9bLLjobiLo79izkWN1b66k9BUZ+ziivAoijHrb3UUltp5c5iJiCPNAkpKhd1H3T2NNdrJB6lH8tXl9ATVgM8RarPjZ1wR9ehnp4u9dQXFuwmjkgmbPKVVSncbBSRtTTqUS4sv2I5+JzGrFYno89wRkXA4FDZxCWVeJxzb1kFWaLLq25ogTD5xw7/QD3Nm+6sc6d8by7gboz5iShgIIw3Hff8qkzhxDd6b/lkY+UDC9NzyZH6W6H5L5wdfDC+EFwjY9qv9ecOoWEbzwX7YmrVOp+lk26Opn16cwwhayq2CmwDP0s8IPCRI6QpdDnQT4pJcbDKWqpgyTom5MqxqxAImKfdxNxSPII2M8DXPEXYydroUbb0WIyI97HBFXMjX+/wrhyOC/K7kzMEGLQUFeYHhHaIi3dwLvg1prPVMtNJ8tW/s8gjLEJVO16hAYTjF1OhQNAgdMGt4vjQpMk124ldWk8Jl1fWp4wwCFA2wIbAf0egUwncDmL0a5IQtwiz5X8uZEps2N/BM3t8GVOIoLjcQn5/EQGI5BwVsaCnFxQn6cP8DfT3m3KLHwRy9qUASQR+LofV+TxX2tjyqrUUM1oCiv+9S0pCXQtFSmjJZJPNS/j7bYNakuWY6lkn5cwQvnrhMmdtmZMfzdbK6LIc0lsQqLtBgCNJFQoX/q6Kscy3hL5SptmeM02LHHcMbyiEUqWkYAnRKFskUIwuTZdaLGNep/l5Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(478600001)(44832011)(966005)(40460700003)(5660300002)(53546011)(81166007)(40480700001)(41300700001)(70586007)(70206006)(54906003)(16576012)(316002)(6916009)(4326008)(8936002)(8676002)(36756003)(86362001)(83380400001)(47076005)(426003)(336012)(31696002)(2906002)(36860700001)(31686004)(356005)(26005)(82740400003)(2616005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:40:36.0584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f71f03-a49d-477c-740b-08dbc10ace84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/29/23 09:27, Bjorn Helgaas wrote:
> On Thu, Sep 28, 2023 at 09:47:11AM -0700, Lizhi Hou wrote:
>> In function of_pci_prop_intr_map(), addr_sz[i] will be uninitialized if
>> of_irq_parse_raw() returns failure. Add addr_sz array initialization. And
>> when parsing irq failed, skip generating interrupt-map pair for the pin.
> Would you mind splitting this into two?  It sounds like it fixes two
> problems: (1) using uninitialized addr_sz[] and (2) skip generating
> interrupt-map pair.
Ok. I will split it into two patches and mark them 'v3'.
>
> There's also something going on with the pci_swizzle_interrupt_pin()
> change; maybe that should be a third patch so you can explain what's
> going on there?

It is all about to skip the pair which can not be parsed by 
of_irq_parse_raw().  pci_swizzle_interrupt_pin() is moved to the 
beginning of the loop to skip the non parsed pin.


Thanks,

Lizhi

>
> IIUC this is actually a *v2* (not a v1), since you posted it
> previously as
> https://lore.kernel.org/r/1694801287-17217-2-git-send-email-lizhi.hou@amd.com
> so the next round should be labeled v3.
>
>> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
>> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> Closes: https://lore.kernel.org/all/20230911154856.000076c3@Huawei.com/
>> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/pci/of_property.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index 710ec35ba4a1..c2c7334152bc 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
>> @@ -186,8 +186,8 @@ static int of_pci_prop_interrupts(struct pci_dev *pdev,
>>   static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>>   				struct device_node *np)
>>   {
>> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN] = { 0 }, map_sz = 0;
>>   	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
>> -	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
>>   	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
>>   	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
>>   	struct device_node *pnode;
>> @@ -213,33 +213,44 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>>   		out_irq[i].args[0] = pin;
>>   		ret = of_irq_parse_raw(laddr, &out_irq[i]);
>>   		if (ret) {
>> -			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
>> +			out_irq[i].np = NULL;
>> +			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
>>   			continue;
>>   		}
>> -		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
>> -					   &addr_sz[i]);
>> -		if (ret)
>> -			addr_sz[i] = 0;
>> +		of_property_read_u32(out_irq[i].np, "#address-cells",
>> +				     &addr_sz[i]);
>>   	}
>>   
>>   	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>>   		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>>   			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>> +			if (!out_irq[i].np)
>> +				continue;
>>   			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Parsing interrupt failed for all pins. In this case, it does not
>> +	 * need to generate interrupt-map property.
>> +	 */
>> +	if (!map_sz)
>> +		return 0;
>> +
>>   	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
>>   	mapp = int_map;
>>   
>>   	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>>   		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>> +			if (!out_irq[i].np)
>> +				continue;
>> +
>>   			*mapp = (child->bus->number << 16) |
>>   				(child->devfn << 8);
>>   			mapp += OF_PCI_ADDRESS_CELLS;
>>   			*mapp = pin;
>>   			mapp++;
>> -			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>>   			*mapp = out_irq[i].np->phandle;
>>   			mapp++;
>>   			if (addr_sz[i]) {
>> -- 
>> 2.34.1
>>
