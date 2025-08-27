Return-Path: <linux-pci+bounces-34835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B1B37732
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09EE7B4ABC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27DD1E5705;
	Wed, 27 Aug 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v6KIXsiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E121CA02;
	Wed, 27 Aug 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258755; cv=fail; b=BSKpGBtrih/MBsq0F3lTiJsLm9uHif6VBvd1eH4K3Bp9iD34+QdRENpAUAivtbYSO1YALEeDa9Jhj5F1B/12YRPY2eOwieipRLdaCATBGXKnM86vXCImEcNGp/zCCpGnnfZWZaVBW/hGKWVD91Nrm7JxS6xmnIE5lH2LcoW1Va4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258755; c=relaxed/simple;
	bh=6mRIUc0lvsFzrHQ5mejXql+qjR/TZjaQMDNzH8E3qnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3Y+/sZmfVQo+C0GSx0EIufxiSPcc1kjQO2+++aIGBY77NVK6IhnJNnMsdeZ9ppDJc4FqU6+JBgk33WnDbuTQIDOfy9H/vVKuU8MoO4XFLfdcCYcNdnlPhm4DjjwK6jZDKBMHUl29zGKr0KJbrWV8a9RQ/BbZAmI+5haQQi0zDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v6KIXsiR; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC/nX73bw+Lxfu1Bsrr9A3dj+pil+MrbWVBHC9t+S+n/TfiWy49QSj6lBEyGEHFFOQBuBtP48njdxAnec1JSDqD/lFoELEp4gpop3H77KlHEtfNEUHhLd7ZZ8W+1u+awuLo9eAGcjE9LFb+Yt7ryKtmCgy+uqPJZYtys0/MQEbU8EyrhAyKnZ129T56zMq5MWj7P/qrjSFp9UheBXAEOzMGMNGj9aXlbkBRL2CWaAb+sHcMshGWMeFOiB9iICDNEFw6d/2JuRCwa19rshvfN3liXIOD+4Y0sQgUI+V/VIX1G0vmXREgqK1tGGGEiG+RSuuJs6fw50aGvhLvKRaU8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27F2yE+daEpL8VxHTpquvOJF+++4lm9NfkZ86sPxtlA=;
 b=tUFrEHBkkK2R4LB34uck1fSXdua/dCqGgkePpLj9onmbNg83sNuEZLY6eWB5kunxhg/Wjiw+2uoUsfI5MX2+xA5fa3p6brDDHrIXnB8p7GplhqFAM5Bk5Hm7ZnULxjIKDUwFhvsRx2NgHIGvw9AzVi+Y5MbFC8pnRN0RryrV5A2GtgunuyzyimTB6oenAxxoYxwHRbRRFh+PvAE45LdQWQJn8X6CpPao2lei68o2IgIRjMVnytCV8ZpmcCau61Fvcvzlodr3+Ybv8XN5tfI9gm9yrpt6ykD/ZDujPncytL1nwS63HFfd8fUsY21MfNmCpNrMc4QOgubxwSKXZYUrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27F2yE+daEpL8VxHTpquvOJF+++4lm9NfkZ86sPxtlA=;
 b=v6KIXsiRze1pQ0VgAKMvFRig5/2MmzaaolOfP1cCJVHC0jViA1fRQmAEC/KKQvk4cuxQyOMOJQpqeOWHiOYQZ1QerHluIr3h3faIGWBZ6O6aEmQQvpaYDcvpvcwfaIVOAzE4WncPTzhaMFPcZwUjqUIXivpyHR1J2jqqWyGn7bc=
Received: from BYAPR02CA0056.namprd02.prod.outlook.com (2603:10b6:a03:54::33)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:39:06 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::d3) by BYAPR02CA0056.outlook.office365.com
 (2603:10b6:a03:54::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.23 via Frontend Transport; Wed,
 27 Aug 2025 01:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:39:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:39:04 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
Date: Tue, 26 Aug 2025 20:35:33 -0500
Message-ID: <20250827013539.903682-19-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c7e29f-2175-404f-f31e-08dde50a82a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1Arg7G/Ovk8ri4cQBsxM13ef2QLtJEhXKZYcVNPy/ypFFvFwRGZQQ3lY7dh?=
 =?us-ascii?Q?DX4rBJHO5zrAiDk4Ky3wJwDpB/8vUQPj6t/Vq33TBcMBEOt+/nBImBZX/DuA?=
 =?us-ascii?Q?kyGgm1RJS0DtRfzG7kQgJaUqjRE4lBfzWwswMOpM4QoTJv0z0JlBbxjkpctc?=
 =?us-ascii?Q?cgS5aDUWzu6Hfx0dkMjUhSgoY5F0jv4qDLWvYZczHtOIBSskpmiGjLTViShi?=
 =?us-ascii?Q?5BgmXiD6qtbUVyzixsc+AYRg+kO7gsRXwkVs35k4S9m4u201UerDkNJ5MFQ3?=
 =?us-ascii?Q?/WVJ3nXNV3iinR+247ojZcRrg8VF+hosumrui+STkaMCFxtWkjAs1zoPjn77?=
 =?us-ascii?Q?dP9IBUsUWBgLCcncpIk5KboyrCJYsCuliLKc80eczFhgUtxfzTlCRwT63ysh?=
 =?us-ascii?Q?IweSzwkDPHgsgYBTYlOl2FCkF2aEmN5TdzxUUkmD9g6upfhduiz7l0q8v7BR?=
 =?us-ascii?Q?kcUURRfkvLIO34Qbsx1FVaTNfpaYloaTeTSz4aqXNoucaZmyT1Atwztel1UD?=
 =?us-ascii?Q?vuaTbYyUzw3k6nz/Dhgwtv5aAul1Lea27+jryyLE0LODfD6zu7dwtXVlD+a0?=
 =?us-ascii?Q?IS2UDMCnjSmxaz29pTPAVbyVLegpfCNPhiPHrZBbSbJ/QFRjKxXRof2n/HJo?=
 =?us-ascii?Q?AYwg7QinpNHJ3IMb/LuKkahUrg1BLJP2cpDa1sir1/oUop7s36Q0evn79aCz?=
 =?us-ascii?Q?pMTGk0cKm8Cz4aS25pQVchqGmnhYxC8zpVeOrXBtOT0rDuVcsZjLgdIqXzXE?=
 =?us-ascii?Q?2yID42pGxpBDJBtrTJveht6Kl02yRKfan6m8r4tBp5X5U+2MrWphU3MWGt2i?=
 =?us-ascii?Q?Pt0CCEuyCfRIOKCF92l2Aa0/m1JuCZtoz+dTBeY4hGk5bmmGK/5lvmaoJdLb?=
 =?us-ascii?Q?kDx8IEqkpEjIJ05k1FGyuk0V5RiAZeRVWdnYkQYi+i+VrTgtKWq4JbGL3Kgi?=
 =?us-ascii?Q?rg3fyO1JT3q/pXoZJi8fLwF+exHDqJbCSQSiH/M0xSNK2j0GbQtQ3Z7GbaOK?=
 =?us-ascii?Q?pPNm65WOwK25yVnKqA/buxkC/vdypWOtFn+8+2vT0o9UBYi7MMjag6W5KsBc?=
 =?us-ascii?Q?7gOCGHMQo4CdnDsJXuokTOIVd7o/kgJj+A4lsaBeNicLcv+FdixwJaufUmSd?=
 =?us-ascii?Q?uY1A9EimFw3Xc4bizg4o8EVp+RhR94TliOEgDwI8vMVO3IkrndGfE6GLiAbG?=
 =?us-ascii?Q?6D8q/CvUY5J2J7wMPmEm9lHdTlw4lCO1cTO6GGUpwWU8EApZlCgsVox/YEbV?=
 =?us-ascii?Q?fVGgnVk1nbE9EwMfjOb2FGsHp2GEWR0gvTr5vwbiFo1fJDZ9jqAzRouqryQ8?=
 =?us-ascii?Q?5LTETPt8FF4OLR1jIQCkiI0ARqI8hs5giM4lQJBK9eFtzUMmrOWk5utFyQ/G?=
 =?us-ascii?Q?Tvpt0QS7w3zN1lvsb89o9YFrtpvOAov/lTwy8vcX6qLD4m+3ms5XOxgINvXE?=
 =?us-ascii?Q?AL9GaOGOosvQpi8dubBKZgoLAy37rKyMsTn8+q/QxxDS0NptT7kP7adlyedR?=
 =?us-ascii?Q?1FAa7mNYkLe+m339egx0KeHBrwhktPp6Z1BHbKbKhjuzlErd3SjfvedKOA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:39:05.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c7e29f-2175-404f-f31e-08dde50a82a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

The AER driver is now designed to forward CXL protocol errors to the CXL
driver. Update the CXL driver with functionality to dequeue the forwarded
CXL error from the kfifo. Also, update the CXL driver to begin the protocol
error handling processing using the work received from the FIFO.

Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
AER service driver. This will begin the CXL protocol error processing with
a call to cxl_handle_proto_error().

Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
will return a reference counted 'struct pci_dev *'. This will serve as
reference count to prevent releasing the CXL Endpoint's mapped RAS while
handling the error. Use scope base __free() to put the reference count.
This will change when adding support for CXL port devices in the future.

Implement cxl_handle_proto_error() to differentiate between Restricted CXL
Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
allowing the CXL driver to walk the RCEC's secondary bus.

VH correctable error (CE) processing will call the CXL CE handler. VH
uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
and pci_clean_device_status() used to clean up AER status after handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v10->v11:
- Reword patch commit message to remove RCiEP details (Jonathan)
- Add #include <linux/bitfield.h> (Terry)
- is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
- is_cxl_rcd() - Combine return calls into 1  (Jonathan)
- cxl_handle_proto_error() - Move comment earlier  (Jonathan)
- Usse FIELD_GET() in discovering class code (Jonathan)
- Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
---
 drivers/cxl/core/ras.c  | 68 ++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.c       |  1 +
 drivers/pci/pci.h       |  7 -----
 drivers/pci/pcie/aer.c  |  1 +
 drivers/pci/pcie/rcec.c |  1 +
 include/linux/aer.h     |  2 ++
 include/linux/pci.h     | 10 ++++++
 7 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b285448c2d9c..a2e95c49f965 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
-}
-
 static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
@@ -331,6 +320,10 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
+static void cxl_do_recovery(struct device *dev)
+{
+}
+
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -472,3 +465,56 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
+{
+	struct pci_dev *pdev = err_info->pdev;
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+		int aer = pdev->aer_cap;
+
+		if (aer)
+			pci_clear_and_set_config_dword(pdev,
+						       aer + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_cor_error_detected(&cxlmd->dev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(&cxlmd->dev);
+	}
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd))
+		cxl_handle_proto_error(&wd);
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d775ed37a79b..2c9827690cb3 100644
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
index cfa75903dd3f..69ff7c2d214f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
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
@@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 627d89ccea9c..45abe1622316 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
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
index f8eb32805957..1f79f0be4bf7 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,12 +66,14 @@ struct cxl_proto_err_work_data {
 
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
index 3dcab36c437f..3407d687459d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1804,6 +1804,9 @@ extern bool pcie_ports_native;
 
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
@@ -1814,8 +1817,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
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
2.51.0.rc2.21.ge5ab6b3e5a


