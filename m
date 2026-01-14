Return-Path: <linux-pci+bounces-44823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A212D20D64
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC58E3013BCE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2588335064;
	Wed, 14 Jan 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VE08Cxs2"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44C8632A;
	Wed, 14 Jan 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415261; cv=fail; b=tZyIylziNNjm+T56xBJfWFDKv3C5PiyZuv/5h1R0jVYuarV4FBWhPIsM3BQIYPb4ELmbObBblhTVladzmpWqvY3ewANsHAUZD97EZ5cEt1HIXQQWqd/ziKEQLatQMd+Y0xCq6tny4btD95XDijrLa9QPV2NH0AOV54UMotF2KRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415261; c=relaxed/simple;
	bh=Z9nvbjt0n5AISIHFiyKjWgTMlQil/SFru28crEgUbDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rho8R5wL6J8iwpGmmXmoDBONhOT0/fa8yX1H/7tG7JQNRJe8z/U6uqwqSuA02Kj0WaVYnP4hDNJu6R0uv016gkwDt4iZTgNAT/R/iPGJ2do+13CS3wdIshYlTJ/mmF+b581O+VoovkFpC7OSew2HL87XpYF6eMRiR9Qt75aJQqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VE08Cxs2; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuT+55tNjUP6j0alWRYe34jS+HLpJVlU7023iYQKNWZThyIozD0Dkv24GrhMAQz8Fr6J/FIS9qmQU8Gv9wg+eDu0K3XCM/wAnRegXcNfAukwSFsvI91LA7D5rDrk7x9kPwHIuIj/IWJxwhSfOdtYbXuy/rkAyrvIkL94nTje2V+4amca9Al1mjx73SKFyvEs44iDD863a3ql+irHRvVVllVs2SWVwFMb1jqB2ftDxZ8GVEhKR9rnC3VXlu1KMrN5V2IZMon/T6I3H/JlxgLw6cDC0buXOXEKG7ILQh/C23ayC0qrxoWaRjvO3Xpt1fGI1VtrdQcgVGLFQnOxbWVrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2ezZrl6rgOgNP5WN0VidluwKCP12jFTZHSSit65SIU=;
 b=GXhCEIwVAu/j0swWbohZ1doLVNZcgFIO8qEzOAs7yJ/NO7yTf9LklBPtCMrkUDPbyb35Sn3IIJ0VIuUgiPgKVGkOKqNtlIuL+vK5F/wtbGBAqSH5HGUBvV5+kL97EPtPG86rAyBgtF7ezhfG58+uZTSOMOuaXqK2sLp982U9p85R+iWNonf4f1NXu+braDnkXG/j/4VmPu7iQ4nduf37TNngKDTMd9J9cmMIzKFwPbIPRd2mgQvU6a4cj+c/dXxK4GknfyVxHO7ySZSpsJ1+zaDPT+TG2qe3rW+yFXVtR8w90oxUlVJBopPprEHxUjkpdbL6gYbvSnJbJSd+a2CAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ezZrl6rgOgNP5WN0VidluwKCP12jFTZHSSit65SIU=;
 b=VE08Cxs22L3JieVMttQEQu9e8SQ19b/Vj81evCHuK9lmZvBWVqD+YZpTyhhF2H+LHdVz0ZT3VLUlka8lU1YWpSRD0qGMdc6OdX/5ra5+eJ/fgMfJJ0xhP41KQ6Dcwj8V5FvZjcROv+voeSrxqQJWwOa5S3XQ2tnUdPAYucdYfk8=
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 14 Jan
 2026 18:27:36 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::d7) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Wed,
 14 Jan 2026 18:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:27:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:27:34 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
Date: Wed, 14 Jan 2026 12:20:51 -0600
Message-ID: <20260114182055.46029-31-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f7ebe9-7f46-4477-f22b-08de539a96e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTxgzvi8esm+qs5meTDIVVfbi+XQVg3ExW3BQRSWNAoTVnhnBt/IkNW1XGHa?=
 =?us-ascii?Q?YTCF6ZVVQuqYk5G384o8v6ze8DofeIOX1Bi/JYgmTmNa4nkF8dUSOIMMMEnx?=
 =?us-ascii?Q?BHZwfO8G6DiaxFdDcERefY0vlqM9G505T0kz1faF4Q3mc/Cbt9OodmGh9HhQ?=
 =?us-ascii?Q?hetUZ7vVuYA5E8LESqip09seOS+iwXGvReCvrNYqI1Idos2qpci1SyfzYgT9?=
 =?us-ascii?Q?oi2sKDQ+yNqSIm0GVMN6hwKZ07eZPnHs9z4RC2OZ/PYF3ekFUnQORE3iprud?=
 =?us-ascii?Q?iUCZczmipBW3oU98w5fqFDOUXqBa8NW48NsArDApWLTzq2gD4bUNU+pdE+9S?=
 =?us-ascii?Q?q+nWpWbWPywxE1dVwraCbHb22uacj4kha/hyPJQEXZMPVrz+NRP82rP7/olf?=
 =?us-ascii?Q?SSmyfD/aLHwA0rI7sj310OcKVpukQbnBJtY87niRUUi8F66age5t8NNUuNCC?=
 =?us-ascii?Q?FpTbAP9pXiHxm0W8n4iAhgXknYm0S/v/myqn0L+uJcSgHE0WEDqV7sja1IUr?=
 =?us-ascii?Q?Hs/yhsPgxJHaR6KclbSdt11TpAjJ6maudhObDwyZl8XrK7/Wt3tV1xkfycuq?=
 =?us-ascii?Q?fehJpnjTRYqrzg0tTYRNuWlU2kTrptGynsuYTBXUmdyffOZWZ0VrGiSUjaAd?=
 =?us-ascii?Q?es1vcTBYgRodp9gfxRmzyGBuZSd0cpbkJdEYPMyk2V9ImljMZ2x87D8vYvPV?=
 =?us-ascii?Q?j2TgEOD1/paUXPhIYVEG7PwuyobtnNP6S/Y1hJWtNWwX0JczrES1Acwrrpu7?=
 =?us-ascii?Q?irUpH/KXdCTATfxbj29MQwHIJR7prIPxB6YhJ7UF9DBIIBlFFLWuLV6fC9Lw?=
 =?us-ascii?Q?sF0dmwdg12PxPEPE8oXaMrJjOxlwz5j1riul4f6BS+FkDVaAPjlCVuI8jvBE?=
 =?us-ascii?Q?H35+QmE2tttJh1c0mlDp6kKd6El7HBJNKLfcouo2VJrCIlFkxty/oWT73uID?=
 =?us-ascii?Q?X0gPAzGCs0+vAdatN+ZnHq8QOOJJ0BUaUzjQPUY2S6zyevBs6/C6ae4LpygB?=
 =?us-ascii?Q?hr7SZusGQnwRBZx7c4V1k7yvZy7aqT2DiKNmp7W12c3JroUj19ixAarsp+Mm?=
 =?us-ascii?Q?W4aHFfeUkUhKom/kqy9KgjE+fSnKL+3Bjt5Q8RulckjNzAdAG+C1KF4oxK+t?=
 =?us-ascii?Q?1MHUUXsfIbv1shOnSjjHVdm3Q35vfj1H+JLfVH4CTsDMDXGGiFBRt8ZQzOEH?=
 =?us-ascii?Q?XKrJjZz2QpHPHbHZckMXmW0phKpRKR8j1Wyg/CkvD91T9cGe0dAERvsPqgDa?=
 =?us-ascii?Q?DRO25grcEb7q/4mP/m5vxtIPDhY3ABm/Ta+cB8yqJM+7SRLJa5FPvIBaHPp2?=
 =?us-ascii?Q?kcGrgzG1nuzhEEcgaf6T0UMIlqFGTIWI648/g5QfUoijg3Ma3F/6NeLGAAnw?=
 =?us-ascii?Q?qEAKiqJoJkvNPjVMUAWyMAfp7MbmeP1K2ALHVXw4Q7PPxKsbAxqshPqnB5hD?=
 =?us-ascii?Q?Bm2GENxlf2VuZqBCU3CMz8J1Zb8gJCDm7iLAuYIzDbRW5JcEiF9Ut6Iu86D0?=
 =?us-ascii?Q?rx3Y+uJeahjRHX2zE0Cx4ui+Cp6VM+aHUbcih2Q8LGXP/T6hncux0NVmLwH1?=
 =?us-ascii?Q?vm5RPwtevVVUeJzaw/QGwUPqupsMNQrIObe1Gc/JHtHFt0Hwd386hTids9Cw?=
 =?us-ascii?Q?PZ77zPnMMJb4NwGm4+tcw0maJJAMDzsi92KTZ51tuFp7Q4H5Wp6eLb8u6aqc?=
 =?us-ascii?Q?GAwAX/YNgyYLJWRzPMnvpZdHmeI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:27:35.3654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f7ebe9-7f46-4477-f22b-08de539a96e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

The AER driver now forwards CXL protocol errors to the CXL driver via a
kfifo. The CXL driver must consume these work items and initiate protocol
error handling while ensuring the device's RAS mappings remain valid
throughout processing.

Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
AER service driver. Lock the parent CXL Port device to ensure the CXL
device's RAS registers are accessible during handling. Add pdev reference-put
to match reference-get in AER driver. This will ensure pdev access after
kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- Update commit title's prefix (Bjorn)
- Add pdev ref get in AER driver before enqueue and add pdev ref put in
  CXL driver after dequeue and handling (Dan)
- Removed handling to simplify patch context (Terry)

Changes in v12->v13:
- Add cxlmd lock using guard() (Terry)
- Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
- Change pr_err() calls to ratelimited. (Terry)
- Update commit message. (Terry)
- Remove namespace qualifier from pcie_clear_device_status()
  export (Dave Jiang)
- Move locks into cxl_proto_err_work_fn() (Dave)
- Update log messages in cxl_forward_error() (Ben)

Changes in v11->v12:
- Add guard for CE case in cxl_handle_proto_error() (Dave)

Changes in v10->v11:
- Reword patch commit message to remove RCiEP details (Jonathan)
- Add #include <linux/bitfield.h> (Terry)
- is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
- is_cxl_rcd() - Combine return calls into 1  (Jonathan)
- cxl_handle_proto_error() - Move comment earlier  (Jonathan)
- Use FIELD_GET() in discovering class code (Jonathan)
- Remove BDF from cxl_proto_err_work_data. Use 'struct
pci_dev *' (Dan)
---
 drivers/cxl/core/core.h       |  3 ++
 drivers/cxl/core/port.c       |  6 +--
 drivers/cxl/core/ras.c        | 98 +++++++++++++++++++++++++++++++----
 drivers/pci/pcie/aer_cxl_vh.c |  1 +
 4 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 306762a15dc0..39324e1b8940 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -169,6 +169,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a535e57360e0..0bec10be5d56 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1578,7 +1578,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index bf82880e19b4..0c640b84ad70 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
-}
-
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -173,6 +162,44 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
+/*
+ * Return 'struct cxl_port *' parent CXL Port of dev
+ *
+ * Reference count increments returned port on success
+ *
+ * @pdev: Find the parent CXL Port of this device
+ */
+static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	}
+	pci_warn_once(pdev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -316,3 +343,52 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
+{
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd)) {
+		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
+
+		if (!pdev) {
+			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
+			continue;
+		}
+
+		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+		if (!port) {
+			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
+			continue;
+		}
+		guard(device)(&port->dev);
+
+		cxl_handle_proto_error(&wd);
+	}
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 2189d3c6cef1..0f616f5fafcf 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -48,6 +48,7 @@ void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
 	};
 
 	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	pci_dev_get(pdev);
 	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
 		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
 		return;
-- 
2.34.1


