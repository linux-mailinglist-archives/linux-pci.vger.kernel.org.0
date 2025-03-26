Return-Path: <linux-pci+bounces-24723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFAA70FD9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 05:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AB17A644
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666518CC10;
	Wed, 26 Mar 2025 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7TfxD8w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265B18C034;
	Wed, 26 Mar 2025 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962528; cv=fail; b=ir3jLcLHcpXk+ZwQoTt4+MrYUtRhol1Vy5vi2A29lPRq7KsEDvZqQYu1aDpFYOAPC6qsczKZmPBtdLrWu82BRZPVtCMrG4FAy3iw0S1CxCzqTNlRLemhb705NipynKgd8vHW98HZjTOx4qz/UHhCY2S64ltXH8JQuWrKxvEAc4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962528; c=relaxed/simple;
	bh=iOAk0jqU21lny6aH34YKGEuCG5pV8c5/KEqLvbWwf2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRg57JaWUSC6aDWY9aUrMWZfcUjMqL0MQdU5apMc6eC3i7+O0FuyLhIr77g5H6IqZhkojGYo5ToGcfLH+cUIWoNu8mh5sFs4cVFltwQRZry2PFrwkxe5OkOkhNuuSD9s5mjYkhf7FkhrZooGKqOJmH+Jq5CBQRUbTZ2PSxJhXHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7TfxD8w; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXCNbhF3tjetV9ZHB3E/vVNb2sWSJ676uWhIFPP9coFiEuwhhxD942gQsfVKUWR4/7bu+oir/tS0ZpdtU7P9PQjQapUYYtbbJyFdfhwPjBmPUtauQRekpWUsNSpPmpIgIPiTACdA1ZE6SuiD1xe1x1BFbh8r7pVEMYDsHNNWmWLjNhQyzCv7xOErbz3O7eBe9VPcnlpv+fnaheomVdAxKXKqmR6SprizQLdoPSrj/UL6xcWyZf75xDquuH+JeSOIL9kDmem9s9ethJlahagw+2PPnS4oCDweMkpP+J/lnc7uG0kaj89DZpatm/KXEK+YvUaVc5xjx3EM7Kx215tHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPrBNUPb1RTMcWHgsNiDcnCi1G0nHbuK8AN8lux1JGY=;
 b=AKbg6uHSn0jK3lDe3UqZICGOPS5px1Im9kNgCzw9kGHb54WTKI+x70r502NpXfB/bHX4uW+OTPnU9ISTQjtx5aZquOj48RuEAT0frJaywU92ITltVfqeR8mLMUo4NRZtTgxM44RP/Od78QvztyEk9bV/dlChZiTu57R6r1RJNmyw5fENEj4HgvtFeDqY7LRz/j+svnOnAyw/7o39FEmLXpDzU8q9b7US5SwsVgWfZtoh9J+tYHq+4mqlhyQWcTXGya3jIgaT7FxvNrQouPy7D1h4AJlthef24bN4Y9fJk7PorVgMV2he6tb8BIFx1f+GmO3hgVax89IM/w5sTZEK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPrBNUPb1RTMcWHgsNiDcnCi1G0nHbuK8AN8lux1JGY=;
 b=g7TfxD8wMABytRPXAm0S4dYJ5uP7XBIO7lUQZPXSoaaK+IkwkbA7O6euOE5ef0atCdLDJkHxfo8+xHS+shgNUJjWNGb9JVtWHwfuyTQr6u3r5WiqIr0uVVXz6hGZNh9VR/KCjvgHJrfhrIbY7Ohp0Ckm7SSBGRKRN2wGhl2xk54=
Received: from BYAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:74::16)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:15:22 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::80) by BYAPR05CA0039.outlook.office365.com
 (2603:10b6:a03:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 04:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 04:15:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:21 -0500
Received: from xhdlc190412.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 23:15:17 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal
Date: Wed, 26 Mar 2025 09:45:07 +0530
Message-ID: <20250326041507.98232-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250326041507.98232-1-sai.krishna.musham@amd.com>
References: <20250326041507.98232-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0677a83d-8681-4870-3553-08dd6c1cd3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aIxc9azgWTTCC/H5AZesxyxHjuGpjHLOFHoSbhmc0QJwdaJSWTE8d5RQgV5?=
 =?us-ascii?Q?HuXvoHy5Tq0Jdda0CCJq2D3z/BF8ckW4BUe1IkUTEM0UFZ8lq/BSGV/6U7/Q?=
 =?us-ascii?Q?+YIN3sDoTtuK5/myOrQNoOJbhGR4sQL5YtNJBlH0ElqpbWXItrpHWPTiP462?=
 =?us-ascii?Q?s676eviKjEtS13vqEDVIu48S9eD+VLwlks5WnRCnvu3E+G57v4lWrrCCTnlq?=
 =?us-ascii?Q?2n2G/EXeNZG5o59r40W8FTUnx79/1vMX7C/xVy3ohHuLqY230TeODgvR1yZD?=
 =?us-ascii?Q?iSx5g7/j3OHc5VwgwUCDV33JpSuYfiERi83q7ZiSb8X11gMjgANe50OFcO8U?=
 =?us-ascii?Q?TZGtducWJcxg1Llj/HFoZhafrKzjwZHYrcQdykvocL06kbHoyH2reWBCB7ZG?=
 =?us-ascii?Q?gucuM+4NLehQHY7lY4wdTopz+hZjEacXEbuHRJxVvUruInM+GWjJ/vvbf4Ia?=
 =?us-ascii?Q?d9wcCGwLNEciTYqn5Efp0TTQuxGPYIaeXymiwpLnA9CYjCJAgZJue3vfD+gw?=
 =?us-ascii?Q?z2WveCul0mRhBEwnH1XgtD3f6Q34hfW+caW+WycpC9t+aeC0sYEsi3nKKw26?=
 =?us-ascii?Q?eWoCOvzIbuIh1M/YXDdU9Gv++Ogxj70ZTDV6N73XRtM1nAtguj75tNK5M6UB?=
 =?us-ascii?Q?7yYD4M9cHl7RFRLEkP/lQ3Pm/bphH5GAwk3qAGRvBVc6v/NtoXVffN56MSa3?=
 =?us-ascii?Q?ISDzYGr19qgD0B/D1SbBXl18L8FSdAvQpKKoOQaVEp9Nb4NJZcEgD3X+zDxh?=
 =?us-ascii?Q?mlnUFdW4JWVrKhcsQRIkMVwX3yHC5NxfnmqagK2uEltE9GvuN1l8ode2v4Sn?=
 =?us-ascii?Q?MuAZNcdkIfcKwpasKrYmZinmCbuaKUiieYa50yp7e00YNLYoObzguMkP7i+F?=
 =?us-ascii?Q?ANPSM6s4s7YxJwfUXQiNwYvu7A8iIqIbeYxX9EaVq2zVDq1v5vpvxDURy+nc?=
 =?us-ascii?Q?wts9WYHBtPpOWooYfgUZZYK97UsJkQJuKBLdHQFpcoP3jadbswXcjr6tDf6+?=
 =?us-ascii?Q?kPrKcV7+1eJg7owYZFrltjb+q9qIiPg5LKZnujhelWN+m8vjM8E+avnBRbhs?=
 =?us-ascii?Q?5w9P79idbcBrAB9RkVN9WJiYqUvKszOgV4qAp+JYld57DonzX1Q9p5gkQVUH?=
 =?us-ascii?Q?l4ZJU9G5qxcCmcdaLFw2oJLUWSnJZP37cY94N13CcHE6b4IvWS02jg8RECuu?=
 =?us-ascii?Q?X042Yj1Zc4RDBvWLOV977Qpa3PBoV54ewPs9mH7ZSDk/Drw3/cmJl7cqHa5v?=
 =?us-ascii?Q?2volnj98/hK5B13Z6ccT9MSZ1OzbcwUGJtJB9um3XqagEP5j3yxakOvZNdGb?=
 =?us-ascii?Q?6OmAyrXd07lCw9pCxXd27DhzIn+abzIM8M93kyt69xBlX+nZUseqvsQv11uG?=
 =?us-ascii?Q?NQuc0FGS4002sftiUpYsEy07bl++D4MboYLkRtkM0X2K1NtdT/LZyeA7aFyv?=
 =?us-ascii?Q?WP8Z2DwdDVPoR8lggVkUYpDKa52iuT1q7/nTXuuL+j/HDxpaT0EH0H0K3c9Z?=
 =?us-ascii?Q?IJ6Za/EbySyUJ0I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:15:22.0997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0677a83d-8681-4870-3553-08dd6c1cd3a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

Add PERST# signal handling via I2C GPIO expander for AMD Versal2
MDB PCIe Root Port.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 4eb2a4e8189d..4eea53e9e197 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -18,6 +18,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
@@ -408,6 +409,7 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	struct gpio_desc *reset_gpio;
 	int err;
 
 	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
@@ -426,6 +428,24 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 
 	pp->ops = &amd_mdb_pcie_host_ops;
 
+	/* Request the GPIO for PCIe reset signal and assert */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		if (PTR_ERR(reset_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
+
+	if (reset_gpio) {
+		/* Controller specific delay */
+		udelay(50);
+
+		/* Deassert the reset signal */
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		mdelay(PCIE_T_RRS_READY_MS);
+	}
+
 	err = dw_pcie_host_init(pp);
 	if (err) {
 		dev_err(dev, "Failed to initialize host, err=%d\n", err);
-- 
2.31.1


