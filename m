Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1277692E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjHITsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjHITrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:47:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE82707;
        Wed,  9 Aug 2023 12:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFR8IxUhGxa8tAllbZMoDACl/rO6CdAYvc2pxLa4YrnXXQ9TftkTBJI/SxeWy3Y14CGpvvwY529ljdg3Rk40XPfj7Wy2wqBbi6nQN0+UhOajP+qrsdwn9nMykwQXVZTZnGmUbnq3/gK5reElAOYp66Qz4hbxNPKrjq4Jhj9MHQXdJ1VIJ0OCpuw5YuZJpwzCaLvJr1bZ5BNjd5ltK1MENK5s9h/xDh5hH5du8hLHuTfk9irzGbtF/S9+/qOLoT6agp61YiK4r6x2CM/OgMaE/0N+tkcG2EY2qDf2LN8YOoL03q3cFyZGwx0Xzb47KZxTrgZPvdL2HeQfPb5pjNm53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=KCg0/rYopcrFNXgMeSvXevcvrgRqUy+X42Ig10/Br/J9krqnG6Hk8N4uq1fTR6DpX/rm/f1t8O5yKLNmLrF+XIg617NzTt++PItU+CipLlHY1z4GCx6r2Uy11tVhS4QUHNZSmZ90dbrXl3sK7B25T4MC4Yn8G5imlAW71HxI6ytwgl3zBHIyqGZpXGdNAczrN5VnGJGPdq6dViQ8dmnR7VQh3nlXHR9Bf2OxZU8JpDqxWAGX+qfB04ELm1vSe5juQYV8UoTcfDYRqlvDecbOFTOFExx2L/7i9a/ucdDrGKxXexyHwI6uYURHmXYbbMJr2prfGw4TFwLNUvgYeikEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=H5L5B/FKPCZ/8xeds+gs0eQKvgVWP4Xl6uo0lxNRIL+qCM+V1GGCsXmHoTOFdxIWFZ8h2VqyPdmg4ROnEKyPlFHb4IkEd9dKlJs4jGwQ+K53KBq8pFjPR0PVnv+JJ4rpsYheXEirG3L6vwKZWdrCw6LR1NRFDFmu/KXm13Khhu8=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:47:21 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::6f) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:47:21 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:47:18 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v11 7/9] PCI: ACPI: Add helper functions for converting ACPI <->PCI states
Date:   Wed, 9 Aug 2023 13:54:51 -0500
Message-ID: <20230809185453.40916-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809185453.40916-1-mario.limonciello@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3ec20a-7055-4942-9ce9-08db9911725a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGipiBgWgACHlqu8io5shbGvJMuSwdJ6BsK+GVGnfqD+it3l1rGyp1ldCOjjDwTT5nBtfGyC5otXvafpivxC7Ri0ox54jFjzhjxGhUG7nqNZdtiFe5JZytBb5s5jNyJBu3GU3aWXnq1EEKAfOLvL1ZF2O0JXba1sVqdIA0+OzBD38Y4mZ4QSy+0OcfGYjnd6+64lLkFAzaVpiyPZmQ9ul6ccXrlXKtOlo8yUg5agstCphZuKuNTRcFrzmpGm3a7gfvGjDxNrhLpl2F1WohyJ8bhEWOf9mDgukpBBeuUK2pOHaXPSEsC/J6Iici9GgSlakIFuzobdHw6KevXDJLTtm/lqMies1UxDn1N20htY5hblb07FmUFiqQ7MaM/cViDizY8vvhp66khzLtvjGEyw62FLVHBB3ARRe7znA1dzal68e4d46WpR6EtXTW4dZHV0QW6r4QPwWldWaLn/z1NBaeSg3znTh7YXfIbYMHduwx1g+JDiIzwyaiAalLYU3qfXlP+Sw7VT+ps3dCCK3N61FCN74PVof52rM1f1awEgyY6WrqOiGT7WPXolCo2bD0/VoBrDJ+xPMzFIe2pV+aJmBfPptXl0PtnIWad/MRQvZI94lO5CBg1UMmuTaF48h8XUVmLQ5dCgI+xtSIsSKtrgFN7qD6Odw4w8bwAQy0Q5EPmrJqtVHLe4U8/UiTE93RtwUjHjMpYWizliZF++Br2OgHt6cN6zKu101NTYJ+/8hf1JKDCR9+1ETHqDaPO0oFOUQqruKgHhFv43vXGsz8S8UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(1800799006)(186006)(82310400008)(36840700001)(46966006)(40470700004)(356005)(7696005)(36860700001)(86362001)(478600001)(2906002)(36756003)(83380400001)(40480700001)(54906003)(110136005)(81166007)(70206006)(70586007)(2616005)(4326008)(82740400003)(26005)(316002)(41300700001)(47076005)(40460700003)(1076003)(16526019)(336012)(426003)(5660300002)(44832011)(8936002)(8676002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:47:21.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3ec20a-7055-4942-9ce9-08db9911725a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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

