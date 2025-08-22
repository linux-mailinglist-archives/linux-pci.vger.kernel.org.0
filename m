Return-Path: <linux-pci+bounces-34508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87CB30B9E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 04:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469571BA5ECE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8379246796;
	Fri, 22 Aug 2025 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8Y17+YF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CC2356CE;
	Fri, 22 Aug 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828252; cv=fail; b=aSwvFFoOGRBFIWVafhCf2ewZPWkduejtrAGhFPukRUa29YKWqk46h03+Ghv8fkchZTRBwLOMH8sl0yEmR2ycBwgC8CHBbVfHrGpaBYP9WMpv7MvLwEqMdhK++d6laEM2JjE/Zc5DPls7Ir8Y7PLj0X4aldNl30tAdZO/7Jd09rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828252; c=relaxed/simple;
	bh=5AJeXBRDTlAoDMPi6jWxbZaK57UqYzS/zbVFqJ3zQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZDKETUc9RnoOvdB7wzo4dpfm6bvHsW1PT1fbmynuqVJi0TfuHtKsyXLrjQF7dg/pl7hBEan81YGDWtsSxhQ33xRwTZr5/9Wg/y8mT1YIYqVX6fNdBHke22DS8yFJu+xE7K1yd2QxZg9iVdBP2Mo5Oo7Ql8M+7A9vb8NFvMdaEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8Y17+YF; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCC/KFcKdfw86AS1/HVVfkJnqNl79M5r8z9PpOp8bYgSpCSZSJ8RvZ+OSEwjbM+tHO/WsPwvz6U39oCSTtl5gIKg8jomP4zWWaiJy8e65oJ0TXOSEvDb6PQ7ireRL8vUzkb2no61i4Uzsj2Kbag6U1cfcVCWfmHNayEnENvswKYK2Et7P7hOPvb0Kxgr09KLINt9iCG3vh52VM5nVdnzpGnSVJuGcjXZrfHDqIqsUHjihRlxbBpv+4gJW9ZhVLWAQJDy/FrYlCzKPfa/2ld7R4/0II1phdCuB2/9E8DbBC5UmRXDw9fFPmzH5oW+/NVeAQclzr7NKoM0IHYLkubFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwprLk1/bgQy2DkCRo6s7iZqGCW0Vu6JYpizHHK5xFk=;
 b=UJ8uwWkR+ksfatO7vcujJCBtenloIHozqKwRIoIE6VJkMFv40/nXxNxekBMeRNKhZK7ReuLUxp/tzfJChW0ZvLm1ylfJmkb2NnthGgl6SXLhLcJHcN7W/GKayuhVeI9rdjrkvGNjS93aZH+5yEm45elW/6QdC54b6SUMirNakKqUiRwQ13oIzI4K+2y5zENnM4xFC6sHyRyleTdVoL9ZZfmRQi9y4TgMvQ+wwF5q9hPN39pSNK7pELSSIsXkCAsxcPrlPnv4h0eKFVWtrpyEXi0mwygOnvJa0t/EgGslYfet3mD8y4D4N0YqnWL5+Wv4NWd8wA1C+kV8ykAZsz6qIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwprLk1/bgQy2DkCRo6s7iZqGCW0Vu6JYpizHHK5xFk=;
 b=f8Y17+YFMW22tIykZYVQxZc5qXyMzdnpJ27STKmHRT0IzjL6JN7I+WyEMfAWfsCG8xlnb55ovPeE4gMEBJ0mJVuYPNnHk4wEj2cWV+aj++F7EFf5rzlnRuX/U6sclEukvC4dv5VvB80S3pykLeNKFgzsp+96PXr2soRJakVCSnAQfsLt2ohODdJ/9Y/IGkApp+5Q5HIg2m2y2T/L5hLG0yKMdTQGo3B8vJuMcfJzGfHlfOdSh70jgqU2EQWv1TpT7Sct+FTIPzSf6dSVmLdCUWzcUo90yeUeXoOpV3c0EqjhqG4Xqf/7HJss41KDHFrwe+YleWeHUHelE8ZKQ40jqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:04:05 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:04:05 +0000
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
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v6 5/5] rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
Date: Thu, 21 Aug 2025 19:03:54 -0700
Message-ID: <20250822020354.357406-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822020354.357406-1-jhubbard@nvidia.com>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: b71fc90c-5fc9-4957-785f-08dde1202c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mqSwt8qyIJB419ek0XGhNXXwrtaG0gKhqMjVCLj9dWPvoNjNr8d32ocwLvYG?=
 =?us-ascii?Q?RKiZMoBpneHye7FU3b7b4WZ+lRQ9hAsqGio56NaOj3adI8mSVisLoaRNX13h?=
 =?us-ascii?Q?LSqoWc2wlc0FGaAal9utb2gBB5lBANg6aa6r/D8kVEZk8eMtNjBPuH038crS?=
 =?us-ascii?Q?7bmvgnPU4lc21mExUgqjQNBAK0vo2+B/GPBVym3WmLyJrOEKzYPLzxbX7B1p?=
 =?us-ascii?Q?yCK2gzqRIKnqRfusAjKxKv++zvxP/PVtmhv/fwb8kITQfMO/Fs9jsS/S1IpM?=
 =?us-ascii?Q?IluwB0/les2i944SByKLWvFnYgH1CX/+ECokHYHVbCXlB1WGhj0zj0/1juSH?=
 =?us-ascii?Q?8/gE3rYhb/RBkLv2Br3Gyzrh2wJzsEfQx3xRJZd+goLGrpncte4kequxKHxC?=
 =?us-ascii?Q?8aghB42TcmyN55Cf8WV3DxnQyT4b60N++v9ggmM/XkTN7Db2tYbtcL4/jMn5?=
 =?us-ascii?Q?WX4bPmofPZpsOOFOaIXxguplGQGhEdXz40OnHvcawZQJFNQj01Qp4EB614Rz?=
 =?us-ascii?Q?XKRkLv9hjXBA2ZhzBpo9bQghMVNsxnEkaF6i5RRhyS0+g9CGHvNinnldb1UC?=
 =?us-ascii?Q?ZTTbCgO9dco0KDUZa2DVv+WOliF5y6ZiFRS2/RBpUuI1/EXUf1LlPcDK8shL?=
 =?us-ascii?Q?MS6GlMHaTd4wDG9WxGmHlXYf6T3cE1oLZe6Cibd6dD0aC8ahnain6pkjoj9N?=
 =?us-ascii?Q?KMg1OAnLzkj8m0Xz/QJwj+vEqZg3ljeS4s9cllZS8z/tHa2s3ST/6p3NAypT?=
 =?us-ascii?Q?1Zl4ijLP6qCttt9ZQxR38x5dBvyj8eJn3zqolQY16kPYJz3ScNYIKB37sIIV?=
 =?us-ascii?Q?FceyFzkCXNu28vUl2BSUy5LdpmY6mT1kFfmDUgiApHC0GNVWdD7Gj17GYi8I?=
 =?us-ascii?Q?2u4KfVh7WiKFbp8TB10C0dBccIz0L4BYrKOyBb73huM5k12WUv49VlXnndxO?=
 =?us-ascii?Q?qjwgVcu0czirzTcCnZ8/YnOe294jpag9y+RRT46SQbADhESmgAL3RbOBxWWu?=
 =?us-ascii?Q?yowo/fsWBylZYbiKttM9bcGGnmJdF/H/+tVFb5OP8B0EMz0WJqn/2o9isXXI?=
 =?us-ascii?Q?/xUYLaSD8CM/vptPPLFX/+juN7bp/R13R8K9LCGCHm7EZzzmnxhQ1+XrpWVi?=
 =?us-ascii?Q?WD31o0wO2b2SJIArgt30ptCHzylhnavAzwa+mN3J76NIY/EsQc4Xd4dR8+Pm?=
 =?us-ascii?Q?aLnHSZ7TTvhCiYtdbO9LV1Bn4YziAVREIqpnGD19OUfS1o/V2eTJHbDo9wRX?=
 =?us-ascii?Q?EsRbECmYkr75VdGfb1eAfle63+dwoNe9bWQhbhPyjd0Vr1z7jNsWIdTBGezI?=
 =?us-ascii?Q?BQja4Ux6Fv6wvKKjmypDQTTCXlEcY77EzS23KAAyWIgMeHXQXSW9ZiJ9Dq3E?=
 =?us-ascii?Q?gm2Kx5yaP7vyBtcn9SumxqVAM3xIPjpQJ8Hvimhuvmks3XERi6qiBHl3fjg4?=
 =?us-ascii?Q?Re+x3u42Kso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZihcJsOaxBcxGqYyqn3cg8YVgZJbr9Wu4ceKxJtExyhP6ivxLjbStcO4IYc?=
 =?us-ascii?Q?Gi5lQFmhNNkD6J7XJoZxAUPvRA0vx31esIc/+sHCtgyMhr0EJx5FXMRFWDEI?=
 =?us-ascii?Q?5TzxV9VlhqEIFs1Jq3rX72UZa0oIQI4vCo3LV7dHwlPqdwkCwQ03A5910ZiH?=
 =?us-ascii?Q?uWtDEN/npcmQiLkzJQjq1wvYmmGj8U2kAA8ZRQkoFo6/GuabRiIYyuulb6sv?=
 =?us-ascii?Q?QxwUh8tAtExcyke6TU+/+kUmbKbLkExZL0DnZJx10QSto/2HGWeAC+SvFpZ3?=
 =?us-ascii?Q?oJtMpYLc8c4cm8u4aaJHNgrU6FNEVWM5RhKAUOezaLBCuoHO3J49zFVMP9pL?=
 =?us-ascii?Q?jPvG46ZEOhAtXqGFB3XuDLKe8rmxNjYggqpUIaFUkmEYK1OKBOZHludoWimy?=
 =?us-ascii?Q?ze/vy4dX+XpE6mCatc3EmpNo8YzxxHqGWLFvtRXXKiWeH+3WAzWveBm2YfOL?=
 =?us-ascii?Q?nAnCiF3nTIypjNe7teJMawENigvoF8XS9w65oiHyd16N5NfQOesHc1QxxFkY?=
 =?us-ascii?Q?FX12+bcBRIBnJBRDtIoeRyrRFf+fRMn6P0tqFB686rOL3KAj9HpAhuloMgqM?=
 =?us-ascii?Q?l3ssO5N5Cop4SgXZmdaGrEG5XgYZL08ixyiphBcGvP/KZzpjpjLlkBmPNlkn?=
 =?us-ascii?Q?/Cl9szINLRa7c5IKbzEsSmjhEfbkBGZYlXtd33LeK2ctJP1Ci2MnqabO+J3o?=
 =?us-ascii?Q?WTKy0dy0T9d93VqpkdLzLgn2lyddAFDQCHkFaohmGdomqoW9zcOQAyhSMUQr?=
 =?us-ascii?Q?7Rr31MeJdCh1KgabuY2PMjzALLhCLTe3CAU982fu0iZu1cmMdLqIl9oJbd6N?=
 =?us-ascii?Q?dopIoU6voITp0r04LYLZ6roFyp87Rgwbtq11KnhCxrvJUFmRyZhuGiKesGK+?=
 =?us-ascii?Q?fb6aierDE/aGFJ9E42g4Y/c5Wsdz93dArt8D6iiEqxKExQnLvulDNm4RLBZi?=
 =?us-ascii?Q?IUo4nBxVP/Q9lgZp0f01cRHab+W4lIZxxG+X/IkzzwScR1tNohTAzYsRNZ/A?=
 =?us-ascii?Q?drJVkDUicT5EzgjWolF9aGDxY8CnLHNnIMTq2m30LUKQeSlZUfkst0hV1SqM?=
 =?us-ascii?Q?PxIYZFdbJJEntSyM7o1qz0n8NOg1O1KEFvEmChtLMon1xJYHf86L+b+xGryy?=
 =?us-ascii?Q?rzyJUZ4snsN0OUkEUPdzZftZTCNZTfhbwQOngm9odR9niqp/41IqPVLpFBXz?=
 =?us-ascii?Q?EN7zLF4nmdifGzHwTDyv4/1DGKxJc4KZlhPFN+2g0CueVdRrLEGyAvHXMCnF?=
 =?us-ascii?Q?/nzwhInXmW8WABokpO6vcHPJYrtIfLDrXAJIfBbD/Wbi5zi8jZpghTfjGKUU?=
 =?us-ascii?Q?smAD19+IznV7npBGoGLmcYfJqvUC7JKBdHrnqVEzeO4Vq9EJ+a/iisz+XshI?=
 =?us-ascii?Q?40AYQMUEQ81XGj7wdzpl7U3mEICBnXLIT4VVE6orTYhlHz+ZRKmAAnvweDEE?=
 =?us-ascii?Q?gv//naC20qqESm7uGBAmUFOeqgRmWpz6k+2Z33zkLGKTClhkdNnYfXq0APyK?=
 =?us-ascii?Q?sPGo3o7EKx2XQ7aFmj4h/ROk8iie+2l+GHtc+MhBoXMd2Xfp4pg1CnxWCzml?=
 =?us-ascii?Q?30cAM8IzOso5DI9s0rYdavxd2/n4MHrHwOs+cRr0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71fc90c-5fc9-4957-785f-08dde1202c59
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:04:05.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUWqCtMJS9IVHiB1sQUZWLaifIptgzfZGLQyGCoMARR8pxc2TqJf83s7suKyycHyIk6ubiYgZM714dmkT7qkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

Change Device::vendor_id() to return a Vendor type, and change
DeviceId::from_id() to accept a Vendor type.

Use the new pci::Vendor in the various Rust for Linux callers who were
previously using bindings::PCI_VENDOR_ID_*.

Doing so also allows removing "use kernel::bindings" entirely from most
of the affected files here.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs                    | 15 ++++++++-------
 rust/kernel/pci/id.rs                 |  5 ++---
 samples/rust/rust_dma.rs              |  6 +-----
 samples/rust/rust_driver_auxiliary.rs | 12 +++++-------
 samples/rust/rust_driver_pci.rs       |  9 +++++----
 5 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 504593c882c9..0ef8754f83e5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -132,10 +132,10 @@ impl DeviceId {
 
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
-    /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    /// Create a new `pci::DeviceId` from a vendor and device ID.
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw(),
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -231,7 +231,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
@@ -412,10 +412,11 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
-    /// Returns the PCI vendor ID.
-    pub fn vendor_id(&self) -> u16 {
+    /// Returns the PCI vendor ID as a validated Vendor.
+    pub fn vendor_id(&self) -> Vendor {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        unsafe { (*self.as_raw()).vendor }
+        let vendor_id = unsafe { (*self.as_raw()).vendor };
+        Vendor::new(u32::from(vendor_id))
     }
 
     /// Returns the PCI device ID.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dd91e25a6890..2e4c7edc48a4 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -124,9 +124,8 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 /// ```
 /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
 /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
-///     // Get the raw PCI vendor ID and convert to Vendor
-///     let vendor_id = pdev.vendor_id();
-///     let vendor = Vendor::new(vendor_id.into());
+///     // Get the validated PCI vendor ID
+///     let vendor = pdev.vendor_id();
 ///     dev_info!(
 ///         pdev.as_ref(),
 ///         "Device: Vendor={}, Device=0x{:x}\n",
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..f3385c4a7e5b 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -45,10 +44,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for DmaSampleDriver {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..55ece336ee45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -50,10 +50,7 @@ struct ParentDriver {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for ParentDriver {
@@ -81,11 +78,12 @@ fn connect(adev: &auxiliary::Device) -> Result<()> {
         let parent = adev.parent().ok_or(EINVAL)?;
         let pdev: &pci::Device = parent.try_into()?;
 
+        let vendor = pdev.vendor_id();
         dev_info!(
             adev.as_ref(),
-            "Connect auxiliary {} with parent: VendorID={:#x}, DeviceID={:#x}\n",
+            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            pdev.vendor_id(),
+            vendor,
             pdev.device_id()
         );
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..f3819ac4bad6 100644
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
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
@@ -66,10 +66,11 @@ impl pci::Driver for SampleDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let vendor = pdev.vendor_id();
         dev_dbg!(
             pdev.as_ref(),
-            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
-            pdev.vendor_id(),
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
             pdev.device_id()
         );
 
-- 
2.50.1


