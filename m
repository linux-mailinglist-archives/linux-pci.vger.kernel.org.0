Return-Path: <linux-pci+bounces-34282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF14B2C260
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39743A8720
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2563314DC;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022087.outbound.protection.outlook.com [40.107.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187827A44A;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=ORlZTPlK0gVOUVt2xhSFbmO3NLVnbG3l2CqTBqjiAtUKP4PghlFCKazxhXE2ezL5wRB3eJ8i4vDgQnVL3nt58z6ZlY9Hkqddv03rldV3ZMmUxDFanclo5Z6tP9nsNCXkXl8QItnctVUGALKwxLDbwHK/t3U6gYXAUzmtsGKBAuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=M8w9I73gwQYxmrKocew0ITnd02v6b/AvLsdCfzeNgdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDvqx+69egWIxR0gSVJqSF6Yv1elewl87f8BTFz6BQ3DhPV13n/g38c/eEGqDrmRli1Ujr/DxrB4bEjXdRUZbL5pDJ6cNBihBLe/iPw3xfGllA+NU2sN9mFUGbPmArvj5eUjB8fDUpo6IRp9813dTSIEmYTKp/qD3r2yCo7C8lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKdmVO2+Q4SWnVXOzSmAGXkavmb3ivy933qy77/8LTOIpvgO1gOD3Yzcfl/BEYFx3fZ7NguRCt3xHUpnp66M4pRHCuN0rhpu+OXXiTunWU9Otk4JwE1etIs1WfKInNWHxdI1MO/ssDBvw/AGA/Hu5NcJhysWhVGCx//8tRO9ICm/PlR2c7VJ6meXam14Z44vcskGhcWo8gj0I25AT8c6WAbY/8TOGM+RNGmCBnHca7/GtsFdSYc5UJxEIpwUfHOVkDt5Ruj4KCFGlQYKBauXwJ67llqRVwUXitKyyS1zrzjP5R/R3H0A3AADigWhYN2z5LfJcVTnpSWbKw6WSvf20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFsvofAejsU6k0x5nD1boLjXv2eHrvY3f8+3JDrIpSU=;
 b=aazo7eFIILKo3bsE6mMv76DxRMz0giytg2WPBdbZHyrTEO51yN5WqTiMyIQIfmbfNUpIOYy3KNXvM555W68jwryXbmTltGmAnEs7uUXCTsfSVK2JRKLU/benyQ2Lx49PhIfniLR/ybrLOIZKAYP55gB4Ndq0hIJfXNhRAkulDEUyy2OWzpktzPmbvu3a5uGycy524nTwIHVAH83sr/qD8iebV/aDiXPNeD6Jvc7PU9vzw93s7Upm27qv/Mqmgg5nq6tRn7m2LZLd2Tvy3JjqL/YnjSbCUXnDePdUhrIwR7K2ccK5zxjHOEb7Ho5jRCpDQYstdIJaUkEqY5mD/Cu1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0208.apcprd04.prod.outlook.com (2603:1096:4:187::10)
 by SEZPR06MB7188.apcprd06.prod.outlook.com (2603:1096:101:233::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::f6) by SG2PR04CA0208.outlook.office365.com
 (2603:1096:4:187::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 11:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 84ECC41604E5;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 02/15] PCI: cadence: Split PCIe controller header file
Date: Tue, 19 Aug 2025 19:52:26 +0800
Message-ID: <20250819115239.4170604-3-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR06MB7188:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09ee9add-1a54-41fe-d4cd-08dddf173fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+UOevznaXd6Bb1RHE4xrQrI+BwwarnaTiTB8e6c+HoaTUzNn9Av7UIbaNj4?=
 =?us-ascii?Q?mR4MyXShnooMIa08d6lcHrdCKlCOW5DhUTbRWGePk5JrPPx3teFqHAMIQH4X?=
 =?us-ascii?Q?xEzIzpJMhzNEtoE22Z3B2ocMNcXPJptZgUvIXbWEQ3g0AbSvaR88Oc2QzYnq?=
 =?us-ascii?Q?Q4ZJbPNoO3SBBeuCZ0h0hVs5CbwPNv6+XYF/FGsIHFi119FHM9rXO36wMLTs?=
 =?us-ascii?Q?1DPGg06EMFSHEV4AsTg4R8pbpp4zDz5J4G1/oaZEnsWwS+1RfPaVtUuliiiK?=
 =?us-ascii?Q?9aGeolFUdIvpV4aBbpOn+63CUMmQCzmQjsgYT485u69COxfEsISTMV4ItyOd?=
 =?us-ascii?Q?/PhTh6yJfLnniCmF5Uhvu4A84RANWX70IeuWAyDDBgUn/ULudJIg4eVhDLrq?=
 =?us-ascii?Q?T1kI2wDjX3iAH9qcwXVT/6bd2YlAlv6fywNo8WHGNZ39wc3X4JfF7q2itKf4?=
 =?us-ascii?Q?kejLSYK3IqPhQ99z46cMbJTHgCu7zUqbKvR+INAtvEziy/L0CoQECTZwCAH4?=
 =?us-ascii?Q?hlahRnNaIsR2gpXcHWaCEqho/fQsXnQg7uC6/5EEyXxRNutlm++RJCmKISh6?=
 =?us-ascii?Q?cRY9cKZDRDbhLqT/wLOeqWVgWB2ENgn3iqxAqTn02Z1pVbrqQ794SkaLx0By?=
 =?us-ascii?Q?/menwc74o8HENmRoXYTQY2cA80JZStFZqtDB2jNNvpCcmxBQb17WtvASYQPr?=
 =?us-ascii?Q?UFQ0iElhoiZrf3ymw04tedG2gVPQGYFdwCrUd5kd553tz9Jd7fgS6qmNvvJg?=
 =?us-ascii?Q?ZIHfcfvPEocVMOPxUIT5Plk5gGkb75yH5emgMBrf8G1fNcRHjQco/+V4BlhL?=
 =?us-ascii?Q?/XoYnQEqAekSlBckT26+w+2P/3Mm+c4d2+p1Ao6kgiPpIgopCok+ayO2sGX5?=
 =?us-ascii?Q?KhuI8ud9a57CEl3VnGCHOoxApgzhb5h0xucWlqaRe8swP+m3PFr/blp1h1lw?=
 =?us-ascii?Q?4vVsZJ9TXHr5ro1DtIJJjq4+rV4F8YtZA3iOgRXvtIdGKHKHwJBJ2pn+ZgqG?=
 =?us-ascii?Q?4TKl3+ilK8vCof/Msdez7ahXy4/gSqABZGU827/Xu/ESJWbcGaPQAVtTG/aE?=
 =?us-ascii?Q?Rz2AxgiGXJLG7EuOYrtZ5PbrtTkpNOCB0BhklLcFDGAGSglk1cLfLORli+gc?=
 =?us-ascii?Q?wfHyXg7xs6oayIeduR+xKcNoUJJhTsMZtmf91sFrAoKK3qg8Itl2TuQNMaeP?=
 =?us-ascii?Q?psSE6WHEDMtlzAjpAZx3hwx5yeHlqcvvxMvjHzDhmasE9Yzp41BAiC/KOhV8?=
 =?us-ascii?Q?BZKqOggO92uGqSOH9e1x+1MgOMnPWSTPFeiSPghx211f2Cif4D/fvvyJZArv?=
 =?us-ascii?Q?8af5uq7dEd6i6vAxbudbNUuegsPk3r7oxOQjY1vEZTtpXJxlseGQWL43AW9N?=
 =?us-ascii?Q?DWYS3e2HL7PPK/zoPR7HgrtFp+hKsPLHqANPTy0L/b0m9TJvdng3LuBjqh6o?=
 =?us-ascii?Q?XjgfSqmfmZ7tFrT4XVQJjJz+/RzQSWHDFhDMWeTTh4LwJkdy21njgX7iBlwM?=
 =?us-ascii?Q?wsMaw1svCVY7vGPy1U6dXyHmuFbvbqLHOh3f?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee9add-1a54-41fe-d4cd-08dddf173fc3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7188

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe header file by moving the Legacy (LGA)
controller register definitions to a separate header file for
support of next generation PCIe controller architecture.

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
index 000000000000..afff0c35828a
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
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
index 1d81c4bf6c6d..79df86117fde 100644
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
 
 struct cdns_pcie_ops {
-- 
2.49.0


