Return-Path: <linux-pci+bounces-16704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76729C7DF1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3880B1F227CE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542018C913;
	Wed, 13 Nov 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ihOmZwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A018BC1C;
	Wed, 13 Nov 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534948; cv=fail; b=mNxkTxbcM5xGOvW7EH6ZOqq7iQHoq+cutxuost5nCjAZIwoGGi5q2XGHL6405dlXRSdGGjLgQoQ2dHrrHw5gjobXqzS7RyrzYUwK7DdxLOydnW56jlimwkp6Dgv9S0H8A8ivdkknhGLrWhusYXJ2iMjcEl5B9iU+1Fce12LltAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534948; c=relaxed/simple;
	bh=K/5CxlYC+Btn9ofbWNUga1o2Z/tRYNFfnbaXXpOBgko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG2wRithX/PRDdl/jNqAWEZgv6CoOYSGN6vYOXAbydnIjJncMkTWjFHWBcAKmm20BalrvJcrG0PGv+gKhnThoT4gU2S6H+68tvAgEEY5F7ECjPGN5sRJBBapscn2pikfcsVBaKWiAMYYzCK6nFNNEPdzZWJzGuJbS/baAGFpyo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ihOmZwy; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLZdGQ1fPxfq504rmGh06eKBUIj/FQ6P6mfwzKJmtxweweO4R70psKPtrO0QCMENfh3CJ0Up/kfSpEnN/xzgMlw10vV/nbJFSVyzJeGnGu9DTpLKJCocQXQBE9C0gZF9dsar/5x9e91BsR3ZQ6ELQDpie/WFC7QIbdmn4LNNoojU5QOAUr3va1JsnNbcIVkqVgTBavpCEYVA4V0sQvvIscSeSYRi8wlOrZWCDtxSLnDuU0nq7NutnZvwi7JwXqaap6c+xgMpIO3WuBmfobO/mqBpXuOiSNT/0WNoaK2JkdLktaKH2zoJiWbb1keCDYr8+DqN3UyVi913WhCfb0l35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inAHB/suUpNF3fUaxR3OH7yBdeVutW5FH5wvfz5UWww=;
 b=vsT+18zmEQouc68eAAcA6DfxTN1YlwR23aA2t5faOm+IEeZF2dOwTKPXs9h6ZEt9rIxOzLvbg00XbtD9YsVS/XDrW++x5eoYc+H2A5R7E3mzfqavEWxN1uXgFJ8TnV7N2T68JaDOPVtMu2HNairOlGIZGAy4Zes5bhrO8fdDFJSUqbopP+o4+/VUW0k+MbUx8SJ2HMPyLQdqJE/+pAP5//W/g67q+rRWdOUJHfTgjceClpg4or1F4shHMUrwmqNqwO/vhDMVCRjNsTeCyg4F7VXlD+bkh0G5S6Poc8aOC2GNqhlwfRN3dqAVj+nS1O1YekzPXgB3c4+aISJQ2GkuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inAHB/suUpNF3fUaxR3OH7yBdeVutW5FH5wvfz5UWww=;
 b=2ihOmZwy7+JlG/yIjZUlhdK/hOlMZihdp869Ku3vrfBwk+zQYOAFa2anQd27DFctCCJ5nSNf6KCYGgA12HaYJWI7ZeVsxNA35BUsveXRXBBpva8Mc3k/ho5VbseqWbQ9fpk+kQM+Y+jlDWtf851wxmUemnFM0oeQgoGCgDXmUmM=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:55:44 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::45) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:55:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:55:42 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 06/15] PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe port devices
Date: Wed, 13 Nov 2024 15:54:20 -0600
Message-ID: <20241113215429.3177981-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e65030a-11de-4334-fe0f-08dd042dec61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYZj4SSkmnalgPjdw83zPb7SqFYYs706d0WzunpdOCwXEqfX5C4iLgL/SW3O?=
 =?us-ascii?Q?3LOyXlCra42DmPnSGD5yFeRv4vmvHJCSynxH0GjQUsEP3tZBjJM3szPgQnhM?=
 =?us-ascii?Q?pDeEv2Ux+rhF+4jtDc3rFNL+1ncgonbLxc3yg5v/UZMXucZKz58uHhSf1DVD?=
 =?us-ascii?Q?q27Oieoh3eksasc06jDIWmXneYVjZZCLDh19wMs5fRhnkC6TFWniP8UO8hpR?=
 =?us-ascii?Q?B3XfOH1+dw+PmfuuxhyucVfiAl0a09Q55FT9F3WrE46GkrwUH9W9Ia3L0H1d?=
 =?us-ascii?Q?MvJ7t6YcJYmcPGC2a+N8HukfF64nuvw0Ck2xDlbR4a7mZL4ZAgfnQqq4gr2f?=
 =?us-ascii?Q?eejVux4pXccuPJHpMSpU1j+ZzMhmIlEhGKVaSbP3AgkPu858CHjg/iv4oVjv?=
 =?us-ascii?Q?Jc4i6yHVXBQqYK3NlW+Vw8FPEFY8xOY6cDpTZ6zCeyhNupYJXwLBI5joswwy?=
 =?us-ascii?Q?h+LmCHpfdqseLkk9HM4AjAnqsgoTPh4vBZvoX6xmMFZBlV0Nr74thA9Bqwwf?=
 =?us-ascii?Q?mN1uOHs3cLlKfLAe+WB//I21M9y5JH4DN2xkaNQ3r3MwXVXKNaQp3WG9ircu?=
 =?us-ascii?Q?EnZKATpNa80ixMNmOuDHmFMj97enYrTk5QZixua1PHQgGEWeDB5+uM0l+W2f?=
 =?us-ascii?Q?sBw52/yQnMfJFTwqj2wH0C+uStLpWVFUtj2eLk4dxyWEAuYLsdP3cSp4IzJc?=
 =?us-ascii?Q?vkIcjmTmdiXqhbmwJ8soqOXOhuv5SDpqZOo0jEtYg2VZbEkLTYKzw+BbwiyT?=
 =?us-ascii?Q?G2XRYyGZCfr6fujnbLugGMaQdLMIekN9E3JWMDj0oTlF2+JHoU9i+8DQWjzt?=
 =?us-ascii?Q?uX3TCewSLWEfj7xzbQ/bdbFmKbYHryu+2EUalvBk0hlThBrABtLghcxECWio?=
 =?us-ascii?Q?wLmSvv4ZDub/ZvIbb4gyl/A7CXHiPljnktEg8Ng+VuL+UdPO7F2l7fBj14vR?=
 =?us-ascii?Q?qLhs0dKR+S+39B7w2nVNX75EYdK3kY3G4D+dQMcHNdU9En2XDc7zpfKMRGO8?=
 =?us-ascii?Q?o85muQi4DImx0s3hCZf3Jwze+madksZourM/UcsszT7RNqN+NS2NiCNQbhGs?=
 =?us-ascii?Q?M+KmFekbMb2Pk3XTugifbn+YzISMLgS16V5wd53mjgwu0OOKeXCGMI1NQe2i?=
 =?us-ascii?Q?fZ/WbM+MSqUccZ67WioTzaeiVaQc4+WYtBM2cMp4Jj2mA48oZKeTUqDB0+xX?=
 =?us-ascii?Q?3K8DEuVYAm+sBUA2c2P2zw5ZbGmaBxan9FlUCbWq4HttQOi8xnsDUoHMhce7?=
 =?us-ascii?Q?q3Q8IQaGhvfd04u/lNAQwIweknB67ajsTfCPkBmWOmRZYnaRSKHE4s+7Axjg?=
 =?us-ascii?Q?ORev/faPeTnvL6flfaBDNV5O/07xU+56vQtmM2eEBRCkunyWzD+9epFBHQeu?=
 =?us-ascii?Q?dGN2fPXLZJ0qF496HK60mn6cBCRfnWYPK7OUEKxyTWWJ39cYkwxqnH8L5lb4?=
 =?us-ascii?Q?MlzhUcPt0oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:55:43.9394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e65030a-11de-4334-fe0f-08dd042dec61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

The AER service driver's aer_get_device_error_info() function doesn't read
uncorrectable (UCE) fatal error status from PCIe upstream port devices,
including CXL upstream switch ports. As a result, fatal errors are not
logged or handled as needed for CXL PCIe upstream switch port devices.

Update the aer_get_device_error_info() function to read the UCE fatal
status for all CXL PCIe port devices. Make the change to not affect
non-CXL PCIe devices.

The fatal error status will be used in future patches implementing
CXL PCIe port uncorrectable error handling and logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1d3e5b929661..bb34e205e082 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
+		   info->severity == AER_NONFATAL ||
+		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
-- 
2.34.1


