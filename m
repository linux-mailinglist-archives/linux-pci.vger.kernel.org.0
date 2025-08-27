Return-Path: <linux-pci+bounces-34833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B1B3772E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4787C14B2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E021884B;
	Wed, 27 Aug 2025 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hYfli6q0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5F35966;
	Wed, 27 Aug 2025 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258732; cv=fail; b=aamSJMf0dPheUpZD9PFxUJuf7uU5543U1wuqXUuKp2Kj2sFCpmuT6EQmJ8FYjDpC33vv3AjyZLUMu1gVOPrkiT+gnQvM2HHPZR8G7wVN+5MpLKoub129l0GywzVz3fXKKQ1WtdHayFADoWxn23K5OFZN7/wurl9Zfr5ZddRhLBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258732; c=relaxed/simple;
	bh=oTpzOXotEDVYUmxL5DVF6Nc55/Hx392X0GcVo3N6K6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC8CX7xtPf3wSut7bN5AWn2lQcDAcBPADFT8lQGscjd/W35OPrOnHQebOMQaLFfHcLYjYGV6tBWvW1+r82cQ7wqZe4J4NwWu0nS/4JRKPfzZ9ISSmn5Ou/8QiGVbaIrMEur9UtJ7+bmNhuCHKnbod0ZPB58/MvoENKn7SVyyufw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hYfli6q0; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPbFFbVfocoOlX70m82BDUPwt8cwQNZNTdCf/+x10KZ8rL5OxWQBX6JFbwKaeAkfa6nzoSz0bMbCCg+wsX3RsdhF3IAgkRubRvK6yGh7g5c4GVfwhDbhs/dNP519WsSys6JTLpacL6VIBF6H1MnRO4lsQVkDS+iEIC0qOsaiQk10nAFjETZq6WNJqyje694poaOvIQu8VNpNO5pW1fniCT0eJgxnn9uF1GN2wF22A33x4hGV2FLvb8zqT/awrm8rMXKr6QJ2QLa8l/TuqT99bZE0EfBtvhT+VQIlT2K/vea7BkM5clcu7SJxWwm3coJSUmfOqI2x3jcon7V3OtZU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaJeFQMLfDQhw3ad6aq7HOrXACgMzfUbAr1ksKdakKc=;
 b=wRqbLB/dR5E99Z7izu0pcC/9vEPYlM9IYxZE5l+wP2q4KLS45y6yGb87ghoEz3TsbE9PLoS+OJK48ER3EVu0aK1FqYzbCOPFDi+Hh0hPbg7gYoIv+UN31zWKwIOIgLQV/vv/DrD/I3wdXmw+ATWMErQoaN5lGvPBmXAep9g+dSvarCQ0kMeUY+W7HtSyvuL8pWvRF3wRv5w43nQwUmW3SDDtisf8cWKE5GW1xfRxEmQl2gm0cBY0fcxYIL+S10hXC6L1+41d9YxvolBGnkZNLSC23Hn28MvfXIJYbx7CXGGHITf3ChXxVz1nET0dph+xPe94rqq6X3llkWvx41mXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaJeFQMLfDQhw3ad6aq7HOrXACgMzfUbAr1ksKdakKc=;
 b=hYfli6q0vP3ZLUuDU2EDFl8JOybVMqh7RLseL1I73Z2QE+Oq9S/P/fNaoOkgkKabjQuhF1uFHWEsjcGkK36BwzTFG9tcnKVajOn6Pjoe2xVQ5PcgyXpoqnw/Wo3B0pG+sX4JUOLmi2BAgTmJQ2jl3UGQMkq03D1zV6QVRoPwoIw=
Received: from SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:38:44 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::80) by SJ0PR13CA0042.outlook.office365.com
 (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Wed,
 27 Aug 2025 01:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:38:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:38:42 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 16/23] cxl/pci: Introduce CXL Endpoint protocol error handlers
Date: Tue, 26 Aug 2025 20:35:31 -0500
Message-ID: <20250827013539.903682-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: a03c4ef5-c4e5-41dd-9b14-08dde50a758c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzClmTwQE3OuFjCj+WVPU/4AOlvtt2OZWbVtADX91kLl8RcQNpM4vPd6Xihs?=
 =?us-ascii?Q?gSrPqFFz7SQowhiAWxpIxLRIGl4BQearGCKW4LL4pRjzj3jqscvS6JDnEI3A?=
 =?us-ascii?Q?CYJUlWGOPZHGNpLvGOiVORJbuZ0VzM1JXb9776ZVAtdWJamrwhFy3jVtgqCb?=
 =?us-ascii?Q?ItPCzejf+GqH6bt1d5Ydv4G6JHWenGSBtKHLj2LzklKyWIZOUDiOqkl+qHGp?=
 =?us-ascii?Q?f9A8TyrndJSEF8OH+v93LTK6wQKahAlnmciaumotmcKdmvID+ScOT67M6R2I?=
 =?us-ascii?Q?sz2ComZ4WMkSVXLHSsYWxhdVbRWDko/y/0lWQydkwsA+p3Z9LSOvuiMsNZA1?=
 =?us-ascii?Q?Zr59is2348ZM1mjMqTo8H4TQfKhePu0NU3Tt4OonZu/89eW+ejzpSAp8Z4Cg?=
 =?us-ascii?Q?PDDZYdaMIIxCaqOmnDFJYxDZmghO6TlkUuhCKE21qYzyL2j54N6CAL1y0uBq?=
 =?us-ascii?Q?CpDvhmPD04nKI9NbHUPqlqStNbkmpvoYLyujj/eLUOENftiiKtlI46Z1OBez?=
 =?us-ascii?Q?Gsa6gbc5FvVKgUR8ZGKKaZZACX/OMExGLvOXH/5AXqEjJYVQLYBaiWUmrNXT?=
 =?us-ascii?Q?QS6rzwWnLgMi4Wwo/bz8u9PRkNuJ+bvKj7XvM+U106SlUg2iLWV9OYOGBy9Y?=
 =?us-ascii?Q?exq6jdqZZAm7aqyRYkb/QxFCWKAAQb4rULzNr+FV3ehBkavTGuWbj1UyR6hC?=
 =?us-ascii?Q?nvreoY4Cj4bia4AM0V7aT5cEHNhKkNzVJesvXSl66R1vtBBShBRiTzlwhNnH?=
 =?us-ascii?Q?mO1bxNxZF1mkditXVs3XDDwIr8KulwWZU6TjJ0IG4GpxqVhL4mWu656RZy6l?=
 =?us-ascii?Q?9DpxYiq3LkN+wECvR+DYLDkqll4Wlu2J6mKBlXxSHjD6WU+4WLD02aRu9U0c?=
 =?us-ascii?Q?SkT5y6FUjYxqnFjgeSno3qnOVxrHBeCuBMTjacFC/g6P6JRVbInur/YXmLd3?=
 =?us-ascii?Q?FQNPzpO7YnJKy/BRHDoSnyxvxknzSZVB0DFqrnQkp72/RUKLE4c3pZDHc/Ti?=
 =?us-ascii?Q?oQMlbxKjdEy8yEKg0DuLbCPXDV83zRRbUG4onNsjmKy6rCaJ8A5SReNHIM47?=
 =?us-ascii?Q?UZtUgZPqGFTweDc+UoR65mNgHrczhO2py0Sy/PPsP3IlkUZj5RYCXL5eyve/?=
 =?us-ascii?Q?+AJPWe84gRLNrtMacJuyjgNDoAj3pGu+MhR9ZuqHvWZp9dy/eDySide9c9yi?=
 =?us-ascii?Q?4gdWZI5gW+arvl5p6xks5Qr5kEHJHcMTPRc0yKAA7m9Q4QbIVvPyHoMFvoVG?=
 =?us-ascii?Q?b268ArBBPNcTvrlejp9y+/Rhm+bWJfFRM9GmPx7+6RWyLPYwf+wjZTzvEgvv?=
 =?us-ascii?Q?0cvir/wEXyr4OQ1Yn3sNxne3+1yv5N29W8WG6n4JVRWxhgchHhY3u8zyMFBU?=
 =?us-ascii?Q?MsIwo9NBTApnpiiukUvWw3tqf3eMQFrrAFv49QBdE4Wth4ZV1b97vz/WMnM/?=
 =?us-ascii?Q?/tPQVUoSzImXnQucPMbNbYPblzE3JGWv6NmVqSFn8u3Q1+FA6TQAQKKYzelm?=
 =?us-ascii?Q?TFZ2madNhBwOCBZfsIXTgqWzBvbDZYdJtdKp0TybirTk1kUQIPijT+X1vA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:38:43.9718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03c4ef5-c4e5-41dd-9b14-08dde50a758c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

CXL Endpoint protocol errors are currently handled using PCI error
handlers. The CXL Endpoint requires CXL specific handling in the case of
uncorrectable error (UCE) handling not provided by the PCI handlers.

Add CXL specific handlers for CXL Endpoints. Rename the existing
cxl_error_handlers to be pci_error_handlers to more correctly indicate
the error type and follow naming consistency.

The PCI handlers will be called if the CXL device is not trained for
alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
CXL UCE handlers.

The existing EP UCE handler includes checks for various results. These are
no longer needed because CXL UCE recovery will not be attempted. Implement
cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
CXL UCE handler is called by cxl_do_recovery() that acts on the return
value. In the case of the PCI handler path, call panic() if the result is
PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/core/core.h |  17 +++++++
 drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
 drivers/cxl/cxlpci.h    |  15 ------
 drivers/cxl/pci.c       |   9 ++--
 include/linux/pci.h     |   3 ++
 5 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2fa76a913264..6e3e7f2e0e2d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -149,6 +150,11 @@ void cxl_ras_exit(void);
 void cxl_switch_port_init_ras(struct cxl_port *port);
 void cxl_endpoint_port_init_ras(struct cxl_port *ep);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error);
+void pci_cor_error_detected(struct pci_dev *pdev);
+void cxl_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -162,6 +168,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
 static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+						  pci_channel_state_t error)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
+static inline void cxl_cor_error_detected(struct device *dev) { }
+static inline pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 42b6e0b092d5..b285448c2d9c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -129,7 +129,7 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
-static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
@@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -403,76 +403,72 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
 	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
+	guard(device)(cxlmd_dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!cxlmd_dev->driver) {
+		dev_warn(&pdev->dev, "%s: memdev disabled, abort error handling", dev_name(dev));
+		return;
 	}
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
 {
+	cxl_cor_error_detected(&pdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	guard(device)(cxlmd_dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
-	}
-
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
+	if (!dev->driver) {
 		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
+			 "%s: memdev disabled, abort error handling\n",
 			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	pci_ers_result_t rc;
+
+	rc = cxl_error_detected(&pdev->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index a6da0abfa506..ccf0ca36bc00 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,19 +79,4 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
-
-#ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
-#else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
-{
-	return PCI_ERS_RESULT_NONE;
-}
-#endif
-
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd95be1f3d5c..6803c2fb906b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -16,6 +16,7 @@
 #include "cxlpci.h"
 #include "cxl.h"
 #include "pmu.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl pci
@@ -1112,11 +1113,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected = pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1124,7 +1125,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 79878243b681..3dcab36c437f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -868,6 +868,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.51.0.rc2.21.ge5ab6b3e5a


