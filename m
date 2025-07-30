Return-Path: <linux-pci+bounces-33210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DEB16884
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8307D188901C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDA22331B;
	Wed, 30 Jul 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gf0xDECu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352AC2C9;
	Wed, 30 Jul 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912153; cv=fail; b=iynaqVXRl0QKOW3n7kwszADy8MVKSHk2LDwiEaWZ58XUrxvrrpvnTvntYzqL2ccMY3kvfaGi69pe4owZnRzzF00BPdHMSMUWUtFi0wC/sWYTGZrWoIGW2ChLGWxDGPjm7pJTUCtBpXaCPae+TTmAz7HGh1iKON9IRidCwlLT4GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912153; c=relaxed/simple;
	bh=BKxC1jVAp6KOBJ5baOOfMwfKWgLxz1z/sqbOnhHzSug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9wThpyDEWvwHy/0pxXLNpM7fPi1bI+32PUlYv6uZvQvcaJd3NMDpgX6DxLRxSfxlGqEETLypLuE3naY9de4q4gHV2ZUttZHMzNHmdz40tucT+hg0VyLfiALs0XzhMNrCgVzF117cNDlMnjkor0XeaApvegot2QZ8jofM5lhqbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gf0xDECu; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjTG8hjTPgfoXI2/0lnwfGh7RjUqVv6odtTOecNBZuTiurIAITjRAeNDSmeQGR2rluQR3PMdgCtM2Q0elG8/1SVaJSYX3ozNkE96jYKw20rAe+vSv3pgx+whRz3FiJvK4C/pvgZZvafmdrvQvyqrsQpqixMBYehIubF2TU1nOyPkH2PpbyvE3e/RHk/DsIQdH/NZWqg39Vck8f/OPc/So/Jl/vSWCRwzp4FtGw2xdVjYtSuf+L6zb0qaP36tKKLLIGOL9E9b/KQSbLtS4D81tB3hLLI3cECL9DwX3qtUcUaBwVAl6Bo2Cz8Kd1y1NxjabyhJXYBy7q4se4IlD2SVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlPyCXom3Off8BJElOB0YTAVb2U9SDdcgGanU9l6oyA=;
 b=BTnPtw8FQWOPmk8sj0E+qu+271xMmKPGjYbmQiLNnV94mrlCXj7lJ9Tdu2/WjqdxAGKWRTlUyEncSIZaNxcLdUM4W263gb+OQHNKIfwSV/TIVDgomfhDak8Cyh4MARcnC/SpoC3Z6hLdd6s++WGY1FYYa3bgGJq4AY8N7/pkCqGlKKFFZHJxxAtV6O5SIoib7wdQRyVJT/S4wredfzzhvhRTrAksl81JsEXrKNuonro1RhvdXQBZg3BZBa6Qc9EvxEG+VPyhDEqC6PM9FX7EA10T3+1B+ja+78tEADVFdL6/Q9gnUvGfqcKFTSD4DNW1LVjp2gm3ufegb2cT+CDbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlPyCXom3Off8BJElOB0YTAVb2U9SDdcgGanU9l6oyA=;
 b=gf0xDECuXFkMQa1/kWzuvSBj4PDVyqUeZtCW6vHYw2/7FdadFDHl1CGdaGD9hecGxO+VY0FjY0/Mrm/OSRaH/B2V6BpRyZnBcysJ+goqIJXwvC3Cx/kSRbpXaOA21J3/omQFANq01gSX0p0zd6XBA8/DgzA0l6YrHFaiRKuYjRE=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 30 Jul
 2025 21:49:04 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::46) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:49:04 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:49:01 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 06/16] cxl/core: Enable CXL.mem isolation
Date: Wed, 30 Jul 2025 16:47:08 -0500
Message-ID: <20250730214718.10679-7-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feddaf5-7ad9-4bbf-561c-08ddcfb2e723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V8mwczq6Z+FG8OOgSGgqQJ1iBle6bqfguVvb1QDi2WMV8FrNv9EuyjeQUvjV?=
 =?us-ascii?Q?Tcel7VRUD5nONju6O8r10wBBEt8Tt2L73LO/B115SbDnS3mQLjpt4ethZFY3?=
 =?us-ascii?Q?96RyzEEsVY5T+dozNqTykvshdtPJhX3hXQWnmqXxn3pWE6nas0lBRJCbnkVI?=
 =?us-ascii?Q?tNQfPgJYDcQyALY7owU0hXRetqvfvd+Ya+ivnZtO9GM0IFlxQJPLoiNHL1tW?=
 =?us-ascii?Q?SZoiaLM+xiEQ9wnTWCs1XBUUnH0Wn3EcoNnvKdVFzUbq4pbpvnrj1m5BZgom?=
 =?us-ascii?Q?KjPLzXK5zwT0PM0rBZIPfa7mm0C3ef73ucC4aeq8Xk81W7zHhWm1MPr8Te7I?=
 =?us-ascii?Q?qgClj2/WuAQLAlFcK02O/3tNQ0LLZVZ1UPWxzXTQiWljU/bax6SPSiKWjbDz?=
 =?us-ascii?Q?oiMTsGI9+RjW4rX/jC+P6SlTulMd59+y67WdyoyvqJYfsj4D8CsBCDmiUJOn?=
 =?us-ascii?Q?K5I7LeKtFScwlDaBKCx939ieoaL06wWyWLtND2tFB/kzQZkR388Fu98Uka9u?=
 =?us-ascii?Q?GI1IUOL2p087o7MzwU1kZtjfTwLSDWnPYdsZ9u/Qn6WMzuIw4nP3KkDjLJm9?=
 =?us-ascii?Q?m/6GhnaSHWDYBH/SfHrkmKUb6zH//r6YXGh0RlKziDjDvWeFT97XT9MxOiug?=
 =?us-ascii?Q?gV/ghg+xpYmJJrObqhq4E53/8Hdr16RGAVdTi1QRYYGOeHOOqomUFhLApW9B?=
 =?us-ascii?Q?fXDdj05H1ehTdPxBHg8vaRQO08qrh+33R49fMnc4eklia+EP4StkA/MAYUyc?=
 =?us-ascii?Q?wBRh7WLTKVHOTE4m7SyZidRpgXoLxmsG5v/ayVno86UwHl5cgc75SYh8TaMK?=
 =?us-ascii?Q?CaGo8TMspkD0YGo177piD95N24x6B7aHYzeaba05hRrLBR8HXzP6wbo08IYE?=
 =?us-ascii?Q?+JoXQEqxM7rluMNdQu79Nxo0aXiZmGRip2g7B1i2oNp0KphHPTLfZjXtDjYR?=
 =?us-ascii?Q?RCFWRkThn3Lq31Kp91MO7XyRp8Uieswlcmxg1jdoRNM3lyn6noZayp0EUcY6?=
 =?us-ascii?Q?/1ImSHqt5QTxXNaFoMC8WUU4VzQS9JqmOrPM1HyPclb90oYyaETTO0bGZuSl?=
 =?us-ascii?Q?gRb/Ebh1pzU6ceAtNZ1aLDati025tiUETrnAb4JYws1VFh4dCTc25Q/B4e24?=
 =?us-ascii?Q?4ydDszl1FSmPzmAMtSjUnYOXst1Y9fBw5XbdkpUXwwiO+cRT981vX69Y5KYm?=
 =?us-ascii?Q?3+aw4vJDrZpmYM97MFdMo4DxtcufnKsKRvWszm9kLTosGVuk2MiiNtW0n+/q?=
 =?us-ascii?Q?+NQtRB2ZUVSzJgU5SQjRvWti4QaX4oeB99RZbM9Zh7dT0PPjCI3+Av25CBfv?=
 =?us-ascii?Q?aCk9/SWgkeFf1vI3E4A72I6Ek/rBpDuNRF/sRJcWVBEiofMxEXhSi4sLnPXc?=
 =?us-ascii?Q?4VEQuYfw/viJsLqy4O3838F5lpusa49pzR3Umc/soYjjAYfsydLd4s0h9AdW?=
 =?us-ascii?Q?F11EQtOfYCSm7LyVtbXTsfEoAd2t4p6ppPJnhsc9jsSjOB4+fPhVGnENqCTB?=
 =?us-ascii?Q?bdsAFtl2k//4f38E8KJEczkkHjrKxCVi8Ce9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:49:04.5038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feddaf5-7ad9-4bbf-561c-08ddcfb2e723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Enable CXL.mem isolation during set up of CXL-capable PCIe Root Ports
that have the capability. This capability is optional, so failure to
enable isolation is not an error that should fail probe.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c  | 45 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c | 36 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  5 +++++
 include/cxl/isolation.h | 10 +++++++++
 4 files changed, 96 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3106ed6b5f49..c4d8d9690214 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/isolation.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1170,3 +1171,47 @@ int cxl_port_update_total_dports(struct cxl_port *port)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
+
+void cxl_enable_isolation(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl |= CXL_ISOLATION_CTRL_MEM_ISO_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Enabled CXL.mem isolation\n");
+}
+
+static int cxl_dport_wait_for_rp_busy(void __iomem *reg)
+{
+	u32 status;
+	int i = 4;
+
+	do {
+		status = readl(reg + CXL_ISOLATION_STATUS_OFFSET);
+		if (!(status & CXL_ISOLATION_STAT_RP_BUSY))
+			return 0;
+
+		msleep(500);
+	} while (--i);
+
+	return -ETIMEDOUT;
+}
+
+int cxl_disable_isolation(struct cxl_dport *dport)
+{
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_dport_wait_for_rp_busy(dport->regs.isolation);
+	if (rc)
+		return rc;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl &= CXL_ISOLATION_CTRL_MEM_ISO_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Disabled CXL.mem isolation\n");
+	return 0;
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 48f632aa3c7e..71e954ebc5aa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/node.h>
+#include <cxl/isolation.h>
 #include <cxl/einj.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -1173,6 +1174,35 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+/**
+ * cxl_dport_enable_isolation - Enable CXL Isolation for a CXL dport. This is
+ * an optional capability only supported by PCIe Root Ports.
+ *
+ * @dport: CXL-capable PCIe Root Port
+ *
+ * Returns 0 if capability unsupported, or when enabled.
+ */
+static int cxl_dport_enable_isolation(struct cxl_dport *dport)
+{
+	u32 cap;
+	int rc;
+
+	if (!dport->reg_map.component_map.isolation.valid)
+		return 0;
+
+	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
+	if (rc)
+		return rc;
+
+	cap = readl(dport->regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
+	if (!(cap & CXL_ISOLATION_CAP_MEM_ISO_SUPP))
+		return 0;
+
+	cxl_enable_isolation(dport);
+	return 0;
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1235,6 +1265,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
+	if (IS_ENABLED(CONFIG_CXL_ISOLATION)) {
+		rc = cxl_dport_enable_isolation(dport);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fdd7c4e024a6..999ffa05b68f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -139,6 +139,11 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_ISOLATION_CAP_MEM_ISO_SUPP BIT(16)
 #define   CXL_ISOLATION_CAP_INTR_SUPP BIT(26)
 #define   CXL_ISOLATION_CAP_INTR_MASK GENMASK(31, 27)
+#define CXL_ISOLATION_CTRL_OFFSET 0x8
+#define   CXL_ISOLATION_CTRL_MEM_ISO_ENABLE BIT(16)
+#define CXL_ISOLATION_STATUS_OFFSET 0xC
+#define   CXL_ISOLATION_STAT_MEM_ISO BIT(8)
+#define   CXL_ISOLATION_STAT_RP_BUSY BIT(14)
 #define CXL_ISOLATION_CAPABILITY_LENGTH 0x10
 
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index 20a3a8942b2c..429501a655dd 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -14,6 +14,16 @@ struct cxl_isolation_info {
 	int irq;
 };
 
+struct cxl_dport;
+#if IS_ENABLED(CONFIG_CXL_BUS)
+void cxl_enable_isolation(struct cxl_dport *dport);
+int cxl_disable_isolation(struct cxl_dport *dport);
+#else /* !CONFIG_CXL_BUS */
+static inline void cxl_enable_isolation(struct cxl_dport *dport) {}
+static inline int cxl_disable_isolation(struct cxl_dport *dport)
+{ return -ENXIO; }
+#endif /* !CONFIG_CXL_BUS */
+
 #ifdef CONFIG_CXL_ISOLATION
 struct cxl_isolation_info *
 pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev);
-- 
2.34.1


