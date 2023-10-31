Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3096A7DCDF6
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjJaNfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344557AbjJaNfG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 09:35:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFBE6;
        Tue, 31 Oct 2023 06:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTsySws2OJ3bMQjr0ad65pX68U7bdzVE8MptyyzeYnQmZGPzLB1zUF3QdfQAhArAPM3RRqPWo9Mvm71KRlXz4m41aRvMgOXFXNzd8NFcaknC137qnWLCtIR83Sh1KTREc+lD53myRtEfaN2QHdvc/gB7FUMoE0SvLylIojvvwacLLuqoq27lPqmCUXsNsujY9m9+Z2JcWVAzfT2LcLj5tXN67Aaj0BOWRdpkvlePooy5tGF8A5ftcMqkcG09mVjYDSYtvXokxXPdQtibPhsWOLpkBFqOgNBOq+GF+P/FwUwx74oP4ve11aspet1OLdiD8VQ118ZZqHIfvPAFC15jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbgtSTY1GCwLhGQB/wIgn0aNJUxw+ac+GvxL1xpS73g=;
 b=i3Uyib7P0n1sPnFjZiWDBiUyg5BaFJenFjFqO+S6TSoZRyEHGmqPPaofzy0gMbl2ksjd8BnIrp6/tRgHqhUMLd0yCV5C0PJgCICMz+ZWLQlFldJtXiNF9Hfut8+G3NEdbQsbu6zS/IyeNQ893yXd+ct+Z7pmdDRKvQCQcAGQ1lAOiyusfEE+lf4L1DSVDYsn8h4F1eMkSrLYsiSUz4RtZySS/x9DaZduLSvcbD9kk4L7MDe0PVC4wnQEhXCY73em3RNtkjWALD841jZN4gdGWXDfcshBnT5QB2yshVh1r/VCHdtUEPyquyjJKW1pdLfBPeND7SzJY8kRsgrTIRaT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbgtSTY1GCwLhGQB/wIgn0aNJUxw+ac+GvxL1xpS73g=;
 b=NzS8g0GWTfF8Cmy7r9PRT7S/GEyZNGzkDqYn9fH2wYYI4hnnoH01V5xP1o0Dzf6/Qtuu5dJrpCU110lxj/nlUPRzdyOPx5zCMANn/Vjy/XkgZ0MYXs8/1IIlQCo+H9Zms4wet/e3ttP9lF3xEaDv5et08yYKoHEa+mGEOqH9L3A=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 13:35:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::97) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 13:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 13:35:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 08:34:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <bhelgaas@google.com>, <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in pcie_bandwidth_available()
Date:   Tue, 31 Oct 2023 08:34:38 -0500
Message-ID: <20231031133438.5299-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031133438.5299-1-mario.limonciello@amd.com>
References: <20231031133438.5299-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 497cd936-cdd8-4f57-da61-08dbda162e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHgyu0F9x330QltXnYPrHvfXR7OLvWqgYha2lGg5M5tuxDd0o7KD6HqWdu1N/owFlg0sdwvBmmE4LyNOP6FY9H9kDhKGww6FakVzKuASVluHXSc/xNntuaG0S9TxG+wpDQZiUk6Qcf0E/F/jRhs2m+Mavs9DJXTjzVnepfPQIIsQgT0esq/Mkjl7un5ZVurCqXp5zZ1MAycVUvTFrwIjuqMRD6E6X/sFxlYaccL/BcXOs2MaAnBSjn/8lbGH2D7aQ1m8M0FYTlDPQNs8cYbZj5VauDY3ZpENaTGZ+gI87LNPg2YHjgd5qfYiSkHqBUfm9BKXEAdQOqF/sOugbEtkcMQgeKK9rxBJU81WpW7SNh63qeBSTKE378yyouvfSCZ+AVRDOVxk1ncUJvAn6VGL6WX98pluWWrm0GI/vQ+D0JEJTg7RXPHI5c/jCXEWZRVrT+thYtihOZOo4fStKS2ycukYq21HWLAzzc6S+4DhqSiehCdnPMFAIgstPoRSgfkwirw6ZONcE8Thl4T9hEHLa4POF6xu+VFneEfHSLmD63KeB6eyMiCWQw03wDBGcDZ5FMqnIiz1X9L9d+jXLzNn3xuTeMsgxPPuutEuYbGfdd2G2GhwU+xD8pJuSyYKo1xaid9k1j5xbMWlH3SYVcYgL5edfpuVmA2QH+Us4uUxlqNgMCk21lGcdddZuwnUEChalUM4mGfaKwDU1CHqw8fBOEpA/QGEvhCZoq/m+IW0xYAOMi+30pIpbVVoprTx2zFEtAnpnVI71YsVLUGLNbh0cmJvkZlb6td90KyjSYfapvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(16526019)(26005)(6666004)(7696005)(478600001)(66574015)(47076005)(36860700001)(336012)(426003)(83380400001)(5660300002)(2906002)(4326008)(8936002)(70586007)(44832011)(110136005)(41300700001)(70206006)(966005)(8676002)(316002)(54906003)(356005)(81166007)(2616005)(82740400003)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:35:00.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497cd936-cdd8-4f57-da61-08dbda162e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The USB4 spec specifies that PCIe ports that are used for tunneling
PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s.

In reality these ports speed is controlled by the fabric implementation.

Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
to program the device will always find the PCIe ports used for
tunneling as a limiting factor and may make incorrect decisions.

To prevent problems in downstream drivers check explicitly for ports
being used for PCIe tunneling and skip them when looking for bandwidth
limitations.

2 types of devices are detected:
1) PCIe root port used for PCIe tunneling
2) Intel Thunderbolt 3 bridge

Downstream drivers could make this change on their own but then they
wouldn't be able to detect other potential speed bottlenecks.

Link: https://lore.kernel.org/linux-pci/7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com/
Link: https://www.usb.org/document-library/usb4r-specification-v20
      USB4 V2 with Errata and ECN through June 2023 - CLEAN p710
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..4a7dc9c2b8f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6223,6 +6223,40 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
+/**
+ * pcie_is_tunneling_port - Check if a PCI device is used for TBT3/USB4 tunneling
+ * @dev: PCI device to check
+ *
+ * Returns true if the device is used for PCIe tunneling, false otherwise.
+ */
+static bool
+pcie_is_tunneling_port(struct pci_dev *pdev)
+{
+	struct device_link *link;
+	struct pci_dev *supplier;
+
+	/* Intel TBT3 bridge */
+	if (pdev->is_thunderbolt)
+		return true;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	/* PCIe root port used for tunneling linked to USB4 router */
+	list_for_each_entry(link, &pdev->dev.links.suppliers, c_node) {
+		supplier = to_pci_dev(link->supplier);
+		if (!supplier)
+			continue;
+		if (supplier->class == PCI_CLASS_SERIAL_USB_USB4)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
@@ -6236,6 +6270,8 @@ EXPORT_SYMBOL(pcie_set_mps);
  * limiting_dev, speed, and width pointers are supplied) information about
  * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
  * raw bandwidth.
+ *
+ * This function excludes root ports and bridges used for USB4 and TBT3 tunneling.
  */
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
@@ -6254,6 +6290,10 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	bw = 0;
 
 	while (dev) {
+		/* skip root ports and bridges used for tunneling */
+		if (pcie_is_tunneling_port(dev))
+			goto skip;
+
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
@@ -6274,6 +6314,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 				*width = next_width;
 		}
 
+skip:
 		dev = pci_upstream_bridge(dev);
 	}
 
-- 
2.34.1

