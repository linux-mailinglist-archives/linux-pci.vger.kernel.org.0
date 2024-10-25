Return-Path: <linux-pci+bounces-15357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863979B115D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A6284190
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7B217464;
	Fri, 25 Oct 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LXqspsou"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAB217443;
	Fri, 25 Oct 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890262; cv=fail; b=DaazRE4oz0TBkZfSwIwaZO2WaOZy/G6VdHHSWxau8uAx/f+pJ11kuJkRwrp1GgniWJ8Bx2EkE3D9/O+qciKsOuJZ4FeslOv0TCoRPZPhI2x9CcWXr43RDF4RaNYm5XEUqWyvss7+hZ1FcLH9il+X8c0x5qVAaEZzjxCuSx7wIuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890262; c=relaxed/simple;
	bh=/9XJuX40kCs0tSWWCrUdwpU7vxcAia9Zyln1UGg97r8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaXy4ReNP7mGdLTve5d0BkhOW+fRyMpVBukHktMPUVA4EkMqQTNscbP+JD8HQqupHQHOK7PQ2JtfEQyh6x2r01I7vL09gpiaKVuSiGaAfhZRvDAYbJCoqzclfeJT8XIi5E0pM2p4MXB6QyxQjszGx1pwRn7FOq/Uc5bUBlYo8Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LXqspsou; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwW4M3x3+R3j0vO41fLIwO9vgVSiEmIo93HGJai/gta4DHrT21N9jeVraxnRLbyqznRlnyfMYkevR11hUZ3+uh07LQiOujTvay6Bg2yGI0EB3eXY7/TPnovLXsjbR3/r2AWM5TWCHjHeKbXahZhkX1+Pp1j139ZLDRrS4XHDNPUFek8Cf6tBR1Icm9iGQy5ExoD+zbMARu4Gc1GaidRmE+fYT+cyZXuODVMytYNHte+EEKWgLTmwwhOBIAaGJgXvPtKUVG+AcTz63VA+e6iEsszW2FLc6JmkhI3KFzJpVCObSm0V8goEO1kKCw78oeKKtUndI0KGI1DKH3Tbvtu84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QJ+++jcSQCsJBok1XrLRy8StiCKAW5Hh3smQzHSG+0=;
 b=ZiW8WtL+IU7lL2qUYSWL8mYO6KkhUCQEUKBYS1kWAuWpqzWGcS52jEpDXOL872uPOHatpeJbIDQzrDRSw01/4vFAbT5CzeJTbGsUgTQmgv+ikXgst0zJJ882bMX9ijYbSim2oivDcN8KoSA4LpBc1+TJG1OSZ6Z8Rp24NliPpFAY9WbQyq9hM8hsCtzBq/GfcrRflzB0JoMgGPNZyRnFU7Gt7ZHh2Wqei2/50r5XusBoN8YMeIWaqDR0jg2RLGkbwXaX+An8E5hf76RFpG0YQbw1nSZ1FoEodkXmNcaREmcYOAe6uj8jb2PYzMI+/TPVcpiJ9Mv26P1BEm4Ze1tpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QJ+++jcSQCsJBok1XrLRy8StiCKAW5Hh3smQzHSG+0=;
 b=LXqspsoug3nb4qP/qXRw/pi43ygB3cTPmOsqhRkLSFG1U4BWhOfuC/KnTieyEBLgqHgNL9nO7O7BrcNwTLsKkf1byiZrTQ08Hqiox+bxLl83AwgI28NYkU+da4E7REFZL4oER/fBSLoDr6bWlI9QZ4WOpgjf6HQgSoGrF56S8mQ=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 21:04:18 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::e9) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Fri, 25 Oct 2024 21:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:04:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:04:16 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 06/14] PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe port devices
Date: Fri, 25 Oct 2024 16:02:57 -0500
Message-ID: <20241025210305.27499-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 517d4d12-5a8a-40b3-71a1-08dcf5389705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhjqGE7a/KflKGyjkA9i2uoASwN2lbBSNeymE8rLnfl17o0iW2gOcemDMR6z?=
 =?us-ascii?Q?DyKJuTkTe3m8pldrmfsq0+Q+HzqvBLRUndyQjVmfL9ntzXFI5SnF4D9rdhFY?=
 =?us-ascii?Q?/dhWQ4wuncYxykUl2BAWPt3wwwLzmUsoCbbDLiEVvAgN1utCuhSHC0rHRRy2?=
 =?us-ascii?Q?vDoVcSSvfS0dVnhb8VcpjN9gbRpuVCNc+qvvFH5sN+1i8SVAAOhEOjs/Ew31?=
 =?us-ascii?Q?+m8mcwu3aGggC7l0Q38Mb1HJZi+0etqviwcK7yqO9MPruZmO022/Vz2EjHDM?=
 =?us-ascii?Q?D7ZCRwwEg6FWb8jw/mficBCYqalYhY2ikATiasDk8H5Dn2Ir2tHJ7K718Q2Y?=
 =?us-ascii?Q?+7pc1uWNkfSjeytLCA4wJw325ARVAcmG+D3qpm39jPniw/DXobrE5lnE+eZD?=
 =?us-ascii?Q?8LbjEnYjVQ26LhhUPJL6vpl48N5HFs4prVqSKICJS/OxmEKH01dD28dDOSCh?=
 =?us-ascii?Q?rwfUFTQP3TlXLbmMz/Aj0ceBRx4u1bJB0JSdTNp++3M+INt0SpHBxa7GVOlI?=
 =?us-ascii?Q?OH/LpmYio7+I9Cl8Dek+Xj6pqSoNbMx+NJE5b8O2q2orCSdzswP/1xtOqIa8?=
 =?us-ascii?Q?pCmNBgQQodfLcdtaaZtQY1qrNC9in84qgEsMF2ymOOY4sieoxgNdxsoMkFLN?=
 =?us-ascii?Q?R5FT/sJ55tfenDV2SyHYfnnZQFqeOnwZqTHfJAnCqH5dgiFxxz4W0fG9c3S6?=
 =?us-ascii?Q?HqOkH4T6xgwVRk5tvbrdErj5dcKN58xZBA4O4g2jRzB0po6G6KeJEFRwtOZ9?=
 =?us-ascii?Q?/0pCrV+CU1aMwgZWpDlr5FRvynhTZMbaThc4Zc2FGy6THGry0IPO99rGyy5z?=
 =?us-ascii?Q?f4g7bt4DmV/so+cn6+7cGipQwicD+Zj8esPmroJEx6ViTanNImvypskzYPtL?=
 =?us-ascii?Q?n9Vs7mwsqoULFBGBU1T20+NaWnHx/EeSXcGFX5vDQ9uBPq4Gn4vR3dl3oXa0?=
 =?us-ascii?Q?MWrOz9QrFDpcu5iXoSu8xJWbjnzrk4HYTrYsjY7OhOlrSlaqRLMGwFxJgsZ9?=
 =?us-ascii?Q?hkzWWQZnfbuY3g57SjOLJ1jZCC3a+YM3A3V42ZWvXQs8olzkq647zurWsGI+?=
 =?us-ascii?Q?5om1o9feJroW7DcswL4lqtmsvdZrExqCf2/2V+iwkagoAMjSSt+54HdXFOQo?=
 =?us-ascii?Q?kf1BYpRiR7mYc571XFmS4tKdz8SyqXeJit+8m1g4mANanpm+rOHgNlHvbRaw?=
 =?us-ascii?Q?N6sbQttyOmW98q/Db0c8UNnI9GvE1OrvN51etSnLUqPKf8eQkyrfAgEAaSvI?=
 =?us-ascii?Q?JDQU39zOjcJCGehl4XFCgVs6DfNwLckQFvIDudEuMRG7hS2HSvc5COvymPrF?=
 =?us-ascii?Q?YGOtJ3mp7yoooWRisXJreYXy5nY5N+NiuVah1gRHVofph+bA6ZOh7bpzgvBM?=
 =?us-ascii?Q?3mJ7nI3kasny42FTltTMQNPpXZkC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:04:17.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d4d12-5a8a-40b3-71a1-08dcf5389705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

The AER service driver's aer_get_device_error_info() function doesn't read
uncorrectable (UCE) fatal error status from PCIe upstream port devices,
including CXL upstream switch ports. As a result, fatal errors are not
logged or handled as needed for CXL PCIe upstream switch port devices.

Update the aer_get_device_error_info() function to read the UCE fatal
status for all CXL PCIe port devices.

The fatal error status will be used in future patches implementing
CXL PCIe port uncorrectable error handling and logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1d3e5b929661..d772f123c6a2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1250,6 +1250,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
+		   type == PCI_EXP_TYPE_UPSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */
-- 
2.34.1


