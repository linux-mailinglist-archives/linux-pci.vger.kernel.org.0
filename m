Return-Path: <linux-pci+bounces-30991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2182AEC5AB
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE911889406
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CE225A5B;
	Sat, 28 Jun 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhVmLBR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3122424E;
	Sat, 28 Jun 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096594; cv=fail; b=qMhxxrWr2/+H96B1wNFQFFfFYhpbemZjCpozwWSu4YzFoy8hGcGMP6K1/hxV1wTdhoeci2iHKdgOefvk5fRdQRPlJy3pAbaQlmICPE9hCNdBpSwYqd49wZv2Cw6vngfZF9XMopo6jDUg37+Xzs/yhdaV5B2NZydf0lFmhpxrOAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096594; c=relaxed/simple;
	bh=DSUJWXZVAgg+0M4G2a7NSxbWRxWTNKCUe8W0PqXzOzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRZOB7DtTIX/b8P9dyLyjUIB5Gl1VCnrNFzDkevst5/xwnFs1s5zd8XlmeJCT3R15v91fsZizP15sVsH2bIkFdcIRXbwQdGajebxSaSIlGKs5mYZAt4jUIOF4rnr7ryJ12SOua1FOabeYzqEzx7IW+oJ9RBSp0LuuAH4B7Ikm/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhVmLBR3; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0+kohvDRaRIxPymFiDUTGmfPnO7kWmwb/Q9DiryRNuwFdQnlx6FjLNVy4wY6roriOgZ3Y9fTmErjLIiPMO5LC33E3vsMz78TdbplD6jQwiQSPo/8Q7VXXYzNdMcRaltgeGi2ZgBvjmOK/7ZWsy1WHxJWMSJxKQeKypSOen3wJv7eRq3YXvHRy0DP6rQAT/+exG2PL/sAimVXVB2JlccO4/ad6vDrLqBswuAwBvb9X4b/tjTD8K5chwd1Z0ceYDTrPM9/wHQ7gSVSpGNKSyjhs+YJDG5z+LMJIYZKvftbxfEp3X1fvI1xbx+EdrlNYkISPndrIeI8uAHzs31zIIaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/jwPQRi4RYqn+THHKz9zgiZld7K8iajcbiMrsdXnmo=;
 b=bttyn1mbvq8dB18lolihFJsOxhpX4hcfY6u4OMQ3AnpLguBY2oFgQ+Q7VCiG/s48MaXxBwKv+mu4l0PlU8KC9oQdgVz6sXHOLInfMKTaaoHguXgfsAJKoHgvRpTNBudmWWFAEx5K2ldiAogFxL45YIkt1386c++A0OzhnYlXXkooqWZg0Rt4CZt4F269tFNWbidQj69lbFJc5AmxqBlON0jSZX+rXGwm6doDPfn3iVRdP316PGfWCwYh8kU0hMbWhPLcTlYFU+tkmRLC0XrWOmVJqWjN2HO2ysfF+y8GIy12uxTMdHtiIKNNlGKEeaI6cYJq6B/0SclWuRyJh/VTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/jwPQRi4RYqn+THHKz9zgiZld7K8iajcbiMrsdXnmo=;
 b=LhVmLBR3dS0i5bWc1ssU0naJo/RTU7L6f0BqUWWfSVUzdYXNmrqAllzdYSm8lAZ52CO+odg+uauvq/Gkrf4X0nrfvN7N2CqMZngBJZ8VpkiO2AlM/j+BVV4X9QwYsWXEHvQe6ZA2HPbTvs5RgjDHpOxjqgv4osCAc2HBUiE6YyfC96BhZbsZ6Bi4FN5EvUy7R5G4t5UEF9BiTiPAULHidxhKDNMZEjHV+fdX9D3ZQJ/C7v0oYErNEEAEGlNDWp1WtXLX4InbYVaLYRt/LeWNRDfpB8meJu7iwPXAHD4lLlFlD54e2xGefWmtNJMV3uBPa+c7Y3z4Y/QTO7QKdsctTw==
Received: from SA9PR13CA0063.namprd13.prod.outlook.com (2603:10b6:806:23::8)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Sat, 28 Jun
 2025 07:43:07 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::e9) by SA9PR13CA0063.outlook.office365.com
 (2603:10b6:806:23::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Sat,
 28 Jun 2025 07:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:43:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 28 Jun
 2025 00:42:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 28 Jun
 2025 00:42:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 28 Jun 2025 00:42:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 4/4] pci: Suspend iommu function prior to resetting a device
Date: Sat, 28 Jun 2025 00:42:42 -0700
Message-ID: <7889db2790263640c6e9bb98956c3a3d55b87ee6.1751096303.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751096303.git.nicolinc@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: c910519f-fe3e-409c-dceb-08ddb6176bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJ8OIdtPdaAWJ1ho3LhFz4SrMh5HgtsgFzvxnxY2YOlT4Pc/tr4c3ZqarIqm?=
 =?us-ascii?Q?pSf3W3TmHFLRVJ+MOwV+TJbDCidCPSihZVXvm9pBMoC4Z5PNUtJESj12xvu4?=
 =?us-ascii?Q?rlwpB/lPtMKQGn12aRzC+hVFe+peyMI/d4GCvDxmeSlyOmSghRAgxJgAT3Cy?=
 =?us-ascii?Q?Kb+YDeshlGNfZDvAeQnwwcpvF11zwoRMMznGbY6z++FP5dmB0+WgkeMd/R/U?=
 =?us-ascii?Q?B6BTAArOachcUP+fqNW3kToPWIdII2yKkWJnWZJTtVzb69kcr+9A2RF1vgNl?=
 =?us-ascii?Q?PA9ULG+CpYP1HeNrLfgZVSQkIalADDfT38RRyQWZ6wjAdBf7qRzjO4AnCkwB?=
 =?us-ascii?Q?NhA93oXNkEvKod5x/3OcENs5P96jNGIijg4d0z4olTKFwtS4bB+832Hspiha?=
 =?us-ascii?Q?8xQFwlBE2nfOxHea7DwNJC4UFEFhfBkd9dqgPfmvo2Xd81H9ld2SmUxGskFB?=
 =?us-ascii?Q?z5psXrtt4vAKnqL3r972wZY8jRc/KFDVs4KI0HBy3V8m/qGT/MzcJauxq81m?=
 =?us-ascii?Q?13zwloBB+ugII1l7rXt3fpvlDz8owENWvAlaZ6Kv6qC0tzeELnPa7dkUXe1Q?=
 =?us-ascii?Q?Hmint8QYO/B9WexT6cBPOJ7FGNFzZbRuzXpL+Wh+1LKOhcBY6k7lPidWOumq?=
 =?us-ascii?Q?kZgGtkLuxaneOUTuEPE6Bkn90z7ntEgIN6wyNJkHKCf0stcMN+lNTHOg2OSg?=
 =?us-ascii?Q?R7vYWqF4Ehlql4fIHj/LJaULXCxfuGYcTleubWYgObhuUu1P5aSiBrtT1w7x?=
 =?us-ascii?Q?JM7Saf6XJ2Uye0IR6Vglc9FnfQHl+5KNHlQ9dH6+mMMZB6XEeeUm4vX6DTSx?=
 =?us-ascii?Q?dUAk+9L341BAJrWtEDexVbImG0S/1vMrCn0O4COVPwsKXuSRafOTcbPvcAI4?=
 =?us-ascii?Q?9ettNIgaBwCbyWjI7Zyi0XEDIhNJmU5LdCwLjNFT+wUWrLlkN1jBBuaepgYK?=
 =?us-ascii?Q?R/NdWkcCOBPVBsmBDZb7bnv6O2Oc5b6QC32bQ6+qFP6gUxKTntJU23vUAVhs?=
 =?us-ascii?Q?pNv7yi0mAO4b6fKikHmuCBwOHeIKgP8BUdgNCjNFwm26aChVqdnAvnOEpJ0T?=
 =?us-ascii?Q?8F7pmPkVfwmhTHE1kjSW0JhBtT6OWKDJJi7Cv6D0drzpP4aexTbmS+fEo2Qs?=
 =?us-ascii?Q?QllNf+Y/8Jz4ZaV00WVH/SzSk8evld7nUvohtN8M4Igk4t8Re7PT6MdZa3y3?=
 =?us-ascii?Q?tCJQcf5vvsPdS1Ou1dCcNgHuoxElHjyNsY5zKp3qYo2/GKeuF6hckTrIvaLb?=
 =?us-ascii?Q?YvRWYoJSaJPvbZjSvcBhr7Y5lk4th4bnDbjgPpfbVNSQdkuCzZXs7AW1+QLX?=
 =?us-ascii?Q?96ZcjO7OUC2Q0xyS9iGK8fK/h0EraEkq9qBW5sggSKhCNPSYnxnGwyl0HI4Y?=
 =?us-ascii?Q?xLTnIGeXvt31DDKqy0lf2rawYFd36a5V/8I2xM4wlvTXLhVA/2G3XzrulKm7?=
 =?us-ascii?Q?kyc0TjQG4aqffH+9M5Ohpio6/4CzmQn80Wb9X1tIEB+bUZs1p0c0dEJ/fWl+?=
 =?us-ascii?Q?Af3hYUNmP9myBpiQV5tCBdJvItWOiRCA0n61?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:43:06.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c910519f-fe3e-409c-dceb-08ddb6176bde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out: e.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Now iommu_dev_reset_prepare/done() helpers are introduced for this matter.
Use them in all the existing reset functions, which will attach the device
to an IOMMU_DOMAIN_BLOCKED during a reset, so as to allow IOMMU driver to:
 - invoke pci_disable_ats() and pci_enable_ats() respectively
 - wait for all ATS invalidations to complete
 - stop issuing new ATS invalidations
 - fence any incoming ATS queries

Add a warning if ATS isn't disabled, in which case IOMMU driver should fix
itself to disable ATS following the design in iommu_dev_reset_prepare().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci-acpi.c | 21 ++++++++++-
 drivers/pci/pci.c      | 84 +++++++++++++++++++++++++++++++++++++++---
 drivers/pci/quirks.c   | 27 +++++++++++++-
 3 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..727957f193ca 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -9,6 +9,7 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/irqdomain.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
@@ -974,6 +975,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+	int ret = 0;
 
 	if (!handle || !acpi_has_method(handle, "_RST"))
 		return -ENOTTY;
@@ -981,12 +983,27 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 */
+	ret = iommu_dev_reset_prepare(&dev->dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
 		pci_warn(dev, "ACPI _RST failed\n");
-		return -ENOTTY;
+		ret = -ENOTTY;
 	}
 
-	return 0;
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 
 bool acpi_pci_power_manageable(struct pci_dev *dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..ddb7a10ef500 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -4518,13 +4519,30 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 int pcie_flr(struct pci_dev *dev)
 {
+	int ret = 0;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 * Have to call it after waiting for pending DMA transaction.
+	 */
+	ret = iommu_dev_reset_prepare(&dev->dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
@@ -4533,7 +4551,11 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+
+done:
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4561,6 +4583,7 @@ EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
 static int pci_af_flr(struct pci_dev *dev, bool probe)
 {
+	int ret = 0;
 	int pos;
 	u8 cap;
 
@@ -4587,10 +4610,25 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 				 PCI_AF_STATUS_TP << 8))
 		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 * Have to call it after waiting for pending DMA transaction.
+	 */
+	ret = iommu_dev_reset_prepare(&dev->dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
@@ -4600,7 +4638,11 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+
+done:
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 
 /**
@@ -4621,6 +4663,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
 	u16 csr;
+	int ret;
 
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
@@ -4635,6 +4678,20 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	if (dev->current_state != PCI_D0)
 		return -EINVAL;
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 */
+	ret = iommu_dev_reset_prepare(&dev->dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
@@ -4645,7 +4702,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 
 /**
@@ -5100,6 +5159,20 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 */
+	rc = iommu_dev_reset_prepare(&dev->dev);
+	if (rc) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return rc;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
@@ -5114,6 +5187,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	iommu_dev_reset_done(&dev->dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..7a66c01392d9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
@@ -4223,6 +4224,30 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ 0 }
 };
 
+static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
+				    const struct pci_dev_reset_methods *i)
+{
+	int ret;
+
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a reset. Notify the iommu driver that enabled ATS.
+	 */
+	ret = iommu_dev_reset_prepare(&dev->dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU\n");
+		return ret;
+	}
+
+	/* Something wrong with the iommu driver that failed to disable ATS */
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS. ATS invalidation may time out\n");
+
+	ret = i->reset(dev, probe);
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
+}
+
 /*
  * These device-specific reset methods are here rather than in a driver
  * because when a host assigns a device to a guest VM, the host may need
@@ -4237,7 +4262,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID))
-			return i->reset(dev, probe);
+			return __pci_dev_specific_reset(dev, probe, i);
 	}
 
 	return -ENOTTY;
-- 
2.43.0


