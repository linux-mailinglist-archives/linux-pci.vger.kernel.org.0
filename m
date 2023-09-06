Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD137943B1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbjIFTQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbjIFTQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:16:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF251724;
        Wed,  6 Sep 2023 12:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2SWKWz1luwaFqrKZdRqlA8y1cC+CF3FdP7DeCyAUn8FwpISEzrjAyF52whqZX2SiTCY4z5j2F84qlAS3yq2Uo7u68e3JEbdJiSYXMWRPmdUZjMYgtdydwfRMeXP/N6fxH5JlIilctyIxu/+FRYOoIMGhybCsRVYtjYFMxxIPBnf5tnl/NPekG+vXkePT7w0UCCEcCB0iDADyl/M8xJZ0GgB/dT9vAI/btqEKBDaDy+FmEvGmRiNwAZf7LhA5RO4/bH6YZPopN864z2GPs4XT5MLgi+ZEnOq0LR9Dbb/Ay0Av8EVgMmiJ3cQnnQkvHQ8cS6lhdWn+phzrJEQwZXsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMINZpGe4Tmcf7sznCpjthcF3tkn9xAgC24SFAdpxHc=;
 b=Y/0KOS5e3JG27DWkQpb3+ejosjdc9CvrjjyyaUdvFcZB1+Rqo90ZwyTNcy9k94qkDCtpQbMuIeeoLOw+Lpm4mMs6JYINuouzVdnLMPc6aH5HQOkPaHD5Wf+Ey5+4hJCfoqqQkzgLaglo1vN8yO+cRG2DUv5qd3XVTpSRK9jTb6zUaBCVZmLV+Ob0Om9wH4Xk05rqnuI1w15p2eu8bwLfCGpYktPbqFeUdKxkOZYuDk5oavpYwfJkkaZ2D8olVvdEOPz0UVb7x6/J4Jvurj9gGBdE2lyKevaL+4VY2oX7frtfl3v0+uA0RvoLO0ykrZDmjdytV8rDcBEyhsQJa+5j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMINZpGe4Tmcf7sznCpjthcF3tkn9xAgC24SFAdpxHc=;
 b=neLGc+00M6Q2CbV2srI5k8mk0FZcsGzwYdLKoGqMAltLpyfX8aOULE7AWy0lvZjK/koPEyCofeoNx74jdSPsn/cMd682FIgnItiiVtZ/s8DDw2nC0N+UgoQIoSV0fn79vhbDx2J+NLh1RDa/vzwXj2Flvmk4UPzwkzhlnacn7Vc=
Received: from BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) by PH7PR12MB7161.namprd12.prod.outlook.com
 (2603:10b6:510:200::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:16:37 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::9b) by BL0PR1501CA0014.outlook.office365.com
 (2603:10b6:207:17::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 19:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 19:16:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:16:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v17 3/4] PCI: Check for changes in pci_bridge_d3_possible() when updating D3
Date:   Wed, 6 Sep 2023 13:43:53 -0500
Message-ID: <20230906184354.45846-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906184354.45846-1-mario.limonciello@amd.com>
References: <20230906184354.45846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 86805025-a223-4a3e-6c0d-08dbaf0dcac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A73mtvIsIPO3oMVwtiC/75u9DEM70BtoY/BcCb+MPwlRnHoje5O6GEYG8cVJ5Z/0pfnWM73orVEzB9MgtPVmXp6vKcYEKDH6aU5COKzu7Udr6OMs8gXGoepF2Oz7Fyb9v6ifmD6GtV67O/M/PLTwy4YG8m/r4iQQlCRWR7HwhT3GmPrfon+W1xeLCvbtoI6IGsb1/dRtJ/cgVjkW/2pw1WY+f7zGloe8tf9cjJ4xGDibxU/R6I/ngyj9T0ghPUvf0o8p0Ympn4e+3Sy2wh8qNseTTqPlshyw1KUr4Mrp7yGfjEfmGHvE4b4GrQmlvTwEHUEsokyeOWrt+gGEXiO0a5sNt2/X3nrujFBW5YmSVvuu7cQ5+Wt0cRtPOphM+VMQSK73Khv6iK0xdRELxCkcTrHIp5xOoYR+i4TBS5ENX5Thlr5XYf+MYQFNqel4xvcpNtOUPHkHZdoWqexWzWz1TTzreIQ0zmhZE12t7J9Q608Us/AbGmO9JRcIx1bY2nJ90J04Ti3Ae/abJRAp7hnkz7zJu4NqsgPfTp7tqwkc8gt9UISfHJoH98REC/IAQTibi7vUH2v1trEOQBn8g0eoZCZuIG8/8j6+XuUO5O+H+RmduGNzlKEEQkciYVLXJAMibYp42F6t3W+A8sB3lmVYZjpHraxakmJw1hajfp2LSpbGR7i1xFayImwXLcbpqVpq96472SQT5cdwUXKhomvq1Fq/GSGzqinFjVdL6mBzHSoMAjimSQRM4s5EljXfhBABGou7TVXO78ft97G8APj8pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2616005)(316002)(54906003)(1076003)(478600001)(4326008)(8936002)(8676002)(356005)(81166007)(82740400003)(7696005)(110136005)(70586007)(70206006)(40480700001)(41300700001)(5660300002)(44832011)(83380400001)(16526019)(26005)(6666004)(336012)(426003)(2906002)(47076005)(36860700001)(40460700003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:16:37.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86805025-a223-4a3e-6c0d-08dbaf0dcac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As drivers can report an optin or veto for a given PCI device it's
possible that pci_bridge_d3_possible() reports different values while
calling pci_bridge_d3_update().  Take these values into account while
updating the ability for a bridge to go into D3.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 06ab73f58adf..9004d8ea460a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3100,6 +3100,14 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	return !*d3cold_ok;
 }
 
+static void pci_bridge_d3_propagate(struct pci_dev *bridge, bool d3_ok)
+{
+	if (bridge->bridge_d3 != d3_ok) {
+		bridge->bridge_d3 = d3_ok;
+		pci_bridge_d3_propagate(bridge, d3_ok);
+	}
+}
+
 /*
  * pci_bridge_d3_update - Update bridge D3 capabilities
  * @dev: PCI device which is changed
@@ -3112,12 +3120,16 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 {
 	bool remove = !device_is_registered(&dev->dev);
 	struct pci_dev *bridge;
-	bool d3cold_ok = true;
+	bool d3_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge)
 		return;
 
+	/* Propagate change to upstream bridges */
+	d3_ok = pci_bridge_d3_possible(bridge);
+	pci_bridge_d3_propagate(bridge, d3_ok);
+
 	/*
 	 * If D3 is currently allowed for the bridge, removing one of its
 	 * children won't change that.
@@ -3134,7 +3146,7 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * first may allow us to skip checking its siblings.
 	 */
 	if (!remove)
-		pci_dev_check_d3cold(dev, &d3cold_ok);
+		pci_dev_check_d3cold(dev, &d3_ok);
 
 	/*
 	 * If D3 is currently not allowed for the bridge, this may be caused
@@ -3142,15 +3154,12 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * so we need to go through all children to find out if one of them
 	 * continues to block D3.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3)
+	if (d3_ok && !bridge->bridge_d3)
 		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
-			     &d3cold_ok);
+			     &d3_ok);
 
-	if (bridge->bridge_d3 != d3cold_ok) {
-		bridge->bridge_d3 = d3cold_ok;
-		/* Propagate change to upstream bridges */
-		pci_bridge_d3_update(bridge);
-	}
+	/* Propagate change to upstream bridges */
+	pci_bridge_d3_propagate(bridge, d3_ok);
 }
 
 /**
-- 
2.34.1

