Return-Path: <linux-pci+bounces-34148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D2B2964A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 03:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8E81966FDB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024023817E;
	Mon, 18 Aug 2025 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+2k/gVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F469238C33;
	Mon, 18 Aug 2025 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480801; cv=fail; b=JTu57rFCk9680J2lojtcSGIVNEsy3EZymYnpNLC6oogKKHNMnHgYiPbdQKdlM8YZkHgsbnuLUravpSJO9xv8P3Nk6yZJ9FWhk1yKLT4Fb6XvtBKR5bYzx+MzXQtK/vyvIXfOnQP1kQO7l41uESNRf58TvqBettAKyjePg9FfWUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480801; c=relaxed/simple;
	bh=W5fO6L3lnEoXzOMeW+5iDjKRrhqeTLOJISW4WKBqQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWglPGPL4673c/+NrSFcn3K8uBK9Eyz8V2iewevtWuueJ2ub1oh417pNty9cIG/nJBy745DUfgC6y+p4IvoDFiDUEK6w7W3jfR2PU+9pEEmyegLPW3DEnOLX9EuCizjOP2rAeU103b2Yakx314V8mevD7c1Qj6ObDeu8H3v365U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+2k/gVn; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOahzsVr4xORFoRNClafJmqBX2uLLuRAy/LpXkyjLbNSzAX98FshtUJ0Y+y30afcs6mb/xHIZnwr49JPS0olfUG3Oj28fL49AQfozskLQBnPXZQGr0sZxgdygQr4Zpbc6UoNmge93OIWPqCYwZhO3LMSenHJKfU5xb76iu+fmjpdmOtzNEuxC/AkYZYsJi05R7B+XYsBNMIDmP9f+PdsczW/LJjNMHVNg9y48FV7VBsXyI7SpFDeeO8iVKoZvSCnPxhWzPOYf+dBBlxaNdEi6y8fB/fMp+Y6ioU0ojeObvvVxdC5Y1RwYFTvfqhy3YkDOF5cK7caiiXIA1Nqalufsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54QdR6ci/jYxEVkaqmPNg9Ht+VbLaUTMC+4T51qbBcI=;
 b=eBkk7qcVzPzJOUXrppXPnWSwhzdCJNrQi+9UUA5FM64lxcM7h7V5H8FWFijmOTNgzTiDZDzGfGH6EWgdcfEpa1me8ccaUEqhohXTr4ztpeubmAfCEgCoG9E9xBZJRe0kvSWmPEGrffZuMg7mxSApYIKGb2j5AQRJwihpL7XeBNFTig57Zx8VA3kPZeLQ+lV4NGKNm5ypWf3qNVSKDZuHdIWCnDG2llGDfQHKy/RXSfjpY8uggkcesgVJcUFE1pXCzvcjaIyJNwXkVIQUetcsfZVwX/XMSCQaA4bmE/N3VS3QDQ4f0nZvcftBMJSUYXZizWSxE4/qwg+Qm0GbfOJVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54QdR6ci/jYxEVkaqmPNg9Ht+VbLaUTMC+4T51qbBcI=;
 b=a+2k/gVnhIKDnCwupV98dWg0Jk1/nXLv6VsTdgGxADYknQCg2QMqfYS+KlECNXWMUhxMIEPQrLzWm+9p0AKG3ZxAegFywZihHVxHCMAveyd8t4bbPEe93ulOXSGO7SDgsDt0gjiw6UWkPB90kpc4srVCW5fHqMNvbRJbZbhWk70xvC+Efv9YqRO2KZa8A6s+KCAx47iLtyYi8BuBg26kxshmSKZLmnNOcSKY0YFoocL0QNTKgDpmw4dvFJOXtLchk0N70DJoGVHb9Mog+yYcchuViFiF3bP1J655Xfu0yfamZDymZ+qrWMD7UzcWG4gvXcQQNxt39vWhkY8/w1pxyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 01:33:14 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 01:33:14 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/3] rust: pci: provide access to PCI Vendor values
Date: Sun, 17 Aug 2025 18:33:05 -0700
Message-ID: <20250818013305.1089446-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818013305.1089446-1-jhubbard@nvidia.com>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 93858a68-36fe-4b75-b339-08ddddf732df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L++zLUTYzmIR2WbpPIjg8Rm2/wMoVi6kcg71IYmexuqThRqWY3gg6UZVJs8t?=
 =?us-ascii?Q?F2+wh4/l44yWxwd5nUg+arvc/fUSJXSVweKdavlY+t697pC47SwwdkvB3HBP?=
 =?us-ascii?Q?xc53PssjzZiRX5c46a/mP+fPoYfG5cXotK5xFcr4g8m+HsomnPSwhho5njvl?=
 =?us-ascii?Q?9nAOLsC3ZOskauChN65XCpXNlGMLBKkNTmpLf4CH56tUI1tQPeQY5VJnysjy?=
 =?us-ascii?Q?33umoUjnRkVAX3DHFcj1fGUOd0Dez+JdmZhmQQeD3DW1V1ri4b7yyh/CVX7f?=
 =?us-ascii?Q?l1wKxkMhtyK6fRJFahD/TyIlD7OoR/3z9tS/6TM3Zbv1ki+YDa/0OUU6Ewao?=
 =?us-ascii?Q?PPutx2S9tlo3SCz/KP1o4CEkbl0H9KGLzIGHGYYUwJiKtbLloFdePJrjTaDB?=
 =?us-ascii?Q?lFLhB5yp1zXNYjkNGwglIDbSqHh20L00JAO/I91MaCHx5hrJQKbyAhjKn1Pm?=
 =?us-ascii?Q?YDEUgTuvmjA+XRYBeof//5m7dgyL7srOxnHpLvRYl6WysRd0Cmlkpg2J5ntH?=
 =?us-ascii?Q?3npR6usj1+wznXkC9+9vp84kF5ZW+auozuWG2vWwptIpq0OSTFHkA4BIduc7?=
 =?us-ascii?Q?D6JPYdscRzOfrwoDYD0OBdep3QqOKcG47CyMCkkxv0/znx2HFqTrXvAp3wSp?=
 =?us-ascii?Q?DEx0FdHCRFzL+vcel2b7MhaIEMeGJbcz1wIDgnGC39vlrM/hoaalMTwNb54q?=
 =?us-ascii?Q?z+7588YUp9Xgkg+NhByq5GY81afWww6KO/OKff2CA+5QRpujGpNSSdWuQti/?=
 =?us-ascii?Q?PGjffJVF8TC/YoQTu5suKdqVDXFFYKHS8MCmM81g79CgHeyxa1EkESUHZtGK?=
 =?us-ascii?Q?RoIDTefeAZIC2fH75FKPnRn7whRICo9lIIh+Ldi62byJWbBaC5DPdRBGyAi0?=
 =?us-ascii?Q?Z646Aa2BuWt1AR0MG+QFoQRjDrAA/VrN+EaPHQdTbd3TitNW1QaUNB0ggUT1?=
 =?us-ascii?Q?+pL+2mIej5ZwHoUXSLfSy2EtB6oAMlcVI00p7XTifh+VqGpLcI4i0IlI/EE8?=
 =?us-ascii?Q?sb1PjChDbOCywelPKJaXzQrZI4R1eXaESzBUomdaAygcLnBsoyx6tkk1PB6F?=
 =?us-ascii?Q?zR2Sd+KbVFOb9HXcwbbK2hL0hu9c1kAfUelNOy0eRg5zFgqdyOC4OV0aZiHC?=
 =?us-ascii?Q?kVqg23+zumfTNWGfwssNxaSAeVzuFXi+F9jrggkJWdApBE+alUUscs4gM4yc?=
 =?us-ascii?Q?NcSz0q6Gf2WV62F4Npbf29VXXe1q8KXs0lFoLIxo00vy7TlUc6WbMxMsEbeB?=
 =?us-ascii?Q?+vjSDnCeNUyKX7y5x8dLIvXc78BRnPQmA3qa2wgr/KWhQnD/DNsba8ihidiy?=
 =?us-ascii?Q?mO1V0aOcC6m54/aA21OQWwOl+K5EKHxvWNzUkQqgNdkUe24F58GYJWRWUNRM?=
 =?us-ascii?Q?Fy4gNx0X6w1rJHsrW9lOk0M29KQ89vo3uRTB1oxiBSWJIcdfsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5apS02MJ6LPrlBVj+GsNcXYchUA9H5vAPrBpGtSaJtYS7JbzHrWYCZzZYzQ?=
 =?us-ascii?Q?cPdDbbcXq2/qFN9k9agjaMxSJyrf9V4sUTUUgBOKZj4y53nEhb65J/2ofYWm?=
 =?us-ascii?Q?uBiCRTSTIe47xHifE1PRdySLNurDA4WDZQQNyxc5Q73FXTaL2GKhQu8iXlwc?=
 =?us-ascii?Q?K75KVD90aweXolbjc2ADnl9iDW6mVUqL5mGHc+ILbRQUiiv+oetJcj9JQurx?=
 =?us-ascii?Q?WLYfYYZY8UR1zEUeKvcFryn7qdlNT5EUf6fqFVgQrw0gWVXugqwZ6NHcPbqo?=
 =?us-ascii?Q?NNKbn0S30GBKS/ttpnVfOPKVyBtybgdldtkSSpuOQFhilqkSRm0pwr2jivbG?=
 =?us-ascii?Q?p0BamxM5SFQZnMBEhfvgKgeGRtu+DknBaM6JqF6fjZuy0sL5ku+/N9xhL2Lm?=
 =?us-ascii?Q?JWNCqZlZeW5IHwpVUryEAlT4WdY/pXxmPv+apFP/rxESQ7ZENR3s9Uvb2vBk?=
 =?us-ascii?Q?TF5ObJ4dK1ifHuXiv2hecHCf3Mruu1IPVUL+3/+r0uG+ymdyor2CaAqGuocF?=
 =?us-ascii?Q?i7g7mFRFwz6C1G9I4DcsmC26IN21BBuzOPhznc2JAPctrdx790zxk67r9ArF?=
 =?us-ascii?Q?641N5s/XDVBUvq9Y4aMfMQyoaLmtxpFeSXE6Kz9RKcCmy1N3zTNbzrV1KRkI?=
 =?us-ascii?Q?Ii3UTCPdJSZPjZ+inQkM3wLyUWpWzHQThpCPz7YqjPLoUi8gHw1AIit2Mbue?=
 =?us-ascii?Q?1nvEQrqeuHcXdf9cjz9ECYh4l00lUJ9To2exH05E7LDrg/bUeGbGGl1AQUfo?=
 =?us-ascii?Q?YFJGuhb+cThUuZWJ5cCnVkuTg9+vn2mdgZ1Ogxqs7OuMNdioE1LitzS0klkZ?=
 =?us-ascii?Q?K+efnJEZAvnJ4hqvvcjrFxU8EGl+WPYIii3HXnyRi+o1eZN35nMy7caK2pDF?=
 =?us-ascii?Q?ICOObhzR8J7Z+loZ0K/nUyuLktb0dC8Ly+XHTOuqL/TFBUECx2oG/hLRHmPZ?=
 =?us-ascii?Q?Uf6fnpvZjU00ENw3rk0ovYJm3H2hbUeOF+uHI5RjhwR40Lvauak+gjASiaek?=
 =?us-ascii?Q?7Yd2lHCRuDhxgT99WsFe3AiQQLL9yOY4EaqGvN3P53du5hYFO/M+Jt70Stz/?=
 =?us-ascii?Q?9FqGltWWx0sm2BBSCTgODmQZhGe0lTZmJ+as+oAqQTgBQWVC50LwBC/eb+uF?=
 =?us-ascii?Q?GiKGb52x2k0TbnjWLhQn7S7W+nhKflLJ4pR63sOoXzwdr4u+53u3ba+Dg240?=
 =?us-ascii?Q?VeSIiy84m9+n3tgT1JLLuRfXtTUGn90T7h/pZFwZ+WuKjjCmKXvRdHI3ohsk?=
 =?us-ascii?Q?EmLTPUpVyV/0RqXMHgqoN+npTyeswMDTsia9n04OoSjd8q1cQ2vMQZiOWCw1?=
 =?us-ascii?Q?12q/uldjCWHk5a4zqzf9b8XBkLGsD0Xdfjc1XZuaYrwkXL3D3It8mOKPyp5o?=
 =?us-ascii?Q?QUk5I/Pnn4OnIsUIyymbbmRV+GQMetSkpDrC54sIrtpQWbUTVdCROSkT2UC8?=
 =?us-ascii?Q?hOqObF5kPYXfFUEJ2/X/zczHYMU8/GJtfkhpt/MM0rS6mEz96Pl/uYBRoi/9?=
 =?us-ascii?Q?u4TmONIa/fxKT0GcQFXzTUQT46Exp8GcUjzKvGZh7w/7umJrRjkLHc+e7QUZ?=
 =?us-ascii?Q?+SMEWHphnXaduuXRQfzFwL26NEX+rpb9tOXI1rHu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93858a68-36fe-4b75-b339-08ddddf732df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:33:13.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVRgikdWQi853y4YTx6d+E2VlZetYseCod6ZE+fkUdcIPb1baCGJeA92gQjU66FizYXKMsEd8iFB2OOFYvAJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

This allows callers to write Vendor::SOME_COMPANY instead of
bindings::PCI_VENDOR_ID_SOME_COMPANY.

It also allows removing "use kernel::bindings" entirely from most of
the affected files here.

Apply this to the various Rust for Linux callers who were previously
using bindings::PCI_VENDOR_ID_*.

New APIs:
    Vendor::SOME_COMPANY
    Vendor::from_u32(), as_u32()
    DeviceId::from_class_and_vendor() now takes Vendor type

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |  12 +-
 rust/kernel/pci.rs                    | 327 +++++++++++++++++++++++++-
 samples/rust/rust_dma.rs              |   3 +-
 samples/rust/rust_driver_auxiliary.rs |   4 +-
 samples/rust/rust_driver_pci.rs       |   4 +-
 5 files changed, 338 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 4ec5b861a345..d0272289f863 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
+    auxiliary, c_str,
+    device::Core,
+    pci,
+    pci::{Class, Vendor},
+    prelude::*,
+    sizes::SZ_16M,
+    sync::Arc,
 };
 
 use crate::gpu::Gpu;
@@ -26,7 +32,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_VGA,
                 Class::MASK_CLASS_SUBCLASS,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
@@ -34,7 +40,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_3D,
                 Class::MASK_CLASS_SUBCLASS,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9caa1d342d52..7a42b91ad873 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -196,6 +196,327 @@ pub const fn as_u32(self) -> u32 {
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
 }
 
+macro_rules! define_all_pci_vendors {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+        /// PCI vendor IDs.
+        ///
+        /// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
+        /// These IDs uniquely identify the manufacturer of a PCI device.
+        /// All values are derived from kernel constants.
+        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+        #[repr(transparent)]
+        pub struct Vendor(u32);
+
+        impl Vendor {
+            // Associated constants derived from kernel bindings
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self($binding);
+            )+
+
+            /// Create a `Vendor` from the raw vendor ID value, or `None` if the value doesn't
+            /// match any known vendor.
+            pub fn from_u32(value: u32) -> Option<Self> {
+                match value {
+                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
+                    _ => None,
+                }
+            }
+
+            /// Get the raw 16-bit vendor ID value.
+            pub const fn as_u32(self) -> u32 {
+                self.0
+            }
+        }
+    };
+}
+
+define_all_pci_vendors! {
+    PCI_SIG                  = bindings::PCI_VENDOR_ID_PCI_SIG,                  // 0x0001
+    LOONGSON                 = bindings::PCI_VENDOR_ID_LOONGSON,                 // 0x0014
+    SOLIDIGM                 = bindings::PCI_VENDOR_ID_SOLIDIGM,                 // 0x025e
+    TTTECH                   = bindings::PCI_VENDOR_ID_TTTECH,                   // 0x0357
+    DYNALINK                 = bindings::PCI_VENDOR_ID_DYNALINK,                 // 0x0675
+    UBIQUITI                 = bindings::PCI_VENDOR_ID_UBIQUITI,                 // 0x0777
+    BERKOM                   = bindings::PCI_VENDOR_ID_BERKOM,                   // 0x0871
+    ITTIM                    = bindings::PCI_VENDOR_ID_ITTIM,                    // 0x0b48
+    COMPAQ                   = bindings::PCI_VENDOR_ID_COMPAQ,                   // 0x0e11
+    LSI_LOGIC                = bindings::PCI_VENDOR_ID_LSI_LOGIC,                // 0x1000
+    ATI                      = bindings::PCI_VENDOR_ID_ATI,                      // 0x1002
+    VLSI                     = bindings::PCI_VENDOR_ID_VLSI,                     // 0x1004
+    ADL                      = bindings::PCI_VENDOR_ID_ADL,                      // 0x1005
+    NS                       = bindings::PCI_VENDOR_ID_NS,                       // 0x100b
+    TSENG                    = bindings::PCI_VENDOR_ID_TSENG,                    // 0x100c
+    WEITEK                   = bindings::PCI_VENDOR_ID_WEITEK,                   // 0x100e
+    DEC                      = bindings::PCI_VENDOR_ID_DEC,                      // 0x1011
+    CIRRUS                   = bindings::PCI_VENDOR_ID_CIRRUS,                   // 0x1013
+    IBM                      = bindings::PCI_VENDOR_ID_IBM,                      // 0x1014
+    UNISYS                   = bindings::PCI_VENDOR_ID_UNISYS,                   // 0x1018
+    COMPEX2                  = bindings::PCI_VENDOR_ID_COMPEX2,                  // 0x101a
+    WD                       = bindings::PCI_VENDOR_ID_WD,                       // 0x101c
+    AMI                      = bindings::PCI_VENDOR_ID_AMI,                      // 0x101e
+    AMD                      = bindings::PCI_VENDOR_ID_AMD,                      // 0x1022
+    TRIDENT                  = bindings::PCI_VENDOR_ID_TRIDENT,                  // 0x1023
+    AI                       = bindings::PCI_VENDOR_ID_AI,                       // 0x1025
+    DELL                     = bindings::PCI_VENDOR_ID_DELL,                     // 0x1028
+    MATROX                   = bindings::PCI_VENDOR_ID_MATROX,                   // 0x102B
+    MOBILITY_ELECTRONICS     = bindings::PCI_VENDOR_ID_MOBILITY_ELECTRONICS,     // 0x14f2
+    CT                       = bindings::PCI_VENDOR_ID_CT,                       // 0x102c
+    MIRO                     = bindings::PCI_VENDOR_ID_MIRO,                     // 0x1031
+    NEC                      = bindings::PCI_VENDOR_ID_NEC,                      // 0x1033
+    FD                       = bindings::PCI_VENDOR_ID_FD,                       // 0x1036
+    SI                       = bindings::PCI_VENDOR_ID_SI,                       // 0x1039
+    HP                       = bindings::PCI_VENDOR_ID_HP,                       // 0x103c
+    HP_3PAR                  = bindings::PCI_VENDOR_ID_HP_3PAR,                  // 0x1590
+    PCTECH                   = bindings::PCI_VENDOR_ID_PCTECH,                   // 0x1042
+    ASUSTEK                  = bindings::PCI_VENDOR_ID_ASUSTEK,                  // 0x1043
+    DPT                      = bindings::PCI_VENDOR_ID_DPT,                      // 0x1044
+    OPTI                     = bindings::PCI_VENDOR_ID_OPTI,                     // 0x1045
+    ELSA                     = bindings::PCI_VENDOR_ID_ELSA,                     // 0x1048
+    STMICRO                  = bindings::PCI_VENDOR_ID_STMICRO,                  // 0x104A
+    BUSLOGIC                 = bindings::PCI_VENDOR_ID_BUSLOGIC,                 // 0x104B
+    TI                       = bindings::PCI_VENDOR_ID_TI,                       // 0x104c
+    SONY                     = bindings::PCI_VENDOR_ID_SONY,                     // 0x104d
+    WINBOND2                 = bindings::PCI_VENDOR_ID_WINBOND2,                 // 0x1050
+    ANIGMA                   = bindings::PCI_VENDOR_ID_ANIGMA,                   // 0x1051
+    EFAR                     = bindings::PCI_VENDOR_ID_EFAR,                     // 0x1055
+    MOTOROLA                 = bindings::PCI_VENDOR_ID_MOTOROLA,                 // 0x1057
+    PROMISE                  = bindings::PCI_VENDOR_ID_PROMISE,                  // 0x105a
+    FOXCONN                  = bindings::PCI_VENDOR_ID_FOXCONN,                  // 0x105b
+    UMC                      = bindings::PCI_VENDOR_ID_UMC,                      // 0x1060
+    PICOPOWER                = bindings::PCI_VENDOR_ID_PICOPOWER,                // 0x1066
+    MYLEX                    = bindings::PCI_VENDOR_ID_MYLEX,                    // 0x1069
+    APPLE                    = bindings::PCI_VENDOR_ID_APPLE,                    // 0x106b
+    YAMAHA                   = bindings::PCI_VENDOR_ID_YAMAHA,                   // 0x1073
+    QLOGIC                   = bindings::PCI_VENDOR_ID_QLOGIC,                   // 0x1077
+    CYRIX                    = bindings::PCI_VENDOR_ID_CYRIX,                    // 0x1078
+    CONTAQ                   = bindings::PCI_VENDOR_ID_CONTAQ,                   // 0x1080
+    OLICOM                   = bindings::PCI_VENDOR_ID_OLICOM,                   // 0x108d
+    SUN                      = bindings::PCI_VENDOR_ID_SUN,                      // 0x108e
+    NI                       = bindings::PCI_VENDOR_ID_NI,                       // 0x1093
+    CMD                      = bindings::PCI_VENDOR_ID_CMD,                      // 0x1095
+    BROOKTREE                = bindings::PCI_VENDOR_ID_BROOKTREE,                // 0x109e
+    SGI                      = bindings::PCI_VENDOR_ID_SGI,                      // 0x10a9
+    WINBOND                  = bindings::PCI_VENDOR_ID_WINBOND,                  // 0x10ad
+    PLX                      = bindings::PCI_VENDOR_ID_PLX,                      // 0x10b5
+    MADGE                    = bindings::PCI_VENDOR_ID_MADGE,                    // 0x10b6
+    THREECOM                 = bindings::PCI_VENDOR_ID_3COM,                     // 0x10b7
+    AL                       = bindings::PCI_VENDOR_ID_AL,                       // 0x10b9
+    NEOMAGIC                 = bindings::PCI_VENDOR_ID_NEOMAGIC,                 // 0x10c8
+    TCONRAD                  = bindings::PCI_VENDOR_ID_TCONRAD,                  // 0x10da
+    ROHM                     = bindings::PCI_VENDOR_ID_ROHM,                     // 0x10db
+    NVIDIA                   = bindings::PCI_VENDOR_ID_NVIDIA,                   // 0x10de
+    IMS                      = bindings::PCI_VENDOR_ID_IMS,                      // 0x10e0
+    AMCC                     = bindings::PCI_VENDOR_ID_AMCC,                     // 0x10e8
+    AMPERE                   = bindings::PCI_VENDOR_ID_AMPERE,                   // 0x1def
+    INTERG                   = bindings::PCI_VENDOR_ID_INTERG,                   // 0x10ea
+    REALTEK                  = bindings::PCI_VENDOR_ID_REALTEK,                  // 0x10ec
+    XILINX                   = bindings::PCI_VENDOR_ID_XILINX,                   // 0x10ee
+    INIT                     = bindings::PCI_VENDOR_ID_INIT,                     // 0x1101
+    CREATIVE                 = bindings::PCI_VENDOR_ID_CREATIVE,                 // 0x1102
+    TTI                      = bindings::PCI_VENDOR_ID_TTI,                      // 0x1103
+    SIGMA                    = bindings::PCI_VENDOR_ID_SIGMA,                    // 0x1105
+    VIA                      = bindings::PCI_VENDOR_ID_VIA,                      // 0x1106
+    SIEMENS                  = bindings::PCI_VENDOR_ID_SIEMENS,                  // 0x110A
+    VORTEX                   = bindings::PCI_VENDOR_ID_VORTEX,                   // 0x1119
+    EF                       = bindings::PCI_VENDOR_ID_EF,                       // 0x111a
+    IDT                      = bindings::PCI_VENDOR_ID_IDT,                      // 0x111d
+    FORE                     = bindings::PCI_VENDOR_ID_FORE,                     // 0x1127
+    PHILIPS                  = bindings::PCI_VENDOR_ID_PHILIPS,                  // 0x1131
+    EICON                    = bindings::PCI_VENDOR_ID_EICON,                    // 0x1133
+    CISCO                    = bindings::PCI_VENDOR_ID_CISCO,                    // 0x1137
+    ZIATECH                  = bindings::PCI_VENDOR_ID_ZIATECH,                  // 0x1138
+    SYSKONNECT               = bindings::PCI_VENDOR_ID_SYSKONNECT,               // 0x1148
+    DIGI                     = bindings::PCI_VENDOR_ID_DIGI,                     // 0x114f
+    XIRCOM                   = bindings::PCI_VENDOR_ID_XIRCOM,                   // 0x115d
+    SERVERWORKS              = bindings::PCI_VENDOR_ID_SERVERWORKS,              // 0x1166
+    ALTERA                   = bindings::PCI_VENDOR_ID_ALTERA,                   // 0x1172
+    SBE                      = bindings::PCI_VENDOR_ID_SBE,                      // 0x1176
+    TOSHIBA                  = bindings::PCI_VENDOR_ID_TOSHIBA,                  // 0x1179
+    TOSHIBA_2                = bindings::PCI_VENDOR_ID_TOSHIBA_2,                // 0x102f
+    ATTO                     = bindings::PCI_VENDOR_ID_ATTO,                     // 0x117c
+    RICOH                    = bindings::PCI_VENDOR_ID_RICOH,                    // 0x1180
+    DLINK                    = bindings::PCI_VENDOR_ID_DLINK,                    // 0x1186
+    ARTOP                    = bindings::PCI_VENDOR_ID_ARTOP,                    // 0x1191
+    ZEITNET                  = bindings::PCI_VENDOR_ID_ZEITNET,                  // 0x1193
+    FUJITSU_ME               = bindings::PCI_VENDOR_ID_FUJITSU_ME,               // 0x119e
+    MARVELL                  = bindings::PCI_VENDOR_ID_MARVELL,                  // 0x11ab
+    MARVELL_EXT              = bindings::PCI_VENDOR_ID_MARVELL_EXT,              // 0x1b4b
+    V3                       = bindings::PCI_VENDOR_ID_V3,                       // 0x11b0
+    ATT                      = bindings::PCI_VENDOR_ID_ATT,                      // 0x11c1
+    SPECIALIX                = bindings::PCI_VENDOR_ID_SPECIALIX,                // 0x11cb
+    ANALOG_DEVICES           = bindings::PCI_VENDOR_ID_ANALOG_DEVICES,           // 0x11d4
+    ZORAN                    = bindings::PCI_VENDOR_ID_ZORAN,                    // 0x11de
+    COMPEX                   = bindings::PCI_VENDOR_ID_COMPEX,                   // 0x11f6
+    MICROSEMI                = bindings::PCI_VENDOR_ID_MICROSEMI,                // 0x11f8
+    RP                       = bindings::PCI_VENDOR_ID_RP,                       // 0x11fe
+    CYCLADES                 = bindings::PCI_VENDOR_ID_CYCLADES,                 // 0x120e
+    ESSENTIAL                = bindings::PCI_VENDOR_ID_ESSENTIAL,                // 0x120f
+    O2                       = bindings::PCI_VENDOR_ID_O2,                       // 0x1217
+    THREEDX                  = bindings::PCI_VENDOR_ID_3DFX,                     // 0x121a
+    AVM                      = bindings::PCI_VENDOR_ID_AVM,                      // 0x1244
+    STALLION                 = bindings::PCI_VENDOR_ID_STALLION,                 // 0x124d
+    AT                       = bindings::PCI_VENDOR_ID_AT,                       // 0x1259
+    ASIX                     = bindings::PCI_VENDOR_ID_ASIX,                     // 0x125b
+    ESS                      = bindings::PCI_VENDOR_ID_ESS,                      // 0x125d
+    SATSAGEM                 = bindings::PCI_VENDOR_ID_SATSAGEM,                 // 0x1267
+    ENSONIQ                  = bindings::PCI_VENDOR_ID_ENSONIQ,                  // 0x1274
+    TRANSMETA                = bindings::PCI_VENDOR_ID_TRANSMETA,                // 0x1279
+    ROCKWELL                 = bindings::PCI_VENDOR_ID_ROCKWELL,                 // 0x127A
+    ITE                      = bindings::PCI_VENDOR_ID_ITE,                      // 0x1283
+    ALTEON                   = bindings::PCI_VENDOR_ID_ALTEON,                   // 0x12ae
+    NVIDIA_SGS               = bindings::PCI_VENDOR_ID_NVIDIA_SGS,               // 0x12d2
+    PERICOM                  = bindings::PCI_VENDOR_ID_PERICOM,                  // 0x12D8
+    AUREAL                   = bindings::PCI_VENDOR_ID_AUREAL,                   // 0x12eb
+    ELECTRONICDESIGNGMBH     = bindings::PCI_VENDOR_ID_ELECTRONICDESIGNGMBH,     // 0x12f8
+    ESDGMBH                  = bindings::PCI_VENDOR_ID_ESDGMBH,                  // 0x12fe
+    CB                       = bindings::PCI_VENDOR_ID_CB,                       // 0x1307
+    SIIG                     = bindings::PCI_VENDOR_ID_SIIG,                     // 0x131f
+    RADISYS                  = bindings::PCI_VENDOR_ID_RADISYS,                  // 0x1331
+    MICRO_MEMORY             = bindings::PCI_VENDOR_ID_MICRO_MEMORY,             // 0x1332
+    DOMEX                    = bindings::PCI_VENDOR_ID_DOMEX,                    // 0x134a
+    INTASHIELD               = bindings::PCI_VENDOR_ID_INTASHIELD,               // 0x135a
+    QUATECH                  = bindings::PCI_VENDOR_ID_QUATECH,                  // 0x135C
+    SEALEVEL                 = bindings::PCI_VENDOR_ID_SEALEVEL,                 // 0x135e
+    HYPERCOPE                = bindings::PCI_VENDOR_ID_HYPERCOPE,                // 0x1365
+    DIGIGRAM                 = bindings::PCI_VENDOR_ID_DIGIGRAM,                 // 0x1369
+    KAWASAKI                 = bindings::PCI_VENDOR_ID_KAWASAKI,                 // 0x136b
+    CNET                     = bindings::PCI_VENDOR_ID_CNET,                     // 0x1371
+    LMC                      = bindings::PCI_VENDOR_ID_LMC,                      // 0x1376
+    NETGEAR                  = bindings::PCI_VENDOR_ID_NETGEAR,                  // 0x1385
+    APPLICOM                 = bindings::PCI_VENDOR_ID_APPLICOM,                 // 0x1389
+    MOXA                     = bindings::PCI_VENDOR_ID_MOXA,                     // 0x1393
+    CCD                      = bindings::PCI_VENDOR_ID_CCD,                      // 0x1397
+    EXAR                     = bindings::PCI_VENDOR_ID_EXAR,                     // 0x13a8
+    MICROGATE                = bindings::PCI_VENDOR_ID_MICROGATE,                // 0x13c0
+    THREEWARE                = bindings::PCI_VENDOR_ID_3WARE,                    // 0x13C1
+    IOMEGA                   = bindings::PCI_VENDOR_ID_IOMEGA,                   // 0x13ca
+    ABOCOM                   = bindings::PCI_VENDOR_ID_ABOCOM,                   // 0x13D1
+    SUNDANCE                 = bindings::PCI_VENDOR_ID_SUNDANCE,                 // 0x13f0
+    CMEDIA                   = bindings::PCI_VENDOR_ID_CMEDIA,                   // 0x13f6
+    ADVANTECH                = bindings::PCI_VENDOR_ID_ADVANTECH,                // 0x13fe
+    MEILHAUS                 = bindings::PCI_VENDOR_ID_MEILHAUS,                 // 0x1402
+    LAVA                     = bindings::PCI_VENDOR_ID_LAVA,                     // 0x1407
+    TIMEDIA                  = bindings::PCI_VENDOR_ID_TIMEDIA,                  // 0x1409
+    ICE                      = bindings::PCI_VENDOR_ID_ICE,                      // 0x1412
+    MICROSOFT                = bindings::PCI_VENDOR_ID_MICROSOFT,                // 0x1414
+    OXSEMI                   = bindings::PCI_VENDOR_ID_OXSEMI,                   // 0x1415
+    CHELSIO                  = bindings::PCI_VENDOR_ID_CHELSIO,                  // 0x1425
+    EDIMAX                   = bindings::PCI_VENDOR_ID_EDIMAX,                   // 0x1432
+    ADLINK                   = bindings::PCI_VENDOR_ID_ADLINK,                   // 0x144a
+    SAMSUNG                  = bindings::PCI_VENDOR_ID_SAMSUNG,                  // 0x144d
+    GIGABYTE                 = bindings::PCI_VENDOR_ID_GIGABYTE,                 // 0x1458
+    AMBIT                    = bindings::PCI_VENDOR_ID_AMBIT,                    // 0x1468
+    MYRICOM                  = bindings::PCI_VENDOR_ID_MYRICOM,                  // 0x14c1
+    MEDIATEK                 = bindings::PCI_VENDOR_ID_MEDIATEK,                 // 0x14c3
+    TITAN                    = bindings::PCI_VENDOR_ID_TITAN,                    // 0x14D2
+    PANACOM                  = bindings::PCI_VENDOR_ID_PANACOM,                  // 0x14d4
+    SIPACKETS                = bindings::PCI_VENDOR_ID_SIPACKETS,                // 0x14d9
+    AFAVLAB                  = bindings::PCI_VENDOR_ID_AFAVLAB,                  // 0x14db
+    AMPLICON                 = bindings::PCI_VENDOR_ID_AMPLICON,                 // 0x14dc
+    BCM_GVC                  = bindings::PCI_VENDOR_ID_BCM_GVC,                  // 0x14a4
+    BROADCOM                 = bindings::PCI_VENDOR_ID_BROADCOM,                 // 0x14e4
+    TOPIC                    = bindings::PCI_VENDOR_ID_TOPIC,                    // 0x151f
+    MAINPINE                 = bindings::PCI_VENDOR_ID_MAINPINE,                 // 0x1522
+    ENE                      = bindings::PCI_VENDOR_ID_ENE,                      // 0x1524
+    SYBA                     = bindings::PCI_VENDOR_ID_SYBA,                     // 0x1592
+    MORETON                  = bindings::PCI_VENDOR_ID_MORETON,                  // 0x15aa
+    VMWARE                   = bindings::PCI_VENDOR_ID_VMWARE,                   // 0x15ad
+    ZOLTRIX                  = bindings::PCI_VENDOR_ID_ZOLTRIX,                  // 0x15b0
+    MELLANOX                 = bindings::PCI_VENDOR_ID_MELLANOX,                 // 0x15b3
+    DFI                      = bindings::PCI_VENDOR_ID_DFI,                      // 0x15bd
+    QUICKNET                 = bindings::PCI_VENDOR_ID_QUICKNET,                 // 0x15e2
+    ADDIDATA                 = bindings::PCI_VENDOR_ID_ADDIDATA,                 // 0x15B8
+    PDC                      = bindings::PCI_VENDOR_ID_PDC,                      // 0x15e9
+    FARSITE                  = bindings::PCI_VENDOR_ID_FARSITE,                  // 0x1619
+    ARIMA                    = bindings::PCI_VENDOR_ID_ARIMA,                    // 0x161f
+    BROCADE                  = bindings::PCI_VENDOR_ID_BROCADE,                  // 0x1657
+    SIBYTE                   = bindings::PCI_VENDOR_ID_SIBYTE,                   // 0x166d
+    ATHEROS                  = bindings::PCI_VENDOR_ID_ATHEROS,                  // 0x168c
+    NETCELL                  = bindings::PCI_VENDOR_ID_NETCELL,                  // 0x169c
+    CENATEK                  = bindings::PCI_VENDOR_ID_CENATEK,                  // 0x16CA
+    SYNOPSYS                 = bindings::PCI_VENDOR_ID_SYNOPSYS,                 // 0x16c3
+    USR                      = bindings::PCI_VENDOR_ID_USR,                      // 0x16ec
+    VITESSE                  = bindings::PCI_VENDOR_ID_VITESSE,                  // 0x1725
+    LINKSYS                  = bindings::PCI_VENDOR_ID_LINKSYS,                  // 0x1737
+    ALTIMA                   = bindings::PCI_VENDOR_ID_ALTIMA,                   // 0x173b
+    CAVIUM                   = bindings::PCI_VENDOR_ID_CAVIUM,                   // 0x177d
+    TECHWELL                 = bindings::PCI_VENDOR_ID_TECHWELL,                 // 0x1797
+    BELKIN                   = bindings::PCI_VENDOR_ID_BELKIN,                   // 0x1799
+    RDC                      = bindings::PCI_VENDOR_ID_RDC,                      // 0x17f3
+    GLI                      = bindings::PCI_VENDOR_ID_GLI,                      // 0x17a0
+    LENOVO                   = bindings::PCI_VENDOR_ID_LENOVO,                   // 0x17aa
+    QCOM                     = bindings::PCI_VENDOR_ID_QCOM,                     // 0x17cb
+    CDNS                     = bindings::PCI_VENDOR_ID_CDNS,                     // 0x17cd
+    ARECA                    = bindings::PCI_VENDOR_ID_ARECA,                    // 0x17d3
+    S2IO                     = bindings::PCI_VENDOR_ID_S2IO,                     // 0x17d5
+    SITECOM                  = bindings::PCI_VENDOR_ID_SITECOM,                  // 0x182d
+    TOPSPIN                  = bindings::PCI_VENDOR_ID_TOPSPIN,                  // 0x1867
+    COMMTECH                 = bindings::PCI_VENDOR_ID_COMMTECH,                 // 0x18f7
+    SILAN                    = bindings::PCI_VENDOR_ID_SILAN,                    // 0x1904
+    RENESAS                  = bindings::PCI_VENDOR_ID_RENESAS,                  // 0x1912
+    SOLARFLARE               = bindings::PCI_VENDOR_ID_SOLARFLARE,               // 0x1924
+    TDI                      = bindings::PCI_VENDOR_ID_TDI,                      // 0x192E
+    NXP                      = bindings::PCI_VENDOR_ID_NXP,                      // 0x1957
+    PASEMI                   = bindings::PCI_VENDOR_ID_PASEMI,                   // 0x1959
+    ATTANSIC                 = bindings::PCI_VENDOR_ID_ATTANSIC,                 // 0x1969
+    JMICRON                  = bindings::PCI_VENDOR_ID_JMICRON,                  // 0x197B
+    KORENIX                  = bindings::PCI_VENDOR_ID_KORENIX,                  // 0x1982
+    HUAWEI                   = bindings::PCI_VENDOR_ID_HUAWEI,                   // 0x19e5
+    NETRONOME                = bindings::PCI_VENDOR_ID_NETRONOME,                // 0x19ee
+    QMI                      = bindings::PCI_VENDOR_ID_QMI,                      // 0x1a32
+    AZWAVE                   = bindings::PCI_VENDOR_ID_AZWAVE,                   // 0x1a3b
+    REDHAT_QUMRANET          = bindings::PCI_VENDOR_ID_REDHAT_QUMRANET,          // 0x1af4
+    ASMEDIA                  = bindings::PCI_VENDOR_ID_ASMEDIA,                  // 0x1b21
+    REDHAT                   = bindings::PCI_VENDOR_ID_REDHAT,                   // 0x1b36
+    WCHIC                    = bindings::PCI_VENDOR_ID_WCHIC,                    // 0x1c00
+    SILICOM_DENMARK          = bindings::PCI_VENDOR_ID_SILICOM_DENMARK,          // 0x1c2c
+    AMAZON_ANNAPURNA_LABS    = bindings::PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS,    // 0x1c36
+    CIRCUITCO                = bindings::PCI_VENDOR_ID_CIRCUITCO,                // 0x1cc8
+    AMAZON                   = bindings::PCI_VENDOR_ID_AMAZON,                   // 0x1d0f
+    ZHAOXIN                  = bindings::PCI_VENDOR_ID_ZHAOXIN,                  // 0x1d17
+    ROCKCHIP                 = bindings::PCI_VENDOR_ID_ROCKCHIP,                 // 0x1d87
+    HYGON                    = bindings::PCI_VENDOR_ID_HYGON,                    // 0x1d94
+    META                     = bindings::PCI_VENDOR_ID_META,                     // 0x1d9b
+    FUNGIBLE                 = bindings::PCI_VENDOR_ID_FUNGIBLE,                 // 0x1dad
+    HXT                      = bindings::PCI_VENDOR_ID_HXT,                      // 0x1dbf
+    TEKRAM                   = bindings::PCI_VENDOR_ID_TEKRAM,                   // 0x1de1
+    RPI                      = bindings::PCI_VENDOR_ID_RPI,                      // 0x1de4
+    ALIBABA                  = bindings::PCI_VENDOR_ID_ALIBABA,                  // 0x1ded
+    CXL                      = bindings::PCI_VENDOR_ID_CXL,                      // 0x1e98
+    TEHUTI                   = bindings::PCI_VENDOR_ID_TEHUTI,                   // 0x1fc9
+    SUNIX                    = bindings::PCI_VENDOR_ID_SUNIX,                    // 0x1fd4
+    HINT                     = bindings::PCI_VENDOR_ID_HINT,                     // 0x3388
+    THREEDLABS               = bindings::PCI_VENDOR_ID_3DLABS,                   // 0x3d3d
+    NETXEN                   = bindings::PCI_VENDOR_ID_NETXEN,                   // 0x4040
+    AKS                      = bindings::PCI_VENDOR_ID_AKS,                      // 0x416c
+    WCHCN                    = bindings::PCI_VENDOR_ID_WCHCN,                    // 0x4348
+    ACCESSIO                 = bindings::PCI_VENDOR_ID_ACCESSIO,                 // 0x494f
+    S3                       = bindings::PCI_VENDOR_ID_S3,                       // 0x5333
+    DUNORD                   = bindings::PCI_VENDOR_ID_DUNORD,                   // 0x5544
+    DCI                      = bindings::PCI_VENDOR_ID_DCI,                      // 0x6666
+    GLENFLY                  = bindings::PCI_VENDOR_ID_GLENFLY,                  // 0x6766
+    INTEL                    = bindings::PCI_VENDOR_ID_INTEL,                    // 0x8086
+    WANGXUN                  = bindings::PCI_VENDOR_ID_WANGXUN,                  // 0x8088
+    SCALEMP                  = bindings::PCI_VENDOR_ID_SCALEMP,                  // 0x8686
+    COMPUTONE                = bindings::PCI_VENDOR_ID_COMPUTONE,                // 0x8e0e
+    KTI                      = bindings::PCI_VENDOR_ID_KTI,                      // 0x8e2e
+    ADAPTEC                  = bindings::PCI_VENDOR_ID_ADAPTEC,                  // 0x9004
+    ADAPTEC2                 = bindings::PCI_VENDOR_ID_ADAPTEC2,                 // 0x9005
+    HOLTEK                   = bindings::PCI_VENDOR_ID_HOLTEK,                   // 0x9412
+    NETMOS                   = bindings::PCI_VENDOR_ID_NETMOS,                   // 0x9710
+    THREECOM_2               = bindings::PCI_VENDOR_ID_3COM_2,                   // 0xa727
+    SOLIDRUN                 = bindings::PCI_VENDOR_ID_SOLIDRUN,                 // 0xd063
+    DIGIUM                   = bindings::PCI_VENDOR_ID_DIGIUM,                   // 0xd161
+    TIGERJET                 = bindings::PCI_VENDOR_ID_TIGERJET,                 // 0xe159
+    XILINX_RME               = bindings::PCI_VENDOR_ID_XILINX_RME,               // 0xea60
+    XEN                      = bindings::PCI_VENDOR_ID_XEN,                      // 0x5853
+    OCZ                      = bindings::PCI_VENDOR_ID_OCZ,                      // 0x1b85
+    NCUBE                    = bindings::PCI_VENDOR_ID_NCUBE,                    // 0x10ff
+}
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -335,9 +656,9 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
     ///
     /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
     /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
-    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
+    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: Vendor) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_u32(),
             device: DeviceId::PCI_ANY_ID,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -396,7 +717,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..520c59b930dc 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -46,7 +45,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
         ()
     )]
 );
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..d8470e4bf88b 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -51,7 +51,7 @@ struct ParentDriver {
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
         ()
     )]
 );
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..a3a7a0837961 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -38,7 +38,7 @@ struct SampleDriver {
     MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
-- 
2.50.1


