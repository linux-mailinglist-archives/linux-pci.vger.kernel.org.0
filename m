Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F193392E47
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhE0Mva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:51:30 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:10945
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234392AbhE0Mv3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 08:51:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5kNynVvV5OvclH0Hxy8lpvhDT/ne0AWBaQelTY2EzF6z1aQxPfaZeuyqcOcea2NzRDihtV/4bVpqP7hRmod1SeZmjNAaPohXLwsJ/QFFIUAac3qQZBGPj8QPe3ajsvdAGqLkCFaFdmZ8Xm8AhkGaObiWJJzGtM1niYNhCkzDtj+UrLfT0HK26SA5Ici70TieLJQ/IG92mNRm1GgnvqEX5VQosrpVAE0Nzdvywut6PjYegseVrG7+5ChF1muLz18+hn0oLS0bHTz1nLKJX1RE9JxaRYNWtaRx3iVVDoZzveKMqQ6d027Tl46KZLyUYTFix33mE7ZZU4rlsPDTwmiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MznfnU5jTFIGxaCFbJXIJfhJADyQfZdS3cor7t+XG6A=;
 b=VokZhVXPL8EOKekC/nm0QtTLxlb9lXL7vHqK0tW7PD9e04q4r+7bt/wDd+MbDIXJZ0E9sjOmQq3iEIOZS26n6Hd4URTO8re8XzmVYHxsbD/guruI6wjylwEz6ihUp4STX0NDUwnyiVDJKLUn8DlqOh6245ETd0iicG3xY5C/8gbhhAcrqE1UzIep35sKoge34BNKh8k9LuxbwCszc9uhZHykmzpS6eKzp8yt3ZkHSlrlEg4AbpTQEoXzE5sZLz6FAlcNME3FwXfk4UqRjoGu5M1FzTWyFy5Xm1AmXLTI/5w2+PXR3OQ6bBjBtNPc239d0pyZb+fH5ov1Ky3vTYZGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MznfnU5jTFIGxaCFbJXIJfhJADyQfZdS3cor7t+XG6A=;
 b=eDGOzrixhnjdgNXaR8IWrFJRN1q9BQ2UQSjD55+JhGy6REh5mr4DaYE3JJ+4rkTaQ6CxmIaSKmReEIlewYf2IZRWYuznyLyF5BuUQqFy7AaImFDO+Ix+IrkDlMedoLnzOhSDYwq8Syz43xM/44LszxOfOdv/+4EQA6T6LIrlVA7h+hgisKTVdr+mG/r+H3dqR4AqL/O8QjJLwGqvXjeSp58i/H4aCvGNjw8bBP8k0GnHRbeFTOZ6eNh+MhMgUeQMO4qfiqSLSCIlvM3dkmYReSc/s+6I7p8sTqlwxLzCg1aXyfmfhXKpVPaA88DxiJi2heRAdIG9DKgjdBrgpBILGw==
Received: from BN6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:404:65::21)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 12:49:56 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::42) by BN6PR17CA0011.outlook.office365.com
 (2603:10b6:404:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 12:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 12:49:55 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 12:49:52 +0000
Subject: Re: [RESEND PATCH V1 0/5] Update pcie-tegra194 driver
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Om Prakash Singh <omp@nvidia.com>
CC:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527120015.GA213718@rocinante.localdomain>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f3a04232-8a2e-3231-6ce1-260b8400383a@nvidia.com>
Date:   Thu, 27 May 2021 13:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527120015.GA213718@rocinante.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b34c68-db0d-4905-3537-08d9210dedd7
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534D60E90DCAB88C36180C5D9239@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SV0GMhnk/o8HU608sonXm5uhk2xOcC3mNuEpnJIsK9nrCGMijz2ia/Vy6MTiu0+Ahtzx9Awp0bd0AUV6ufrX52pQJ8BeMGLwI4YJLY/mFcEejA0dT4NbRKUCnBBn6a1o0XYH26crwnVLW2/8XK266VSb5zVwhrxBTz6VhRXUg3jb+TBu/O07OqTefA6q8FPzBDxa8yQgD8QXVovYSGTVf0txcr2Wm5w5PQB9qNtJgaeo4Um1W13NaWUROJCRR/Ep20d/aplYPShNkzxGLjawYuoNuaBWK6eLIrUs29RBPSO6idOLAXBZQVsNs2yp3BffmJzr9LCzN8D9vg+0QUaoH5rDu6hA2wFjCrF0VjMXDTBQ/0jVJkzZdnw4ZiX/CaKXNNUUPGFpeHcfhmSmYfptysOJ/IGPQEjJWabcg7ZRlwGglaM++WEpxZ5MwDVOWMV0M+93Hc525fDbPqN2bW4XsJZs8eXNZZbWzlJdkpIuJpHZKQMl6DiF6qBjNu8WKA9thWNEWSrkebA+ovbiKPutv1JsEN50qrliFOoI85JEbMWp3FE04qmuQ4xk/DkOymLC/gVstQW0GsI6NVy7dEzuNqYJyuQPRiHXs2YUn5jn+XGtVfedAOWZKG9oizIbBdxxcNEtv2vN9uryFYWqymufIY2eeoi4ynJ9vVDxzzAimCNDHCcnhcy75ahfA5MC5bHW
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(15650500001)(4326008)(82740400003)(2906002)(356005)(107886003)(82310400003)(83380400001)(8936002)(5660300002)(7636003)(66574015)(36756003)(186003)(426003)(36906005)(31696002)(16576012)(16526019)(478600001)(54906003)(86362001)(2616005)(110136005)(4744005)(8676002)(36860700001)(316002)(70586007)(336012)(31686004)(6636002)(53546011)(47076005)(26005)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 12:49:55.6052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b34c68-db0d-4905-3537-08d9210dedd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 27/05/2021 13:00, Krzysztof Wilczyński wrote:
> Hi Prakash,
> 
> Thank you for sending the patches over!
> 
>> Update pcie-tegra194 driver with bug fixing and cleanup
>>
>> Om Prakash Singh (5):
>>   PCI: tegra: Fix handling BME_CHGED event
>>   PCI: tegra: Fix MSI-X programming
>>   PCI: tegra: Disable interrupts before entering L2
>>   PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>>   PCI: tegra: Cleanup unused code
>>
>>  drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
>>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> Why the resend?  I saw you send this series before, and now you are
> resending it?  Help me understand what is going on here.


I suggested resending it because the initial version had two cover
letters and two copies of the same patch. It took me a minute to figure
out what was what. So just ignore the first series.

Jon

-- 
nvpublic
