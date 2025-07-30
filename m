Return-Path: <linux-pci+bounces-33217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3BB16892
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F59169CF8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB822331B;
	Wed, 30 Jul 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjVEWsgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323F2222D8;
	Wed, 30 Jul 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912236; cv=fail; b=ROcxKILfxMzTL363dlptw63WNFVZW5CM8nAiBRNMUt/fXgVacm0q3YyR7nlsZiuvw5p0YZpI77tNPdtOplgZ1nQEelT4fMRoWpqoceaMf0wnWnW+z4UuIlR1B9zoR78ATB4c4BF7i6eXkZvIpc0RxX1bHfREr90raD1njJVozeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912236; c=relaxed/simple;
	bh=V1ktLKYxuoM2wr07W/9R6nIM7UKRn7aveJz+ywpfjSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcryM6zDDHnL9VIrvt80RsuD8WW/UM3eBjv3MN6Rz9Lo6YqAr8i8FzZP5IgaF9GRIliksqc+nJSlqeZlolFSDYc8zCTsieyIzjCkHSNioK6HrVWFE26nVftpZ00GH6TkZ5YjBq14o0UXQUwbfc/B0jRlBGotnG6TRbQWWtmz91s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjVEWsgo; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umC89W59F1/gzzuhFjD1AVgiQsbhMIdYvz0vj+wJ+1/iNZtOfwTXkIHYs/YrKDunlhhe8nwV4tyY90Krbb51hOU+aqmlIRr4KTvvRwE2HOaBPWN1i2B/E0Eq4NDLMpFr3YQaGIxOQ3JMY8J9c32cNnDxy8Pf2lhTbeevEu1yUZvx6o6DpjDxAWhZYbmKFEpDJvx7QVS6i/4EjLrTuRszoXMOR5/oCjmFy9BQAPYjJb32c6CmJLi9Nhfj6CtfrBx2Qz3YzlAzwGBEPuMHnV+FVMC6d46i8Oj9pAaQC79to094h5Pi0JvohBmDHt7BWq09uWJXYsTavTmV790o7uE/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKTHzqd0LwVIuCWgovP7RveFs4+kY3u96G0zccRjoGY=;
 b=UIIaZgLMf2fMSR0cJNYstoTbSG0FFoFOR8tGc17q0qwnmaALZQXJZ4PISZU0ZYILwtQCsDt5ISd+Rqbctbl10WJQbbPAautwqZ9HfDNzZ+CXERa9bydxMNyXu7lRaTnGu7myYlrQd5vfjvJY8AjfhwnLInk+oeL+bMFjt3KcTPoJ4lLJYgXY/XqSB2wxlcdtIKaqmYRFgx7wDhC5n8rpj5zvSO+gH6RKpT4WkLa/JLN8yU37/sJTKdLskBwuTf1V09kqRVtXFzxJcEZheb/srFPKSH6Anx9Awl0wu9T6f1qjQQiup1UKTdpmgJhhKnIsolOXjrHYkz01zReKK/sozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKTHzqd0LwVIuCWgovP7RveFs4+kY3u96G0zccRjoGY=;
 b=VjVEWsgorUX8zqb0LNvIwV4YZN3J3OMvISK1Hrq67nQtqdfpyBqa1LnQ2NWVvp4IrBa6bAxV0gCiYleACI54jzRfOXxzjLuBqsScqIpY1MDOOec2e00pROEEMnhZDuW09oybRLVLL6pQd6cGwKFXRqibrK8g5ERBB6lTQDVaFEQ=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.12; Wed, 30 Jul 2025 21:50:32 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::32) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:50:30 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:50:30 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 13/16] cxl/core, PCI: PCIe portdrv: Add CXL timeout range programming
Date: Wed, 30 Jul 2025 16:47:15 -0500
Message-ID: <20250730214718.10679-14-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a18d14c-92cd-471d-7822-08ddcfb31a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e+yHql1aJj0Eg2N1d29N4n5FavroGCtfUxyphnHB5I9QacDYVsy7J7jIt8wx?=
 =?us-ascii?Q?846+Tt96JZgdNNMLdHQx0u7Er7UITXWD1zDCWas4Zp8GvuFIBcwfzBNCO0nP?=
 =?us-ascii?Q?ZUXrylAThZXElPtfbwreg+cUvu3NFLpawNwIaAZCAgrqDuXgrFrF8U3e8uDH?=
 =?us-ascii?Q?Iom+UE3L4YzomYuceQ+GOh1qNQGzDW0UKD1fkHOOXuwrXojnfq4rYMEJDD8E?=
 =?us-ascii?Q?g07hSL/Qoh9G0m4StV1LA0HXtHvrfTxKL6NwDjDc5nFApacUi5YiBufG3NCP?=
 =?us-ascii?Q?3+LqpD7ywHhmydMlIoxEjwoQqDXcRgYp1Il4DOonNL7V3g25BHA0FngR9s++?=
 =?us-ascii?Q?WGK685a0fW/ZpbzdChBDye8iNiXbiggUBAOuiL2/ioc67Cjn2yjZ6JYIl/yv?=
 =?us-ascii?Q?72jvWZ8qUeR3QkpcC+NlNn7rgT8BCyGjSqNvlgw8CaRW06sR1pqxGksXdNCc?=
 =?us-ascii?Q?6UzHpITYqPIpMei4pns19kS0Dd/ZuZtAPcV1yLT1jsD0WtueYgPdPBQ9pGMX?=
 =?us-ascii?Q?6IE4Z3jhwXIKRkD4fMSRANKzJVB9rlRWycD8Lce+Hzh0mTtrwCBxtMObuhv9?=
 =?us-ascii?Q?09zp9nJoMo8dxRKNhX+b30O9imoZyTN8S/zscoG8mJYpwFoiwVwCylJVP3yN?=
 =?us-ascii?Q?jp+ibthJGzuXcXnfLJlZsXBy/hkXPTmJwuIX/yCRHwLE1IfHmO0axs8OON0C?=
 =?us-ascii?Q?3QbJmWJI1KFfW3PP5CTXovlC/ePaI++ggln3Lg3Z61itASVzT3HBZ/h84h0p?=
 =?us-ascii?Q?B8uqQkZ0I7/t7wFw5FA0NeF3yidzu9p1KOOIJh1cYqZsLoqOGOTrG/CehO1n?=
 =?us-ascii?Q?iU8+jdUVuIspQFHWYyTwjQVPoshKcIV6PwSvnHrfR5x/SGv1siq4ypLm1XP6?=
 =?us-ascii?Q?GqqseqjLXY/kfqvo1l4pv3MLDEi3IoHEyNGRXeEojlHCe31iYmOnfkZ4EPL/?=
 =?us-ascii?Q?0x3s/AFFjzcrYirpz4FcIZRLMnfeLCGEO9SqsmvQ0s4UHoH1IYUKXHAy4KUA?=
 =?us-ascii?Q?9oEZIqmlF5iq1MHMS8RnIPlqmm9g4O34eVL/SGCs3zEU3HL/adWMi86Ii0bH?=
 =?us-ascii?Q?cHBig+Wtv3o0ZL4Oxx0zXRmZNUNzJgDmQvPSRkghbkWdjVWllzO4yc0JqcnS?=
 =?us-ascii?Q?YjWWnj0t6zur1jSpP8kS4bLqqQAchxxUZkFKzq1Rdc8fVloJwJL2Na0FWKxX?=
 =?us-ascii?Q?t4jmnNHZ+Xb0n3nbqh7MaiqcCHnFVWmUWYVv6Xv7EEDZXkcaiBXR8mlfyky1?=
 =?us-ascii?Q?x8V6GgDjfRvBJ4hOi9XLiNcP2YlfURkzFXz3xpsflp/4akq5r51pOD7yvl3o?=
 =?us-ascii?Q?dVE6y6YGEfB2UHNt028YY6DadPhaxCozpQeofCKqlpQonjVvUccc1rvpUzAo?=
 =?us-ascii?Q?mQiP9Uv0/qdHtwYYtsVIrPosMF9pqzZIJ0uTiRjOTj5e6BvyZgV6GWollC+S?=
 =?us-ascii?Q?6mxNoD5J43nwuzXBeYBxSpi2Bqt/F7Jhvd6Xq6uf0pkZa+fe9ZYiQP56pkmS?=
 =?us-ascii?Q?MXVJpw+3YMgyQNdATHIuv3gSUvCnXq4A2Kug?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:50:30.8602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a18d14c-92cd-471d-7822-08ddcfb31a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

Add functions to enable programming the CXL.mem transaction timeout
range, if supported. Add a sysfs attribute to the "cxl_isolation" group
to allow programming the timeout from userspace.

The attribute can take either the CXL spec-defined hex value for the
associated timeout range (CXL 3.2 8.2.4.24.2 field 3:0) or a
string with the range. The range string is formatted as the range letter
in uppercase or lowercase, with an optional "2" to specify the second
range in the aforementioned spec ref.

For example, to program the port with a timeout of 65ms to 210ms (range B)
the following strings could be specified: "b2"/"B2". Picking the first
portion of range B (16ms to 55ms) would be: "b"/"B".

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c           |  49 +++++++++++++++
 drivers/pci/pcie/cxl_isolation.c | 102 +++++++++++++++++++++++++++++++
 include/cxl/isolation.h          |   3 +
 3 files changed, 154 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index dd6c602d57d3..616c337c818d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1259,3 +1259,52 @@ void cxl_disable_timeout(struct cxl_dport *dport)
 
 	dev_dbg(dport->dport_dev, "Disabled CXL.mem transaction timeout\n");
 }
+
+static bool timeout_range_supported(u32 cap, u32 val)
+{
+	u32 supported = FIELD_GET(CXL_ISOLATION_CAP_MEM_TIME_MASK, cap);
+
+	if (!supported)
+		return false;
+
+	/* CXL 3.2 8.2.4.24.1 field 3:0 */
+	switch (val) {
+	/* Range A (default) */
+	case 0x0:
+	case 0x1:
+	case 0x2:
+		return (supported & BIT(0));
+	/* Range B */
+	case 0x5:
+	case 0x6:
+		return (supported & BIT(1));
+	/* Range C */
+	case 0x9:
+	case 0xA:
+		return (supported & BIT(2));
+	case 0xD:
+	case 0xE:
+	/* Range D */
+		return (supported & BIT(3));
+	default:
+		return false;
+	}
+}
+
+int cxl_set_timeout_range(struct cxl_dport *dport, u8 val)
+{
+	u32 cap, ctrl;
+
+	cap = readl(dport->regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
+	if (!(cap & CXL_ISOLATION_CAP_MEM_TIME_SUPP))
+		return -ENXIO;
+
+	if (!timeout_range_supported(cap, val))
+		return -EINVAL;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl &= FIELD_PREP(CXL_ISOLATION_CTRL_MEM_TIME_MASK, 0);
+	ctrl |= FIELD_PREP(CXL_ISOLATION_CTRL_MEM_TIME_MASK, val);
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	return 0;
+}
diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
index 9d2ad14810e8..107201b5843f 100644
--- a/drivers/pci/pcie/cxl_isolation.c
+++ b/drivers/pci/pcie/cxl_isolation.c
@@ -193,9 +193,111 @@ static ssize_t timeout_ctrl_show(struct device *dev,
 }
 DEVICE_ATTR_RW(timeout_ctrl);
 
+/* CXL 3.2 8.2.4.24.2 CXL Timeout & Isolation Control Register, field 3:0 */
+const struct timeout_ranges {
+	char *str;
+	u8 val;
+} ranges[] = {
+	{ .str = "a", .val = 0x1 },
+	{ .str = "A", .val = 0x1 },
+	{ .str = "a2", .val = 0x2 },
+	{ .str = "A2", .val = 0x2 },
+	{ .str = "b", .val = 0x5 },
+	{ .str = "B", .val = 0x5 },
+	{ .str = "b2", .val = 0x6 },
+	{ .str = "B2", .val = 0x6 },
+	{ .str = "c", .val = 0x9 },
+	{ .str = "C", .val = 0x9 },
+	{ .str = "c2", .val = 0xA },
+	{ .str = "C2", .val = 0xA },
+	{ .str = "d", .val = 0xD },
+	{ .str = "D", .val = 0xD },
+	{ .str = "d2", .val = 0xE },
+	{ .str = "D2", .val = 0xE },
+};
+
+static int timeout_range_str_to_val(const char *str, u8 *val)
+{
+	char val_buf[32] = { 0 };
+	char *start;
+
+	strscpy(val_buf, str, ARRAY_SIZE(val_buf) - 1);
+	start = strim(val_buf);
+	if (!start)
+		return -EINVAL;
+
+	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
+		if (strcmp(start, ranges[i].str) == 0)
+			return ranges[i].val;
+
+	return -EINVAL;
+}
+
+static ssize_t timeout_range_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t n)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	u8 val;
+	int rc;
+
+	rc = kstrtou8(buf, 0, &val);
+	if (rc && timeout_range_str_to_val(buf, &val) < 0)
+		return -EINVAL;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (!(*dport)->regs.isolation)
+		return -ENXIO;
+
+	rc = cxl_set_timeout_range(*dport, val);
+	put_device(&port->dev);
+	return rc ? rc : n;
+}
+
+static ssize_t timeout_range_show(struct device *dev,
+				  struct device_attribute *attr, char * buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	u32 ctrl, val;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (!(*dport)->regs.isolation)
+		return -ENXIO;
+
+	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	put_device(&port->dev);
+
+	val = FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_MASK, ctrl);
+	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
+		if (ranges[i].val == val)
+			return sysfs_emit(buf, "%s\n", ranges[i].str);
+
+	return -ENXIO;
+}
+DEVICE_ATTR_RW(timeout_range);
+
 static struct attribute *isolation_attrs[] = {
 	&dev_attr_timeout_ctrl.attr,
 	&dev_attr_isolation_ctrl.attr,
+	&dev_attr_timeout_range.attr,
 	NULL,
 };
 
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index 0b6e4f0160a8..f2c4feb5a42b 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -30,6 +30,7 @@ void cxl_enable_isolation(struct cxl_dport *dport);
 int cxl_disable_isolation(struct cxl_dport *dport);
 void cxl_enable_timeout(struct cxl_dport *dport);
 void cxl_disable_timeout(struct cxl_dport *dport);
+int cxl_set_timeout_range(struct cxl_dport *dport, u8 val);
 
 struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
 				  struct cxl_dport **dport);
@@ -39,6 +40,8 @@ static inline int cxl_disable_isolation(struct cxl_dport *dport)
 { return -ENXIO; }
 static inline void cxl_enable_timeout(struct cxl_dport *dport) {}
 static inline void cxl_disable_timeout(struct cxl_dport *dport) {}
+static inline int cxl_set_timeout_range(struct cxl_dport *dport, u8 val)
+{ return -ENXIO; }
 
 static inline struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
 						struct cxl_dport **dport);
-- 
2.34.1


