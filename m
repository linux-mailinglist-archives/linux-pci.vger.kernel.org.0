Return-Path: <linux-pci+bounces-42721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55436CAA648
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E592C30A601E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010A2E0904;
	Sat,  6 Dec 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acw4ey/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1D225788;
	Sat,  6 Dec 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024947; cv=fail; b=KI6nuvWKYn8C6WnCrn7FAys+slrU+dAN5AQAtFcwtqmcZzkNndl+90hS6LIBU7FMh6SvGgIFQJqVtJRNH1ASq4avkHg1cA3zpzSS65XHzix3MN4399lLqrE6svIQIv/zMQwgvYksEETlr+Ea3HlnPmCrmxZ2eYsI+FbV8e/H0qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024947; c=relaxed/simple;
	bh=rsHY+2C+PjX71x5KXoWRoX12bOcHGf26bGtF3badYDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBza0ByAWWMB51IHpzt5sgqcT33wrFDnxqxSlHn5Xq+bC/0u1XWK35s8t4dOOL6CqSUbcGhswueE2kVd5ELUWFf5ZeniWNZFSvTVt3FYlNHN1GRTwbmiXIw2J8db002SAnD5bqPrch2/1S4sZcJ+L0oDnZpBoWIR/i42tIxrDYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acw4ey/e; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVi1HM4Q4qNZOOKEueZH6IDjY0Nr6mb35+36hEag+84pGMtRDXp1HFN2Y1sFN5WY4z6UCMqF0BpwHg//gMPeeUQGzoSEcsAIOouMI/hm0RsXC8WmWp5oXm2VXs4PwXmT9RFITlM9nu5d/M2S1iq6Ldd0/hpsm9DvEvjhqAG01kFS6xf9nx/Bg0O5/t9KCSR/lSHRZ7oRD3nQNEeoP+qHtKcvVQk8zfCJypMG9m4I80/ES4Pn34GXmSMBJMgY59CorDmbGF1HUoxSClulnJOmaeJOUTM1p4PLj214prGPGjfZrOp+oB1y/7IRcpAi39UNt+jxpxNxUpqs/D4isGqeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6pRVJSv9H7Z1vT4tgkSpSNVMUsCMeE/XBwctpPNg5c=;
 b=pW6qlIyY7vO1ZA+hxuUezhVf904y3axM88HkD3TZSQwQYfM33D/yuaetFsAsN/u2G8VDacSL+DTtWDdRofMwRpNmDiaLQXAOg6XFeX2dI7B2CQkF/HaYqHAIoi7OMH1ss9RnTJ4Fqzhlm4f8D8TxUF7NHGh0J2nhZBaoRi95tN9kBedgq0Fh9YIl+mo/ZDJRPDsx1ueCIXpDZx0uN3z4WEBgeu2AT456uiL1/xBps2dpUphwxuHV4LeP/38mr3K4N/73otcfZO4nQZyxrZVq9ebNAqVckaPAVI95ZY96iJM1RjpcIfGRjAKgh7HRDisPWCwIYInBs/Qlpga+f1YWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6pRVJSv9H7Z1vT4tgkSpSNVMUsCMeE/XBwctpPNg5c=;
 b=acw4ey/ecQq8o0aJq72Fo5YXaHgIKnHbS7C4E6n3LY9fXxmj07LU6IuQI2TwVJ1a4TZwIInLqmLqX/bLIy70/voGYAGf2DO4ONwvd29TrKLSYR+dGlBqa5I/nykmliVQc1cIWV5EOwwN2TV9P/7DokZIAuu/cu7JrhY3V+5gzuQDipLduP1ZOKnJA9mVuFuJLUiWkol/PX3BAvLv//2H+akbYRhqIsfJlUTCxK2M34Vo2gDRa8qvlGAtU62tfQ3noFtFKUNOGI8POUja1w2BpECQOHrscpe7nV8Vjd+5YxxNQQu6MwrzPROqtUjXeuCBgVQ3obAoXtS+OWUoPUdYmA==
Received: from CH2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:610:5b::30)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 6 Dec
 2025 12:42:20 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::cf) by CH2PR07CA0056.outlook.office365.com
 (2603:10b6:610:5b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Sat,
 6 Dec 2025 12:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 12:42:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:12 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:12 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 2/7] [!UPSTREAM] rust: pci: support configuration space access
Date: Sat, 6 Dec 2025 12:42:03 +0000
Message-ID: <20251206124208.305963-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206124208.305963-1-zhiw@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b8f347-5297-4302-e022-08de34c4e577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iVIpL5L+/vGx/oPVukHhyKZJpwIhZuTYTJkE8Ye/llcZTYBOgsOYuJASggRR?=
 =?us-ascii?Q?NnU6r10/dBAkQDGJWDqP8maH5jKYNKvtJQDMvcNq6hiyVp6G76CTskGwtDGn?=
 =?us-ascii?Q?T8SE7SOylwQ+Dx+LIDhUElLwI3MfDeupbLqosMsFn3LaTu3gQZURK5uY2BBd?=
 =?us-ascii?Q?1W9fgIUldwKGO9WATbsYTDOQxEHq/ubWylE8BNb2kslyfewG6ndhLkyEUZAi?=
 =?us-ascii?Q?TgsCZrN6JN8bbvCRvisfOWiGImAGgZp8FEe9+oYbhsLkxUumCYRRpTT6ntYu?=
 =?us-ascii?Q?p2Jkjlxo6ofTywqrmJ6vdX9uMG/hqwUKwJca1G+HC/f2Rg/XETRKG5H4zz7h?=
 =?us-ascii?Q?B8RZKNRo1ypTH1U36xOoJQij0lKA6OQoIpNiDhvvyt8Oaol6G58CMpacQIbG?=
 =?us-ascii?Q?1kBmt9LlMDFb5EgOTNBZbuQbX43M7w4hwadBWa7I5AVlTmAsfIZgfh9FJPZ6?=
 =?us-ascii?Q?zSqlb0MxcVBFnWdI9gH8V7GLaCbqk0LaRqHySwBod8+DpBo9EW2V6BFL3g5O?=
 =?us-ascii?Q?YA4yyy4y9C7v7SeHP/5vm1y/6RoFa2PFt8ugbCUlTBQl20vTXyFbb5JtE4B2?=
 =?us-ascii?Q?iB/rQ3D4vJV2oPFndV6M8/RLNFtkppPAKYYOVjm/+w2sC1bMCgOZCNeq5mrL?=
 =?us-ascii?Q?4n6RfxQJzsD4eAQhd9ef/qlvtDctahTY7PRaeBKDL0a74qV7NRiZRqvwl6X0?=
 =?us-ascii?Q?6/A1IN32iuirLg6zPUB+vdO8JgTuX6fbpNW5u+cW1ICDAF6MWw258etsZuvw?=
 =?us-ascii?Q?CWQmECWR+DHTm3YJoT6eQ6wOY4p7P8vXZMVgKcbvkHbKZZhzIONgXWWcg6OR?=
 =?us-ascii?Q?GJqV0ThBW03HnKnD+FFQX+2sY87ZcB3iju+gIsIbvZAhJslEQvo9rKpVeVAq?=
 =?us-ascii?Q?42AGV07RuaqLZKFdf58sR1O+jW7N+C1EFi5kaT+FFI1HrXsYucquvFQRGli0?=
 =?us-ascii?Q?eVzJ/eKk+2Uxl1GoSZUdxExZKN7gePhwg4yRSSMmPwRMTgQhfU28x+sonmH8?=
 =?us-ascii?Q?crUjdPzrmgzqrJmaVXs4axwMu5FzIt1VadR+8xY9S+yLkkqsZY78fXzC8dsB?=
 =?us-ascii?Q?D0Ht/N0M0VPgNty/xqXDyNO4iAjKM9Fcf9puy4a4tXsdK/99MKcOiUsn88CQ?=
 =?us-ascii?Q?6eFPBh+KZ8G1U5zRbCmgIg7tiSoIb2iNyjVTTlcOqfVqoaY/xb/A49+pcYO8?=
 =?us-ascii?Q?Vlle6GEUQjE430BwLV34iNiabxgPArh7cWFYXLyZqsr9/pko3h8cJ58NKji0?=
 =?us-ascii?Q?l/a+qcP7XnKbG2k8Ew+tB6upmWXJ0hgXb28Ey1geU9cZxZnTKer50RmPszS4?=
 =?us-ascii?Q?+tIsTwvQEcViqjIUXB1Zy11EzHzW/JU02spXhIeMb45+tZEE8g3f+ZIub5Df?=
 =?us-ascii?Q?E5iuFXFczqU7p3L/RjuhITfCJ3gQIuiRybtMUl2DMSFPU4Be9x/Q8fDjf266?=
 =?us-ascii?Q?WOw44WOD92A+fG9LnpMfc44S2dsiIofk+na6azJNl8z/u8saGTtOKjQmg7GG?=
 =?us-ascii?Q?PFJQNW/oNkk124fTzWE0qpZIKnbni/eOH7X2CR9uWzqgcIqZAs4gnRN2bxhG?=
 =?us-ascii?Q?VebLWy+z8KYb3fpEBuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:19.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b8f347-5297-4302-e022-08de34c4e577
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

The work is WIP at [1].

Link: https://lore.kernel.org/all/20251119112117.116979-1-zhiw@nvidia.com/ [1]
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9a82e83dfd30..e7fdded9d746 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -526,6 +526,40 @@ pub fn sriov_get_totalvfs(&self) -> Result<i32> {
             Err(ENODEV)
         }
     }
+
+    /// Find the extended capability
+    pub fn find_ext_capability(&self, cap: i32) -> Option<u16> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let offset = unsafe { bindings::pci_find_ext_capability(self.as_raw(), cap) };
+        if offset != 0 {
+            Some(offset as u16)
+        } else {
+            None
+        }
+    }
+
+    /// Read configuration space by word
+    pub fn config_read_word(&self, where_: i32) -> Result<u16, Error> {
+        let mut val: u16 = 0;
+
+        // SAFETY: `self.as_raw()` is a valid pointer to `struct pci_dev`,
+        // and `&mut val` is a valid pointer to writable memory.
+        to_result(unsafe {
+            bindings::pci_read_config_word(self.as_raw(), where_, &mut val)
+        })?;
+
+        Ok(val)
+    }
+
+    /// Read configuration space by dword
+    pub fn config_read_dword(&self, where_: i32) -> Result<u32, Error> {
+        let mut val: u32 = 0;
+        // SAFETY: `self.as_raw()` is a valid pointer to `struct pci_dev`,
+        // and `&mut val` is a valid pointer to writable memory.
+        to_result(unsafe { bindings::pci_read_config_dword(self.as_raw(), where_, &mut val) })?;
+
+        Ok(val)
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.51.0


