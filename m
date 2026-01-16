Return-Path: <linux-pci+bounces-45003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B08D29A93
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BC0E302CDC9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFA33506C;
	Fri, 16 Jan 2026 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rk33jQYE"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB58335541;
	Fri, 16 Jan 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527743; cv=fail; b=EsigenuPEDAaqOuMqxHGF6omG4zLYhX96fJDm6TDqSKF3MoUwOSZh7ogfHX5UQtTNCXTUKzvAMb7SHflYXFX4GpEyPwtQxpHOj3vyMNKfi+Htdy5OnugeAxxYDYgjhlCJT1gx+RTeTVBqSkmj53gAv8EXindf7yXCPE/wpXmU2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527743; c=relaxed/simple;
	bh=wPKU0gDWHEfrXqi1DhF9ajlyLDXfVhTR+D3S4gnYROQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZc0tK1gLVWUy7kL3zrBOUqRXYq2sUzZ72bkx+163/u24w8UKFjyR7jcHQh2bQksMDEWwDLeGtQdYiirJaNmqPko8rgYQ5jZQLQ2+qfF5jfBJ8i9WLr0qg1ZW5+ARYw3jJydjn2wg24r7jDw9wtcfwnAd8nNZlNrjiIPuDXSais=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rk33jQYE; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6aP0lgKemCRmp+Ap7+FDiKoIhqZ2GXN0qy+c2ukWYv30kH9cWM1LLwbcyBccurpTGxjG29SdcmJofdy6Of0k/AeQHAQFYbMyKXp8weDhaRhNwDCXasMB/TA5l9P45UKczlaObYrOdYIfwYhF9muItLxRbEOfdhEyNlwyPptcTWR3lyyabaYOKRnju9VcMhwZzA0w+1fmUF5edr+SOo+9qjsPsbafacq1SPThUoQI9V0Jbepwg1ztzaf3BwRe9tDrElNrHIwjix7XTYoW014nHcZj5kEKhcok9IE5SZA6E7LA7PzObIPbpMKaOBjJ8uh1VVDQ9+j+tVM3p2sNc55rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGdVkX6GvyNV7mpHPmj+n0h6llj4oDVqr5FeqAg/yw4=;
 b=LTxdXilSxWn4b63sFSnj2OxtdzAFctpJHlcK/m1vV2R+TZvodXzPA948GzY15fAmCpjxxAjd+mDR7caZ/owEyR+UpjGfSgGZr+HhQqCJCuHkRwgIIv4loYRruT3f6jfrfCFxWj5KjaVC6iUtJodXTQhCfx0yzK9GH/qD0tuImlwLuu8mXMPI8qOwFIUUl/ggEEoTQFT1TqwyupSwZ1jqldkG2bwaNcaN92DC6F4HApf/vq0qmbCg9ckMPEpdtPOmsS3zgwZ/0so+ByhbwvOzt4dggH8Ze7eurregcD3ZwDffeWVCW4kYALJ7Tak4ttSjw2KZHn47iUEz6L4ESlBlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGdVkX6GvyNV7mpHPmj+n0h6llj4oDVqr5FeqAg/yw4=;
 b=rk33jQYEJQHKUC4f8Xc9P0CJQ8M5OWjOR9dnqUDnL810miZO4W2c2Tn9+qfGgs4xxE8RTLHt+a7le76yvZoNFCLOYOGZCV++5n+HEs9W0IPB4tju8qmRIZTMg6+6b42NRq76LMVtNbKrAJ+f7/L2aR/BSTA/7Vf5/20F2BEn+rBL4PVejuQyOJmVsTwY/UrMyEhlFSdDE+1vW4OtpUgMP6g9d2GMfirtflwL2hqidY3xcsn7XzmtdsKdPa1Qxk+HTwIGtTe7t+5YXzbRGxBsXIjaEfWxP1n2mXIS2KKLuvceK0MExaqjB72pWaLy6vsfkerNu4OXLibGIF7MPTELCA==
Received: from MN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:530::27)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::989) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 01:42:07 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::68) by MN0PR02CA0013.outlook.office365.com
 (2603:10b6:208:530::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:52 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:41:51 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 1/10] cxl: move DVSEC defines to cxl pci header
Date: Fri, 16 Jan 2026 01:41:37 +0000
Message-ID: <20260116014146.2149236-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: f188f8c9-f89c-4311-c457-08de54a07531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iTPj5gibwRbl9W+vTjeK1AdAFeNi1ZqKIpneeAlobKMbPd/o4domXTNAi1d?=
 =?us-ascii?Q?FzasSVl8ymzmFuxETZTmkejVMWJ4pTdombCjxID4Bu4/ceb16H2tOb6kjCHO?=
 =?us-ascii?Q?+STazcujTT5LMkN/r5jq3uxHthmRBc6OOG5TcdI25z63ThHeM/45oWbPeaEQ?=
 =?us-ascii?Q?a6IFwJDyZIqC5Sjj00GiXpvYvyt5zjz7r9MHC2nLAjNioExJW6K6w/1sv/kn?=
 =?us-ascii?Q?3tiaLtdK+/vA37s2K0lFAp2bX9O4Eisd6QNDbIR5sVtcbmKO3a5WwPUqFI0G?=
 =?us-ascii?Q?JijIoWULoAmp6RgnbXW8sfvouvUMh+1ZJ5xbOP2gW9Qnik/Rxa00kBzQjneS?=
 =?us-ascii?Q?HRWAPsZmLQqbhRfWbyc3UmIB3NQUKVm9rN0Pt4JkCCmZmY2FQd2yZ2yuZUnJ?=
 =?us-ascii?Q?i2RBPdBg10/NeWMsxAIUglwjHWD10gPzueBSXIdTW3ZBmc3aN+jLuOg7dnJZ?=
 =?us-ascii?Q?45vIejyWYLJanqD/BN8TjxEjXOihpr5qtRf+9C42dW+DjHslaZKJUU+XUZLW?=
 =?us-ascii?Q?a1FnSqYA4hNrcoyisGSgv6PKDrhMKNUufk9hHnJpEV3vmkWhiNRGbe135wRx?=
 =?us-ascii?Q?M08deY1ciH9br0uOfVXrh1LirfMSsROK7yrwg1dPJcSQpVknbvSXwbAKkfOK?=
 =?us-ascii?Q?3e/6qWJ7PbU3njpjDP23Sn+HWavtdjXPsm4VO9jc9wNkb6pry9Wkyj9vtit9?=
 =?us-ascii?Q?1dB5ShmfjuA1sKC6gnFBfxPlrvVlq04D8sd7dgfTwyehiQMrioCfk6LPfoic?=
 =?us-ascii?Q?AdVJgJIA3SkX1Wu0hguL/D3hFnZ0ugHOMnPsdXweYTfhF94uJ59gPAS2hYRP?=
 =?us-ascii?Q?AXoJzHy1nWnRRUAfIq+QnAPiOBffftUS7MNaSTrMCwjwSpZsY8XVXQalgtZn?=
 =?us-ascii?Q?mQygLz5N9qelvIJCzVx0x8A/4ShKwn7NMD18fbpztxn+pYiz28MUgTmVxUBL?=
 =?us-ascii?Q?9/IInE+XW0LPsIm0/ffAwvvPw1a2skkkGlrqbrE7dEr36WNrSVbMITmuQBBi?=
 =?us-ascii?Q?eN+8uAyU5qSgB+RvFT9qmrJaYgqlnJSilP+h1ivKy02LEUcTGFO0IgXMFOmR?=
 =?us-ascii?Q?VevDb0VhgUq1kYWsC+fwXw4woRkR5FR0IdzwK7KqFsFuhVlB3ybxi7yPO5ef?=
 =?us-ascii?Q?SlFqF0IoOdSef7MROMeILR2Vf9+l65UckkvipgeZBEbUujtfuF0Mf2PXg6iB?=
 =?us-ascii?Q?rUM7VsfYiwoO52zgJMVSTN1hqhCH8MhgmhWv2uWocxM6mmPJkDCYpxyajUbJ?=
 =?us-ascii?Q?a4T9ZEK4YQOcluF3uqYtaSgrWJ3/3auXbfOB985QmHhV9xRghFlnTpCV2XKK?=
 =?us-ascii?Q?4Oq5GkpR51zqDRsidoUVOnEbRQQq61DakcavElAuv/V02uIgvOOIEb6MJ8n5?=
 =?us-ascii?Q?3qCbB4xrgtlaGzCQiRyGKT+ythaZ/FQIx0PI1upH4mDbwA/Zwd+bMa+BS1WU?=
 =?us-ascii?Q?ldzRggCDHJQmAC9b4dyeg6SRvkPlTIGNYYjFWDkeJa+DsFSNaBYnl+G0pfa3?=
 =?us-ascii?Q?J8Zq/sm8nwgDF4ohUj1wYIc8hqFpDfLlSuQ/u46ubObeXLRBC7KuZVMXaOzw?=
 =?us-ascii?Q?oqP7iMndJjM8lNtLShFb6SIDjpVjV6H/+s2ayYmPRIHmEQAKtshDeaGgHcKW?=
 =?us-ascii?Q?IspodiTLemoI+v4h5K1Ha3rjIlMYX17yuf2nX1Bi2xFpiLYIA81cq0pFhPOF?=
 =?us-ascii?Q?BovICxwDRCyl5xyqpFWHGAtkAfo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:06.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f188f8c9-f89c-4311-c457-08de54a07531
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D

From: Srirangan Madhavan <smadhavan@nvidia.com>

CXL DVSEC definitions are shared across PCI core and CXL drivers, so
move the register macros into the common CXL PCI header. This keeps
the DVSEC surface in one place and avoids duplication as the reset and
config helpers build on these offsets and bitfields.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c  |  1 +
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxlpci.h    | 53 -----------------------------------
 drivers/cxl/pci.c       |  1 +
 include/cxl/pci.h       | 62 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 53 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b023a0178a4..968babcc09a2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..ecdb22ae6952 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 1d526bea8431..cdb7cf3dbcb4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0be4e508affe..afcdf6c56065 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/mailbox.h>
+#include <cxl/pci.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..728ba0cdd289
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification. Names are taken straight from the specification with "CXL" and
+ * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
+ */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#define CXL_DVSEC_RANGE_MAX		2
+
+/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP					2
+
+/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT_EXTENSIONS				3
+#define   CXL_DVSEC_PORT_CTL		0xC
+#define     CXL_DVSEC_UNMASK_SBR		BIT(0)
+
+/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
+
+/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF					5
+
+/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+
+/* CXL 2.0 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR					8
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
+#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
+#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
+
+#endif
-- 
2.34.1


