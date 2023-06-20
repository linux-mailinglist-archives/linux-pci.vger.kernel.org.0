Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0297B7377B5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjFTW5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFTW5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 18:57:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3B10FB;
        Tue, 20 Jun 2023 15:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0qdi5iXEMnBJeSNa+Qjjn4lm+oNd4ZcK1h/03JRG87hLJecwf2Opz9yBNQHBnPUqaXOZgrYNW7MBOhzqrCOC4/xJFlDY8df8kCwqMaTBr7PIpoxfjIt9V7nWh2+z0R8u6QFOl/zLqnMCLAEOu4P/YHLaEFVK+Og2/MqmBtXGLCG8rNfmWaXna5/OGsAhYfC1ePgwRBR/9EzmZINUaeJKAA3qjgdY0VtDWxxbxMgseS4vmd9/gmPvHz4C+XzDrfZDom5AQnI7O19xJtVdFTOLulUK1pJBvVhwiq45P+e0onw4Tv5nGnprwJRcmlhwObte6qGfLoHFROJDJdLaEdEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdYxMdatLT6GzExFXa9Uqm900fvCHleV80O9bpIR1T4=;
 b=IhE+QgFRtskSmWdsF2H1KQNlEZYHxFQQY0Hz+DOvTfqjbRZtWgQx8R/wi4yFahblEFdTXh5vn8gjVIsCG7Ac5j4eQL0nriYi+8jR7MsNaFcfrG6L8qGAyYL/Q4Uqxl1XYZPl3su5WJB19eTb+A6f846mZhRaeiGf6lgSwsDX5PqZfXSgmao65y5YPhyjLLD3IwrfDTrB6Q/El7nLn0PZp+e4Tl1hQC4Gx/oTm1ptRWrjoxgiDpG0xkn6m3Db7BeLpAosMVW06sr95Y7/zFUM6yppGxslIrWb5Wxlxw2jPfHC/HtY05C0bTSgiP2DDauy6A+Bv0bKvMGquQLzxj7IuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdYxMdatLT6GzExFXa9Uqm900fvCHleV80O9bpIR1T4=;
 b=yaKGp34eeXh01NxI2umXiCxI0zni0gZhZF1ikfRnujvMWCLw/3hqU5rH8aKss1ret2EXRNOHngLOGNxeuDGjoOc/ZqurNo1SBkiAVaXHehawDC9w6ARLczeTquR2josbc9kBeIWFR+9QE6bKh9N4wdSQPklYffCCMymly+r4RDY=
Received: from SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 22:57:40 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::8d) by SA0PR11CA0207.outlook.office365.com
 (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 22:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 22:57:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 17:57:38 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 20 Jun 2023 17:57:37 -0500
Message-ID: <836d998d-25db-7118-a08c-1b69f95254e1@amd.com>
Date:   Tue, 20 Jun 2023 15:57:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 4/6] PCI: Add ranges property for pci endpoint
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
 <1686847842-33780-5-git-send-email-lizhi.hou@amd.com>
 <20230620220031.GA384833-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230620220031.GA384833-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: f907383f-47c3-4f87-92de-08db71e1bf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Z0qPX3KyvLQ3bOB8iTbgTIUbNL6K37IzJjInm4AMsoYbFUPkwvbQosQJPhyFsplEQpalPpYWlBKQq7dmHZ2jfoj3f5L3qNuCAIzqX/bBO6TEVNtmBN73QwqisL8QkCqGibxYApmqLGICqOA0quGkmpqkG0B1xGNanQ7Nl6kKVhXquYI0rDMHuSuWIX9Kyn0Ag+yUU1swRyiEMSL1j7tNeE0Yem3jBW6N6a2Vt2RhXB7A5coahdxV8PSMIT682JSH6kIFyICZUsWel5dt/4fK5E7M/ksQ3W4PKBq2zXbxgcHrw1DJgXpTcrNYfGIkM1avrThGKjzTwBnzv6S0ps3gzWKIj9MoDMZSpDLDKQYuQixYrCNscfukEgnftfbNb7xDkHG/xlY4Jj01R+dXQgpEVcbKhzKISTzzV+//c4jfTsAWgUlTJYIcRTQgx09wrsL2GhCxbbhpHfMukPt8tL0AXYML+lO8Fq+aAiT7kAoVplvXpy+kRo0qrXUuKTPYkJslKIe9b/qwOzNNn6pt3x0bIuzAu9GlwFUsQd4nS8QqyskdQa5winmAzGY6vApWeSGbUK7AKvMHDwO7opEWjcFpitKr4aHU5O0/CVMlobklhfLV3UsCY8tWKSuFumSfJfDJulEL6TjVzHEgq8xqY+nSr0E76oQ4JS6p/BDPOCTdOY00Awob0HMNRqYPY9qPeAQaGMIgU4F557NsUSdiGhnAjDU+zw2Z03oEUvjHiLTl+m9Om0xEx9gu537dBTYPxxDPeAI9uFHP0ijz2hFRhyGfGbaV3GdGoQrYxQoew9jm5rW0GiwZePeWP7yegQtaKG5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(31696002)(478600001)(40480700001)(2906002)(40460700003)(81166007)(16576012)(2616005)(356005)(47076005)(426003)(86362001)(336012)(54906003)(36756003)(186003)(26005)(8676002)(53546011)(70586007)(70206006)(8936002)(82310400005)(5660300002)(4326008)(82740400003)(44832011)(316002)(36860700001)(6916009)(31686004)(83380400001)(41300700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 22:57:39.7345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f907383f-47c3-4f87-92de-08db71e1bf87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/20/23 15:00, Rob Herring wrote:
> On Thu, Jun 15, 2023 at 09:50:40AM -0700, Lizhi Hou wrote:
>> For PCI endpoint defined quirks to generate device tree node, it requires
>> 'ranges' property to translate iomem addresses for its downstream devices.
> I'm not following why this patch is separate from patch 2 nor how patch
> 3 would function without it.
Ok. I will merge this with patch 2.
>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/pci/of_property.c | 33 ++++++++++++++++++++++-----------
>>   drivers/pci/quirks.c      |  1 +
>>   2 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index bdd756c8d7de..08654740f314 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
>> @@ -84,15 +84,22 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>>   	struct of_pci_range *rp;
>>   	struct resource *res;
>>   	int i = 0, j, ret;
>> +	u32 flags, num;
>>   	u64 val64;
>> -	u32 flags;
>>   
>> -	rp = kcalloc(PCI_BRIDGE_RESOURCE_NUM, sizeof(*rp), GFP_KERNEL);
>> +	if (pci_is_bridge(pdev)) {
>> +		num = PCI_BRIDGE_RESOURCE_NUM;
>> +		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> +	} else {
>> +		num = PCI_STD_NUM_BARS;
>> +		res = &pdev->resource[PCI_STD_RESOURCES];
>> +	}
>> +
>> +	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
>>   	if (!rp)
>>   		return -ENOMEM;
>>   
>> -	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> -	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
>> +	for (j = 0; j < num; j++) {
>>   		if (!resource_size(&res[j]))
>>   			continue;
>>   
>> @@ -102,8 +109,12 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>>   		val64 = res[j].start;
>>   		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>>   				   false);
>> -		memcpy(rp[i].child_addr, rp[i].parent_addr,
>> -		       sizeof(rp[i].child_addr));
>> +		if (pci_is_bridge(pdev)) {
>> +			memcpy(rp[i].child_addr, rp[i].parent_addr,
>> +			       sizeof(rp[i].child_addr));
>> +		} else {
>> +			rp[i].child_addr[0] = j;
> A comment that child address lower 64-bits is always 0x0 would be
> helpful here.

Sure, I will add a comment.


Thanks,

Lizhi

>
>> +		}
>>   
>>   		val64 = resource_size(&res[j]);
>>   		rp[i].size[0] = upper_32_bits(val64);
>> @@ -161,13 +172,13 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>>   	if (pci_is_bridge(pdev)) {
>>   		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
>>   						    "pci");
>> -		ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
>> -						 OF_PCI_ADDRESS_CELLS);
>> -		ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
>> -						 OF_PCI_SIZE_CELLS);
>> -		ret |= of_pci_prop_ranges(pdev, ocs, np);
>>   	}
>>   
>> +	ret |= of_pci_prop_ranges(pdev, ocs, np);
>> +	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
>> +					 OF_PCI_ADDRESS_CELLS);
>> +	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
>> +					 OF_PCI_SIZE_CELLS);
>>   	ret |= of_pci_prop_reg(pdev, ocs, np);
>>   	ret |= of_pci_prop_compatible(pdev, ocs, np);
>>   
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index c8f3acea752d..51945b631628 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6052,3 +6052,4 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>    */
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> -- 
>> 2.34.1
>>
