Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CD7BEE9F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378964AbjJIW5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378958AbjJIW53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8AA6
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2PdPssT0g3JeFwMUoYBcfFtVfWxruyFE1U+Hnpy0/DnufJ/85p3/nG+8vBlor3NOgEAKL9CjN+gHXpCXXgAEusPs1ny14w82FhkUdJPfPgLVHFTWCJ+KLf+7z/D89UcUm8E7pHhEqosetMty0JdAdLJX3YMry0XL4kSBRdcl/TymdeV0IeMjamsWTcUWIE/xag6sGRL7uVabv3WDoISotxrZ454AmmPMKnwHsyNbjmIMT4oJHBLajC0fKEbRPIhSv1Ec9CF1w5ERpV+QfwC4jm4w68NSu0U5LwvZL4JbmwkBbpSDe4HXjFxCO7sbP6EcPATSuX25UOxoaAvIfzNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO9Q5CqL7Ci5cJI7FuQRoezylMaAr47+JW+6ufmsNn8=;
 b=Rcgmrg3kmkwjZjsgcTMK54p6ygoGLwqDAzsSy+7Viueuipw+oZaoIfgGYXffwCJhUU6K0pB/3p4VDXEyfi2QJx85AD/BKriOyMTwUuXofPB0NlQMT4sCr/bEJNlUdSLt6Od7mU27lceK3DOwbWDmuva9QgI+GxEildvLy35Ytyb3U5F2R3NiE8Yv6cNvMfq/K4z3EFzOjN8rzUoEXXobeS21eDZMh99Di8rgrE3SEnVZCGVx/Zm5UmAQDkk+OO5fyMze0cWJkRHz1yGRYWCrl8u9/GIJjGsZgHQRBHZlwhktiY6jiORRJR74/8Pc3smTKmsV91ZFbNMFLG+wnBxUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO9Q5CqL7Ci5cJI7FuQRoezylMaAr47+JW+6ufmsNn8=;
 b=25YzgBJSZQOukDKI/mYuoMJsbP/B9k5DN3Mq89xkP/owFK0bX3M/o0/jBQipdpzvNMJx9pmhiFmPgeZLYpRVKcrUBggLxwlW6kqAk+blRG6fmArIWzHYxzIWdvEd+FiQQCB1Kxx5bSJ5jL95SjW+6yPgxvDG8tc4MC0lNw4zhSg=
Received: from CYZPR05CA0039.namprd05.prod.outlook.com (2603:10b6:930:a3::9)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 22:57:22 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::8c) by CYZPR05CA0039.outlook.office365.com
 (2603:10b6:930:a3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.22 via Frontend
 Transport; Mon, 9 Oct 2023 22:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 22:57:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:57:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v1 3/4] PCI: Check for changes in pci_bridge_d3_possible() when updating D3
Date:   Mon, 9 Oct 2023 17:56:52 -0500
Message-ID: <20231009225653.36030-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009225653.36030-1-mario.limonciello@amd.com>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: c23e517a-9f32-4a38-ad6f-08dbc91b18e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqM5uI+UuPXvk1OY4x7QVHmTPIBvf3ZM90XrmyW6LmexOLpMOHGnMt1YeTVZooCf2v9xIcJuwDEH817UOPxssxfcsG9Ge64ojziUBr1OF8f8q4qezmA1aAfzS90zhVl278dbHWZWPoiXzc2/iw/bzsdcMK9x3tJxaYkNV5RX5vp/vOlnqiNCcPCK77NrCS10sURxmfKvSVIWbkhFm9kqFGI1rb+HnaqqFEz72fV0PcgtupMlmZ6u6FxJOJgIvCKuTEUHPI+f6rrcighqhXCYfs0l7Y/6lZmdz21uH/IJBEJUrUhD9U8Z7EmW0XI6MHE4vOYtFJR9LXvUGi76Do+bqXXGqBmuIolPGTRpsK17oZOPsvkMtXgpK28oDEFGgbi5TkvwIUDq4QlJSw3PA5rNp+9PPo0bR2RGuK/souc7rrEFQWUsNvjt4Qwt6WbO2AJ48lumVdz2lnJDV+YP+lV99LNMHtc6wnvYVsO0bq3vYRmWpBbBRaMUab5kYuHLedPAs0EZM5EUhtBiLlLrQ5LBz+mmotia588Scak0XFZUFIgr5ucse+Z2Aewo9beAh3499mFhPYsnZJaPwKm6/5ktzA9qRIu4/JCcdKDORQiakiMYb6SJpMnIQEisqX5G+gG+6+I0hGiAlfor/XIXRPjs2dqKIpmkP4b/NOaEK2hsw2FRnSLyVxbYEvEbnsp4J353ALAjzHtGStn/Qy6pHKJy2hPmWe1XP0yscsrusmrpVzAW4SoC7c/dXFuHmJZ7fbA4URKizZQDdw9fFZBFldN9Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(1076003)(7696005)(2616005)(86362001)(356005)(82740400003)(36756003)(81166007)(40480700001)(40460700003)(36860700001)(44832011)(47076005)(336012)(16526019)(2906002)(6666004)(83380400001)(8676002)(8936002)(426003)(478600001)(4326008)(70206006)(316002)(26005)(41300700001)(5660300002)(54906003)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:57:22.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e517a-9f32-4a38-ad6f-08dbc91b18e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
index 3b8e7b936908..77af444fcf1b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3094,6 +3094,14 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
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
@@ -3106,12 +3114,16 @@ void pci_bridge_d3_update(struct pci_dev *dev)
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
@@ -3128,7 +3140,7 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * first may allow us to skip checking its siblings.
 	 */
 	if (!remove)
-		pci_dev_check_d3cold(dev, &d3cold_ok);
+		pci_dev_check_d3cold(dev, &d3_ok);
 
 	/*
 	 * If D3 is currently not allowed for the bridge, this may be caused
@@ -3136,15 +3148,12 @@ void pci_bridge_d3_update(struct pci_dev *dev)
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

