Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA93420102
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJCJPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 05:15:38 -0400
Received: from mail-dm6nam08on2061.outbound.protection.outlook.com ([40.107.102.61]:43270
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhJCJPi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 05:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMUVBMelOd3E0PwgYy9iveaFP5P6QkvRZx4siS2C1Rx7m0bMQ2B6vBMWWkjff+47Fo4WAU/qkvznaQszeuitIXVMdnylL4KjY0MQ0sXda74mRQEhN2wbF1NGpK5PXOk2jhuGfQ1uWP8BdTIxTEV3o5FhjEAyqnPqHE/ihaEpNOWCUhCU/cJohukg3YNMhEFTZkxYd+Uqyu0QfJDz1dSkFmkDc7ymCNKFe/qyhwinfQe8IOHBwmlKwvrNoj0RffvrAg697l1Jdx3dP9Gr79tkW+6aF8lU8yEVjR0svtvQ5pPoHfNLdYLvegTntrEYa6r+lKc4kpQWirGCJgO0ndQD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cf0RKnkoKlWzyRU7pKlIqRlsiani+9wXY85bnkWYJs=;
 b=OWFjBetailRDqkmiu95QO0Z5fYt8g2DixKeez7p4fEXMM+bfHcafQcM+sj4DG+0AQzhQEX83OsJDOyzWfQTAHw1swnXMS9cxniTSl9imyUaBeKDQ+nJo/6yLDYRiGeKZbrVKdZxnNLj051CztBlwEteGe2ewUcWjEL3ecWS78iPvvCDDEDkJIBvscoRIaazRkTdVl1EbI/hHOXzLYJ8ttONvlcSkhho3ZLgDS1Nb1oucnD73Xu2bzmauTmmF1PiuwViybMQ8uuKbJEJnYuW07OHpym8MlQDio/ke6g04NLZELhyipGD1QOcYcjryjOmMLHvuzDlHjB9mYYj672D88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cf0RKnkoKlWzyRU7pKlIqRlsiani+9wXY85bnkWYJs=;
 b=pKIoZJ4plSbD12itoTDXePuvMsHf+xybpWc91oWmoICYXY+p7KhQiWCZDFbVqER598x33wHHEjdHYJ3qYyK01cKozItH2YBXYqmpSQV35Y5Yz9bDrPPLQGnnEQuoz/azVwHxf7KyXEBt+7WIUQWF1cdj+0FYsLZ2LXUs0jqEKTyTPIEqrD/Pzqu0aRXmOKd169lRcLEdXKaeGbMBjpsschxdjHg2WV1Zz0On/jWMGo3SuZ6rUdqvGTv/GKEx2XdPLPldUqy2G1Ldk6fT4FXZD93BPPLjWmXXJFT9DQ36ijBn/zBbbo/baXev21llKVtFJlOkny5NwbD7u9ovYKq4cQ==
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sun, 3 Oct
 2021 09:13:49 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::77) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Sun, 3 Oct 2021 09:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 09:13:49 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 3 Oct
 2021 09:13:47 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 3 Oct 2021 09:13:45 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <stefanha@redhat.com>, <oren@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kw@linux.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/2] driver core: use NUMA_NO_NODE during device_initialize
Date:   Sun, 3 Oct 2021 12:13:43 +0300
Message-ID: <20211003091344.718-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ce1b26-7907-4125-16e4-08d9864e1c92
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50955FE351BBA0C5F66A131ADEAD9@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogqkCZ8e1qcv4dXGOdzAVi4DnkGD5nDV+0cSLHmcQaKhR2pQhFCjKz25NbnWlcZG/nJRONJZ9DEGUQRTNnTSy3sq3AmrOf3lfrSt+sYfcWUYeiIZAMVLS8kxA/M/QorfYDczqeI8c2rqeH85zh6hzJxt82a8HP4a16dXXVZ+IubBeHHz6qH3NW8WnYPRjdv8mvIPeUhQDZZlUxNdM7jkciXAhIjwkPI4LZKwBF7DirqmxbfRsISD99ZTbxjYao3MGNq0St7Y3GT2DWDVYd21EkTax/aSXQO5i06QTbo0Pv2jwKB57mt/t96uYw+utmNjEiH21g0swvDTSi2w9PDGn3Id65eV13ewgQDtEpBWOBKXSTyClqn/8fJDQxlEpE6t+8h1s0k6sAMSVK7tYQhMDGAjL601PWRWoF5+0eeaC9HpeyxiRMSYVTueqn0m/GXPMdRFPiRbdiquBxVT81H8ojCZytlCnOfAR/ywdHsvlKCiUuMPQ42NEuh863fUG7UwU26BACYJEzluezuAf/l8NnhbptKju9sPyhKrqzwcD4V992qMHXbsqKXdQ3pxeygHU7BS7cvvXx8UxpvzPNW+dJ7D4U+fcOuknx/36KtR6S2sJ6Apxs3jXS6JSA1P8WeFMUd5o6vXbB8GLB28DISZOv/rnniLVCaaOYlzMla4eu3LAbJ9dHBby9/wdFJ2oAZ2HLat7ddMzu7bDDA2VMMR3Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(426003)(83380400001)(107886003)(186003)(26005)(47076005)(5660300002)(8936002)(336012)(4744005)(1076003)(2906002)(70586007)(70206006)(2616005)(54906003)(82310400003)(86362001)(4326008)(36756003)(7636003)(508600001)(110136005)(316002)(36860700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 09:13:49.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ce1b26-7907-4125-16e4-08d9864e1c92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't use (-1) constant for setting initial device node. Instead, use
the generic NUMA_NO_NODE definition to indicate that "no node id
specified".

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
 - added patch 2/2 (Krzysztof)
 - added Reviewed-by signature (Stefan)

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

