Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31EC7E825D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 20:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjKJTRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 14:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345759AbjKJTQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 14:16:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CD6C90;
        Fri, 10 Nov 2023 10:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhRmmCM6XXHI2ZTrvZDvHIJrwrmlloS6ysksNSpKFZ/jGHSsjdNwbQqwsw5Sn399qv1U84r29x7zBh8TkETngEUelXYu6hd75Yw4HCn/+OAF7z4p1V3+vOburW4CpnVDEdGx47ChOCidOXmiSXVuRwvLEMX3UQ9LR68N77h17eahPccHO5+1OiZvdj/7eD0r+G4h7JgsW9a5Nb1sqV37DuzVPana8wTJZAJWsl51Fa9LNkH7HBgfz1Z4FQXofHBbsy7/CSm2wI2NdidOB93tnlGaJzQsRX4+vmFJCVxgRula+iISlQEHoD6A4unl2Dv7gv2M19d4HcKAH5XXrz7Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COYn6LvPddBHTWly4J+FD6qXdpwcv2oBpv77/QbspEw=;
 b=QNrohEiRb5pCSD/OKdA3nulPL9+feHLXkjEbZiO54Pngf/z31Mm0sOMCwwWmfIsN9dfiwxxxZAXfL8b4STjAY1VAejj/D3F/7dWN9QROOkL5pqSs6IKMXQMkvappgLKLfbJsQpL7XF04g0+osnmEe75f+kpBM8HQuvBTBFcta41CC4lWhPU3YXNBmPxp/k7+6V+mWYhiobzSol3v56QUbV6ZZjmOharReajj5CQ/bw77egBBSGHXP/PQEixL9wzZaKeALvE15+NyRGlk3zUq8CWNSedQhVDB8QShGV4REnBYEQZIdKsezlolGUB9SRtm0JxHOWPlb3ujuci1fKEiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COYn6LvPddBHTWly4J+FD6qXdpwcv2oBpv77/QbspEw=;
 b=0nTyx2VhyRhoraw6MTQ1nUiyoJ5naO697W6A+4m8XZJ7bnG+k9Jprud8thu5VUe7eervs4rVSk0hvRA9kO8NL5oaJct1FnGLy34MCsm0jGGhcS33XsqqkMEHPDiUr6EINfh+Gs++Sw9oNq80bvZuaDYsKCNUeGVXKZSq1Bn0Foc=
Received: from MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18) by
 SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19; Fri, 10 Nov 2023 18:55:30 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::76) by MN2PR01CA0005.outlook.office365.com
 (2603:10b6:208:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 18:55:30 +0000
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
 2023 12:55:28 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 3/3] PCI/ACPI: Add API for specifying a PERST# assertion delay
Date:   Fri, 10 Nov 2023 12:55:03 -0600
Message-ID: <20231110185503.46117-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110185503.46117-1-mario.limonciello@amd.com>
References: <20231110185503.46117-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3953cfdf-cb02-4105-0a13-08dbe21e9c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a35lPOCYviJ1NbEDH5THP9qPdPr9slElG/0h/fCwxs7175OI1f6zp7yWkFkHgKp5A+X0ryt0dRzPJgT6Qa0lVMoLjx+lpxvvCVmHwyEUIQc415o1nVhAYSfBLyYsRtVcSmF5iAWu+2khf+aHP9uGjFUfaD6BHubHZtKh+U+XGdQWbW2HINz+qKf7KVs7uc+RHUnr5ScTbLhNSk9PCCi4//S8+mrpX7n9jN+E+pZj3D9SpR2BYKtMfkMPSEu3MIPPw7zo86/JXVjhKAF7rG7ComaCjSfUWuh7QX50ITW5n7Q1i49RL17YCjxNZX1om8VdWa2xoud8x1179tfJeQtyQtdnDycS6Z4B9UNlEtxBReHXZlyCAWLMDAsXoRuYGgnrgGhq1W6/lMrBduQh5HfKr01Z3ytI92AB7Nh8Swx66W7s53lFz1p2pDRVABe9IEbstW0l6/gizrTm5Hsi0bC4wQZ47lV9wvrqMTUgdsIJawUSf53l8rjxdURc+wvJh8MVd1/a6nIDaDM/oDKq7q4389GjznafB9wbSb3Hlveh04JzkUOCEwQLi8KLH/ZIxDhzt5ydlqjsHAxZXG5finnRMysbWvFE1xcj91dgl0T9FyPacAA5lC7pQ0B4vFeGnECc6zpR/h6PJUfFZLxatFndbiYABxIe8iaFw/DBynDJO1DUHYQ2z1rGyatljPt4lncLNYhl0GTV2fhp9SKLO3JVfkyvv/Edl4XjfB2mQjMj+a1SfDSz9NOnHPLFXmfRNjBTi5JsiWewgmjOuQa0QhtkGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(7696005)(83380400001)(4326008)(8676002)(8936002)(2616005)(966005)(426003)(6666004)(26005)(70586007)(16526019)(44832011)(110136005)(478600001)(316002)(336012)(54906003)(70206006)(1076003)(47076005)(40480700001)(5660300002)(36860700001)(40460700003)(41300700001)(81166007)(356005)(82740400003)(36756003)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 18:55:29.9717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953cfdf-cb02-4105-0a13-08dbe21e9c43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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
to specify a PERST# assertion delay.

"The Add PERST# Assertion Delay function is used to convey the requirement
for a fixed delay in timing between the time the PME_TO_Ack message is
received at the PCI Express Downstream Port that originated the
PME_Turn_Off message, and the time the platform asserts PERST# to the slot
during the corresponding Endpoint’s or PCI Express Upstream Port’s
transition to D3cold while the system is in an ACPI operational state."

Add API for callers to utilize this _DSM.

Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
      PCI Firmware specification 3.3, section 4.6.11
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 257858a6719e..82e04808040d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1402,6 +1402,46 @@ int pci_acpi_request_aux_power_for_d3cold(struct pci_dev *pdev, int arg)
 }
 EXPORT_SYMBOL_GPL(pci_acpi_request_aux_power_for_d3cold);
 
+/**
+ * pci_acpi_set_perst_delay - Set the assertion delay for the PERST# signal
+ * @pdev: PCI device to set the delay for
+ * @arg: Delay value in microseconds
+ *
+ * This function sets the delay for the PERST# signal of the given PCI device.
+ * The delay value is specified in microseconds through the @arg parameter.
+ * The maximum delay value is 10000 microseconds.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int pci_acpi_set_perst_delay(struct pci_dev *pdev, int arg)
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
+			    pci_acpi_dsm_rev, 1 << DSM_PCI_ADD_PERST_DELAY))
+		return -ENODEV;
+
+	if (arg > 10000)
+		return -EINVAL;
+
+	obj = acpi_evaluate_dsm_typed(adev->handle, &pci_acpi_dsm_guid,
+				      pci_acpi_dsm_rev, DSM_PCI_ADD_PERST_DELAY,
+				      &argv4, ACPI_TYPE_INTEGER);
+	if (!obj)
+		return -EIO;
+
+	val = obj->integer.value;
+	ACPI_FREE(obj);
+	return (val == arg) ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_set_perst_delay);
+
 /**
  * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
  * @pdev: the PCI device whose delay is to be updated
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index bc6372bcb7d6..bdce83c3afbf 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -123,12 +123,14 @@ extern const int pci_acpi_dsm_rev;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 #define DSM_PCI_REQUEST_D3COLD_AUX_POWER	0x0A
+#define DSM_PCI_ADD_PERST_DELAY			0x0B
 
 #define PCI_D3COLD_AUX_DENIED			0
 #define PCI_D3COLD_AUX_GRANTED			1
 #define PCI_D3COLD_AUX_NO_MAIN_POWER_REMOVAL	2
 
 int pci_acpi_request_aux_power_for_d3cold(struct pci_dev *pdev, int arg);
+int pci_acpi_set_perst_delay(struct pci_dev *pdev, int arg);
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
-- 
2.34.1

