Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C954A614A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiBAQWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 11:22:45 -0500
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:4008
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241055AbiBAQWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 11:22:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPE+YlqrWkhxVfoXJ0kEtQYcxba8lor/fPo86GSoOGJTiX7+aCIlD1htPUhzNgj0dDJGMu/QrwQ5MujgJKt7StIDaLNWci0Y7sFPJF0V17h+uNwknnPRoepm5piYmRSFLdurzLg6kGp6SXoTug9ByQyYgRdA6xB/y6Yjxg7C9tSn50JdAvMxkMwiQCkoWY5FGtsENZoWRNacBWdTdcVgMnNeDGB44RePwSt/+odowfp0eZal9r7hT/PoCPjoyTLRhOfIawBVtXUdFWYeomPdXB8XUBt0Hp1w/Wfdwt7tT8orfsIPoHJXZbgdrHtX5CQAU6OgFaeg9zZY0Jss/9SnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgC72qfrt1nXX/kqFvwgjw+vaD3+yk6/B8fqBiuZD5c=;
 b=Z5E+n54CARs5xwXipdXaaWX3CLVWO8qa8PhXre58VghnGpGPJ0sr8SDpOTEdU3hV0F4wDtwHWdJmBcnAEDN8hKZe4sQLULvlthZ4e/hWnx59bdX2fmStT9ooB+91lfSAVLJgfNJy6PocQEGfwM4i0VZ0MjRURNLqqm9vyWYPUGgh0z8cg4T2cW8BdfnMey/eIatjUuWYHOGwsvTtW80ILs6HUGkLTZr6s3agJcGXalaJWM5Pnw/w4PDBJnt+dwzWhA9kl1lZmbzyzFb8Y5dbUQ19rw2H52H9uYaCm5AxxpynwETz+tqfcSGx5oXBkj0b285NEZJuW1wrF+JUsfGT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgC72qfrt1nXX/kqFvwgjw+vaD3+yk6/B8fqBiuZD5c=;
 b=LYms60hNQJc7YK39d26EePIsL1x8ezcCVhRmnuig2ngSlj6gM7sEPRVbnfQMzvYR/TvcJLQyuvrGeSOWLKWWaM4T+/Jj1PxCxBTFq9VARCxF1b1N/rpZsitZoa3inwqGsthWI+qFP80zmcbzhSERIcGGUuBrAO4hHTv3SZKU0+ups+kG1e4HOseENqWUBj9FIQw2YLU98tnmbTFCNcLhC6K+7DBNPI9U/Qx2lpTJj0a4PG7TbKKcfgWZIyHx2vPd4d+mFBjfPfmvUQbUxGOlnsEyD0HG7p8Az8lqXWpKgEI54oGSnOcdX4bqszIESgonRHwt25p2rsKLjWWLeGRNUQ==
Received: from DS7PR06CA0029.namprd06.prod.outlook.com (2603:10b6:8:54::29) by
 MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 16:22:35 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::6) by DS7PR06CA0029.outlook.office365.com
 (2603:10b6:8:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 16:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 16:22:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 16:22:33 +0000
Received: from [10.25.79.72] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 08:22:30 -0800
Message-ID: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
Date:   Tue, 1 Feb 2022 21:52:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <rafael.j.wysocki@intel.com>, <keith.busch@intel.com>, <hch@lst.de>
CC:     <bhelgaas@google.com>, <mmaddireddy@nvidia.com>,
        <kthota@nvidia.com>, <sagar.tv@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Query related to shutting down NVMe during system suspend
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7603ec4-202e-4f91-cdab-08d9e59f0e2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2957:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2957F0076A7AB055FFFD1E16B8269@MN2PR12MB2957.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oto60ErCpPyceERfc4J7YacbTX6HzYuSkY8hrX65y/01gZWk1ohjSUSGRzo+/eoOUUiD20NIueI5j+hrMoyCOk/JJrvylUf2wCnszNyfse6Uw5IwjkzMQR2y9Le+3/dcUtgWV19/CguTIuREv2Oba01chgn/LpOKyvVH8GiUXvrMMsIaegwhIV3MzTMtgRAe6hfTgVJiyMVq4oh+hPQPyou3+01XQa+E9d9IABtjTGJuIifFaDNdO9oDZCDI8GkuvnpDKcKbZpRZbI7eA2VnrmUAMqT8QD0nBCbU2F2qVzpEjiwFswvcgNiUY+ycod4G1pPc2wp/lLCOuFJ+XK/NQdJxsEgumu+wDZc5/AGQCEcO/+Nn8ct7lfEd+JkWwRCY+rZJIEzOZmVMEv4ZOWqnJ7fAOy3nlrq8NRok3CT1pPtqOp6AMzGYskJFo5Zx/vs31V76iN7hjl1yBPxG5U9uU4PCtmBZuBko9hZzvwQVPL15sXhSQxvnm6PL2GfC99z7zaZG8gyjpOhoXAf2srzI8t5KLANgOD0wmXbNes0oLFy/FUCAICVMp/PT4THeTa21SRqGVdAE2yJN5f/Sm4xva409lPcVBKB7E5Jl7VMg5oocSPTeyhYS5ZvWJQcK8k0JcIaqXp1jxOD3QMirol/g/R3ZvEc4ftHbolvuGkmNGnK8ReaRNqc8ZDo96Jo7nQcR8thT94Uh/NwRRHFmdBK9q1GWukzElpt3ETGzYRcV9lf/Ou3Q6KaZmshggi8fulGzIcb7761p51mA5fRDiz+f1mt0rlgSZqCGU75yd3ebeNMQbYtIIX3nmX6Ri081xnO7CIKBSIF4ED+sPch/j7sikg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(8936002)(4744005)(70586007)(81166007)(4326008)(70206006)(8676002)(2906002)(31696002)(82310400004)(86362001)(15650500001)(5660300002)(16576012)(110136005)(54906003)(316002)(83380400001)(36860700001)(47076005)(31686004)(26005)(16526019)(2616005)(426003)(186003)(36756003)(336012)(40460700003)(508600001)(966005)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 16:22:34.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7603ec4-202e-4f91-cdab-08d9e59f0e2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2957
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael & Christoph,
My query is regarding the comment and the code that follows after it at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
What I understood from it is that, there is an underlying assumption
that the power to the devices is not removed during the suspend call.
In the case of device-tree based platforms like Tegra194, power is
indeed removed to the devices during suspend-resume process. Hence, the
NVMe devices need to be taken through the shutdown path irrespective of
whether the ASPM states are enabled or not.
I would like to hear from you the best method to follow to achieve this.

Thanks & Regards,
Vidya Sagar
