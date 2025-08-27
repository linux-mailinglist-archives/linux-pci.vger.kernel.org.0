Return-Path: <linux-pci+bounces-34832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E244B3772B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F7F7A6379
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83718207A20;
	Wed, 27 Aug 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0ZRAsRB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9E207E1D;
	Wed, 27 Aug 2025 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258719; cv=fail; b=fCUOpHzJpNMU+7E4JudJd/ZKQt7IzO4MuzG7F1Qj9lDWz8r7WqSezwZur0RScDVFSeCpM1esfTi2YFWJDBuPDmGGtZqlYQKL7dKMehwj17FJvBPGONG5kG++maOQiNLABZnnq6xrFRobdfufJwHo9j93qhwLRukWKLoBT9bY9Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258719; c=relaxed/simple;
	bh=cxTdMeNb+0ax6bSlLNdqvgG8cYjwu7WW/k3qZ1MFwtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsxIfI7z+RWhcUxl4vi4DKs5cRNuIFd9ta5+uLUs2N9DJ5oazlsoN/2uBagpeakvG2amo13Yk/N/sndOtOvtpLGEQGCnPLoa/uyBhk/KTDOIreKpkHrXWPT0P5OYtQwuMRI/7O9jxLNLGMT1qa4vmvlw9VCHt+Ay3PZ7IQWDrhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0ZRAsRB; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9B2IrZc1myfQ8znfe4g6E/0ozCb1rs9N43Toa6rNKzbpzFCvSicSNR7qxpCpJOKQaLmuQ0Y1YZr7wXAy17KOLHaYkEyDTi3t0r1Q6/z5EjtANRNuGsVCF3W+rUExWxKngUb4J6h+1brrEQ0LbFN64GcevbpoObdgJmfJumh7idvFxAl0VxiZH029UVetzvafeSOJnvmdw845a3yCS0BRrdxNOZuTXjTg68ImJJ1JNxtpu6sZ3LUOsUZT5zvKAs8J29pUjYhhVy2UDPRC/WpZwkB+HtLlPS4715i2FgoF0nY+cbH0eqPeF24yvg3bqpuy4qdmqZ8HZF6h/Nb1HVX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKAl1Ps0Qcz9DzzjkzlFzYTps8jPi7mDmIYw6JcOi3c=;
 b=xXgHK86mx1uLb7i2b6Wypc6PBXVGc3IHGbp6f4z/KLXqDlAPphp2srUDnBr+fGogh3qqNMomlKVYqlpbuXMTLEU53OEnok8kTCy6XQbuEEnnw3bTgJtYcH3zoeU6SAr+CImZEQ3gEXY/4LYKYEXVe27fkT5SQByls0lasZcuwxwgRmmvWzPe5AQylQLgaw3NR7D1LzL+4kn5QN0mRql5Htm1M3GmQaTp49ltklAlMCa6LbiAdO06cahMFwaIs+p/TsqV6iGqDAISO1UFkaWsx0E6hFN7BNEZ/4dvHwunAMqc1RraWAOBODDoYy02m44xHZo2TTGGxDDP+rG2PcUWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKAl1Ps0Qcz9DzzjkzlFzYTps8jPi7mDmIYw6JcOi3c=;
 b=b0ZRAsRBdEHkX7/as1oAOlmSWnuDDF07Yt2WM6N0BZrhvFDmkPQKvJ2GFSYnozCZnOjMFaPDjYdRsBzvJ1TtZGGe4oo4LAOf6+LAwz38vu1RaHz31xM1ozX6TWxz3uJ61KMAUoaVP2aARA1op4ENPRm8rQJB4sokRjuHwBKWwgM=
Received: from BY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:180::43)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:38:33 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::4f) by BY5PR13CA0030.outlook.office365.com
 (2603:10b6:a03:180::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:38:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:38:31 -0500
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
Subject: [PATCH v11 15/23] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Tue, 26 Aug 2025 20:35:30 -0500
Message-ID: <20250827013539.903682-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ebfa68-24c4-4e38-4534-08dde50a6eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWB88z+Ea6GApJJpuByRdRF6mvVCk1Yw5mOTq/34/vqpdMz0Q+FxsbnmNdK3?=
 =?us-ascii?Q?fzq6fqlmPF+O8WsCq+As6Vu1je+hF3rLGhxyJnsbbEPz+a/AgMCrFS23Rq7a?=
 =?us-ascii?Q?zo14Nklitx6vgMLVppP4LkmdRn1QCzexi5ycXuqZw65dig4C7O+UhCPURqf0?=
 =?us-ascii?Q?xLOEKn4y3qbms/mGqhkOLFD5Vh4eL3E9+4YEiQRvXUl+u2JrrPY1PBrtw04G?=
 =?us-ascii?Q?5nS+EZe2tw1IcFTxmZSI7iJ+MFKeM5Ao83Yx2lCOWdBp25fgV5Uaq05YbpBX?=
 =?us-ascii?Q?/cpr2Y1ouKFyeEWPsnC32vvWVOqjXKANI5VYbStnhfmHa3kdCYCjuYI+3yze?=
 =?us-ascii?Q?clbo8TKYbdyC+mTJ8/X6goxVc9ZWxiQz6IYqvXCEPFrvz2dI46EfNySROi4s?=
 =?us-ascii?Q?3cdFFRiZ1sufOm2AvjhKD65tbfXcLZCVrPwepD4iq2aBGe+dqfc2rHlxxLvC?=
 =?us-ascii?Q?rKBASoT68dY3kv7ia8OaF1xZEWpTp9wXQcaNZD6P3LGsU9ULtJ8JtWNpXtTf?=
 =?us-ascii?Q?85Cws8/cPSpmKKw6oc1R2deYeGHfhy4/VSxwLrXEJKwlNxY0P/oPzQ7vuG+8?=
 =?us-ascii?Q?VFLBvgDiJtjR0EKI0qvltGzrBprJzzH9I+mLfm/urnhampBVwdS6dZ1iyJY0?=
 =?us-ascii?Q?VWDvZ9FBYM5rXPLSuxl6xgJ+Zlfg70VXlSMeLut1DGsBm8Yia1F1ZnoLcZvF?=
 =?us-ascii?Q?x6p5pt1Oa2/rmG8DGtuNc4hSMs087Wg261E1Ndmx0BKg3zWwV0gFYshmvSi9?=
 =?us-ascii?Q?bheJEKDd473Qt5vHr5elfGsNqhzxH2KervVK2/qM4Xg3tqSSFjE3YdvBiCSO?=
 =?us-ascii?Q?e4pft+iaLOfPcIadG2qiJBDYLVhYJW1KJj/fuW5olJcNg1j1iDhgui/e8f+z?=
 =?us-ascii?Q?HW6bQjzyDKEVcvOlan32vmWFVFk7dQI5URaXms2DkFazMTy2t1zTqxJZ5UVd?=
 =?us-ascii?Q?KfAGDtEChUzbu7gZ/63l6rOtqPlyFcVX1SbCZ0V5QAD5Er/C2aqBHqMfpDCv?=
 =?us-ascii?Q?VwIM9gR7Akl3DMhM57bAk0Y/Z/JSsiHjL+7OdLwYfNkqNvhQIGOVhFINnQ9V?=
 =?us-ascii?Q?FTg9T5IkSnXUDv7ohDu3BifKqeNbf9JmQvDKVetYG37rMueXlqUX0yM/2Cv5?=
 =?us-ascii?Q?Uky7kaie7J/Qhqy1WpLQa5HxvakQFzRGoO/FKe4Su3g6wQLDVq+l7XQyb2wp?=
 =?us-ascii?Q?vMenW8jUoESVmRfDxpggxl0zcRR6dS5gw3/H4pQqsjeyLpAL/DnqH0EXRqD7?=
 =?us-ascii?Q?LuimHiaWdtC/+VdoDn0GP7YevutjRA8oMSQQ2FSSQrAAWPtVbIplhofrdaO9?=
 =?us-ascii?Q?07BIYOWtkb7vQuBgPm+0HXQH+/UgeS7+/+ZYgRLguUdPfN2HRZzEeTZ+uXZR?=
 =?us-ascii?Q?YbpY1kE7z2tOWSMNYKHIoP4VS9lA9620vAtfHHs6z8lJ0TCmtLTBCwNhd8dd?=
 =?us-ascii?Q?4lKP9NjfCoqCyrzYeVSU1s5alFgQBKM3M/nvDIEUExrghLMrO2IjgSjWCUvw?=
 =?us-ascii?Q?LKX9ujEPCssJg/X5179jiDnl/rA11ZkEjL/i5M0kxrlVrPGRCP5fRzFmwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:38:32.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ebfa68-24c4-4e38-4534-08dde50a6eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB

CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
mapping to enable RAS logging. This initialization is currently missing and
must be added for CXL RPs and DSPs.

Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.

Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
created and added to the EP port.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
Changes in v10->v11:
- Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
- Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
- Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
  and cxl_switch_port_init_ras() (Dave Jiang)
- Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
---
 drivers/cxl/core/core.h |  7 ++++++
 drivers/cxl/core/ras.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/cxlpci.h    |  4 ----
 drivers/cxl/mem.c       |  4 +++-
 drivers/cxl/port.c      |  5 +++++
 6 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2c81a43d7b05..2fa76a913264 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -146,6 +146,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
+void cxl_switch_port_init_ras(struct cxl_port *port);
+void cxl_endpoint_port_init_ras(struct cxl_port *ep);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -155,6 +158,10 @@ static inline int cxl_ras_init(void)
 static inline void cxl_ras_exit(void)
 {
 }
+static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
+static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						struct device *host) { }
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 69559043b772..42b6e0b092d5 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -284,6 +284,53 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
+	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
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
+	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev)) {
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
index 8f6224ac6785..32fccad9a7f6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -586,6 +586,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -606,6 +607,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ad24d81e9eaa..a6da0abfa506 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -84,7 +84,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -93,9 +92,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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
index fe4b593331da..e66c7f2e1955 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl port
@@ -71,6 +72,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	cxl_switch_port_init_ras(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -125,6 +128,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	cxl_endpoint_port_init_ras(port);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.51.0.rc2.21.ge5ab6b3e5a


