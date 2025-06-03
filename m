Return-Path: <linux-pci+bounces-28890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A0ACCBF7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8961897EBD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066D1E5B94;
	Tue,  3 Jun 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cVRflQl4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300C1EA7E4;
	Tue,  3 Jun 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971416; cv=fail; b=EhBWiDk9/7XmyLN6QmFeAMrjDQKWM3OyPQIwUPsl/Qem2XolOKeL29DalZPuU2QKh7g/2lVqH0aZZBlD9yXkMjBfTUXP8Mj0V3F7F1eGzhjKKY1KU1uyh1aBrBLUiWX1Ko/+zoYfFTVGluNx7kAUe6QornkNK4EeNxOj66YriYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971416; c=relaxed/simple;
	bh=BbOJhPo8UiRk859cfsZ5Zql8qC4V3F2LX23PzbPTq1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkgQS8qECrFvd7H+VSfd6uQbCnabHkxnTS35zaSLu+elOSFbNcgESKp/f9+7vlLXSJoAI2IoZdnP+znT1nrZ/yI3Ve7zGp8PaBBI104RXAsuip5IKDMA1toNCIsZGyIKFjEXMg7xQfEu2yBSDIxdir+Eq4gH3GObieo6/lcGTBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cVRflQl4; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8E9LJsgyb+qJmFmFZtdGE6HQbX1sqmSEmTgLV6GBxjqeHiSebWYIBuGr9iH77BGmJ+DTu3AzEws19VEaUv+1WKNFtcHQNYC5y39eNSz1JCuHyew4wqjWQEkfJurtmD+v4xrfLmBlZ/HWc6nFxxYxlayt9Z1YoG4X2W7r0cw6FmRE4s7pdAWrY6W5n6c/krszamTKZck4N+VvOqT+YFw3Mb0qKgZU0CDAXM3Qc1L5BzkbSz+RTaHCfxlUMiI0Ya+i66XpYvF0O3tBTXNBLmbT2fOBNGE1uZ4klJgb5P6EtecLUx14nJnK4YEEiS0voEAGZuogXyGTaZT0tM7OuaKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfDBpbTDENEZJ15zunUKTL+CAv5SbxUSYFLDeIKLjvc=;
 b=uumJFsvVk/48IqBmfK+6jrh67o6KHu9Jy9LHNdHd5ZHuhMArQNkl6jWRY0a2LBApy+4VX/WeWTbBoZXM/fq3CgVxU6C8zjWXK7Ocgl+qsVdCY3Bp7KhkKXmvFSxsCW00ols//82D9DP9y7MaSHD4h0EQA5LkBbTlhxwE4VVzb4vbKT1qTpgBG3vignGm2eqG3KL5nHT0JUt3acpnyi9Vkt2mcOph7rdVL41yB6zPR0hzDpY1jwWBucpmAgmRgszbLjQmUIPntnzDqwIPIfjLKq7FuqtWaccIC0LhXkFzJSPCi9CEU65+sVA2krCW9hRs8FEA8IU+alrQ6HohqwnIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfDBpbTDENEZJ15zunUKTL+CAv5SbxUSYFLDeIKLjvc=;
 b=cVRflQl4abCl0+hCyH3n9V9MnHbKcqVrJDYtBAy45x5HmhgeQdB2U8dbI8aVtMXCVpk1fngHpPMm9hxcF/E7ROQTNGesJRCvhjacCl39aU9WK8l2DIf0/jiI4QumSVb0fh7HdpdBgUwuvfVoVZAr8BuyDiMoFSxqJttDT1az+gA=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 17:23:31 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::7e) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Tue,
 3 Jun 2025 17:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:23:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:23:29 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Date: Tue, 3 Jun 2025 12:22:27 -0500
Message-ID: <20250603172239.159260-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c86d00-540e-49b0-086d-08dda2c35c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DSGivDffNzk2a+ZohR3WWWe4FEndUXiEAGkh+LMFDkae2Iqwl4wkPMFZcQF?=
 =?us-ascii?Q?ff5rzhXD8p3hWlrju71vIwVe+N7b/UknZX9AVdWsx1WGIKn3PZ0gThuO+pxA?=
 =?us-ascii?Q?gA73qhThDVNHz4VI2beXJ9W3DQoWIDziwnTmVCiYZtBT26TCBK681FakVzcJ?=
 =?us-ascii?Q?f4Nn2l0k+IfLD4/vt01PSrqFYptZnZVWm9ongPP5LmbacPS1r2RnMt7jztre?=
 =?us-ascii?Q?tKmArGKKH5otYjKIWWoi0IFcrJ4/ajWhBvn23lVmFtyMTGlrYSsSU7aESvDU?=
 =?us-ascii?Q?+x1JnNRPNscHuwIQ5tnpdTXRpzGFviUZcc8plSWV9pPMTI6LCHiHHE0KBwS6?=
 =?us-ascii?Q?IjKbTCepf2HlqEaChsM9ucJcufbZQ74doG153QUz6TJmOHro7Coza1kCB0/1?=
 =?us-ascii?Q?ZXuc+6n9WmBzImak/V7ed9I8lIBpu/KoLZFhMqE0OHYfsyTWx+qS4o74Vjam?=
 =?us-ascii?Q?+MmvExOx82hiKkmq11hcAhN4/Lf7YxRsR4hsA1rcKkR7E5hfK0HvWR0lYDyg?=
 =?us-ascii?Q?Jo9Z7rw6CmOUVdMHjkbepo8cfTlt5FZSleeEe/zPeNQ12l/LVNEXLfkffVCJ?=
 =?us-ascii?Q?WYfLgpNCHdQsKmjOx/LzUUrLBVlenWaMWbMrhy2w11Vk9u2Fgfj6FBglFiLH?=
 =?us-ascii?Q?qb9Yh18u6Hn0IOz+dmT0Dq5nWcbLQNY09AU6dkHTCoAmmzc4tcNizB84S8Qq?=
 =?us-ascii?Q?hNvZcy89bikQz54CLnv5i35S20T296PRYa9spp42S9Lkxaa8rjJus4i2BvDI?=
 =?us-ascii?Q?ETkqJtR5XEUggNtf3CChwQNPhiEqq3AV6+55eTyN2Eukyr1cycx5x05oheMV?=
 =?us-ascii?Q?AKsvjB05qJ/1pSFPKsIgdKww9i7rAkE/D/+xK/RJGcNzNeNtrIcYEBxx8a2v?=
 =?us-ascii?Q?rg2x4PMkiSlnKdh4r7gOBSX63ufGS5/WB0UObce661K5UfzgUD0+UamOSUhU?=
 =?us-ascii?Q?98RU44PBM//WK7/ghenWJKrUMJDJahUneiNKTQWcukZUeA65yTAatmkvX9o2?=
 =?us-ascii?Q?nQfTDzE0KrS0C6Ld59Y+ZqsqXfNVcUUazP5AT1tBwrom/JqcfwjFORJd9Sgh?=
 =?us-ascii?Q?cusMijLR/G5q+hWPWanRBXbvPzG/2Pp4muHx0fUECyPMAtxelORKkxUQdaDD?=
 =?us-ascii?Q?xK8CTrlRkuy17XG+9Xh1MtU28l1wbVJM+Z60B+8AfDbirmte9FQfER3sF+6z?=
 =?us-ascii?Q?j0qi42gYc6Mx1vGWsxHSGTiPBq+Nm3EkgkSH6C+10MSvVY20AaVOufLdxE+W?=
 =?us-ascii?Q?pBDdniahJ548KgK3IADyg+qtjSBxG1Gs0bIIHDsY/7Zc5xa5bh7zLzsnTWd0?=
 =?us-ascii?Q?pkj5vN4McdO6w6HpKkydfoMiHuDlPKoKTpY+81yBR57SWgs1Q+6V2yupsJ1o?=
 =?us-ascii?Q?PJx4p3DOyBR1tr5eyo/ROqkZvdFiH5auosSk/p9byF7nONFi5jI8EHaR1Q5X?=
 =?us-ascii?Q?I8L5mvf5PzH4meYIJUSCALNWRk3yE5Vtp/oVgSicC1S7Jili7BA3X9nVOOt1?=
 =?us-ascii?Q?HIrCLyJrMkhfAYWvMCYvP8bnL1BNA/+hUX3vAR+irPB7GraHmiR/cGfmGA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:23:31.0311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c86d00-540e-49b0-086d-08dda2c35c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180

The AER driver is now designed to forward CXL protocol errors to the CXL
driver. Update the CXL driver with functionality to dequeue the forwarded
CXL error from the kfifo. Also, update the CXL driver to begin the protocol
error handling processing using the work received from the FIFO.

Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
AER service driver. This will begin the CXL protocol error processing
with a call to cxl_handle_prot_error().

Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
previously in the AER driver.

Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
and use in discovering the erring PCI device. Make scope based reference
increments/decrements for the discovered PCI device and the associated
CXL device.

Implement cxl_handle_prot_error() to differentiate between Restricted CXL
Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
RCH errors will be processed with a call to walk the associated Root
Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
so the CXL driver can walk the RCEC's downstream bus, searching for
the RCiEP.

VH correctable error (CE) processing will call the CXL CE handler. VH
uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
and pci_clean_device_status() used to clean up AER status after handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       |  1 +
 drivers/pci/pci.h       |  8 ----
 drivers/pci/pcie/aer.c  |  1 +
 drivers/pci/pcie/rcec.c |  1 +
 include/linux/aer.h     |  2 +
 include/linux/pci.h     | 10 +++++
 7 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d35525e79e04..9ed5c682e128 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+}
+
+static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
+{
+	struct cxl_prot_error_info *err_info = data;
+	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
+	struct cxl_dev_state *cxlds;
+
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (pdev->devfn != PCI_DEVFN(0, 0))
+		return 0;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return 0;
+
+	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
+		return 0;
+
+	cxlds = pci_get_drvdata(pdev);
+	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
+
+	if (err_info->severity == AER_CORRECTABLE)
+		cxl_cor_error_detected(pdev);
+	else
+		cxl_do_recovery(pdev);
+
+	return 1;
+}
+
+static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
+{
+	unsigned int devfn = PCI_DEVFN(err_info->device,
+				       err_info->function);
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(err_info->segment,
+					    err_info->bus,
+					    devfn);
+	return pdev;
+}
+
+static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
+
+	if (!pdev) {
+		pr_err("Failed to find the CXL device\n");
+		return;
+	}
+
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+		int aer = pdev->aer_cap;
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
+
+		if (aer)
+			pci_clear_and_set_config_dword(pdev,
+						       aer + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_cor_error_detected(pdev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
+}
+
 static void cxl_prot_err_work_fn(struct work_struct *work)
 {
+	struct cxl_prot_err_work_data wd;
+
+	while (cxl_prot_err_kfifo_get(&wd)) {
+		struct cxl_prot_error_info *err_info = &wd.err_info;
+
+		cxl_handle_prot_error(err_info);
+	}
 }
 
 #else
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..524ac32b744a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d6296500b004..3c54a5ed803e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
-void pcie_walk_rcec(struct pci_dev *rcec,
-		    int (*cb)(struct pci_dev *, void *),
-		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
 static inline void pcie_link_rcec(struct pci_dev *rcec) { }
-static inline void pcie_walk_rcec(struct pci_dev *rcec,
-				  int (*cb)(struct pci_dev *, void *),
-				  void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
@@ -967,7 +961,6 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
-void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
@@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5350fa5be784..6e88331c6303 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index d0bcd141ac9c..fb6cf6449a1d 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
 
 	walk_rcec(walk_rcec_helper, &rcec_data);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
 
 void pci_rcec_init(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 550407240ab5..c9a18eca16f8 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bff3009f9ff0..cd53715d53f3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
 
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
@@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void pcie_walk_rcec(struct pci_dev *rcec,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata) { }
+
 #endif
 
+void pcie_clear_device_status(struct pci_dev *dev);
+
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
 #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
 #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
-- 
2.34.1


