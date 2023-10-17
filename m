Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE547CBC8F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQHoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjJQHoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B3106;
        Tue, 17 Oct 2023 00:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa8eJmDGTGlsyR4ZIHtEi04CNBmulXk1HgHTXRzLtjasUD2F9p+aKXWLNVUxSv6PSR9bq+WmGqTA3Cd9dQKgWPEoY6DXion+vEGMWqx6rFtqZQJ2q/FJX/c/QqLMhs+6Rx3GQYzVWlip3m9ftGeG39VBsJ5rXJJ78up9mkcCWHkKt1nTwtjlnH+YrgtfmYPIbbGQj5bvYaq434GS8gwpOh5yD5pqb89HHZI27OZJzJoQ4FoF+mWDcLbWYNXeuTTN2BIulw9fQkAwJhzFlHhYhyPedOFViFJTuJl+g85lG5EUCOw7tuYLO0RBRDsxXLqe/p/B4qjrt9m6XKxP/4px8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGnYnIIBghGO5sxadBSTNx7BruaTJrIx1/d1ZKzo8HQ=;
 b=S52IDoE+APRkokwIJAAjuG6l+JwktanbATARbDhgjxzFqBZaJqOapNy9mC0CvRJqlQMtb+mA+dvIVEWNnGzR7uzkP/kv0kP0sbdm9j/hnaD4WAshtF/zVqSNwh2+ZdjtBYiyXMwQIq+qwZPfNqdLYcAoMHxKcKb2V++FmI3Y4oliZ2nr7VeFTXQDFIrCrsncjPPSTvPSbWxbOf0Hw+yxClBfhmFpJPWbS6YySp10iwnvPSnWnuUU2Zz2BI1xWxu1BAAiiZ+glDc7+EhdyqaHshXyK8KrnNhZWKs+7/BuuXCbDo1sZ+E2tstpMmxWT26UbGRbiR42UA1cud96Ff7Miw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGnYnIIBghGO5sxadBSTNx7BruaTJrIx1/d1ZKzo8HQ=;
 b=KtqHFKu5Ytd2Oy7x7S6cH7CII0H985ypzau1X+SUBNTYbAAlJp55zsBm0zD9SeHU75Ecq51yeVXYpN7w1WaWBw3FnR6dULzEJqbp/Q+2ozNCNrLRSTdIjSqgtBfR7HdCv6ZcCiq4THnzY+x43BtuL3lv8kDIIbS/ZhfJ2vKWkluDunlT/yblA9ALh+pdOd1wAN4HyiO6rVljGf+fLVTIDcEheJSMlml9Bi4wo+lsS36IqMxFQyRvbnXRpuhau7C9d5TJ3ACo4sT6QyIUKucXRuwF/3TUxeyMB33OD5FXE7kvHxVDdKM59o0l2Lr8+WldtNA8Mvftmluv+1bvuoMfxQ==
Received: from BL1PR13CA0153.namprd13.prod.outlook.com (2603:10b6:208:2bd::8)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:44:13 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b3) by BL1PR13CA0153.outlook.office365.com
 (2603:10b6:208:2bd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:44:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:59 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:56 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 06/12] PCI: Add debug print for device ready delay
Date:   Tue, 17 Oct 2023 10:42:51 +0300
Message-ID: <20231017074257.3389177-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017074257.3389177-1-idosch@nvidia.com>
References: <20231017074257.3389177-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9585d7-aeec-4b8e-ea70-08dbcee4db53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzoXim9qrHSwM5Vsbs18jaNlgq2n66lw9TvVQBmkbbXA4a/7X/DkyDvvE1v3TRVIBjGS0oQv2v7iodwkwMEFfZ1bVpcE6ars6QYid5lpBFl10VBLpGh8fvwSLQaJRZD8jHsU4Oq2XXJO5isFksowcjACwCX0VD3hDlJbXcQ0veqNI6DVBNXbBLIbLfmThy3ActAP5CpT4cK2x9dsy8LjGONi6pj4rqMlKMs2Ety27iLFGdbpfVI2VwVz65HhAqcdthB2l/2NZSEPC1FFFOsgl/vn2bjb+J0+zrGGo1bqKzlrPPjj1qBzf9WqgZlfTpTqPVVzlBZGLsQJpNfgAdKwIw3MzBmX4SBE3rTQ2UdCoXoywptNechFHmeFQ+zJm31PMu9Znl1z8BJQ4JWaqRKn40MJYTUGLTg2TprZENPURcqG2MvquWpefz//oOTnYXn7kZjlX96yExbrvRWYr6aXqdaMOs3NEZ+qpCb6RG35FWEdMUeM2oDK8O4JwMQzrwfILNGuHlvgWmbDGgtapjq5xtDwFalyp4NZ/Xxk06mlCzDGW/Uq4w87N7jC/+Y3G9ZK0iuwwEJX74fdKvkP00zJd4wLNOdxr4bvnfr0PqV2IFk7jItDD48nwHSIr375Re++KCCHyfpPsE8VJA4qmFmoo1n3VG/Hff24WEbyQxl78A9qYCjpxNe1JcuwNnWqiRJux7pXjKQkBqhox3aUBbM+L5SV5y83jR9lzWnWXy8xckQY/UF3eZhAJibLh0dF2p+T
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(316002)(40460700003)(70586007)(70206006)(54906003)(110136005)(16526019)(2616005)(1076003)(426003)(336012)(26005)(47076005)(107886003)(83380400001)(40480700001)(7636003)(356005)(86362001)(82740400003)(36860700001)(36756003)(478600001)(6666004)(2906002)(41300700001)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:12.8601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9585d7-aeec-4b8e-ea70-08dbcee4db53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the time it took a PCI device to become ready after reset is
only printed if it was longer than 1000ms ('PCI_RESET_WAIT'). However,
for debugging purposes it is useful to know this time even if it was
shorter. For example, with the device I am working on, hardware
engineers asked to verify that it becomes ready on the first try (no
delay).

To that end, add a debug level print that can be enabled using dynamic
debug. Example:

 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready
 # echo "file drivers/pci/pci.c +p" > /sys/kernel/debug/dynamic_debug/control
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready
 [  396.060335] mlxsw_spectrum4 0000:01:00.0: ready 0ms after link toggle
 # echo "file drivers/pci/pci.c -p" > /sys/kernel/debug/dynamic_debug/control
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..0a708e65c5c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1216,6 +1216,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	if (delay > PCI_RESET_WAIT)
 		pci_info(dev, "ready %dms after %s\n", delay - 1,
 			 reset_type);
+	else
+		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
+			reset_type);
 
 	return 0;
 }
-- 
2.40.1

