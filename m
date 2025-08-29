Return-Path: <linux-pci+bounces-35154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43698B3C4F9
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B0B5A33AB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C522BF010;
	Fri, 29 Aug 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7zg4mUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974628A705;
	Fri, 29 Aug 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507006; cv=fail; b=MvfHa2YvzYG2ddTG0XvkeQAu3Fm7FeDd2JB96MCep0k1pdD4vAudeO+Ik2O0hgVPv+GTR1adrqEx/8WpxUhmRigFi2fj4nYMzRlZ3IbvhrE/czGSvg8koEdOtd/ndFezJPzFVGPRZKqg+20ggfQQPOOWL+hW7FoggekFLfycamY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507006; c=relaxed/simple;
	bh=s6dlZDoOupXdu1KHMaaFaVojD9S216O2jW/m48zFOmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoGiSG4sdAbVN1DmsJAVKG0Tac8HvEIUsYqdQgIbkGO37Zl6UNyTWwA09RW1YDckHIVg/BWjDDni0SO+IlKlS39d0FBw4kQzBb4p6hZwlehVqHP1xMU3Q4C0Nd/zP0J9IvVIIQ87I+LIzM82P1h7LlZ8xqMb7bL7+sSWzNib3sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7zg4mUr; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHwEUT8YPZ3Aza9aeBl4EtNrMXPHEYvK8UFjvChvlhAAZRojQmc56GMY0hZU/ybaWuCWOP9vA8UeQFhOOEcIjaQFMsde1ot3/8R1UoZSjaDYzuhXp02m5h+eWcQbgho9K87y5QZT95t/hCYuY/bG8AYfnQhx8juyAKHJrT+uKkFDymRnhYURjc4q7cPmWdr07U3IAqfczuc1pwBn5s9YJn2l2kTxd5iq3BN0CWs21rp984Yw8R/yvZ1/fso6EqquoE+s5G+hFjiiTHEZg/vl/G/QEe4HpQ2r7y8p4npNd3dAX4fZPChnSl988iSf8qVTlGTdobX7lZnVSWNgbQvvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhykZMPnyQFz8eH7l+MoV0JIjvSWgqF58F3l+tk1cls=;
 b=x2SefkAy8/UcVcVcUuIvQTln/SQ4mwVDO95/ZlQLExveJVURbgP7Xuod6QZQX0t4wakwohmbbj+Onz9rzkeDnNGjaRd3K35IY7VESfRCZrGCenvGKiWdBrh1qr9n3IYieqqK4oA4s1EdnIeR96wzXUfMirUKnIWzxqLSi6Rk8yEJuWJIPWkvvdtsTs8ZXNE1DSkf2yEOOuOL5ybqtvO5dGeLpGp5b4659BukGAtDwlBAjFjtNlTSuYtpyj/AuyvgM+OK/ITnAGwu5O3YYBKcSPu9LRjuSv4KF5ddOkGNR+I9WL9h6GAMkjUj8nuGyttEwOM1zNapnIqutjTtf8Z5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhykZMPnyQFz8eH7l+MoV0JIjvSWgqF58F3l+tk1cls=;
 b=q7zg4mUr9eHjbnqP5PqC4oRXLgHoDAznXjV3SUW3XZcKNb5NL5qJfteEy3U7NyRjfaGASW5cGxfzGXZyLiKF+mKsOm7ZBRC+GfsijZ3bNk0AyhlUUH9diYgkQe36ngZ161EjNCjkGJu4RwJ8cs6vGsH6S+0Nh4pQxtMf6SrA+15gFbOwk8v3VLaflM2+efGphUdExv1Mk417pXWwx/72+5yypu9s7lG4bok/57D0h1eqpPBfmffvi/mLeht0nVBhJbyj6DoboqMoqMAbZ4csu7PXYAyJKfslOFt+hyh1a5yPOA3YudFMKmOtLa2j3w4WtDxVqjsjuy0aETh9z0B3LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 22:36:35 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:35 +0000
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
Subject: [PATCH v8 1/6] rust: pci: provide access to PCI Class and Class-related items
Date: Fri, 29 Aug 2025 15:36:27 -0700
Message-ID: <20250829223632.144030-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 249e2b3d-1413-427f-e8a1-08dde74c82e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzAQJomihbayQ8qVmqbTx8ghyh14Moa6JxbZMms/ys0fM4ubNJ2IfTCQkzDW?=
 =?us-ascii?Q?DpXR0Ys7D6MEZXH7dXoNF66IU8PYnN0ho6HNXw1r1X+/EEUpjp4nJ3kJeGaX?=
 =?us-ascii?Q?l7ejliM0tPrn5kJS+BpU59O2DGdBBpyZautZ1nTUQD3FG5fYKCGQ7KN+ySV2?=
 =?us-ascii?Q?B+DXXSrtu7d9DsbIGS+fa8DVp4r1k9tQ5K1suEdJ4a26XAvAM+bt8OFfQtPD?=
 =?us-ascii?Q?wYsFdT00zFgj8EX5vCBB+DO2eq7dq2ZObwGqUCsdcXGYT8FiHStDAyRJ1YY4?=
 =?us-ascii?Q?Zk1cj+fhU6DEAnf3EW2wyyMQ8w8Nv2b+ZAeXN3vaNLZ11Giyfh7kmgTVUDcL?=
 =?us-ascii?Q?rDYrLGML0fRUJ3YQ7TOzNVA7O7+fHI1FjVFyFUp4t39iJiQvX0owac1pOE0/?=
 =?us-ascii?Q?YzOYU4ADOQqor2Rg4eSxMGy2XJNzBM6E7laY/H27m7TaJBvnj/V5ZIYyYERY?=
 =?us-ascii?Q?TDkMDEfAGZ92x297bsrxsY7yHzT0QBM5m8+tesS5aryNv79nmXKl4H2mGmcZ?=
 =?us-ascii?Q?P7bLr/J1+LUIuTDJBttWvN0HxnBx4NvnLvcpwXbldUPKYtaLZkDVn3PGARJ4?=
 =?us-ascii?Q?NJ40uyDD3yXRj847dTKKVuUebY1bweeyx/VqoufXlkDldXJb6SbZjDshIBIS?=
 =?us-ascii?Q?hWqxvzf3K9cWSagIeToVpCjZTaoaqATLbZDDyi8QrRhebu9yIZlWDuNChvES?=
 =?us-ascii?Q?LzKXvoj9igsgn/turQP8uiatGdFP8mrhpMU3vAnxW47JKnNAzw95TvlSRs/t?=
 =?us-ascii?Q?E0xo0vfWSinL7+ezOU7CTK30t+j0ghZel5gY/ExJvI1TLOYBHCgSzpWCYYWL?=
 =?us-ascii?Q?QxDcXnbwixbK5IaOHDFJJrhww+tK18Qg44HR2uIOH0pbMbVnduR5URL5ocdF?=
 =?us-ascii?Q?/E9UwiDPghIDV7dqRzYWWZfXJtrSeVg5jKtQtkNHbkhc26tNQG44150WoFQs?=
 =?us-ascii?Q?FgHYjBO3VXE4ZZc+LD0vca/nGOVWUdg7ePtI+tlZDT+F5uEGYtuILqgA24qa?=
 =?us-ascii?Q?nLhsNeXb/HSPoic8MdNaDlHj1dMCtephPbJYauGtE9VgxPRHzq6/BZR2e/mf?=
 =?us-ascii?Q?N/EUtimUj3MadjnYPHFPTuuaSJ0sWfdTnGdZhyX/6xQ3g32S3PCdJc603tm8?=
 =?us-ascii?Q?gzJPN6m/19NqtmyXFaml7iRRR/pcmYSu/XAY/uYd3kKd5/ZBT1E1FCs9ZXvf?=
 =?us-ascii?Q?qDtVQhwYKXj/HaaYBKa7rVvkzCsqy5s+n3kBcT67HlQpVIk17HhvGtWgQf2X?=
 =?us-ascii?Q?VLTQa8hutCgKjXXWfLssF0i+geQGQBMv6m5Uczr2/l8cXi5K4nJ7zBeo7aTj?=
 =?us-ascii?Q?knzRrydKysapI+ZabvSq1WfkMPrwWQPyXKz3/kkaEF6T/D8W0BQCHnC19nF9?=
 =?us-ascii?Q?AEC1CQRL84J6Mpw+vUvc0JwEsVA1VfpvTUfPZ48T15kW+LNfgEn7Z8alh2St?=
 =?us-ascii?Q?zGriXledKY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rj3W5RoxCCyE9RDFV0tuSNg2DOAADiBp5ZmDeSW85rPmxrird7IAmdahdJ0l?=
 =?us-ascii?Q?JdKnpSPXSwrmCf4EIKvI8r7+2lWLmNmwZnIkuRuivxW75KYohOoTRVg1nT0S?=
 =?us-ascii?Q?IJ4O3drOvj/357wEZI7nJAG66jSW7ubw29B+b8/p0dkrEbBSe8UoFSl3DXDr?=
 =?us-ascii?Q?P2U5FbWVMPX7SSpftLrYpuADJ4jEY/g62g7IkOUtg9QXM94mVPSYwuSqCX1b?=
 =?us-ascii?Q?XppTXRIrcBUCX0FrHhwiO1sRaO+lu8W8vX2rd1luRJw76netHziQk8LRT5Gz?=
 =?us-ascii?Q?ABCXQI9hKXOp75868GXXalLtBmwcfw21NtyPzu8ginVA4T1/bML6frLmW+U0?=
 =?us-ascii?Q?Z28iKLwVUUP9sk80hrBWIgIALGfIiSX7qs6r140q9QDmiqg2V5o6BTTLga0F?=
 =?us-ascii?Q?yUVQI7hJ1He0GrUOarxpQ2aF8aBoaxT0OvD+QIT//LHBM6hYxWCvMIdUdRx3?=
 =?us-ascii?Q?eeHmIV40Ug0u8SEcmkPbmjEmqCT9BvegaL9LaKJLiCvs67jw1KTpj/bggCKU?=
 =?us-ascii?Q?GBaVtu8RzMnm0hpPRadvjsnhTOBcr4kyOTm2/PVDuOvkTZY4+x3sm/Hpo0I/?=
 =?us-ascii?Q?zCB2OKdja/eZRxc7XnVJBXeZPjQzPuA5GFOaI8aTSo4bLm7rMHHI6YKi2UAP?=
 =?us-ascii?Q?E3c2vcijVzuH8FXbSeenFvXTNODN7KrovY/fmBSb5JA2bYxUEIQok9+35odr?=
 =?us-ascii?Q?NRlzj4hattnOwF3lqd5eK437iE6VCJlmmd/VPwV8kJpIww5D+itRE7gJ0Ek4?=
 =?us-ascii?Q?Q2prlf1tuYEPNNcmZZ9vE7/rOUE8XspEzf/BjLDaNjBJH9iY4rcwU8hLExjP?=
 =?us-ascii?Q?qGOHdK3+Vd3Icx3Ija32bj0pFoe5zWB5GIPHbtAGyGR+Qlqpx6EmmA8h31Za?=
 =?us-ascii?Q?gU2INEuOSjPiTeV+XoP211xl7G3G8/ANHVOuInByV0/stvUV93HZjzVxPwGk?=
 =?us-ascii?Q?AreBdNQaWkepQqFjb/FPhvJEjHSnaPYJQH+F6ER7PdVn1aOLieKAMDhltK5V?=
 =?us-ascii?Q?DLZPyqVU/oDOwQSSXT77vXsxEkw/CezXTrdlJ/YJ0KuVykQlOwOt6NHM0B6e?=
 =?us-ascii?Q?m2fzmYhRz6qyoORwhDSyK2il5JxN6iGikyRoocQNOb3o6Ez3pf4mIQgK+OZe?=
 =?us-ascii?Q?v174hrH/nhvX0lrEuLJaTu+NCxPmCYPQ5PpwoWhfLMthhMPkv6QDhYPYn17K?=
 =?us-ascii?Q?Yw2rLje+EntUHYnFGlzbwmyOJe3RC6ZesoTGfGGW31ojoHSCGfJ8JpNv37dT?=
 =?us-ascii?Q?1XhbwgG2hC/YTnRHzw36B13EDqVmNqI2GhKyoZnEpmHowhqnaOw/sBGlneX0?=
 =?us-ascii?Q?bhMnEYPKvEAB10n1A1CxAU65iyCo34hpur0beCPtenoELY7urYTKzfF6y7nZ?=
 =?us-ascii?Q?MGs/CTvQbKTYs2sGcXIPPN8c7NaDAviLIqEtf2cRYdgIa75m1nfz4jo5uwtM?=
 =?us-ascii?Q?NyaZf8f8r9EKQX9OcqsSJfQDalsb8Z+LLSyXmOlBT6aEAoCn17u5X0XkUvXO?=
 =?us-ascii?Q?1IFOA/l12Aa5HL/hSTAbKukapYk1dMfpRAUgoogKzoBJJ7Ija1iMwkjjl0ok?=
 =?us-ascii?Q?QoeNGmJd5waje4yr6DDC2OQVKB3Mbpt4XY43rqnf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249e2b3d-1413-427f-e8a1-08dde74c82e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:35.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRDANQiStltu1uQ+TKiT/ffBt6Rdpa3fbnBKrI06+M4pjT7bS5wylqn/KpW5njlPp91RHj5huDWv6mGWfudE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::from_raw() -- Only callable from pci module.
    Class::as_raw()
    ClassMask: Full, ClassSubclass
    Device::pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 MAINTAINERS           |   1 +
 rust/kernel/pci.rs    |  11 ++
 rust/kernel/pci/id.rs | 231 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 rust/kernel/pci/id.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..28e200fa9423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19532,6 +19532,7 @@ C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
+F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..212c4a6834fb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,6 +23,10 @@
 };
 use kernel::prelude::*;
 
+mod id;
+
+pub use self::id::{Class, ClassMask};
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -410,6 +414,13 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the PCI class as a `Class` struct.
+    #[inline]
+    pub fn pci_class(&self) -> Class {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        Class::from_raw(unsafe { (*self.as_raw()).class })
+    }
 }
 
 impl Device<device::Bound> {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
new file mode 100644
index 000000000000..18a1b7f9afe5
--- /dev/null
+++ b/rust/kernel/pci/id.rs
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI device identifiers and related types.
+//!
+//! This module contains PCI class codes and supporting types.
+
+use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
+use core::fmt;
+
+/// PCI device class codes. Each entry contains the full 24-bit PCI
+/// class code (base class in bits 23-16, subclass in bits 15-8,
+/// programming interface in bits 7-0).
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
+/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
+///     // Get the PCI class for this device
+///     let pci_class = pdev.pci_class();
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Detected PCI class: {}\n",
+///         pci_class
+///     );
+///     Ok(())
+/// }
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Class(u32);
+
+/// PCI class mask constants for matching class codes.
+#[repr(u32)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum ClassMask {
+    /// Match the full 24-bit class code.
+    Full = 0xffffff,
+    /// Match the upper 16 bits of the class code (base class and subclass only)
+    ClassSubclass = 0xffff00,
+}
+
+macro_rules! define_all_pci_classes {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+        impl Class {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self(Self::to_24bit_class($binding));
+            )+
+        }
+    };
+}
+
+/// Once constructed, a `Class` contains a valid PCI Class code.
+impl Class {
+    /// Create a Class from a raw 24-bit class code.
+    /// Only accessible from the parent pci module.
+    #[inline]
+    pub(super) fn from_raw(class_code: u32) -> Self {
+        Self(class_code)
+    }
+
+    /// Get the raw 24-bit class code value.
+    #[inline]
+    pub const fn as_raw(self) -> u32 {
+        self.0
+    }
+
+    // Converts a PCI class constant to 24-bit format.
+    //
+    // Many device drivers use only the upper 16 bits (base class and subclass), but some
+    // use the full 24 bits. In order to support both cases, store the class code as a 24-bit
+    // value, where 16-bit values are shifted up 8 bits.
+    const fn to_24bit_class(val: u32) -> u32 {
+        if val > 0xFFFF {
+            val
+        } else {
+            val << 8
+        }
+    }
+}
+
+impl fmt::Display for Class {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "0x{:06x}", self.0)
+    }
+}
+
+impl ClassMask {
+    /// Get the raw mask value.
+    #[inline]
+    pub const fn as_raw(self) -> u32 {
+        self as u32
+    }
+}
+
+impl TryFrom<u32> for ClassMask {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            0xffffff => Ok(ClassMask::Full),
+            0xffff00 => Ok(ClassMask::ClassSubclass),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+define_all_pci_classes! {
+    NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
+    NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
+
+    STORAGE_SCSI               = bindings::PCI_CLASS_STORAGE_SCSI,               // 0x010000
+    STORAGE_IDE                = bindings::PCI_CLASS_STORAGE_IDE,                // 0x010100
+    STORAGE_FLOPPY             = bindings::PCI_CLASS_STORAGE_FLOPPY,             // 0x010200
+    STORAGE_IPI                = bindings::PCI_CLASS_STORAGE_IPI,                // 0x010300
+    STORAGE_RAID               = bindings::PCI_CLASS_STORAGE_RAID,               // 0x010400
+    STORAGE_SATA               = bindings::PCI_CLASS_STORAGE_SATA,               // 0x010600
+    STORAGE_SATA_AHCI          = bindings::PCI_CLASS_STORAGE_SATA_AHCI,          // 0x010601
+    STORAGE_SAS                = bindings::PCI_CLASS_STORAGE_SAS,                // 0x010700
+    STORAGE_EXPRESS            = bindings::PCI_CLASS_STORAGE_EXPRESS,            // 0x010802
+    STORAGE_OTHER              = bindings::PCI_CLASS_STORAGE_OTHER,              // 0x018000
+
+    NETWORK_ETHERNET           = bindings::PCI_CLASS_NETWORK_ETHERNET,           // 0x020000
+    NETWORK_TOKEN_RING         = bindings::PCI_CLASS_NETWORK_TOKEN_RING,         // 0x020100
+    NETWORK_FDDI               = bindings::PCI_CLASS_NETWORK_FDDI,               // 0x020200
+    NETWORK_ATM                = bindings::PCI_CLASS_NETWORK_ATM,                // 0x020300
+    NETWORK_OTHER              = bindings::PCI_CLASS_NETWORK_OTHER,              // 0x028000
+
+    DISPLAY_VGA                = bindings::PCI_CLASS_DISPLAY_VGA,                // 0x030000
+    DISPLAY_XGA                = bindings::PCI_CLASS_DISPLAY_XGA,                // 0x030100
+    DISPLAY_3D                 = bindings::PCI_CLASS_DISPLAY_3D,                 // 0x030200
+    DISPLAY_OTHER              = bindings::PCI_CLASS_DISPLAY_OTHER,              // 0x038000
+
+    MULTIMEDIA_VIDEO           = bindings::PCI_CLASS_MULTIMEDIA_VIDEO,           // 0x040000
+    MULTIMEDIA_AUDIO           = bindings::PCI_CLASS_MULTIMEDIA_AUDIO,           // 0x040100
+    MULTIMEDIA_PHONE           = bindings::PCI_CLASS_MULTIMEDIA_PHONE,           // 0x040200
+    MULTIMEDIA_HD_AUDIO        = bindings::PCI_CLASS_MULTIMEDIA_HD_AUDIO,        // 0x040300
+    MULTIMEDIA_OTHER           = bindings::PCI_CLASS_MULTIMEDIA_OTHER,           // 0x048000
+
+    MEMORY_RAM                 = bindings::PCI_CLASS_MEMORY_RAM,                 // 0x050000
+    MEMORY_FLASH               = bindings::PCI_CLASS_MEMORY_FLASH,               // 0x050100
+    MEMORY_CXL                 = bindings::PCI_CLASS_MEMORY_CXL,                 // 0x050200
+    MEMORY_OTHER               = bindings::PCI_CLASS_MEMORY_OTHER,               // 0x058000
+
+    BRIDGE_HOST                = bindings::PCI_CLASS_BRIDGE_HOST,                // 0x060000
+    BRIDGE_ISA                 = bindings::PCI_CLASS_BRIDGE_ISA,                 // 0x060100
+    BRIDGE_EISA                = bindings::PCI_CLASS_BRIDGE_EISA,                // 0x060200
+    BRIDGE_MC                  = bindings::PCI_CLASS_BRIDGE_MC,                  // 0x060300
+    BRIDGE_PCI_NORMAL          = bindings::PCI_CLASS_BRIDGE_PCI_NORMAL,          // 0x060400
+    BRIDGE_PCI_SUBTRACTIVE     = bindings::PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE,     // 0x060401
+    BRIDGE_PCMCIA              = bindings::PCI_CLASS_BRIDGE_PCMCIA,              // 0x060500
+    BRIDGE_NUBUS               = bindings::PCI_CLASS_BRIDGE_NUBUS,               // 0x060600
+    BRIDGE_CARDBUS             = bindings::PCI_CLASS_BRIDGE_CARDBUS,             // 0x060700
+    BRIDGE_RACEWAY             = bindings::PCI_CLASS_BRIDGE_RACEWAY,             // 0x060800
+    BRIDGE_OTHER               = bindings::PCI_CLASS_BRIDGE_OTHER,               // 0x068000
+
+    COMMUNICATION_SERIAL       = bindings::PCI_CLASS_COMMUNICATION_SERIAL,       // 0x070000
+    COMMUNICATION_PARALLEL     = bindings::PCI_CLASS_COMMUNICATION_PARALLEL,     // 0x070100
+    COMMUNICATION_MULTISERIAL  = bindings::PCI_CLASS_COMMUNICATION_MULTISERIAL,  // 0x070200
+    COMMUNICATION_MODEM        = bindings::PCI_CLASS_COMMUNICATION_MODEM,        // 0x070300
+    COMMUNICATION_OTHER        = bindings::PCI_CLASS_COMMUNICATION_OTHER,        // 0x078000
+
+    SYSTEM_PIC                 = bindings::PCI_CLASS_SYSTEM_PIC,                 // 0x080000
+    SYSTEM_PIC_IOAPIC          = bindings::PCI_CLASS_SYSTEM_PIC_IOAPIC,          // 0x080010
+    SYSTEM_PIC_IOXAPIC         = bindings::PCI_CLASS_SYSTEM_PIC_IOXAPIC,         // 0x080020
+    SYSTEM_DMA                 = bindings::PCI_CLASS_SYSTEM_DMA,                 // 0x080100
+    SYSTEM_TIMER               = bindings::PCI_CLASS_SYSTEM_TIMER,               // 0x080200
+    SYSTEM_RTC                 = bindings::PCI_CLASS_SYSTEM_RTC,                 // 0x080300
+    SYSTEM_PCI_HOTPLUG         = bindings::PCI_CLASS_SYSTEM_PCI_HOTPLUG,         // 0x080400
+    SYSTEM_SDHCI               = bindings::PCI_CLASS_SYSTEM_SDHCI,               // 0x080500
+    SYSTEM_RCEC                = bindings::PCI_CLASS_SYSTEM_RCEC,                // 0x080700
+    SYSTEM_OTHER               = bindings::PCI_CLASS_SYSTEM_OTHER,               // 0x088000
+
+    INPUT_KEYBOARD             = bindings::PCI_CLASS_INPUT_KEYBOARD,             // 0x090000
+    INPUT_PEN                  = bindings::PCI_CLASS_INPUT_PEN,                  // 0x090100
+    INPUT_MOUSE                = bindings::PCI_CLASS_INPUT_MOUSE,                // 0x090200
+    INPUT_SCANNER              = bindings::PCI_CLASS_INPUT_SCANNER,              // 0x090300
+    INPUT_GAMEPORT             = bindings::PCI_CLASS_INPUT_GAMEPORT,             // 0x090400
+    INPUT_OTHER                = bindings::PCI_CLASS_INPUT_OTHER,                // 0x098000
+
+    DOCKING_GENERIC            = bindings::PCI_CLASS_DOCKING_GENERIC,            // 0x0a0000
+    DOCKING_OTHER              = bindings::PCI_CLASS_DOCKING_OTHER,              // 0x0a8000
+
+    PROCESSOR_386              = bindings::PCI_CLASS_PROCESSOR_386,              // 0x0b0000
+    PROCESSOR_486              = bindings::PCI_CLASS_PROCESSOR_486,              // 0x0b0100
+    PROCESSOR_PENTIUM          = bindings::PCI_CLASS_PROCESSOR_PENTIUM,          // 0x0b0200
+    PROCESSOR_ALPHA            = bindings::PCI_CLASS_PROCESSOR_ALPHA,            // 0x0b1000
+    PROCESSOR_POWERPC          = bindings::PCI_CLASS_PROCESSOR_POWERPC,          // 0x0b2000
+    PROCESSOR_MIPS             = bindings::PCI_CLASS_PROCESSOR_MIPS,             // 0x0b3000
+    PROCESSOR_CO               = bindings::PCI_CLASS_PROCESSOR_CO,               // 0x0b4000
+
+    SERIAL_FIREWIRE            = bindings::PCI_CLASS_SERIAL_FIREWIRE,            // 0x0c0000
+    SERIAL_FIREWIRE_OHCI       = bindings::PCI_CLASS_SERIAL_FIREWIRE_OHCI,       // 0x0c0010
+    SERIAL_ACCESS              = bindings::PCI_CLASS_SERIAL_ACCESS,              // 0x0c0100
+    SERIAL_SSA                 = bindings::PCI_CLASS_SERIAL_SSA,                 // 0x0c0200
+    SERIAL_USB_UHCI            = bindings::PCI_CLASS_SERIAL_USB_UHCI,            // 0x0c0300
+    SERIAL_USB_OHCI            = bindings::PCI_CLASS_SERIAL_USB_OHCI,            // 0x0c0310
+    SERIAL_USB_EHCI            = bindings::PCI_CLASS_SERIAL_USB_EHCI,            // 0x0c0320
+    SERIAL_USB_XHCI            = bindings::PCI_CLASS_SERIAL_USB_XHCI,            // 0x0c0330
+    SERIAL_USB_CDNS            = bindings::PCI_CLASS_SERIAL_USB_CDNS,            // 0x0c0380
+    SERIAL_USB_DEVICE          = bindings::PCI_CLASS_SERIAL_USB_DEVICE,          // 0x0c03fe
+    SERIAL_FIBER               = bindings::PCI_CLASS_SERIAL_FIBER,               // 0x0c0400
+    SERIAL_SMBUS               = bindings::PCI_CLASS_SERIAL_SMBUS,               // 0x0c0500
+    SERIAL_IPMI_SMIC           = bindings::PCI_CLASS_SERIAL_IPMI_SMIC,           // 0x0c0700
+    SERIAL_IPMI_KCS            = bindings::PCI_CLASS_SERIAL_IPMI_KCS,            // 0x0c0701
+    SERIAL_IPMI_BT             = bindings::PCI_CLASS_SERIAL_IPMI_BT,             // 0x0c0702
+
+    WIRELESS_RF_CONTROLLER     = bindings::PCI_CLASS_WIRELESS_RF_CONTROLLER,     // 0x0d1000
+    WIRELESS_WHCI              = bindings::PCI_CLASS_WIRELESS_WHCI,              // 0x0d1010
+
+    INTELLIGENT_I2O            = bindings::PCI_CLASS_INTELLIGENT_I2O,            // 0x0e0000
+
+    SATELLITE_TV               = bindings::PCI_CLASS_SATELLITE_TV,               // 0x0f0000
+    SATELLITE_AUDIO            = bindings::PCI_CLASS_SATELLITE_AUDIO,            // 0x0f0100
+    SATELLITE_VOICE            = bindings::PCI_CLASS_SATELLITE_VOICE,            // 0x0f0300
+    SATELLITE_DATA             = bindings::PCI_CLASS_SATELLITE_DATA,             // 0x0f0400
+
+    CRYPT_NETWORK              = bindings::PCI_CLASS_CRYPT_NETWORK,              // 0x100000
+    CRYPT_ENTERTAINMENT        = bindings::PCI_CLASS_CRYPT_ENTERTAINMENT,        // 0x100100
+    CRYPT_OTHER                = bindings::PCI_CLASS_CRYPT_OTHER,                // 0x108000
+
+    SP_DPIO                    = bindings::PCI_CLASS_SP_DPIO,                    // 0x110000
+    SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
+
+    ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
+
+    OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
+}
-- 
2.51.0


