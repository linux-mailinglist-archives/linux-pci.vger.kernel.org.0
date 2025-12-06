Return-Path: <linux-pci+bounces-42724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B962CAA67B
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C486631865D2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B912F617D;
	Sat,  6 Dec 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SevaC0ce"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9802D949C;
	Sat,  6 Dec 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024948; cv=fail; b=YQQ1wEZnIsCjgt4+aQHrGSaQoiugYRVWiya4OSgfpSjPsYy7UYsqQEPvGhrV7CciVC+9Eba2Ag34PnrhauVEjMv2AUxgIg9yBa6RnPmOYznfnlGQAKX5kz0iStpiNSp2NpiDoWCKPf6gIah2W3rKT00GckESN0zU5T+uwbgQ2Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024948; c=relaxed/simple;
	bh=2TnZSVssnnlFR9g3519yxnd9Pw1RnSIOWM6LUwnRtAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLEiDXgv/M1wYbwppk1aVNwO9DONhMgVuLjbjjD5Qk1DmUNVD7TnHdSJt5AkRu5Nlvh5n1Kc4LrvfmigkvL8TQ1SptvBtHMm1fkm6p4+3ONAnSkWnek0Gq/DlcTAvXu4NrVgxUFpxM+lc5D8hj34g+ePZfgxFec5kglDrswaOaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SevaC0ce; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjA6ATOXrg7Y6VmW2338S/ZS4C1F7Ftx9vvFdmX+Mx+lBnKe8hE4VfzaXEbpPgP3rbg2eI6EyviRzthmsn6fzfvHa4wikdvBFYtMkfEPJPNR9nZMSeEpuOSX/ojiG2qj08jTKChZjT/2JFWiUXo75dAOWM9YcYx7S6Ive/1kzn2le/J2EhiEQNH9+s5eYCazLoZQEOSflomFWS8WW7XzyqnaHRX4SXTWWTssskbklm42ysxvpy4ZEHhixuYyj8qk+r/aBFeIUe7+MeUs2Uc5OS3Fg+B0cxx2NTuiGHkID4asYJWm/qzDi/tswII5EvrsSHeIpIvWNXwMC9zwQBqqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KP/26wxm5FjqonfmkEOqmdKTX1jy8R4HtTGYYfn9Zk=;
 b=S86ATFZ5jt3wykdmZyXRZlT58quPQOKv+Eyg/zvI+mTC1HX+M/ocH+C6n0mY8aX7N0OMxwKqpNFf9pQ3YuIAo/8SoY1tAQnCHUE03Ek6yhXijOQPhu7SyNr0jQo8Ckf14BX5XFopOFP3Wt0xQrlW+3vf5TWZwBQFHHUKU1zfSzTG10ma+jo5L4Eblls1tpm1TIBAaQWGxQJAXmXJNsS+nSxaSirn6XAtMTho71jyeO0B35xsxhwOmvcAprNghhWgrXmGl43CZzC3z7WNrULKUqKN2HW10lHO3lHxCOt1BZe6RZ048SbL3hAF2+rqmMG6qePEet+HEeUvQ7O+xeDbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KP/26wxm5FjqonfmkEOqmdKTX1jy8R4HtTGYYfn9Zk=;
 b=SevaC0ceLoMUuqLX7pbhlDcJ3f1ODoh9IE8GxgXvnNH7YtOpVfmUhOMVOttpprzA8+WsvBLEBPk09PwuNCBrTZdXMnvPfT0srQ4UNQGP5CgSXJwKe43pg7yXTrcaclob+AC70sKtpShSaj+/FKmR/xNBPlR8qdgImkfpe3unMNqCEkSf7WDeSWVfLsvqKuvAk1WvwPn+H4lWe7J6sky3/1Uhitm2vAnCXBHrRHfGm5PH5Hh0dhJ/uED2gtKt0lc2nk1MSIEwkg+P94x7kMKJzhuyL8LFpERNeQOG8PAl3Z4SZ1KFDUaL3PerzCBQlwXbr/Ci+EtNrp20qxMilFmXOw==
Received: from CH0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:610:119::9)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Sat, 6 Dec
 2025 12:42:22 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::dd) by CH0PR03CA0362.outlook.office365.com
 (2603:10b6:610:119::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Sat,
 6 Dec 2025 12:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 12:42:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:13 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:13 -0800
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
Subject: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is enabled
Date: Sat, 6 Dec 2025 12:42:06 +0000
Message-ID: <20251206124208.305963-6-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: eb45ac8b-e30d-4ddc-c8ce-08de34c4e688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/YyH0NwED3D7dfOQanNA8b6uxi90P8PhgJyyiEh4b1FEbFpGLDfwBZ+ZivlA?=
 =?us-ascii?Q?284ot/uNEotiU2hzcnJ8kDvJOdY4/dnpxRqTp5TncljvnGY0i3BUS46sS7YZ?=
 =?us-ascii?Q?eb0Pbc6tzQud9jTJzJAGAJuOVf/x5ffQuiPBFFGfLQw9OKwXl3BiudNylTXg?=
 =?us-ascii?Q?US7SGcMV3b6M3kQkYHAKoCkVN4PCsW0cSaE4uF4134rYYNBbEyrbGLu1YgE/?=
 =?us-ascii?Q?c6syl+G551n8OV9mq5wfAHUGi6OpBiOxr1aAVEoN5T+6kwH8pCaDr+9HdsPz?=
 =?us-ascii?Q?L7QjZ5Twq+Fhy8yJzJFqb1rL5IOoN6UiaaOKIIYIrkILSB+hbiDeejz2Vx5l?=
 =?us-ascii?Q?rxdoiMXY5OeYx+rMyqtRNF/O7v3S6NjmlW2R0JhoMC7WKybA8DJiR1LMqQom?=
 =?us-ascii?Q?OQmrZ3BpC7ac5IOkwq+XQ/qawWeUdVOELJNUprB2imYUky5NC4KvU5371Yw0?=
 =?us-ascii?Q?ji5K1mPJBfEe99iTnn9xeutsxMW0diEyJSeBJk6kzC1B1BE6mnSOvF6z2E6g?=
 =?us-ascii?Q?zW8Z8AayApKak2HgwDSvkm2239GNVLm/uyshe+rz/+dIZVR6O+zsIe/TIAiJ?=
 =?us-ascii?Q?ehleuD5i55X6oFyHuubTq8psDFtMdWpF12qAblvqGjN5JMTApXcvXLjZe0yd?=
 =?us-ascii?Q?zQinJXaR1z8eB0aMm+LhUe8g7jtuScuy7xe99kUaHr1KKgx1Uhkuehn8lQzj?=
 =?us-ascii?Q?Ao232FJCNYWignyhgX+sAEMWmm5TwFZCA/FT9SdyfMPE6Ug+61MdvfZHo8Nq?=
 =?us-ascii?Q?xsIHVhl3ov4vdq5XnogwZMvhGZsos5d3P1Bxtw7kXj/skrXrif/ayKx2IQnh?=
 =?us-ascii?Q?io/ndVCUoGpfMokIHRw6KpFqz6/Ey+hygTc4plSDpQJKHj4C/auhfItZ1DZ2?=
 =?us-ascii?Q?CgwHMxtmN5U3euUz2pkG4bRFergwk2jrvqPSiEhw8rFOVg3hlw58Vq+DJiVt?=
 =?us-ascii?Q?w1WINBf0kkjjb65pnGjSN/q9nin/cYEW2mkVkzCRGn/1zDEKAoKC8Ty/8IQs?=
 =?us-ascii?Q?UB9t/B5NkkDjswEg9xxGUCkvNuTDE4WAFIGxGcpooxfvCLx7vAWuolO+We8Y?=
 =?us-ascii?Q?9Y8lOSylJ0QrKjg6GrKPI2O5W11RDVdW9w5OUaAY2eSW//Eqp+CUDTJfNEKk?=
 =?us-ascii?Q?mYNI89oAgeFbe6S4D+OEqHOsRs909T/wkxkvO2oHE4u/+mpRibLETEonKCkV?=
 =?us-ascii?Q?ong7NKe7FhV18652SQRYb5XHNWNgv0PITKOpHN2ob5chZD+7qWFFrN4yHXnk?=
 =?us-ascii?Q?YlmUA+8OV46Y18wGG0etZIUpJxZ8M4LxQrpVXKH4iwRrtzbNzQ/6E9Q+Cu2K?=
 =?us-ascii?Q?V/QlOMUVplrdN+ywwKrz6tJfDuosZPJ5Q9CKCff0TrPtQNzPhLayGRxV9Mm6?=
 =?us-ascii?Q?ZWLntZpGVPLYFkjayriKX5orNftMzKKR3MpmTO9Pemc62acrlkltCTqfirA4?=
 =?us-ascii?Q?9Ht1o0QfKhp+PmUHgVCytcf1MOe19xj14u6+QlKj0JuLLGfpHvs+1LlaBxBZ?=
 =?us-ascii?Q?3L3cJW7EDmrDnYM+euRNlqzLYpikY4yNWjb7Wl3D24RGquS7g88C3V1Hwu7i?=
 =?us-ascii?Q?PmwNwkOohXNtdioUBPw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:21.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb45ac8b-e30d-4ddc-c8ce-08de34c4e688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

The registry object "RMSetSriovMode" is required to be set when vGPU is
enabled.

Set "RMSetSriovMode" to 1 when nova-core is loading the GSP firmware and
initialize the GSP registry objects, if vGPU is enabled.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs     |  3 ++-
 drivers/gpu/nova-core/gsp/commands.rs | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 5016c630cec3..847ce550eccf 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -168,7 +168,8 @@ pub(crate) fn boot(
 
         self.cmdq
             .send_command(bar, commands::SetSystemInfo::new(pdev, vf_info))?;
-        self.cmdq.send_command(bar, commands::SetRegistry::new())?;
+        self.cmdq
+            .send_command(bar, commands::SetRegistry::new(vgpu_support))?;
 
         gsp_falcon.reset(bar)?;
         let libos_handle = self.libos.dma_handle();
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 1d519c4ed232..00ba48a25444 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -64,16 +64,18 @@ struct RegistryEntry {
 
 /// The `SetRegistry` command.
 pub(crate) struct SetRegistry {
-    entries: [RegistryEntry; Self::NUM_ENTRIES],
+    entries: [RegistryEntry; Self::MAX_NUM_ENTRIES],
+    num_entries: usize,
 }
 
 impl SetRegistry {
     // For now we hard-code the registry entries. Future work will allow others to
     // be added as module parameters.
-    const NUM_ENTRIES: usize = 3;
+    const MAX_NUM_ENTRIES: usize = 4;
 
     /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
-    pub(crate) fn new() -> Self {
+    pub(crate) fn new(vgpu_support: bool) -> Self {
+        let num_entries = if vgpu_support { 4 } else { 3 };
         Self {
             entries: [
                 // RMSecBusResetEnable - enables PCI secondary bus reset
@@ -93,7 +95,12 @@ pub(crate) fn new() -> Self {
                     key: "RMDevidCheckIgnore",
                     value: 1,
                 },
+                RegistryEntry {
+                    key: "RMSetSriovMode",
+                    value: 1,
+                },
             ],
+            num_entries,
         }
     }
 }
@@ -104,15 +111,15 @@ impl CommandToGsp for SetRegistry {
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        PackedRegistryTable::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
+        PackedRegistryTable::init(self.num_entries as u32, self.variable_payload_len() as u32)
     }
 
     fn variable_payload_len(&self) -> usize {
         let mut key_size = 0;
-        for i in 0..Self::NUM_ENTRIES {
+        for i in 0..self.num_entries {
             key_size += self.entries[i].key.len() + 1; // +1 for NULL terminator
         }
-        Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>() + key_size
+        self.num_entries * size_of::<PackedRegistryEntry>() + key_size
     }
 
     fn init_variable_payload(
@@ -120,12 +127,12 @@ fn init_variable_payload(
         dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
     ) -> Result {
         let string_data_start_offset =
-            size_of::<PackedRegistryTable>() + Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>();
+            size_of::<PackedRegistryTable>() + self.num_entries * size_of::<PackedRegistryEntry>();
 
         // Array for string data.
         let mut string_data = KVec::new();
 
-        for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
+        for entry in self.entries.iter().take(self.num_entries) {
             dst.write_all(
                 PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
-- 
2.51.0


