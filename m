Return-Path: <linux-pci+bounces-26991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F59AA0683
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D743C7A3162
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D52BE0E6;
	Tue, 29 Apr 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zE6Qk84l"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A82BD5BF;
	Tue, 29 Apr 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917271; cv=fail; b=F3mW1AOL2EA9ELG6sSwIEnWezyfg3LbemV20pQ+20LQRwMyrrD6G0XqaBms/Jw8Yv8+szckvRHE9T/QB3Od0Xa4xbKCAgp8f3EATkz//AUXY+byxSSwCAyimPvXuIefW9NxPcJcRwduQA5tH5ZgENKhqRu18B6+SzO9DDXoM9yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917271; c=relaxed/simple;
	bh=GckNKdDr9Kvx7WEKG0XK/HTkOyd5f6moDbvdfeCqREc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCPg7C1hJGxfGiY4L6m1IMZ7zvI9hKnPJRPJze133a7qAzPEWXX7Ngngf3uWW1inG6dJ+RspNDgKTtGK9QxdfblYgLNwt2DTh037m3U0evONHgXqMWmBR4wxmWOoHvRPXQn5fSgiiiYwhPiD6P0fLvWTRaJkZzK6SmP7750wWLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zE6Qk84l; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyD0DaJrVMpfj8EEKqnVoQe3lgldPgR40n1L4ljwCgNEH6nRMgGkgFTbOFnEi/OMHgnixuZaDPvhE+MZ1FwS9mIIruwETAahgmd2jDsy02cyy19gIEaZwJQ5zKJJ3/OhVpg0ub0RycUVHo/5cFAdwtsBcLijTJKu9iPH7B7EiGZhrn6SjPvTbXF4zu7AQN4sF2tF3fqgtD5SxNes3ea1HcJUX3CP09s6qkJ/+0/ABEZ5rCmYmzRxCNFZeNYySFIDbFDJSjn31tkeCMz+5o/SO5HoCpzgVxlZoRbFswpKI4rPr06hxPGBlw/BONfEYivJ6WdL0BjkezOke6/Z0zX5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7nMRYTKe2AM33GuS7VMEbv1ayq+5Ia243eZXkrSAy0=;
 b=YF2CoI8zwQv3wQ9sPkI9MuQBBZPN4TdPF7nsrysiICCgcTLxhPq0g0F5+OIYg8NpXJReawiUZ7azO+zNxX3pqWHYNJw2JCqMJt/6UbpJzP0jyJmNULykSZYkRsuVARLgGJ71rzoHyzezr8iMXm9lFngYyfseHjsbCiw1R0cwi92GaTy5+JVkjIh5QqK50PuUCsY9Jk6NIurh9rsmuxcguWreFObaRWb0eXEQYvu7tBVaOJcUCvFTDHNfEIbk86CEaJ2MhHNIkdbXL+OxkhuFk9ABq9C6vWxumsozPsXaOqiHCVAsXBAcmxl+dBEGuIWG7UGz/al/yGRsRtMne3raAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nMRYTKe2AM33GuS7VMEbv1ayq+5Ia243eZXkrSAy0=;
 b=zE6Qk84lFDKeSgdS2/2h+/K5pURzGPoW8Q89im7bH+nL024I6m2WcaLan/H/L1Awh4RS527T8Qm3PsMD2+Qi8UFeL8XsByS0smFUM3Pb5rti9IOtRHrCVvpf1p4d18aeccJghe6q69+4G59RWZX15AEgpVIO7NyrTv2RRTL2UwA=
Received: from BLAPR03CA0172.namprd03.prod.outlook.com (2603:10b6:208:32f::12)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 09:01:05 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::25) by BLAPR03CA0172.outlook.office365.com
 (2603:10b6:208:32f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 09:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 09:01:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 04:01:04 -0500
Received: from xhdlc201955.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Apr 2025 04:01:00 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Tue, 29 Apr 2025 14:30:46 +0530
Message-ID: <20250429090046.1512000-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
References: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 11affb38-426d-490c-f023-08dd86fc5ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qX6NF4O2hS3PqYgJ1MG7u9ZyNLQwDNghDMv+zXwo9d7ccyv8gn3AaMD8NXJ?=
 =?us-ascii?Q?5E6GBJDwgVAQPKmHKIBN9xpzoMymSfftT9RzYbmUDQHPc/3gKdDYhmWuJl0w?=
 =?us-ascii?Q?jbwgbYoo0VLGl8DNXkjZMRUGvUL9J5SVAOmtWBobvoaR75U4p9RN+2WhvP1X?=
 =?us-ascii?Q?jWA3KbBRSDkMvM7uKYMYp82aJySjGZo68hLnteuGMwe6z/TPWp8SLoV0Xy/A?=
 =?us-ascii?Q?hI/KaB649ecg3ggOi51Xn2yqnBg+sYHRLjRRYtxc0VNZ647LDfCNUBrX/JpO?=
 =?us-ascii?Q?Sm33Q6cY0FYjwB3lX1OohTgQkbpNM2gyuPZe6zU1YswKqlTHFnuIiPGrag0H?=
 =?us-ascii?Q?aWbIz3g+Tka9ZNzVlJSwcHgiF7W1DfsWZuzItmmtF//YwzBk0nzHj14XYVDH?=
 =?us-ascii?Q?STbAumwy92BX0ZASU5P7g01itH07Nb1naXUxJEHqOwzPK5ItvxJZoIZDg5mq?=
 =?us-ascii?Q?QoQVkZ7wJRch89b0d8cMcSZoGVg7Rph2QBalNJoX00aoIqt7XELBJ0slyXIk?=
 =?us-ascii?Q?+ZHl9/aLfdig3oPRKdB7T94CBFqppD7343+llQuISKVropVDhpoLk1JyAb6p?=
 =?us-ascii?Q?wk8P/8mGzd72gEL8Z/1tf4OzhLg4CRi8pgoM5h3RJ761p+UCs235KGbh8NMA?=
 =?us-ascii?Q?Ux8u4C5EZAX/XXH63GC3XPB1GxbwhUYMvEYlvoygZnPz57lv7Lgh2bFLkFgF?=
 =?us-ascii?Q?yR2aAlLVdjRs+57xMGBezLMODkDB5spRtev0FRuM4vrtkt2d51xYETFrjvrf?=
 =?us-ascii?Q?URYZVlXvgwTjhWxES43RQCT7OvKSN+oDcqzj9hlOS5UnMMwabUV4sOFs8Zm0?=
 =?us-ascii?Q?3q1VHjaNb9rxzWh/8dQ81xWzxwOjrfUCK3P++nRzRFh+NVkPicZBa3QGjiiB?=
 =?us-ascii?Q?oUQm19Cx0/76OUJkiAnNCRV+kgka1mO7GMNt6edSYhU5LfqKhhYuLTzAn5YC?=
 =?us-ascii?Q?kC0ma9cbWVFji1mclUMULPlEga5i4SdUEd5U9W2p6PQp1rvfVIl5llJzUp0M?=
 =?us-ascii?Q?jHMKDVKU01Wck1IVm9paRJJZiVkPdSBEOcoW5NcZ7X1KvAj7OudUcGjM1m+9?=
 =?us-ascii?Q?6o9Oo/SMZdg3pMU2SSrcfcV57DaNLDlZ+HigqtbcopLsUSxnwMjq1ZguuFKB?=
 =?us-ascii?Q?OphvrF47qUbOMoomdcRLWIdu5woh2G312dX21wPkAzBf2cqmTlUyByNM2VqY?=
 =?us-ascii?Q?ynEAAG50QjbGCKFBYuPRW1ubnLp0FGheFqFyoVui+1PA7uh3myQUEhAIghLr?=
 =?us-ascii?Q?VuBDdkgJ/YhBTc8W0oNUfEr5DMBsCtM4kfQ8iRlQgRBcUleZGuIN1M5UMf+B?=
 =?us-ascii?Q?TtNznkHJprV6Ho9GghSyKNi0KW094MrbHi6MNz0CtINwHoLQDT4OIWa+eiyR?=
 =?us-ascii?Q?UTRkdry/SBNR8XChL7XQYddstrfh2+0IRE4Yubxyp4smaCyo/PHJqrzRSpzb?=
 =?us-ascii?Q?ozWeQNAE7WFt00NeVRHJJzIYNHCW09zbdt+6orlejtOk1HkVcb0icydJHARB?=
 =?us-ascii?Q?KZudERQYYHuR9eyeUkYYuEIXB1ZDg3aVknKF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:01:05.6342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11affb38-426d-490c-f023-08dd86fc5ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

Add GPIO based PERST# signal handling for AMD Versal Gen 2 MDB
PCIe Root Port.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v2:
- Change delay to PCIE_T_PVPERL_MS
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 4eb2a4e8189d..763265e86db5 100644
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
@@ -426,6 +428,20 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 
 	pp->ops = &amd_mdb_pcie_host_ops;
 
+	/* Request the GPIO for PCIe reset signal and assert */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to request reset GPIO\n");
+
+	if (reset_gpio) {
+		mdelay(PCIE_T_PVPERL_MS);
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
2.44.1


