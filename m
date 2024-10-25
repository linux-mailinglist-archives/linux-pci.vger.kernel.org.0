Return-Path: <linux-pci+bounces-15351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3769B1142
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421B0B22EF7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3B217F2D;
	Fri, 25 Oct 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tffkEaCK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45810217F2A;
	Fri, 25 Oct 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890203; cv=fail; b=gz/SE5iaKOsNNtw/cH3zfn22VLNIi8UoEyru0NsTnNu86HLgJQehHTBxlMlmBXcj6RvYokqPDcY5CQwexajCA1wc5uJAsz6FaZzt3ACOK8I5q8fDwNmBduq8aJ/dwjNPQxbV8i5FQt8j3O3edsIOxQy9DcqilJA308be6+NIIB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890203; c=relaxed/simple;
	bh=DrmCN8K/mYnrGlx7c47UMF/AD0FRWUJEWby23Lqe+gA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAACaqJdQa8pKBGWtUD7DwQDEETbQIAezXqpGJvLE18m/VGapRnp3DhJ0bJLW69mslbJIp+H4mAhvjtRG2UeTSAVwPPg+wLMoNUrxpoUUd8FhH4jATwprmFy9/JvOoDtPECiVfVh+DPwo5dky/jo4aJmxrQcFoaL2tpnqdlLkyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tffkEaCK; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZlWXdrttzvQ7/jOgwbHgakud08vod4xeGWNSqufD1R6WEImexbQDbUwLpRXL4Pyx0MCDICdVDHCgerPu9lpqmr+SmguXcJ51tT0RbgVwy6ZupQURd+G+wiutSc85px40sw81KVJtchVlc2oB/4p3NjY1VKQJGOysM8k06Nqi4kKbHWs0ZHziRcEK8cwBUVkvfFj2x2PDqiUZCfnBqqm7qUdMvjYHcyk5mhtllgS1RuvPUCl2+iMVjrh6DvnJNF0RY/iMB24qzX5qJzz0LapTTNi0jFk2NHd38bAZEENtDLpI1ARTv3TwjHOdR+QhnqmlcZN+8FhYq4uAGgXOO05/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ciA2G9KOnZ+ma8+d9G+TGW8x826Ap+QpO8rcmiuTWs=;
 b=TmVrm2d8ljbE8iBhs2a41VoppPS/L1QihTixJnFRq316wEEZU6wM7il7ZMKDaDM+ysxHUSch5+PBCP47cz3LB5Kzn5WfeAPNJlNJioZwHoJupNekjx55SwD3G9oc06aZGMJwhwdbPq6UXFxLlkJ2N64D7oila1RxQRsxUcUY01sB/aERzHOmQUSAwQAYcBnDWmjXMHM+W5/y9xyCKNEOQ885J/sG73DqXjI+WHhtkUemEPyOG7tU/BvPmIFRRgCl1aGiCPxeXiXxFZGzrUGqkLfwjcPMt7+bql+asXmLi9HZwcDwPjK+axmeZEe/on9Z7npIdCgtu7L1ffFgP9JHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ciA2G9KOnZ+ma8+d9G+TGW8x826Ap+QpO8rcmiuTWs=;
 b=tffkEaCKVoayQds8dRTIn4TyKg2cx/aQ6Gd04vxD510sF5lpfPQC7arthtd7vH0nBNRthbaakcE1iGMbSzQao9S+7IS/07IG2ub7YP8MQkrEV4O0hvNdgttReoEnd57BdN/Ew58pJxK5637vRSG3pvcmccZqEf7FDDotzGOq1Qg=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 21:03:12 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::28) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 21:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:03:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:10 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/14] Enable CXL PCIe port protocol error handling and logging
Date: Fri, 25 Oct 2024 16:02:51 -0500
Message-ID: <20241025210305.27499-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 219309c2-8588-4a62-f198-08dcf5386fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7HRDmKjQkylT2eXcZl8cwqcIlb23scITAdF4T4OeATxTsXsPnAx9svyKbXY?=
 =?us-ascii?Q?0IFBmBvDEt2Z4vwFcNwaKF66gf3MgJL0zNTaorWH92Yhs+Uzh6vFphDYntoJ?=
 =?us-ascii?Q?EUOWXhEU0eFsmS1wCL45Y0bnyIOlGiKYJeYNedj2YHmsSaUHQY7Y0cZOUzo/?=
 =?us-ascii?Q?kKroAG2U/1Sn+iXiv9pnddDAURqr9kWFxjvu3Yn0UNUuFigT4NdQA1j2PIXW?=
 =?us-ascii?Q?JPGMR5f+8Dmh/xqfUL7bur/h9WqFmq2hnmy7nRaCld0rxyPRq2o9IMfHxfyh?=
 =?us-ascii?Q?OQHs6ry7y5rG97WQ6l+lNLFnoae83+vBvdxf8RjQDj/zEUNaVY7JygP5ux3X?=
 =?us-ascii?Q?sZdQDG+J1Mlc0Dl2CbqUftelIJl7bwvXa3ISIbiOUa6CwdA98gmlGoSp4fzk?=
 =?us-ascii?Q?hgxXUWr5t46MuP5PXigy2m1vioeH0qS6LzqNwtolvP7DXlyMDL1hyZZUVyZR?=
 =?us-ascii?Q?EjraV0o5b2+nwq6tG8H+eQxa4at/dhRLSSHqqS0MTKHnaann6HuHfIQ9rXNl?=
 =?us-ascii?Q?7bF+7v4e0RRqMBnQrztR2iNKAwKD8VlMbhHkkRSjMXBJNwRwW+DoejnWjCxF?=
 =?us-ascii?Q?48jgddAZt0foZal2pxtJ5UNG+XXufn5Wi6MC++DgtBJd+Mv/Qb2xAPIzDiR1?=
 =?us-ascii?Q?cH8oO7NRxvzuYqYh3jyRWF/6zXMzJH85tKl9+CWDWHjrc830xL7v4xQa8a3V?=
 =?us-ascii?Q?06FnPgtkLmn7rYkGCcyRTWUUiPJKEKDtvQByR4lqgV9ZbZE3afi1YQ/I3IfU?=
 =?us-ascii?Q?I/BJ9OsPFP4acMtyFrBhAZbWB5/7Spa/mZBPhEC00QRcDdJ5lqIiRkP92Yb9?=
 =?us-ascii?Q?we88CaZRsHgSNNVLby4BFFNLjuPgpC8Wc2FojS/a684lDDuAWBu2BiyoJfMv?=
 =?us-ascii?Q?mR7x2DivHdLM9FJkt7meRO4+XoznbJ7RJ3b+NFk1TfXaMPAN9+2OQqdq3pnE?=
 =?us-ascii?Q?xc21gZJ77UvVq7IFIPMZLZx/apecJJ6h1EkaoqdA9W9VjCEIVXSkBoyf93A2?=
 =?us-ascii?Q?OhR/XtRo8MenN1+HM2ofC3Jhqupt+E9PM+GAtUQJIq0CBQESeaPt71HYXfLE?=
 =?us-ascii?Q?vj1uVJYhN6hOUfm/rVYTU8BQjnS6l0JnK6ny4PmWLR30gQkUtB03KV3QM0ga?=
 =?us-ascii?Q?bmkN0fvtp8OaBmp2W3y25wyRo6WWA0cgY8K6GHNUsgrhEICzSDYZggWj74Wx?=
 =?us-ascii?Q?UoQ3rI4AAgB4njRCq/+d/Iuaud41KDi1LgBnSr0WhuqpTVDXxVEWHywPAgWO?=
 =?us-ascii?Q?M8ApdFBIl06CIxdR2jM9NpMsc61BnqdoNsN7midtoG8OimM8+WhRgSQCnns5?=
 =?us-ascii?Q?KdQZVyoqLsyenGIylDfbWIKogHwX8PUJfyoPAhuybKxK3/+y3BxRCmmdscwF?=
 =?us-ascii?Q?rD6hNjE88Q58d7LZLq0bUz2PuxUGxRG10CTFNqIMZLAdK0BOPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:03:11.8537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219309c2-8588-4a62-f198-08dcf5386fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

This is a continuation of the CXL port error handling RFC from earlier.[1]
The RFC resulted in the decision to add CXL PCIe port error handling to
the existing RCH downstream port handling in the AER service driver. This
patchset adds the CXL PCIe port protocol error handling and logging.

The first 7 patches update the existing AER service driver to support CXL
PCIe port protocol error handling and reporting. This includes AER service
driver changes for adding correctable and uncorrectable error support, CXL
specific recovery handling, and addition of CXL driver callback handlers.

The following 7 patches address CXL driver support for CXL PCIe port
protocol errors. This includes the following changes to the CXL drivers:
mapping CXL port and downstream port RAS registers, interface updates for
common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
adding port specific error handlers, and protocol error logging.

[1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/

Testing:

Below are test results for this patchset using Qemu with CXL root
port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
switchport(0e:00.0). A CXL endpoint(0f:00.0) CE and UCE logs are
also added to show the existing PCIe endpoint handling is not changed.

This was tested using aer-inject updated to support CE and UCE internal
error injection. CXL RAS was set using a test patch (not upstreamed but can
provide if needed).

 - Root port UCE:
 root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
 pcieport 0000:0c:00.0:    [22] UncorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 1 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x116/0x120
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Root port CE:
 root@tbowman-cxl:~/aer-inject# ./root-c[  191.866259] systemd-journald[482]: Sent WATCHDOG=1 notification.
 e-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
 pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
 pcieport 0000:0c:00.0:    [14] CorrIntErr
 aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'

 - Upstream switch port UCE:
 root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
 pcieport 0000:0d:00.0:    [22] UncorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 1 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x116/0x120
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  ? free_cpumask_var+0x9/0x10
  ? kfree+0x259/0x2e0
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Upstream switch port CE:
 root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
 pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
 pcieport 0000:0d:00.0:    [14] CorrIntErr
 aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'

 - Downstream switch port UCE:
 root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
 pcieport 0000:0e:00.0:    [22] UncorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
 cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
 Kernel panic - not syncing: CXL cachemem error. Invoking panic
 CPU: 1 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x27/0x90
  dump_stack+0x10/0x20
  panic+0x33e/0x380
  cxl_do_recovery+0x116/0x120
  ? srso_return_thunk+0x5/0x5f
  aer_isr+0x3e0/0x710
  irq_thread_fn+0x28/0x70
  irq_thread+0x179/0x240
  ? srso_return_thunk+0x5/0x5f
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xf5/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Kernel Offset: 0x19c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---

 - Downstream switch port CE:
 root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
 pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
 pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
 pcieport 0000:0e:00.0:    [14] CorrIntErr
 aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
 cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'

 - Endpoint CE
 root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
 cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00000040/0000e000
 cxl_pci 0000:0f:00.0:    [ 6] BadTLP
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available
 cxl_aer_correctable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Received Error From Physical Layer'

 - Endpoint UCE
 root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
 pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00040000 into device 0000:0f:00.0
 pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
 cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
 aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
 cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Memory Byte Enable Parity Error' firs'
 cxl_pci 0000:0f:00.0: mem1: frozen state error detected, disable CXL.mem
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port2
 cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port1
 pcieport 0000:0e:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0xac/0x160
 pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
 cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
 devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: mem1 dport_dev: 0000:0e:00.0 parent: 0000:0d:00.0
 devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port2:0000:0d:00.0
 devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: 0000:0e:00.0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
 devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port1:pci0000:0c
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 <snip>
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
 cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
 cxl_bus_probe: cxl_nvdimm pmem1: probe: 0
 devm_cxl_add_nvdimm: cxl_mem mem1: register pmem1
 pcieport 0000:0e:00.0: RAS is already mapped
 cxl_port port2: RAS is already mapped
 pcieport 0000:0c:00.0: RAS is already mapped
 cxl_port_alloc: cxl_mem mem1: host-bridge: pci0000:0c
 cxl_cdat_get_length: cxl_port endpoint4: CDAT length 160
 cxl_port_perf_data_calculate: cxl_port endpoint4: Failed to retrieve ep perf coordinates.
 cxl_endpoint_parse_cdat: cxl_port endpoint4: Failed to do perf coord calculations.
 init_hdm_decoder: cxl_port endpoint4: decoder4.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder4.0: Added to port endpoint4
 init_hdm_decoder: cxl_port endpoint4: decoder4.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder4.1: Added to port endpoint4
 init_hdm_decoder: cxl_port endpoint4: decoder4.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder4.2: Added to port endpoint4
 init_hdm_decoder: cxl_port endpoint4: decoder4.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
 add_hdm_decoder: cxl decoder4.3: Added to port endpoint4
 cxl_bus_probe: cxl_port endpoint4: probe: 0
 devm_cxl_add_port: cxl_mem mem1: endpoint4 added to port2
 cxl_bus_probe: cxl_mem mem1: probe: 0
 cxl_pci 0000:0f:00.0: mem1: error resume successful
 pcieport 0000:0e:00.0: AER: device recovery successful

 Changes in v1 -> v2
 [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
 [Jonathan] Update description to DSP map patch description
 [Jonathan] Update cxl_pci_port_ras() to check for NULL port
 [Jonathan] Dont call handler before handler port changes are present (patch order).
 [Bjorn] Fix linebreak in cover sheet URL
 [Bjorn] Remove timestamps from test logs in cover sheet
 [Bjorn] Retitle AER commits to use "PCI/AER:"
 [Bjorn] Retitle patch#3 to use renaming instead of refactoring
 [Bjorn] Fixe base commit-id on cover sheet
 [Bjorn] Add VH spec reference/citation
 [Terry] Removed last 2 patches to enable internal errors. Is not needed
 because internal errors are enabled in AER driver.
 [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
 [Dan] Use kernel panic in CXL recovery
 [Dan] cxl_port_hndlrs -> cxl_port_error_handlers
 [Dan] Move cxl_port_error_handlers to pci_driver. Remove module (un)registration.
 [Terry] Add patch w/ qcxl_assign_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Removed PCI_ERS_RESULT_PANIC patch. Is no longer needed because the result type parameter
 is not used in the CXL_err_handlers callabcks.

Changes in RFC -> v1:
 [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
 [Dan] Add cxl_do_recovery()
 [Jonathan] Flatten cxl_setup_parent_uport()
 [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
 [Jonathan] Rename cxl_dev_is_pci_type()
 [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
 replace these find_cxl_port() and device_find_child().
 [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
 [Ming] Dont use endpoint as host to cxl_map_component_regs()
 [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
 [Bjorn] Dont use Kconfig to enable/disable a CXL external interface

Terry Bowman (14):
  PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct
    pci_driver'
  PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port
    support
  cxl/pci: Introduce helper functions pcie_is_cxl() and
    pcie_is_cxl_port()
  PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
    type
  PCI/AER: Add CXL PCIe port correctable error support in AER service
    driver
  PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
    port devices
  PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service
    driver
  cxl/pci: Change find_cxl_ports() to non-static
  cxl/pci: Map CXL PCIe root port and downstream switch port RAS
    registers
  cxl/pci: Map CXL PCIe upstream switch port RAS registers
  cxl/pci: Rename RAS handler interfaces to also indicate CXL PCIe port
    support
  cxl/pci: Add error handler for CXL PCIe port RAS errors
  cxl/pci: Add trace logging for CXL PCIe port RAS errors
  cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers

 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/pci.c        | 180 +++++++++++++++++++++++++++-------
 drivers/cxl/core/port.c       |   4 +-
 drivers/cxl/core/trace.h      |  47 +++++++++
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/mem.c             |  29 +++++-
 drivers/pci/pci.c             |  14 +++
 drivers/pci/pci.h             |   3 +
 drivers/pci/pcie/aer.c        |  99 ++++++++++++-------
 drivers/pci/pcie/err.c        |  54 ++++++++++
 drivers/pci/probe.c           |  10 ++
 include/linux/pci.h           |  13 +++
 include/ras/ras_event.h       |   9 +-
 include/uapi/linux/pci_regs.h |   3 +-
 14 files changed, 396 insertions(+), 82 deletions(-)


base-commit: 739a5da7ed744578a9477fb322f04afecafca6b0
-- 
2.34.1


