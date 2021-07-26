Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D53D5384
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhGZGVe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 02:21:34 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:19904
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232064AbhGZGVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 02:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrd/UxWIh5CfLuytJN3IGzhtiaA+v6WUWLa5MI62XHFV5/NmBP7flypFWKJQVjm9k00yuEw0/XlyV9SDNfEbNNAx0VRdK9ccbV1Ucj6qy1hrQ+AisHXUo07hri75mzZ+tRy5OTIq9lH5v5lwMPamHMEdOIK//U30mkAv44+JjQFM8BwQluWqqAW9jyGGzyTuz0KxSJct8V2VRfh6sdNlAEebOPFGU0cvZ/VcXbkFUTsJ3YEMMf6omRW5A8zrMRMu3uimmdodqMOois78VuYY/8hC5WeeDb5RUGQq9QjuKoKrfwuDs6MYlZRhNqgjpSp7xx1HMv2rAp5YWpPGw/7Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixmw96qEhMyFbWV8BuzLBtqw32Wy6l5DgFsF3MQi0SQ=;
 b=KpfAGpH+5a0N68bcEtouKMJ2UX9/ESH+F72W6OXMKI+SNYTHMcql2LlvC7ULAFkvJp8MAeaA1GQan08oBzBX3aTzQ5A6KESNN0UI266BuN0bn/23CKpyzmYlreLj8Gnd43RXBxhAQaMbkjKG1jziH2wE3YgedZffNCHrYYA6wK8W7cXseo2h/TbMtWpMIwipQQJKyy6EjSKMU1QN82j9bzLOOhrK3AzcydEw/SFqogHae1ApQ0MipIADZ55heuLyEc1F230zQZb18JUyjfH41LSAFv0dA5vUP2Ws4r8mIi4GPJmkJ9k3CvHeMVD8mNCVvRiuYTnkjVnaOk8w61R55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixmw96qEhMyFbWV8BuzLBtqw32Wy6l5DgFsF3MQi0SQ=;
 b=ZpP5FsI5TfHmfSlY8sFAi9BilNigeoYXrNiizV0oCiz8ZK0wDxwotINP/eZdw5cbdZTywAvy5PSztrDZlklYniiBkouEKyNFeL83iND+r6JtprkVEcHzr9eqoHrMSRhLLViebUrR/2IVozVWFn4ByUApcqu4NolAxhkAk99txdhjzjHn9me6i3CljuIUKQ3vI3b0HjLeTsWFaHy17CLZgTlMlY8JAfwBp6aFYxgJY1cMlLLjof4oWABn1kqltda6SC33NFPd/bQ4jXq9T1i8nxX0n+8cWPmogYEu/a82s7Jm5QJSptENRX59VjS9KY/D88FkNNhGyNxgFVVMxQztvQ==
Received: from DM3PR11CA0003.namprd11.prod.outlook.com (2603:10b6:0:54::13) by
 DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Mon, 26 Jul 2021 07:01:31 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::ea) by DM3PR11CA0003.outlook.office365.com
 (2603:10b6:0:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Mon, 26 Jul 2021 07:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 07:01:31 +0000
Received: from [10.40.204.200] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Jul
 2021 07:01:26 +0000
Subject: Re: [PATCH V3 0/5] Update pcie-tegra194 driver
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <3e20a33f-fe8a-c3e5-8571-05b671b95e78@nvidia.com>
Date:   Mon, 26 Jul 2021 12:31:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a6b62aa-b7b4-43b8-baba-08d950033299
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4105996F59E871EBBF67C936DAE89@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGPS8OtNZShqxNLUZQZzK8zJAKKI6gw16XeDgsMg3YtNw+DuEH+QLHizaMJe3fh5qd+lO3I8ttB0Rm9TXJWWz1ByNzbBVH+NHM9JFD7FvM4F+g+lvC99dRpu/hyt+WNoBCCd5FqgrBvRxRzYkSv6M+AHQGPm68lAf3uZAy4PY+FAIOJdyrOnqVtf4CyXnURDyDl1nILiNPPf/LtUXjoa5g1bWOJ0EIfOr1kF4tgPz+QnVliM/sVCtuNjHImuzYFDrgr0zKKJU4r/F4ykkHDPb01AJiEL5W38OHUoTaIVD81rE1f97YT3sjin5WtaMGhGOCpt8vP2O1WxuSEPudWJeq/RddNC4F0vvlVdOZqiqqdlJnGgbpKcWwDM5mw5mXbObNE26ZfQr5ezULNIj0X3n8KlfzR9u+Blu1Drld8t5DbDxlPNPe9zSaJlA1DnwXRLcxFP67ozHzkIBKwxQx3NM3WzG0r0e+4XIaC6Prn6BHWeov34lI5bv4Vc/Og+fealCYc8mnkJWnEiCDK4IbFPFm6lu/apzDZNsd2SphZCm3yVcDIlCP7239LwQvcvWjTonsocCdOZP5uSUc5xoiZHs5AK3CqYXDrCZ4hQiVsOkZ184ogj9Hx3mArQFjphKX4ghbABfo5IuKGskBNhyM2Y3VpmpKsU5RIO2gbgOw2lTqhQ2DmJRDkPGUx6NSCT4GlwrLJghoMnUV9JvraiIj0t8i1pMB0crbs4JB4rvGXfQAwDY7vI2Gb3ycmktzEAH4xRwB/nq4rjCVZM2+Qyar+sA+IqcQEAs1KHL2Tbt2qANKkuc5ewUKIBf6Z57YpQnz+t5lOwPsl0/nFvFIREyDwiboF2uxKhPjf3AY4rP3Rp/sQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(36906005)(5660300002)(70586007)(8936002)(82740400003)(53546011)(47076005)(70206006)(31686004)(54906003)(6666004)(16576012)(4326008)(478600001)(186003)(2616005)(6636002)(966005)(8676002)(86362001)(7636003)(336012)(107886003)(426003)(36860700001)(36756003)(316002)(31696002)(110136005)(15650500001)(356005)(82310400003)(26005)(2906002)(83380400001)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 07:01:31.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6b62aa-b7b4-43b8-baba-08d950033299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,
Please consider these patches to review.

Thanks,
Om


On 6/23/2021 3:35 PM, Om Prakash Singh wrote:
> External email: Use caution opening links or attachments
> 
> 
> Update pcie-tegra194 driver with bug fixing and cleanup
> 
> Changes from V2->V3
>    Updated subject line from "PCI: tegra:" to  "PCI: tegra194:"
> 
> Changes from V1->V2
>    PCI: tegra: Fix handling BME_CHGED event
>          - Update variable naming
>    PCI: tegra: Fix MSI-X programming
>          - No change
>    PCI: tegra: Disable interrupts before entering L2
>          - Rephrase the commit message
>    PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>          - Update return value to -ENOTSUPP.
>    PCI: tegra: Cleanup unused code
>          - No Change
> 
> V1:
> http://patchwork.ozlabs.org/project/linux-pci/cover/20210527115246.20509-1-omp@nvidia.com/
> V2:
> http://patchwork.ozlabs.org/project/linux-pci/cover/20210606082204.14222-1-omp@nvidia.com/
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
> --
> 2.17.1
> 
