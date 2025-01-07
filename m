Return-Path: <linux-pci+bounces-19426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426EA042C3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B64188209B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259B1F191D;
	Tue,  7 Jan 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DL9mZBqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DF1E491C;
	Tue,  7 Jan 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260762; cv=fail; b=Ac+nx2OyAaCXwErvX0qPapDqPVcFen9/Xwipsjfe0/Aw5dYTyO+MPkqd4nKor3o92ULtDx2VZvgyFVEdKn4QFnsqw7F1yvC03/BbeMsiHUlPePFiG4efBuy+tTURj73hblTUBWkjuSmfRFaRG3PkEAugUejeq/Ist3c2Ow8L+6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260762; c=relaxed/simple;
	bh=GeSmPmmUTIfJD4G3LWgIaCTaUWqAjfjJNdk4eQPTb1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJCO/+ZB4u2Q3Rd6pvDBFerIn9CiEbxVim+mHcF1TDAseeAbDDOvX31zXo7/dWk4jZs/0x8Y8nI6JDyGGqXJBEOpJb7bnUE7lUxDLqB8lfSol0IHo34vteJU2sIc1UyiSuwsA7AnInyBMa1X9G0ke2cjedYg6GjZsVGT6la1owQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DL9mZBqK; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU0WCEfQ5pNnvr85q/IiVL4sEvAK18QTbKmaLCNdI57FFOJJMbNYd0ygjZmrODgLRufjiRqS/Pb/sYHyIMiCKdtkHNfKgPkP7rY3KCPUoFJNB28/ZWeVrWLOAR6elRv2zywjBstlzWQAwOEqrvfa9S0OeVWqbnC2uqjk7122NPaqTzaRLCWapvfTa0wNozyfH7cUrLHyyrifKE9TR023YQr1BzXnqjJ1/3l5/q2Lwlx/Lnu4SdeX7NANlD4zK6C+Fyb3+1MnBs4+HvTXJ3DelSwotaKaVkoO+nEE3dRISZ7o6mwQdkMaGIj60ID0iXJFbFQOzzYuAL33YIBE07UOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uaqsGdnDU9bC6p9NmTWOBSzxQcM2rL3wrIxPIFc3JY=;
 b=T9AeL1CrGoh+acg/BiBCER/vduCUCLqz51ZohRdkugZMo36jwuy90ADiKkPGGiyhRUAUhr1JNP9CxDZpPkCtj+vcLd6phcOr0Fz0lLX4an8WuRP/d8QVpQKUNkp6HVHGJ+ceFd9FOHTfl0eMgQiUaoHWBlUCepgZu5nqCiPm2a+oMH4ti71Ho8FW9/vSFT0hn7oE+0DBANRel+4IImormqxaQ2G/qMFPoESTvs6klzUBpJOFzqt20xpBF4oT/sucCr1xdi8H89FlxT5kwojG2gg4ZjcA8nIPSqQWhfFlOGOaqLqCMqX+6snq4emUHU7MDNuh6fQhk0RRKTsQ3NB5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uaqsGdnDU9bC6p9NmTWOBSzxQcM2rL3wrIxPIFc3JY=;
 b=DL9mZBqKVXeFbrvRehQHH5bhx3gdxFsUsu+LemmTtE+xBikNi91oyDeSAqH4/9J4F0GHRZLvuf1Lx5fwk9kkuqhLmqRgkWz9yfe+NGtgUVebXoyM6pEIAV7TdGajXXynPFs6FOYzFP/nkkoq/e7XgSUlFBSiypD1Ozv+uw6bn9o=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:39:10 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::64) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 14:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:39:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:39:08 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 01/16] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Tue, 7 Jan 2025 08:38:37 -0600
Message-ID: <20250107143852.3692571-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b1fe0d-4566-41fa-957f-08dd2f290bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlwGVfqrfiBrqJLbNH+nT4T3I5mywi2JNi75p+WwtLLPKxZoux+iw/jPFr+x?=
 =?us-ascii?Q?7pdXaqYESoHY0Q/LvZD6MElRv4Uqf0OG8CYJI6ZdYqEQaIM016l22s9eE7HQ?=
 =?us-ascii?Q?U5e1kPSzT8+eLOfTjf1BCf6zA3kOTrMnvFJeYWZ4NGS6qBPWSIZieTai/j6r?=
 =?us-ascii?Q?XuoejWTxW3KT0fe8u+qG4BKfUzqmG37FXzmGE97D87/qUlObdpd6HGezpDcg?=
 =?us-ascii?Q?OI6+X0GyrVSAFYSAJZ+J3XTgV/NSmBj5KNvfmMHvqsrk7tfsBNRRLvNb6v74?=
 =?us-ascii?Q?9oe0+95Zf1PL80cHP5YySQ9YNizKcu9eqLI5bvBu9nMox9GhJrqMKOn7ahSF?=
 =?us-ascii?Q?MG1eNTTXjMVyijmtPUINXmDK71oqZEiCfd9qFHL49DBE53Rj5IJ05Keywb0p?=
 =?us-ascii?Q?F7EPdIM4AMdPlN3waaSxms5i/6sL3dS9wFI4biCjjBbdsm1obqyKOZbhL4uU?=
 =?us-ascii?Q?TZ6cMaf3GwN+DMogE9btiP+iStxNyF57sFEbumaI4kj4kzC/ThZCtskFf2Hr?=
 =?us-ascii?Q?4OT1WbK2mUiy2P2b3It7ArKuVVm2nfddGRhB2PLeHaLqMuefE3TAyhVALN6v?=
 =?us-ascii?Q?gDm3CL7gmLezy8BlcMVSYGw6Vp2zaRRgjGi4UuGxMVrkvymOwAyWxUDHPHTx?=
 =?us-ascii?Q?/kf0dDKydun0o3xWT6GdQ/82iAsDST6XdJBv1uO85rNRZjAw4zVNX0Qrjf0F?=
 =?us-ascii?Q?phA0k9g9GwOGHgRGC92U52D5Lmqz7kLnv8VHN6lLgsnX8YnEYePZnvS2dU32?=
 =?us-ascii?Q?/dTHSlaeT5rxOK4PQlFzFhtqD2YlEeinkhMMs4Gb+rrEACgZk0BmDpoBt9Bo?=
 =?us-ascii?Q?5ZImvXTDRi3ql2gLwNbFpKiIWk2zWf4sR0sHFs+610m1UNGq0WSx3cJ89ddx?=
 =?us-ascii?Q?m6quPPeIzOfNTKoCu/Lm8ThYUxBnyNSUH7jJICaPhgRPSOmiT2z2ke1YydoL?=
 =?us-ascii?Q?LFkJUSlKXJKsx0pUaqiqEyGOZVqPHplLFKPOzGanP7GlV1afMTizvLt4FPoH?=
 =?us-ascii?Q?gz3l4eSQ6OjUkLN1aEVFrmZezZSaUFEkswT0NxXqcJ+EecudZ8XkzqTiNwTL?=
 =?us-ascii?Q?6A6ifA/M3hg5lzNRZllPvHSPNKpyCNdWDWj/r5tUrEVyuW287SAi1GwgpkzJ?=
 =?us-ascii?Q?yiPBcq9VNts/JqIf2GjxlbEosdBgUsCEYuwoocOEOQrpRXE7r+ofe20+fLwz?=
 =?us-ascii?Q?Gh0Ef8OXeU7loiF/qGV3xMOCvy/uMAbdFR5KgTbUXTiVN/6XsoTaS5s2d55z?=
 =?us-ascii?Q?x+UEaSbzXs8Sp2Yw60MqU1kW9f1XgKZl3OVGBpGYK7RhfxiB9w8/3vDfkOsb?=
 =?us-ascii?Q?bmpUJv1uru12ePSMgwWJl9f89QhbE/7Wtc8AUqusjyRIrZVV5QwxMD1AGKfZ?=
 =?us-ascii?Q?LDMCIXe/PRqxZtltNDBzbbM/dhvy69Rog8njXI0YQSKPvV8rSnt4pcsVqspq?=
 =?us-ascii?Q?mjDU9dV3qa+dBxSPpcvHv0HAphUcGJa7+o4znshAamT2HKAYE/k5yUNWM1Mv?=
 =?us-ascii?Q?ou3JBN6CVCooYQKKPI3Qs7jd/owxPmLP/q9+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:39:09.7055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b1fe0d-4566-41fa-957f-08dd2f290bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

CXL.io provides protocol error handling on top of PCIe Protocol Error
handling. But, CXL.io and PCIe have different handling requirements
for uncorrectable errors (UCE).

The PCIe AER service driver may attempt recovering PCIe devices with
UCE while recovery is not used for CXL.io. Recovery is not used in the
CXL.io case because of potential corruption on what can be system memory.

Create pci_driver::cxl_err_handlers structure similar to
pci_driver::error_handler. Create handlers for correctable and
uncorrectable CXL.io error handling.

The CXL error handlers will be used in future patches adding CXL PCIe
Port Protocol Error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 include/linux/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..e2e36f11205c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -882,6 +882,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* Compute Express Link (CXL) bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	bool (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -927,6 +935,7 @@ struct module;
  * @sriov_get_vf_total_msix: PF driver callback to get the total number of
  *              MSI-X vectors available for distribution to the VFs.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ * @cxl_err_handler: Compute Express Link specific error handlers.
  * @groups:	Sysfs attribute groups.
  * @dev_groups: Attributes attached to the device that will be
  *              created once it is bound to the driver.
@@ -952,6 +961,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


