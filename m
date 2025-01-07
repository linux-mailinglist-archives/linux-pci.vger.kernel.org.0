Return-Path: <linux-pci+bounces-19431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB9A042D5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFA1882C8B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCB1F4266;
	Tue,  7 Jan 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FpQg2x71"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93C1F37AC;
	Tue,  7 Jan 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260811; cv=fail; b=p3ac3wln4IbxLXSKXO0ei0d65+YcLrUE0ayxtelbpBss3KnQXoScWeeo5AydFlr7zNbOh/ksbCBBvehxAmtvbNo7TBXjvK05rHQLD9KVvHUi0UpgUQZ0paCyttM8JClxz1alq9gZUTP+oxuYkNnEh0eHhCUKup/h5eZmhuhDp/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260811; c=relaxed/simple;
	bh=s8skyk5QAujRf9oNmIjospC71LqYkxtyr5Jrc78V3Dk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtIGJL3oS1g/0Tie4BhLghytddLN9tKBUZWCG3XUNdre5Ul4/kGIfIDAckCfOYpXnJePsIBLhoRFmEDt3bn6p6Kg6rUZk8ZA7iCY7W9KbOyIAKBawFy7EZ1R48lxVSULtHgvXEsqiU9rVwVR2bfT01IUUmHNW75EsVDs3PFKowg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FpQg2x71; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLmzeAIG5PfZTY/GnP4NePcTkQQHHDHL0ryE2nRKaCx9AFr+QofPrcEldvFPXO2BTEDDKBDT2NOHKEHaTSol6m+ol5c0NkqbLPevbdbeGkJtxdvsbmIUTBpo7FNLglupcO0CMY09SLNIMK/2I4TuBmdHtme2DVP8gzOje6ISMn3diiYpOS+w0q2s4p25YfOW8K/zJ9yDTbuSgtbAU0xzWBvXRTRg4bfEhP6tSsOKpm/+XBmWUkiVeF+bNX90sZe0PqjTJXRS4/HiLHoE73wn188sABhZtLx5c4g3DMnMLAv8d6z2Ukh1S4Iad1AICyMfL0fhwASAeIaN4rtaF0IOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOHjqj41sXHixzWV97sXXY1rs10j1wYeahWbALqMupY=;
 b=T6HCyONomHo0l/GVOuYeW7FAPJ1YjLa7yr7Y5pmXwjPaxpm0QmUhf0ppB1nnADyTjUOi4eGy/SorvtP5bcvgnt4xJMIYgM1O7MkXR0oxTSBLT9ebwqy6fWBatMDc5AmsY8hWL35dXGKWYDbyJw+bCvCQ2HF9wnLwFnxUWR45UywAwOrzFVY1Ld7ZXVrH16kSv0TBHW92FKI9JNRDrZHY1mtUvnL2d2TFeHI2GGtCiMDB9kCUdeB0GsrKkI0zjPI3CP6/OqG+Dy8LbXazshvOx5SwRpE2J4XpvCeZ6sfreaidR6/0QqX1R69MYl3YMFPkrmj+dtplCss8Ip5aDa77Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOHjqj41sXHixzWV97sXXY1rs10j1wYeahWbALqMupY=;
 b=FpQg2x71lIEot93RBG6XKOFdJtneTkXeGSjs8BNO+MWSr7FxwrVvGZRZ2LkbUnTBnOilu/OyvXfmgv7N3XtS0ZSXrjl1r2C5YW+qPLmLugyS67Rd/QblF3vk0pDMouSh89Z1cXZqdgx3Y/9CXCq02pjom/vx+oDQ+7cR+y7xfXM=
Received: from BL1PR13CA0439.namprd13.prod.outlook.com (2603:10b6:208:2c3::24)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:40:05 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2c3:cafe::57) by BL1PR13CA0439.outlook.office365.com
 (2603:10b6:208:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:40:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:04 -0600
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
Subject: [PATCH v5 06/16] PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe Port devices
Date: Tue, 7 Jan 2025 08:38:42 -0600
Message-ID: <20250107143852.3692571-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4435c206-2dba-43fe-41bf-08dd2f292d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qImot5KsxOKNQfDMmHsRncE8WrmfiuuGZI0KNIwBYZEAdeLJlhBVCoOd62F?=
 =?us-ascii?Q?E4Ww1oyfIlGpn0nMqzXFZ28zC1TvrZazOuOg0z9lgGXCTsyA4d1PKu/coGUR?=
 =?us-ascii?Q?ijJ20opdbr1/FwNgBg3yhNcqvHHXCINg8J5t6WRTenJYql6E+U7SUGdK3FEH?=
 =?us-ascii?Q?egxXO0POX7J51l4fx2W+kwPPslZxqHDc8C4T7EUwK8n1VgFZo5MxFHeqbb5P?=
 =?us-ascii?Q?Geu+Y2OtMWL+9WkE9MuEkg/3laeGyY+45GrihmEDE+8Wl6WP7kWHkwYQM6UH?=
 =?us-ascii?Q?6W2ToikHo+Bft4sB83wjmy3RZJa5LSuXWPVpcH0lf9qjtEdXJjMJ8xkmNM6t?=
 =?us-ascii?Q?v0rQF0dVPHcQSuq9zObdNrAm/K/HzQsjEOtMknowqD9YrbeupAxQJoseVmWx?=
 =?us-ascii?Q?tOA7/duUfT1GbmCTeGliwA4adnLBDG6pq5TVVxaYghjaUIIwetLHahsKDrXc?=
 =?us-ascii?Q?nvyQOUXyozGSW5yVVk2Qns4i5cC4XENsRpb+xWxs5Unz+MJbXUUBYKLwAAYA?=
 =?us-ascii?Q?7SUQTyoliTfeBRdtKqA2lnLWBLTFBiUsFZxv7hl/E5Ozzhzl9JeSfxnFHAI+?=
 =?us-ascii?Q?apwsyLw0Jf0ohxDdp45PSzRu1+HbQL1CVCkcuLu4PEhuduOsJGyShBag0b63?=
 =?us-ascii?Q?0oFzbhz9SgUrNS6/Q1p2gFL4PSkyoZiWjZqLAn8P+fy4sJOxxVydVM8+6fSo?=
 =?us-ascii?Q?tw8Sm+8Ts/gAH61MyePkmIWZ+mxmCfWBBGT//iGygS+sDaVkCNHplRmdirVN?=
 =?us-ascii?Q?qg7RCkT05FAvax6KOk+2t9DAMCV3u0pwo9CpmGnf26c0y+cURrXjZ7VE1E1k?=
 =?us-ascii?Q?HUNPa7XDXJw/65DqOUKEFzUokWRO1iuvJhIkOr21l1jLDS4cxzPrgjErpfex?=
 =?us-ascii?Q?YzCi9ohmgQe7jWYURREAdxjyZMkJnqNx4hGBS36ZkUsXK7nuao4Ai0PlcnI6?=
 =?us-ascii?Q?1/h4SmFPVvc6n6xZ0QJhIulyg0YFb5m8rcXKfG529jXFCheZhGESDQ55jK3p?=
 =?us-ascii?Q?oUiYVYAsTNg4JaIURWq+DR29CfnU2REiSTXfRAXHClBXwuZI/b+NF/UtCOm+?=
 =?us-ascii?Q?UWT9W1eUBlX+eKsA+FApZRu9igL15+2Z6Nd3AJCd9ZDpJcbZ4SD60VOxv55o?=
 =?us-ascii?Q?4QDHdMURmDqzFdP+ayWh/Gt2bcttVajuydFHKZHQWgmmycScRdbHkIKvfjqq?=
 =?us-ascii?Q?ixy1ckW2FI2u5WEip+GF+SxIk4L+xPaNzcF5/lhNfMz3Oc14w1LeC7aj78pV?=
 =?us-ascii?Q?AY78BDeiEBWLS/Ro268VoW1zpK3fWvz6ijMKKG6QImzmi/4gk8whSOszBHRC?=
 =?us-ascii?Q?g+Zm5Zm0D5ZPIkEz3DlBArC4SRKUS7TVjwW4KjmyjlT4JE3R7kWuMB9BuDrQ?=
 =?us-ascii?Q?NBX4tVwDuUavMOl+0FGfSTFkO4vXaNvs8EIhX/I14us4QTGgW8ntDBoi2x/4?=
 =?us-ascii?Q?csfQs8Z0haXhZB5PWWv1bMwvsztZ0CPx3eDBiIE9Pk+C/jjed2suXoNRPn4b?=
 =?us-ascii?Q?r7DdF2UcaI3pe4UoOEaE1bvw+lh07O27p357?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:40:05.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4435c206-2dba-43fe-41bf-08dd2f292d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

The AER service driver's aer_get_device_error_info() function doesn't read
uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
including CXL Upstream Switch Ports. As a result, fatal errors are not
logged or handled as needed for CXL PCIe Upstream Switch Port devices.

Update the aer_get_device_error_info() function to read the UCE fatal
status for all CXL PCIe devices. Make the change such that non-CXL devices
are not affected.

The fatal error status will be used in future patches implementing
CXL PCIe Port uncorrectable error handling and logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 62be599e3bee..79c828bdcb6d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1253,7 +1253,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
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


