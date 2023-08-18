Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5585780588
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356858AbjHRFPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356531AbjHRFPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED2171C;
        Thu, 17 Aug 2023 22:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFM2lKq+eYovLZxKCMioy2+K9/r5Y7AbZwtP23aSTwpzp9KqcoGhHLaLg5AvdJBqvA0/PkJd1JsZ1IBQmsU4FTNvtxM+kAO0GsgNSSmCFCHTMGjbLoaBPskaAmkfmrYO0YhvnFsqk4A462AS3nQgN6Kk3eeDafuQJJNJx76g1XDkMX6//r5a9aujfcm4VOzW2qKPu1VRb2JXn8iOmHGpsML0ngtbUoVcL5nLmDrhzLoNuWUiDthsmsDhfIAhVHz9+LFEd2rmZPR7P3U0Y8ALgfCaH+vrc6mUEgGhQqYIwyG5v831YlTgBehbB5i4Eza7aax2Tfdxw6sZqZqp4irBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=eUMa2BEvCKK3N3rhTkig5SCJOr9UwLYz7uy3CkKnjDylWTehChKQ2rJY2j3eW3nqzKYe1oVJEP4gQZjB2Pi7ZposoZbFsT087hfMfGTZHrGqHxVza4ZCmx9t87sRw1eD5A/kVe3gUR4doDUDCvw5J8XF3geLbmlUn7q8gfoEgPCtC/2N6RjSLCSYnYOepZCFGP0UMOWY2YCaTkt7nRUF9LHEZX9fVN+4JYBzoilL+v66YlDFEvPYyQtyo+zrBNFy66XF4jHfnqKzlzxD7HJt3tuAAM94EOhn4/Boj4uRzMDx1Z71DDcVMGvxCvCxHNcYtVCvpN6vucT5AoBxp9QZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8t9dWr3SYEGcReSvoWYqCJ1XUDQSml1FxGQjktYRqU=;
 b=2YdYBYTB38EjdRFCLoR/R+29AnbvQxfOvDIjV4BMBwcOZZBlz5LMwig89OqzKy7PZrB4EzuRS0iAWuYo6346JjZeLRjzdNfkjOlo9/eQOLoSQzkJEIJ2oJJ2AFBk77Ty1PyuNdMf08lEDhou7LkyHAaqJ/rNjgSOP24fGuCvMzQ=
Received: from SN7PR04CA0195.namprd04.prod.outlook.com (2603:10b6:806:126::20)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:15:08 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::c) by SN7PR04CA0195.outlook.office365.com
 (2603:10b6:806:126::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:15:07 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:15:04 -0500
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
Subject: [PATCH v13 10/12] PCI: ACPI: Add helper functions for converting ACPI <->PCI states
Date:   Fri, 18 Aug 2023 00:13:17 -0500
Message-ID: <20230818051319.551-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818051319.551-1-mario.limonciello@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH0PR12MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d003abc-7830-48d6-a769-08db9faa16cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbSi6u2RVLgUPs5dbR+6mJ+DkAXfnywjmcEwmNGLhELH5V5Fs67YPINOK/hcUIXCXzXn4MnmNZUXI6qTEr8qMuLKnUEeTsU1OarQJpQ5DZIwebPaz9QVNsJL+yYtYBGebwoc4SSHW7LhCXObO1ECZbSF87D4XaWIv6mOtUN7b4FPEoQXxmuoNwgwRBJWW2GxCqS0VU63XFgpBt0T/+ODn1+J07/4yUJEz3bvTuMj+zK156oc0eWP/K73VyhFr+hVJCWPyJ0FRGtUUDmYnk1a7SFfQwKdpPCh6ZYtElqXISEbR4bVnfCIo1hH//h47ob5d6+ZXYS16DASvbc4SwrjNk9Vos2ZQM6pmSuqEyqs3c9BjkXPeita+XTCd7eKTST4T2Pyt+ugToxFj2xPjazICZ5hVGLU9sat3uA//rO0U+4xEyMwiA12JADcdw/eAYjfyUdi/g8rzvAngtAXuZ3GAt+PQLvJI8+asq/KXQYkKcUS7KgIotCl0gCZAcX3jnzM0XLT9gpGBQQAnEk4FaI2cs6ZXC7zsx+lGhDCK5KE0u0Kv/3mam1V63RdwvbH1PEcnJCMEbgDINlMH4sN5mtbF8k56HV/mpkCGc3ttOWvlIs7RIU3I98x8rPqgsm9+r/Vdm8b62WwlG0/8DCeytoJvFwtkmZFXjZBZqUHw5Y0BdQWbu4HikpBXx97Q7yhC/s3ieFCJjUEHfxxvLQ6voeCT65kPr/rcKksZ20Bm6uEZkdpCE1hDTN+KoQk1nHBRZNc0Ihi0BK6dwkYgjV7Q/ztJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(316002)(54906003)(478600001)(110136005)(81166007)(356005)(82740400003)(44832011)(2906002)(41300700001)(8676002)(4326008)(5660300002)(8936002)(36860700001)(426003)(2616005)(47076005)(7696005)(6666004)(1076003)(26005)(336012)(16526019)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:07.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d003abc-7830-48d6-a769-08db9faa16cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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

