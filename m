Return-Path: <linux-pci+bounces-35250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0456B3DE3B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94F2F4E21A4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6ED30F526;
	Mon,  1 Sep 2025 09:21:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023124.outbound.protection.outlook.com [40.107.44.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6D2E0417;
	Mon,  1 Sep 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718475; cv=fail; b=jbm2TQh0Jhrpa82pjtBpujYgmWas3kBZH66WMJRZLh3PrGHC6DBbpWBvCsjIAaj2+dv3yKU9xpD5JiNjCmWxHhDaBQYWScCJQbCcaUkZYVfN9c5EjEybH1dvDuk0hcFfZd9KtnjgepCObob6PzM+nZee3q+bbQ5oQ5X+R5APO+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718475; c=relaxed/simple;
	bh=yAeiXg1vbd9S3sldKCe716s/N6pWewTfyhuj7/p4Vag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSgjgeWuFEG+yqbaPB+LuO1PifkLB2MpCBIztPE9DTVf8sby/12Agy3cBO3EtzXch3HMGP6gPAL8dWhSxdHpchefxj4Ux5QsgX698Z9BwCRwruxJBIpYU4uOzlAg4vbc1z71SWyPli3cDOPKt/mZWQOaS8Ma4wjeG87SXRdBpLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8YASLAotN2xd3KXdgw38QGzLawIzkweM3IJAPItvc/ly61dwlwIsJUtZWO7hdDJ7hfLRMHMLyEA704OhhnajAWvBT2m2OgtQAyNBt7pKWFq4WpZNM2WBy4zwz/BxjJ5/5ifhaIITGXEEZZpbQKWdtQOjes1kV+92YB3kd3eYwAr+z3AfuQF89UzDWIKswlv4bMF1R+zCeMwZTcibzAKpuka10DYoYXP7+VecwmBAjKDSEcOu7pbuO6tomChYtR7uo+/KDV44De5aEmXfoUIuYXs0Lk3Dhx3rwYtys/4IJLMFoorhw7IBJdtC/VqN+RrAdZD8eYdILH3TPJM9G0XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuwjgsnJzALT/J4lDTFJu3jFIH3CoV8OZ6qHyPgF7XA=;
 b=dxweV7UniFIUypB193y8q8V6FXThlNKS9qv3/2vXhBxauaxWbLD9gUAnLrpAMlwr81hDQSiyvmHQd6LrBpiz9/80+3wGMSLBmpCuftIfh3b99nuQjfMoKA79YqsnM5GN9Gaxa3QsGCzKA7ZwqxeKydoa8zdRaL+7jKDl5ihJLprgGUSx8RGmEPDsWs8VRM6oXgSd4ju1uhcIYPixpgGmxI2iJhSDGccf4vXsJON2JDftZxzbXDeQqIQI/CHZY1jhfZ4b/lkR+AFfFrtFzAnAj4DDfQFCpb5bYmyiv03JiElR/ru8EpRlDupag+Ykr1tbO0pMsuJKxN/XWaspuYCr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OSTP286CA0100.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::8)
 by JH0PR06MB6452.apcprd06.prod.outlook.com (2603:1096:990:2c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 09:21:07 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:219:cafe::52) by OSTP286CA0100.outlook.office365.com
 (2603:1096:604:219::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:06 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id ED47E41C0152;
	Mon,  1 Sep 2025 17:21:04 +0800 (CST)
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
Subject: [PATCH v9 02/14] PCI: cadence: Split PCIe controller header file
Date: Mon,  1 Sep 2025 17:20:40 +0800
Message-ID: <20250901092052.4051018-3-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|JH0PR06MB6452:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: faea420f-1fe3-4b26-5f9f-08dde938e13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oUfpyDP4Uw2rCmeljAwC6mjEyh6O6DQt1Lr+zY3uCTDwbOktk0z7It2dpiF?=
 =?us-ascii?Q?pML9KjVVT6ZdmRCN+NuOss2z4VO8VBfDDdFm8KXW63Oh5+EJc41tGB/98DD8?=
 =?us-ascii?Q?8huxwnZm2WJtLAF2GNs+fNAFewLNyNr619Oa+9B3SMy2h7pht0JeVtTF8oZQ?=
 =?us-ascii?Q?DM0T5GvIvCAxCvBhQCr35NSiyZ4nQKPA8eX6Z2mJ1+7L8JMvVyhUGI0EkztZ?=
 =?us-ascii?Q?7OxOGJDM9ngnk/ZVuN8vqeBN20806M569Dnx2CFC7GuqcEnLUx3KXIaewY5V?=
 =?us-ascii?Q?upASgMImNJAny1+BWOifv6Y3Ngm2cCK3mZW+PxOcKPEw7k5knlha8nFksBQf?=
 =?us-ascii?Q?0AvIhZB2IQRG8vWUBBEJRzwGpsOliJxv96u+EOwarANz0cCrQ9mxZs6ltuUq?=
 =?us-ascii?Q?7dYWKZc+RZZCL9QgdepvosDh7wYFRebGPc0w+V2zmls5iImpqueBkfZJ6B4r?=
 =?us-ascii?Q?d1ORi25u6vg/IULNmYMAB4qwu7nkOKGev+k2pol9mFC8qcgraxLfeumcNXgv?=
 =?us-ascii?Q?wRfV5u2Vg0NQM0w8NQudz8LxbfHNZJkO6r1kQ5/3UKWk4URCr5PAYPEwKSJG?=
 =?us-ascii?Q?xboFUiOY/4nGdRSrZeIQUclc103ZcYDSRSp75KOE4KWh7F6OgnlM6yqIDkfN?=
 =?us-ascii?Q?4o81EPtzFbtXVkGQrlj+viFycq+J/rMBK4KyiDe5g/SD70EUuR/lw2uq0FDf?=
 =?us-ascii?Q?MaqhEC8RTFCTdGuD/WbFMLh39TfGTAQK7oVoRwRrnrS1oULLU//tOW4B174Q?=
 =?us-ascii?Q?R9tDH8rXPKlZCCd2mUm7JYw3GWdf3EzovtTVWB9yxvuKqSDkvKpnVPeR8nGy?=
 =?us-ascii?Q?FGE7v47B61DceiTO36DcN/WHe+89AE9FqmHijwa/PetHGBLGwj+52mmC81Id?=
 =?us-ascii?Q?OEiAKYtiw6MjxVp/d1rmejxipwJQGCuwQ6kPtkuqhpQanqNfzVzmLKV4ExH0?=
 =?us-ascii?Q?6WfQ4B1WmGASomgqYJ3qPfh01xi5PgOXv2bJUaJC5Gy4KpQ0t0kUtdPwDGuN?=
 =?us-ascii?Q?8AoDcxrEeK+VxN5slV9KlelO8WEvXdQKCJAOGGN77zt/4Id4Z4g54BIO1FJI?=
 =?us-ascii?Q?lFEmP2+Y1fFYSa8Y+pvVrnzjsaGft7Nd3BmoKI9be4XePYZMb0D91+90THe3?=
 =?us-ascii?Q?tUcldVPM1dWlN+Od+Ybn0o7cwc3/xSJTotMdrBs78qpEhdKjHu0vD02SWQyI?=
 =?us-ascii?Q?vgMvVEnyb+pcieI3OYpmeq2Jmt/XIyQX5GXTq1sE0DoTxR+nWHBct+RQGax/?=
 =?us-ascii?Q?3wFuloBJ5snk8/RE2LO10/lZGKjZ3CRIzkYJ1wdH8vMnrRGzG57bPpqmT1nH?=
 =?us-ascii?Q?nTwd2szaPmkK/bMZBex1/jDMd+Jqm4+f7BeQs224XIMTixybSx7kqtsuW9Si?=
 =?us-ascii?Q?cztuoH8KdJvvXTKQdugR0Mt4g8Jjc1i07Y2fSWh4yTPUAYZ3fLmLWPk+FJ2a?=
 =?us-ascii?Q?SG9UYrnWAi08OwykbI69HMLi/9giKNIikjcGf+qDSGJ07lPXpErywKZ30x09?=
 =?us-ascii?Q?Wy3CVYpP7M+HvyX0P9X1Z8GKbWTMK98P/IYr?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:06.0801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faea420f-1fe3-4b26-5f9f-08dde938e13e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6452

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe header file by moving the Legacy (LGA)
controller register definitions to a separate header file for
support of next generation PCIe controller architecture.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../cadence/pcie-cadence-lga-regs.h           | 230 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 226 +----------------
 2 files changed, 231 insertions(+), 225 deletions(-)
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


