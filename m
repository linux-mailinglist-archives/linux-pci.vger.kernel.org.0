Return-Path: <linux-pci+bounces-397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0207C802B9A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B229C280CDD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F753944D;
	Mon,  4 Dec 2023 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xxG+SriG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09207E6;
	Sun,  3 Dec 2023 22:07:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/de6TZGB9jyie/pxPtoPowzeHuvY3LD9C4tnx7ofsSqMIpyWVe1WLd2GPodAlmUUWneeGBr6bFQKZXSyTHuwL21UmBMX4C1cYyOQ7oImGp0fk2KIHHK+OM6/UhgwkQUiL0fT4nuoMK5O8zPipHTkylAGiH9+kDpY4N12ieeHo4eCNlmCpZHEto5ntIF+xVf2CCm9rZsxAWfo20q2GCpVhZiG1Y0xKKzHKTSoMiDgeMvwMwtJYkSu8fmrvppPqoHHMjt/JcSORHelfXQWB2HMM/qy9sSWLIfVMMACoulwiMzrRJyLg++o7luZufqp8WSovOU5+RrlTo9i4vOYeC+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORNQsfZuZZssD0ZhCAI+ij3YAGOBeTBp0bf4Eaf2o1A=;
 b=GPt6yGM3/MyOtVjwDcrdsGURStCmxESENhl2+uEf381H3fwyngtNKRAHtcunip1Djs4zhTPPDjH8yfjdm3vglborr18h7vaiX7nW5uPOPNxccXdZnJi0Rhn3LqnlODqVnYz95XA2OSfF79mwTt/v558qhhpkOZTIph4jp7XRR6A0cB9fTYgzXixe6FqGpkTjDTp84nBm0N/z5bK9LIYBBcQB/TrdDMJpswLQHQCSGN/Rv4GB7X3RyCCx+ZeSK8cnfGBM+z3BpsIzch2dphokcMBPToV7TOLJ995wfCz4aeq1FcGrJaHPMZzw1/OjjEVzxZWiCjba2GahdQ+SKFjPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORNQsfZuZZssD0ZhCAI+ij3YAGOBeTBp0bf4Eaf2o1A=;
 b=xxG+SriGXDjQFSeVh52B7h0rLkCOW3x9vl5TQGbSevRV86bZejgcBt+jZ72mtKXY1cpthxbqusaMKR+krYKQnMWjtFMOLHVulF9OJg4gi2iAG6xL50oL/7AfJSDCrYAyOFIE7eW8UIKO3RmXVqrW2pb4gAH6sw35CbDP7V0jEys=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:07:02 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::6e) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 06:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 06:07:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 00:06:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
	<hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:X86 PLATFORM
 DRIVERS" <platform-driver-x86@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 4/4] platform/x86/amd: pmc: Add support for using constraints to decide D3 policy
Date: Sat, 2 Dec 2023 22:10:46 -0600
Message-ID: <20231203041046.38655-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203041046.38655-1-mario.limonciello@amd.com>
References: <20231203041046.38655-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cd6dd2-4037-4cb3-b594-08dbf48f3b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ZEswAeWATwsMTTgSnDiTHdD5nRnCQNh+Jx/Kb6XII6RJBF2niIuEb+tpViSpjkBlnPD3pSuppxonGigd2+IWVYrgGY18fUpbv9dUwOW5WbK1ha7hdSkX6UjgK48oh2yPqzU5g+02v3Yb8ZFqFtYrD7TevPz+E7vp2Xy5FX0e6MLrsNuW/FsWxwrj//nDPLKiH0OvxQTfCAcno+cb1tW4UXXwGEhU3n0dnNulhQVfd08BXxTbgFUGNFrG/8nf1kbgDILfOuECFPsh/MshnjqH1hCjIoAcigwaeapFlPQejy+Txoe95PYrmjALHCV820lsv32bT+lWEPW1AiTbH53TjKo3uT2+1kEHlZfIwtHuSndrnbm+y7+Bq8DDwlEwsLSvyUHeL4ZikhQYOI3WelhwStADreD74cAOzZKtPl+0HV+VF3fo9B1jWYW5YN7NYFVqil3seVYbCWLGu0FS6pi1xpgxov8TPpgXoBQ4XT8kG2hZrUT9j5862EycF9yur71ovlt1R5GjZcsW+U5Ny/edHTxzO+nETMzs+tCe7qakqfgFSWNCnLWdbcFbvaLT/f+m8sh03etE7mc8r+/fFUxfTcPd2Rdk006Uu1vtS/LD8Uygqp3a2jQMOXCcSCmzI+uAlVRex1MQucCsBSJ+8byGmgutkQov36h9BCypPR9VlhGgnUrcBNRqoCP+qokax9S0T1UbvaV4u3RXkD9OgOQx2EYUbutUc4oeZMNXRM0ugYTsIpc0DgM0R7jrpYM/CQR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(70206006)(70586007)(316002)(6916009)(54906003)(6666004)(40460700003)(966005)(478600001)(5660300002)(7416002)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(44832011)(86362001)(83380400001)(2616005)(36860700001)(47076005)(81166007)(356005)(426003)(336012)(26005)(16526019)(82740400003)(1076003)(40480700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 06:07:01.6923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cd6dd2-4037-4cb3-b594-08dbf48f3b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Spam-Level: *

The default kernel policy will allow modern machines to effectively put
all PCIe bridges into PCI D3. This policy doesn't match what Windows uses.

In Windows the driver stack includes a "Power Engine Plugin" (uPEP driver)
to decide the policy for integrated devices using PEP device constraints.

Device constraints are expressed as a number in the _DSM of the PNP0D80
device and exported by the kernel in acpi_get_lps0_constraint().

Add support for SoCs to use constraints on Linux as well for deciding
target state for integrated PCI bridges.

Disable existing production SoCs by default with this change.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c3104714b480..9aa6cf4fabf1 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -793,6 +793,61 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+static inline void amd_pmc_apply_constraint(struct pci_dev *pci_dev, bool apply)
+{
+	if (apply)
+		pci_d3cold_disable(pci_dev);
+	else
+		pci_d3cold_enable(pci_dev);
+}
+
+/*
+ * Constraints are specified in the ACPI LPS0 device and specify what the
+ * platform intended for devices that are internal to the SoC.
+ *
+ * If a constraint is present and >= to ACPI_STATE_D3, then enable D3.
+ * If a constraint is not present or < ACPI_STATE_D3, then disable D3.
+ */
+static void amd_pmc_check_constraints(struct amd_pmc_dev *pdev, bool apply)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct acpi_device *adev;
+	int constraint;
+
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_RV:
+	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_YC:
+	case AMD_CPU_ID_CB:
+	case AMD_CPU_ID_PS:
+	case AMD_CPU_ID_SP:
+		return;
+	default:
+		break;
+	}
+
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
+		adev = ACPI_COMPANION(&pci_dev->dev);
+		if (!adev)
+			continue;
+		constraint = acpi_get_lps0_constraint(adev);
+		dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
+
+		switch (constraint) {
+		case ACPI_STATE_UNKNOWN:
+		case ACPI_STATE_D0:
+		case ACPI_STATE_D1:
+		case ACPI_STATE_D2:
+			amd_pmc_apply_constraint(pci_dev, apply);
+			continue;
+		/* use the logic pci_bridge_d3_possible() to decide */
+		case ACPI_STATE_D3:
+		default:
+			continue;
+		}
+	}
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -1099,6 +1154,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 			amd_pmc_quirks_init(dev);
 	}
 
+	amd_pmc_check_constraints(dev, TRUE);
 	amd_pmc_dbgfs_register(dev);
 	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
@@ -1114,6 +1170,7 @@ static void amd_pmc_remove(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_SUSPEND))
 		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	amd_pmc_check_constraints(dev, FALSE);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-- 
2.34.1


