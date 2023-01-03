Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B965C654
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 19:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjACSea (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 13:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjACSe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 13:34:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011AD2E6;
        Tue,  3 Jan 2023 10:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4cTdNoLLAYA87lcnEtYDtm/BY63xfqgFhzL37Ev6w1dpgFbkhmlwKibxPIAU/PJcCZqqRCouobO0/avdpR63Bh8Y9pg0YAcRySjg6BxeSap4G/vNWJ2dB9TH0AX5uf815bfsXxBD2f0xq3aR1UjgCj9BRgAIemiJKlsfWKGNaw+SpY46UE6/00ycsnvecKrqPMdG2AksCLKqnW9JkI4TVBSZ9kLsq6tFChUjcZieM5U3GxRJ93aweDcoLaxcBYS7R3XW59zQELytJE4kP98Bg6QnOC9vaV/nPuHpZUC27K775aIE1e7kRp8PbT/4EjFtu5a9zIvxQDe8jIYXRmYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XD6y/5bUrCcLgA90cFAWrX47gNQS8pTuNJxxOsffCg=;
 b=PNw0IBoW5HlT3Q7vrkWQ9G/8Dk83co27UypxCdGSzlHbL339/5AiY91/nqd6sVc+Ui6QPqSU9VJy/Le7hchK6Jp2IpM1DuDA2+YRYz34alRmMaRepowjbV/rYnDLk+l0Dh4MMtQRI7V4C0ufN+ZmFsgGFmIYEpc5hjjamN0/T3Mx8wBm1F6L9em0Lf4pJxGq5RN3gKQdoT6heHJ11alorZMXAiA5YWYvhJpzSoUhNKUjMUPQ+B0fPdriXhCf5nEKT6SZNStwTQgW9jSxVWvzUxXnNXRUZ971WK1HkYMCFhI7V458HUNYEQZPR42HaFLXlpWg5y68bRUS6F1F3nHnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XD6y/5bUrCcLgA90cFAWrX47gNQS8pTuNJxxOsffCg=;
 b=aS0mV1zPmcSgccx6TT433WZwUYD4IVtLPzy99K/jaCfkWqXakGQ4YE2YFxCi2MLyzTct5TCavuRCIBnYTNZQtiZdbFE6r2ephFbzH03ORrd5EPth2L8FLz/ihI86kCsYQgHF/NfFvTY7VToF19sZRg+vasug9c/vVjF4YfkGuUA=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:34:23 +0000
Received: from CY4PEPF0000C967.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::4a) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.3 via Frontend
 Transport; Tue, 3 Jan 2023 18:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C967.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 18:34:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 12:34:20 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Jan 2023 12:34:19 -0600
Message-ID: <f8d5d5a9-6d3c-8b1d-797b-a96c3580dc61@amd.com>
Date:   Tue, 3 Jan 2023 10:34:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 1/3] of: dynamic: Add interfaces for creating device
 node dynamically
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-2-git-send-email-lizhi.hou@amd.com>
 <20230102145046.3e1d009e@fixe.home>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230102145046.3e1d009e@fixe.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C967:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0fbcbe-7f98-420a-dbab-08daedb9226f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +T7/yfJJsAG/KdhTJTT5c5Hac7EGCO2OXrisQe8gdKDQ9h1Cc5NX1xfx5fmKhlUr7nb4EmTrL5BWpEoietuSAA0/eEnsS0h7+o9ixsBTNuTa2vaTvj6eoNmuEEJ/WvXIG14FdjFQufSmUGD048GP7VbNJFgGqF7g/W20Z6/I4LLsCu4T+u103/WUoJUljuBfkKYs/T3EncjcYDGoqE8TWAs8WUmj7/92QfAEdNarcJrdygFesnhWGnEC3gtFSEsSrIhsDyiZIV1hs6d8gfKLraFlDOI73XZkjk9AZge2ZA2E2xjSFWGHsZfnAw4G1mz/FxIs62NMrUYKN2UvaeqDXA1uQaFMNTHmX/zMrpGMeu02hTCgNychc2+EkbkPJVBffkdaIuF8BljHdkz0zaGRXwTfRd8Y21S9w4erDHFIfTT58VWFv0kHjhfapPs1vQGktdv9OWD0Gk6DtokRw4HasSjMz7BYXR9p7rG50mkIkzc8rYIUY8OqaBJF8moy58IaF8MdFirlWToLrhZwdWTFKnqLnoBwKyg3NA9+Ey8ANBBm5TdyoV7xJ3bSNYR/JDRHMHoBgvYOAD4avZ0JpTxSIYzG67qoSiYlQoNXEAxoKG8rNpUo5j0GY++fw5a+OEoLvnyHnotwwIqZ/aJu5/JHGFW8A0L8UgrlscEDyDY9yUXcSDws93KDhbqwUQ8fqtYtX3OIQLi4Vq7qCsEw1xKbq296yYM9vZ/Hzso+/GzxoQ1VZ0L46VxfIF2R2FYQSBwjIU5W3pHyj39LWNLZHqfNiyBlWQFj64rMV6ZHBCTSQbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(66574015)(36860700001)(47076005)(426003)(86362001)(31696002)(82740400003)(356005)(81166007)(44832011)(2906002)(8936002)(41300700001)(5660300002)(7416002)(40460700003)(53546011)(82310400005)(4326008)(40480700001)(2616005)(186003)(316002)(26005)(336012)(478600001)(8676002)(16576012)(6916009)(70586007)(54906003)(70206006)(31686004)(36756003)(22166006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:34:22.7741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0fbcbe-7f98-420a-dbab-08daedb9226f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C967.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/2/23 05:50, Clément Léger wrote:
> Le Thu, 15 Dec 2022 09:30:44 -0800,
> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>
>> of_create_node() creates device node dynamically. The parent device node
>> and full name are required for creating the node. It optionally creates
>> an OF changeset and attaches the newly created node to the changeset. The
>> device node pointer and the changeset pointer can be used to add
>> properties to the device node and apply the node to the base tree.
>>
>> of_destroy_node() frees the device node created by of_create_node(). If
>> an OF changeset was also created for this node, it will destroy the
>> changeset before freeing the device node.
>>
>> Expand of_changeset APIs to handle specific types of properties.
>>      of_changeset_add_prop_string()
>>      of_changeset_add_prop_string_array()
>>      of_changeset_add_prop_u32_array()
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Reviewed-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   drivers/of/dynamic.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h   |  24 ++++++
>>   2 files changed, 221 insertions(+)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index cd3821a6444f..067d996a9f79 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -461,6 +461,71 @@ struct device_node *__of_node_dup(const struct device_node *np,
>>   	return NULL;
>>   }
>>   
>> +/**
>> + * of_create_node - Dynamically create a device node
>> + *
>> + * @parent: Pointer to parent device node
>> + * @full_name: Node full name
>> + * @cset: Pointer to returning changeset
>> + *
>> + * Return: Pointer to the created device node or NULL in case of an error.
>> + */
>> +struct device_node *of_create_node(struct device_node *parent,
>> +				   const char *full_name,
>> +				   struct of_changeset **cset)
>> +{
>> +	struct of_changeset *ocs;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	np = __of_node_dup(NULL, full_name);
>> +	if (!np)
>> +		return NULL;
>> +	np->parent = parent;
>> +
>> +	if (!cset)
>> +		return np;
>> +
>> +	ocs = kmalloc(sizeof(*cset), GFP_KERNEL);
> I started to test this series and this sizeof(*cset) is probably wrong,
> it should be sizeof(*ocs) or it will yield the size of a struct
> of_changeset pointer and not the struct of_changeset itself.

I will fix this. Thanks.

Lizhi

>
