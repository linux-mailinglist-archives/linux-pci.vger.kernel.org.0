Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864B7E8465
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbjKJUmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbjKJUl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 15:41:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04206C83;
        Fri, 10 Nov 2023 10:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRfAh82m7CMXurMg7iSnOZ9/G5HfmlS44vBNjfRFlPL7LFHX2NdSdNYk1n1bVKFsicYCKe4ILHin0LRElcb0cdIfEzXaX7fV9lC7x1frutCjg9b5uxOVpd+rM+LU4+cQgOzScEzn3TVqQRePuq548Zm9MtLKb0g1G+8zokEJRpMKXaKRE1rQbrLvWR5dmRz5JeEGiezfuqI58Qb/rXJqj+wm4ED/LAGWE8h5hszQFiqM3qKEPt1iQXWDML/sG0/lID7/EjkbxoM1DQBHQLE50tbij6BYwZGi/h7RhonSh8tGecmpnjPR2d1v6HfGeutAt5aUepNOg8JuAO2wrezFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML7lbkbZ+5pEQd7nFxbuj28Rl2dq0DBNE+aUqfsFCNY=;
 b=Djplrvth2q5X350xexhISDAMaOz3OgwGnTDxd3NuWSTWI/gGr12PVrChmKiN8JAczShIf7PFiGRHA5I8YPw6Bx69JjHrBGRXHI7j1gVKvCH9Em+ns0Pq0+GCYuNf2h61I+5SBxK2OUr4p+TkvFx6IP+xn9AzBG2cABgB5EN4WAT2Ff0ZoupP6v4eIprZNWnyewx57WHYfyy06C9o2YAd0+Ln9fDxmtfzuYwcfB0InjY+xI9CR6bL2s8kQW5UBxmyjBvhhRmxPEJ13bflH8kVIUNAyutK29s5rYXxbYDdLKQxZ4P8w6R6AEDgKD0YM6ueI2LGaRWP/5gMo/KxtSEwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML7lbkbZ+5pEQd7nFxbuj28Rl2dq0DBNE+aUqfsFCNY=;
 b=TdKY1nuLUW6nMnJqoXLUQbFIyHdOqrgd0Qi6c1fcpkHPAuX4G81ZUAWRP+mIXT2mIsGDcWIwdHe8ME6sCY7wnF4tT6Hvo4Szpx4irrfM/cMLDHkBfBmn13KRPPOpCHcV1nr9IjcZ8uiZkNyxKWI9rb2AtRXiQtEYRKW7glIp5Es=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 18:55:29 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::46) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 18:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 18:55:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 12:55:27 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/3] PCI/ACPI: Add API for specifying aux power in D3cold
Date:   Fri, 10 Nov 2023 12:55:02 -0600
Message-ID: <20231110185503.46117-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110185503.46117-1-mario.limonciello@amd.com>
References: <20231110185503.46117-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c531db-3c74-41ed-20e3-08dbe21e9bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCl6vqb7Kqio28JcK1sgcChicTopOtiiDyFH/B8gN5IUDMam+GIj4C/7+br41eM87rZl0zIkLMSuXCdDh/PffoA2U/NwhhGJQSYPWC0ZzgSWFCFbLSEQVXvot0NlJR3kCRh62al0xnnP5dzOp7aTwKHLxh/26JBsEsZ1PH0dpdg0NAKtlRT9i2YNR9V4dLai4hNbU3dVPGOkrGpG0WwqndNceYd+ktFUcFPsnt39ASEVIQkeQcYpkyV24vN9+SdALjYZ5QUDbFE5LRbBV0II8HxzNt95jTTbyIH0cCYt3ZNq44Ypp2bFOC5VTtuzaz4Q4PZfUw9hFtc8gwznlgaoLOjS8fxmOP43K2+WSduxeksevpNLjZaPTublQQ+SaIJsfb2Xv3l5/k8AJV9UmWR6UV7mirkwv2xU+L1LHTDWjE2S2Uf+ZMwsXrLSWzWCKXe+mmOcmRZhHRsikeVmzWah74Z8sNwWUAAJtwGND7RP4G6aenovr4Jaj/rwSzbmDYWMIMzITweEhyw37uFIEbWhTZh6IyqAAk/JWD0EXd2+VgPClVmZOWqAdf9L8G+K9vE0vIu0wVBPso3hWDh0oXlFOPDzX9BeKJya5+H0mqHvSgB0b746G5iadR8wUSpS8+bkHlMSMwqc0y4pSR134bCzNDtMzouIspdTuohFdn0QhOekhZNbK0HTaC6ajryiukfHb3SmpzsM0kAX2HgNrNgimMfGGHiT/5UgjhXu6AUgmIl1FsZDqi8vPiwSGkPLsEaAWSJ679bcYPRC8RO8a+c63Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(70586007)(70206006)(316002)(110136005)(1076003)(2616005)(54906003)(40460700003)(86362001)(36860700001)(6666004)(36756003)(478600001)(966005)(7696005)(47076005)(41300700001)(5660300002)(426003)(336012)(81166007)(356005)(44832011)(82740400003)(8936002)(8676002)(4326008)(2906002)(16526019)(83380400001)(26005)(40480700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 18:55:29.4405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c531db-3c74-41ed-20e3-08dbe21e9bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI firmware specification includes support for a _DSM function
to negotiate aux power to be provided to the device while it is in
D3cold.

"The Request D3cold Aux Power Limit function describes how a device
driver conveys its auxiliary  power requirements to the host platform
when the device is in D3cold. The system firmware responds with a value
indicating whether the request can be supported. The power request is
specific to the Auxiliary power supply; main power may be removed while
in D3cold. A device must not draw any more power than what has been
negotiated via this mechanism after entering D3cold"

Add API for callers to utilize this _DSM.

Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
      PCI Firmware specification 3.3, section 4.6.10
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c   | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  7 ++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index bea72e807817..257858a6719e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1348,6 +1348,60 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 	return adev;
 }
 
+/**
+ * pci_acpi_request_aux_power_for_d3cold - Request auxiliary power for D3cold
+ * @pdev: PCI device to request power for
+ * @arg: mW requested
+ *
+ * This function requests auxiliary power for a PCI device in D3cold state
+ * when main power is removed above the value guaranteed by PCI specification.
+ *
+ * Return:
+ *  0 on success
+ *  -ENODEV when the device does not support the _DSM
+ *  -EIO on ACPI call failure
+ *  -EACCESS when the request was denied
+ *  Positive value corresponding to platform requested retry interval in seconds
+ */
+int pci_acpi_request_aux_power_for_d3cold(struct pci_dev *pdev, int arg)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	union acpi_object *obj;
+	union acpi_object argv4 = {
+		.integer.type = ACPI_TYPE_INTEGER,
+		.integer.value = arg,
+	};
+	int val;
+
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid,
+			    pci_acpi_dsm_rev,
+			    1 << DSM_PCI_REQUEST_D3COLD_AUX_POWER))
+		return -ENODEV;
+
+	obj = acpi_evaluate_dsm_typed(adev->handle, &pci_acpi_dsm_guid,
+				      pci_acpi_dsm_rev,
+				      DSM_PCI_REQUEST_D3COLD_AUX_POWER,
+				      &argv4, ACPI_TYPE_INTEGER);
+	if (!obj)
+		return -EIO;
+
+	val = obj->integer.value;
+	ACPI_FREE(obj);
+
+	switch (val) {
+	case PCI_D3COLD_AUX_DENIED:
+		return -EACCES;
+	case PCI_D3COLD_AUX_GRANTED:
+	case PCI_D3COLD_AUX_NO_MAIN_POWER_REMOVAL:
+		return 0;
+	default:
+		break;
+	}
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_request_aux_power_for_d3cold);
+
 /**
  * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
  * @pdev: the PCI device whose delay is to be updated
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 7966ef8f14b3..bc6372bcb7d6 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -122,6 +122,13 @@ extern const int pci_acpi_dsm_rev;
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
+#define DSM_PCI_REQUEST_D3COLD_AUX_POWER	0x0A
+
+#define PCI_D3COLD_AUX_DENIED			0
+#define PCI_D3COLD_AUX_GRANTED			1
+#define PCI_D3COLD_AUX_NO_MAIN_POWER_REMOVAL	2
+
+int pci_acpi_request_aux_power_for_d3cold(struct pci_dev *pdev, int arg);
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
-- 
2.34.1

