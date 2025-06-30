Return-Path: <linux-pci+bounces-31036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66127AED346
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABED3A8057
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CCB1C3BEB;
	Mon, 30 Jun 2025 04:16:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023101.outbound.protection.outlook.com [40.107.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A219E806;
	Mon, 30 Jun 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256976; cv=fail; b=gYMnc1MytgWWpV1WRoyVMdnRrY5YdrDhmOih7kHS8CLfWjfYg+EPmKl3DIuasMMyKuptJC8fEXMHefdFCkDYqsZp9CXFth6xEoQH1UyquicbNgPFUAkYlYhIAveqEco+J3lpHm0PR5zntoMqLtvxO4aJ6EE2FeVCJCNPvIKHHGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256976; c=relaxed/simple;
	bh=OoHhN9fD47nddlfVapB80SYIm4dlLTsLmsl9L0UJ1Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pilaVmTCtruoO3TevIux/gyowDxbyF/FjfV2wv0NMN1gPYpNIReTzBF8a2me60SYq6jbaFkbmo/pzvdg1MeAH/kujvZmCmIJEGwbQLWVnHsyfpMjs6gR6syvc9bstzcyMJwmh6/1UN/wwFZlJ7qPOBDQMv3jWErCCPfJmf38GXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoQVDC1hrqL7X6UY8R+8YraJ8luTLP6uZHb0u4pJkIIlUOP4moesW4CU7qZBfB5GT8U9i6qwyyU3ruWr2D9824YauMEOwFcxNZDblafepwLLnJ4utBGKRkiAtZBUS7L3WTt1slTcP0fRBcSkRmrRAHRcabEnfDsiJHppsVNmq8ZCS1upjTW9zM/tizAoZ1uQEJYhEvYPhu4umEzFyzurgtNyZyFgjhuR9RcrpY4x5Ao5f0oC6f+wTlXsFkyM4raxed+KhoNtP7n/vOfKBtQfR/UKw9o8Rnkl56bdGPbqC4P+kYlQ4EqjVoDQy/zniKAcCZ1NjBWqQmUAhV0LbHo+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wlUzx0c1hsYn5hm0tZ5jDMmU3OpNlAUapayTZKQ//s=;
 b=vzT7mhDydY9aTQ5UaFCQje11ImlUrp0gXHM2F1SbaVaNHnUKwqZZ3k7U6ZuKOGpeswwXfjn4SZ0okMbKYDg+1Eiq8XN4scqGyG7XGKjkKllKB463XCugcxJH+WTZv99PHPuKOE41wcVhS7Hty0g3OzFe7zi+38B2BjuFEMmASU9lPPmnteAagzdGPE+QKsYu/a+JTK5qgsuDq2tVqBDfuiCko67z7Q90xR47fXc9Xs9SD0xypTPbu/ptTEq5dQ7kwFMzSW2J0EVtliBuYcshF4AU5dYer8fyQjyppQ/6ufP9wREmqwHkt++wfj8x4h5GY3qr+FcJM9fwcVorJSabvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::15) by
 TYZPR06MB7144.apcprd06.prod.outlook.com (2603:1096:405:b3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Mon, 30 Jun 2025 04:16:08 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::b8) by SI2P153CA0012.outlook.office365.com
 (2603:1096:4:140::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Mon,
 30 Jun 2025 04:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9C19641604E4;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v5 04/14] PCI: cadence: Add register definitions for HPA(High Perf Architecture)
Date: Mon, 30 Jun 2025 12:15:51 +0800
Message-ID: <20250630041601.399921-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TYZPR06MB7144:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fae7522c-3890-483b-ebbc-08ddb78cd647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrXFbHNsRhf52Astcksa+SyrBR+683Ce8A2lDB08hn9USr7Xhm57/Nw3YvV3?=
 =?us-ascii?Q?2TLVNitn9ZFEI7SovXYigqWG6FaOsQl2wk2S3ZPZcFe5HYER43dvlBMA6F3O?=
 =?us-ascii?Q?mJZ94hdTs5HkpqoYy2R2wgKbNNutDgx6uFXjARJ9fmmvBoyIQLsiIRyAw2bE?=
 =?us-ascii?Q?4X/c38FwsGelxAz/0KAmB6RjW9QmDjZ8W82MOKJAIWnKCrC2SJwFShXmodX4?=
 =?us-ascii?Q?La9iJVQwVv9Ie6vw5ejZ89elhjR7sJAnZQaMx083AL7/xFsC5ID/oufjMr0p?=
 =?us-ascii?Q?X6G2+3Er1rRmApzzw0vI7NcfuOQIzLQYcGMKJI6OHkH5Z422i3nsnX2SyinA?=
 =?us-ascii?Q?EEbw2GFKZK69IM4pOoSsl9y5sy3lczLRfZlA5YctaLnFyfB9Mgf8GiX4REG8?=
 =?us-ascii?Q?TpfGu281vK+8KB3K2VDvQC3Rzt3eOs2bTTkABRcO/mEnRxQeBoX8FBLdJPFR?=
 =?us-ascii?Q?zRKslbUUoXsmuHrTvBFRDNxWLB/x5QqlRwY8OoW0AldwvESS4Rawgq8L5iLr?=
 =?us-ascii?Q?2jWePshEFZwLlYgJ/DOcpcq7KjlGci7IpfacTFpQeVhuhDb1CGKNs3ph4nwR?=
 =?us-ascii?Q?h2u3ftl5t9DWLO7Ij4hfDEq5W8/OEyXAzXfZgJFbvqIrWA8G/cWVs5vxflq8?=
 =?us-ascii?Q?xNJXD9ur12jJ+jFX6iLa4M+QvYbpYYdZLrBKQMa5dDTnDczpZXhpzXbtsGJE?=
 =?us-ascii?Q?ZgFSwFDoG4ySWR4BqIBc24dUqOfmQ6ux27jczgQOvG2VecPYz0BMV2uMowVK?=
 =?us-ascii?Q?DpfZbTyKeNyM6HdFYP5Uep9kD8YMAbaqm2Uk9T7uwAAABn54AjuGvcm2XVPg?=
 =?us-ascii?Q?Eg9dOuFFJAykWj+c/g4F+vIEi217HA1N8YkB6cHEbq4ZbT3i1RUrXsFszzwA?=
 =?us-ascii?Q?+fj8iIYQNW/4JMihq4LY06CM1OBcZ1noZ9xMyqTTy5RC5JNa/Nl0ouoBPSVc?=
 =?us-ascii?Q?SkrX9oHfPX71yxZ1/gkEbNveyWeSUplSkR35G7jCUHspEjlhx1RGx+XaONBf?=
 =?us-ascii?Q?CNTt2eLEIP9FNVdnV4ZGmWt8dCC7vIM1D4rCJ1NUzFyqDA56zQ7bt66bpo1o?=
 =?us-ascii?Q?BImiLdX2TAJajYbViODyyZDazYdK7+WasPgr4W3I8BzzbYC2nkoaQXI4aZJ4?=
 =?us-ascii?Q?lnBGtN9E9S+UG6itYlDQFVUyESrzLdJ9cAIzZpizprlzYFQtDLqgRk1XoYQ1?=
 =?us-ascii?Q?3MRquk4/DC15BjseFZMd9TjVDi/begudmlzSfBX07ScXOYGzO5rB67SaRLHg?=
 =?us-ascii?Q?SCnXLsO52/shdmvouvED4o+wNKJfgZem5LYJAcaZ+F9bxP4AnCRO+CmUDM3j?=
 =?us-ascii?Q?ljQfxrxDXE2ctX2GJK8sHA4p+hUq0ftLqjDnXYZYY961idKFQ8DCJqbLzzA/?=
 =?us-ascii?Q?HK15Ro1OKQl58HbxU+jAf4a21OSEFsZE5pRl0BKMz6ajjxVhwuA/H7x8ULIB?=
 =?us-ascii?Q?rnb2CixK0LFlNTaaZ25cpxWYL/7/gZ55qfqNKxqJoy/SBMwrrCm/4VbjPXx8?=
 =?us-ascii?Q?iJvByHfVZf+WUjabgMi1IilHxiMe8kZtywAF?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:07.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae7522c-3890-483b-ebbc-08ddb78cd647
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7144

From: Manikandan K Pillai <mpillai@cadence.com>

Add the register offsets and register definitions for HPA(High
Performance architecture) PCIe controllers from Cadence.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../cadence/pcie-cadence-hpa-regs.h           | 212 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-plat.c    |   4 -
 drivers/pci/controller/cadence/pcie-cadence.h | 121 ++++++++--
 3 files changed, 320 insertions(+), 17 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h

diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
new file mode 100644
index 000000000000..016144e2df81
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_HPA_REGS_H
+#define _PCIE_CADENCE_HPA_REGS_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/phy/phy.h>
+#include <linux/bitfield.h>
+
+/*
+ * HPA (High Performance Architecture) PCIe controller register
+ */
+#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
+/*
+ * Address Translation Registers(HPA)
+ */
+#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
+/*
+ * Root port register base address
+ */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define CDNS_PCIE_HPA_LM_ID			0x1420
+
+/*
+ * Endpoint Function BARs(HPA) Configuration Registers
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0C)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/*
+ * Endpoint Function Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02C0
+
+/*
+ * Root Complex BAR Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG                        0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Complex */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << ((bar) * 10))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
+#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Root Port Registers PCI config space(HPA) for root port function
+ */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r)            (0x1014 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)                (0x1008 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)        (0x100C + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)         (0x1018 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/*
+ * Region r AXI Region Base Address Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)     (0x1000 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1))
+
+/*
+ * Region r AXI Region Base Address Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)     (0x1004 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Root Port BAR Inbound PCIe to AXI Address Translation Register
+ */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)              (((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)              (0x04 + ((bar) * 0x0008))
+
+/*
+ * AXI link down register
+ */
+#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0               0x0400
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0             0x0420
+
+#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define CDNS_PCIE_HPA_MAX_OB        15
+
+/*
+ * Endpoint Function BAR Inbound PCIe to AXI Address Translation Register(HPA)
+ */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) (((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) (0x4 + ((fn) * 0x0040) + ((bar) * 0x0008))
+
+#endif /* _PCIE_CADENCE_HPA_REGS_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..e09f23427313 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -22,10 +22,6 @@ struct cdns_plat_pcie {
 	struct cdns_pcie        *pcie;
 };
 
-struct cdns_plat_pcie_of_data {
-	bool is_rc;
-};
-
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index b87fab47f2e7..5c0ea49551c8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -10,7 +10,9 @@
 #include <linux/pci.h>
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
+#include <linux/bitfield.h>
 #include "pcie-cadence-lga-regs.h"
+#include "pcie-cadence-hpa-regs.h"
 
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
@@ -25,6 +27,7 @@ struct cdns_pcie_rp_ib_bar {
 };
 
 struct cdns_pcie;
+struct cdns_pcie_rc;
 
 enum cdns_pcie_msg_routing {
 	/* Route to Root Complex */
@@ -46,6 +49,19 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+enum cdns_pcie_reg_bank {
+	REG_BANK_RP,
+	REG_BANK_IP_REG,
+	REG_BANK_IP_CFG_CTRL_REG,
+	REG_BANK_AXI_MASTER_COMMON,
+	REG_BANK_AXI_MASTER,
+	REG_BANK_AXI_SLAVE,
+	REG_BANK_AXI_HLS,
+	REG_BANK_AXI_RAS,
+	REG_BANK_AXI_DTI,
+	REG_BANKS_MAX,
+};
+
 struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
 	void	(*stop_link)(struct cdns_pcie *pcie);
@@ -53,6 +69,30 @@ struct cdns_pcie_ops {
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
 };
 
+/**
+ * struct cdns_plat_pcie_of_data - Register bank offset for a platform
+ * @is_rc: controller is a RC
+ * @ip_reg_bank_offset: ip register bank start offset
+ * @ip_cfg_ctrl_reg_offset: ip config control register start offset
+ * @axi_mstr_common_offset: AXI master common register start offset
+ * @axi_slave_offset: AXI slave start offset
+ * @axi_master_offset: AXI master start offset
+ * @axi_hls_offset: AXI HLS offset start
+ * @axi_ras_offset: AXI RAS offset
+ * @axi_dti_offset: AXI DTI offset
+ */
+struct cdns_plat_pcie_of_data {
+	u32 is_rc:1;
+	u32 ip_reg_bank_offset;
+	u32 ip_cfg_ctrl_reg_offset;
+	u32 axi_mstr_common_offset;
+	u32 axi_slave_offset;
+	u32 axi_master_offset;
+	u32 axi_hls_offset;
+	u32 axi_ras_offset;
+	u32 axi_dti_offset;
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -64,16 +104,18 @@ struct cdns_pcie_ops {
  * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
+ * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
  */
 struct cdns_pcie {
-	void __iomem		*reg_base;
-	struct resource		*mem_res;
-	struct device		*dev;
-	bool			is_rc;
-	int			phy_count;
-	struct phy		**phy;
-	struct device_link	**link;
-	const struct cdns_pcie_ops *ops;
+	void __iomem		             *reg_base;
+	struct resource		             *mem_res;
+	struct device		             *dev;
+	bool			             is_rc;
+	int			             phy_count;
+	struct phy		             **phy;
+	struct device_link	             **link;
+	const  struct cdns_pcie_ops          *ops;
+	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
 
 /**
@@ -151,6 +193,40 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
 
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
+{
+	u32 offset = 0x0;
+
+	switch (bank) {
+	case REG_BANK_IP_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_reg_bank_offset;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_cfg_ctrl_reg_offset;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset = pcie->cdns_pcie_reg_offsets->axi_mstr_common_offset;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset = pcie->cdns_pcie_reg_offsets->axi_master_offset;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset = pcie->cdns_pcie_reg_offsets->axi_slave_offset;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_hls_offset;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_ras_offset;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset = pcie->cdns_pcie_reg_offsets->axi_dti_offset;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
 
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
@@ -163,6 +239,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
+					enum cdns_pcie_reg_bank bank,
+					u32 reg,
+					u32 value)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	writel(value, pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
+				      enum cdns_pcie_reg_bank bank,
+				      u32 reg)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	return readl(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -333,19 +430,17 @@ static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 #endif
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
-
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-
 void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 						  u8 busnr, u8 fn,
 						  u32 r, u64 cpu_addr);
-
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
-int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
-int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+int  cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int  cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.49.0


