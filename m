Return-Path: <linux-pci+bounces-45011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C7D29AC6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8073086023
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB7336EC1;
	Fri, 16 Jan 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dotubexw"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0C335541;
	Fri, 16 Jan 2026 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527764; cv=fail; b=tep7EpXQZWel/xpLh9gqtGCk8DjTsRwVKmoC8r9IsrAKRC+kJbffiXKZMhNUFphj8RekPf+0O9aC9DcM2LTDTJC6V/nelSaHa12Xh1QAX2MvexYdw87g7IiTcSnoRcYr85yOfZCl1a2SmXnLAFF5ayBesaYZp5RhKTv8w+bN200=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527764; c=relaxed/simple;
	bh=e+e6gdynUbK4yEaASdPuHz4lRX14Wvome1d+Y/0w8Ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klIs+rCKXQes29pIyX2zkWkJYOcBdnkMTlMjosV0/g48u5ZBd98Hv1Y0e0chw6LXmhF6Y77Hzy1UHBD4LF8JmzOrxscjj+IaccaJhyPYbfzFghKqWyK1t1FSH7w7rGTsCbVHtoujJ14t5agBcOAKVoF3mU4aHUxKQpjeJjYcxiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dotubexw; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwhVsBEgI55z6LrZyM/Mo9GPweF8cu2nOCx+73Ki+/FoUjmlZ1EodSJCTmuATHL1Mka8DLrsjyNFjJA/JMcj66Jv4NQbtN0ElfxrTQP/PveSDIdDiP9V/eIjG8DDaja56oiMhKHA/iVXrwuwjGs6Xz7z8QeNDvXjg3J5sJvuOkt2chWr5DPSE7wGLwUcSCwUv0Kay4ukHPo/luWn1IlZVnXx3t5PseWwyHhldD3oLalGeWVbH5jvtyi5w8SwXdyLlJGEqtoMdDnSQA/9MFkGjVTEmY7XKa18/BmS1M6DR4r4IDuRVPj0yih94FROP9O9pIYzmvdDR5Pmt9URW1O5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmb2xJ6Jjp3yzhW9+n9u5SrcjLzp8Z1MYxiWuhkImFE=;
 b=OJd4IlpM/93xxABcwoqYLHZ1LYNQnqb3ks9VUQWcjg6CdfyJRxSwp1IcvV7qN2QRfRSYmDQIeVbKPKAlVhkOhgKti0aQYsOsG7qcKFFAMb5NdQzZae5WZFJD0wqhXTKZJ/fnAQa2FqV3cs0FqDR3/QAa53QiFWE0bWV5gqdzs0++/vMBhDjHDlkuAGlV5oz+Mc89HnQCqwngh/zMTayQTZ1ai+SpZoDTw3iHtf60dl8Nz5uHa+kATzJU6vzmI+qpwZ0t48ZyRovOfMyhtEEzIdVpV1pkvqk7aCJv8oyclNVeQQZWVRHwogPYkDG/G0LeflvqBQk0vw6RiAOcF90Q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmb2xJ6Jjp3yzhW9+n9u5SrcjLzp8Z1MYxiWuhkImFE=;
 b=dotubexwE3gq6DAcrYjgO4M481looryGNebG0W8hMezOtV7iEnc20B1CgTMh8uvYE5CVNVMdaJexW8DvLme9C67X6U6ojJHLniAJReYmcH99javqQmsiX75/TVxe76SJ9q2sobDroD/fFeE4xozdgkXI6l/J6N7iMMJRVBCufLZubg4zyY1k6U9cwPGLLqBoWJyvan6U6Vfkjbfr8SX6RSDjaSSFZ9OJO1GcIxTw4bI8C5jNc/GFZoSfNMXMXSA7QlfxMpaLRAzS6P2we/mtczaLjG3KK3fJJ0kUxYEzMmK8AOlsHmTBzN5T73G2GPDcrKTCkV3HVyFrUIzC6q9w/A==
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 01:42:27 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::ac) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:09 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:09 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:08 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 9/10] PCI: save/restore CXL config around reset
Date: Fri, 16 Jan 2026 01:41:45 +0000
Message-ID: <20260116014146.2149236-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 29708c50-d136-4d6d-1f8e-08de54a0818c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hvuw9RKy+N4n7zwAtDHafoqYojYQfCr4xrXrQRjQ+SaNlO8clGKDnKXM/OYZ?=
 =?us-ascii?Q?eSneJ2pdRH8tWLaCkrpyQ5DgrVWq6Km28WcT5EawkvdDIABwxraKdeFcI8tY?=
 =?us-ascii?Q?OVx0CB/fN/GRx43btiTrdl0WFIaPRbIROGb3ooMbGI1G+aTB9OsnnB4auITH?=
 =?us-ascii?Q?D3ylAi98yJI/WG4N/SbaaeK3ZnVUcfMFnAGUIIjNptnXnbfC3GLSEAG8Ezg+?=
 =?us-ascii?Q?sfKc9ZlQJAvp7rhEmwFuI1d7VUpy968MiuBNkaIGS1LtFeeoI8Ca1ykue/H5?=
 =?us-ascii?Q?w8Djm0iDmNfcg2HZxZUlgh9/LaXsbkdyI3qBGvNmvPSA+JkZY7jZHQN0KPLA?=
 =?us-ascii?Q?RfGqPWsCEpbkXqAmvwRSuseVAAQ9mffMK+okJK0edWWVC5bFKUHWtVjxpDBI?=
 =?us-ascii?Q?iPoBJLI2vYbjSYZYGjiGdblcOPIzQNrjKvKtIvcbVlguMqY9VyJCMYB0BdcD?=
 =?us-ascii?Q?ktY0JZemFy6z+6M7R7qrcSPgWSH9GwL+IyUd/kFeWSyDv6J9YW6tvNtBs8wX?=
 =?us-ascii?Q?p2/3sCQaDa1EQuVyAaXMfbyW0hMiSKqtIL2DRDqSEyjVmHmBo2tEXfx7C+SH?=
 =?us-ascii?Q?G2bP4808s2vZtN/6cPziK9gIkfTCY3t7AMYzt3o0RgFRIHxrWAn0s0cn3bak?=
 =?us-ascii?Q?asg78xyWPNJmFBfdlndQa5uvRYkrJU+CBr1RbNkqFkkOqouU3aFghSjfQt1S?=
 =?us-ascii?Q?XN5agTjTWQF9/YzB2NwehS96aLWE8YoG7FFBcrTd7XS74/bxQl2EvYQc/BEL?=
 =?us-ascii?Q?/Tsy9zh+xkEi7ZQYlSIyXhQr2iPJlL18yHMdSdrcRZW5sjrT2SyL6ngVCQ/m?=
 =?us-ascii?Q?yr6rLdLRH7AVpuf0EQAcYDU4nOpWxY/8OVkEjBq9rgR8sKZYS4qEWMn07ZTz?=
 =?us-ascii?Q?StiwPAQcwBnFtoFTQMWr0h/cOKgpaq/NhYEd0lSHh5CfFM3/8k5234Dfvjfv?=
 =?us-ascii?Q?8YODGYIui5mqKcuZsZjDJvQ7nWvVrPtKTvLSwgG58eOMK2gTANOJ3sCtQe2H?=
 =?us-ascii?Q?0j3SC6y2iz4rSqm9GK1b8/JQmiddt8cbAnJR3uKt0GC0Q6Dlb62ET52Hfj6q?=
 =?us-ascii?Q?GpV9fjlnRKDriDvlcaB1CcbpuQHoKj7u4zm2xiw1LghZ9hRknNqTO4VKaUkk?=
 =?us-ascii?Q?d82o+XLQNB7dAzEwuJqtS4BS1eNzmHZPljQd3DeWGFPoZ4Nk7QskeG1Sn1CI?=
 =?us-ascii?Q?mmHa1tCu1XxADrobmVY5IoXkVIx4kLQoQiuOClhRqSxb0+PAfuw+QVFV3m3d?=
 =?us-ascii?Q?dk6HvCsJ36KrarHGKig1Aql08RR4AvYkZUShKUO5ajbzkf8z8U7MUcW7U+gO?=
 =?us-ascii?Q?ZxjJOY4ihcs/7XH6whW2YX//A7PsMMt0+NSgkE23yrY/OQ7gBJhGRXhZkSAD?=
 =?us-ascii?Q?oDFa+tyKWbdVfPIurlMEc3ILXLAaYhLipEK6HYohpJV3nDcNVdtYo9n2IENa?=
 =?us-ascii?Q?3BHiV/ttBjfyoHu5f7EPh/fMMegNNdwbifnyYCW8zBm2qLyX8inKvaG3uDZy?=
 =?us-ascii?Q?Q8bkheXjrIvyjtQT+3OKGbMI4forQ+M27xHg7erlYiBpKYcnW68AHxb7Dn9l?=
 =?us-ascii?Q?ioouFtY3oIRuBkToUWqAxQOAg4VEMSSBnnZKIAPlDYlz95USfhY7uXk7XOhZ?=
 =?us-ascii?Q?MQfCpTv6yUoWD1UrXG8h8ntVNHKdrmH6cwmyJ5ZNzSfo4DlDtCjMvBAbBilH?=
 =?us-ascii?Q?YfdtMIN3z5beNSQe6WE62PiHGjI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:27.6275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29708c50-d136-4d6d-1f8e-08de54a0818c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save PCI and CXL configuration state before cxl_reset and restore it
after reset completes. This preserves DVSEC state alongside standard
PCI state and avoids losing reset-sensitive CXL configuration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 83fd7e75a12e..705be8b079da 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4960,6 +4960,7 @@ static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
  */
 static int cxl_reset(struct pci_dev *dev, bool probe)
 {
+	struct cxl_type2_saved_state cxl_state;
 	u16 dvsec, reg;
 	int rc;

@@ -4985,6 +4986,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;

+	pci_save_state(dev);
+	rc = cxl_config_save_state(dev, &cxl_state);
+	if (rc)
+		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
+
 	/*
 	 * CXL-reset-specific preparation: validate memory offline,
 	 * tear down regions, flush device caches.
@@ -5000,10 +5006,16 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (rc)
 		goto out_cleanup;

+	pci_restore_state(dev);
+	rc = cxl_config_restore_state(dev, &cxl_state);
+	if (rc)
+		pci_warn(dev, "Failed to restore CXL config state: %d\n", rc);
+
 	cxl_reset_cleanup_device(dev);
 	return 0;

 out_cleanup:
+	pci_restore_state(dev);
 	cxl_reset_cleanup_device(dev);
 	return rc;
 }
--
2.34.1


