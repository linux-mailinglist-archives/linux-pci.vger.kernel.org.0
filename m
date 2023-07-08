Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77FE74C7B3
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGITAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGITAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 15:00:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE40128;
        Sun,  9 Jul 2023 12:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h11nbn2CzIrfzx0fe49tX5Kqj24mWfaY19yXG48FQ8GUVtbDFhV/M403dNoQTqs6D+x7bNKA2Y0JpJ2Cnh1Rn15LpeVoez2n5pMItyg7MT9zqvW31R/y/I07sE7VtpaL2PUqiDfZ0RSX4QWkJ1/ehfEanuQhH5oWXLkbr/myktoY4LnOZwbijPJvL+KB/m5h7ER+GaJyy+JAfFvryA/HYITPzAADzIV/NMpzvFma/FzjJOPmAIYrMWytwWtGPpUyQZk1WSKGqu85x2BPGXCnug/lDVlZWHttJDGy8d/0IleuGb0Ez5QkOvtdgCn/D/g2T5byR2NTJePingfvz8ZPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hevWxkLHIDjLd6V3Vug2xDLsaqM8IxPfJVj9nulxmo0=;
 b=Q0kooEagauFEUxECqArmX0gqH26qHaa8aiOPQV1JswL7hRzUkEoUjRJnv2Q8eibVvfQh5lkToNDNxOLkKNVcxY9dPZvTO7OV4GvjUo6N2JT+AoOvj6c5h4NfICKrOJ93b7PKizqJ6YfQ4F8lm1xAb/AWuS1AhhL7XDbpTBT/B1t2SNp+51Dx7RoW8HarY7Tv8fFFCbQh0LZxPYOvsN6M18FXDTWMm0txzWZgyVwyw5YtKbnv5jnc1dTPiTt6bCRLuGloOri51gZzQCOuJj2WNbi19K93vsGqqWF3rBoEfoL4ZkgkOA2X5KhlnUboB0IY0pfeDtVQLgT7CzxRs/gXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hevWxkLHIDjLd6V3Vug2xDLsaqM8IxPfJVj9nulxmo0=;
 b=RjnBiY8jgga+HBsQC2UFqiqpEFoNOnVCZom3LC0HmhxB7NwaBZlbvzb/xU+JAIRFdlsIGlKq6qgMUHWqkwSg3wmIZGVGFcjnNBmyKFWxhIPlBDUOzZ/8jj8SvXCxDU+wE3ta4zFy+RsDxSeu/Rv+0q6SdCvY99NSksPJO/8JQFk=
Received: from BN0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:e7::7)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sun, 9 Jul
 2023 19:00:34 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::d0) by BN0PR03CA0032.outlook.office365.com
 (2603:10b6:408:e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Sun, 9 Jul 2023 19:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Sun, 9 Jul 2023 19:00:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 14:00:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v6 1/1] PCI: Avoid putting some root ports into D3 on some Ryzen chips
Date:   Sat, 8 Jul 2023 16:44:57 -0500
Message-ID: <20230708214457.1229-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708214457.1229-1-mario.limonciello@amd.com>
References: <20230708214457.1229-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: c662de27-856d-4358-3af4-08db80aec690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RslJRpSo0vjx1GOpY4NPDe6Lby1ra7Ux+kaTiZd2q0LVShtxoDkuCpxlrCycY5pGnkpUIThZfA9q/GLiMSoyMc68ooiRK2scMU9gZV+aJsSp95hvNZq46enXPCk8u+9IIBrtuvhQ8xdx9ylu8AkbUFRl+CAY59Jo6++Oa5P20nkENAmIzr3+lvTERHKK664SJgV//xU+vZ8S78wNxBR1zHamtnTh7lN/LhTD0tiP/IM46UBnH07dRAQr+91EXsk5+3Vv7SQQRhrpZroUJOfOROACQK0Snp3VPjjb9lDTNaNZ0DhZgUBWd8E5euqjQwi/yGMsdXTIg2ysfZKD9pPN/mJINXp+bBUXORvd+M8gpnGNxzu7C8AEoj2yBqXdaRCYJtUbwByzUS5Dij8q6mYuRbjpE/+MXFG9M3n65lhYSLg0ObvyzhCagzBu3Ke4jF8x7FXZMd0e+tT3+qA1+cg10kywAiapLl6sW3dQseqnLI0yAZ0QePUZXZYIIdBC+a1qQZ4fYShN46BZO+GjyhrE1+m5Et5YauU8Rxvl1VpH3YTSzrn11grczVQb+qGEwlVc9q6ozDSdgbDeMiY+AGvi+m0Fq7YgYsdfzDP7+wlEVwq5nR1dQD/0BSmx8q7ihO5bnq+v3gj+/YVvNc/XaEtQw4JwOD7Egv+/ytqRtXyGqEKvK1XYkuF+va86k4xNHJ0CxhkVVbeNJmTSabQArfRQei8HhZS97h1AFYU9O7N49xWkGVukgrtdnjHZHLg5P7Xa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(4326008)(16526019)(186003)(26005)(1076003)(70206006)(70586007)(5660300002)(41300700001)(8676002)(8936002)(478600001)(110136005)(316002)(54906003)(82740400003)(86362001)(81166007)(356005)(44832011)(47076005)(36756003)(7696005)(36860700001)(966005)(6666004)(2906002)(40480700001)(336012)(2616005)(83380400001)(82310400005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 19:00:34.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c662de27-856d-4358-3af4-08db80aec690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
sets the policy that all PCIe ports are allowed to use D3.  When
the system is suspended if the port is not power manageable by the
platform and won't be used for wakeup via a PME this sets up the
policy for these ports to go into D3hot.

This policy generally makes sense from an OSPM perspective but it leads
to problems with wakeup from suspend on laptops with AMD chips:

- On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
  interrupt.
- On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.

Add a quirk for the PCI device ID used by the problematic root port on
both chips to ensure that these root ports are not put into D3hot at
suspend.

Cc: stable@vger.kernel.org # 6.1+
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d5..e0346073e5855 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3867,6 +3867,22 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
+
+/*
+ * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
+ * may cause problems when the system attempts wake up from s2idle.
+ *
+ * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
+ * interrupt.
+ * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
+ */
+static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
+{
+	if (!acpi_pci_power_manageable(pdev))
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
 #endif
 
 /*
-- 
2.34.1

