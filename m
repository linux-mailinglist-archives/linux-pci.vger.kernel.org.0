Return-Path: <linux-pci+bounces-40183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F30C2E993
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A50B189AE0B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6B1A256E;
	Tue,  4 Nov 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S6K1EQ0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B61C860E;
	Tue,  4 Nov 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216176; cv=fail; b=mAxkuezPgM1Ai8M0VdULuwhmC4tBo45dpO+0G2SJht2ni1PulDPc3m3mqKb/bKt7J3/bsZ+39yYFTSP8V1em2peGEp9i+twicT66M+Zv56OoEstZJSqhBk3sGwciJnGN2R4UjPivDKOpIsDEBQLO3oy9kMmtTmeM1dYdY8Bs1IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216176; c=relaxed/simple;
	bh=HRwPiP9x2NTGozOQ102FKDbBWNN50Z/sayCBvuTw/Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/Kx92x0aEC8XVUO96tfdnFzi8fN6NX4tXzRUVyJLZ/JqquSnosnWm0GI+jF2nmumnBni+anlVojuhZYpi5WkTcxbLUGe5ObZf2cFtrKibLYWNi2q21ysgn2o2HZCfU/K4/aDA2i1uGTPenV0N+sWvy4bkdrAcyOVUSZrf23cm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S6K1EQ0A; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqhNhGat9rT0bwus7kUNDLJWdyIXKH+e4pnRdLIE2QFHFI/SA0BRS9k4Eplx8pcueXmcZd6OgOyhhkG9O9bsITYHI7X6U6LrtCX2bSvXC9jJ1uPZpABUU5bpFD6SEQRoHKxe1lCuz0kHGQv1Ao/wnAldDhzAiqFAaGv5MjOoyNNa4JcI9eSIo51vuPInGVHNM6iUvP3xFqO87KwUvKZRZfhH9E089zu7V/rqLVOcFnb/4J5u3ZhZ1RFkaZ6FnWiTdiNRX6y3pwXr/ur0HPulPpGM1LnphulwLPTICoP8tiarJn8Vg/32yiUm/Psal6UVvAxGrdm2JBUaXdnb0HPw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6LmVebsgT4Y6EDCUmLUIUAbb0b77qwZs90gM4F976A=;
 b=onhKGvzioz2UhjjFjd7NQo1K+z/rfr325/ooYe/RY2ONjvnAcK7rUywyDQPGfH8X6M7XaI0cjEOMJjkEmp+swtCn5zQp5shGKdeD+9B/eJWpZfPiEPzDKfYZAO1/svD+I9m/4AuT1rX0TSOZ15nQjT/jFS1Hsj065nz2ECUbk6tsiih1o/39vguObW4vITUB+zMxFNmGO7aJ3s+WNKKLhcereD48yjB+AebJoG4FkR/iLpfkFhyOpHNdxU5W/Ff5kdyAQgQaQc2eMwopW5hcfSEH/41YvDYSI9GziAKmGaqGQmnnpphVp7cH6u2Np2dqqF5E6sGD/FpzlGcs5ir88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6LmVebsgT4Y6EDCUmLUIUAbb0b77qwZs90gM4F976A=;
 b=S6K1EQ0A6X0FR02yYxFOmVxzFa67oyclNQ/Vwg4MqKGm6U61Koh746p61LteqzOQoWClvznd4wZoPGzFD6Z8m36Cq1d0Hf92RKq5oebvDBCIiEIY9KTRQQ23V7Kn1PjHzDofdDOcXXGWQZGXKr490vNV2I14D4zZlnK9GoO6E38=
Received: from PH0PR07CA0045.namprd07.prod.outlook.com (2603:10b6:510:e::20)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 00:29:30 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::4c) by PH0PR07CA0045.outlook.office365.com
 (2603:10b6:510:e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:29:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:29:27 -0800
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
Subject: [PATCH v13 25/25] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Date: Mon, 3 Nov 2025 18:29:10 -0600
Message-ID: <20251104002910.3888595-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002910.3888595-1-terry.bowman@amd.com>
References: <20251104002910.3888595-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae3da18-6275-4ed8-d8d7-08de1b3937b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zR2fYe9p4qVXfY465nafyyOD3csr6Mu2C4qFbZ1M0ytupT6UEgLniyiHb5B?=
 =?us-ascii?Q?fPOOUdYyYS0W45r/gYRqmy3k9inecJcDLPwg92TknvnSkoc65P9e23NgrXjk?=
 =?us-ascii?Q?YR5Y0xFp7Kxhz7LbNWgmWw1yeu8DJ98NIgdc9w2a2NuR0axwqOxizu94X8BS?=
 =?us-ascii?Q?VGVzkfkJSxszR6ryQlSOR61pQo7i6UI6ubyjh6Vd3TeQsMjNE5IUn3GGv321?=
 =?us-ascii?Q?/GrcswIfrZLeOoP/4H+vCZZmfOUIMHTiUENBccYXtvq7cpP7QjRNJX0Q3BlE?=
 =?us-ascii?Q?9GxDJiL/z/e+bYHgzogKYA8ZA6JOfs+YzewHemG8Z3xQlcgePds0fsDDPkU+?=
 =?us-ascii?Q?NUervR8Tqee2LTD/xmjGx1uobQDeqIfbakKaj4ADvXc/fzWhQ0Jq5zDVFlX7?=
 =?us-ascii?Q?SaFxvanuH3rJjFGXnHWsG+v7Dq5qkAFWQsbnHw/jqB27stoPxSqufCh7Fv+3?=
 =?us-ascii?Q?jvMkrn5O5/hp+yRlhv4iQvA9teJq+AJK+tqsND+zIW/8zr0o74SnIWO02CpI?=
 =?us-ascii?Q?f2iB26h5xV37Sz85kMbO4Y5OIuJJ4fq9ME6urCmhNVjI6D3Zrb09bvfwXG7A?=
 =?us-ascii?Q?8AOtyT1l00rvpy+c/wRW7puC88P+LzczVpIhrm4J49Iz3KbL0L6Px44XpgB4?=
 =?us-ascii?Q?o6SgjPEKidyLERFeTVk+y2p90+Mzn2ok4Ym+jgYj3X6VwYIlv3mntQ0xJkBD?=
 =?us-ascii?Q?oKxwvSpGQ7WdvG4XUURZpb+c/PvrIy5mrt5uSEuBym2wHf9xSlfOJuuPQ4yy?=
 =?us-ascii?Q?5R+NiBmRGvpMfznCnS45VPZRbWkpG3w/uUZ3dsGnJ9U/tbPQ5Guc55/1gd4+?=
 =?us-ascii?Q?c3NwoxXXJJb/BtHeJg9Gem7YkGWs9viOqsH8E40Yf+YSDD/fbaLvAI+VvcqY?=
 =?us-ascii?Q?nK1LREBSQJe6diV2ZnU4e9L9euC94Pqh1wOZdqahYkohcO8J4VaIgrHn+vMH?=
 =?us-ascii?Q?DH/tPHUfnK5YimJ+QcL+dKFuJFvd/4YhuH1EGRQh1Rv1sbyEU/4MybaB6igE?=
 =?us-ascii?Q?u2fQVrybT1IhhanAeY5xR++VfiiboHqQahLF0zVug9YYp/WHSsqvR5Wuz7IS?=
 =?us-ascii?Q?EevyVZGnlkoh6TPNnNqi2XVtLG/MJppfOwfY600sYrSvXyuPZjTCEN29UVYR?=
 =?us-ascii?Q?/YfgL64O/y3xNjjppBdnfk9t8TfUS9PbhA5EER99b4QsBjYCJjXmcNoDqgmf?=
 =?us-ascii?Q?SDdDpZoqCY+RgY0t1pYVA8YIDQt2ijzmBjjWEnQ811WS8EfP23e5ak7PXfJv?=
 =?us-ascii?Q?DKhaWPbIQJ+fgSDz0o4ALl/F2Gw+Kmc4Cw6yBcoqcQ+/uHde2ywtoDOtpBAr?=
 =?us-ascii?Q?lrB6UQpZWG9G7A0CzyDbCIr1V29byjEuShEmTt91XKqHeS4fjv9tLgzDzSc1?=
 =?us-ascii?Q?8z5Mo9GThyZEHA6Cm0loQNgPGMbr5dp3ktBpVtIxMP2rc+ynILHlERydWiKz?=
 =?us-ascii?Q?2k7SvTpxWlZ4CRGomhC8i6yzCaUxZXMDblL+ATDD5eJDh+Rxw2WoducVW7sJ?=
 =?us-ascii?Q?U9nQoIm3Vj0EGO6fuClHURtwq9de1KbzCDNiY/nQHHQgeQRsJDBgXBTL8OWW?=
 =?us-ascii?Q?Iypddr/4fdyi2WcGn8d05GuJm9gh8QxWPTyyGdkO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:29:29.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae3da18-6275-4ed8-d8d7-08de1b3937b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

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

Changes in v12->v13:
- Added dev and dev_is_pci() checks in cxl_mask_proto_interrupts() (Terry)

Changes in v11->v12:
- Keep pci_aer_mask_internal_errors() in driver/pci/pcie/aer.c (Lukas)
- Update commit description for pci_aer_mask_internal_errors()
- Add check `if (port->parent_dport)` in delete_switch_port() (Terry)

Changes in v10->v11:
- Removed guard() cxl_mask_proto_interrupts(). RP was blocking during
  testing. (Terry)
---
 drivers/cxl/core/port.c | 10 +++++++++-
 drivers/cxl/core/ras.c  | 10 ++++++++++
 drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
 include/linux/aer.h     |  2 ++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a23c742eb670..d19ebf052d76 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1437,6 +1437,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
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
@@ -1458,8 +1462,10 @@ static void del_dports(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport)
+	xa_for_each(&port->dports, index, dport) {
+		cxl_mask_proto_interrupts(dport->dport_dev);
 		del_dport(dport);
+	}
 }
 
 struct detach_ctx {
@@ -1486,6 +1492,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 101e55723785..6dccbe66c9ac 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -139,6 +139,16 @@ void cxl_unmask_proto_interrupts(struct device *dev)
 	pci_aer_unmask_internal_errors(pdev);
 }
 
+void cxl_mask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	pci_aer_mask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4cf44297bb24..fcc2f43c3383 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1149,6 +1149,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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


