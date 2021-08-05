Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3143E0CBA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhHEDTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 23:19:24 -0400
Received: from mail-dm3nam07on2084.outbound.protection.outlook.com ([40.107.95.84]:49888
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231321AbhHEDTX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 23:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEOaOQkYSNz0mxzzgiIkkALIveu1e9xcIQNUzsuCyozph0r5h3iAIfUJBp/+IZdyBYt0Vob2Fr3LrQPsaSNdLen8Q5LPTvTJRkA6pc08cfJQSk9qKu4UF8vDVZqTwet62xjXH6FpyDCmlelB9pvq0+NMmz08modKojDtMZZWUrNIF8652ecv7wgXXkzshIJcnlqpz710qaU1xN9AVwE6gglb97Ewo1Wdly9Ll5AexFbJo5zOkzKYYL/ERU41mzVpwufjPofSq4FLylygLNgSyUevaDcLna9pyqrUBiE33ELNIxjuju6LxgFWEiWMqwcQEdE6exySU71KpExfhUSd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejeuyp10ROvklGYAyROI96r2DhteT/6SHx2VRyJ6qEI=;
 b=L2XwxCUn5HZI4Eh3P3Plb4SfsGiVviw4phd0pgeN1Ua62RHowk5lqM2wOL1Hg9Lp25jmkNlqpIGzYCekvFaF+Vnzmvdb5YVgqLMoKECS1fgwsL4nZ+0jhbk/FxpOLiUqJxv9ICOvFSL3wCi5OhVSfKsXlYojEPCjhb9Ajy72cJf29mHjmuQRzXub0EDLHlYYeHIExNvRAzjZTkbHgmSXTStHz/UrgZHO/IWXPiTWQxwwhUpvwZt7C+atCk/cyywL1ZGitu3sEYP8+yMqPzP4DOxmLq3nbK/tAcKfj2gacEHWxwpCM+ViP/PKxDfXdGB0krLDa0mG+nry2D3TXYpstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejeuyp10ROvklGYAyROI96r2DhteT/6SHx2VRyJ6qEI=;
 b=ChkYCrKNlI6QzO9qWRC6iz2mzdrBlLTygLZRWtKzTcjx5pJbHZiEt5aT3lCMJIuBCy0kicXmcVCcDD5ED4Xn8Fsou9hjYqFGdnRum0DxVjbvScm9UC0KPSHgEkj86piYDlFWGeqQyNkd+L1zuvc2fJjW3iEu/YBCoxIxPMpEL6wA48oLp7D4cWhqNpVEylyG1uaw3yMLFRrT5w3O0ekg0Ie40RvHc5GYXQ4QiwJ6SCQkfVZFHePepKzt6q+3T2wUuSJLIcsbiJL9VS6b35ekKQgWVL0NtVI6q4LmWP/F8JQrnt81DnNuoH2ScXvxyTdq0R9Nh99r3ImfWJfwkZo6Ig==
Received: from DM5PR16CA0011.namprd16.prod.outlook.com (2603:10b6:3:c0::21) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21; Thu, 5 Aug 2021 03:19:08 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::3a) by DM5PR16CA0011.outlook.office365.com
 (2603:10b6:3:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Thu, 5 Aug 2021 03:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 03:19:08 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Aug
 2021 20:19:07 -0700
Received: from [10.20.23.47] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Aug 2021
 03:19:06 +0000
Subject: Re: [PATCH v14 6/9] PCI: Define a function to set ACPI_COMPANION in
 pci_dev
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
 <20210804204201.1282-7-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <28235d1b-d268-789f-fa12-8add880fc8a5@nvidia.com>
Date:   Wed, 4 Aug 2021 22:19:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804204201.1282-7-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 263adc1f-70fd-4e63-e221-08d957bfc9b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42335BDD5FFD11EDC6A6CC49C7F29@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAGnihbEA8LfgCbYUbVCZmabli0wd0TvlPNLnEsSbMzFRTqW0I6rpBpiZ2TWUsLxBmNfZ432NThk+tBhVWPMZrcLFZq7LewxKWB86PH/girSt8uRDJOHJUmX5aLF3DPwA+FlTQbBp7/4F0lvrSAM6k2ViVG4iwb4eExJgLqw0nhJTdL5zXtWfu3X6OOBj3szblrY7r7In0QeOXvar0GCV/Nc7PXMfe/QSOzMSTPtEaqXx5Xrx22Lm5McrEQHqhesVE8GhBLYnIr1zstupRvRmTECBGXdzKj+f3jIdoaSXSNV30fgA6/oXgHa5hQmjFcfkbshJ9s1Vx9uJSidnqnR4ATLvWBtCDO/Hk9REFlD0Y8/xpUfEQh2Cn8vQbn85Qb2QbibcRTCvf6sZn2rAGiDgg2lO9SpNjFKcdIPFejuuX3ykWvM3AbW1zMyli7wKOZCRgA7wo+llWVsPcvzWK/9ifnPafHTpG+WBO4NBdUrfhUblKSiioyBCHb2pJeUtU5Nbb0N9ZgK+n2YyEsVqVjKFqS2R5yvAuNJ4bnl+XcOzFtBEUo6Zm2pO6OHA0Q6KiCQl5pz0QCJxA0ln9JujP7k3BF8qeR8osMiIqtJBzbj8ms04V61effGMPf9yK4LpLsVQ0zJjzMFeNXOc/jFiNiEm06GeJ2T1/mmCefjXhlNTnAeAemiDpPzrv3hAgVUNVUkaAeZruOjToWDGHt6tfVZzcKQ0g0qpRv86CNzFUrsl1Q=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(36860700001)(47076005)(86362001)(82740400003)(70586007)(31696002)(82310400003)(7636003)(426003)(7416002)(478600001)(8936002)(4744005)(2906002)(186003)(53546011)(16576012)(26005)(2616005)(8676002)(31686004)(5660300002)(36756003)(16526019)(70206006)(54906003)(356005)(110136005)(4326008)(316002)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 03:19:08.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263adc1f-70fd-4e63-e221-08d957bfc9b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

On 8/4/21 3:41 PM, Amey Narkhede wrote:
> From: Shanker Donthineni <sdonthineni@nvidia.com>
>
> Move the existing code logic from acpi_pci_bridge_d3() to a separate
> function pci_set_acpi_fwnode() to set the ACPI fwnode.
>
> No functional change with this patch.
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Alex's reviewed-by has been dropped from v13 and this patch series, could you you add it?
