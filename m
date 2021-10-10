Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AA428012
	for <lists+linux-pci@lfdr.de>; Sun, 10 Oct 2021 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJJIjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Oct 2021 04:39:04 -0400
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:36078
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230254AbhJJIjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 10 Oct 2021 04:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvLv6s0ZEMK1uUt2pIzeUg+gPsQzC6+HMK5btEGqkKX2i/EJSqa0CjlK4/ZVR8Ed2Bz8wHEykcBF+reX8dgYDeSJ9fZ7CLzG40a0LpXA4UaIM8w3080+ky36EHtVY2eteovE6Yl8pXx/h2SrV10qvOat37HcMcDfdTe9O6vZUaS8W3F+6Q4Mh54rT72eEAPOT91CtJZjPJ7lnQjKIbJwiI3Un0yV7fSw4THg4F13iFExL4Xa4/dm49IjpUc1TvkilxTJWL57Z9Vb1Jczm1m5YQTdabGvycXlbnUXOq5cYC3ksf6SBgE9hNoXN3s833TPU7ThcKyv6hJmEQ81sRsHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/0DoH+Dpp3/L6SeUjH1l0wx54wHhnmxZ+t/hkqaf/I=;
 b=CMIcuQi9B9yl67mlysHcA02hzBcB2u5ZMx9NmvNMBYfM6kTW2IbJPHJUZj++fBuQ8+Sn49VlQfGHxEHAH2ZSScf7Kd8nkreRJ5OwuqEc4Py6kSfksEhN87dtHfZED29j5D7vvKTzz+WztKohUNL9Uah4YCKeWxuNCAA9vfUhJNZim/XVFZP7boEhrNiAuEuYnr3HR8k0Bjqpau52kg9JLXiyzeVp9niUDVVMd+oXoZQ8pUe965IP1LExyhHtaRdwLe3XU0DzTF0BDJxJJowY5ALMkassKx6YUVQePkIIJJGGvLG7Xyucge+CP6VMA93uSNuRqW9iuq+TgCnOni04jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/0DoH+Dpp3/L6SeUjH1l0wx54wHhnmxZ+t/hkqaf/I=;
 b=SrUi0T+rfmS6S831sOd+3DePNBg++RpGlsjMm8KT/ZNfGEiBBwVszFOe6WN5ZHB4CPNBSjUUcg9jwcDHSKoHepc7Ol93Xxq+H819Bp55pZU4JI7gfWzCNNEw7h1Wj2mA9utYP/QjwtMzQrIxInsdPQ/WHrLpl1VlgqDuZ0rKQiGkcSZEYfv0y+xcYc9PVJ+129LATz7Xwu5J/5gqum2NgC3QXAfsfBBej1/E8R5jMBgpagqhPv3K3vb+rwWJE6Q2j7A7/1A6R+JGWG8Yl7sn7fH+tMs6vS5AZ5HBifml9zk8/dOcXUxI9cBMzS7FOb7g9SzMoPChk6XkzvQvkd2OyA==
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Sun, 10 Oct
 2021 08:37:02 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::4c) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Sun, 10 Oct 2021 08:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4587.18 via Frontend Transport; Sun, 10 Oct 2021 08:37:00 +0000
Received: from [172.27.13.3] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 10 Oct
 2021 08:36:57 +0000
Subject: Re: [PATCH v3 2/2] PCI/sysfs: use NUMA_NO_NODE macro
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <stefanha@redhat.com>, <oren@nvidia.com>, <kw@linux.com>
References: <20211008222550.GA1385680@bhelgaas>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <a947cd7e-c847-4d44-5a65-51bbdceb1a1d@nvidia.com>
Date:   Sun, 10 Oct 2021 11:36:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008222550.GA1385680@bhelgaas>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f34661-50e9-4f82-2c92-08d98bc92139
X-MS-TrafficTypeDiagnostic: DM5PR12MB1835:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1835B1EDA8EA58FF890848EFDEB49@DM5PR12MB1835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fAUL0K+BCMnA6PsgZHLwos7Ga1X7uEMEhwNk0E8fwg34flKPrZY4qBqaUQ1QMZfKG1GLe7iABb1M0bM0bm1JXQKBgKSilOGGHvHH6PzJzxwv1+2+32SrC0BnZsqcSWnAP0tRot7fsKK5tglcgAri1YXmb5Qj+zSTPpFgovK0qJfYJN3RMkQcw/5X0ZSPoxhSehm7Aczo2mLpYKMvZx3GF+j7JzjdMnPyJdTM3ApJone/X8vVJZ9rrZKWqv26Fi3otIbJC4I9y9nK2P23jTJz+Nkpii9hU13gfA2vGSQHfDoKDVxIM1u1QJZAlZRlidTX5U/SuMSJpPlvaUoL+6YLqHtoKRg313/8VjXBW4m9zeMDZY4OvvT1GsYB0eAxIWu0aHFMYSEq1y4QWbGi4/RyYQIeFF9Q01SZZgOLpjnxsh+7vF8TXxNQwDY9Q4NdCX7Ilr7LlL4twzP+xN5uu+JVG1C9ne6yfmZMp1ciDcd7bzgIza8rGE58PtnlTr6C2fwrb0B9bHTN3Y6d3ZFvIRIps2QVuJtdR3usroZsmU10uNnJHJtry+xKGobopiNWBM/AirsoMKsZKcQLvRv9mqs/8KcFmUhobz1tQCxFKcQP/Jxf93BKZrOaGA48oLOprMg8VOdMBCvXYFF5mmQygB6LcD5pbn3OJiWKj67jRgqysTrp4rCPXgUszHd6kQxu++9NpiOiNtTBaTg/aZaY70s3fudc0fk16YkaMe4kRchvDs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(356005)(508600001)(8936002)(36860700001)(5660300002)(6666004)(26005)(16526019)(47076005)(186003)(36756003)(83380400001)(2906002)(31696002)(16576012)(54906003)(70586007)(2616005)(7636003)(86362001)(53546011)(82310400003)(8676002)(336012)(426003)(110136005)(316002)(70206006)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2021 08:37:00.9921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f34661-50e9-4f82-2c92-08d98bc92139
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/9/2021 1:25 AM, Bjorn Helgaas wrote:
> On Mon, Oct 04, 2021 at 04:34:53PM +0300, Max Gurtovoy wrote:
>> Use the proper macro instead of hard-coded (-1) value.
>>
>> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
>> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> These two patches are independent, so I applied this patch only to
> pci/sysfs for v5.16, thanks!
>
> I assume Greg will take the drivers/base patch.

I saw both patches in his 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 
driver-core-next

So I guess there is no need for taking it separately, right Greg ?

>> ---
>>   drivers/pci/pci-sysfs.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 7fb5cd17cc98..f807b92afa6c 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -81,8 +81,10 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
>>   	const struct cpumask *mask;
>>   
>>   #ifdef CONFIG_NUMA
>> -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
>> -					  cpumask_of_node(dev_to_node(dev));
>> +	if (dev_to_node(dev) == NUMA_NO_NODE)
>> +		mask = cpu_online_mask;
>> +	else
>> +		mask = cpumask_of_node(dev_to_node(dev));
>>   #else
>>   	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
>>   #endif
>> -- 
>> 2.18.1
>>
