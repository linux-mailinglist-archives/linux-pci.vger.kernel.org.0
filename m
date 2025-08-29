Return-Path: <linux-pci+bounces-35155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835BB3C4FB
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B35A329D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DA2C3272;
	Fri, 29 Aug 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neA5kGru"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19C2C08BB;
	Fri, 29 Aug 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507007; cv=fail; b=KBwePuIRihGQBU0RXjhRDQTozOWc+f4K4qYanBS+OPIOdklGlEGsOexLn89GtBfp33QA3s7nBzPzGuE9XAwFMka+d6wQOCTVmY+zAHfQsYF7R2+9LPwOR7kcLVXvLiaLIBZo3q565fm9ZdG0/Qmo0EsMz67iuR7VoMQ6FvC1J1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507007; c=relaxed/simple;
	bh=MTohjgSrYiSivshssgjqkGNtx7SqDLLzpdF322Ndbis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoLrwi4IWRYECghV26E+n3H1BsFDC553+0CWC3xTkdPcX0k2kRF1Ei5v1XdShrqb119ki2WqJwLIe+TyAa2zvDzUBHpCKPm4f9xhaarP6lZ3MSbBziFg3BfPrI8+sSh1DgFLaNKSUeLV9sY1Abn88jXZercBlM7ihjI3Gj1FqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neA5kGru; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTlTW0IauSW5Rt8UIrSmF9qjYYD5m3hQprGF+G+H0osE/zStGR7rfhQBFKfuu4kUyopfkCzBYRZb46KJYnp7dnI1QdmLJo9fzVgkqdbMsj9IYIHxwJU2g4/H0jNKuDt/6dXPZ0k2MNyno0uHxilqoQpk9Zepf0teNxwINYtL8HSH412l7/ouA94Y4hGW43ARJdglS6Yz2tDUZ17iCtc0edEjWvCN7zCWljha67r27ZYZ4AK7ULe8Ju3Pj1Pl4j8cwnjsitw1RfniGlaGtraHZZMRnZ4gizQQwo1+s45L+0wDdAuDAE0XtSqECd6pMuSEBBmLmW3KLk0YyQ8a3DhDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIqoJd/yfauO0vT5lYh35Jg5gVUZlx/FweZoTF5SNBs=;
 b=fblmSsbddjDrqt8Uu8XCwFfkRfdC0iqpDeZr4FctoOM7Mx+tSzZmyFwK8Hrvvf3870M/zIKdYCbXPw2mxxC4SMZFLzbHy4aqm7/rTn1KdK6C0rADjmimyUCUjGmMZEmd5BsyQg3cxgs5COWD5ev2kV3B3sRocFqgBmEh37Ymyg9BoMFk02C1Br0pNkvH49AyM+wlsmoPkTXCWPL+mkS7w92TbwOaSNy8r5weQ1jBKie5oKoBsMoAvif1YopIaBOVfXQRMe3ntS74n9C9nS93tY14Sm3RHIgx7t2pPjwtS5FQZ8aCIBzJrsaA7o1m7SIIa9w9Zxn6G+2EAIDavoaZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIqoJd/yfauO0vT5lYh35Jg5gVUZlx/FweZoTF5SNBs=;
 b=neA5kGruMWgriIparG447PQOQo40hOzo6k17bo1Vp3KN98Hj+tUozE0/gyYM7Xqodndi9wfXb6qe4n4JHkMmqDB0dNQddIVHewqTKb7HacXDXPco0PLG0adYRqAkKiF9YI9B66CB/ZxFsKfuPfiYjLZY1PUFiVP/cH7yZL4pG32+5ST4bQIxpES1N5IhGLoyPhaBM9mcIJ/DaiWy3Hk/ZynOAACuH7sC9uOMSSv4uExKrk0n2VtU3hLA8+BG4McZz0HT/XPPHZU0Q648eFdSX630+W4xsnmueIsZmvnqGknJNxFMSbSbEqjDtOOHuiJaKjqJitGXGIPLjXCrMeu+DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 22:36:39 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:39 +0000
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
Subject: [PATCH v8 3/6] rust: pci: add DeviceId::from_class_and_vendor() method
Date: Fri, 29 Aug 2025 15:36:29 -0700
Message-ID: <20250829223632.144030-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 679e99fa-0eaf-464f-d29f-08dde74c8544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEB/unt0vIj+ChOQzIABmyNTj9Z7rlXdjV75J1MqBfZ7ZV0S72FatzdMXKRU?=
 =?us-ascii?Q?e0mPNB5EFV+cNAOuM/9PgFeuwxnlqhpDfsehDdkXGsQzgghm5aKrxkrc1kN4?=
 =?us-ascii?Q?aDiXxT8kVfEhjuyM4SOLeCyxGztzJUF6aQ8pn/XXuzeOoZ6OzZ3/qqD+EvcL?=
 =?us-ascii?Q?sAzGGnIXdVWj977G57u6CiLxuZ2op1Es+hdybwLmo4uXs8y7wtFpKJih+5fF?=
 =?us-ascii?Q?YpfUTDtd2K45KwD/I7m1i0bWhQDK8Un/ZulCSshjggFMV09pyb79POAjTLBP?=
 =?us-ascii?Q?P1VleEg4qj+zebaBdwenMyjC6bBJJ2p8HdWpR6y/EsXB4bJd0pAmSKB2bVtk?=
 =?us-ascii?Q?QSEU6dkXukR1f4pCVvNv5Pml93OBnbxtMFia32Y8J6WvdvZwvYOm+vJc/Vkt?=
 =?us-ascii?Q?u3rTa6VI/eYYIcZuzVGgRRMlQ6TzAh7SpTcW/wxYRg5dh0vafoUrorgYA9ko?=
 =?us-ascii?Q?9/EgTxl1VtZd+bhA31sNQTdLjXPDFbRL3/xOOcwfUmwZdDnCl4bU8ZwPChTd?=
 =?us-ascii?Q?MwxTf8DDent57125h5hME7vG1HxSoV1lX/2qMVr+heiqRWuRnKYHgARwmOBT?=
 =?us-ascii?Q?kmuvaADpZ/QmfkDX5v418Je19cH0kKKRgt8kFoQ06Ia9gLp37ux8XKqZl0AJ?=
 =?us-ascii?Q?d1FrP3LbM1YTpWQMAkg90e1zwaBnFkqb01Y7yGZ6WK02dKf1Z7c8ymYfV+8f?=
 =?us-ascii?Q?HEDCuImC0rB3Dwqs+RttuYl5n4yRMp+r7KLUqjBVZbmDJCzXJnJy993FNfpd?=
 =?us-ascii?Q?ZEU9j/1ss3trly/Nu3QVLJ7rP5ZG6JOX/CzWAlAWbkTaH4/+WxbZIT0KCRBc?=
 =?us-ascii?Q?5RYjnxcWknXq6jazFI5kK3fNELmaXgnbSQmmgL9vTJJ1FYn6aDGOateR3s+Z?=
 =?us-ascii?Q?vrpU0Jh2mEoE/8UeoB0249XjA3Z+pxpDkKiA35yYlpoJkFEavIjy3dkf1iL0?=
 =?us-ascii?Q?0J0SdRpWr2qk9fkMiCkGX+E1HC2CBQcsAJAVcUpRpfK57zN8997DeohCFLdY?=
 =?us-ascii?Q?qzEponts9dKr0swUNroMlphaCmvvGKw3jxPWPHGl+G8dIi/0agw3m+y24UqN?=
 =?us-ascii?Q?+Ca1JWKtGDaWWrys+gCmLFk3bUG3qPonSGizDl4DWG+wV/4cF+nwLtJAtmE3?=
 =?us-ascii?Q?/18vGJ6BowOkRYHvlMHk8EESFkvZ0WFeHonRGUa4VknP3nLR0i8bFYmv23oE?=
 =?us-ascii?Q?PApi6+/5sUL2GxhGo6oYbaKh9PQlcnqivs28ev3JrIcW3tXSCu56Vn/wuxC1?=
 =?us-ascii?Q?tluzPis82wIg4MiGjaMKvI7/64qEeGpEGQvnIFNb4eK+KLEgSFIxuJWoJhay?=
 =?us-ascii?Q?ce5sP8TkJxbguu8AbLcEKB5/T+W+t7SLWdRAL5/yeBzLeyklHegawh7bZM6y?=
 =?us-ascii?Q?R82MJDh2VKCOYWpz4uaZQI8TArKIk0olBJ8Y+qDiPJ1WQqMepLqH9RkIDlP7?=
 =?us-ascii?Q?J8YBXZshwgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFzHCh0kB+lKxOFBmUGXyAYMGrra/TXHIy6ryA+Xpv21b8rqX4GBFWO6zeeL?=
 =?us-ascii?Q?puQtRauM0hm6o1PhVYdC9pXwKKzY0UbDG/CjlU5f+iDfUUuYK1s9Sw/GuQuW?=
 =?us-ascii?Q?NteZqMtphKZQGs3cvhWVHiwjZb233evUApXthFULBLLkyrRTVbneglMFFu5X?=
 =?us-ascii?Q?imj8cXk8dPLbOGmAZhymRGEXXxole5I67ScbcgTFVx0dLXFPLEznAVd2AYzb?=
 =?us-ascii?Q?xOWShc0BYz+JrufqRnTcXc9+r7Gv8OBounMVJExhLZ+bT0jsllVFd5B4tPNf?=
 =?us-ascii?Q?zT/ltz/u6xOnHCsByuK5+sh4B8+/m1zt2OOxYmLGSmvqRgwXjR7Lf9uMmung?=
 =?us-ascii?Q?MM8akl2/8U3JpJe+okBYQe+2YgWyzxa/bGiSO5uBbFYayv7c3TPRKUMz2lW5?=
 =?us-ascii?Q?jPMb1T8bm3xfejjg1UanM6aowVPUqo9qbblga8VRpQJDrOjk4aoM9qntDdQ4?=
 =?us-ascii?Q?7AagBaWvfAXn65j4LxgnCR1hVOkvgIaAMK72sTk20jgfPHdZaxD+xBDadhOx?=
 =?us-ascii?Q?XwQvpbK/xTry28etuRGjCX/lOFNAECNZgPbAB8LhLkACRYyZbvxn8j9fbUvn?=
 =?us-ascii?Q?QmjO3vO9Uu4e+JOsBd7u+lZ3y74K6bQUTg9b7taNStW8WISfzwZ/Pb7tAOKN?=
 =?us-ascii?Q?B0TOeh1PLSmZSX/BH7S3JgEl1g39sW/p9jqpPPhKA4N6SDbf4xrUWcL6IwUG?=
 =?us-ascii?Q?bEYKK1vIkB6EbpolBVTxslFiPBRe4n/Nj+nAwryfIJIV8YtAVFbji+ZMoBHg?=
 =?us-ascii?Q?0zlFyFsu+4y2//etKdzYdSh52rbAqrc8kPs/L6+oo70VacXN2wyFMlwuB4ok?=
 =?us-ascii?Q?kKgFLWenvoWB3kRLNB5JlrXR9eNNhTIFb/p49URJHiAehqxuH8fXdCVzE4Ab?=
 =?us-ascii?Q?R9c9YyBt9ok1UKkRZJHq99/aRVZeThqdyXxWL7ssp0tkc26JbNxjgelpkb8J?=
 =?us-ascii?Q?I6kfIZS/uFmD5FVJMggaiA7pgg1zBoaiadDVuLlIPt0/Hu+8GogZ/YlK60nl?=
 =?us-ascii?Q?bAOaOctxkgNYE9btWY0q8JjgP1NMnN5FnKQ6Qf7HK5Pi3HaFpZT/TeNNeWcb?=
 =?us-ascii?Q?XZoTlrPq5Ax0m5/nAQ7C9eOKhV+jPSbmYulwmRazVhwcgHt6uMmJmgjZN7yV?=
 =?us-ascii?Q?UuSQcNkcEBF0aZi47M0Mr+1jt7No+GSOiLTt2Q+/LdQcW06oVJ7l+FGwzqhh?=
 =?us-ascii?Q?RAPGWbkqoZv31QFnUKpsr8H9skQl+Oki3GsMnKulR91PW02irEwQgpk+/0bA?=
 =?us-ascii?Q?ptq1h0mVZlRI895TIyfo/OoB9WDFnAWJec2ZSSAcjUIzvHRrWQqfK2fxFWP6?=
 =?us-ascii?Q?X3AOYf90+vAMnwRE2Ou3hyXGCJO1/VDgeZhQVfz4igMWvc3+Me4CbNISia8s?=
 =?us-ascii?Q?gvRrJyXSreL1CWIfopWHQKqvaevGHHryFLnksxwzhr4aXvQfypMs4fPZ2Lyh?=
 =?us-ascii?Q?E30c7ySVYomI3Hdq1/bevz1A6oav+1sti5uPISa3j6AIoO5WvpkgH5taEgvy?=
 =?us-ascii?Q?LyBEtn5ndqWoaNTB51U1pQJfAalOzDJLw7YkBeCJ2YJk3i2kCuZl3lvO0kHO?=
 =?us-ascii?Q?8eCSneP11gYE5wfP6J3zBSOs4d2Udu/jQXycddH4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679e99fa-0eaf-464f-d29f-08dde74c8544
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:39.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O+PI1BE9Z8PfjraZYif8JpO587onmbeq4JqNzmMlSXz3hNUlt6FCeB2CZI0OHMGrQkZpmHeIDf56DiMwc5UMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

Add a new method to create PCI DeviceIds that match both a specific
vendor and PCI class. This is more targeted than the existing
from_class() method as it filters on both vendor and class criteria.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f15cfd0e76d9..26974cae4a22 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -161,6 +161,28 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    #[inline]
+    pub const fn from_class_and_vendor(
+        class: Class,
+        class_mask: ClassMask,
+        vendor: Vendor,
+    ) -> Self {
+        Self(bindings::pci_device_id {
+            vendor: vendor.as_raw() as u32,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: class.as_raw(),
+            class_mask: class_mask.as_raw(),
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
 }
 
 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
-- 
2.51.0


