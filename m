Return-Path: <linux-pci+bounces-40242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4EC323DB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6B61894995
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19352338F26;
	Tue,  4 Nov 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdG7L38u"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A68337BA4;
	Tue,  4 Nov 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275916; cv=fail; b=BCxQSQP7s0+35X40iroF0jOG0d25LnAb5wsaj/9qRPlE22P5CVtri9+eqUQNpVMmCMA9IACjfIvMXWbFy5AWDSFjPFfukqc5PdK08XR3pNWkcXN1NtFVJMk83yq97ipzzh07ef4a9H1g2fcCcz1beilqcyyndyshi2hlhSRZRRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275916; c=relaxed/simple;
	bh=DI1ql1FTb+fWeuvGT50ltJcAMdBGnnsj7UYribF+QXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdAIy1/4xVY6pVeTygAA1w/0UE6ZzF891Y+rTuyO3ye62furEKfQl9+BnXVrWeTA6KwhgRAtFprV/gR49de1FZaYjTR+jl7DBO790sAGpnP5LiuL1UFNM87Xi2MS3w9EgBf9zgajN8fo6oxb0YG8NW4LVE7UlKI96z8UxRmqpIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdG7L38u; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxdM0BVgemA4Lhi2wchaLnc4LLLyQRJ2+CzFf0lz7tKaHWwNgNlstsOzlhCnS6CuPiiKJxg5M3lctwx3cQvxZOK1QlDJdJLaV7z5ry1q+80zofqfDBVVYXf3B4cin1OmX7nPEzVzp/jr/nq1mdJycw/5aLsmA3ZYzRMll9o9iBSnC+6TSF9mxOwQ37BBpzFbl6VKTRYo8+tA3TEylP2alfwG7ZQyMqb2QGigigrPJoN2G8lm787fKDb3Wj6lvMyOK/iGdwLKrcWWmljBruE4mwoqN8+vcilrTUcHKJZSuRADsAmvfP5ckmTcLHZbMGnIihsJKhEbCvc+hUoLGBav6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd2krjXdlLHo2GJs8ggVn3OcMNU4jcNukXzFx+slKdY=;
 b=lX7ZlpR07iiIARU0hbb9eMGloOJmWTA7dum7PiDFc61SDsfUccAas8jGbcX0ueZIp7GJjBeSwCoLeBWJQJNmTO6OKvLCQZeyKIhqDQ9+nlMBd6NePAiIU/c1NaJviJFjCbrlQAcOHrMOo7AOJy7mcdQtuQbG4r5g6keZSv4v5p4IDyipsAmD00swSKnksbdjGTU2sCiu7smxlHTbSJPmc3McYOla06Vny5e9H9BQ5WwnJjLCM7Bm1xZZ5j8lL8H/Xxq7ksxC+8yHb7vAt+cxbuPcB1xmHj7krGdM/OdaaXJrTj/uJFdw1GxONXKQE6HMUJgRvEE0/Ud3LLcngtMDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd2krjXdlLHo2GJs8ggVn3OcMNU4jcNukXzFx+slKdY=;
 b=IdG7L38uKM91sGCx2csB7QPcOAvuraC/mOrXHPuin2FZSoLRjBNTmvfn8JR0Gn7ZGWiHPK+GcCYXGPQjEh1mS6I0ENxRwyxdMIwYGFBDW6W6TopmJTLIn8ROoDZX5Zj1TbNE85tQ8ipXt3R/5VP/GMlCINWaHKT0quhoVWTMiQo=
Received: from BN9PR03CA0701.namprd03.prod.outlook.com (2603:10b6:408:ef::16)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:05:09 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::1c) by BN9PR03CA0701.outlook.office365.com
 (2603:10b6:408:ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:02 -0800
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
Subject: [RESEND v13 10/25] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Tue, 4 Nov 2025 11:02:50 -0600
Message-ID: <20251104170305.4163840-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6a2ac2-beb8-4c05-135e-08de1bc44f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OqqnBM0VvSKl8GqJXjqlt8daraK7aQNOsPmHCb1ftqRg9ICCThHiDrBOVGT7?=
 =?us-ascii?Q?Q2or7kQGYbbwkxtwb8hyCY+SHHfqCmq7Kdu3c2JiZuZX2x2oGFik/i5HXNyO?=
 =?us-ascii?Q?nJkDL40RH5whaplvAYedEk3DJcM0wpjKqPgQO1KCC6utXWCdQSaetmp1HWHR?=
 =?us-ascii?Q?Pi83GLJDPNePOIuQygEUU7JRqEDkQqG6zeHRGcJLk5fpGpozzp7K+YQRDUQQ?=
 =?us-ascii?Q?mZKp2rWrN+giA7fynASfq21QmlBdeDJ+6cjBNfEQ3Xu0qqbUXCY30Qjm6ef9?=
 =?us-ascii?Q?qHVE/w3Dk1yI0Frg9/lVkqdxfasNu57mulG1uqRSZ/Mwo4tNPVJiGp3Jt4Wr?=
 =?us-ascii?Q?m2T3emNnV7sW4BHeGDBufzo1du3ADDWcpxzS+ZN1nuB1hTaBUkc+01KeuMPP?=
 =?us-ascii?Q?Q8h9dAYMIyXwXWxiXuSB5Hdtf1Ah0vSs5S0mzih/4Sedp88etyFMTgkvZTYt?=
 =?us-ascii?Q?3jOEHrrLw7X8W3nDNFFIsIZvC6YMSq8T8YYZ3Hk6cDfmsSKek0ezRhi0TKPC?=
 =?us-ascii?Q?PbqSuvcuS6ML+a+O4UfYWuxQUqqAHmZT6mjt+TR4IHD4gBsQBW7IopVnToGE?=
 =?us-ascii?Q?Bq0KGn2tOnT15wIqAIm2VieV/J+A1zUSfWkYF5oSor/vja5vnBBhs1dJfuDC?=
 =?us-ascii?Q?ThaCxReZxZOXC3ldHAo7qMUr8+VACIYVxlOS/nhNbJOaWIF6aF14ZNTBLnjj?=
 =?us-ascii?Q?IwLwcXfgp2PDCdzLRZ+6Wig5M/KoI3DwjoBkUwZ/2SpdwxluCtXo2yi1wfGE?=
 =?us-ascii?Q?kkxcnmt5UT4rkKDMUrFmU2OAe4GD7eTWQuzzJAFUOxgbzlvxUV0epj3dS8Hw?=
 =?us-ascii?Q?rPk677v405M4W+Fl+mAfFohrGAZqBFLs9tqtpFHWO9xaSF/rviOpbKPO0mKN?=
 =?us-ascii?Q?3UrXB4DWWKhC0PM57lQa8NkO8865prxXa3jMRygyqqBP2nAUz+zi4uJUOvTY?=
 =?us-ascii?Q?mG6u1u1eIV+8KMwDOTwkqog40hjpox0tX4J7YEYFjMWSiT3JzTUPSdhJ2WoJ?=
 =?us-ascii?Q?LwgFGaOKO1NT9cpEHF5S1RfrrJPXnTkWePW+Uzack0Y8JobdcYisN+3BN794?=
 =?us-ascii?Q?tsS4pf52c58tAb/W/htZ4dAxpbRsWdd933W6M+HDMLncmXMTfi9h9XvhUP7V?=
 =?us-ascii?Q?AZYQfYsA4gjgqzukWD01HkDM8ot3QPtpqG5PaeG6K2kZBTa06gFuhPY+5Mz/?=
 =?us-ascii?Q?1yDmMOj5gsSJvhmTyjyZxbVWvujTiAgU6Ir4CFQbKL8lmP4BUo9m9nfC2PaF?=
 =?us-ascii?Q?g4tjlCTH+yxhPdZOqjdy3Roe2ThFI/nfS6V6R23locnTtVg43Im/yOdzuoYS?=
 =?us-ascii?Q?VZFoq049ESQVcOpSzRMECsrqvhe8UwV6z4tWtrkERZt0EUXTpV9bIBxETK9z?=
 =?us-ascii?Q?ivWL582l4MugYuAkMtHUU2PEpMd0268F777I5pqwnZg6QFeuRuXCVhGyrFyW?=
 =?us-ascii?Q?pBAstPH52/PM4Lapa3eswPyfvI+Rt/Evu1AyrOnJH06OogBUeg8S66XiKmI9?=
 =?us-ascii?Q?nvsaP21D6JvfYYTh5ixdz8U3CeiyxC9QCpd7CX7gpbWjlSf8+QNLh5d9YEjQ?=
 =?us-ascii?Q?0iWwoTkINafRAsT7OozBNvtUuNabOYjczx3e1I04?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:09.2774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6a2ac2-beb8-4c05-135e-08de1bc44f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620

CXL PCIe Port Protocol Error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port Protocol Errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL Port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v12->v13:
- Added Ben's review-by
---
 drivers/cxl/core/core.h    | 15 ++++++---------
 drivers/cxl/core/ras.c     | 12 ++++++------
 drivers/cxl/core/ras_rch.c |  4 ++--
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c30ab7c25a92..1a419b35fa59 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -148,23 +149,19 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 #else
 static inline int cxl_ras_init(void)
 {
 	return 0;
 }
-
-static inline void cxl_ras_exit(void)
-{
-}
-
-static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static inline void cxl_ras_exit(void) { }
+static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	return false;
 }
-static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b933030b8e1e..72908f3ced77 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -160,7 +160,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -172,7 +172,7 @@ void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -197,7 +197,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -224,7 +224,7 @@ bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -246,7 +246,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -275,7 +275,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index f6de5492a8b7..4d2babe8d206 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -114,7 +114,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
-- 
2.34.1


