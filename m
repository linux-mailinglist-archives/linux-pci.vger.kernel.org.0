Return-Path: <linux-pci+bounces-27119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7205AA8811
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E916636E
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB43A32;
	Sun,  4 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWSekBx6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BC8F58
	for <linux-pci@vger.kernel.org>; Sun,  4 May 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746376325; cv=fail; b=tmd9PBqiesh2m6PG5ZQjBEkHoy7K6ajS2UtFzIPDzfZc67ePtYIrbjz0neFAXhuwUpbW482YCRSCA2N2bS/gkYFellRip9jIkZxrpS0NUj8gLlSska4LBhEQJ5ta2AWOAQFNW1Gm4BdqZpSsTQbif3Is2rKs1hNAVqGR5WNYatA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746376325; c=relaxed/simple;
	bh=WVTJ7KvSXG/pAZhmWypQZ/GLFmlkRit6GTWAEiIJkEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkwiW3lE3BaaA+21M5VBOtqCPHdE074o9yJyXru2MbQOTEsJ/O/NEOY5hySU4sVCe7DStialPaNgazoJ4Yi2YhJD4dTB7D0AAI3NB26yHC5bkFjtn8W6BwHZC6Czn7X3hxq35MSyQsrzIxuOSSAzGcauGmxVFc/Ku0dbfzTUmMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWSekBx6; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHPet41F63AqHwY7dbtOIDE5fGaUH+ugHRDADlUFyTWgvYMkMV5XzfoNT3Nml/7LnVyvXvFj5hJlAeLP7vaGXrSix7WPRMMPbxoXtcxSRVpxKKK51NQ3Q8liRvCxiR7gHCDfT1oMVX4kSlflDxg6KnFcrJt/QsVBQRAHr7Dc3JjqTXho6gqs8fASR70j6r6HG8FPlXgjYfdUipt2ISMvLRMec7h+dBErr4J6crgSXrsBBE0rRyR7+/JFRQnSTgdmCOeu5YiisDkWQRnKdyzPz3Qybn6AcC3lvSFRWknWdOW6QmWgu02E8+9z+J4n+IoL5RMQp+VgxObPSTpjGBNpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZR48SBIxBo39W/yljgx2833wFf+1qs0mCButuvIXz8=;
 b=LpNPVmnTzwEk25WxOtaU4lqJJQnzd4qXHjBFLfeMdWZjV0MXX9drTTf3jmh6X1859oJz3WIPobcbe0HjV71fUreZcRdedVtuIIE9L+LM/CPVWIjqiRQM3y0R23X6LPT5vmxhGWX7oBHWcxhdkhz/lS003yjlVJ5evdbqq+x6MZbzJ8RLWOl/FlRvuC5rwtUytJGnJGl1BdGWEhBKgxFN5e2p0KUpfeVYTZvJA0qn53gu5SasKgV487z1AT/q88+QsslyVuh6hTJtHvJ/piXH3r6dHxT5pVGXuuVfVeVSFysFI6iV0t6lj51vF0Ln7e1YbI8du38Nqld1ZO/Y/gfBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZR48SBIxBo39W/yljgx2833wFf+1qs0mCButuvIXz8=;
 b=PWSekBx6WtLX5rRCCCcxgYun9NSKSiss8C8TrJ7LdnhA0nI7/3T8kaZLC6CExnMAMfEhRP9NtJ/udVsMqTxHySL5xEOyC6yup6ot+rWhVgibNg2aHCG/puSbZBmeVpzV3pXT20lnfqnDDPh9ELfWm/7ezrhx2nPoU+Q7NrBC5tYSjTbRvFxwxM5BmTvfI8X2tPMpiu2PH7ugPds0XYVrZDK6QZ9FlmMcAt+eOJJPEIiV+xM5V4rG3JJPjaqVb3q9+GRl0g6XjwJAJMjml0LyzxnCAJHiFHGUYAEmFU9hzRdmbcsmDXC1I0vji+Lcg7unMk+Gzl9rnoXIQ0CQeiyvxw==
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 4 May
 2025 16:31:59 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::3e) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 4 May 2025 16:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Sun, 4 May 2025 16:31:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 May 2025
 09:31:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail202.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 4 May
 2025 09:31:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 4 May
 2025 09:31:53 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 4 May
 2025 09:31:51 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Keith Busch
	<kbusch@kernel.org>, <linux-pci@vger.kernel.org>
CC: Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH] PCI: Fix missing update in pci_slot_unlock() after locking changes
Date: Sun, 4 May 2025 19:31:32 +0300
Message-ID: <1746376292-1827952-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e8aace-d770-47f0-7737-08dd8b2930ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l2iHuVioYBp6cYgJtQqnprVsO8G/mt204EIUegA1rGH6cJIuD6egXmKvBv58?=
 =?us-ascii?Q?NAKaNnaUn8MmE806c3p0KfQi4qYisJn7wkbd8vgJsDzvF7wbLjGvrRIE97SG?=
 =?us-ascii?Q?TbcY98QTi3wBut79qlYm2vzZMFMw7Gno1Gj8h8dhLvy9FCTvycoTHP5yzX8j?=
 =?us-ascii?Q?i8JGV6J39L0npZumHYAkMKCKAbaW+X3xiLS4IuxLrLBoSVG1VNyLRzEkado/?=
 =?us-ascii?Q?rKFQCqlca0ADqLaryWMv7Wg3cQNn5RsdVB7gM5iU3E3PC6oJiBQcPc6zeryT?=
 =?us-ascii?Q?ginXu2pnQuhmuwuJGrgE81ZXjfOL1DRHthDDUnGRfxZqSww8EAGM0l8ZxC8O?=
 =?us-ascii?Q?1i8LtSHwV9R6dNo1Rxwb51/L9CWtw/ycxfCH9IQ4Spm7x5Go3+nFoCIvTyxQ?=
 =?us-ascii?Q?xTZ3fzvufa5VJj7zFEx519jjkzHQTK7Rh/JIvM15qxFQxrbcAhqBM7Et+qpF?=
 =?us-ascii?Q?bnv2UaGPlqvpIiU5UI20qE0No0b7ku92BHq9tOK98ik/MdpxKzoncx0Obxi2?=
 =?us-ascii?Q?nP6VInQj0srUKZrEb0nxrH4zVcPyEeWuASpav3Ekh1NoBoQhMYUXxnRhFNKs?=
 =?us-ascii?Q?nB7Y/J8V3kFU6HekSYFyrl5X4blfJ1kqnorUpQmSojdMJ8YqtG/VbUk/0Hvr?=
 =?us-ascii?Q?GFdz+L0UNshiFjJUCpcUBxHVhCcAUvDD9MSB92X9VU6q/FTPy9q5hWC0VN+Y?=
 =?us-ascii?Q?ZYpARvvX64paPrOKWxE+oF8Ce6l3aXpGR5ZDr0wAsg90TkS1V1EvwPZbv6td?=
 =?us-ascii?Q?UcA0dHRmUi6eq5YVpybDMh0JSpm0Q4U6FYDkE2QbMR09pLlEMAJKTYxWOKJF?=
 =?us-ascii?Q?F+HDSgNVjaGEgetLon+03k37fgpjZF+oJJBkrlN3zEWykYMwTS8oxeTf+SWW?=
 =?us-ascii?Q?ls28gY7GO/i6u0AuT0/dDxFxSCk6KcyDYTjSM3XQ7v0EnEg4aXskNvVClFLO?=
 =?us-ascii?Q?wgXoaPMzgwwGKQJVbIHcAr6kBICYMaeE0cUSkvgs6pXdVZgv3869MaM1NUkS?=
 =?us-ascii?Q?DI6v3tS48Wvt1Ft7Qy/X8YCjX1hoYNoezWBcCoisJc/LarEVw9tVDPg8Xo1q?=
 =?us-ascii?Q?E6gZAwFvcshSCsKqaTZ1V//klHFXJlToUUWNfR71uR6dmaFkpPDLG6GrI3dz?=
 =?us-ascii?Q?R8YN42LclkYnWKEzg2BOc1uVT+ZpMt6r9oMCzX8c4Kgu5VFqZKQLimrZWWKf?=
 =?us-ascii?Q?Ex2BIAVlVjP8yZfGc0CvVqtXCs6mOsoZxK69OUnsZnBZJiWZrVC2K5Y3AStR?=
 =?us-ascii?Q?miEK/bfrS90MZS499IGfMbyvPdMwQ5bwsA3CVlguM5LKGZOSzCjo7ArR9fHt?=
 =?us-ascii?Q?npA145dy0lpljBbzIQoafGKjUZA7F4ZroZfR91h1hXl7hjU858M1IlRs5G9A?=
 =?us-ascii?Q?3ykTwhIsWFhV4mq9hACH91F11IlS1GlRoXp7wOE+kTq9O/aFVUpAhk1/4lkh?=
 =?us-ascii?Q?q167ZWgBsLCz6EjT655Xm3c1NYyXIu6/tX0Nia9YABUvNNbRwk6w5K0KrIzd?=
 =?us-ascii?Q?PbzPtmG5EUJlnWvr2EgfhyOJPAPZAgkSEstq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 16:31:58.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e8aace-d770-47f0-7737-08dd8b2930ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9

The cited patch updated pci_slot_lock(), pci_slot_trylock(),
pci_bus_lock(), and pci_bus_trylock() recursive locking, and adjusted
pci_bus_unlock() accordingly. However, it missed updating
pci_slot_unlock(), which may lead to attempting to unlock the
subordinate bridge's device lock twice.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..26507aa906d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5542,7 +5542,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 }
 
-- 
2.18.2


