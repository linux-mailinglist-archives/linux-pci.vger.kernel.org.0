Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9041DCB3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbhI3Ox1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 10:53:27 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:24672
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351963AbhI3Ox1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 10:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdUW1Oy9nqs9HX3JWjRGqnCXCmd6UFq2Q+j3VL6bVOSXJex3pEPJ6L+mgvE1zNOy+Vs+0Lw1BqOmu/34h4xOV5GwllOjp2yqZxQuj9Pyl70sQN32hFtml09Ofxuq7JofW8kg6ToKf4wOQF4/prRpDf4BwfnjY929hpnmhAksoi8sXGWA25jk0ZR7K3jaIugnVxzsMTgsLWzpaPRyQjwEI2RMtBbaZp+5lXhjNfxIGBYSTf+/A2NSlOr2JFPGH/hj6UEtJBNFM3IJLF2so4ENGHsqE4aroXbQDL5rdJt6RukCA7NYh4Xiyt/fCA6Uwyko8OEjqDkiWY/nCY+lQ5Dzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=am5fSTe6wJIucHDJWfkvNzgj9Q3MynE4HIDt46P8kqY=;
 b=NZWXTge9SRE9j4TjfHevNK+RjUMk6da+8lEgSbjPIdtLbyhd9s9JD5wQ+CCjsvEc+fUZKc4sdV9m1fdpWOR0XGrdKqPkLtJW+SjkoNZq0gZ8JZtDylmCKJ5ybvqgDB2GICxGUXhlGCIaMDeijf4ADrIKxsXWBI7xzo0OlXGYqd9ko04slGDK6djwBW7X5wGG+eXrlLqczaTbZ5gZgw0MHM/45pdurqMkoQSWInbnEhfBtGaNtGqQ8w+uukCmeMDjFGhWCGKxQO8xc/2vhZORxMHKCaAH7D9ZLc7OZAlf5srfp1W7GSnTvaADfC/rkJv96VtefG9JdFhFRjvDCE83uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am5fSTe6wJIucHDJWfkvNzgj9Q3MynE4HIDt46P8kqY=;
 b=oCMp19xF9WBaHA/jZMdIt3wkKr3omVk9JUmAWMfiWa/TKChHgZZLilmpNziieQHfb811pkvsdciyzvrq+Jf/8EFE3z22zFUYucbWMXReBSpAgMPawBDcNhg3U8SXswrC7+EXDt1wLrlYR4h2dTiFfDKbTnfvLWZENEKLnUlh5wolI5GFYb8MpoUP6adKKHifpiNZbh9w2IgFQBChu4GCcZUVh225UyElXMsUYzcESmElm0aiEmOmndPaIQ+YgSSFIb2uzxY8BiPe4fjYKtW71SEAt37daCBCryr5Ky7qUFcvODSaJGhwPuUFMs4kwQ8gd63RJp1fcLolQ698P9NKaA==
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 14:51:43 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::8c) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Thu, 30 Sep 2021 14:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 14:51:42 +0000
Received: from [172.27.13.136] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 14:51:39 +0000
Subject: Re: [PATCH 1/1] driver core: use NUMA_NO_NODE during
 device_initialize
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <stefanha@redhat.com>,
        <oren@nvidia.com>, <linux-pci@vger.kernel.org>
References: <20210930142556.9999-1-mgurtovoy@nvidia.com>
 <YVXMifT1hdIci1cp@rocinante>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <edbc96e3-20de-d8f1-7b65-29f4c8e9408b@nvidia.com>
Date:   Thu, 30 Sep 2021 17:51:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVXMifT1hdIci1cp@rocinante>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac64dda-e88c-4da7-2203-08d98421d11f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511BB0F39FFDB058F68B89DDEAA9@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC2K40gFrrAOq4ttNTQpdNrqCeczQyDmWmgzRSpQh8UEWYidtp4jFYAOk6mLAj1qdkfjUtSoiNOor8ryTVkR0rfuuKgT4YffCPNb3HdjUvH0kBYADVBnnuq0O25GacrF5FumtOsDu3lzr0B1ZcVbNMvXK8INd6GFp9ttSXrDuHB/G+QdnJA4pz/CVozQD5Y6gzp2vScacvgvma6tn9Wd1+QsFdUjKGqfdpVvgNVyBL6LkIIZ2I2oq6c00qzzFGATVh72Zs6tNZ0n+osBwFbI/IRDiEfUZe48qNGmViqeKVVT0PKpvye/OL2bV+QJ4zqyFBxmWmuAqiraAcfIKNNBIOpCXwJICIJWDsE9j1s3TYfUm21t8Z/nHSysPclL60K+O918oORfpXPgBieCUAu8kY6gWapjNprqEDDYd45z7jnWAHefC8qfy+3rk0YqNKR467yJ6OTBqtxn4ACWdlLj+JhvZdA3Ge4sBOS1511aCJ3Zi3wHuy/f6ZsVFCliXptW+Us6wprqv4diokJYAs7bjd4RFVjqCv8+X8pk04cuh1nTqC+ZiBDV+XgL2nt+RR3BLp6xefjl/0Ib3UMWfOmh7Z0mU9XGnMFLWkBa6AlzcuHofTc4mcgqPR8FVTKCMsRQKKSm08y6SIHVGgYc2c8geqZmcvZu/O+TXlTIEQQbFhhH5+lWsQKr8pZKyylyJL17psezQ1zkfb/OZYCKuxgs7ShKVjNReiKg/yyT9iyi9UZylCDeq5wF9VVYL+tov8C7ayVkk0HvazKI6IWuS6Wy0AvPxqwnuQooj9hunqORwKmvG88z3A//3WggnGO8iEhW
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(6666004)(4326008)(47076005)(36860700001)(36756003)(53546011)(426003)(31686004)(31696002)(356005)(86362001)(8936002)(2616005)(8676002)(66574015)(83380400001)(6916009)(7636003)(5660300002)(54906003)(70206006)(508600001)(186003)(70586007)(2906002)(966005)(16526019)(16576012)(316002)(82310400003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:51:42.5182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac64dda-e88c-4da7-2203-08d98421d11f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/30/2021 5:41 PM, Krzysztof Wilczyński wrote:
> Hi Max,
>
>> Don't use (-1) constant for setting initial device node. Instead, use
>> the generic NUMA_NO_NODE definition to indicate that "no node id
>> specified".
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/base/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index e65dd803a453..2b4b46f6c676 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2838,7 +2838,7 @@ void device_initialize(struct device *dev)
>>   	spin_lock_init(&dev->devres_lock);
>>   	INIT_LIST_HEAD(&dev->devres_head);
>>   	device_pm_init(dev);
>> -	set_dev_node(dev, -1);
>> +	set_dev_node(dev, NUMA_NO_NODE);
> We might have one of these to fix in the PCI tree, as per:
>
>    https://elixir.bootlin.com/linux/v5.15-rc3/source/drivers/pci/pci-sysfs.c#L84
>
> Would this be of interest to you for a potential v2?

sure no problem. Lets get some reviews first and then I'll send v2 with 
this patch as well.


> 	Krzysztof
