Return-Path: <linux-pci+bounces-44257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4AD013E6
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 07:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4183A3014BE9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F5318BBA;
	Thu,  8 Jan 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvNYuVAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FC3161BB;
	Thu,  8 Jan 2026 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853706; cv=fail; b=RBK91OetKDKeLPTp1h67rA4HHeCcJx8QhDyjlyCzFRTCpHbAQ54ZblceVaW7ED1k9gtHlXBFsrD3x+pSn86RtZuwlqVyzXAnqVjT/XdBaoJczgtfOJ4NpbFArNTvh2mcX4eBmBm3AfsXCkkbVVXjugCOJa+OByBWTTva7x7Gq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853706; c=relaxed/simple;
	bh=omaq15PzcV1G36CwoMEzFhvGMnrjvRb1WaV7WzL3eYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbucmNlElO2qFe19SQLWvpEkJfI76c70Pelj3wqF1zlr8ojJMu6b9TMhpQy5XKmljD1N60nlMAMl/UDuAlQK/bYPxmiJLq5h2huTNKwPkpZ2FptkuO09X38j3dgQe6VLeq2vr5PP78pJWPmH+tLoPpSTvBY4sjQcmWDA+H5wQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvNYuVAI; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jrd/pUBI4dKrTklD9NXfLx9/gPrKUuJLipnGQhsV5nVx8xpgLz9nv3rO9S21/CUGVyk7ii1iONzV8YzeNkutQ/KqRixpqyM3EeTZ+wkhzeDCxclXNNa/UqqIn6AIG5lQSRXPEJYGeC0O5Q3DoP0ZTLQV9GxLkKlxVgSB1u5SB6uNnVXqNN1aIV2ENyyDVIGdSEWm0rGverRraDC3MmGHj/PunJZP0Goo8cEjrQ9lYK5bvvkZNtJ3ir9aGOAjaSxegfacp4vNJT9cqp8RFYpOdARcbCiu8Zl47RgObDMZLnSXlAWl9UyuJ2bdOXKGqw8LaF05tUE57VBORV1837XOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhgZDY+sLDD1aAIX4CiOxlwyJAYRM7SJsE4e2kIMDNA=;
 b=jRHuw9+hPSYRQTRR5ad5nrs+HWqbKsy8n94dRPykeewpmvrB8bOw/JkMUJUhz/upjAMa2NqQfGv3BPyin1mfxdQMocTe42za2c0CkQscpH6WRA1WZvceqklN4hRBELhKGHE+O2BdCn0W7/SRrlKnJ7tQs72H8zitjkvYiJOhY+eRlaU43qtGM/fs3HCgXU4rPfp/C46AJc7n0l6gYComa89Qiuj6mPcP8yI9f85YJsxRfrNTGh7K4pXFkPi7ULTqAEOY4xJVoBf0mgsgGXRsnNV+njXLv80UsRM/xH9RNEy0FN7wseuzbrApXfaabDmXYpCxvCgiRVVvFLoStzJrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhgZDY+sLDD1aAIX4CiOxlwyJAYRM7SJsE4e2kIMDNA=;
 b=IvNYuVAIEkFzhWOP1G/Pz8BNWlDASvjDcAL2jJG290cHWggATc0WVZGyIK7EgbjsULgC041kaLQawtwOZw+aCCQqbTVdMdvhcz+qH/9LZ3jXbTXu1l5e9VzRm3vo8M9CfgqIK1rAj37trQETeUyPjc3xHsg+nDFB9FshpfnkPb9AMkgZw4uXCueuIqcuq+DYXS4se0CvPXpEVAtNTYGCavPnmTzAgxBsjs/3/UH3QSt6QTdYdtKm63jCW4TAgrb9nz0Spoq5AHmj7eQ9ZzYpB4mqAtch9LZMSBd4zrYmaBBmk8Ib1tudB0R+PinOdfY+Jq1wPNfrHvyiiVEAvdLYhQ==
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 06:28:20 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a7) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Thu, 8
 Jan 2026 06:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 06:28:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 22:28:06 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 22:28:03 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
	<bhelgaas@google.com>, <lpieralisi@kernel.org>, <vidyas@nvidia.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 1/1] PCI: endpoint: Fix swapped parameters in primary/secondary unlink callbacks
Date: Thu, 8 Jan 2026 11:57:47 +0530
Message-ID: <20260108062747.1870669-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: fee5ad98-91d4-489e-14e2-08de4e7f1ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WvzpwTNQn0on9AYKxHB0ypT4ghBQeeBgPQXJ/7im9K/s6CmyVVejFPb7Rwcj?=
 =?us-ascii?Q?yOtqQCq8UX8VFUFsPoIcfNNmG/riNxCjWH7Vvo6gQ6He7oLjAHQ2+isVYPRZ?=
 =?us-ascii?Q?TdRac7jmSpqWsK1fQHjtiVJ3U4lTvY3Y+lmbp+ocg1QXazMkv0Xp83X0+sFU?=
 =?us-ascii?Q?r/V8shGt7A1zMjzXGQLI1B3f3Ow7/t1FNU4EXM11uYNyfi5ZjlJd2CNcMTC9?=
 =?us-ascii?Q?e3e2fqFiQ59ELTRxpRBbfqJAW6r6nSly1zT6G5glJEScnJdGvXBncE9CMop7?=
 =?us-ascii?Q?Kk3nTf7XELh5EW90tWOcGku+Q3vh9H1dHGDPJId0jh2WqHZKf0o+TJwE7q5q?=
 =?us-ascii?Q?hvRQG9yjrBfAPCsEVoX8eqOurlEI08LLIXKJS1/7oJzjC5IKd4SvldCEWM4N?=
 =?us-ascii?Q?oignxm4FoRBkT/Enf7t1pDXBJd63phiZM/KEuVr4kqOK5Zo9cb+1Wv6aA26e?=
 =?us-ascii?Q?n9ROljoCGnV6IJP2KR23EVxtTNBOzLoEL01mvObyXrVEHyGBs/YwheYYg6XN?=
 =?us-ascii?Q?AztXro64ZMx73Pcnsshdn9x4L1656P1eVvMYt6Ilwqs0C8bKhmYjhMcvx/d3?=
 =?us-ascii?Q?cUrQuBvz/pAYK5bSBBQVJ5YZxXAP7iQfYK1PqxsPujxA9QwTSh9kBdIAM+W0?=
 =?us-ascii?Q?vqYW006qBU8rnooqURvs79/zqwgeEKmi9pgY4BNyXOEr6lTVeVopr9SIU3/R?=
 =?us-ascii?Q?ZFBruqcf0Tnba9n9vNhA6OWaQb8rm9cycEG4XR93XtX0K8UU3EJ80Hy+2ksg?=
 =?us-ascii?Q?J7dEzyAjsKAaibV9BHoZm7rQETRcZtlmz75oL+DGvz1RGxTUBty8w75Hm1dz?=
 =?us-ascii?Q?kEn7I4tMgbJFz0IVOMlIoYMSxUDann8Zl8BpoZcAXxDwdQ4EvlQm/pT7pihG?=
 =?us-ascii?Q?x5GPvkrhHOgYz6XHF/xHIxJR6sL9m0JIj91Wnc6tTDybU8HQ6IprCT5Prv7e?=
 =?us-ascii?Q?F8TxLX/G46EsCSrV9kJiEtw64F5OcI+ncfXwsC2JB+H+8CuFt4XCVAX9y2l1?=
 =?us-ascii?Q?cPFI6quPmemhYG468yyWKgd9/9MsmAYrMzWKZXXP7oLLXjXO4+SGV3uSpP/o?=
 =?us-ascii?Q?FwLCb9fkmneIfBRvxghVPdsDEuWKLrb37pk67C6Y1JrvCyCN8O5lcTgjGwmz?=
 =?us-ascii?Q?4v7kNgiISr3hQyWJoJaGkJ1dAMx3yIGUDtpX/+Y4Yvmmkinz8/ABeJvjQNzE?=
 =?us-ascii?Q?mj4Pe4Qb1eZb2XAcoxWHNb7v4eAz0hZQNCv7dK/9b4lqMKxtClXUGeX2VmXG?=
 =?us-ascii?Q?NysHPuM6MideEW5iFHg7HRqKwXXXsQi/d09GggF1gcZLoAtBwqqQjjZhD55d?=
 =?us-ascii?Q?X1tJwM7cCwbmFWX8XttryXTCgPxJE7IR3gYkMqflGsGpq66ACk8ybfZXtmFB?=
 =?us-ascii?Q?IETLuCD02QMagm8W0XngyjjjU6PT/UIvwBXnGHSVMdwAP0UCgveCpHjG/I83?=
 =?us-ascii?Q?DDdUf/r0EOCkrShl9CdABcIadwi3809aN+M3/Kjsb+9IjbhKrIu9bzK3BtGy?=
 =?us-ascii?Q?w+V46wiS0yN64bSvVqXSpllaMYQv+isjgemfZYkdI/e1nBQhZmGNLM7bGSvx?=
 =?us-ascii?Q?oaohoFcUD/iec+9x0kE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:28:20.1571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee5ad98-91d4-489e-14e2-08de4e7f1ddc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

When using the primary/secondary EPC linking method via configfs, unlinking
the symlink causes a kernel crash with NULL pointer dereference. The crash
occurs in pci_epf_unbind() with a corrupted pointer (e.g., 0x0000000300000857),
and WARN_ON_ONCE(epc_group->start) triggers even when the EPC was properly
stopped before unlinking.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1774 at drivers/pci/endpoint/pci-ep-cfs.c:143 pci_primary_epc_epf_unlink+0x6c/0x74
CPU: 1 PID: 1774 Comm: unlink Tainted:
Hardware name: NVIDIA Jetson
pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : pci_primary_epc_epf_unlink+0x6c/0x74
lr : configfs_unlink+0xe0/0x208
sp : ffff8000854fbcc0
x29: ffff8000854fbcc0 x28: ffff00008fd0ddc0 x27: 0000000000000000
x26: 0000000000000000 x25: ffff00008b756220 x24: ffffc46154d53248
x23: ffff000095368088 x22: ffffc461568bdd18 x21: ffff00008afb3f00
x20: ffff00008068ec00 x19: ffff000095368088 x18: 0000000000000000
x17: 0000000000000000 x16: ffffc46153e6f32c x15: 0000000000000000
x14: 0000000000000000 x13: ffff00008eec2043 x12: ffff8000854fbc64
x11: 00000007ec988e71 x10: 0000000000000002 x9 : 0000000000000007
x8 : ffff0000824c3540 x7 : e0fee0d0d0d0a0b5 x6 : 0000000000000002
x5 : 0000000000000064 x4 : 0000000200000000 x3 : 0000000200000000
x2 : ffffc46153e6f32c x1 : ffff000088009c00 x0 : 0000000000000073
Call trace:
 pci_primary_epc_epf_unlink+0x6c/0x74
 configfs_unlink+0xe0/0x208
 vfs_unlink+0x120/0x29c
 do_unlinkat+0x25c/0x2c4
 __arm64_sys_unlinkat+0x3c/0x90
 invoke_syscall+0x48/0x134
 el0_svc_common.constprop.0+0xd0/0xf0
 do_el0_svc+0x1c/0x30
 el0t_64_sync_handler+0x130/0x13c
 el0t_64_sync+0x194/0x198

------------[ cut here ]------------
Unable to handle kernel paging request at virtual address 0000000300000857
Mem abort info:
  SET = 0, FnV = 0(current EL), IL = 32 bits
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ed28000
[0000000300000857] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)n
pc : string+0x54/0x14c
lr : vsnprintf+0x280/0x6e8
sp : ffff8000854fb940
x29: ffff8000854fb940 x28: ffffc461555540fd x27: 00000000ffffffd8
x26: ffff8000854fbc90 x25: 0000000000000008 x24: ffff8000854fba70
x23: ffff8000854fbc90 x22: ffff8000854fba78 x21: 0000000000000002
x20: ffff8000854fba75 x19: ffffc461555540fd x18: 0000000000000006
x17: 0000000000000000 x16: ffffc46154a438a0 x15: ffff8000854fb5e0
x14: 0000000000000000 x13: 00000000ffffffea x12: ffffc46156333e80
x11: 0000000000000001 x10: 0000000000000020 x9 : ffff8000854fbc90
x8 : 0000000000000020 x7 : 00000000ffffffff x6 : ffff8000854fba78
x5 : 0000000000000000 x4 : ffffffffffffffff x3 : ffff0a00ffffff04
x2 : 0000000300000857 x1 : 0000000000000000 x0 : ffff8000854fba75
Call trace:
 string+0x54/0x14c
 vsnprintf+0x280/0x6e8
 vprintk_default+0x38/0x4c
 vprintk+0xc4/0xe0
 pci_epf_unbind+0xdc/0x108
 configfs_unlink+0xe0/0x208+0x44/0x74
 vfs_unlink+0x120/0x29c
 __arm64_sys_unlinkat+0x3c/0x90
 invoke_syscall+0x48/0x134
 do_el0_svc+0x1c/0x30prop.0+0xd0/0xf0

The pci_primary_epc_epf_unlink() and pci_secondary_epc_epf_unlink() functions
have their parameter names swapped compared to the corresponding _link()
functions, but the function body was not updated to match.

ConfigFS drop_link callback receives parameters as (src_item, target_item):
- src_item: the config_item of the directory containing the symlink (primary/ group)
- target_item: the config_item that the symlink points to (EPC controller)

The _link() functions correctly use:
  pci_primary_epc_epf_link(struct config_item *epf_item, struct config_item *epc_item)
  - epf_item (1st param) = primary/ group -> epf_item->ci_parent = EPF group
  - epc_item (2nd param) = EPC controller

But the _unlink() functions had parameters swapped:
  pci_primary_epc_epf_unlink(struct config_item *epc_item, struct config_item *epf_item)
  - epc_item (1st param) = actually primary/ group (misnamed!)
  - epf_item (2nd param) = actually EPC controller (misnamed!)

The body then incorrectly uses:
  to_pci_epf_group(epf_item->ci_parent) -> EPC's parent = controllers/ group (WRONG!)
  to_pci_epc_group(epc_item) -> primary/ group cast as EPC group (WRONG!)

This causes garbage pointer dereferences leading to the crash.

Swap the parameter names in both unlink functions to match the link functions,
so the body logic correctly interprets the parameters.

Verification steps:
1. cd /sys/kernel/config/pci_ep/
2. Create EPF function: mkdir functions/<driver>/func1
3. Link via primary: ln -s controllers/<epc> functions/<driver>/func1/primary/
4. Start EPC: echo 1 > controllers/<epc>/start
5. Stop EPC: echo 0 > controllers/<epc>/start
6. Unlink: unlink functions/<driver>/func1/primary/<epc>
7. Cleanup: rmdir functions/<driver>/func1
8. Verify no crash occurs during unlink

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 43feb6139fa3..8b392a8363bb 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -68,8 +68,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
-					 struct config_item *epf_item)
+static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
+					 struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
@@ -132,8 +132,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
-				       struct config_item *epf_item)
+static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
+				       struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-- 
2.25.1


