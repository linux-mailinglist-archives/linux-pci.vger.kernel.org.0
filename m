Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97970FE3B
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEXTHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXTHw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 15:07:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6EB12E;
        Wed, 24 May 2023 12:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubap98wO65k5/9CnZSUilxkgCeOYr6tA2xfUSRuyuDrXqWraAxv3jQ1LyfGZ7eOgLJmlOgj/Y/c7UqRfyFMbONjTwwZuQK0YhBuEeMX1jk/S8p9Ag1kMPNdfwUVoOKevhdmQI2zP56+u36rIvnJUzYYNqWg6yC2Nze+T5C9EzfjScmhEuQg89H7hwdyncs5EsL0DI4WJ/lKKTu3c+4dTPNFp8DtH8O6WJiRLuREmFKt0V5CbXlDGZChbLpIYQZqNps7h9cQL13LgNfEpAWYV7bdCSZJLjZlFi/AJEW1JP06+nmzxWPQ0przlZyMlnC+C/54C96NGAcvKQ/U2uwIL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSYWzcp8wMhvhiUJASaUrK3knaPwcQTaxUWCltf0ZYQ=;
 b=fKy/PC8YONQcTvJTKGzUEN3yEcX5jiaq1d/a7LpFzVNhlXk6A4qgy7JBK77NrY5296MuyNfBhGP/pz075m/lQPYji4Bhu3uWUZ0cX3ZQq6juo/qGgUINHhw63KwapFHjp0PdoSGaJ11oUYtkEArhsBVtaDugORzMbhALWU0bk936StvvDMfBAg2zr8caXvmzzFmKO+f+HX2GryZ3ZT0r3in6lKYR+pVfkwBgDusbDtWUPL3qoUOEFp4pwnRYZwWT3VzAu0Bny+JKeb7U/5Dqxwo+IW7BnJANyF7qyev9Sn6+SHT+3ebWHWg3NZSFYta0drWqFwNHwbhINoUEwlHlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSYWzcp8wMhvhiUJASaUrK3knaPwcQTaxUWCltf0ZYQ=;
 b=HhaJ1Ggf73BgSRMFr/azOMYy5VuxhlJfowVX9ZXMoNIzP9KQvbhbYOTKnQlkTrTA6hCVMwJ4NAyYGucygNjJw5FmziXNrvP9FFdN1L+2NpgsySJJ6JYTYRVjdIyb/sdnKnoSZQjfkz9lMwbNl7PB6mCUXWQPTKhYXDJBfFpqkpA=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 19:07:46 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::d3) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Wed, 24 May 2023 19:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Wed, 24 May 2023 19:07:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 14:07:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 1/2] PCI: Refactor pci_bridge_d3_possible()
Date:   Wed, 24 May 2023 14:07:25 -0500
Message-ID: <20230524190726.17012-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: eaadf609-5a8a-4df9-6c60-08db5c8a28e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eevwNxqVm41Sf+A+jT7xOtfccVDjJJZBzGhyUVpNFrcCh1Zwxdn54vU7a6/DivEoVb84p86vqGqLlu9qgJsBQdpixcT3w/CS7REpwOSNvx3qWuJTPFn4xVQNG9b3KWpNl3WXzYX+r4elEBVEjI/hQe9rLXCfikDn8Pk9MQdFF5WUY8IPSY4gkYwcMJu853vuitTT9ci34QlnwYvNdf6wdcyss+17DTtVOWNYRmCFmLwB9VMMXheX85ayMSuasapmG9Erg84aSmwg9ZSfyc1/9Us0N5gq4ring3WlZYijv7co6IGzPX5I/+LX/SGHXFCc1Ltq5ajX4QdYoPD68vH6bf2vaLfRqfwcIrAiWzjJCEDdoCZdzntAh9rlhzGvK1Rmn9S9G8Mci0BBACxgNvRzW6K7BrpmCfcbvOvoo7dLSpHwF9Xmtf3HWsOoafXYnGxMUlqEnp1g8yxedX2VFrKynlTi+3ZctaS+77tnnYi/GLXWTSsA7a1iqo090FKBk/jLDqYYIzzAjJagjP3UZPwup59e2anXqOu6OJtW/O3HSRAETYDUl99jrAsH8T+Uj9OIoqz4Le7E06ZUDIYidmU7RACKpiXB2GOBppv3bHN0VERt7gbWQYRDxh+og0JB/jLe8feyZERzn/ybkDCx5mCYIPEd9QPhK+jU3g3W1xcx6QDwrgxaoEc1yP4p6OF3GfIGTjUnnxBkpp2lWR9l45NrVFN3W4iNMjkKQIrhpdkbtuF441ZDQ53SlO+dsoEur8eRkMp2cLPeuMddhkkuXhQ+3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(1076003)(82310400005)(186003)(16526019)(54906003)(2616005)(26005)(7696005)(6666004)(426003)(336012)(356005)(81166007)(82740400003)(40460700003)(4326008)(47076005)(83380400001)(36756003)(110136005)(8676002)(316002)(36860700001)(5660300002)(70586007)(2906002)(70206006)(44832011)(8936002)(41300700001)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 19:07:46.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaadf609-5a8a-4df9-6c60-08db5c8a28e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All of the cases handled by pci_bridge_d3_possible() are specific
to these branches:
```
	case PCI_EXP_TYPE_ROOT_PORT:
	case PCI_EXP_TYPE_UPSTREAM:
	case PCI_EXP_TYPE_DOWNSTREAM:
```
Drop a level of indentation by returning false in the default case
instead.  No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * New patch
---
 drivers/pci/pci.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..d1fa040bcea7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2978,48 +2978,48 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	case PCI_EXP_TYPE_ROOT_PORT:
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_DOWNSTREAM:
-		if (pci_bridge_d3_disable)
-			return false;
+		break;
+	default:
+		return false;
+	}
 
-		/*
-		 * Hotplug ports handled by firmware in System Management Mode
-		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
-		 */
-		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
-			return false;
+	if (pci_bridge_d3_disable)
+		return false;
 
-		if (pci_bridge_d3_force)
-			return true;
+	/*
+	 * Hotplug ports handled by firmware in System Management Mode
+	 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
+	 */
+	if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
+		return false;
 
-		/* Even the oldest 2010 Thunderbolt controller supports D3. */
-		if (bridge->is_thunderbolt)
-			return true;
+	if (pci_bridge_d3_force)
+		return true;
 
-		/* Platform might know better if the bridge supports D3 */
-		if (platform_pci_bridge_d3(bridge))
-			return true;
+	/* Even the oldest 2010 Thunderbolt controller supports D3. */
+	if (bridge->is_thunderbolt)
+		return true;
 
-		/*
-		 * Hotplug ports handled natively by the OS were not validated
-		 * by vendors for runtime D3 at least until 2018 because there
-		 * was no OS support.
-		 */
-		if (bridge->is_hotplug_bridge)
-			return false;
+	/* Platform might know better if the bridge supports D3 */
+	if (platform_pci_bridge_d3(bridge))
+		return true;
 
-		if (dmi_check_system(bridge_d3_blacklist))
-			return false;
+	/*
+	 * Hotplug ports handled natively by the OS were not validated
+	 * by vendors for runtime D3 at least until 2018 because there
+	 * was no OS support.
+	 */
+	if (bridge->is_hotplug_bridge)
+		return false;
 
-		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
-		 */
-		if (dmi_get_bios_year() >= 2015)
-			return true;
-		break;
-	}
+	if (dmi_check_system(bridge_d3_blacklist))
+		return false;
 
-	return false;
+	/*
+	 * It should be safe to put PCIe ports from 2015 or newer
+	 * to D3.
+	 */
+	return dmi_get_bios_year() >= 2015;
 }
 
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
-- 
2.34.1

