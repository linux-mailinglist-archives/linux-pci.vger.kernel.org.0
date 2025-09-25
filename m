Return-Path: <linux-pci+bounces-37049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E7BA1D60
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4FE1C82D36
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E70322536;
	Thu, 25 Sep 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1vXITZ5U"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD491F91D6;
	Thu, 25 Sep 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839861; cv=fail; b=NoAvBncINsVwZTLK9g+fXsKfchWu7zTbjfBNTr28MoSnqRt06IlyduBcEiOlcCMK6gMyDhU8ViGvhd2rtRXop3CAhaHj/mj3A04nccA0KpA0qRIgyWMI1nQO++dWKvYt90JXX21oYgPU9LhhFQMbqPpwq9U0hKgJ6i+qVtFEU/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839861; c=relaxed/simple;
	bh=LNHAZ38Y+/Zeqpq4oXSdeArHRAHtewuQFnHnJdmY4eI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLT+ilOAb2URpPeV8hszxanNDr24EioxXN2hZTqy7bVmHLRkcjd3ujat/i9AkUdasmNGEnsLRr+k1jGAton1ODhUcd0kccBgm8QAQdseB63AurFY5cQVxd4RpYjhPfvMJicffoQms1LN6MRjN9UZxgtXar3v7A3vOQ/Z0AI17EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1vXITZ5U; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1bKYB6mbyWO3vIF95KTg/8ZwfED7VHDLBh4h7gYJb65kytXg5Wx0TdnJCCu1pFS+7khFFYpFJi1ClnoPLUxY69k21s3+xGfT2fGrGzZYbTLA1X3ArAxLRq2UHNZqxs4L1hMH9suOJZB2hu0UUDcwToL9sIx86bVID2HYeeUGkI+FWo3F1J75Yz7zr2EggnVnI/BrqFHdtf47GkRFMU1vT2FGnICuZ/XD94uc3CU/rQYruv4RnQS0LvEZyBPC1/kRsKrXd481gh9icHHHPMcmK9Q80ehWMHMm/PUXjmnHuvQiuIieyucA223zWSJ4Nv1J8rs+Mkzq+bl2iauiB8x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nMk7l1UGfBNCDa8pbmNomdEKbIYslMWBRf2IhG/mMo=;
 b=HbxkXaxHq/2G7pcxN3tX5QAI7JF51v4mIg5P2djExc4ZebZ5pTwKlvLZT3rTKKVnXUZT7Bb/UeC4hVEt3x2ZefJaE0MSE3aXVtXvfnH83S9yJ0MPWt46auqiLDpgoIrFjbXs75hvp+WjSR9+87wSoi2gh2WvXIUQFT+Fk3K1nnhfFuRF4gxBrRJvpOr45NUurad6urAITsHGF7PnBo1S1ba/TA1zv9ZPT+5vaVj+1XiFAqDIg9IGzH1/W//Ad7KxbxstUz0prSm7GzSCwr+u7p2CBqnHStfgNQHRXL4WjWdksQJYOwzDfM1XxG/Hv1XAFUOycTwdJsxxcYaZzkSUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nMk7l1UGfBNCDa8pbmNomdEKbIYslMWBRf2IhG/mMo=;
 b=1vXITZ5U7tTBg1bCADR7U/tCQK+XNeUyKZhujRG06LgWJjzrrNT2KYLcP+IL8igZYqCjPbExMK4UzdootgwbSS2CigItbGCh2++2gqzlgSjg3ulUwpnRPTfo6iFQDb8nlE+c/aE/PdfVHB4vXdw8B5QMChbX4r1KRDZuEyIHuRs=
Received: from BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 22:37:35 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::cf) by BY5PR17CA0036.outlook.office365.com
 (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:37:32 -0700
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
Subject: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Thu, 25 Sep 2025 17:34:30 -0500
Message-ID: <20250925223440.3539069-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2b3544-479d-41bf-0cd2-08ddfc841f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQe0Wx/W4smvHEOGLoNsrgeKFpOp+2oNNVGEIVPnkR4Ln2Oq1ZtsWJ51o6g6?=
 =?us-ascii?Q?m5S7mKVfif6+08CgJosGc+Gck1qs+4q0AxVcoqkAtvujIuMuYqWaaRc+wBX+?=
 =?us-ascii?Q?QHF0NfHqo31ct7u5osmnC75INIJuv8VzZ0K9n2W+QJITnI95AzmWHy2gPCwD?=
 =?us-ascii?Q?woFvvSCE69QwDc5F3PZoCrYnHGv3KYdRjXCpTZ6C0gj3PTOEO9q+AaWWD2NX?=
 =?us-ascii?Q?TwdkxmBG4gDn5A6g0nqiMIdtvtJShNd9kF5g4BYJbv6go2beHlpNNmni55nn?=
 =?us-ascii?Q?7K0STZg5QZKDG6SCYda+U3144e/18UNRkaROj+C9GdgwC/pEUb5AuLCWYpbX?=
 =?us-ascii?Q?InKV3lxzTD+fWbA0MLGaK1j5uKIx5qqf7X0Ot0RiveKeMsLYT+pkhzCyEsQF?=
 =?us-ascii?Q?BJnbmAsABWGgjHDLREEKc5aB4P+hmIW2V5LKMkUs5Hb1a5MTHSM1RqIYG2pd?=
 =?us-ascii?Q?8tXp/67aLs8JI68VUCfIResRAV+8GVGip1dSWVH4lfpzMx8KkWrGePfQHHsV?=
 =?us-ascii?Q?b55L5lG6lCcrDbHKI1D88v6HePUb+zdK0j5M7hWz1JeJlqs5vEHddXnZz+40?=
 =?us-ascii?Q?kqmmx2Y6JiBOlB9WK3RPbhebvEDHuu11n2jf8Rd1/A2UURLckDW6RxFsq64s?=
 =?us-ascii?Q?CtAySUYGnny5GT8s/rHQcTeS+Tpr4fNezg+u7X5Y0t0PKSZS6wJrUF8Gaftc?=
 =?us-ascii?Q?UoaTRR5ncgpmyMWyWNFZ4saB1RvZa1TA450Jav1mWUGbgUziM9S2m8hpG/gi?=
 =?us-ascii?Q?Y23ycetO05JI46yNsqg9mCzfMWIJ8ZGYx4dPgkZCHiWA3pCL9+uWbxHL51IB?=
 =?us-ascii?Q?x/lZb3G/Cena6FbuzhZHU3YDqlceZ+tmxh5DI8P3kTCRIcZske1y2mGj5A6K?=
 =?us-ascii?Q?uqpgFitcjbpcwNN/CSxGb7j8K6emdxZgz8Hg6KScxdUjmdrxQ1eUKEXXOclU?=
 =?us-ascii?Q?r+sbcYXh/jfemSX7ne7FKyjOkR7TKUD7HPXTsmw7YPUYRdtpLFPzwIdNg42E?=
 =?us-ascii?Q?52cdoVB0FVJpKjq18jwav3K6/cpSDtPRGT5+Lt3B9a4QUWHxGwXsFp45xV0g?=
 =?us-ascii?Q?I6opZsY+zdx5jvUctQPJ2V9PVGxCXG+8isGcG5xxFBWcv+yZIXMdeJHTADv3?=
 =?us-ascii?Q?JBnbDtyZhuzHDi1vkfkC42CnfGgZe500SrHl0hKWh4J9xdfxv/0LBTg/eOPl?=
 =?us-ascii?Q?kp9hp8SKH5MqQsTk5FCIJo7G+5lbr+qX9hIxtkqnd7mxBarZtfMqaMpUhIhN?=
 =?us-ascii?Q?mAR+Pi8X9m0ke/8TNjrSzUv9UPEVL6+ZAN5iDU1w5XpDDOYyXSo9vdOJ8gtW?=
 =?us-ascii?Q?o/F66kW1FGNRQSlYVf//LERt5hO0CFwT0CmNDbC5IbrAUjO1GcUi/S/jgCC9?=
 =?us-ascii?Q?es4qykJspBF5TfgNrWb6GCLgp9hGZCHjvWA9HAKG2RHms99CvU8gWkwmTcJ1?=
 =?us-ascii?Q?2XTpogan0KznHsLq6mgX2ePeuMBQj5YgqpJXN8wFnP3/Aku5PX2Z8+ToF2I0?=
 =?us-ascii?Q?M3OPuVfaJauAlfTwPrHZTMCSAJQaNWu+9XMHPiNL/JaGWmDXLGLwcNc46nfW?=
 =?us-ascii?Q?53zzQSJym09aE45etzR6MDClah/VwTyOD5DcjmeJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:34.9264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b3544-479d-41bf-0cd2-08ddfc841f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
mapping to enable RAS logging. This initialization is currently missing and
must be added for CXL RPs and DSPs.

Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.

Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
created and added to the EP port.

Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
Upstream Port's CXL capabilities' physical location to be used in mapping
the RAS registers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v11->v12:
- Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().

Changes in v10->v11:
- Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
- Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
- Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
  and cxl_switch_port_init_ras() (Dave Jiang)
- Port helper changes were in cxl/port.c, now in core/ras.c (Dave
Jiang)
---
 drivers/cxl/core/core.h |  7 ++++++
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/cxlpci.h    |  4 ----
 drivers/cxl/mem.c       |  4 +++-
 drivers/cxl/port.c      |  5 +++++
 7 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 9f4eb7e2feba..8c51a2631716 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
+void cxl_switch_port_init_ras(struct cxl_port *port);
+void cxl_endpoint_port_init_ras(struct cxl_port *ep);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
 static inline void cxl_ras_exit(void)
 {
 }
+static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
+static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						struct device *host) { }
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d5f71eb1ade8..bd4be046888a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
 			return rc;
 
 		port->component_reg_phys = component_reg_phys;
+		cxl_port_setup_regs(port, port->component_reg_phys);
 	} else {
 		rc = dev_set_name(dev, "root%d", port->id);
 		if (rc)
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 97a5a5c3910f..14a434bd68f0 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
+static void cxl_uport_init_ras_reporting(struct cxl_port *port,
+					 struct device *host)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	map->host = host;
+	if (cxl_map_component_regs(map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+}
+
+void cxl_switch_port_init_ras(struct cxl_port *port)
+{
+	struct cxl_dport *parent_dport = port->parent_dport;
+
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		return;
+
+	/* May have parent DSP or RP */
+	if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
+	    !parent_dport->rch) {
+		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
+
+		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
+			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
+	}
+
+	cxl_uport_init_ras_reporting(port, &port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
+
+void cxl_endpoint_port_init_ras(struct cxl_port *ep)
+{
+	struct cxl_dport *parent_dport;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &parent_dport);
+
+	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
+		dev_err(&ep->dev, "CXL port topology not found\n");
+		return;
+	}
+
+	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
+
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 259ed4b676e1..b7654d40dc9e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -599,6 +599,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -620,6 +621,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0c8b6ee7b6de..3882a089ae77 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 {
 	return PCI_ERS_RESULT_NONE;
 }
-
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..f7dc0ba8905d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl mem
@@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
+	if (dport->rch)
+		cxl_dport_init_ras_reporting(dport, dev);
 
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..2d12890b66fe 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl port
@@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
+	cxl_switch_port_init_ras(port);
+
 	return 0;
 }
 
@@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	cxl_endpoint_port_init_ras(port);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.34.1


