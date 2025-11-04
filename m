Return-Path: <linux-pci+bounces-40180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D6C2E927
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E0C3B2D72
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2682139579;
	Tue,  4 Nov 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eoIy/kGV"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5345C0B;
	Tue,  4 Nov 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215620; cv=fail; b=iVKvh/GpqWEmeMYAJraSJ3DY2gupfOzRenkIE8JtLz36ZWdRKD4xuEEvh5Ir8gI10nCXcQSIheAYvsRxtqYZDfw9BsinGrvrpaNvqNvYoYwL2J5MOh9jOu+lmqz8k/S3VJfIO2f/4b62lA1a3dWFxgTe93ZcoH3r8lNFlSCOKI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215620; c=relaxed/simple;
	bh=34RW/WHyo03GCccU5H63V/6lIL1e5IsFkoOhtMDI1g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdQQlATjzp44CRvEm138TH8KGm1acS3njdTCd3o0zjdjcJBsZmuGnjWU4JQ0V1HUnINScc0/Bv0I0hewOK5voh7rBmdh5P74w4hvW7vf1AB5CPB5+B7ztzc0d7jaWtXJiMYKZr6ut3PXZtGbKgwEcpb0cG1KZDuNiCJlnJ8yoHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eoIy/kGV; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD5Cplsg4JH4lUk4heaJoRDi1YjvJaZDaFz39UZkmLIrgkP9AEhtHZgOH7DC5y6b5y4001fSMDvpl8QDBbJUT+jX8TqbqK+10NZuwVkmUiHXEyL0DKsVpZN+XRRTl9LHcNFYOGYE+tfarLiogOF1A79QZ38pOWd0u6YO1dDGKa6AWff+n/FUuNhpjwDBz40gVQFeODs1OlC34oj+3+vR6vvEmtMTdX6Hghu78S+fsZOjz861eR4dDtfXaNANwzXRVvWkG01WqZajrWwyBQVAV93ST8AlT3M1/kDKZ/Fs4Ge3tMas8uLAPqSCa39pZRklKi8Q1dO7PXBCEBgR5T3tQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm/mOyX86SEcJug4YxBZmK80XYOcMmSJdVrSHrgBPyU=;
 b=R25WiovIRsab7FEf+8XTqm07MDgcToSjFJbmCwn3rnTGhot8i1Q7mZ+fq+LfRm2DTeRdtLwI1f+YLhznA7kbtyVBNZkdGUhkc3K/rEOL4oddKeq29lZw23A5dUW9sHELZwp79IgDSv+B4HkHLzSFM4b8kb9eDXa3iI+RwGfHV9YqLwWEV1gHtyyWrTVH/EX38pAkeCdyRkUpJbBQSE7g2vBiUA6uANH6ViHKg41o9xi1xewaP77W4OcR/jUFWYi9/5sVzu4pQkhWu5TV51H1betEa38KTtwC3ZPZasnqALrhYdPWSsbzN9AeAE8if1kMdnknMCcp2e6vaH2Ilt/19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm/mOyX86SEcJug4YxBZmK80XYOcMmSJdVrSHrgBPyU=;
 b=eoIy/kGVCu8Q+3Q8Cxexf73/wMzNEOOR0V+bUjvDJ/B59JK9fgi7lqD+jIKmblwJZDzgjUnug6yZfGTF4kAfPuUZGOjO7YimuJHLiEag9iQn4GQesdh8V+icetxz6AyKVwgXd6CRywDQXcwICD77TCjVumhMDGf4tLPIMRP4J1g=
Received: from SA0PR11CA0179.namprd11.prod.outlook.com (2603:10b6:806:1bb::34)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:20:16 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::19) by SA0PR11CA0179.outlook.office365.com
 (2603:10b6:806:1bb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:20:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:20:02 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Mon, 3 Nov 2025 18:19:56 -0600
Message-ID: <20251104001956.3885052-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: fe207936-4b2a-4eb5-7747-08de1b37edad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERCZVQzV0RIQlhpdFlmUmsvMWFlOUk2MjlSNE9pMURoRDc5Tm5xaU1wTWpx?=
 =?utf-8?B?TGNvUU9CNnRmbFhhOXFGZndSWTNSVHVpS2dwNDRCODRLVEdVdkNLRHpFMFpK?=
 =?utf-8?B?SGpVQmxiTzRhVE5VYlJvcUdaWjFxc2V3T2NZVGRVaTZ1SUplL20xQUk2ZVpG?=
 =?utf-8?B?YVRyMUNBZXN0anVYTTNkeVdzMGlaU0RBRWowaVd5UlhvRForbERUdXpOOTds?=
 =?utf-8?B?MzNhWWRUUGxhaFZsT0wzcmpoL3VHYnNyWkl1S3ZmaTZoVE5RQjE0a21CRFc3?=
 =?utf-8?B?aVFPdE1iUkF0dG1meE5KTjV6NDRJcXk2aDJyL2RyRS85bHZzbUxWWmZocU5J?=
 =?utf-8?B?VEJYV2Y5ek5jR0RsYklYWHhFajVIYU9TSnA1bHFLSDhUb0s2cU5GcmxGZWRH?=
 =?utf-8?B?YnhJeHNhYWt5MktvVWxlV1FtUU1NMVJ1Z2EydHU5OFgwMDBIOEVpamFVOEtw?=
 =?utf-8?B?RG84M1B3aWlWME9INGtCZFJCVWI1aUhlamxodGp3emlaRFNTaU0rUmQ5ZUhh?=
 =?utf-8?B?bUsvSGZVTFF1S0RPQzducGhzMFM1TkpabG9NbDcxS3dIa0NNaEdSb0U1aGtD?=
 =?utf-8?B?MHJsaFZKT0d4Y0JFQnlCRW9Sdm5JTXZkVzNObVlCRUdMcWdtZDFIMWI4dU5Q?=
 =?utf-8?B?eFNRdmZkeFBNUHpSQ1FqbG8wYnk2NzFseE1IRU1YQlI2N0R3clhha2RFNm0x?=
 =?utf-8?B?SkNXaWZNZ2FDWUQ3ZVdIMUs2Z0toTHRNSGV6RFZ2OW94RENNV0cvYktaSmJs?=
 =?utf-8?B?bURZVDVHbnRneXNhRFdPeGd4TE1YRDhQUVF0S1BwaGZFL0I2WDRLcnc4dHdq?=
 =?utf-8?B?YnB6aFQ1Rm5YWGdTaVpQYkk1UitCb2taNkcwS3ZaUzQ2WDVhcWRBb3cyejVr?=
 =?utf-8?B?bngxbFFmRWY3SkJBQ0g2bDN4aGFaSGlPUmQ2cFpOemdjV1dBenh1ZktLWVF3?=
 =?utf-8?B?d2JjbWloVllvN3k1eDl0M3BKdTIwdHVGVys5MFpXb1NzcXRtZFdzOVNoemMx?=
 =?utf-8?B?UGZmREZwUUxhVCsrVmtCRkZDUUtQWFV0QXN2Q3BzR1J4WUR6VFowQXp5NXFH?=
 =?utf-8?B?UkY4SHNDWkZ4cllGcjR0RWFzRVowUUxZWm9zdWFIa1ZGazc1UjI2bUUxSmdy?=
 =?utf-8?B?Vk9hT0tlMlNWM1djTVFXZTBNdWRQWGl5V2pIb0R4QVJNdGFNalJoL0dsT2Fq?=
 =?utf-8?B?dDlQdEJJdXF3Y3Z1NzROeExzeFdsSElKaWlxazUwUmtLSFJpc0k2NXhpR2xZ?=
 =?utf-8?B?S2s3OXRMdzUxbFBVUzJJQytWMHFrRWRnaDhUT3EwSGdOcEpqdTRDaTNhK2ta?=
 =?utf-8?B?TW5tb3dIdzV6emNkZlMvTDU2WkxaOVBJVllQWkFXaGZTVThycU5FVmlRSExM?=
 =?utf-8?B?R3VnRFVGL2NqcjlaYzRMcG9rTkJUbEdvVjdlZnZXL1dOS3dtM2pmRTkzVWtL?=
 =?utf-8?B?U3o2VHJLWkJaWWt6U0doTGxXNnpEMWdXd2xMaER3SFBJelBDdEFnVDJOV1FI?=
 =?utf-8?B?ZC9uT0xFakdBRjRRcjBmbGtrRGdjYWtwTmJWdk9adTU3K0o4K2xGeHhtY3Ns?=
 =?utf-8?B?VnJMOXlhSlU3OXlmYmxua1RONEJseVNDandNNlNJK3IveXhkb2F3MzdZVmJK?=
 =?utf-8?B?MVlycy9VUVppOStwSndRcWNkR1NpajZyVyt2MkV5WGE1bWYrelZMMzBqd1lS?=
 =?utf-8?B?Mmt1U1FlQW9JSnFFK3FVejE5Sitib0Q5S01DanpYait5Y3JnOGlyMU44VUNI?=
 =?utf-8?B?WnJXQXkxa0c0RjJxcXhtL2lxcTUvb1BkR3VMOGRyS2F0TnhRb29ET01KeCtH?=
 =?utf-8?B?L0t1NXJVTXdtZ2NLSUJPU0RkTHdQMVpTc2R4RFNtZitIdjNxSXRaV0ZhSGhw?=
 =?utf-8?B?SnBvRmNTcUkwOXYzZ2RPZU1iZlpneEI3MjB2WmcrOXBBZExJUnFVSW45SFdH?=
 =?utf-8?B?Ym96ei9XamR4MUdMSXhtcnQ1VGhJTUpUdU9kOVhqOFVERkFFVlh4NFZGTWwy?=
 =?utf-8?B?N3JBQ2d5NnFtTnlBelRwWjdNOVFNckRlOXJiN3Y1UmtkcHNtbW1HbWh6RE5T?=
 =?utf-8?B?bjV3MGFKSE1ya1BrN3E1Ui9MNExRN0k1Zm9MTGJzYTFadXRWbTB2VGpHU0Ri?=
 =?utf-8?Q?0Sont3s23x/Wq92+w3hANQrQM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:20:15.7255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe207936-4b2a-4eb5-7747-08de1b37edad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475

Implement cxl_do_recovery() to handle uncorrectable protocol errors (UCE),
following the design of pcie_do_recovery(). Unlike PCIe, all CXL UCEs are
treated as fatal and trigger a kernel panic to avoid potential CXL memory
corruption.

Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the CXL
topology from the error source through downstream CXL ports and
endpoints.

Introduce cxl_report_error_detected(), mirroring PCI=E2=80=99s report_error=
_detected(),
and implement device locking for the affected subtree. Endpoints require
locking the PCI device (pdev->dev) and the CXL memdev (cxlmd->dev). CXL
ports require locking the PCI device (pdev->dev) and the parent CXL port.

The device locks should be taken early where possible. The initally
reporting device will be locked after kfifo dequeue. Iterated devices will
be locked in cxl_report_error_detected() and must lock the iterated devices
except for the first device as its already been locked.

Export pci_aer_clear_fatal_status() for use when a UCE is not present.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
- Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
  (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
  cxl_handle_proto_error() (Terry)
- Remove unnecessary check for endpoint port. (Dave Jiang)
- Remove check for RCIEP EP in cxl_report_error_detected(). (Terry)

Changes in v11->v12:
- Clean up port discovery in cxl_do_recovery() (Dave)
- Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10->v11:
- pci_ers_merge_results() - Move to earlier patch
---
 drivers/cxl/core/ras.c | 135 ++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h      |   1 -
 drivers/pci/pcie/aer.c |   1 +
 include/linux/aer.h    |   2 +
 4 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 5bc144cde0ee..52c6f19564b6 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool=
 take)
 		device_unlock(dev);
 }
=20
+/**
+ * cxl_report_error_detected
+ * @dev: Device being reported
+ * @data: Result
+ * @err_pdev: Device with initial detected error. Is locked immediately
+ *            after KFIFO dequeue.
+ */
+static int cxl_report_error_detected(struct device *dev, void *data, struc=
t pci_dev *err_pdev)
+{
+	bool need_lock =3D (dev !=3D &err_pdev->dev);
+	pci_ers_result_t vote, *result =3D data;
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return 0;
+	pdev =3D to_pci_dev(dev);
+
+	device_lock_if(&pdev->dev, need_lock);
+	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
+		device_unlock_if(&pdev->dev, need_lock);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	if (pdev->aer_cap)
+		pci_clear_and_set_config_dword(pdev,
+					       pdev->aer_cap + PCI_ERR_COR_STATUS,
+					       0, PCI_ERR_COR_INTERNAL);
+
+	if (is_pcie_endpoint(pdev)) {
+		struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
+
+		device_lock_if(&cxlds->cxlmd->dev, need_lock);
+		vote =3D cxl_error_detected(&cxlds->cxlmd->dev);
+		device_unlock_if(&cxlds->cxlmd->dev, need_lock);
+	} else {
+		vote =3D cxl_port_error_detected(dev);
+	}
+
+	pcie_clear_device_status(pdev);
+	*result =3D pcie_ers_merge_result(*result, vote);
+	device_unlock_if(&pdev->dev, need_lock);
+
+	return 0;
+}
+
+static int match_port_by_parent_dport(struct device *dev, const void *dpor=
t_dev)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port =3D to_cxl_port(dev);
+
+	return port->parent_dport->dport_dev =3D=3D dport_dev;
+}
+
+/**
+ * cxl_walk_port
+ *
+ * @port: Port be traversed into
+ * @cb: Callback for handling the CXL Ports
+ * @userdata: Result
+ * @err_pdev: Device with initial detected error. Is locked immediately
+ *            after KFIFO dequeue.
+ */
+static void cxl_walk_port(struct cxl_port *port,
+			  int (*cb)(struct device *, void *, struct pci_dev *),
+			  void *userdata,
+			  struct pci_dev *err_pdev)
+{
+	struct cxl_port *err_port __free(put_cxl_port) =3D get_cxl_port(err_pdev);
+	bool need_lock =3D (port !=3D err_port);
+	struct cxl_dport *dport =3D NULL;
+	unsigned long index;
+
+	device_lock_if(&port->dev, need_lock);
+	if (is_cxl_endpoint(port)) {
+		cb(port->uport_dev->parent, userdata, err_pdev);
+		device_unlock_if(&port->dev, need_lock);
+		return;
+	}
+
+	if (port->uport_dev && dev_is_pci(port->uport_dev))
+		cb(port->uport_dev, userdata, err_pdev);
+
+	/*
+	 * Iterate over the set of Downstream Ports recorded in port->dports (XAr=
ray):
+	 *  - For each dport, attempt to find a child CXL Port whose parent dport
+	 *    match.
+	 *  - Invoke the provided callback on the dport's device.
+	 *  - If a matching child CXL Port device is found, recurse into that por=
t to
+	 *    continue the walk.
+	 */
+	xa_for_each(&port->dports, index, dport)
+	{
+		struct device *child_port_dev __free(put_device) =3D
+			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
+					match_port_by_parent_dport);
+
+		cb(dport->dport_dev, userdata, err_pdev);
+		if (child_port_dev)
+			cxl_walk_port(to_cxl_port(child_port_dev), cb, userdata, err_pdev);
+	}
+	device_unlock_if(&port->dev, need_lock);
+}
+
 static void cxl_do_recovery(struct pci_dev *pdev)
 {
+	pci_ers_result_t status =3D PCI_ERS_RESULT_CAN_RECOVER;
+	struct cxl_port *port __free(put_cxl_port) =3D get_cxl_port(pdev);
+
+	if (!port) {
+		pci_err(pdev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	cxl_walk_port(port, cxl_report_error_detected, &status, pdev);
+	if (status =3D=3D PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (cxl_error_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
 }
=20
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_=
base)
@@ -483,16 +613,15 @@ static void cxl_proto_err_work_fn(struct work_struct =
*work)
 			if (!cxl_pci_drv_bound(pdev))
 				return;
 			cxlmd_dev =3D &cxlds->cxlmd->dev;
-			device_lock_if(cxlmd_dev, cxlmd_dev);
 		} else {
 			cxlmd_dev =3D NULL;
 		}
=20
+		/* Lock the CXL parent Port */
 		struct cxl_port *port __free(put_cxl_port) =3D get_cxl_port(pdev);
-		if (!port)
-			return;
 		guard(device)(&port->dev);
=20
+		device_lock_if(cxlmd_dev, cxlmd_dev);
 		cxl_handle_proto_error(&wd);
 		device_unlock_if(cxlmd_dev, cxlmd_dev);
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2af6ea82526d..3637996d37ab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1174,7 +1174,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINV=
AL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -=
EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e806fa05280b..4cf44297bb24 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -297,6 +297,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
=20
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 6b2c87d1b5b6..64aef69fb546 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
=20
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pc=
i_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
--=20
2.34.1


