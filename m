Return-Path: <linux-pci+bounces-21192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBDA3154A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FA97A3540
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31415264FB3;
	Tue, 11 Feb 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTglXpJ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B8264FAB;
	Tue, 11 Feb 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301912; cv=fail; b=du+gwynk4hnv73pU/hd9SHSwFAFfgJ5EDclR6q0VZUAce3wkHCxs1nc10OW/YO3IaNOOH5fZTvd9ZsxBmWwzKsEzUFUKc0pNKayTWYJYQBbY2obphaC8els8L9VLatwPOJ4g1yL6O5cfHlNlp3Psif1DHvz3vSsvrhaixbnINwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301912; c=relaxed/simple;
	bh=9JDcgC8d/bCnUZ4kEfK0wY2IIiEY/EpgUp7DX2b/9hY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZOfbOWqIEn0OMRDqNbMIzGQXhg+Uui4x5kl3YY8R43e8xQ1B080asyTgcc/Nwg4v8oG/RpSfz2GICkDv2686i6AmNqj3RtT6Iq/vfEbZXPi3xjC5CAp0nphqROPwRRFuIJjoU1wci6VbjMMo7GCoHxYhNO5/USGY0PEab5RnMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTglXpJ3; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4Lfsp5xngZPfsBAxH8Sgzyi5sx7nZsOKrTNxAhWeh1mOGIyXNM/2vauluFuqZ/dGHPi/RaBPZUK0jbbZYyA8M5jmgrKJXdohEF/TThvX2wvt8v+J/wIrn6zuJzeMSu8mPvdWEZwdESpHPPsihbUZ6WnjDOn4LL4YmnSV8No37InDiw7OBwFAfnRqKGIThvdCdBblpkJqN+MnNR9DiOie3ct2hjJ+tLsgoZxDuB5SR6JLgpMe+VR4r3MAzsiXq6cwfT8fxOnBXaqQznSGBxoH/svr7Rv+puup+bwKRbLNj/7Grsrbzx9JKoAleSAQY13+KLdMjAH4SZZoZQv2um1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcIayVX5NDpKC7/iFdgEgOr6CFd1VVJEE7NSu3u5fSc=;
 b=Yu0lQgqyrSVpX4aTQnnQ+AN3LKc5PIEjm6ZVlFkTIE8F7IIuR4Nq8tNw7suDOKGhQD3a/7rcz4Tmj36/z8rPDaEZmrrIOH9Fz336r5TwBaHnhvGU/FpYprYOs8jOviZQtC9w0BSEe537i9hBGOH5bg1P5TtQN+rMTa/QBqPrgUDMkepYRAuRCQdY7zAi+IHKahfDmk6zHy0ZdwdWzjGMRkYyUs800Z06bWydxYuaPAcAY+TOt1eVwdOZco4vg4/uDTVAxbBwnuND1ksvug9XL5zz04HrWYT38FMM4/C1C/SndwAtrNnt+TNjqT/MLbvUAZGmxLAab9nZa/B5bt6g2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcIayVX5NDpKC7/iFdgEgOr6CFd1VVJEE7NSu3u5fSc=;
 b=NTglXpJ3gE9R2tFfP5bOeCGTpHDEVIuvWYtrk5LLvbMThWAG3j1UOCXZfYWE7fGMLKp9s+/cGCcRijZG+dzdij+OzMIL+hRcvFEnpVkwvl9F+Jbo6JIZiFhaaP4ndQOw5rmAiN0G1FNONHfsmklrw1ue89MaMSDw+bb0IjI71Tg=
Received: from SJ0PR05CA0144.namprd05.prod.outlook.com (2603:10b6:a03:33d::29)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:25:04 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8a) by SJ0PR05CA0144.outlook.office365.com
 (2603:10b6:a03:33d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Tue,
 11 Feb 2025 19:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:00 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v7 01/17] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Tue, 11 Feb 2025 13:24:28 -0600
Message-ID: <20250211192444.2292833-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c5fcbf-597e-449d-a43b-08dd4ad1c8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEzlm0zLacqQH+SvAj908lzCYYtDfOio7sZ53pAuHJ6ziwj6uB++0kqdH3Qt?=
 =?us-ascii?Q?Ex1uov1e0KApP2ZGAf50sKF/ARDA8fEvQBmlt0sX+b8F0DaE38KxTOnKhmV6?=
 =?us-ascii?Q?wd778EjU+W92JwhCmxnf4ZPB6F5FOKZsAvUfB+boBmYSIFUDH6dH5tdQkI/t?=
 =?us-ascii?Q?eAOIR0VzZlLfYPOS6GLDs5auJAwZ5un1rjAqZ7PNTFZB47pWEodj2RTq/5WL?=
 =?us-ascii?Q?nnz7BJwrzJOJlGAtuEpMkv0nqbq9k7aVSXHVMu9cVRro5iAgXqvd435x6jSm?=
 =?us-ascii?Q?6nCAoV+gcYns1uGRjJiIuBbfb+l1dFSgyzVSvnR//uF5TQJ/zh6xDkt6oP3G?=
 =?us-ascii?Q?ADnOGKLyRVHszJXiVS3tuz/eq8vbtYCcR8zRJib0OAyOFUnFVAMmCOM3+8N9?=
 =?us-ascii?Q?FtZjgEmr5ylC5MLfMFkURecMIQcNly7EW/SBEOme5gSuA/4Yd+EJq234C7jf?=
 =?us-ascii?Q?/zS+wu4lTZsiViu3UpeXh2q3pu1Y/Ld2CM5WWkqzhHK5xQRkqOdSADgDU3FP?=
 =?us-ascii?Q?3blBgra1dLmkzIfuchyK85ClRGb+8ly/FknZm+z2OgHBk3CMAIW3AKaddgDZ?=
 =?us-ascii?Q?ZNOIRVoXkOyxM5QZmHMYDQjzsuWgkvBhqoXvUuTyLZnOKTAyYZCiZeq/bgef?=
 =?us-ascii?Q?JmJZg5u6nkeJw0HP4lNZHqoiFX8Ma23Q8kzcNerjNiz9Sh7I0oChq89L4VMT?=
 =?us-ascii?Q?WYFC+j82/8CeMyB485rBIsLXygePTWM2KTqlcbPSvmep2jwq2egiB2bQo0n0?=
 =?us-ascii?Q?eMF4HYsKXXUL35p6Z2v7yI7Y0PCttOUedHygYH/t6kHwq8kKDAehORgbLFRz?=
 =?us-ascii?Q?MUMW1q2Tg1dNPlvE6UU5e3twhkyBZVWoqLdfvW4LJVjjPvavifmM/G95nAay?=
 =?us-ascii?Q?GFlUROh96PYDMWxPm8aE8MVp5BvarUhLpebKiJZfItNxrp/3fYpDwfhHmPzt?=
 =?us-ascii?Q?PcRyUFqlXLBWC32J+4WagL2QHHVia/Q7xzpvzSUlYT4Nz4uC0jD+/RIA0MIm?=
 =?us-ascii?Q?xg2GbzjptgagxguSeKZgr4sCyslqe/sJDH7uEx/X3e4C6jGhcDG0tH1DsUmD?=
 =?us-ascii?Q?Jfi9GCvvHVtiwXTfym1pAcbREv8tXn0ss3ZGkru70Rl81waofswUrosvQ3dz?=
 =?us-ascii?Q?ke3Nq/7F7g84AH6uXAgMr+8FX+WCgIKzlZlCVgQXVvUkn9iPEQAUpG89IBTk?=
 =?us-ascii?Q?o6e+CerZHjufrZDRn+8uYelkBHCb4DNs8ZZFDyoA4Fe0/TUWYSr4gYTvA67c?=
 =?us-ascii?Q?+g7CENOklQl43GaIMMrRh1HgVTOyDL0FsWZ1OHKWwZkk8d3bE0xJQqPdTmWA?=
 =?us-ascii?Q?mtF6yMfphGPCVVEPttBSENzIvZpF26G8+lSg9TjWQFlShW0qDbAu6IEwsH8m?=
 =?us-ascii?Q?vRQ/xCrjNdZWIn2SfWkxAJkeH4EqJMBb36GDzqd1ykqstRcME/G/Y4vqRDWu?=
 =?us-ascii?Q?0dc7druICDTMaUlfsh1stc3yDAMliG8ZaZTEsmbIK7jGFV9dOZudh2dPFavU?=
 =?us-ascii?Q?KobUkTOVMaxqa1LjGmV34Bnks6EsdQ31ElCh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:03.4618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c5fcbf-597e-449d-a43b-08dd4ad1c8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

CXL.io is implemented on top of PCIe Protocol Errors. But, CXL.io and PCIe
have different handling requirements for uncorrectable errors (UCE).

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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 include/linux/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..1d62e785ae1f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -884,6 +884,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* Compute Express Link (CXL) bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	pci_ers_result_t (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -929,6 +937,7 @@ struct module;
  * @sriov_get_vf_total_msix: PF driver callback to get the total number of
  *              MSI-X vectors available for distribution to the VFs.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ * @cxl_err_handler: Compute Express Link specific error handlers.
  * @groups:	Sysfs attribute groups.
  * @dev_groups: Attributes attached to the device that will be
  *              created once it is bound to the driver.
@@ -954,6 +963,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


