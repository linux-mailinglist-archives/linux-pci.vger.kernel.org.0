Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DC3A0BD5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 07:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhFIF2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 01:28:51 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:18077
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231443AbhFIF2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 01:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM7Y8CTGudCw+/TkK4RIcceqdpaUoIqCvej3emoBGPf0xEa3qcma2aRUEJlQEny7re/gqtARDHELrSKD3gcDXshq5x1kH/N6F/kahEuD1N2+CByUYuLY2D7y0cVWUKaFvOXC1OUWzStvo7QEw2XB/UR+yxd7f17C5DS0mIRM5W5HRH9HLtPAPGyoaqhoTfujhhajq4oNrLDR4wGLd7wUZjIJW/wq9VZIQO8nlFmGMveMzufN+7K2/Bolfo/uhK6ZzWaEZ68ipFIgV2rQcTa0HnpG7q32e3guMxQS0HYk65ksz2i4YPbebznXDXCQ+OF3mDjdwBh3YwN6Hn/+Qd2tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaFH3bs1ws0RD1+tG34yLMQGyFHeH9J0Bjv9Mlo8NVk=;
 b=RhkM+U3EbiHk2BwdHVZV/qaxGQPXarysQxWmhcfyOSMLt+udiHQJYh4A8/IXBZ+dgoH7JC+k0f1ZoqQJq1MRKJEpRWuXnzUftEe6YVTbKEUxky7IswsqbC0UXdHjJeOmFwaGNsDr8KwZJSKAa2UR9jEGgFFh6ZDX24yq9DoV+YjUF+w1G5b11ThHUptBw3JczIshOUc9aHJqj+dOXZOSoh2gliww+ZSI4xUvVFxy0nlK3INW9IX1yPybatLrrjuKMIOLU5SO5MNjUQQiv3hAwpjFkWsMkFnWUJBEib0X0wBpKS6OrkWhsmgcwWqhrqOjiyUUUDuvuOfzc1osLKeqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaFH3bs1ws0RD1+tG34yLMQGyFHeH9J0Bjv9Mlo8NVk=;
 b=n3E1WE7AeFYWEtSC3r0zrfMba3FQCE1mWNpldAXH8CWc5nhPpOT3gvQKHRmMCseEXBwACmieMhdoghVjNtqPCeVic8LsWj7ZCVtJSTZMpQ5M8FPNYqyvDN7c3lO+aLiUWsG0tbq6o1zjI5g4/k1kLn2O2kceKl1gsJpHzKqBSE5GR/rJYGMAo0sJe3kv0ezIvHzhhD8gSL7NWITX2bHDcxzqd6RTYD/QFynyYGtF1RcitfHP/w3ExQM8yc/9AMSfdDGhQAWUzd2JGcIk1XiRZkwq7AxtbwBwzYojSI/zySnseld7TG24XI2wOMCuR0w8Kvw6Gt5n5pfwp9JN2IYE5Q==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 05:26:54 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c0) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 05:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Wed, 9 Jun 2021 05:26:54 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 05:26:51 +0000
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
 <DM5PR12MB18351813A8F94B0D18E6B505DA379@DM5PR12MB1835.namprd12.prod.outlook.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d142b6be-f006-1edf-8780-da72ff4f20e3@nvidia.com>
Date:   Wed, 9 Jun 2021 10:56:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB18351813A8F94B0D18E6B505DA379@DM5PR12MB1835.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc6f78ba-5d24-47fb-d24a-08d92b07314a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3964B2BE8233CF00B3108683B8369@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfUdEGTDyK7SjP9PAgr6fSqnGFS5WfN/s1IONOASvi5cCLAcnzcgREBcfpBBrhdr8Xj5Bjs3BHhcquHhiyte3mSNNSwgR4EoTSqcGeJlQYmJjFfIsfEQq4qrir16SQAPfXyo34fZBrNDfhQjF7i4jmyNeeA1SzNIuEiko0Gr1nb3xlV1T7JSKfI6dCo6SQ6z8JXHBspugkeTf9FBG5yvZq9WRDzlYx46HcI1pgiBmLQyrvk51OY3TSg4BH55HQSIHPdDxH58AIcLQu8+FXy6w65nlTqsb+ERwPFdemIybLLQe6vuOrlrIrhINngWrnGNA4NIEBvUbzVzI06Wz/4qAW7lSqIp+meUN1NnFDGhRaS7HmYNJ5ZEQJaEAjMOTg3TUiF2PFEyX6MirD1h1HfaVmFLo6O8A2vLwJOTEx4k+t2koA3Ko8GxX42Ae5nXXlzdcP+CJxR7nvMJvgORWcGw0gDSC5BWC6u1RdrUQqJi/C4yBH4RRA/B7UIqOcZh7gHyWYdCIkcEqDISD/VAj36oPCkmGPM/8Ia2i9zrGKJ45Fb022Jh58Fyzxm4/84ad+qchL8ClEyB4Qc7WujrslDM/aw3LtPKEYrRWUka2aCpTUuk4Q3DE+8vZ0PLcf/57XdKDAZGOYjesXzeKdZ4+KhzjlFWE7PBEattig8m/jsyNrXqMqafJYEdk3+MjYNy4cr1
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(36860700001)(8676002)(2906002)(186003)(426003)(26005)(86362001)(7636003)(53546011)(70586007)(478600001)(8936002)(2616005)(70206006)(36756003)(336012)(16526019)(82740400003)(16576012)(54906003)(5660300002)(4326008)(316002)(36906005)(47076005)(356005)(31696002)(31686004)(110136005)(82310400003)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:26:54.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6f78ba-5d24-47fb-d24a-08d92b07314a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2021 2:47 AM, Gustavo Pimentel wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya,
> 
> The pcie-designware-plat.c is the driver for the Synopsys PCIe RC IP
> prototype.
Thanks for the info Gustavo.
But, I don't see any DT file having only "snps,dw-pcie" compatibility 
string. All the DT files that have "snps,dw-pci" compatibility string 
also have their platform specific compatibility string and their 
respective host controller drivers. Also, it is the platform specific 
compatibility string that is used for binding purpose with their 
respective drivers and not the "snps,dw-pcie". So, wondering when will 
pcie-designware-plat.c be used as there is not DT file which has only 
"snps,dw-pcie" as the compatibility string.

- Vidya Sagar
> 
> -Gustavo
> 
> On Tue, Jun 8, 2021 at 20:22:37, Vidya Sagar <vidyas@nvidia.com> wrote:
> 
>> Hi,
>> I would like to know what is the use of pcie-designware-plat.c file.
>> This looks like a skeleton file and can't really work with any specific
>> hardware as such.
>> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT
>> is enabled in a system where a Synopsys DesignWare IP based PCIe
>> controller is present and its configuration is enabled (Ex:- Tegra194
>> system with CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen
>> that the probe of pcie-designware-plat.c called first (because all DWC
>> based PCIe controller nodes have "snps,dw-pcie" compatibility string)
>> and can crash the system.
>> One solution to this issue is to remove the "snps,dw-pcie" from the
>> compatibility string (as was done through the commit f9f711efd441
>> ("arm64: tegra: Fix Tegra194 PCIe compatible string") but it seems like
>> a localized fix for Tegra194 where the issue potentially is global, as
>> in, the crash can happen on any platform.
>> So, wondering if the config option CONFIG_PCIE_DW_PLAT can be removed
>> altogether for pcie-designware-plat.c?
>>
>> Thanks,
>> Vidya Sagar
> 
> 
