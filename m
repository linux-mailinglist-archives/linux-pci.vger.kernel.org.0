Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1C420FE7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhJDNjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:39:10 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:3553
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237199AbhJDNgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 09:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdeTtRxV6yHNNxvQIxZB6+N9Xp9TpysvJqBEjpM6TbjC6QwYCuzxUDM9gegrQE8HVPO9fSekTFcejEZpofiCZNBZxd7pFOIXt+PBRP+1YCgPvNMHbeoRLungdQTCO9s7p7rTmivz8qSMUhyedsgjWxlgi8bwA8UNWVfwN4U4wcyhuGbIRuctGu5Em5MRcJMCmZ4FEr4V14KLiMRABGvbBAOZv3sV/ykjKr3sbK+fQt3sMDJVRpfqjOax6Pmenzdxm8IcsA0DWENKy7EQYs2mSkzCsl3HOo5OdJ/W71NQwVQuM20NDMB+1GY0gibmos/+3Klc1grPBBrKslNTlIm1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W+B5oObK3HJmhtfEy7QFaF4iakPNE9ca+/bXYC1MU8=;
 b=LsvTpwsUs/dHrBxbPEPKmVm8RP6Z9SKg+TE2uuVeVhZd3njA1qHGch8nIhC18oLGYJ/ilKCIZ4WowsxZ4aQDY/qgAUWqqoJL+cIsnwn34hCBaB0DXFR41rBVutKjwfJwogLEoIn8+o5+W15wC1cs7hjK4okh10yWFzAcIwYVnAMIgpTlClqgm/S6TZTqPqwY0tQcrjqnAeLb73EFGLhST+hEIpz3r7vhWQF35GGKpZo6EHQmZerbGXFUCT/LD/novqRNPL04e660PZP4fzoBCGUxb8NQO//91Hkh9fMPom7XpyacqetVZ3+J9kQGSed1xwVjKiMDCRgEptkJDOS8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W+B5oObK3HJmhtfEy7QFaF4iakPNE9ca+/bXYC1MU8=;
 b=uelteGuNw7uVicRUD5/sEckjlFsWSkoijCttexZXNsiHv9wwidQDN2lsSpRvjqx8o6YFw2vRh6K+tgAyTHGETXWu/WWxnVWbyeG6SSjv8eP7rw5baAc7iprTKauHoCcj83OLw0oCzrUeOKf2FtLwJtwBdm57GBl0KIPt2QEXXYTwwb+WAa3cDB/3cu2opfxkfMKhxMvA3Hv4ffuv8O1qizqIZzRZ1ZTvtS6H9Ka26kW7XcT3yOtwAmYNPbZ85WfeGHKk4MNAVOn/7TYR++0I0k09bMKPBi8Q/Niv2hjH6TM5s2l/p46MlRgIM130m9/nty39ZV1dKPPUsBynoChnZw==
Received: from MWHPR12CA0025.namprd12.prod.outlook.com (2603:10b6:301:2::11)
 by BN6PR12MB1602.namprd12.prod.outlook.com (2603:10b6:405:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 13:34:58 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::1c) by MWHPR12CA0025.outlook.office365.com
 (2603:10b6:301:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 13:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 13:34:57 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 4 Oct
 2021 13:34:56 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 4 Oct 2021 13:34:54 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>
CC:     <stefanha@redhat.com>, <oren@nvidia.com>, <kw@linux.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3 1/2] driver core: use NUMA_NO_NODE during device_initialize
Date:   Mon, 4 Oct 2021 16:34:52 +0300
Message-ID: <20211004133453.18881-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368fd2e5-952f-45d0-fc7a-08d9873bc209
X-MS-TrafficTypeDiagnostic: BN6PR12MB1602:
X-Microsoft-Antispam-PRVS: <BN6PR12MB160255E38614A7A6D4F2DFD7DEAE9@BN6PR12MB1602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTYnTR8T7vjiLHwwaSFSCCi8OHItiv0ChOu3Q5jvFM0rlo+esR4nSf/zIE9dH05XKa90KVsDIG7O187XcbHWurq7sOqbLA2EJ01LCCG2daDCqry/v4wojB4jgULOelOenDJevnZVjzZe0zZ2KuNu/v5GipqveBsA6sxYioTXGQAJmDu/tQMADicCaluK+OKYS2SUwTYtVmvZLxf0mjdWyWreeZbFLyon+BNH+0jO8toecc2WEfTbMpI0HbzMzlANerHvWlKDhXwUaIt4nkwIqoNUOvtrCspIG1hyY6/KHQAux3jMj5J8bH64j64d2QvJadTrns2qGPK/AbL55wh1+vsbguex33qDO1X2d1eDx6kJlelkd4fTdkVxUPPUbXHm1SLJdIsQ/Aw+lit9qc5BzeUkgBuUzKrSgsQ3c9nia0uGlLZ1Hn1zeGbbA6Qd7Iwe+XbMw87LrZpuoakxGsVMAw2hjoMwCyGOCYQIbK3AgO++LxfWiLdFTvh6kgV/w4NVjialStwV9c6v6WP0tC+w2GNs+5WGKOTtYcI+pp++a0UqC3l8+z/Iz1KseR9RbIH39RQMybxXTkumOyEhWhDLVfl/mCR5YTeZuDTKITHbSp0Zgca4ErBIvr8WUxtYCUnP7IC/a2bdR/wK48R/CS91aAv7sDYOCoXgo9DO9Z7Wdt9W3USQ2mr+V18IVmUWCf939DCjh9WWpNIporEjQpBX0g==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(83380400001)(2616005)(1076003)(356005)(8676002)(316002)(26005)(110136005)(4326008)(5660300002)(82310400003)(86362001)(47076005)(54906003)(36860700001)(2906002)(70206006)(336012)(36756003)(70586007)(426003)(107886003)(8936002)(508600001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:34:57.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368fd2e5-952f-45d0-fc7a-08d9873bc209
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1602
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't use (-1) constant for setting initial device node. Instead, use
the generic NUMA_NO_NODE definition to indicate that "no node id
specified".

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v2:
 - code conventions changes for patch 2/2 (Krzysztof)
 - added Reviewed-by signatures for patch 2/2 (Stefan, Krzysztof)

changes from v1:
 - added patch 2/2 (Krzysztof)
 - added Reviewed-by signature (Stefan)

---

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 15986cc2fe5e..a705b85656df 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,7 +2874,7 @@ void device_initialize(struct device *dev)
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

