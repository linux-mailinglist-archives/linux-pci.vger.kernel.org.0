Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9B39E13E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGPxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 11:53:07 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:47392
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230264AbhFGPxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 11:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCpV6Az/GJvvbKT4ivIubs3ANn7pKblhqxVeWXfP9uekNLxwhNdb7dpB52j5lGZHhxeYyp1HRL17Wd5Rp49nRxMEb5VIxlf3ielkiQdhLGBqzG8zkfSP/8kvyrgtPbi3gvKU9HA0D0eOozwMyGKEa1LIMwD0xPpN3wX9WvJkFvwDqLhgX648Hq0lcyoMsDmluq77W+Sn396RF6ICaoqEv/uuVVM57ErVE1GD3+YIm2Amjtn55sP+MgUcYoHjj7YVDMM/B7+1mMtNXBAHVHpgbzZnvT+sJtwwKW+z/1GYrsVxDqOUChydxMnUHxXjqJlvmxl+iP6UfR+JkFd/RdJtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0ka6TbndTxxkzCkrAW2ezd7S5+DhjGbXv5Gg1M8hrM=;
 b=H+x1S6K14bcagn1UrcB3K7J/aSm8JHIQ4tRqJGUmGAnCXqRCfI/K9H7vc2IrKD9dorZQ+NMBbxcxzRCP6dOq5N7B/c0FBMiu3HnHnHC37evAEiWkueqCg7xKEJZhhqTEiIg1vgUFfShj5SGd4JlHpvwBn8vXju6vOBIIxAslQZqplz35L2/iQkx6E/788G88U1MRBVvOhw+tyy0eF+1hiutL3N/ZESYTf4MTq5J6IYfsQFxJVn1wH85ZVkcSYJUVca63PkH/YKeeNikuFG3sqCrgapwq0TfxwSyrC3v3pDRDg+aOBvhFG2BgtqDE1tC5tbDiE70PiRL9g1YO6NAKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0ka6TbndTxxkzCkrAW2ezd7S5+DhjGbXv5Gg1M8hrM=;
 b=p8Olb9a2UFaG8kGuK2IWneN2VOIkqGAxyP8biE04domaMWJc5opMV8UVMpSLTKzzMv+v12dmjq0RuxF5oBRflwqvmVgbU+1q4PPpxg8We5nUWkEuiNcM144K6iWtfG/xBop16+XfO7f72nn2Njm49lE4ZXi3i0oM+Hj5J1cJszOxXiRSn/gyyKYeOK9E+kPdFU8+pZ9NSs8w9KTkARpb5VXqwiKAIldhN9eViYTQz52zxwDMmo8qN35DuF17dlj89ohijFSbYX80ekQjiYto52xJDQkhGYwS5oUIkd/jQhpjpJBqWrJkEDP84XV+isy2MyMGTOZm4Ga0wbaxDqipAQ==
Received: from BN6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:404:13e::27)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 15:51:14 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::4f) by BN6PR13CA0041.outlook.office365.com
 (2603:10b6:404:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 15:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 15:51:13 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 15:50:36 +0000
Subject: Re: [PATCH V3] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210526123322.340957-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bc6345fa-12a6-aee3-7fa1-1703bcffa6a5@nvidia.com>
Date:   Mon, 7 Jun 2021 16:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526123322.340957-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48008b7d-2da8-4b1a-dfb8-08d929cc145a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5367C7E0C3AE78276F65BD9FD9389@BN9PR12MB5367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfBBd05E1zPeGEX8DNcs552nKCvdveFPxhvcOTuP5CGs3CmE7H2sjazuwZVHwEoNAveiypSiJcbez/nclSHkYWnMKY/jXhXGRlms8yZadoMvMehg45L5UXap2w1DFer3yXOBdCMiBdUbturgMesH2TtoziJyDPZlbyndQKG8V54Vml48G9UPw+EfEmwdQW+YUuAphTjLCZ++b8u2yavKOXILILuR8sAsyMMiR3TKh4ZLRSCJV9HrFb12MLbnp/HOJurgcsP+km+/BmaMqO8RPDUceCv+T7KV2xV8hWU5dOpG7bemwM/Q1JQ/Lf/4Q9SGslxyHNvhi5GvYS9n8aEAx+7IU/DBdDisyPgtKlTPmsArUMSDkFyfj3TWcMe6NTc9ghceC8QZG/H0OyDUtKWVgTPbBz6ZBo3koNQlse1PtMtcvcl6Q5aU4X39QA/jecpdxuYPHtesOi2W2kEIs1Kzd8ekGSc38rdnXEH0/BiyJzq7cGrv89uN+ZTyugvjR/eBTK85PqcMNtx8xuGZrGkPLcpFUCYZryzpytzeaGlr5BNZj6xneLshRTVwoCDJj2zmD52dr8ONN1jm4KaxHCAD6ONdM4bG/oYc7Be2dIdWdmSw1WkjaCMj0uBygGWSI5Nwa60iWBeU72CW08UHJe7BmZd4pl8TkDs4P+raJ8VOSmMyjutoxNbYx75NZm5SPLzR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(2616005)(86362001)(31696002)(82740400003)(16526019)(426003)(7636003)(186003)(4326008)(16576012)(36906005)(26005)(316002)(8936002)(82310400003)(8676002)(47076005)(478600001)(31686004)(36756003)(53546011)(5660300002)(2906002)(83380400001)(36860700001)(336012)(54906003)(110136005)(70206006)(70586007)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 15:51:13.9533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48008b7d-2da8-4b1a-dfb8-08d929cc145a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Lorenzo,

On 26/05/2021 13:33, Jon Hunter wrote:
> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> errata") caused a few build regressions for the Tegra194 PCIe driver
> which are:
> 
> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>    was caused by removing the Makefile entry to build the pcie-tegra.c
>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>    so that we can build the driver as a module.
> 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>    driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
>    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
>    driver. Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks
>    for either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.
> 3. The below build warnings that are seen with particular kernel
>    configurations. Fix these by moving these structure definitions to
>    within the necessary guards.
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> 
> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>


Any feedback on this? We need this for v5.13.

Thanks!
Jon

-- 
nvpublic
