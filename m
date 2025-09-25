Return-Path: <linux-pci+bounces-37059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61BBA1D9C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B037B3711
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DD32255F;
	Thu, 25 Sep 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pi2VIE17"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B881F91D6;
	Thu, 25 Sep 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839975; cv=fail; b=Z3JOqjwB4thqVSvGutz6jCe7K150mB1A6ogpga63K3m3hivpkRRGMJbQmWePKxxI/TIxFLCEdggccQWsHF5Nfst7GOI4pyVebPhIS9gcuaBiS5HFCcp6nmV/Abx/hHPCvNPwRGKWim0AxmAkDkEHb5a7VU2+q58+SapvHDIVzZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839975; c=relaxed/simple;
	bh=2mFkXbcAAkM1hRlrY1BkUoA+53FJYAxQISJN4VRYung=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAMz8Ro47qyLhSL8Rwp96vNDciaUTrWXu2wEQSniMh1jyOeoXJqqts1Yk22Pnbg3fsnrIV2ikTpPl7ym3iLt787Xf4vH+arHmxTyUPxFrNdFJgD1vdMpaooOjFCx8bdSu8lkO+fywGWk/efC+UgEuAf1Sp0C3JAypDZ8uT1/GRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pi2VIE17; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvZ/8ycuf7nEbTnxTqmlFoiODwGLukU9sGqpTMmnQz+izGrt3ukSd+YQRnN5FueVG/wWy0d3SGyH6oIpZhc4PWqDDEf0QpArIB3HYbv+7EyyDGpYi/GChDriJpc2+UylkJi1SjwDRAAj+y4ofPRolOnhpoaq8W4YwJVDolqBnlb1OFbxEA7jySu4NwZUe5lQPn1JO88PRksa3tJglxDNqiCDl1HrwAd4Is6lYkb0G4VLVSzKRzGqx/KZXJPK3y/sDyWqwlVFo5Lz+6omDiKXET/syB5360bk0kI81QnhLCEgRHkPrDuhurp/Sd+sg2m4RhjSHc7oIE/FnHUBAT74rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGl5HHVXunt5vzbgqbyv/IwjlxG/8cAspfoe19QCKmg=;
 b=mjb1tGefw+hskThBxcMJRjPcTqcZ2ToyjLZ0pKEAyNyXSTQstPfXhZBtYePDks4oi0NRKOY5wbbS/BAahP/9xXitbyO2xYe5CAPTNB1inQ7Pr5wKKluTFZRgeSH9vJf1oabjauIvGHFCdyn4k2SkJbNIYiQijvr5mKACGvoV70ZlE7yZ1rfPrwG3r/BNbaYFrzQkC/WuIprN7WEjW/0ZfD/qUtgdiz0ZR2pbkRVM2oNSmC9L5FfcizGHVY+wIQFNZS3X2EARLA/SkLh73mv47ekKSQQSx8+3PJnJ3UnhFe7/EkTaeaj27lDq/1ZhXdrm3Ahz20U8c9tCrz3zAu5Rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGl5HHVXunt5vzbgqbyv/IwjlxG/8cAspfoe19QCKmg=;
 b=Pi2VIE17urlJ/7e1RnMnGmegTST4GJs8CqRMFuqYii+kUVgVWvmbFbu3su2PtRed6WY08g+0fsrSUAv38w4yNfMGp3PNEEYaGmLjEwkJDLr+hchOj10fHjB5WMMqjQOs/yBkcyg3EG6r+sBDYdFmpzqZ4vsHCK7hcAnXEnCEzhE=
Received: from PH3PEPF000040A2.namprd05.prod.outlook.com (2603:10b6:518:1::56)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:39:24 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A2.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Thu,
 25 Sep 2025 22:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:39:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:39:23 -0700
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v12 25/25] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Date: Thu, 25 Sep 2025 17:34:40 -0500
Message-ID: <20250925223440.3539069-26-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e4e64d-bc3b-4c55-f4ee-08ddfc84606c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AvfwTB/6ih5LVktMX2zD7Wg9iWQT62HcmiBrbaA2/aiJLgMO5ZfrSrz4DMwc?=
 =?us-ascii?Q?fEBb6ci/CUKE05UHAD/IwKgPoTsyIL68wIz9wFxjWKEXnpcxaujKMSlkVOXt?=
 =?us-ascii?Q?9U7mMNrQBm/vyqLm6orzpammGhhqiJwSQ3CaFO8cA/iWNxiU8LfUOsD9G8e7?=
 =?us-ascii?Q?cPDKEOYCrLcWVlMudA//NC4KCa9Ryf1gAHRck+wPaRSqWkqsEXa8zfS/ndZn?=
 =?us-ascii?Q?Ue3bvpFOG8sWH10+k1bHqNH/Abjxmuor1GjYvN1TtRa2J+LjvBv7Jkh5xWTv?=
 =?us-ascii?Q?ftBZtFS1KYe9kEZtqUU41NQ9q4s5TrJsBqSujm0fdj5hOL57j6UF/POdZ1Hk?=
 =?us-ascii?Q?+cwNtJAe80QQGU37ulWyFS7lth3hSqmoaGVdRM8LCDGcno9hFAW2zTAwNrHc?=
 =?us-ascii?Q?zBfRQTICvyjiNs5Fsy+h/g9yL8WywaS+04+xhlTEvBJTwIIj16eH6w3iy5/b?=
 =?us-ascii?Q?VQQjJKZ1cdCr1Tv2pOgetnjHtwLvzVeB1OK2uosWEfbaSctRXatmXWBbTpy7?=
 =?us-ascii?Q?O7BQDdHPvx7Q+yUXN3YOuSoGO7xZDEmLjz6fjzD5c3mmRVLpvPnlnZrO6qaC?=
 =?us-ascii?Q?fHeSN36A9JP8yIijqfiltV4Bg4brh9aBsdB5+T+uKez2EaYhO7Ubbr9YmEqJ?=
 =?us-ascii?Q?Gkdi8IFZ9HFVC9cIY8OATrGK2vfxrmdLe4+JGO7Pr2c7mOkpOQ6ABDKzZBuP?=
 =?us-ascii?Q?kACPADDTSgaEVFolD28ybSn6Knezzo+hAUs6UDjYc8FY6t4A/BOm8SRTnObp?=
 =?us-ascii?Q?p96CCVdcltJKSvTIizwkUnyQpsBqTKB0W9nUXdgohB3qeBVCn/HqvZuL4thE?=
 =?us-ascii?Q?Ji3+/3k9KCKUUW+aWLhvmSfvi6sAcAztAdYYKkwI+5SnpbKttR7mUfMGNl87?=
 =?us-ascii?Q?pSzFqlOXUGAmFVsTLxnPKOtek43sBw6gTMQRUt64B2t+kPYyVGteJ+o2pTTg?=
 =?us-ascii?Q?cdc7xvT9UuuWbfaBGItSKLjjRpCyzmKVcho3uaTotjJ7tRifYxc8/7qp7Jsm?=
 =?us-ascii?Q?eooIowlhJQtCzRv0w31PGkzXeU9Fm7NUtewpvAdrf9AUNT6S6Rxif911OOhu?=
 =?us-ascii?Q?4PwWP2nJW0C0ZTP2L/s5EvIqFZg1bvkbSgs415TKOEtiyNEdLcnHMUrYmXv0?=
 =?us-ascii?Q?7b/HvZhrEYbS4PONzh9WJ+mx7Ux2q7jskzuSDsDbXmT1WgqIAXhuvi62GSoc?=
 =?us-ascii?Q?+6s03yMxQZAdtw4bvE6Ft74JVbVwXXkm5dx8XhgJsEJF1r4y2D2iyhNyDfCk?=
 =?us-ascii?Q?2F6GTuxoEvL/tm7K4J2kEdacKz3aLAb7y+ZJ9VYWh58HF7chR6dOyLTco1EM?=
 =?us-ascii?Q?8cO70wYQ3X4GnFkvlDZncvEuL4jjEo+rvgu5XfhmvDCIQqX80zARgwP3f06e?=
 =?us-ascii?Q?3TASuEtzgThM71v5IN+/d/GgCcvUbu0Wjhtbhm8nYPKQPKR6wJQhMQRB/Po3?=
 =?us-ascii?Q?VE12xFkNa6HGiMA4+uEUJwKr3aaIDtATYMmBR2tz2L89g3QRGKk0U4zY8+x4?=
 =?us-ascii?Q?G4qDxXyK/7mbbSwhAQpRVMSjDFlVyhswvADKiuQ2ogxdtClRmaLw1t6GN720?=
 =?us-ascii?Q?TT1Xbb+aFNi/t87RDx9Mst4MqPGoVdDHCGTJwvVr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:39:23.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e4e64d-bc3b-4c55-f4ee-08ddfc84606c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

During CXL device cleanup the CXL PCIe Port device interrupts remain
enabled. This potentially allows unnecessary interrupt processing on
behalf of the CXL errors while the device is destroyed.

Disable CXL protocol errors by setting the CXL devices' AER mask register.

Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
Add to the AER service driver allowing other subsystems to use.

Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
Endpoints. Follow the same "bottom-up" approach used during CXL Port
teardown.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v11->v12:
- Keep pci_aer_mask_internal_errors() in driver/pci/pcie/aer.c (Lukas)
- Update commit description for pci_aer_mask_internal_errors()
- Add check `if (port->parent_dport)` in delete_switch_port() (Terry)

Changes in v10->v11:
- Removed guard() cxl_mask_proto_interrupts(). RP was blocking during
  testing. (Terry)
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/port.c | 10 +++++++++-
 drivers/cxl/core/ras.c  |  7 +++++++
 drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
 include/linux/aer.h     |  2 ++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3197a71bf7b8..db318a81034a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -158,6 +158,7 @@ void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
 void cxl_port_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_port_error_detected(struct device *dev);
+void cxl_mask_proto_interrupts(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -187,6 +188,7 @@ static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
 	return PCI_ERS_RESULT_NONE;
 }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f34a44abb2c9..337a165e8dcd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1434,6 +1434,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
  */
 static void delete_switch_port(struct cxl_port *port)
 {
+	cxl_mask_proto_interrupts(port->uport_dev);
+	if (port->parent_dport)
+		cxl_mask_proto_interrupts(port->parent_dport->dport_dev);
+
 	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
 	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
 	devm_release_action(port->dev.parent, unregister_port, port);
@@ -1455,8 +1459,10 @@ static void del_dports(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport)
+	xa_for_each(&port->dports, index, dport) {
+		cxl_mask_proto_interrupts(dport->dport_dev);
 		del_dport(dport);
+	}
 }
 
 struct detach_ctx {
@@ -1483,6 +1489,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index ea65001daba1..a297ce5e3d97 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -253,6 +253,13 @@ static void cxl_unmask_proto_interrupts(struct device *dev)
 	pci_aer_unmask_internal_errors(pdev);
 }
 
+void cxl_mask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_aer_mask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e018531f5982..538e953c49cb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1119,6 +1119,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Masks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+				       0, PCI_ERR_UNC_INTN);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
+				       0, PCI_ERR_COR_INTERNAL);
+}
+EXPORT_SYMBOL_GPL(pci_aer_mask_internal_errors);
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 64aef69fb546..2b89bd940ac1 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -69,6 +69,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
@@ -77,6 +78,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_CXL_RAS
-- 
2.34.1


