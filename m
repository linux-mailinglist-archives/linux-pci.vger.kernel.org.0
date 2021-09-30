Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2241DC36
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbhI3O1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 10:27:48 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:46273
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348704AbhI3O1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 10:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsIf4OBPt4Vf6dQ/p1ZYbyxAfoqWY4b1WvRmJLOkepQdsWZuI4X02nzSgmCP9zxjWYWbT3OKgaGJgfGcxu1vwctpqzntitU2lJNtpw7Vp2Ppp+EG+Kz0Jcz8/ujrYGY4yBZOJxe4uZBLZXTFCx+XwW5xEo+gd9Uey++Z9HrX7Oq9FdQmMbdWLukTBCDTs/RoT6SiGV/qT8sjEGz53+IXAbmZnmC808BhDQ62BKW6xvAArxfmb34cWi3hgRbfJDAPRqV4OFCCXu2l6AUxPDXB4Kav3iEXd2XL3x6umHwdrvAfZfObj0nitUsc6tB89BxBawSPTQCrQNJypfTQwRnJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lXoZsf0l/pmdHbmneNO6syKV5dmdhkdFhHoZzMPElGE=;
 b=MMpGqp8lJ9TpOpT4fF1/HSsbXBqjyzZE6u5dUQn9ZnmRkxy7B9noFYIo0rYeARSHqBL0D3tvn4XDl9MZx6MV7F9CSqma9lpCVfJZ2DerrEIUj32YtI7i02UPOUQokIsnQI2Dr/2RyGcxRAYDP+gpWwcdxazkpBvhr/8ImjsmJgNHoT6YWZBcgyT5qTXNSCBYd4JMFaljj7sAEZaFIbZPP+ugWkXz1OgdJSUlcwYe4XvUHit4LsqI0FAz7Rz1CqE7bj1kgRbS8Vqcbi4mYmZcU4gAblZ31A1IugzCuUBf6AERBetGn2XS0w3m5MPX30goCwg93dp0prApdF2mRPWLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXoZsf0l/pmdHbmneNO6syKV5dmdhkdFhHoZzMPElGE=;
 b=e3BsFxKir3jaaOS1pseFdoMArrH8ozrLlX2/NxLlMd5QeLOQSilzYKnmjqmgN5Lx1mRRRQAE/Y/w8kQqMxz+G83JJ1RN0dV0uAuX+sNMITh9QGyYBXoLf1nXpTp4vRZbq95xz6Nx3cab9Yruhj+6KtUB0yNmitfsu2YDxvV3O1J74HBqC7A+gHcBkwYjlMdpq0hbA3Ay5ulr1XQBtdOJTnL/iFYR+QNYzF4nEX412LkbKPD1h/HwyOBokjBquHS1uWi5mzegAw/kcCZPlJMw3vWv9+2AWBytmmp4Rnh1Kkpa8l3Zpowz8DdUHagHA5fn0oKfoKaxtJPlXrBTkd36Vg==
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 14:26:01 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::da) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 30 Sep 2021 14:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 14:26:00 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 14:25:59 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 14:25:59 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 30 Sep 2021 14:25:57 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <stefanha@redhat.com>, <oren@nvidia.com>,
        <linux-pci@vger.kernel.org>, "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] driver core: use NUMA_NO_NODE during device_initialize
Date:   Thu, 30 Sep 2021 17:25:56 +0300
Message-ID: <20210930142556.9999-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26cd7d6d-a3e2-4bcf-8995-08d9841e3a06
X-MS-TrafficTypeDiagnostic: BN9PR12MB5321:
X-Microsoft-Antispam-PRVS: <BN9PR12MB532136CDDE6B41B02379858ADEAA9@BN9PR12MB5321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0wbfmjAT32KDm2AA/HOPvLIZpbitjyVi/U8n4kpz3NULK9tVcie06acV03tiKTwNpMHghJ8ehtNenGrzp6/I9+1qzMhnYsDdlNKW9I46igzw9GdSXOguf/eIeCo1oVQE2mZ6UN2HFX2v7Ta/R0kRRpe1LmkdqpRZfRCO9k9Rn7H+OdNy6QAYw2QMsvseyYecgKPJxsSllxDPdxsS9UvvVz5qGCLF9cJuVmuOWhUFw/JvgjmlwPBXgLMU9oP22fWOF5FbB0hp/eymrAz2qT8LV4M+EMZ75H9MI/p2sWPCkz2DdaedLSke4fSRvkyUgTKJ02ICqnoW7YqicowUKefvEWtG8+/cSck8xfxlWYL/rbiuMFyAVKjlCSALIv2YHGEGlTCjlKKikjPvtqmElnozZk96ZTWOC/WzogOkQzBthAQJ/Q4+9qlAHyG+UBtckVnBoQj09rl61Y0GGEwsAgf/TGlbWJBIdW+Yn1aT+Fuof82S+/WCezYcybyios6c+zAHyPf9M0RRHwt5VDKiyqYKH92gshWYNZqfSiMNxVYTq38EJx5zTPeLu2M8fQS9TqwZEn2xFOpbw7lwtLS1FbbDsSzWqOQBMPGCK1g6t7pcp/8rXUwU5CxzV32Xuntv1Rm5fJFDAycBkk11NWOYJp6cz1KTZXofZKkIw4m2diKVKFo3gHjZhrCeqz7HBB+EAZIt+wCymJD2e4qszamzYHarg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(508600001)(316002)(36860700001)(186003)(26005)(1076003)(54906003)(5660300002)(426003)(336012)(2906002)(82310400003)(110136005)(4326008)(2616005)(8676002)(4744005)(36756003)(107886003)(7636003)(47076005)(86362001)(356005)(70586007)(70206006)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:26:00.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cd7d6d-a3e2-4bcf-8995-08d9841e3a06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't use (-1) constant for setting initial device node. Instead, use
the generic NUMA_NO_NODE definition to indicate that "no node id
specified".

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..2b4b46f6c676 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2838,7 +2838,7 @@ void device_initialize(struct device *dev)
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
-	set_dev_node(dev, -1);
+	set_dev_node(dev, NUMA_NO_NODE);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	raw_spin_lock_init(&dev->msi_lock);
 	INIT_LIST_HEAD(&dev->msi_list);
-- 
2.18.1

