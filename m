Return-Path: <linux-pci+bounces-40777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047BC4946A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C196D1884D20
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8472F12DA;
	Mon, 10 Nov 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJDOmX7h"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9002F12C4;
	Mon, 10 Nov 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807328; cv=fail; b=X5Lc8XzfFOKT+tkoPmkkp1KCrhcrF2hcr7wqDGROX/7SLhucnGL9v8QgS6NElxRzqibw+wCjr2mwjNw6ikkoej0lmqakAY3ux5SrdVfTD+glzbENyLsnecirDnGhRik9pzM/28OzVqo2W1ufxkR5DWThRL9dpXXjBZqyuzN0PLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807328; c=relaxed/simple;
	bh=pmufUxO4slioaJ2XtjP+dPrsPcRDjxS4Yfvv2hMe+R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgqnXCZlI79/yfBR9hvjKhO5Cy3SezEAHJbi+20cXfmJx4ptkLUjnIxgLuaDgggt3T1Uj7HEdnT2pAEu3c4TdN0VitmHErH6szd1AQC3oUjt+PnaTvupW3pxv5OxbammqYU6DOqKBw6k4JiLpjjcmmcmDgtxc3FFEwRkxqVweAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJDOmX7h; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXf/BJ18mq7xgHfw+Xjs0YMT3CXtxHSnUPekWQSs9q4pJOqv+7hZJzFVtu/iKruk8JeekD5V4thnyHhwQfQ7QqBYlol+qmX9pbN4BtG4vuclBH80vMh84RX3D1ALm/jxSHMSvt3r+tmHYFh3UMOwjZL60HF6Ku9lzXm623m1Z2OkeqTUmmQvwm0vfdCSZczhfBK8cDc1DrORuzja/Sic6+tLXghC+Mp9EA6bKOKLJ9syX38+8pP/tuYBy16rrBHaLoUHmrBZY/vjnpmADWr8GXKFHfAYqcf71glwdVPlRUm0eilYduNb36t8x9YPXK03IBgKpzHRdfy7nTCBTqpLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=aWCLzzAX6KjggBgZ1yC9QKpd1/fp0oDiLYdI6/73fAAFCt4v3Suc7LLiRJdXdKioH35roLmyJzd1CZ6s96T7Vs/X8x33vD9E73VXqPOihLvQv2chv2wkMjlOPpqjeGAMek9sD8ZzCyAYxfHRpwt9XfaqKgYMir3mCb34EQpQo6B8uFFmH4vX/61AfTqRpjk9HQ9kjdYX7C3ajBF3m/7jEVKag1yBcpBqGC5SG97u4eleR1YMLp2vLvmCYk3Esjhn0MbAOwYcDZg+0Z6KAmPNq1iK/GV9qEURXyX9ysN00Ag6YzSeAb/uqFdSu79I+158ACDYnJMID2NWEEi7E4RgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHnxk5gTlMEwwObcrUO522PaSj/dgW0lDqaTDSNRIx8=;
 b=lJDOmX7hh7N6CuEsULaLbVgl7fWJZ2/9d93CAh5FNAbppCsQ/TOYePqOivetFhdSlWcKjtOjNLy5T5KApraGHqN82cd2aUr64slvaDZjBhrfp52c24nh5j7KT43ZvWw/UiuzpW5Q0cLjCSLb3EeXf9xShmcs9kXEdyICWq9yPmfNh2zmihkUQXY+8o+xxok0NY0Q78VwMb/NAsq/fcJ9DjG3qRFhbJ0Jybq9hzQpTJGj24y4kKAOheQI2W3xutP5PT6GV8LKCRt8k0h4/XZa6gpXjRMm94Jf0pe+SgrNYaX7LKHOQJFa8WntyCOA24zlvxXgFGNO7O+EO2xWMgJV4A==
Received: from CYZPR17CA0002.namprd17.prod.outlook.com (2603:10b6:930:8c::24)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:42:02 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::63) by CYZPR17CA0002.outlook.office365.com
 (2603:10b6:930:8c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:41 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:41:33 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v6 RESEND 1/7] samples: rust: rust_driver_pci: use "kernel vertical" style for imports
Date: Mon, 10 Nov 2025 22:41:13 +0200
Message-ID: <20251110204119.18351-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f0e228-dcbf-4d14-eb28-08de20999a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWcB0Nz9QmoqCnsoi/ishQKVxMukQ138K26lBGI7e8KVFOskjMHb63CjD5fg?=
 =?us-ascii?Q?JdUZ+o3xYuyZZr0EMeQYLL2mFh0v0MS1Ozc5xePZ5fodpe4lFqEj7lKewZ23?=
 =?us-ascii?Q?BZuek4u6oEiVIHZWpfwwnfdrjZuFGMvK7feAQvv9MQnFxQlujnLRxGtEi43v?=
 =?us-ascii?Q?BRCW1m/1YPTEkz+eqxiAmAEFa46Z6Ggugd7f0DdB9GefldYnjWNYoTWLOVQC?=
 =?us-ascii?Q?kVQncgwBxChG1wG2rK4dvs5AIlWEUjd7/hyw8RuN5v1OoTPH8BQr8pihqnBT?=
 =?us-ascii?Q?mWEqUnanIb+N00DXxhPZqbDRNvVHP/538V3s4+7Y+ts3klVTtgsCMt+Jgw19?=
 =?us-ascii?Q?ep2lAOs+HG5PH5a6xYaDvtIfzkPg3IZQNmsm5VgW4EtYhuGjv8a8S0rmChli?=
 =?us-ascii?Q?MXNmDFX9aJodhNBGNYIeIYNNeaWWFLBtNu6wA85ShrupY3BW8M6eLalS0Gb1?=
 =?us-ascii?Q?DVGeDy6RMphDgfECkNZ4kUh8j5e9gGRkoQBIJgPw9eBPelKAIydExQbSbI0Q?=
 =?us-ascii?Q?xGzBXnlHpQonzsp4NI68jgjyGioHZ4Il1FGFQfAJmi1VrRRMY2t87UdETBuQ?=
 =?us-ascii?Q?ZEv/zt++aAjYcYegqwhMxiNgXLGVumS0eJ3gXK/9CqvY9bko8lp2Unfp2KJe?=
 =?us-ascii?Q?SzsU4aiPlQRG+X2H4LCy3P8/2nhm30DtmY9+3B0JxHoZeOx9Aqg7uF2RXOK+?=
 =?us-ascii?Q?mKCd9pVAMuU+9KB6sEZUouD6zmxxboDhlmU/F1/YmYlYITdCsvaf3W3fG8vy?=
 =?us-ascii?Q?ivCWutWP71CWRqlOLNoAmhQx5K0pN3I+gJ3asdHo/4jkWslPneh28KPkj28r?=
 =?us-ascii?Q?Ka7Sef4dNhUA53vYtQm6VssfcR9chgEC2j/b5MfBRK1fTowJjP/7lPLBE3VB?=
 =?us-ascii?Q?hQid9a/2jW1DsLIl2MPE7tgTFqqVarYUxGedM2WbQGXPVp3tDBPu8RUU6jU8?=
 =?us-ascii?Q?IQLDLqNF8/n36kM+7+Mxuhnb4SBhLOi+8Y58PMXP8Kdk2J6n/iTjr2rhZABV?=
 =?us-ascii?Q?hxBbzHUgR7HDnj4bpNsQqrgWpacC8zQncQf2YzcQD+K6zdoUGvLE1L2QbyBq?=
 =?us-ascii?Q?wqYo4hkcl4dqG5yPCr5gdlsdM1UcQ9cTd0So4q5Rr1rwGbmskuVpaeYz0ibA?=
 =?us-ascii?Q?UTfIt3wv9u2JBONCp0XrkxZ5vd5jYysNsZqg9WRWbhK8T3WE/chgTdLsf30a?=
 =?us-ascii?Q?oOja/lzNrlRZaMVaVVQ/BW8Xuw72HghUg8A1EKjFS02thgDZQkYsSa4KwJ4k?=
 =?us-ascii?Q?CCm9vWkhNZ01+H/zBoNLLb3Batx1Fe3YccwHrplXCOIhjjebuAxa0I2gpAzz?=
 =?us-ascii?Q?QbySfQHF3Tqaj0NzHgr0WWfutJILGUPrJJinV5IszmmjIr4DHkiVPmPtSxqT?=
 =?us-ascii?Q?GmKcDFKdtsgLLd/6rhYhuEICDQ7kDkI/nSnKJPgobo/WGYFpz63DSB74nuBf?=
 =?us-ascii?Q?uB0hDUglFx3kQHjgAMh10G99OQkPmNrTT3ru9qZcMWMq+dcz8DxLCO5lUQSR?=
 =?us-ascii?Q?dVTAvM7Qgm0o+yaCMBuktruxXy0lei4cC4xfH7ulGAxmkzzXY/L7W4O+l2vl?=
 =?us-ascii?Q?rDe/DmpbIV6Sp6JT3ng=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:02.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f0e228-dcbf-4d14-eb28-08de20999a86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

Convert all imports in the rust_driver_pci to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..ee6248b8cda5 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,14 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
+use kernel::{
+    c_str,
+    device::Core,
+    devres::Devres,
+    pci,
+    prelude::*,
+    sync::aref::ARef, //
+};
 
 struct Regs;
 
-- 
2.51.0


