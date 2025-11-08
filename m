Return-Path: <linux-pci+bounces-40629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16126C42DB7
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1AE4E7133
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AC223DD6;
	Sat,  8 Nov 2025 14:03:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023122.outbound.protection.outlook.com [52.101.127.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D91C84DF;
	Sat,  8 Nov 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610597; cv=fail; b=BljC5AldyiflE9e2sh3pINbxGUziMPwExZFS6tBThWQA2x9NtC6MCHLrBFSodvrd+Dd5kTGHKthnE21qIdiO2j0LF8/ujaohGGZ9RIe0hIU7oXe7rBqV1KGDUeqAPb7LuyEoDcxWh11Rh+5kRMjX4sXREb7sHfd3u7+TUZMwiV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610597; c=relaxed/simple;
	bh=6Z2tCLaqRtU/A64N92e1QGxPjYAopLwmmFbUuWtNKp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjnFd8k6pzlY4HayS4nf5CLf1o8RvE9e5LadJ0G7awJCKkg/wi7eLnZ6jS2R04ah0PgZPyGNi0zlkdnZ3twd98XV11x/va16nPovlDLcbvN7sn6P3F2wTpAtNB3eu0IyPlkvIWmi866Jj8ogombvUwYPuJgbSliAv8oG4nHbMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9Rf8ZRpgx/oR03bdHTCYIsRbA7MwTFY/zV+zoKfhW/PA0Q0OFK2T6aK580exJ82goFXmpgfjfyar8AX5VJAv3I8tQiKpCnKyjsxgD2Lc7CiaSC5hIHhZyZdWK1kMS08U0LzNjgWs2MF3Etb1tMxFgv+X2Pj/349xY5sjoySvqLmu2VHliJ0Wk5F517jipxicdl4uh4+jyuLxthNyplJ97eUZlfbn9OW5/fvsJyFBqc1kpHmdnLRk72URKjEUwe8OvC9JWcjL9s/5ATP3l7JJVqLQ9a22pfoUH87+pHVRkZ/4D27GPYUuINPpJvL1F1igloWHLfjGqrs1DmwIA0Mlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCGeJVV8MJnJQrlgf3jHZM9fzgyaLwApK73vrrs6Ty0=;
 b=Y7vexnoFraBOt/I106iw57dhEdzjcfc6LQj7JuF55Do0917m42rhokkuf0NgZxMHD02HKCmgiPDAy/fpT/LCVSXs7IAbgpxc/MqDyVVlXvE1SVc4ddlAWwypZ+bhPqCGKM/k2IRZcgrK5B6LpliPVunE2wsNXxBJuI/4qw1wH1XUnKPHQxxCaENlL9mW21da9E1m5HQgTbTIj+ScqP46Dd3Yn8MZeAX6fUHPhp2ycj0e6uTqjbs8QgDQxdXiemJsqKSgDYHU3kxAC9NCL00IhLBnJI+Flks9R1sTid0RNN4tEISPYnlL7V3+a7Jnq3kFInkaO42IMI/GsTCFwwYSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) by
 KL1PR06MB6759.apcprd06.prod.outlook.com (2603:1096:820:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:03:08 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:ac:cafe::bc) by SG2PR06CA0249.outlook.office365.com
 (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:06 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DDEE5400CA08;
	Sat,  8 Nov 2025 22:03:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 02/10] PCI: cadence: Split PCIe controller header file
Date: Sat,  8 Nov 2025 22:02:57 +0800
Message-ID: <20251108140305.1120117-3-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR06MB6759:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b8c64af3-cea3-4ce8-2217-08de1ecf8ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KMW0jeHqOyGvCqO7B3Ve61Cdh1zN3z4ohJ6bCOQt4iapWh3iccpYmaIzshX9?=
 =?us-ascii?Q?rrFXuqNtRu2s0G2ayLccIqYqhKXgNI317/i3HTLCKsZ4L4rdT3mNMhF7dTfZ?=
 =?us-ascii?Q?U8JNccJXeVQqJCofLvcoV9KnZpXQxMlQJv6s6yuK2Dm7JvQMDfYReyUiUzjr?=
 =?us-ascii?Q?c4zongpbF0BS7lFH8zf02USJLlKI44GrBVRGf3Zcx7YBmwzCbPRuSKMkzLWv?=
 =?us-ascii?Q?p5G7RKKK7Sx8dUQrpZcsjbIJng0/K8ERzxM94Q3X0WKL0Oxjgyt1jKCrSKE5?=
 =?us-ascii?Q?ZNDToz4Kwcwp5xYbJuY0SJzQWRJOBIxZZxEiLdnvB0FEBhkt3e1e2LYLAUzT?=
 =?us-ascii?Q?+u1wUH7allvFZ/Et1HhYDHNhrLLADXLtzcmA4Smu9MPVKpeYcHyyZOQvvpIR?=
 =?us-ascii?Q?QV5qECdBGO6JE5Ho5FHnm/HEArqRJIxePF29nDd9tTgLeCOwEos7sO7fNUUq?=
 =?us-ascii?Q?Kit+xKoPA5L4DbqTdOFjxj+hxudh4hBxz31zc111EFr6xqpgSBSzAcC4E5oU?=
 =?us-ascii?Q?BGpWPXptca1AbMmREZm72oR0k6+wBHNRzwYYHmNB5WQL4d2+4roAfJSLgYqX?=
 =?us-ascii?Q?lM6tcQaMKotdc3iHsDDYXWdKo/Ve0XoesaQfLHZYcTCwpvYHwQDJTWynn5DC?=
 =?us-ascii?Q?yWJm+Op8tEkXx9CXYRe9a+tgJL4Z4S+ayEfcW08WKsM+L58SI2+9gdJUwz0N?=
 =?us-ascii?Q?UthaIdImrr2EOJitSZNcUKmizAMqkR/CBXfmkhapeThvWS55AKft1XKMS3KJ?=
 =?us-ascii?Q?h40jqaU4L5HXgztAF2/H4XpE724R+Qr80YFI8itTCurv6goNX4bqfVpPQHX6?=
 =?us-ascii?Q?81smjkTOfY1fquUOjdarcXxgeVNE5a7oGfc2E159FTd3XuLduShhqGkDtNTc?=
 =?us-ascii?Q?jrukO/3IjMIkmsOnUtddxAhccjmphm6dcINILnj+IqGsJWWycvtkoL0Zo/+A?=
 =?us-ascii?Q?Ko26iNtsf4VjFMKnjb+blVEX0bgJnWbmRrNje1vBig4WPdhDk8NO/fkCYZP8?=
 =?us-ascii?Q?zTpPU+XMvCpMU2JCVFYYydkQz/27yOJJVe/TlywMjlJ5tVsK7XUcuhynH1JB?=
 =?us-ascii?Q?0xCiTAKhqCb+ZuZHN3fp6rVZMGlF8GMupH1iX0uRE8wnciUmT8MnfnzGCbD2?=
 =?us-ascii?Q?blwPDX7MUAtq0fUcSlCW+a5DY0swoPT0y/dT25++G9Ghq4wv435LVZNQVEF8?=
 =?us-ascii?Q?ySm/OvTQfYPE5Rjp+AwKdUCUF+k3cXh10/iZaOS6rqBJW8Mkh2zZ/2AQpujU?=
 =?us-ascii?Q?zZQj28frJ6pLV3n1LKr1iexGwn4Emt0NCmzJZpE+96Jywfo+y0AEbxdtnFu9?=
 =?us-ascii?Q?HnoyFHwJlb41FaNhbAcWqk3L2OzMd2TxMneONPNX/heESs1Yat2AWbWnn/xo?=
 =?us-ascii?Q?VL1l/btzvsCkALoWfsZ06sGLfZy1zahYSsUCKxcAiW0AJBKeMNa/Szsstjzv?=
 =?us-ascii?Q?POrocxdUE+akHgc16nYPAirEGT9L7FIqUmsCAv/8O53tWQ3F23g9eZUxrNvM?=
 =?us-ascii?Q?c68rLA9K+OXpT79Y+/1r6sDBScClnVxNuUgC4juCga3QXK/vRh5BuH5j5vpL?=
 =?us-ascii?Q?WjlTFlSJBs5BzcO+O24=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:06.6353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c64af3-cea3-4ce8-2217-08de1ecf8ac0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6759

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe header file by moving the Legacy (LGA)
controller register definitions to a separate header file for
support of next generation PCIe controller architecture.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../cadence/pcie-cadence-lga-regs.h           | 230 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 222 +----------------
 2 files changed, 232 insertions(+), 220 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h

diff --git a/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
new file mode 100644
index 000000000000..857b2140c5d2
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence PCIe controller driver.
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
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
index e2a853d2c0ab..0b8ba4ed5913 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -7,211 +7,11 @@
 #define _PCIE_CADENCE_H
 
 #include <linux/kernel.h>
+#include <linux/module.h>
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
@@ -220,29 +20,11 @@ enum cdns_pcie_rp_bar {
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
 
 struct cdns_pcie_ops {
-- 
2.49.0


