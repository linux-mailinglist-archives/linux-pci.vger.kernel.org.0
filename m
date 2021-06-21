Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA553AE615
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFUJec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 05:34:32 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:61497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229597AbhFUJeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 05:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtM9fIchsN0/uO9pQEnF3S01UMWG/DnsAazKx0bJqlpOBn0llxV/qhGMD1xUYtz6imX8m/i1TEbvlarODoilkx0DKz1hfP+oj1y8eqKBIrJjj924rt22l04z9PiCO2MKAqXZZ1I6ComayozbcQsr6S+719HElQusG96sqkyB7jHhEBc3MGTDVpH/Unt7Sc1LnPRl8khtsQJjDZI3v3BlodfIYGqwYxJxGFPbKSa1iI1TidtOnu4N8NHE1DyHDakg5dogUXBh7NpqO71792sEVFIvl/azOa6UvyvscGtucOSZaHDAVyjgiOdYMDxi5lh8YmiXNt5x7RCCIkEB/znqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzIvKC/j5e5RN+JNSAQ5DnewpfLxEAHlZ9MBygMV56o=;
 b=bGgCbYGE75DLFnuWUh3i2FDnceovVriTfbNqn2b389GJ0cSbtA+4puy2Ap/2e2S8HC6u9j8UD6MOI7ah0iTg2LIFVocjKtPt8AqepD7mAcvFvUSnqWLuGUlccugDqexomCIHuEbjbKoBNhcspelq8td9V+0SMq+YJvpt0fdVMWHeyO1+hJPsPmhutkgSU8vFHrR+n4waiK0t1CdcN0XQwVYHIaATmNyRR4ODguE5tv1QRMggCM+t0he8TbBMELEKcz7XnVG09gRrFwJIJEIPuKQiMlPUPi0CcNsWWw3GQOjrhv9yYurpi7AaQtI9dWZKMQxOwxNFQ8DFGcfi84E/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzIvKC/j5e5RN+JNSAQ5DnewpfLxEAHlZ9MBygMV56o=;
 b=SR5NqV+Yp9G907h52u5yiehEkQrjLZJ7FJNMtLWoPhE980kEQ8GXJ5/QWFMayVisOYVyZpprd8gT3cfd8z6YmlibALWJDGYOxMnhJ45ybd5VDIWbkZsMpWf892WiOrNJJhcC8/xarV1iY41YYDiaROB2RYmpaXTRffoXlVv5SNeOjCNmq0t2deEboBQfoSzW74xg1PFnHFKBUQfbZyi5sU0rU6YHdC6jYgsO2V/4M7grqrc35ccfehV+BucBU5zBM4iU12vYpQOHxA8HBQxbsf7qEPsQ/UZWaKqGc+zDPgn+W5u+DHaRryry39rgsG3C3h5Hq8NlxVy+8DTqzEDNPQ==
Received: from BN6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:404:121::32)
 by CY4PR12MB1525.namprd12.prod.outlook.com (2603:10b6:910:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 09:32:16 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::a7) by BN6PR18CA0022.outlook.office365.com
 (2603:10b6:404:121::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 09:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 09:32:15 +0000
Received: from [10.40.204.223] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 09:32:11 +0000
Subject: Re: [PATCH V2 0/5] Update pcie-tegra194 driver
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <2fdb1d89-88d5-6895-ec20-0e2ce4cacb85@nvidia.com>
Date:   Mon, 21 Jun 2021 15:02:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8483d5-e28e-4350-f07e-08d934977526
X-MS-TrafficTypeDiagnostic: CY4PR12MB1525:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1525AC0AF536B2B708B4FF92DA0A9@CY4PR12MB1525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwvd+FEYSNHqQ44CJX+2LIeSrIQ1oFNqKv5sI6yDgguenM87OkFJj4KZkTHoHdgEmhZ2yyB/N0fzhbw7FuTyzgRbbJX7Io1CJbxrs9d/tKBqBRkQxiqOzMup2vS9EToKB06sXp0w3PNVT72Rb+xyfqFHgPV21mPgTFljr2rfKI6xsTlPwpwSofUBVYjpwUXiYp5bRdshMXxb29ZCldIy+wk5W/Bb9azmhpr4iHC8soRt9voQeab0Kqvl2zRIdh7Cd2ZXLY+d7dv3sJQAsKpsm9j12CyxAvxGrPRh5t8LKgtBJ5Ubx38wDwBCcMnhKLFdbs8Ma2JCf+i8jEXLYbRKZFB9pHBBbzzcVm5qjtr3L1UQgN9pDH9FOOrFvtn4nJaEUKEG5+XA9t8/pKTrzg5Mb6FUF7mJswAl6RFXl9YSWOMYBYPQEFTeb1jschtq4WSh/wZPXCaAYoix9ujiFj9bzWIWd0l8o29loioddiDgbHWdU4CyyJUc1nUuw9BkSkcvkS2av5lfDHjuXInQ3fBls7y2UU9+WXQJIsfX4dAx5Mol22tHZrZXSj2foiUgeHes2yauB+i3uQ+F8fD3QVr7ng4c4eFws4lpMrJQGhju+8w/3lJNqdgDDYiTMDZdXFYvvPSWygoTmK6dg5ur9g5qCYZ8a0rnFzLfKxP0R2tVhwzVRPxB+QxvVIi5/YYxPYhvTune1mrbFmfsUnVMr9o99zKKr5FHZ6QoyjQ3kwmk+W+YciH/yYwYHPckB4YfBW0OY9oimAuhUDGtktX4bNvRZj4ccLXqQlKqUkyYQvf8rn7ZbFxqFZvcwPHHq6ufkW64
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(966005)(8936002)(26005)(6666004)(82740400003)(47076005)(86362001)(36756003)(15650500001)(82310400003)(8676002)(4326008)(6636002)(53546011)(84040400003)(107886003)(7636003)(478600001)(70586007)(70206006)(356005)(36860700001)(2906002)(31696002)(16526019)(2616005)(5660300002)(16576012)(316002)(54906003)(36906005)(336012)(83380400001)(31686004)(186003)(426003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 09:32:15.7979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8483d5-e28e-4350-f07e-08d934977526
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1525
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Bjorn,
Can you help review this patch series please?

Thanks,
Om


On 6/6/2021 1:51 PM, Om Prakash Singh wrote:
> Update pcie-tegra194 driver with bug fixing and cleanup
> 
> Changes from V1->V2
>    PCI: tegra: Fix handling BME_CHGED event
> 	- Update variable naming
>    PCI: tegra: Fix MSI-X programming
> 	- No change
>    PCI: tegra: Disable interrupts before entering L2
> 	- Rephrase the commit message
>    PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
> 	- Update return value to -ENOTSUPP.
>    PCI: tegra: Cleanup unused code
> 	- No Change
> 
> V1:
> http://patchwork.ozlabs.org/project/linux-pci/patch/20210527115246.20509-2-omp@nvidia.com/
> 
> Om Prakash Singh (5):
>    PCI: tegra: Fix handling BME_CHGED event
>    PCI: tegra: Fix MSI-X programming
>    PCI: tegra: Disable interrupts before entering L2
>    PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>    PCI: tegra: Cleanup unused code
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
