Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD43A165E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhFIOCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 10:02:54 -0400
Received: from mail-dm6nam08on2073.outbound.protection.outlook.com ([40.107.102.73]:27521
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237090AbhFIOCy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 10:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js5O4ZgXzzxZe9uMkt+6HhhDA273wIp6j/190uXjzdihEiQN+NLK4+8Q4sBhx9vgpwVqB2/YZ63LZcBDJPh13wdU55ZMDmbGsAHjmG5xSnZFSRZUXE8qUvHbGSq839ZDoUk0ZdggqyD5VxBhekJV+/YRkeiJzeaVFMuMuzk1X8rHmI19OG7D8swmzUoxfuFwQqdAoc2A/Kb3lToGnBcaaBCw0zVzYLlxtCL92vM1oUwSD33ucMJarecuyvwUzCdRwdLRkpl0DWFILjz3BNiFr75rwt+m/neoHEH+kAkdTynwx6TFKRKnv6dfgKr370cmU0wucS++vg4JT+VFHX43Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LlsRH7dIp9v7CDlQkzUBq/ba21YEfRVH86qqDR0vyE=;
 b=LIcSobTNI5tYPqvVjLQZyXge5SpSnMd4Dz/9mR+2ldJTa8RCyrd9v0cPaYnSZJICf6Q7zKUzAwtM6SFqjA5iBXiXPMnLpezF2DssM4DTMa27kk8QaHIzNTXo4sCtcjrIUc4PJbRDua3pFFkdjxXfYlXdrryMK5LenfYvBFIcH4sJdjzsQW8kafhKwEQtHU/ltfoX2or88kew57gVU61g9ht1GVGZjFiBWvDMQKP7pKrltjiqNqkBb8okz+3GAddyud41JPWkL5gxoujpVArhElQymPE1/L1y4MaHrJPKidxX7m2esLDbwCTYgORHshMVF0cJyZhKIjwFqO9/p33GcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LlsRH7dIp9v7CDlQkzUBq/ba21YEfRVH86qqDR0vyE=;
 b=g+D6TeVbyPLQePdQ0gxNnz1cJzX5qDDi2nxJekT/cxEVDKXiunEDxW+YG3aQadcwIjoo/S72iqR2jRqw3BH3ogGBNlHW2fkqK99QlptkBhGkYcIKHXk0yXbUEIbpq5nHXFQQiYycCfXfxuLbKRKsqQ9alAgbdfF7OS4j7WJpcU31ilR0B4sxzos0EdMmB4oSFBPSUXOUEreSmJAoy8DaEsw8sXHravkdUnQJ1rpUDnt6cpTeEcEBROzytvPRZ2raaF+svSY/5nejcCwSWGn6SlE2ka55dYsXBhN83JSLxB6X0goWwNL4d5AVeE0HGWpthiXhsG0Fq6J6Iyw9smD8sw==
Received: from MWHPR12CA0040.namprd12.prod.outlook.com (2603:10b6:301:2::26)
 by MWHPR12MB1295.namprd12.prod.outlook.com (2603:10b6:300:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 9 Jun
 2021 14:00:58 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::e0) by MWHPR12CA0040.outlook.office365.com
 (2603:10b6:301:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 14:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 14:00:57 +0000
Received: from [10.25.75.134] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 14:00:55 +0000
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608130207.GA2597738@bjorn-Precision-5520>
 <754e3546-402c-2a0d-02e8-5d30701f3b94@nvidia.com>
 <9b027609-a2c3-3df0-5e65-1f282f03cc5d@nvidia.com>
 <303946c4-29a1-4f5b-6a4c-be451ece20fe@nvidia.com>
 <a80788e4-b0a9-b8d9-46d0-873b5cc6035b@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c3fd5fce-e7cb-66ac-d792-5fcfd95135e0@nvidia.com>
Date:   Wed, 9 Jun 2021 19:30:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a80788e4-b0a9-b8d9-46d0-873b5cc6035b@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 633e8397-bd1b-47e0-1f0b-08d92b4f01b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1295:
X-Microsoft-Antispam-PRVS: <MWHPR12MB129533D50A469B6D2CDF5823B8369@MWHPR12MB1295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5O/3srBDt+EIE3zRTtjwHDKQPXCM3P8xM8LngSvOtYpb0n48SFcFwnT/yZSGR0XHG/JrIQXhYVV7qDX1NCw0Z3x9RZ15ZiASF+XZYeEVsZ4PoTsFrbmm4LHY5+ZZS39IS8z6FF82+zgx184zmGhnu5kF5vFzls7dg+pAO0oMF+RbAdM3NnYxKTbaacJ2rPxC5MMts1XTjPdlacTGjOM9R9c7Ae7kMEmGDVFpLLUx5KsxByPOw5JTvbjDegP+woAaSWdne0twsbO9fpwh4V4yvolUNMSvQQWBslLQAs/H1w8EhLb0PyueQHyRPQ7I20bxHn42tBXEHJgXKxBbtHgsFNMoM5zFy7ZRHZpigrVUsgnWxtTL0E1sPgugQFYmuW3x6LvgBKPM8chfWJT2RnHRJcI4wce0/jwDbl+y/YiXCuqpGJctc4GWZdNyPxm+P6+MmdaWpEeABCuIMCDxuz2KLIpZ17Qi6YA0W5Bl2eOVNUVLZXeAstHKrazSxI1Hgrjt5C3ecOWP+5Flh4vGk30Zgn5wDmtR/OFigP0lRxrkYSBcdBpm+tGYWo/QietCW75fqPboadOLISn/09HE6br0o6WIVjWImDWsNen6BAqvpZyz3vcii+d7Zh530VDN0KD33xDw7vh1RC02cneszMlDd4rTo7keQPUHzRDNQQrKivPONeAP2F+KK2LKEmieGJyH
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(70586007)(54906003)(31686004)(8676002)(16576012)(86362001)(478600001)(316002)(110136005)(36906005)(2906002)(47076005)(8936002)(356005)(336012)(5660300002)(36756003)(7636003)(4326008)(83380400001)(70206006)(53546011)(36860700001)(82740400003)(31696002)(426003)(2616005)(16526019)(26005)(186003)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 14:00:57.9410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633e8397-bd1b-47e0-1f0b-08d92b4f01b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1295
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2021 3:53 PM, Jon Hunter wrote:
> 
> On 08/06/2021 21:11, Jon Hunter wrote:
> 
> ...
> 
>> Furthermore, I wonder if we should just move the code
>> that is required for ACPI into it's own file like
>> drivers/pci/controller/dwc/pcie-tegra194-acpi.c?
> 
> I have been doing some testing and the above works fine. IMO moving the
> ACPI specific code to its own file is a lot cleaner and simplifies the
> Makefile and Kconfig. Especially seeing as the ACPI quirk code is
> independent of the actual Tegra194 PCIe driver. Therefore, unless you
> have any objections I will send a patch to fix this by doing just that
> tomorrow. Also let me know if you have any concerns about the file name
> or location drivers/pci/controller/dwc/pcie-tegra194-acpi.c.
I'm fine with this. No concerns from my side.

> 
> That will at least fix the issue with v5.13. If we do that, then for
> v5.14 I will clean-up the Kconfig and place everything under a single
> CONFIG_PCIE_TEGRA194 entry (which I can send out once the initial
> problem is fixed). And finally I will remove the unnecessary cast in the
> probe function.
How are we going to address the dependency issues (w.r.t RP and EP) if 
we keep only CONFIG_PCIE_TEGRA194?

> 
> Jon
> 
