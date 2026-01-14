Return-Path: <linux-pci+bounces-44818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5DD20CA7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A91113000B33
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F803358A0;
	Wed, 14 Jan 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvMX6Vcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522C335064;
	Wed, 14 Jan 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415196; cv=fail; b=KERg4UlcPYPr70+5R6qGy7JNbMb42j6CtLnX/QbLZD73ZR+QD3NgLop7FpCAi5piWMGsO6OXytJzwlzyGQJa/9/f9YLWbSIuyjEftLdwBhNAVwAe0dHnJURuvOJg/E3/OEM3eXRYP1fWrJaRBVGkoUIHx2gtt9M4HFDD2bbkBf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415196; c=relaxed/simple;
	bh=ceadeDaqMk2JV9IBXaBN8Ve4ci0spMdUKDJtLz1WMv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0TfV+Sv2Yn3R+C0VwjS7Cfp6h47x/YTxeAZkMxN7Iu+3lhCkh+9up83R7GS7W36RQyDOKzhClzpzdcIrXTUdNaF2WYP9FEaKYeyC/zBm8WmLv/YUdjceXsvepnXxftxFpsHzQ/LVt0Z3N7t15axslu3Vu6elz2TOJi418P4f7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvMX6Vcv; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfVGSQ5Lt9UlSWAmYOGWW/oc9M9XgO+zmzT+2u6mz3iWwXFoeNKC9B0iPDNMiKRqawhh5+2HYsX6mxN4XqI9EeAN40H+YG5ifE8rSs6IFJZJ9Z0B9D5V2Ljb6Wk4d8mYEcShYFO8gzWN3TvDK/Yl2cq9ErnTpPtJKDFU9mWxd5qRWdnFeT41vQrRtjSHt/V5s/5WkKsl8HpjAi+CgUVyIG65DWpoxPtIRBHOcAkylnO1Ov9b7XxBWOM5NVlNws7h7kxYO3aYBQCsc9acHDFIiU+s3wQ9APxyzT60OnEV0oJlBdwgNVKlN69nd+qoK2ifVz21luEao+qANaVZIkGbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkbsE82qahD9i6dj3LLtjwhC82Sn/5y0pDfDqrgwC9s=;
 b=tTZ/3g+hbkP9Gmg/3WsggyebFnLbqlaWqeOdPIg+YtaTEdKQn1pYPih7L9lqGb5VIfVgYwL8wfh8Ix9X5kLkg7sOwWBrR/m6bO9Bc4D+bt1nnW7jyJ5uwI5iCC6wq1sjfHAqla71vKKjhuoGETdKBblTmQtjsIqiIvkGbM0v2W8RVxBQyWNU0VIMLf8884cdX1o7XNGmzKPZV6o5zkdD8+Idxeku9jy88xxvXsLa2l1hpFIoa2AG8NNw6P1lkKhCDNfT1x5GTalgeTZBcvvwJFr9z1Eg6XOVDTMaTQtFzkG7zLlRKFuTIM4JhynwKrvssQRpiYGnfmDMR0PjK35f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkbsE82qahD9i6dj3LLtjwhC82Sn/5y0pDfDqrgwC9s=;
 b=rvMX6VcvUqpzbp2NBtQWjIX29ACJ4ZrvDoteNnxdbhp6okBGcYnIOWYHPl4vSWgewRH1Jqk61/yGQ5bVqY9+RU6SQ23HeEHsiVq+tyhASybsBKRgI6UTYGove/fCCj7o/aholN/x6lSCqnyEDQOjxxU7zEEsfgo0jmR+cSbs7Vo=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:26:30 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::58) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:26:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:26:28 -0600
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
Subject: [PATCH v14 25/34] cxl/port: Map Port component registers before switchport init
Date: Wed, 14 Jan 2026 12:20:46 -0600
Message-ID: <20260114182055.46029-26-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 956a0c6c-9ede-40f1-e9b6-08de539a6ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nl4lfbwGIDuYpYB2Is0WhlHZGqSy6ayWnfpkJ3i9/di8XCRnfUaOvVcob3j2?=
 =?us-ascii?Q?Uo0VmcvxzTTkHR5hk7nKm2R0W00jh8qGdyySN0+9VluAieMFsOwwKOzUULY0?=
 =?us-ascii?Q?fVAN5tFBpXwraxLLWU2FBP95lCYu3Iw/nNTjfu6A/Q7FDMsaypkAsvfWyzWe?=
 =?us-ascii?Q?6mkzCf6PJbJLw19zYx9e49nx0fOJp95eTt2ABLJ3c/8LRs8mcD2tQ3Vaid7h?=
 =?us-ascii?Q?iYreBOdsdPMXW2RPCmsYi/GetwCnazoGjVLHh3veGi0HZwcph9aLeLUPnswB?=
 =?us-ascii?Q?uvxITXsnXswsmTa6AJkyJMaRp0CtoNDMzgIIxAMp1P88j5jkOWAWiOLMcAzo?=
 =?us-ascii?Q?7paN3pFplVP8H58z1WtQtACqUv4GvUjTcCXWCHbxX+VQLpCer/JyPLHemXt6?=
 =?us-ascii?Q?Y3LfDd5SImnum7E0AfwObsGfagh+R6VQYN/Rb9to4LFRhxWaNC+QJxURqZ3S?=
 =?us-ascii?Q?R/3ftjjHXeI2zQDshFOLkE9VaLi7UI1vx9IFeH5hkGwSslmUjrGClyK6ttkZ?=
 =?us-ascii?Q?QA5G+0SpKcgwPZ/C4YQlY3PkfFyxDDnOO4bEEcIu+vFPzJRhpWj2wWv3MFa/?=
 =?us-ascii?Q?b46g5spgV9PXqB98BQxuAqn5jCgdZHjlmGQa4uie9IamGmlQB7lIS25d94tZ?=
 =?us-ascii?Q?Evcz8RHwc2Y8VY1TnGfNZKCMscB+vpPfniYpfgllRC/Ev+ItGioIpfqoAsXy?=
 =?us-ascii?Q?xg0L/KXjIas0oZLE2/FXJo4rVbF2QIN39giuX4/xNaCIcfDNaD0adiJjxBnl?=
 =?us-ascii?Q?6ztnS6phEs1tu0+8C73GfmfP5von6z37DqKdSUG6uI/UyRnGBD9yZbKhTpwv?=
 =?us-ascii?Q?pWWtUg7WE5AbA/rbEfCjzce2WVCeAxRixBqTI6QBWCKBiQ8bC+Dnq4yizAnH?=
 =?us-ascii?Q?1DL+oVcoqrOqPBMNIaxcprPBAvidX6c0uNCHMjX3NMqkGiqaWWFGDK/yoDBC?=
 =?us-ascii?Q?KSITjuki5j3in2T3xarCB4s9QdaFbiwq5oV2WRu1ZpFR5f6XrUgY+QJn8Y3V?=
 =?us-ascii?Q?xLCl1fGQ7/nSotUpSDO0WEHiBmtV+zKUFwMIh3OAry7Vyi5shURu1AZpw0Sn?=
 =?us-ascii?Q?iX6td1clgTmaxtXDLKzJU6Wkww2mHoXgwNcl90ZcISFDrCopizxZm53ZUGJI?=
 =?us-ascii?Q?YfE82il9vK1nEO5X9JnNAQ5zLsAWNatdVOgaP2T/8JiiMmmkSEkKyMec1+fo?=
 =?us-ascii?Q?0NmDuzaRFgWb4TWSJMeTpP++rJ9VK3BWmJABqUlHnKlUaXlRu6SDuxldnzGG?=
 =?us-ascii?Q?xWPy85rp7SQCqbspplNk/7Zw/QIf8zZLB8aazW4c0bPfzG7I0LKD8/5jiZgf?=
 =?us-ascii?Q?lbXNRyD/25geESdyXgprqmpYVmhPnBynq7lcsRhYuu57RXJIvzZ+nZ/cHPQM?=
 =?us-ascii?Q?kzL8ATakIVm56SUk14ik+POomeAc/20T0GkbUJyF7aCHagTrcws9Sw3IVAXn?=
 =?us-ascii?Q?23eewQd5vxUQTpk/ItpixqHief6GMTiZuZJVtMBByhkxKFcWjxkTfkn3O7PR?=
 =?us-ascii?Q?b9CouS7yOjolVSkgWaBpC3n0bJnNgLxliiTJIJgqWxPhj/z3ZtyYOGqiXuhn?=
 =?us-ascii?Q?PEcEG9NbaBVP5a7mIP8aM876BlFLtOWC5JwLZH4E1P9YuJ1UWkL8GVCmmzkp?=
 =?us-ascii?Q?CUc8H0M+1zptYWCWhk+omRDEychXcHgeCxzpLcptvIVUYd4BkzlAGYMHJl6i?=
 =?us-ascii?Q?RgkEtw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:26:30.0260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a0c6c-9ede-40f1-e9b6-08de539a6ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

Port HDM registers must be mapped before calling
devm_cxl_switch_port_decoders_setup(). Invoke a call to this function
in cxl_port_add_dport().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 3 ++-
 drivers/cxl/cxlpci.h    | 3 +++
 drivers/cxl/port.c      | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2c4e28e7975c..3f730511f11d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -778,7 +778,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	return cxl_setup_regs(map);
 }
 
-static int cxl_port_setup_regs(struct cxl_port *port,
+int cxl_port_setup_regs(struct cxl_port *port,
 			resource_size_t component_reg_phys)
 {
 	if (dev_is_platform(port->uport_dev))
@@ -786,6 +786,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
 				   component_reg_phys);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 				resource_size_t component_reg_phys)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ef4496b4e55e..532506595d0f 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -99,4 +99,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
+int cxl_port_setup_regs(struct cxl_port *port,
+			resource_size_t component_reg_phys);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d76b4b532064..f8a33dbf8222 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -278,6 +278,11 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		return ERR_CAST(port_group);
 
 	if (port->nr_dports == 0) {
+
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
-- 
2.34.1


