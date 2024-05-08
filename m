Return-Path: <linux-pci+bounces-7255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B28C036B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF88B210D1
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF012BEA1;
	Wed,  8 May 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpHjXscY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55D12B14B;
	Wed,  8 May 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190136; cv=fail; b=ZJ46pqe7YGtgP0OyJMILxFBNTKtkxikgjYqJjfCNIlKSrYVpcBML8ZaJTpAoRy9sXvcLYS2KrsUGeXr5/B0E+lssGbER/hMDnqaa5YQkOuvaswNpUbFNXero6M7VoP2RVuTAqTAaRF14wJJIaFAeJq+cSBfFBFcuGBcc8+5wKIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190136; c=relaxed/simple;
	bh=bbPaNVHQDtYt3rxbAZRWARQp1sT1B9U2icJ8j+N+dwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI3HEspkfAfIjYJf0r7d5VI3gyjBfS+YR6vM8xjGLx7ZOuDDNwfM2NPpQ3O5doBVJJVCIh6ia3KEmVMhXh+h95afrcuFCUlPyM7vuPviVtAjdOM+k5VM60l9o072OT+mhXMudUo4THZeywHf4Qzltr3xdGUJQ7b6WM8VXw40bKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpHjXscY; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug5IkvNCyx1B4Zt9Ziv6s+BKfD9t0lbThRmIt8CCTMqvQs0ZNp/by2YGjhFEPkkhFlAqEZzOleMQFS3W0GMFrQkNZeIhZ0YeH0I3V359C8/t9wTZ5sWLrZEkO1YaDIcukYQjIuL5CXwYQMKxuNQWyN/Q+giE6w/pOnanD53Pg4Ub0+f7ITROcYuR5X1d+sjk9TvkuG3JDB4gHVLgmq8u98azbMcx53f6v08PZvNTcenaVkJ0YEQwF/oUPibbgnsYx01XJuwJ9tVKnM2w6bV6uvbb+vjBiDwiJku4ppIECWIAuRDzaJdhVU7oSXk3G2vMlp0a31B0P3yxthD5FMbKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuSu85Yw8h/x1UtvtWWic3WpwzTJcJHglpKY88sTqww=;
 b=dLQTTrvWVExdna/GFVj180O6sEG8Qs4Vg++VxDW1V5GsVVoey+FfuGbgVZJE5VAusBQ/jS9UimBnhAtydLK163+Oj16vABYGssX3zjwdmsptj0u4dciNa7Ir/ffcp4gt/RbHkcI7wHvG5d0zJ7WbWI/1gRKRRR6fa2wOZMMi1QRJc9FqYudn2ssfUH2tln2HFHl2D9ycmTN3evp2aSWPmkb8pFKeUyb/PiAlNmz9rz/wDMCFDVTT35PKKMDHZ8E+/Q/wibizFaYXawwqUg1XhjarLiDgLd/ukdEP4Za1AxvlzQU2EIaolp0qhhB8uilvjxmt4raYbTQILYsf0luYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuSu85Yw8h/x1UtvtWWic3WpwzTJcJHglpKY88sTqww=;
 b=cpHjXscYO60uVaw+SrlbZNDCeKKhL7k5dbW28X/VJJOZhDYn1kizXIkr8koDMT+za81uUeCgZLC29CI+IejUVkHDBFRRJjJp8LzJapVG7nP9SNIwD4m82gMlAFimW1zVYNqZH5CiOXwp9PX1oPblkBj0qopkwwJLrykDm8g4FRZX9cLzOU+RtJtOGGU1CnAdiBPx2rOafwVUIWUIT39FzFZaPbSAfdzrASvhpousCNIOs89rEWmChc58RjOLAPiBTzTxoS7WUp2BNmmEruzrN/u+WktJRdwZCtnWxhTj9oA9YVWAsRwLboXjOe026yLWooYZ3SUG3wtLao9bXTMszg==
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:42:11 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::24) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:42:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:41:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:41:54 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 10:41:49 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V7 1/4] PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()
Date: Wed, 8 May 2024 23:11:35 +0530
Message-ID: <20240508174138.3630283-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3d7ac2-8665-425a-fedb-08dc6f8630ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JeDmRNTWyxu4EKFSJig5bRIIL5VujCZZrj580kGI5vcCtK5pX0a8Q5ovNaEZ?=
 =?us-ascii?Q?pf284RU8n0Nj6VE11KchGg4bWSuJJnDwS1Q+aL97b6AysoD7W1EPV6Wu0Haf?=
 =?us-ascii?Q?QC1TYjXusMfdUTmkn1b3oY7iHsYIXI5I4o550j/w9AogJibegFjQYFfL1Zcd?=
 =?us-ascii?Q?nnc/P7qu4RQWsW//rnCL3qYx+mh+qO4LCLsAqXLP6/eT8DbczEpJ+63iLDlK?=
 =?us-ascii?Q?zz0sXO0d7L5AqGLjs90zf5GLmtapv+zv7cpsxBhA10dFgqglzcOsMIzoOCPW?=
 =?us-ascii?Q?/II/4jMBbLJ/Pzjq53T1U+keb2RJ2qgCzLL6enLRjAtWsU4lmUaD3EM8Hwf9?=
 =?us-ascii?Q?dFT7hqdJWz2j94ZEs/UDDKBYDCglAwUMYAWrBS1dbKQdhsT1b3FrfZlwj5YJ?=
 =?us-ascii?Q?1lcCotcZEmT/8ylMyZwrcdgCq8Ig92Nr328LAqbXhgzkdlWOZ0RBPuEgA4lx?=
 =?us-ascii?Q?uiTx6pKkkwD/CZbDI6Dbz0vMi7YV2bNp7XNkrlwYAg9JNUPZDWMmsuwBYO2K?=
 =?us-ascii?Q?ty5gt/sez2Q65wgW6oDzTNfpPn6my7tYx3MrP61nZYAO0Dre+NdjmL9EsMoX?=
 =?us-ascii?Q?YjDOh7Xuvi+XEdJRUh1gGiNBOOmTFkuLfOvgsZCjfAb0AMRHjNsbq3d7Mez2?=
 =?us-ascii?Q?Ybr24MeUVkAQS/jQyw14sc7aKURdTz92iYsVRShEAfZJAtdDjhhsFtipmc8g?=
 =?us-ascii?Q?emZqD0UdfZ+xu363T8ur45yhU4tuylGvD2I8vUZ8KgViZW/CqrOhlIuIkZTf?=
 =?us-ascii?Q?6HvwCGLOfqBbiCV1cmmocUKylh5zoHnl/xx02ww4RHz9ugyf7mC2MxSIve9v?=
 =?us-ascii?Q?kl2fHmX+ONbNhe5mcgNvfqmaUCxNZUFOlyLby9f3nQYb0vy9orSASWSwzP2a?=
 =?us-ascii?Q?UGJAWInddBpaSA3LI05S60V+JejCJzrHXHyKw9rteIOuNEuyeQqULHhCL6RJ?=
 =?us-ascii?Q?cqK/b5FzfwjiOL3lNYIUJhWu6T37oeNoEK0IP98YOLwgjDTZG+zRoy4Mgxcr?=
 =?us-ascii?Q?0rqCiMtO/m1GU0k9xj+w0MyJjlv/1X3Q+G5XN2FfINXEUayj00xeSGgR5DpP?=
 =?us-ascii?Q?V6bepBXMNcPJzsoMq78yPhql88D3lXt/F75FTJPTUs/9XJcyQ2cRqYZO3cYm?=
 =?us-ascii?Q?DQ/mX/5t0cmj1aIn4QIhk7Md6gCg3wPoez/qG/+bMw8mFfViWTxgeCcv1GJO?=
 =?us-ascii?Q?YN1uqNgbOXm3kkqBFqL16KtAPpHlpfub7e17KzO3w1j+I+/XMus9HAFtAeh6?=
 =?us-ascii?Q?eNExHBNIOhcfl7+yk5Zo1VvTDEIJw76/maC8SqPW5lg0kzL85KPKGaRdqk7V?=
 =?us-ascii?Q?GrqVy/YFLlJBi/Ngab1ysCsNkaq4Yh+xyt4mrR+UNvnC3lRAz4jdThPw6zJY?=
 =?us-ascii?Q?2wmsHPvhj1/ZDEDauSH1FCcnIgOe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:42:11.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3d7ac2-8665-425a-fedb-08dc6f8630ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

Move the PRESERVE_BOOT_CONFIG _DSM evaluation from acpi_pci_root_create()
to pci_register_host_bridge().

This will help unify the ACPI _DSM path and the DT-based
"linux,pci-probe-only" paths.

This should be safe because it happens earlier than it used to:

    acpi_pci_root_create
      pci_create_root_bus
        pci_register_host_bridge
  +       bridge->preserve_config = pci_preserve_config(bridge)
            pci_acpi_preserve_config
  +           acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)
  -   acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)

No functional change intended.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/acpi/pci_root.c | 12 ------------
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 drivers/pci/pci.h       |  5 +++++
 drivers/pci/probe.c     | 11 +++++++++++
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..ddc2b3e89111 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1008,7 +1008,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int node = acpi_get_node(device->handle);
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
-	union acpi_object *obj;
 
 	info->root = root;
 	info->bridge = device;
@@ -1050,17 +1049,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
 		host_bridge->native_cxl_error = 0;
 
-	/*
-	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-	 * exists and returns 0, we must preserve any PCI resource
-	 * assignments made by firmware for this host bridge.
-	 */
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
-	if (obj && obj->integer.value == 0)
-		host_bridge->preserve_config = 1;
-	ACPI_FREE(obj);
-
 	acpi_dev_power_up_children_with_adr(device);
 
 	pci_scan_child_bus(bus);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..9cc447da9475 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -119,6 +119,28 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 	return (phys_addr_t)mcfg_addr;
 }
 
+bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
+{
+	if (ACPI_HANDLE(&host_bridge->dev)) {
+		union acpi_object *obj;
+
+		/*
+		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+		 * exists and returns 0, we must preserve any PCI resource
+		 * assignments made by firmware for this host bridge.
+		 */
+		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+					      &pci_acpi_dsm_guid,
+					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+					      NULL, ACPI_TYPE_INTEGER);
+		if (obj && obj->integer.value == 0)
+			return true;
+		ACPI_FREE(obj);
+	}
+
+	return false;
+}
+
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
 struct hpx_type0 {
 	u32 revision;		/* Not present in _HPP */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..180d3907b543 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -734,6 +734,7 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_ACPI
+bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
@@ -747,6 +748,10 @@ int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
 bool acpi_pci_need_resume(struct pci_dev *dev);
 pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
 #else
+static inline bool pci_acpi_preserve_config(struct pci_host_bridge *bridge)
+{
+	return false;
+}
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..ee086d029450 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -889,6 +889,14 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
+{
+	if (pci_acpi_preserve_config(host_bridge))
+		return true;
+
+	return false;
+}
+
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
@@ -983,6 +991,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Check if the boot configuration by FW needs to be preserved */
+	bridge->preserve_config = pci_preserve_config(bridge);
+
 	/* Coalesce contiguous windows */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		if (list_is_last(&window->node, &resources))
-- 
2.25.1


