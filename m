Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61B3CAE96
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhGOVfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:10 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:26208
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhGOVfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqKmNqBorB6JWWEBvhznFZKg71XX9wLedgGCxpi78xov76AvLHb9/csm3b9UjQr/ikkXWUITdgqPwBACfwAGPNzqaFtEK4OGW5mWiExbdd7AxazRRdMwvtn0665NxBcNlk8KQw08fYEeMy7GiZVKTauTaRFP0ZqL+romI7TyCg4BiUnk9PSKb1sVLJNiyk/hucdQmnB/xaB2bsOYrbGlqgdHtYOMConZYHAA+S0mHuHhU8bZbsHPyq8stnu5UtrNYswlhp9stFJxS/EtyohggnSc47wWmHpS7y6N5bZfVhMjiJU6OXjBlJm/PT/y6aOr3Rt8cBGK0FU+JXGmqOLrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovzB+Qvsy37ejW46W9js0hCw+OSIiSu1ZGqRrn3/sv0=;
 b=MokBGOuWcxFB/ePK1k7PJ3N3aqWSjeTbko2PapS8n/rpkZ6JvuSXsojXsUxoowcgTZJgBUH9Tre/lzBlvAdyCvaDXLTLJzN7fWPVS7fpZ4mW0Rvwdg8FCldZL0HkL5sFE3oYZeBDkgVJWIi4+M2oKrMG12Gd52wiBBCNDHtsISXTFa2VWZwxcoFpogJUhTPysEO9FXMZwDIfcnxVoQJZpP35C117o+UnWEYZIDIop7NTjSXOdIpX+vBjHqM9m2zzqxl7BJgyD38qVCTn4ZsMH+lt+e3GynF7PSBMtvuOI083eT3Avtj4Ouir3Qb2ivn3GdwLzfWJEU5PcQKyX3eGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovzB+Qvsy37ejW46W9js0hCw+OSIiSu1ZGqRrn3/sv0=;
 b=gQ5O5qdYNtRub05WxoEGZLxugdGnbKGPfWZUtxsDcEhosYAaOvV0OpbJTgw4zt9xxgv5f/YCqJTwGD7TcTQmy+Mao9X7Scu09cRH6tjfdrHaMHE4S/OWkpVMlylWcr33cwT6eGKcl3egflC5bWX9+hhJSHGbA3vaw2Z0WXL4FyEDPBhl71wm9lw4eq8R7F1W4unFLN0vZx+VkYWrjybPmmViQoi3L4SGhh2SpUx7+QBa+xrzeVPdM0APULXoHdjhSZj8x9/ZtBWLPIQszskb0pQiYjkLIWlrw5guHc9Xmd3MUia89wMSJHBbyPF0o5kX3dRiU8zMDdFVcO/bT8rXNw==
Received: from BN9PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:fb::34)
 by CY4PR12MB1445.namprd12.prod.outlook.com (2603:10b6:910:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.27; Thu, 15 Jul
 2021 21:32:11 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::b5) by BN9PR03CA0059.outlook.office365.com
 (2603:10b6:408:fb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:11 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:32:07 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 7/8] PCI: Add support for ACPI _RST reset method
Date:   Thu, 15 Jul 2021 16:30:59 -0500
Message-ID: <20210715213100.11539-8-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147a66e4-86a6-44ef-b402-08d947d801ba
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445A52C49880BAA3820E943C7129@CY4PR12MB1445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhIpg0jzmB1zSpbCqFPqPpkL0YnkwTmowMMKTc8bxrlUyqtD08U8wwRYXquzynCeV+jFA11ZwDmIZ8pBoMeZ79h5tkJ3DXsTjDR8KcRZE1HiUloMdPUcFji2dMsWUMPzK3hIumU2J63mUPQ/UZqUAwct3C8hW0vm5G4I9JowlLW1jMfZ6mTRLngGmWgO8DV3jvYlnueVNpvnThPDEvgmcIOdBx6229LSJ5Ot2GJJT+7cs9RJDDgb1qpuASUb49h8u9RMOSJghzi75GhlZklBTcitgx4NmyOTWBI1E9myHCWgo3wNGdwJaONjQYbbmNuTfNyz7eiSdeyQLVpnwGfVjzD2MQjnvv86lCTUZDewoJPEPMgczmQ/6DcWVZ8/g8jbW+o19H/HrR9exutwZhulgbT7NHgYL/cfOzR2FCXWmIoa07F2WQw2sXqNqn4sMY9qk869Rvyz6wKXSenhArZSxsaNCJOiURYA8+0HCbxAkQP8n3sH2SSH5ytYA8vM0Ht/Dz/B6U8wYwwKk5f7D501YqlzLmA5QL6N3coWEwCzlyPB8x5cUiGDgGIzrVXHGxOqKgYunFChxm8xdmWvAkLrOIMnD+SNY6jUGg2GUg3xdirE5R3BQpuJTzaSNWmm55S/cMT3EBT1Nh5EZoU2jNQdxckxy/lWyt9vhMxdziOBvGHfMAOUzRBhNwyRcqYzFtG6JzmDeInLa4uKu2SmdxQUianBWs9WtKVCHRyowMEk3qs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(426003)(36906005)(336012)(26005)(70206006)(186003)(478600001)(2616005)(6916009)(54906003)(36860700001)(316002)(5660300002)(8936002)(70586007)(7696005)(107886003)(8676002)(86362001)(82310400003)(82740400003)(6666004)(2906002)(36756003)(7636003)(356005)(4326008)(47076005)(16526019)(1076003)(34020700004)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:11.4908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147a66e4-86a6-44ef-b402-08d947d801ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device. Implement a new reset function
pci_dev_acpi_reset() for probing RST method and execute if it is defined
in the firmware.

The default priority of the ACPI reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae021322b3fc..31f76746741f5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -941,6 +941,29 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 				   acpi_pci_find_companion(&dev->dev));
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "ACPI _RST failed\n");
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cc9f96effa546..8aab4097f80bc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5127,6 +5127,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37381734fcc78..699d14243867a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -709,7 +709,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
 #else
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	return -ENOTTY;
+}
+
 static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 58cc2e2b05051..698a668828f66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -50,7 +50,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 6
+#define PCI_NUM_RESET_METHODS 7
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.25.1

