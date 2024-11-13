Return-Path: <linux-pci+bounces-16705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B39C7DF3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5414C282EE1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D518C935;
	Wed, 13 Nov 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OVL6WzW9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630E18BC1C;
	Wed, 13 Nov 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534961; cv=fail; b=LYSEC3lE0zpOm7QknxHNPU0jjr3A88kHE1DgsmpdjAijz/kHMPa4sRxiFcIiUlC0gYsDugeJwVqWgg4aSvBKyelxMj4BoHXN3kBD85OTfpoI8hEGSv2heCaRMNyeOEhOfDGL5eli4v0c+5pfbfub7bC5lrIh0txRE3vxiFYONi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534961; c=relaxed/simple;
	bh=8xGq/MeWzcmAMrubEu+pEg+RraxKCSkkn6UBLE3hBLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTUIJ5OpNKGtcv1h7cEX6T1Z8GqmZ2VTQBdS90LpPLp1q5JAfuBZC7Ak4wUpPWDCNNtHdGoBU76p9wjfDcCF2xaFdgUpELnckJGC5d7EUXgtQtSO4eMC0kNYJAOr+ucIa4lDPxiOmd+A/PJWEMKRnLSEdGHdlYEHEU/eJCL4YYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OVL6WzW9; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjoXGzj4HxYpxo+UbOcRLj2hWW11lCAiSMUdP8bRgEh6cGxkC8olC3BTNUeMyn+d0CDwPXxPqQRqxeOxtC6CHNnR+VCtY03GqNmwtqEzzx1sUeNQmq1JMoIakJEQnvTUNgxA1nIh819SJ2Zk9xudGafJRlinhVHv3yTntg7rxsuJJPJoyfC9/iZgPScRWo5QCiNAoDsILLq3pRXyfU+duMqdCWX9bCUhTGhhR22BWgeV+4DhGVsUszU3KXloDVEoQTx4ogFhsrSHm8/YZgnUJlNCCR9WzKOnfw+zT3Kx02klWuAIfKOywDxYM9sovNlSOHvLQWuwDXdlOuDGFWQueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mogS2jRrrsbSXQIMvGyRlxmRVZNVPBKKx/cyrkl7ljY=;
 b=ZV1WME188Yc3c1exvOCBBFgQY8VLDYHs+WffGwLE292KiyAWpYd/NSReeGRTAc/PxeDjSR9is6gN0YZMnTaSMBQspCpNCEdBN5p/121k7XeMltoOSlBVc3UrMU+1emGxoKTF7p3oxEq4z/Fisan1wXpi0cGXxtFX1ZT8skVW9y3j7ppWsFgJEMVyI2ign+tSMu/GfitJZ/RPrt+qQnqFVo3+VZ6H09b9qhVtujnEpCSPXu0SYr03fzOFcuPHNczaGbYzrOy+UbnggfkEe9HUvIzzzj0W4HTNEx9j4ot8eVYypFUBBW6oPLsrsuX1P7VMRsE+D975h6+mn34ya+TkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mogS2jRrrsbSXQIMvGyRlxmRVZNVPBKKx/cyrkl7ljY=;
 b=OVL6WzW97TK67aZnWfsUGW4XSXvn+dzBtsn+D8OzhMb0z/pho1WjP4F1jjfyAZUfS38jw6QXWHIKmG5BheAcfvJm7nZPF9c65LthZXsj8RdhSK6ECVWX2DEEivWXEAbMYK+pzNoLnISiMotH1aqpapa2fjhCIgZLeofU0NF0+RE=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 21:55:55 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::f7) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:55:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:55:53 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 07/15] PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service driver
Date: Wed, 13 Nov 2024 15:54:21 -0600
Message-ID: <20241113215429.3177981-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8ab243-2e88-4d5d-a0f4-08dd042df2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aOfDuntqk4FH16WzpyZ9P0KOWxoDALGccd3NQnLDFYhdndR/JJPcsvPLgxXC?=
 =?us-ascii?Q?P3Nr4qQUxOToUiy20DzhiNxtEx55tuiA07Og/o3Vkvsd+MDPz8W90BY5e7uD?=
 =?us-ascii?Q?4c7FkYbXfcqVbHr6I5gE3bur0JocrUdiNvT2w8aPzfVvCnOANiCYF5xv+Q87?=
 =?us-ascii?Q?HlFbK45FSN+mmcltGAQHRnfkE7eVr0kBWHdMphsX1xVDyJeL2ijbOMKBLoz/?=
 =?us-ascii?Q?tgfPUVjTjWx8vgUl0NtyAUtssu4UvflKZIbXcu01GR62OkMKmQWhXp1mnZj/?=
 =?us-ascii?Q?hhB3LxSZy8GC/IerOk4eLNoza/xd4SwvkkEz7dl30s7vGpM7w/TSUhMZ9bVt?=
 =?us-ascii?Q?27HDLR59oLbIn3d/nqt4LDATvPvtlDjelGH+sH53MaBJ4hASlqozUuBsT1By?=
 =?us-ascii?Q?ZXF56Df8JUDyv8ax4lM4NQDH/ALkNj2xx0nZ0f/k+U2DCRnFfxnvkM8ehQbT?=
 =?us-ascii?Q?QW/nq0WY619arLSgLBqD3t3kStoG0fq2dlYFmSabmaMyjnumGmPUYNiBuv7N?=
 =?us-ascii?Q?G+xMy4orl5DAVxC84c9ydoJMeVfn08dLTIo28YAsp7qH8udO1K3ycpABfALD?=
 =?us-ascii?Q?iQCkLnnDr5ofad2LfqKleQJf9rwOzuckxfJ0ZTUa7J1zSpAoBns6TzEHa/Y+?=
 =?us-ascii?Q?RXIyo8kA0ybXFA8y8nuy/63tIy+1td2dMsKu+kAi1g8fa+nhYHMhDADTjd4C?=
 =?us-ascii?Q?KsKzhJGHqCr9yMdsCkHyf9KjnJ+JMNXLtXKZbDPL47k41p+eTIBOw50oSAko?=
 =?us-ascii?Q?tXiB3v15iqtscs4IL58pmqJ6XOBCd8VMZIFNk4vYHvwkXI1irvh3bfbW2Ahw?=
 =?us-ascii?Q?5SCUr32os0ohDFVAduxoDZ3Dye0w95u1Y3fRgmH5qjAv+YQjaoV7VHX10rFC?=
 =?us-ascii?Q?jya4xJ0kG09GGpXCdovY4coccWxjT9PbsV3QTCVotHvYmFJsaXAHIQPjq4wc?=
 =?us-ascii?Q?okiYXxl+hiS4P1cV9kJ6IVpyAd56UmBirmQokVwYr8mWGoSqahBCNwRrpx7I?=
 =?us-ascii?Q?PMtfQ6Jz6QLn9mEBDi7hGlbNsbnoXXlWd4d6I+nB6ygEfjCRsqdB0pP05o5W?=
 =?us-ascii?Q?1ForRvpfDwiHjOWgfYEjUehzq1X+b3XbGq96GWMiKCFEk5jtxuxAy+ym1BIp?=
 =?us-ascii?Q?M2+uHWlAoymlvxaCMlMGWV+eJuQgNheMh9RWLC1fDWWZ3YPmcJfhl8vLbJam?=
 =?us-ascii?Q?PzwpBLBn/ZIZt8KXcaa1GPRQPuO0Rz5E92mwaJfABYHmU7LyO+Fvif8KA3Rn?=
 =?us-ascii?Q?NqYKGkMGMRe24s2IZlrXOf+tXiVuPMUAbTFGHSzrRIsv9eEvMfFfKpsCwRpL?=
 =?us-ascii?Q?9nDP+SfKzILqcXuiURZoz3LLBneDe+A7xl7pN2bw3lHa68vqGrvY0m7Ws+tl?=
 =?us-ascii?Q?CbIIcJS+Wpkjl6RwtVo4bon4bJAvPNXAknsTITmmESKIjnVLVvgFDsoCoqs2?=
 =?us-ascii?Q?90r46/6k09s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:55:55.0322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ab243-2e88-4d5d-a0f4-08dd042df2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
apply to CXL devices. Recovery can not be used for CXL devices because of
the potential for corruption on what can be system memory. Also, current
PCIe UCE recovery does not begin at the bridge but begins at the bridge's
first downstream device. This will miss handling CXL protocol errors in a
CXL root port. A separate CXL recovery is needed because of the different
handling requirements

Add a new function, cxl_do_recovery() using the following.

Add cxl_walk_bridge() to iterate the detected error's sub-topology.
cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
will begin iteration at the bridge rather than beginning at the
bridge's first downstream child.

Add cxl_report_error_detected() as an analog to report_error_detected().
It will call pci_driver::cxl_err_handlers for each iterated downstream
child. The pci_driver::cxl_err_handlers UCE handler returns a boolean
indicating if there was a UCE error detected during handling.

cxl_do_recovery() uses the status from cxl_report_error_detected() to
determine how to proceed. Non-fatal CXL UCE errors will be treated as
fatal. If a UCE was present during handling then cxl_do_recovery()
will kernel panic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  5 +++-
 drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..5a67e41919d8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index bb34e205e082..87fddd514030 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1048,7 +1048,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
-	}
+	} else if (info->severity == AER_NONFATAL)
+		cxl_do_recovery(dev);
+	else if (info->severity == AER_FATAL)
+		cxl_do_recovery(dev);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..3785f4ca5103 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	bool *status = userdata;
+
+	cb(bridge, status);
+	if (bridge->subordinate && !*status)
+		pci_walk_bus(bridge->subordinate, cb, status);
+}
+
+static int cxl_report_error_detected(struct pci_dev *dev, void *data)
+{
+	struct pci_driver *pdrv = dev->driver;
+	bool *status = data;
+
+	device_lock(&dev->dev);
+	if (pdrv && pdrv->cxl_err_handler &&
+	    pdrv->cxl_err_handler->error_detected) {
+		const struct cxl_error_handlers *cxl_err_handler =
+			pdrv->cxl_err_handler;
+		*status |= cxl_err_handler->error_detected(dev);
+	}
+	device_unlock(&dev->dev);
+	return *status;
+}
+
+void cxl_do_recovery(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int type = pci_pcie_type(dev);
+	struct pci_dev *bridge;
+	int status;
+
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_UPSTREAM ||
+	    type == PCI_EXP_TYPE_ENDPOINT)
+		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
+
+	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
+	if (status)
+		panic("CXL cachemem error. Invoking panic");
+
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
+
+	pci_info(bridge, "No uncorrectable error found. Continuing.\n");
+}
-- 
2.34.1


