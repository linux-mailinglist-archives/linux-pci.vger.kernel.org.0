Return-Path: <linux-pci+bounces-16699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99F9C7DE7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BF4284151
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAE18BC1C;
	Wed, 13 Nov 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvGL4IkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25B17DFE9;
	Wed, 13 Nov 2024 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534894; cv=fail; b=JZmYbIg2tuiYq2biOUwaS4aMdV1waZ/JQvgZAuY6S167uGwzDiDqyHkEvwvbPFYL2ZDxlgrcwQQT/IsXIwvs5sG99xfLZBb7ucCVG3MYHyNBL639nfvskgXYezoIc75WtwPVQyrtqrocL3d89dMjkCqcOpwFbJpWmuH0+Eo2asA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534894; c=relaxed/simple;
	bh=q9OB8tLWZxIgsqVEOjpOhXtgeP+NfDbwRrU0r5B4teM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kasSqcI/v4L2zG0RGO/pEAJWfIvVWbynKD8ZfMdfOaVwil6uJ1GAyU4NE7F2qodkA572nHwjay82gWxVxGQLEzx+JySoVCeAqcXj5cMtRg/2L9exwUfK/t4rX4aJ2ozeSuEGOtRN0N7FaUApeonO7DiSOCcZ0niPdVOFHFT2ae0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvGL4IkW; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFtaSxYVOvdL/iqYlhOktwPJvZz9r6QIjdiYGbKjXj6DISjg9nlBBxUogE6o47QjeoKGwY11BXdDSNUfSHIpJE8qoJRXSSENa0EANFIMfsr/XE9lqacFbd4dT+RK+1oWkz7a0QVXtRFB/Hs2JbhU8D2HPfAEAmYnEInlcbYWJNsEq2VbKxdlU7MKJFoiB9Ow0XBVdlbqCwbu4qBgaKE0083QmcC3hNdJ/SLWi90j1ADnaGqjUuV0F1Ty/DwiADg8gjgVGr4+dA037nvcQddbqAPvWi8JXkZypLjchP3mLvdIsJqbiOVQ9B+k1bCZ+St4B1VL6EIU68YuBrjaP/c6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StoEvp8g08EwNbFA+ReDo/L4wXg/3VV38sCjNUREhfE=;
 b=k/lrS+sEmfh1HrBghzeH5hN1yLcos0LjXi63VPC73+/92JDBOrlrqR1r/obqVNG94v0rfxNHJydRLBLhrP81m7DCSgcTpC8yv6L4+KKyZKIgeAEGUDhpuQZvxVKgOvvjSaf5D/JEjI+toqJZzvNn1Gzhtt/mCLKwCR7IRx7kxKCNi/O5YZRzqvgX2j5ANSnKUBsVFOe48E81VXcJZbNRVPHbY0FQXfYOo+NOkYsEEaXzDOLGxo6/7po/eYHClKjwkBhkE/Eh2/l28n2C2J91CICacNCg5Gwc9oSwE8n0Z2tnUn8wx1QbQaWSi510mHBisYUlvkY10+5q1sJG6TSPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StoEvp8g08EwNbFA+ReDo/L4wXg/3VV38sCjNUREhfE=;
 b=rvGL4IkWgeUC0lGoU1MxL3/dZyL0k1dL+ZRz3CDZUI9o1JM3mnvuqauJCqkZXPF2teHUjLkpo7w9A1T7WaSWZJP8xmTUiLdgRTLvXrDC4B35HNxkfyhbdfRMe++I3F4hLbI/moDiz1KwYKmSOt12oa8s31heiH/HvhMf2eiFE9c=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:54:49 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::88) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:54:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:54:46 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 01/15] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Wed, 13 Nov 2024 15:54:15 -0600
Message-ID: <20241113215429.3177981-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1228af9d-67f9-4495-389b-08dd042dcb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3x7xdFjkCKPH317U2P56eb9Wsc2KlVZay9dTiAFktLjglMTqR2DNeCETJ0R?=
 =?us-ascii?Q?2NIGh/za7JWRA8Isxo9Qef7v6bzb5KxZ6gH0QDxg4nRNt8oxPBm4cZ29Gkv9?=
 =?us-ascii?Q?5ppcjffe2tXWPeE4Fc9Bu8uhPlaZltaO3Dw2Zv0MvcA99qc3UjaYmyrsgoP9?=
 =?us-ascii?Q?XFqm6zqRAd5UTUpihr5AnMLQcRi7yRNWeGaOynAVtvWWRmGLZWxSGHTHlGcR?=
 =?us-ascii?Q?x39OcDBT1o5km8gX+Pds6NUCOv1lDQod4KRsUj9TlnxMNyGiO1g0xqaSdc4L?=
 =?us-ascii?Q?6bBOb2FfS0McQ7jnNbNkXNOCbUwJBhMA2Qdg5Jb6TYYfvhzKLlvbmvRgFKVq?=
 =?us-ascii?Q?uEtmjrFgCMCZu4Ew1mG1QRmZXajNjw60Y+NPOFN20BvPWnTD+WUJl3KOx1rA?=
 =?us-ascii?Q?K+jsfKvGablAnU8YG0aP9VEwiqyi0yfy4GrQgbIAngoUCPonYEkNrXMfiloQ?=
 =?us-ascii?Q?KCqpSo0FPZp+BQN/EShcp9Rz1FpA6E1tGgiWoUNLj8Sg8KDjcP+GaLYA30Wo?=
 =?us-ascii?Q?Qfmf7Vb1OWJaavkAnafIJtUF0rub7GksSmF+HaEpn+0XlI7PUD5MMZ8q3oe2?=
 =?us-ascii?Q?n6n5nw+rdxBbvAu+SOtCkpiIDLKv3696D4jkfe3AuGZKZUVCeX1JcHyG5HbJ?=
 =?us-ascii?Q?wFM14WvuC1SA2UrqUNk6vucdFdib7NxZvmeAYy5LeSplinHvjUpiniPOcr3Y?=
 =?us-ascii?Q?VNrf++dZ7JRMLK4+bI2Z1RuUrrJjWLDZAkcxHyGnGsHyjwvy5bHTNXJ+Ea3O?=
 =?us-ascii?Q?DYkNz4Bbd0VmSI2O9iKfIHx/KOyBXHZ8xuAQjJNUCvyjgNmbFgxnaLqiFhqg?=
 =?us-ascii?Q?o2+vvPzOnhTkTYx+JTjVlugCYt//2CZYkdACu3HLI66Rw7hU210nepJxt3JD?=
 =?us-ascii?Q?yuIfq5Trg7ja3R4YUu1RB3ZZIYueQv/FMmBE0QiFouUP12DuAdAxHmAEXPwJ?=
 =?us-ascii?Q?PIiCSsV0nwsTvMsipP7mwDyz53IIzgLvVXKfa4DLnKJDA60pnaDJG8gcIWX6?=
 =?us-ascii?Q?eD8atUDBYeujBzAEbZt+ispl1Ton0CSLS1uZ2+igxk88/H8dqUJq3nCE2LsN?=
 =?us-ascii?Q?q/tjKSk1nT9UBCinqo2oqF6GOgC7ebme+z8OkNr/NrhlWyzWPn9ke/2RaL2P?=
 =?us-ascii?Q?JWdKLtf7kXXxOdPZDEwAg0EeX1J4cRjEpMF2YPjYy0KfcZDCGYb9tYqM7QyB?=
 =?us-ascii?Q?h38pH881ZJJPJ021N/52sZhg4MbjMy9Oc+3stbmJQoYw9003ZGK+3IhGJskL?=
 =?us-ascii?Q?F2k59fBAEm8AymSaTDecPFOhEVdpduFkOSEREJdVV6gvK1Th6LuU0mcY4e9F?=
 =?us-ascii?Q?WH/ZUhdyll9EwDpETnW0dNpgT6T3GD9N4hNJyzIVWs5tuVGEVW0wa1R70U+e?=
 =?us-ascii?Q?BLLQdvyuWDlVani4GYtxxG85QLzn8TkeKQW1gOHYdpcfgpmCBv4AFFUV0IQA?=
 =?us-ascii?Q?7VvyXsdxPjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:54:48.7515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1228af9d-67f9-4495-389b-08dd042dcb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

CXL.io provides PCIe like protocol error implementation, but CXL.io and
PCIe have different handling requirements.

The PCIe AER service driver may attempt recovering PCIe devices with
uncorrectable errors while recovery is not used for CXL.io. Recovery is not
used in the CXL.io case because of the potential for corruption on what can
be system memory.

Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
Create handlers for correctable and uncorrectable CXL.io error
handling.

The CXL error handlers will be used in future patches adding CXL PCIe
port protocol error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..106ac83e3a7b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -886,6 +886,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* CXL bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	bool (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -956,6 +964,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


