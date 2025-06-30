Return-Path: <linux-pci+bounces-31041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916DAED34D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C9C3B2546
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693A1E1DE5;
	Mon, 30 Jun 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023092.outbound.protection.outlook.com [40.107.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD519F137;
	Mon, 30 Jun 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256977; cv=fail; b=heFN0NtnCEAmNbLpBYnTETvEvM04sRcTzFTotsJuA0VsyeiIamVHOjl8cXEN3wvdkhPGPRmzOwGJhwbic6pdM4EcvzWvbpJW8oHxtnIxSjFCQZVf03PxbO2qPR0zHJlCc1SsDR8iYs/m1ZqJqLTLL+U0vmo1WAdcrcz85cb+9WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256977; c=relaxed/simple;
	bh=7BdFoaqzczxV2qGqD2nZ0n3jXjyxa1na5Q1YyF099us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Gwik/PCh3ymfI4yovMyH6wQCArpBvNCcDuKL7CU/3zVgdWm6/rLZU+vxTOJiFkS5rLvt3dKTbcz8B4PrfqS+EjBNbdRwkTOO2v0nCGQ2vLQm2QbiNKV8xe7Clrg/QaRdTAMCYwLxArloK/qy9qK3Sk8JsvvIbgj3/hngRIWKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV5DE0hA/l0tNIDEBJQ412uJEZC/jgHbr4o/WxDEq64YnFMvhzss+DB5lwFaVB2AaxbkYdErgdR/AKJh2DveOV+kA8ZCPZCpDrtoiMNuH3zgXjhfk0L/GDZYyy7NaBMCr+7XZETQIOEZsDISoQU+rhZQBMxJRMqj6+tlecA87RCENVzaVV/u2f4VBPjPThMgJVlIX0Tw1xZK9OpUBa4VSmYoP8MTR0WwJwK1fLzyPEr16zOWeZg1axbUeX93o712fnpjQ6OPImOgBWWph6BP7E9QUiPI/ORrbIWXvCJH/kwyBD8K7tetERRnwZlTSrEPJBu2emUIr5DN0tRY+zUp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fLVX8pOx9Wb4y2xQ97itnfigh87l3HUPueRJ9n6Bj4=;
 b=syNU0rWjKw0kFIqJ3dioATA/MqxZfgGkqvnb6HdjsBNIzuajM1ozTM6nOCu6DACn5UPoaoOHLs87F8WgPXvoe77glhvwOQSCDEKmHoVXl90bFGB3/VbUIxhZd3COG2ttuSxlfY9l6ts8y3DdZYRzUV9qludZVc41MUPv5uoPfk1dwzENEL3ieWU5rtkyfe5nlK1+zcx77guJFw/6BCYUJbZfazgGfffDWUBAgKGsokkdwJupauLQPQ0Jp0DAf6zdLDhKMbN4vHvXUnZFrCroSa+mhnnsJfjVKzu8JWJ4W03cGmi6/axOSVcBu7Pr3mZyKbx738Qe8iUZq5golhWkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0203.jpnprd01.prod.outlook.com (2603:1096:405:7a::12)
 by OSQPR06MB7277.apcprd06.prod.outlook.com (2603:1096:604:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 04:16:08 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:405:7a:cafe::b7) by TYCPR01CA0203.outlook.office365.com
 (2603:1096:405:7a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.28 via Frontend Transport; Mon,
 30 Jun 2025 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 889D241604E3;
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
Subject: [PATCH v5 03/14] PCI: cadence: Split PCIe controller header file
Date: Mon, 30 Jun 2025 12:15:50 +0800
Message-ID: <20250630041601.399921-4-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|OSQPR06MB7277:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f30615dd-4305-4f74-00be-08ddb78cd66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKY7FhdNYbN+a65t1WTXDcoik1iP8jvvm3C4NWDlMGwbNa1AJx+yANeXvnOC?=
 =?us-ascii?Q?YG+ZEN+pUMGt6EAuwMFvMETsPrPOmCuqZkSC9VmyoroskPR5abdgQIBzO65R?=
 =?us-ascii?Q?qjQpM1BAnMB2kLDkyE3BQeb1P980JODKHZ2kZITw8oO7LeL0t6sEUEOQOrNH?=
 =?us-ascii?Q?9XhsK6/uRjodGIoAdzW418q82lzjN21xgyCFL7CBH8zvXdjKP4vBlvXUN1Au?=
 =?us-ascii?Q?XR3AFw8OU8GWta24hzgpO1mrX+oRrwtWW2BX9n/bXF8WGv1aD/ANc+HQ6Mw6?=
 =?us-ascii?Q?rzo5ViNOlMmXpq4gQOmBmwxC/kTo7LhKc2y7IDRJA0X5pkBq9TfQA0oj0BJs?=
 =?us-ascii?Q?9uobVZ0zonsypQ6d3ptY/BtI2t58tBYGyJ3rR0Q1q/ogVLCOHafRMu+Ut9ZL?=
 =?us-ascii?Q?eVURhdtKVfADxGpYhBBZpnxZtH0bve4FewuaGIlF4d5x0zcrYQ47dIfDyaU8?=
 =?us-ascii?Q?EsMIIpTcqJlNOBRW2CaqYXaMYNxHk7STm99msD94EgZzEyxmLIrx1Xt53JqA?=
 =?us-ascii?Q?/0j9zVo3hJSIrk65lIwe1VXWH5seJU3ryjI8+MbfHgqiZ5GmdCXey60wlQEd?=
 =?us-ascii?Q?FktCEzOYUnCt5BB7hQ0gcPa08VL+jOMrRMK6QRHq8DxxGpsJD0VdSdRzcIWC?=
 =?us-ascii?Q?YI9+ZRurUzgRwhu94cx0rS82iE0T5+EdNLbQPx9zTwZxmJvUSmpNxgqPq9ds?=
 =?us-ascii?Q?JMUT7CBsD62WS5ESEKY6pCGcuLFUtjEHMOpl+hbvEpo/ZzYAlfLW8lBxfds1?=
 =?us-ascii?Q?ZtjIO8OiwHA5OhvcH+AJFCgkr7u8fi7xdYeezgQt0IoHJR9O252ZIlUybUhI?=
 =?us-ascii?Q?1rB3pCHZcjTO0O8sCUKLJsZUUKYTUKm2lJRlCzXGiR4BzuxOwuK1uLSPUhuT?=
 =?us-ascii?Q?sjoq58hs0DWoRVvvB5zRSdzp3x8y51S8CYkgyf6E3U6JbebmsdnfPjshVHbk?=
 =?us-ascii?Q?FnA+i48XA33Af1OO7NmrInrUHvpPpMGc8MLAa2Ob82p02ZpW0U3hlAUgJlzs?=
 =?us-ascii?Q?FCLTUqIP1sEVjEy7uT3buHrH1Yi+tAklAvkFBPctgZPRuKtsSav8BehB9fMv?=
 =?us-ascii?Q?nW50+NudvekB27+fGbWCHanZRyG+5U4KKYV3MtQnkSqIIONZTOKi7H5eTrgB?=
 =?us-ascii?Q?PWTSuWRiGJreE5PR5xxQFmPZ+gRkeWhUC9CbaXHWA2/AyM9h9Gcl4S0TBf9f?=
 =?us-ascii?Q?a1ScmRvgSjaYdetnZe2pHnliypMw1bD/6O4KtPHifmODDf3rvBuL6I/PUkw9?=
 =?us-ascii?Q?I2EQuwyCxxcmoZigTAKkgYe3jdCmNwwrWNMjRub8dKjitJKsV+Qga2eK20+B?=
 =?us-ascii?Q?BqObJgEM2V7Z87jbr0HUoPan7qfSr4kvqT+isNoPVfXwIBXPdFGh/MX5OnIr?=
 =?us-ascii?Q?aOt/chn5ARxvUrfStUyuxWMXriILlA0ZPl2iZPzYduJJNqjPBhfoNUF8L0Sz?=
 =?us-ascii?Q?21GYcMO1gJjQg5dvzaWLFibtiUZ5VzGYTk8ZFpuLatG6Es+1+flpwYR9html?=
 =?us-ascii?Q?NMkTR8hQM/fkFabYY7NMslXrYJClGeeMQIhj?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:07.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30615dd-4305-4f74-00be-08ddb78cd66a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7277

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe header file by moving the Legacy(LGA)
controller register definitions to a separate header file.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../cadence/pcie-cadence-lga-regs.h           | 228 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 226 +----------------
 2 files changed, 229 insertions(+), 225 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h

diff --git a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
new file mode 100644
index 000000000000..0e88beb77292
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_LGA_REGS_H
+#define _PCIE_CADENCE_LGA_REGS_H
+
+#include <linux/bitfield.h>
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+/* Local Management Registers */
+#define CDNS_PCIE_LM_BASE	0x00100000
+
+/* Vendor ID Register */
+#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
+#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
+#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
+#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
+	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
+#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
+#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
+#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
+	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
+
+/* Root Port Requester ID Register */
+#define  CDNS_PCIE_LM_RP_RID		(CDNS_PCIE_LM_BASE + 0x0228)
+#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
+#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
+#define  CDNS_PCIE_LM_RP_RID_(rid) \
+	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
+
+/* Endpoint Bus and Device Number Register */
+#define  CDNS_PCIE_LM_EP_ID		(CDNS_PCIE_LM_BASE + 0x022C)
+#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
+#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
+#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
+#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
+
+/* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0280 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0284 + (fn) * 0x0008)
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
+	(GENMASK(4, 0) << ((b) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << ((b) * 8)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
+	(GENMASK(7, 5) << ((b) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02C0)
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
+
+/* BAR control values applicable to both Endpoint Function and Root Complex */
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
+
+#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
+					(((aperture) - 2) << ((bar) * 8))
+
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL		(CDNS_PCIE_LM_BASE + 0x0DA8)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Endpoint Function Registers (PCI configuration space for endpoint functions)
+ */
+#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+
+#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
+#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xB0
+#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xC0
+#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
+
+/* Endpoint PF Registers */
+#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
+#define CDNS_PCIE_ARI_CAP_NFN_MASK			GENMASK(15, 8)
+
+/* Root Port Registers (PCI configuration space for the root port function) */
+#define CDNS_PCIE_RP_BASE	0x00200000
+#define CDNS_PCIE_RP_CAP_OFFSET 0xC0
+
+/* Address Translation Registers */
+#define CDNS_PCIE_AT_BASE	0x00400000
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1F) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1F) * 0x0020)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1F) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xA
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xB
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xC
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xD
+/* Bit 23 MUST be set in RC mode. */
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
+	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
+	(CDNS_PCIE_AT_BASE + 0x000C + ((r) & 0x1F) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
+	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1F) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x001C + ((r) & 0x1F) * 0x0020)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
+
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
+/* LTSSM Capabilities register */
+#define CDNS_PCIE_LTSSM_CONTROL_CAP		(CDNS_PCIE_LM_BASE + 0x0054)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK	GENMASK(2, 1)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
+#define CDNS_PCIE_RP_MAX_IB	0x3
+#define CDNS_PCIE_MAX_OB	32
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
+
+/* Normal/Vendor specific message access: offset inside some outbound region */
+#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
+#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
+	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
+#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
+#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
+	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
+#define CDNS_PCIE_MSG_NO_DATA                   BIT(16)
+
+#endif /* _PCIE_CADENCE_LGA_REGS_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a149845d341a..b87fab47f2e7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -10,213 +10,7 @@
 #include <linux/pci.h>
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
-
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES	10
-#define LINK_WAIT_USLEEP_MIN	90000
-#define LINK_WAIT_USLEEP_MAX	100000
-
-/*
- * Local Management Registers
- */
-#define CDNS_PCIE_LM_BASE	0x00100000
-
-/* Vendor ID Register */
-#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
-#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
-#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
-#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
-	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
-#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
-#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
-#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
-	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
-
-/* Root Port Requester ID Register */
-#define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
-#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
-#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
-#define  CDNS_PCIE_LM_RP_RID_(rid) \
-	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
-
-/* Endpoint Bus and Device Number Register */
-#define CDNS_PCIE_LM_EP_ID	(CDNS_PCIE_LM_BASE + 0x022c)
-#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
-#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
-#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
-#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
-
-/* Endpoint Function f BAR b Configuration Registers */
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
-	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn))
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn) \
-	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn))
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0280 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0284 + (fn) * 0x0008)
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
-	(GENMASK(4, 0) << ((b) * 8))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
-	(((a) << ((b) * 8)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
-	(GENMASK(7, 5) << ((b) * 8))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
-	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
-
-/* Endpoint Function Configuration Register */
-#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
-
-/* Root Complex BAR Configuration Register */
-#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
-	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
-	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
-	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
-	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
-
-/* BAR control values applicable to both Endpoint Function and Root Complex */
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
-
-#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
-	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
-	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
-					(((aperture) - 2) << ((bar) * 8))
-
-/* PTM Control Register */
-#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
-#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
-
-/*
- * Endpoint Function Registers (PCI configuration space for endpoint functions)
- */
-#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
-
-#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
-#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
-#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
-#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
-
-/*
- * Endpoint PF Registers
- */
-#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
-#define CDNS_PCIE_ARI_CAP_NFN_MASK			GENMASK(15, 8)
-
-/*
- * Root Port Registers (PCI configuration space for the root port function)
- */
-#define CDNS_PCIE_RP_BASE	0x00200000
-#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
-
-/*
- * Address Translation Registers
- */
-#define CDNS_PCIE_AT_BASE	0x00400000
-
-/* Region r Outbound AXI to PCIe Address Translation Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
-	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
-	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
-
-/* Region r Outbound AXI to PCIe Address Translation Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
-	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
-
-/* Region r Outbound PCIe Descriptor Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xc
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xd
-/* Bit 23 MUST be set in RC mode. */
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
-	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
-
-/* Region r Outbound PCIe Descriptor Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
-	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
-#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
-	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
-
-/* Region r AXI Region Base Address Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
-
-/* Region r AXI Region Base Address Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
-	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
-
-/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
-#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
-	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
-#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
-#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
-	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
-
-/* AXI link down register */
-#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
-
-/* LTSSM Capabilities register */
-#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x0054)
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
-	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
-	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+#include "pcie-cadence-lga-regs.h"
 
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
@@ -225,29 +19,11 @@ enum cdns_pcie_rp_bar {
 	RP_NO_BAR
 };
 
-#define CDNS_PCIE_RP_MAX_IB	0x3
-#define CDNS_PCIE_MAX_OB	32
-
 struct cdns_pcie_rp_ib_bar {
 	u64 size;
 	bool free;
 };
 
-/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
-#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
-	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
-#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
-
-/* Normal/Vendor specific message access: offset inside some outbound region */
-#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
-#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
-	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
-#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
-#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
-	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_DATA			BIT(16)
-
 struct cdns_pcie;
 
 enum cdns_pcie_msg_routing {
-- 
2.49.0


