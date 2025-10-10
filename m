Return-Path: <linux-pci+bounces-37793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF7BCC0F5
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40DA4F3DD1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B328000C;
	Fri, 10 Oct 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHnGJncI"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF527FB0E;
	Fri, 10 Oct 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083440; cv=fail; b=sRh7SJKBB9x/1obehqnlNa1Jmc+4pOdA9qvRn5wz9eMoI8FawUz6uQVd6SgwBOpc9OZcgKXgFhx8jykNlIzgXX/HedObm88yeKn10G7u/Rns+7JSzMVrI5vZHLsW+wpG+E3SMV8bvbMCT9DrQBI1XcjhR37G2H7b5Zo1Hhd5lkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083440; c=relaxed/simple;
	bh=4k6VymLTRDXdmhpcL+IeeTaUZty0fnpSu0SO9yOurZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVJBwgeDKD5LAgBHYeN+TIw57s+xr6wv30otK3WoUyzkl7YwM/b9wsGWoef03mpARraUT0OtPdFKJQMbiuuNiWu/rpvn2Y+qm2urUlUoThEfb4/KQVNBqMFfWoHj5MDAMdho958NETKnBgE2G7vtG/uGPgB0zDNjGJQ9d1P9J0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHnGJncI; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7qnAFZ1n4Vo4QK8MP0mzk62NeZSw02Fsbp9HNFouhMopHmjGXqNEItd66V66hFxXFvMuCXojQw4xntxz8+Vhs1A3uZgR8IAAjneU61pEVQdu0AqkE7r0BCSEFrFsluQTZoBckr9/RTQyNFiY+EFqwAtICFiyVfbDsVPp/06T6XW7lUdEBGM+yTHeH4CyFGyQh8JGkFl5pyeHAMS5tKRaBCYAqKW9t38In2EnH/BgLzliyhB/p5KWbgmFSTBhTyD5SW2EGgstqkSoyxJCVmTct5coADKefvL8fwcqDkNkkKlaBL8ZUZ+NyDaGBCmsZDGxUbhOZLWf4BEo21KxP0wjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+JKKciUi5RESVKBXPE9hvJKLVqvKcU1tY04C/ZNzss=;
 b=wwwlJMdmA8oPP/9vyYKPMU70xSnMjAr3Be3i8TS7bs3zoDJ5ES37SJcRH07KQeZ0OtCJFeEjCiMRIQhIvtz12j0a+W8OgZhcrjGTZITrMvkgoNaqBKj7ji7fEc4WxhQdJ/T2kp5xJ0hP+3pewe68/nsnRvc+HSnEUddoXbD0jcF0SDJqpRJ/WIU2bJGzmcjZG0NN4UlLa6IbPUODqzFnL7HuEb2MHVSxPh7IvSBNx/BK8Fhyl2r7HGxC2KFHebTUBkyStj2xFfqrrgCm4Ws7CkQAiaX5vRVMJ9LF0FYXdCwf/ukTdvqt/6tV7zfac7K1BjtKqd+bBKI916TChkHwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+JKKciUi5RESVKBXPE9hvJKLVqvKcU1tY04C/ZNzss=;
 b=tHnGJncIxu1+n/PPEXEg6nsD2JqJEvPqsYh5XEImTwPOXMs0EhFolT0K1kkcakqt2bIho9woN//0d0LQOn8vWWlegApJvz3AwBHjMDs0rL9H3g81+46ST1wBnaYFuqPpCO3DBohzrINR57W1J/4BBmAt0Hht176g1J3TXAcgw4uG5ap6uQwzUYtE68hLQjP2GnSQi1FG3wrwNH/lOs+ax5i4M9AwP5KRr9ULnFBgNrOrmORm9TwSJzSGpireOA+f8ndfSt/6CZes+Qr/On3CNbPfn7DJmHoCCQjXH8jSPkiwy5kJD1nKMCF7bmPOPR4w6GkiNJG41GDzAqzNw53W0g==
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 08:03:54 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::74) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 08:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 01:03:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:43 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:42 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 5/6] rust: pci: add helper to find extended capability
Date: Fri, 10 Oct 2025 08:03:29 +0000
Message-ID: <20251010080330.183559-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010080330.183559-1-zhiw@nvidia.com>
References: <20251010080330.183559-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9448c8-40a3-4a67-21a5-08de07d38e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YELxQSwhVaU7DGinTPy/Ofhz3aguFUgl4xaBabxdCRbq57KzeIjQ3znXom+7?=
 =?us-ascii?Q?3j1pbMwREzpCNDLLCTO08FwxeRcUbJS9Q7kjK0dL/NIRP33RE8BqJoZdU6X4?=
 =?us-ascii?Q?KlRuNr8duQUDo/2bPFzAZdkmPhFhtw+wc8Jg/j6wTkLSLc57ntqQq/v2W3+f?=
 =?us-ascii?Q?PA5iJKgyCqpyygLB7uPlhNZICvte/EIHCGtTH6fW1sSAR+QVgmKmUezacgyw?=
 =?us-ascii?Q?RqGmDTPZymDauwmwiaPEW/0Xk4TLXWiafZ497Yc4iYDBI9BA4nF/aP8kGWAa?=
 =?us-ascii?Q?MehnmLRMDVqZENFtelg5P98xBFbYC4K/fU2M4GL1p5pj4tj5ooWhC4QUD3HJ?=
 =?us-ascii?Q?qy+3OQp8W8V+b+gTHncUxjQ3HE0oe5atfHiKjAi0xc+PWfMOCDswMYPyc70s?=
 =?us-ascii?Q?iSFzrB4J/qae1AGji+Jox8mzTTYEpAhCatuIRttafs+YJ2uQ6tRyliodJCzw?=
 =?us-ascii?Q?HwQMT3LD4BfNrmy9zXlJuq3ob5eAqavjFfoTq/Q9b+LtQC/9rKxXEwiLA/Lw?=
 =?us-ascii?Q?38GrHVJJX/gxk2khCyM/p4sUVm467IIKIP9+ie0FdD0BrYD3voIEZVc0y3rz?=
 =?us-ascii?Q?PDtGtxAgflrXvwIdE6T40KdkC/hfCRgh7uKXr8Ov0poZ4qsMWT7qAAY5gcQd?=
 =?us-ascii?Q?vtO4hQyCQoPMciVGinxGV0LTwpGmF03oq4qT+q76HyAedtzUOjkxFfpGQ8lP?=
 =?us-ascii?Q?fyfkIsFiG9soCIletHVx+eYs7ML4klmOYtOXV0q1AJOsVV6pXXFqyIOK0uG/?=
 =?us-ascii?Q?7D7jlaaeVU4sXSl54W+hY/0ZeQ/EJfvcHEdsOPzsfXsn6aqUwa0qh0Oduq2c?=
 =?us-ascii?Q?W+RJiQbkfagyPgh6lL/thG7f27/IUm48H3RGL5dnh6KMi03DTjqOuoQOzSQq?=
 =?us-ascii?Q?dzsZUtIp7gT/y3dZKIBmbTCN8OSO4x/UnG40u3wJnpzIM0to9snLszudcfU6?=
 =?us-ascii?Q?wWYrPCj4vVX9dle7vkp6rEZ6/GooFiiMkuTJD6346f3vzcgUWQH82yi7SG0y?=
 =?us-ascii?Q?QhpgyiW7XJrUg2qGpZXNYLZikWLWvMFW7NUBCHxoh31J9WLZJ5TZNl594k2a?=
 =?us-ascii?Q?se8iNcpBTUJoEqwCA58nWEE/UasziJRCVGngeQfv6onFgkfOzVZAYoFO58yt?=
 =?us-ascii?Q?GZPCijJqp1SQ0QR/W6Vbeb1lLLkThI/7k/9qnWpmUMNq6iGN+6nBTtRiVTsV?=
 =?us-ascii?Q?/Am77snnxrWPLcVfgdqB3aq1gLMopPd7ng6ZJ6slibtFVqvpDqFmR1jdhDDv?=
 =?us-ascii?Q?mvLI6IETvK9FgK0CWkKMGb2W4ylzTzj0wDe5W9bOVFeTsWDH9sHSshbJrkyX?=
 =?us-ascii?Q?jAMY+XH7fzwC8vzT3F5jALgV7qFuOIRMYxyQWdForqaxKVhRvXWkQIEVgDqA?=
 =?us-ascii?Q?vqHQj4nACx+tX2W/TNEDQALo3G1WL1ANuuLkpjMfX6CwrD4llRzL6tHvKb0f?=
 =?us-ascii?Q?xSqS9mZ2c0+SyQnjlDbeOhRSZx0sjNCKMBaOblA+2aWEuYbfec2Fz7NkYFVq?=
 =?us-ascii?Q?6ItUd2SBZ1+QK85sNFodTdTs3j1yV6Gf/G13XGh4a0LEOgoXqH9Fcv593TIv?=
 =?us-ascii?Q?QX68vFzauiq8pq7n+Yc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:54.3028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9448c8-40a3-4a67-21a5-08de07d38e93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438

Add a safe wrapper for `pci_find_ext_capability()` that returns an
`Option<u16>` indicating the offset of a given PCIe extended capability.

This allows Rust drivers to query extended capabilities without dealing
with raw pointers or integer return codes. The method returns `None`
when the capability is not present.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 2f94b370fc99..5d9c5eef5c85 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -477,6 +477,13 @@ pub fn cfg_size(&self) -> i32 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).cfg_size }
     }
+
+    /// Find the extended capability
+    pub fn find_ext_capability(&self, cap: i32) -> Option<u16> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let offset = unsafe { bindings::pci_find_ext_capability(self.as_raw(), cap) };
+        (offset != 0).then(|| offset as u16)
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.47.3


