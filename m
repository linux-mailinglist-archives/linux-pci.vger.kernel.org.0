Return-Path: <linux-pci+bounces-44827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F300D20D91
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07CA30E9D6A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EC3358D9;
	Wed, 14 Jan 2026 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y0KezVl/"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B83358A3;
	Wed, 14 Jan 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415321; cv=fail; b=Vx6K/9kamRDQYiwAbbD2GZ2T7JXg9uVDVEXib4xgVY6VlPKvXCWvTi+fsvta1xGvDSLqWz0LOd+rgC4vfkDirsiCIicDbjTX/ixw8XT5RVRkRS/wB05lq+ghHv/TjEEN3y72LMkY6v3wBFJLhBvPSKSBxR5wDEkcYKqCyyiY5JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415321; c=relaxed/simple;
	bh=QdlhGXyr5rrh4c0cgzX3TS3Fwwd0F0UKa9xUUhcCYTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEVFMsp0DI9NC9F31SMXh7admzEiaIH3Kmm0ekwPHRVAoX1YVeTs9NPg/MVt260qYwyLumuaR6iMOR++XItraGKAx5jlPnXzzIW5kmC4Y75kevIdewtPEo01ZrLW/etJfnT2Del1YwuoxPdAX7SJ2JVAes/fzBEC5reZ6OvtK/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y0KezVl/; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk6h3Uh+4AHcPHuYtziIzCbHvMEN38Zop24xyQbxz0BLwl183ZTl++e7JpAsx6QatGSbLscy07eqzIyZenorQfIpdKuh9G2ia/T+kSd1TcMGMa7EwNonkLz2sKLmtFHXncD92+3AJ2dxfgvlqi+SC13eq2BU2UPM/5TVMjGVh++Hi9WT+73jGGZaxekafFCTomhHtFE4A7hGsN1sDsLPNxIk8v6CN+p5RRx0skwpKAbhQGoMhUdyLTsOMzXXPmuh6yO+akTgcMXEB0nt4GnTH48mg745p7GIaBcgOBMx6unmwTx+3pphTlvWh8+zWKDB+BqkYwVhGVIpL/s1fuXuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6P4Zx0k1yJqpWdRJJtDgNUUzH3Yc591BvAplAhmIr0=;
 b=UGAe0/eEI4y+mSh858A51AfLf/2VUUCjZLWlcnDNBOFODG5e5iIDdkIpP5s1Jwc1jogQdLZOzTmNQONgq4UPUYJwtme1pFhzrHqYyJJ2Fhhw9I3Ya/WIyx7MPxJ4zcmr+Lj3T4AVROsPZidiDJvylvtmBwo0g4rwLQlaOeiyJE+XPIBX7Mwsub64JqrfPBT4XZ2JxbeL5ImoQGomuWu6PGNm+uONfST4oXqurEBL8hT4IEefQTZb5nNQgDDBYildSvLknZA+3YtvC3gmH1WzmNxiRbM9hK8qcEayK/BmqtbNZZcBwqIQtr3J5qIbaujTueMG7j9T5WLQiTqG0TdxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6P4Zx0k1yJqpWdRJJtDgNUUzH3Yc591BvAplAhmIr0=;
 b=Y0KezVl/0PCN7g+RSZTedzUlpqaQ1V2yg57+FkAymWmj/Y/hWmEtyymr5i3BGlFh9P7b/ekqrSsl2FcSse+RfYxxhlxlO51IAsqj54evzGlRFX4IPHJrZzSdmHf2K11vqzEKxu8EmMmTp0nAtoTYUj+BRkU+JwapfETSCtnoLXU=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:28:30 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5d) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:28:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:28:28 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 34/34] cxl: Enable CXL protocol errors during CXL Port probe
Date: Wed, 14 Jan 2026 12:20:55 -0600
Message-ID: <20260114182055.46029-35-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a6468-87ea-4ae5-a551-08de539ab761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njpaprj8J2pkltP9ij9i57PbSHeCbffzutQ9ZB+oRmKBx2z3bANq/+mPIuUr?=
 =?us-ascii?Q?QjsbI2zMGVfLvIhqf7yRpXaVvFmdW79aQhHkdU4VTUd0R/cJU8iVx28xIFFG?=
 =?us-ascii?Q?aiILuxrCx97jQyh+bsvsZvUtlqWoxmAMQRfX9qyWCRgcaCIr816kZzXuhO2g?=
 =?us-ascii?Q?qgaP4oGgDxdgTuFvcKFR4YMt17JscVKVvR+2ZdGVkP2l8cmZpgBEQIDnjW+P?=
 =?us-ascii?Q?W2JD8pz2EmefVetXWP8SSYNRMbHlw6iHfnDscE2Ou13b6YsCdvnRWBbJ/Ukj?=
 =?us-ascii?Q?p82iS+j5uwD/p0T+TyiMCM7QNrv603j+DFKP7wnUQ7imUCcaBUGsG7t5ogWc?=
 =?us-ascii?Q?fD6HHMEtAPNGjQAOuXka0cPi/u/iTxvz+0EFzvvLFzNKnVX5wKowIzDPVpI6?=
 =?us-ascii?Q?RDsxQKOyCdHAXEAF+I8GcKNEPp0bEuWZHEJ+qxOFMEyfRg3OXcv8j9T6Gwzg?=
 =?us-ascii?Q?CmFuXGLjkzdG06zKd90Y4w76RuG/Bam3/QiGhDmKj6YLHTISjHvOzSw6g8qp?=
 =?us-ascii?Q?SgGwC4gfwHab3rRZcNfiNrreP0OwEG0V88f7YpcYHpmOsyjBKhH6HS87EQHf?=
 =?us-ascii?Q?V57G1vkb+K8IW+ltDADh6n6Flks1oawZNOY0TRlUrXePqHT9cJi25E6/1TG2?=
 =?us-ascii?Q?4Bh6fDrSbJSg3fZkrNfXaOKLE3/QcUS6deR458s5ILJR6B9h+T4pp93SqPO/?=
 =?us-ascii?Q?MpbtdGlZSWGIhPMLKdE6Wl+s4b0PNI2e3vThAAzr92rNUFV2ZCXI3ud0brXx?=
 =?us-ascii?Q?AgfJiuYmW1Caik6olh+5CDtAYhbzaGHW7+SdlK5LMMyiLsVnfcRtRqsxvCxY?=
 =?us-ascii?Q?zWoSZ5r9G+ULvTx4Gxt2GmYz8C2DwMxyv0lPw2Q2UcznOtN1mg0HXIhk1VNU?=
 =?us-ascii?Q?eVYm7a66o3uba/RonMz8S/SWyqtvUHyiy+E8UGUP+vOO7uREACSfIcReGr02?=
 =?us-ascii?Q?UUFubBoz7q9z3yjIZL/pSZKkQpFsUgVxGtdrCnX1ByX4qXrWzOS+wUnVYaZS?=
 =?us-ascii?Q?lyWRyJ0CKIyo800Ckmumc51jqRhxkG1GUfzYhlLvxoln5maBSPp1stU3ZE5D?=
 =?us-ascii?Q?5UcqiFbGvQiHuMO7S/CubkZXM1cdGBF19/8uS+LuvGoXc9rZ7tOTBelL9gMz?=
 =?us-ascii?Q?fXmaUZETvq6yTddJq9JThrj6dxc9MDYQe9vLbo4HSbhFbJdFijxlyr6DA0f2?=
 =?us-ascii?Q?KeU6XRPxqWc/qIqGzk0+sy+HYbJ1ERgdks1sN2fBE3zD5uBqRqjAeXJNN41J?=
 =?us-ascii?Q?rnnxBqdTvsTGdE1hKDeVnoG9enYPUr5vlvl5+VkFvoUmtzQj/AC+1+G6xR8J?=
 =?us-ascii?Q?KVU2RTbiTnVLfl2D4FFkWDViPtwwDtEwzehIQJjMKf/nJ+iOEj0AE+059FXW?=
 =?us-ascii?Q?eth3l7uAHfuIuB00ExQHYM43O4Mgk/ft10W+/unRv90DXWURikkZOD6c3jgG?=
 =?us-ascii?Q?N/msiNWhBZ7+YpVqbop/SfV60YnwiKb/pLwVd1CzDrU/2UZKoQ3LWVJ/8iJv?=
 =?us-ascii?Q?KY+q/8x21rmoOE9y91BAxMmqWJZqYRx9KCtV9Yt+cLnNWfmP9RE0/nRCnTYy?=
 =?us-ascii?Q?8DmtpFUHEq4PoDMSZVvH1KgL5cih2chT4PcieGkXSJWbUifexthAY0m25/IQ?=
 =?us-ascii?Q?OuYVHImnPv07/QhTIr2D2cm8fPXVfGtz4GQMSogub+KfypQ0L+3C+hFdD8zq?=
 =?us-ascii?Q?cZ/sotUO8UQRI2VO8qn2ehbkS6c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:28:29.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a6468-87ea-4ae5-a551-08de539ab761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v13->v14:
- Update commit title's prefix (Bjorn)

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None

Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/port.c |  2 ++
 drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
 drivers/cxl/cxlpci.h    |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0bec10be5d56..588801c5d406 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1828,6 +1828,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
+			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 427009a8a78a..e299eb50fbe4 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -117,6 +117,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -127,6 +145,8 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 	else if (cxl_map_component_regs(map, &dport->regs.component,
 					BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	cxl_unmask_proto_interrupts(dev);
 }
 
 /**
@@ -159,6 +179,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 	if (cxl_map_component_regs(map, &port->regs,
 				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 3d70f9b4a193..0c915c0bdfac 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,6 +89,7 @@ void __cxl_uport_init_ras_reporting(struct cxl_port *port,
 int __cxl_await_media_ready(struct cxl_dev_state *cxlds);
 resource_size_t __cxl_rcd_component_reg_phys(struct device *dev,
 					     struct cxl_dport *dport);
+void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline void cxl_pci_cor_error_detected(struct pci_dev *pdev)
 {
@@ -104,6 +105,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 }
+static inline void cxl_unmask_proto_interrupts(struct device *dev)
+{
+}
 #endif
 
 int cxl_port_setup_regs(struct cxl_port *port,
-- 
2.34.1


