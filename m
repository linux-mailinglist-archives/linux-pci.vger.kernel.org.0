Return-Path: <linux-pci+bounces-44801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CBAD20CC2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8266C3081E62
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4C2ECE9E;
	Wed, 14 Jan 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpFvyZuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C338335065;
	Wed, 14 Jan 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414978; cv=fail; b=kKzLf2SERlKB47IinnUuEPZxo2C590PkkEaHfR/238ogM+dIx+1QkmWJSK/h0drac5O6gbpB8PvO38OLYyUh4E42qravbL1McTJqzpi3FIkpu4bWGicIBIHm6Yc5vd/4xMN83foFVI9VbO+fWGXJS5dBaqiQ/9UXhzThIToSxb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414978; c=relaxed/simple;
	bh=JO+fJ3TleiqYFwkHR6dnZsgXy+sMrGsoGNGhoG6VsFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvReebCjyv+dzJdWe/j++si+vPkJoMNZsoAsiUucek8Sp6CfO9aYdbM1kfQgS6SwJ8nC1r6h04K/XX+pDUtdsOc8PB8QcPe5s5tyN+/ZS/+5lOk3qtQjc3FrcjVGXwzOq8d+ODn7oMvJ+ul0bZoYylFc619mjyKIUL3ffjlnIho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpFvyZuQ; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1MQQuaFjVAVOKDb8wYldqJOFrwGxmo/+uHD6KXZ9mfV4nAYBTmTwy/bS136scKZfwXeak8HcUvOVxzXQCRGO5EMQp1TU8Xdci2ysBvgX0lAE6wmXHlwBeA4CCK0e8U0X8mbpQt/4NsynutaMO1VOrsIRBmQnH4hsByHlnGnWuSC1j3Sr1G0J8D9Fjjd8zExwQLcwszhZNCsshAQN7VLk/0dXXAJ2zdk6a+akSQBU7S/sY2XHnllDXYqe/ASxA8a6MhM+dB0pVYsm77cQzgLwwhI4BfSErrRXm39iCMuMBEbexXh/XdNS9m5hIK1AZaRj/9BZEqIPu/fAHMnaqF4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0VUgUPnSBfAx8YgkvIR5NTaBaYk53BTzdt3sdB/M0U=;
 b=F8S8Z4U3Kz3P+yqnmiH6cG2N59v67TtuES5qpfTa3zTQER0C/cQC7xef5+bjm8Akzw3cmLWAUYYHbn+NCyknx/P1FT5AIJyF4HHwiyTnr9kSi7Nqmt7uPOB0L81X3LsqmSYDQguo/tlyfGmfculhJ26box3G1N2EzZCy1e0iZcsiskHU1ECR5KJ/vi+kLSkQQrTvPTZlmd/WLJNos9uPirhqG6GkYTcohgFl+vf9zlHLcuISxKciEivMVrnHALwUkvEj3CETfVlElioxAmq8gP3DTlZGS0Lwp7pbo9CaqWUToTAvOCl+wd+/ylhBqprT+whxbD7tuHUlnf+7a3tKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0VUgUPnSBfAx8YgkvIR5NTaBaYk53BTzdt3sdB/M0U=;
 b=SpFvyZuQXs0L3m6kFCG/7xt4g7Vv02uUoFhFcCxAHOSnpFWKDkHEUhrj0F2AlXMI02P3zvT5+WDe1eG33m4kRg/o60QZpvJinPN7hN3UdL2ZB9pON3THTHs/qwADUJlxJQRj5vWKbSCOtfa1r/0g0hGXYIJLJ5K+tOlC6OuypvQ=
Received: from PH7PR17CA0056.namprd17.prod.outlook.com (2603:10b6:510:325::17)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:22:46 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::5) by PH7PR17CA0056.outlook.office365.com
 (2603:10b6:510:325::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:22:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:22:45 -0600
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
Subject: [PATCH v14 08/34] cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
Date: Wed, 14 Jan 2026 12:20:29 -0600
Message-ID: <20260114182055.46029-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: e58a989e-f8ae-4020-1d18-08de5399ea93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KsI4Nf9KQudUejzTvYpFhxMCPIX+J8dv6AN4MBBsUEtzVT9vi8tHONJNpYnQ?=
 =?us-ascii?Q?HysdWrf/CBeR/vVwBJAk/ShbB5e5n+g4b5+/wiX6JTMYIBlLZfa2vr/z0Qy/?=
 =?us-ascii?Q?r1H68JH4xrICS6O8SvjJuXvPZh/t8gqk9F1qeYkhkkQv8CKGoY8ovxe8pR1h?=
 =?us-ascii?Q?oz86ZutpeCmn42QUG0quePzLtbH3cPDx2tMI4tS8vDmGWgzirljBiOmn9N2d?=
 =?us-ascii?Q?2c9hu4g+J+hnSCW+jMa1bJflQw5DYSJG8prO21ZWCWYdv0jAalZcFdRkPgSU?=
 =?us-ascii?Q?JiQXMWjnBZNcolmNTF5moUBIBhrFpfYgsrY6+C4RNIkn2Z/KLeuiwr4lSdle?=
 =?us-ascii?Q?jyIy8Aa2+tPN88yOm3cCBqM74VOZGmszsLp1fkzZUBx31yjVa7J0gq+HjC4c?=
 =?us-ascii?Q?6xMwwVt04YOTbuALapS5jGLVHXrEJ+/Ie/cpGna9QmI9aIbPZj9R0tyYn6C6?=
 =?us-ascii?Q?BoaJi6d2DsG5CsT8MDe0tg8CDJjw1He/fBCP8FNVqmmUy+cKYR16kWf8nstv?=
 =?us-ascii?Q?e7VQKfSKraVRr5W/WCAnKtFxSlRoqKJRr0XnjTsMnDX75cH0lOK6wLLyJ42b?=
 =?us-ascii?Q?ur//5GX4kh4rWTGgAefdbXX2gsSIAQBJK513561IqtQP3IvnHauqxvpz3Me+?=
 =?us-ascii?Q?jYU1o335amnlkkQrDJEQ38E1lqAomb93EMUm1PdxBZSfOzUW6onGkvt+q77V?=
 =?us-ascii?Q?PZ13UkjFn+zLysAR9q3kmFoBDBveiBG4UNNgn5PTOcFWKHZNxqOrAFUwTklZ?=
 =?us-ascii?Q?A6B2lSWwfdVR6WeU+bNpED6fMmSOdualeLDdVM5/1a76Zo94hHjPunsQ3zeV?=
 =?us-ascii?Q?BsyPyEypEd05GDMxSoGk/he90Cirtt9FXmndJhWTj8dP9Jfq708LkloO9nMe?=
 =?us-ascii?Q?5JQgqTy7a43umcwDYKTD49IoJ9g4sarr4YmZdTpsWZSOouvSfZB01kDUQEm1?=
 =?us-ascii?Q?9qZ9lJ0IqwCY3Fj7sOQn4pi07FiirEfPmn82s/3gJY5yyRl5wqdYOxcVN937?=
 =?us-ascii?Q?9nuABt+ZmfcmL9fqSdpMA9kd1eVL0Gk3GJXblBRg03WTZYc3EylrZT8IZ/MD?=
 =?us-ascii?Q?Di1jsEjf6f7Dfk7DedRQCru0LlmC640Av7zE+aivk8x2/DjKOZCeacARmqmo?=
 =?us-ascii?Q?rW4hb20r0JQWuGPE0EHIesde9ZzU2Fk4SPzZQMU2DwIeQ7oz8xunsm5HnE7k?=
 =?us-ascii?Q?dWxOA5bOZYelGmCpBk2DKSfg4P9NCQpBhZB0m84qm1x1wR0amF2WPqBpdQQO?=
 =?us-ascii?Q?d4uL5BIoUn+7eMbbrOchyjOV1qBeInnD7wY7DR77CUWlrSR+2ex2xm2HKSnH?=
 =?us-ascii?Q?2BVFVcgV3z5g+qgxYUqxMMJSWyvBVXsopErhksEHYB4ZaC4bB6e+D4TaLo0O?=
 =?us-ascii?Q?0X5o0UFLdUOWMlwmf3E0A7r9VXmi6vcNE1fZ6I+D2a3Gb/s4SosyIDuUbYa4?=
 =?us-ascii?Q?jY2lhzfNgv3Ui7T0PLl72FGE99jv1FRqbWFLQvgthgOK0e2WCUjx73Waik3S?=
 =?us-ascii?Q?n5foE9Wn6s14xOx2DEY1jyrnihr/IUK2YmUvTCSqdlk/NAu+ibh16ozR7Jdu?=
 =?us-ascii?Q?Pu8Z78lGgp/sHMBwXJh6TnCI3h3omkjk2qtxbufgRX7wyu4YLAdyBnQfDwp2?=
 =?us-ascii?Q?+0T49rc+3Zi+l2atrjbCQMKW+OCg38UWymVfgUiwd7M2Robm/Tf5iPIgllrH?=
 =?us-ascii?Q?50nJRYju0yt5GWD/SMk2RRYGUSM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:46.2933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58a989e-f8ae-4020-1d18-08de5399ea93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- Add sign-off for Dan and Jonathan
- Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
- Remove default value for CXL_RCH_RAS (Dan)
- Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
- Add linux/types.h include in ras_rch.c (Jonathan)
- Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)

Changes in v12->v13:
- None

Changes v11->v12:
- Moved CXL_RCH_RAS Kconfig definition here from following commit.

Changes v10->v11:
- New patch
---
 drivers/cxl/core/Makefile  |   1 +
 drivers/cxl/core/core.h    |  11 +---
 drivers/cxl/core/pci.c     | 115 -----------------------------------
 drivers/cxl/core/ras_rch.c | 121 +++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild   |   1 +
 5 files changed, 126 insertions(+), 123 deletions(-)
 create mode 100644 drivers/cxl/core/ras_rch.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index b2930cc54f8b..b37f38d502d8 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
+cxl_core-$(CONFIG_CXL_RAS) += ras_rch.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc818de87ccc..724361195057 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -149,6 +149,9 @@ int cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
 void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+void cxl_dport_map_rch_aer(struct cxl_dport *dport);
+void cxl_disable_rch_root_ints(struct cxl_dport *dport);
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -164,14 +167,6 @@ static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras
 	return false;
 }
 static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
-#endif /* CONFIG_CXL_RAS */
-
-/* Restricted CXL Host specific RAS functions */
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport);
-void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
-#else
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e132fff80979..b838c59d7a3c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -632,121 +632,6 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-#endif
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
new file mode 100644
index 000000000000..ed58afd18ecc
--- /dev/null
+++ b/drivers/cxl/core/ras_rch.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/types.h>
+#include <linux/aer.h>
+#include "cxl.h"
+#include "core.h"
+#include "cxlmem.h"
+
+void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer =
+			devm_cxl_iomap_block(host, aer_phys,
+					     sizeof(struct aer_capability_regs));
+	}
+}
+
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	else
+		cxl_handle_ras(cxlds, dport->regs.ras);
+}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b7ea66382f3b..6eceefefb0e0 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -63,6 +63,7 @@ cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
 cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
+cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras_rch.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.34.1


