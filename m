Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0F781395
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379700AbjHRTlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379702AbjHRTk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4574222;
        Fri, 18 Aug 2023 12:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAu1k7zyRsxY7amxrwEfl16UlIGs4l+l8MZKM2BYvWA5zXXChKGhpkk9ZrV7bHDe3MRRqNAdDbW9SPwEMvIQy51uowVd+xiDLg9bD88d1jM7fNeHzEh/Jn8Ez1rHTtfvGA4d5AWWniJyhVz1Y7CjjWRz5jBXMLjZED27msFFCRw5x1u4gpoghmyDBI3xSozniy3aMN0JUBJq5tjUWJtpqTmXJ2Jk3PL/f4sew3U/7KfIkKsBGdV1iF4TbdOLhN/9vq11NBrxRVnS+xCcXuOlFiBhtfiG2vb1nqAGNkUyAYxlUGhqkt7HicJlhZKf3teGpWBJATX8/G9U/m2SpYlNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=Y1gMtgUbzgx0DVYstfIp88Gn5kVG0wLMnKItlFLYB2DsJkrihHGe/jgAmMqPX0Ez5dPp7dCz3knRAGP7j14FgkZ7cvbVlCuyS4u4O4TbGavL8oypSX9ugxFSljdE8807EQpIJp5rAYvr81Tvt8fnJuTSmaVpgtDDGKK7A5z5Hpx3doEGmtnAtkY1JZ2JJ4X4Ez5RhoM9JFlhC71WM0l2CrZtz8Fh08jheSVq/aKQPPLsxUjRg0G9BEtQKe2c/NYM6UOU0CcbKvzqEBffqor23A45lDIeqG78E9/ySHPiVJzIj8fl01N/uvBwasdDXSESY5yKen6b++s1FHbP5o4lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=EbpeAg91dy+JuiT8eS8DMA74IGCVW9U9wC1OeyYjzt5/UK96oe7v6QvGdoNbWQeUgSWZ20hxR3fWfOLMK8o7fkHxfkYgmtuX4HfbdqJdYpRSE3boGtnoLN2zqsY4E31VgvuXBfUmB2y0tuIThbngSipkKdfVAe7K0S0ntDAlQNE=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 19:40:47 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::96) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.c 1/4] PCI: ACPI: Add helper functions for converting ACPI <-> PCI states
Date:   Fri, 18 Aug 2023 14:40:24 -0500
Message-ID: <20230818194027.27559-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818194027.27559-1-mario.limonciello@amd.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb3a66f-658a-40e1-8103-08dba02304fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: veFVNV+UilsZxmdqi3+NzK/4GSFAWt6vYeLTXRh4BFXVENeAtwFX0nXFKEvEQ+EPwBeQaQT6rf48ntMMJvPpQENflOM7jZaUQzBPnqNnQuwv8A5nX74P0pC4qzq8H5eSuip3dngzEMnJ7UNTwR+ru+NjbUE3XMTd2hbH2I0BNvas1U3fHalpLRfpnhNbf61KLYwfJ9TTzHOJkLpniHtQ39w6eOcBkR5uvAjXSuc9Gn9SHAZZtxtCisJ89p0mLc4udSp/1bwOicLZhCXaRBfaYJmjG2rTakCjPnbMHF0pde9tQYZqUsZ7MBEE9jAraZj5W4z5ia/t05mCV2u335MrHDPXjUOsi1UBYGtipndVf5wedyPsGLdepWa3xeJ9Aiq3ssVRCqbmVHYF4GRnU970CdVPnwCb/ePjTw4ttn7v/SHpXofTysdudk1LarWu0P5Axnl1HT8DaxtQ1rsdjR4mm9yLTddx3cifY2u4IcvvDGsuRkNvEw56hmKEYv4JWG1w2Z/sHzg3z7bfzPVyG4+Vvs9xoQYH0nquCqPi6BTwXMF09u4+LdijMaYtNwfrFCoSLD7E/mM7impqpARXAAP//Y7m6BJLwF+D+G1p8/B9M4hkl5SAvliJNzWp4HpFqkzV3srziWog+dXHduFdPJnKlrpBd17va0ilVR1lUJyBKQh5Ce7XSi5Fr5FENv2AVzHEHyV/M8manqaADSMUkxm3TxTV7W+KFwuutGIFVC0bZWTQ1r/zV6vDrj4swoQNTy3orRfBVwxjAYq6BM6NFAe7YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(316002)(54906003)(110136005)(478600001)(81166007)(356005)(5660300002)(82740400003)(2906002)(44832011)(41300700001)(4326008)(8936002)(8676002)(426003)(36860700001)(47076005)(2616005)(6666004)(1076003)(26005)(7696005)(336012)(16526019)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:46.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb3a66f-658a-40e1-8103-08dba02304fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Several functions do internal mappings in either direction. Add
helpers for this functionality.  No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10->v11:
 * New patch
---
 drivers/pci/pci-acpi.c | 87 +++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49cb..b5b65cdfa3b8b 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -884,6 +884,56 @@ acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 	return acpi_add_pm_notifier(dev, &pci_dev->dev, pci_acpi_wake_dev);
 }
 
+/**
+ * map_pci_to_acpi - map a PCI power state to an ACPI D-state
+ * @state: PCI power state to map
+ *
+ * Returns: Corresponding ACPI D-state, otherwise ACPI_STATE_UNKNOWN
+ */
+static u8 map_pci_to_acpi(pci_power_t state)
+{
+	switch (state) {
+	case PCI_D0:
+		return ACPI_STATE_D0;
+	case PCI_D1:
+		return ACPI_STATE_D1;
+	case PCI_D2:
+		return ACPI_STATE_D2;
+	case PCI_D3hot:
+		return ACPI_STATE_D3_HOT;
+	case PCI_D3cold:
+		return ACPI_STATE_D3_COLD;
+	}
+
+	return ACPI_STATE_UNKNOWN;
+}
+
+/**
+ * map_acpi_to_pci - map an ACPI D-state to a PCI power state
+ * @state: ACPI D-state to map
+ *
+ * Returns: Corresponding PCI power state, otherwise PCI_POWER_ERROR.
+ */
+static pci_power_t map_acpi_to_pci(int state)
+{
+	switch (state) {
+	case ACPI_STATE_D0:
+		return PCI_D0;
+	case ACPI_STATE_D1:
+		return PCI_D1;
+	case ACPI_STATE_D2:
+		return PCI_D2;
+	case ACPI_STATE_D3_HOT:
+		return PCI_D3hot;
+	case ACPI_STATE_D3_COLD:
+		return PCI_D3cold;
+	case ACPI_STATE_UNKNOWN:
+		return PCI_UNKNOWN;
+	}
+
+	return PCI_POWER_ERROR;
+}
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
@@ -919,19 +969,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 	if (acpi_state < 0)
 		return PCI_POWER_ERROR;
 
-	switch (acpi_state) {
-	case ACPI_STATE_D0:
-		return PCI_D0;
-	case ACPI_STATE_D1:
-		return PCI_D1;
-	case ACPI_STATE_D2:
-		return PCI_D2;
-	case ACPI_STATE_D3_HOT:
-		return PCI_D3hot;
-	case ACPI_STATE_D3_COLD:
-		return PCI_D3cold;
-	}
-	return PCI_POWER_ERROR;
+	return map_acpi_to_pci(acpi_state);
 }
 
 static struct acpi_device *acpi_pci_find_companion(struct device *dev);
@@ -1056,13 +1094,6 @@ static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	static const u8 state_conv[] = {
-		[PCI_D0] = ACPI_STATE_D0,
-		[PCI_D1] = ACPI_STATE_D1,
-		[PCI_D2] = ACPI_STATE_D2,
-		[PCI_D3hot] = ACPI_STATE_D3_HOT,
-		[PCI_D3cold] = ACPI_STATE_D3_COLD,
-	};
 	int error;
 
 	/* If the ACPI device has _EJ0, ignore the device */
@@ -1089,7 +1120,7 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		acpi_pci_config_space_access(dev, false);
 	}
 
-	error = acpi_device_set_power(adev, state_conv[state]);
+	error = acpi_device_set_power(adev, map_pci_to_acpi(state));
 	if (error)
 		return error;
 
@@ -1111,23 +1142,11 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	static const pci_power_t state_conv[] = {
-		[ACPI_STATE_D0]      = PCI_D0,
-		[ACPI_STATE_D1]      = PCI_D1,
-		[ACPI_STATE_D2]      = PCI_D2,
-		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
-		[ACPI_STATE_D3_COLD] = PCI_D3cold,
-	};
-	int state;
 
 	if (!adev || !acpi_device_power_manageable(adev))
 		return PCI_UNKNOWN;
 
-	state = adev->power.state;
-	if (state == ACPI_STATE_UNKNOWN)
-		return PCI_UNKNOWN;
-
-	return state_conv[state];
+	return map_acpi_to_pci(adev->power.state);
 }
 
 void acpi_pci_refresh_power_state(struct pci_dev *dev)
-- 
2.34.1

