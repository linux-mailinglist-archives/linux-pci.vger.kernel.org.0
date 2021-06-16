Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316BA3AA409
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFPTO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 15:14:27 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:43002
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232377AbhFPTO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 15:14:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQTAnSNmICBG+i62ExIq+Qm2icprTGMRnp+UHEagmzEGZy9ND57i6K/tIxeR4nm1AxId5hrjh1y/C6qv3or2NaEuXzjzI2+CI2LuzDT7zgCr25zFHpnmagXvcp4lN4z1fT3NvWnjsaFvIe6/69KYo2qfFyKw+QrR/KvZoUCT37eFYld2Z1eTHUpw+Gt15KZhWE3dZhB+vXxVATTI4mR2mm06LdCW3jXNldLgFVzMFSMc6pkBHT1jfwFLTj4XtnrYZrql7tbG4yL93fzFB8gM3q45lxAesN4PYL9Y7BZvzKP2AR9Y0SWhgBzAHJYczy2gaBivk/Mw5utJsR5KwLg6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTtUdOME4ppYDYmHb2xu666NhFukfFKhDR/IvRGjF0A=;
 b=bEmeExRmaLzVu5vYLvibDAhqTr19AT60QIr+gOiVKxb00munhqY8XW+kKYI70h44N2KOjxwax5qcWLK+mG6CJRHttj550DU4s3cRPUzvX4FtzJH/QSyoZLSyAHs3PE1ejfLUBdGPZVg8ZKsv8r4ebwbFpkrN62T1OBiuQBKebEeQcew71pHWF481xXvAV/YM0Gwgfhpwb4dvnwiZEuqB4M9Lt1X4jjgkP24nwJfeB5ZMhBTJbJqliw5OfdDETSxScWH3whYt3+kzon1wERKAyzRq+WjnE1nh5QK3X7jaM/SiUSJ3PjGNnOiQYDScV4jMayhJ12wen3yRcg1dJMIEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTtUdOME4ppYDYmHb2xu666NhFukfFKhDR/IvRGjF0A=;
 b=l8nXlPHARHpLK9njfKGBF9g5MZuckXmXZdfEzrEjXyoKpPe2OmhqtfPf58JicGboXe4rf4BhXRWpWdsYGQ++91pDOL1EOlIWC/jzASAXPtLZ3TceUWixEYLcExvjVq/eaMqibgSHvswufO1Ufrq3WfbIVUQaiq22HeuvOVZVRnj1kXDDYR1wEU1EG87aSJQ7jEeoQm8JizyF/C9WCEJ4cdww3V77EhpGo/ISKG+n5EMhmF5LNhJD7tZAQ61BHpstF4SOKrVJ4yBf+zQw0oElG28fLiatVwPo4RV14jkIf2FvkmZGGhZtJkthqNzM0RYVZl96XJB6S2ZYA4hPwDxDKw==
Received: from MWHPR22CA0049.namprd22.prod.outlook.com (2603:10b6:300:12a::11)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 19:12:19 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::37) by MWHPR22CA0049.outlook.office365.com
 (2603:10b6:300:12a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:18 +0000
Received: from [10.40.203.90] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 19:12:12 +0000
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <smohanad@codeaurora.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <9fd37c43-e2ab-f5b2-13dc-a23bd83d3c7b@nvidia.com>
Date:   Thu, 17 Jun 2021 00:42:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6238f9a-b1db-4a17-cb03-08d930faa94f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559A003666EC1A6959749A0DA0F9@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0+aZCHMhWUkJRKpSHncpybq7viVxHeuU+TR4KwgY53YEyrEOyhXkw9Qs7Fy+/Tf8x9xPag5EbGeJozNM+eLJTV4ZZj2SwlbXvIaib6xMpbhO2I86RC/s7fA029DGBOMgljNbzhtwR1gMuMOaeXq8iWdB8leMRIAYkLAEtx46wLyX5oPBwijuZXp3WTxIDjHoG4eKiUFJ0YsYzJK1rUPyFnAK2sh5+ZecHZzwzV3TIUac37Tof2INgOcHFSsmwWZ4ANrM3ZI809Ks/KnF3JfZnoPEdwQp8ATa2Gc0VERTQSLxh+wKNUibMhKQbh9d5vZYdHfKah9hePLrrN4Rv4zHJMma+ku7fDMP9+R4NLlNPplKj2DBNAHTRtPqkhiPGP9BhsCocicsBYDgokvepa2eVOZvovqb/y6fVnzDLAoWzvZTKlt/vEwSYJvxURDPEFi1LpDoBQPdLaN8jAc+eFvTgDNbcuvIvLa7RHit/Ygiz+g/XIffE2jsEhj5pS8prU+fy4qYqusloaxkljdFvj004+rY61EwQM6qOlT1MaFKRoUPIDAFRRHBaeQT5eNc5fGNQd9MVvhQDhaO7yFiMOMsT9WquBZIS/4RX1R2weSFckSVwwwnZJk2pCDbUWhOpgIocN3W+uPVG/lSPH9sZpF0E4lIk6z9R9toWwmMXK8JuTDF0pKRQXSxxnYYiFIv3Nu
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(36756003)(478600001)(8936002)(426003)(47076005)(54906003)(5660300002)(36860700001)(4326008)(8676002)(336012)(82310400003)(16526019)(6666004)(70206006)(70586007)(31686004)(316002)(82740400003)(110136005)(36906005)(53546011)(356005)(16576012)(26005)(86362001)(2906002)(186003)(2616005)(7636003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:18.9022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6238f9a-b1db-4a17-cb03-08d930faa94f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,
Adding more notifier types will surely help but I believe the list is 
not exhaustive. What you are trying here is to pass various 
vendor-specific epc interrupts to EPF driver. That can be taken care by 
a single notifier interface as well, "pci_epc_custom_notify" from your 
implementation. This also requires to have pre-defined values of "data" 
argument to standardize the interface.

your thoughts?

Thanks,
Om

On 6/16/2021 5:29 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> This series adds support for additional notifiers in the PCI endpoint
> framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> to pass the device/vendor specific events to EPF from EPC.
> 
> The example usage of all notifiers is provided in the commit description.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (5):
>    PCI: endpoint: Add linkdown notifier support
>    PCI: endpoint: Add BME notifier support
>    PCI: endpoint: Add PME notifier support
>    PCI: endpoint: Add D_STATE notifier support
>    PCI: endpoint: Add custom notifier support
> 
>   drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
>   include/linux/pci-epc.h             |  5 ++
>   include/linux/pci-epf.h             |  5 ++
>   3 files changed, 99 insertions(+)
> 
> --
> 2.25.1
> 
