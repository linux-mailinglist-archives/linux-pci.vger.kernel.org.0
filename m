Return-Path: <linux-pci+bounces-42327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B70C950C4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45974E0EB6
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8DD27F75C;
	Sun, 30 Nov 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dBRb9+1X"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A422274670;
	Sun, 30 Nov 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515473; cv=fail; b=pywnecs/Qm7MS3nwASV2bt69Lev+UvyEoIZN5uokDu46+RGeCZtmJBO0DqYSx43aCePjtB69aNH10ZlKVW9LmTYL3LWmXNqxdNECpvnSEwVdUixmkUmy3Er+xKgzqf0xEmqP3beJ933kKBUwvr48R7kPxRWnU+PSZzlxHkKrt4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515473; c=relaxed/simple;
	bh=rP0p1ILfWNTqLsSUX4OcvDyxfrGW6bWFA8pcS7q1IBY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CFa4uFFKsF6x7PA6R4b1KxpRG8VaX6M/EzUGn++R1kdAChX3s+QOk6+QbBi0rg1frRzJL0YMhZzkI5padecbPdyNr9CwxhMRH58UhDdbuHAqLzilOE0mzjpIoJlhtcTwWZm3HDOBrIBlNKdhEokW0QQJ3tPEg8djYx4ApjiDrWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dBRb9+1X; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXA9gaYEbbAenko4P4a1doMYrSns3EdyqQLhH8diTgj5JatgqWgcbzY3ZKeIZi4xZ6HbuhmqhuMAbPG7SxLR8uOPeiODPLz5zfIAmi7eC1BXYXMarZnj5g/CuxiFXUdxm4iG+VLg7OteET5eeJdF/XWvmtL3jQ8hUf43+Qqb1IeR+KmO2ALhS8xMbtcP/d+wQueom0C4Rwr5+NNSHURgxPa5hB7uSgp+ZJkmMp1KKBV2da2qhAmytc89drjEbwNxzPGJqnO7kX5U6S+GQ0trS0MILYWBFcoV5T3tkGA5eKG63h6sEs/uNPN+7gUxrpNNVLELnyerbjjTsH1Vc3fpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzVrr0UNRTrh5bfCmD7sbZfkv3WQFb3CcOFqGeRWMWE=;
 b=I5Z4eJJiOQdwZDgNct7kJC5YRfSTmQjbY+D7NorHlHpEYLqYluQSegGeh5rBKfAu1oExto35euTBIQuvrJh32JwsBw1kzocA8y4JbN/KZ679sD10AKDAdcqSWQe0SnmhZk8gRNDiqy7sGrJxteptE1atVpL5vETBi3NS7dHTPr+vLQXCAJIXzhlslmGWVD+cKoEv8mTSltibVHh3XSYUsLLKefP+DYFLGaWxK2l4/1niKARK6422LKfmJaGefA347Lh5272IEchG2Rq9RAT63AIRmJ8KP0OcX59N+LF9PayQ9SgGDt8p3DNMcwmcyIgDQOsqn0dxFSbsK4e87U9y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzVrr0UNRTrh5bfCmD7sbZfkv3WQFb3CcOFqGeRWMWE=;
 b=dBRb9+1X7oAAGVUGthnCkBzzNfj4FwNyIMiej7+x/Mgm0N6j85TSCQVWq4Tueqm5sv/yPi1ojyEh/AHWqcbYGQwxYaAA+amSx0P93sr7JxLs/CSPnBloRSzK29My/ikh4wrtxprgTZaq3d6DGngq6TpnPF3UiNRa9dnz8EDYzTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:05 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	stable@vger.kernel.org
Subject: [PATCH v3 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Date: Mon,  1 Dec 2025 00:10:53 +0900
Message-ID: <20251130151100.2591822-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0267.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d60bd5b-466e-4233-6453-08de3022aebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJ83icMtBXGTVxt9u8InjRRLb70Z5Irh3V7HFziDADZPC1V22HmlmJuS0OBP?=
 =?us-ascii?Q?z4A60NsWL03aZntx3OrG5JDwMAmt0cA6ZB1EBy99HaMxdCvsVFGLneAzmOSA?=
 =?us-ascii?Q?0SKWJWDZRio0W5AXo3ZR75K8bBBMKvDV36tKnA679R1oktTcJ64b/jFFGQTf?=
 =?us-ascii?Q?GRWYQiFfI2eIpiwNN0GQEsVlVbRxLMqXTWlHnWFAf9xA7SHtHBUH+5MISTzK?=
 =?us-ascii?Q?pq5JxphJi/eGEg+Xm9TkVEuJ0wYhYOlBmuTq8uWRSnAoUX3uzbVP6zXUMKDn?=
 =?us-ascii?Q?XDdjs39H7ve3fFgjJ6eLktKtNQ9wTvwSYzSNjD2Q/DRs/T/nEO8xY0tTUgOj?=
 =?us-ascii?Q?7UA+HJ5Ta0mY0Qs/RfDpx9kbS2Gr2tJRxK8Ei6Yx38bbPZT+rzXL2iN66My2?=
 =?us-ascii?Q?S12DKtb/5zObPI8qYvh3bm+FV6g/XPLaoQb+CigQ6/tQtM6qPwcUo2izWh4A?=
 =?us-ascii?Q?0mBAN1GvUb3oDNXs3KaLW5iZeBuPaGMZJzLWsNHabNVf9MPK7cDpTjABuGly?=
 =?us-ascii?Q?MGt9BimTLnxjqW64qxfE82FF0iGGHrdkf9kzr9WhTBVwWSitiGOBxBrOFESR?=
 =?us-ascii?Q?SdfgK7UWpMjx3S41Hb6JJT3zU5KPRR0dLxvKgSNIFe67MIXW0CVWcU0/JKMG?=
 =?us-ascii?Q?NIrezq/v/5e7uOFs2XN4gx40IlzvX8+ru4oY1paJ5yuDjpK3LCPNxEfTSmnp?=
 =?us-ascii?Q?2L7rzXA4p7Q2WX/vRgleS2jN+u8JK237YhGW1/Hx+beT3CY3rwsLDeuvQa69?=
 =?us-ascii?Q?ocbsBMnsmhMJQ65yFf1+XrAiiBuWg9omXI2vyhMkQyuw0v2TAkL/d4gtcW3u?=
 =?us-ascii?Q?M5A0Hob8elx606OQOjy3QTCOuTIWHckceA1nTaUxvCo/F/LajJloWjjSacK9?=
 =?us-ascii?Q?Gt12YwjgKaDU7+pQeOfG2TNlrgAj1d+l/ZP7gsdSm2RZJRDCjgLdnmHlvVFc?=
 =?us-ascii?Q?t+mURdTuIjf34hun1y5x6UgtHI34nmwKWpZ0WM+2jWvVLbTCvHrnJ+Yirm5j?=
 =?us-ascii?Q?ElptS7X8A7LMX7WuwNuSf0R+kc5RW6vyZ8UgzAHXmrHanjh8UKJMUhwcIVUv?=
 =?us-ascii?Q?hAreibus7B7N/NPEJ6h0xq1AMB6XAe5SHu9orSgVhASA54IFdcf0nF2EVFZ2?=
 =?us-ascii?Q?xfd+hqyyDMsuXkZUpLf/l2lymGy/POUQHk7RyRVjM4mcwh9AetwsCqxME2i+?=
 =?us-ascii?Q?xGzgTOgKxXM4j9+UjnQQ1Ug9sTgOnGdYMW/rRKNexbxRo0Iy+24tN+cVfJde?=
 =?us-ascii?Q?jaBfZUoTvsqM5Sg1JRCNmN71YkD+e8zmOt1VW30cxvyAhnRstJLkqQzLwaGq?=
 =?us-ascii?Q?dN6oOxG4pIJ/C4WPFEQ3ED6vUB433PQZZzPx8A2BDR7RPU+BGR574tXrLgOG?=
 =?us-ascii?Q?2TA/NM9uaE6eHTxnzpi5qrGxWzK0LAZ75JspgBC2a1XkUfJk4KPX6250WuTA?=
 =?us-ascii?Q?thF+1AwSExnTTMfAEFlRGyz0Q+PArrCEf1nG3p6HgRrc/N3LVTpqDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEdrM1DCMYH8O06bT0KXj5EHDxcN+ZOVYK8Wwkdvfe24tWgozgzaZKWmVZdZ?=
 =?us-ascii?Q?afCxIY3eXxmy5ifbVjoJBwZeG5fNpFTxOvCwPruHWWQQ1ebC5Fy72ni9wwyY?=
 =?us-ascii?Q?g0tLWfikjLJ7yY3i4H73k7167eAzbfWjB5ohSHYD1+EQPQ08aKkIqJ1qLGvU?=
 =?us-ascii?Q?T8v93sniaWNcl865qN2q7cCRk8sh9nEkF+D7mGlCToIVDyCmcPVyyMoDOCfK?=
 =?us-ascii?Q?qSQDayNZ+ckWItHbCKYvoa4M37iNjR6dLirHF/QGzXF0hrK2EuINLIkBpnm0?=
 =?us-ascii?Q?318JY1skyU+31LBWJOEC8bVNKc3FqpRRw8VT3dEGltLnEYm6EkMZsUa/Q+/S?=
 =?us-ascii?Q?AF5nSWqjItqE+sQvhaQQeW9/RgGdATJ2x3W5JbwGJQ1yIpE5T3Uyv6Yj8/gF?=
 =?us-ascii?Q?k8l3ZSP10hm6xICSA3UJuuxADiAOn31hOuhvsH9e3MyWXVLrlQ7PdK0qAsUf?=
 =?us-ascii?Q?J3AAzTgVIMywO8wZU3xaCclDZSitKUJVs9AFg2YtrogWQx74iGy9a5yWbRy9?=
 =?us-ascii?Q?Vg7JDOkwoXLfhF+I8qTTqs0h7hikpoy8LjbLwkiUW7GF0yTnOy9T+0+Zg0lv?=
 =?us-ascii?Q?MjZS+JapNqtzZYVARnm9zBMuDqmbAiyVXSbVKM1loosBBV2czvHR8Z4lYvzY?=
 =?us-ascii?Q?C/pPEyTMwVjOq93g1elZYZUeWN6POOs11fd7fbZIta32eCCiuhr6fWgMi191?=
 =?us-ascii?Q?AuVUy1pZjyfxvc57Ui0Wp/kToJJ2HxxpUpZgkd+AP4T/mXKDR2P8pO92ow6C?=
 =?us-ascii?Q?s3KQWsYijtdUX3vvtXD+H8u0DrLSb6E6bN/p8IcO4WrC4bAQX1F+weAeQpOL?=
 =?us-ascii?Q?qwWEAKLtX/rieMzvVNagqtQQl1sKdr9mrCMgqotAoPJahTO635ld2q6xg+N9?=
 =?us-ascii?Q?Khq0wfPO+s4RpYwpiRZptxPY6Fze24XTLKWfqkPt6YUGiPkhHkLqIFvKDBbF?=
 =?us-ascii?Q?h2E9RKsb4x4Ic6auLvqitzqmYNpjkKCNCt8hGFCPgSGHyojpqqBcKboZAi0s?=
 =?us-ascii?Q?9FEL5GPsu3DNU5ikcdKgN/Whg7L8VwGu66P0n1r4uIr7uyN1/cJ7K5e36J35?=
 =?us-ascii?Q?W/h43oXg56yg2Q6j4UQo/Q9Ye2YujtmrDN8vfcG0cwlLCtC7yySLw7Z2783l?=
 =?us-ascii?Q?hUgje2POhAJYmiGM3LG32SKXC8zKTab/CScXYrMR+1lRciLs7wtkHIXqix/D?=
 =?us-ascii?Q?oXRDJ0sSCR8Tgf74W2k3WShyqnAI+Y956QaTXooyrr5bVMs3Si3CwweAMVKH?=
 =?us-ascii?Q?o7ZjZYCIPMpzYcmlNVlwaQTmCJJ7tISH9rgd5A1QZjA89XpkoAxYDmdBXk07?=
 =?us-ascii?Q?6RZ0ok25CSod12wMYLB8Sw4EApR7QNUn+p2OdyQ8ys6Fwz/zFfAdw+VyGH+g?=
 =?us-ascii?Q?JS+STyGJa862/BVCTjmDm5L2E7H7vW42DfESwoc7pTYTdtHC3HCdVWY9M6O2?=
 =?us-ascii?Q?I148hGcB9XxofhfMF8spb3VB7+CGoAgDW130KclofNmuK6VM5Vl6YkAcIMz3?=
 =?us-ascii?Q?jb1n4BrgCIEljl4jfMkiJn0sTuPPwOAd9t5gJ7HH6dFnQ7trVt9FbP3Es1bf?=
 =?us-ascii?Q?gBJ2EWrGrr7bZnCnTS9Zh4s3ynjc2DoMNoLzi8lluTdICp09FAv1eIHfqqAO?=
 =?us-ascii?Q?z9BbilTKwlHtohPp2BzHVJ0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d60bd5b-466e-4233-6453-08de3022aebd
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:05.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HIvX9oZf0U1X8Sv/VJQseJ5zMAcIPknEjRhOOOxwE+2KUkjr+QWuhg8l+R1L/8mRdImVqtzXxwRh55NxG3VOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
through configfs (link/unlink functions, start/stop the controller, update
parameters). In practice, several pitfalls present: double-unmapping when two
windows share a BAR, wrong parameter order in .drop_link leading to wrong
object lookups, duplicate EPC teardown that leads to oopses, a work item
running after resources were torn down, and inability to re-link/restart
fundamentally because ntb_dev was embedded and the vPCI bus teardown was
incomplete.

This series addresses those issues and hardens resource management across NTB
EPF and PCI EP core:

- Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
- Fix configfs .drop_link parameter order so the correct groups are used during
  unlink.
- Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
  avoiding crashes on .allow_link failures and during .drop_link.
- Stop the delayed cmd_handler work before clearing BARs/doorbells.
- Manage ntb_dev as a devm-managed allocation and implement .remove() in the
  vNTB PCI driver. Switch to pci_scan_root_bus().

With these changes, the controller can now be stopped, a function unlinked,
configfs settings updated, and the controller re-linked and restarted
without rebooting the endpoint, as long as the underlying pci_epc_ops
.stop() is non-destructive and .start() restores normal operation.

Patches 1-5 carry Fixes tags and are candidates for stable.
Patch 6 is a preparatory one for Patch 7.
Patch 7 is a behavioral improvement that completes lifetime management for
relink/restart scenarios.

Apologies for the delay between v2 and v3, and thank you for the review.


v2->v3 changes:
  - Added Reviewed-by tag for [PATCH v2 4/6]
  - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
  (No code changes overall.)
v1->v2 changes:
  - Incorporated feedback from Frank.
  - Added Reviewed-by tags (except for patches #4 and #6).
  - Fixed a typo in patch #5 title.
  (No code changes overall.)

v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/


Koichiro Den (7):
  NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
    share BAR
  PCI: endpoint: Fix parameter order for .drop_link
  PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
  NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
  PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
    pci_scan_root_bus()
  PCI: endpoint: pci-epf-vntb: Manage ntb_dev lifetime and fix vpci bus
    teardown

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
 4 files changed, 62 insertions(+), 91 deletions(-)

-- 
2.48.1


