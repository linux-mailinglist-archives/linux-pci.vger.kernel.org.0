Return-Path: <linux-pci+bounces-37388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A040BB2509
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 04:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA893A6FC5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AAA78F2B;
	Thu,  2 Oct 2025 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gCcg0YmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1E54652;
	Thu,  2 Oct 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370416; cv=fail; b=EJ7tqI0MSuc7b1vTntOHsFiMQFGf0oBkI0en8ZBcZcYzDb9c32zV1iHp6WO7LRzKY7NlvEMwpP1IHJNo8EXRBACVoKz6b/zuq99uF+FhhOB8el0tpwR1/OF/bVzGybaY7ZfJGIWSSKj7HC/OZmatz0cVRzsw51CyJQzN3MT1np0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370416; c=relaxed/simple;
	bh=BuoCFVA29z0TMKQ/8GCIMf3OoNDZnyVHuWmbE/CYOqs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q0gusWSDQeTLH0FnmfK8Cn0ovnSAcu6JkWn7mX0+8cUNEaT0UQmkd+hPCqirNqu+q8N0gRKC3Qz8/eHD7aN9KBHKybCJXqjsX6WqYW2Ccg83b4eu8ETQWsLciJwTddNb0dCHXUyPis4chGmt+bF7uPOtyNNbnnIbJVrvt/L2IKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gCcg0YmS; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnLfp4Y3Z9UDL3p1cTwF3VBp334PfOzWgHTPJVTZLQyHLvxz/z3uOumNkLKpZSt1p8jJd2vPWU7RqhT6lizuBNRrGX9MiUr5lFLeZkWmPJ7aIRsIh2rj/dXgMyNcSKYCdh+01uxvVrHKLmIzWt2Et2jxcb9Tw5fZ+kAJGHrvkAyLyYxpcqUoJIJ+rphUTIw7LUkGzLRomoxdcSUTWPAPsgxL7vUbdQsgym8X/uz6fgrCbxfka4lkLZilGONk36aPIWyolcyok1ONHFjpXR09CYKLIXqzXfcXRThyyg38xOZA1Ur6QnBlAdH0GF46Pivi+Vt9IIb6H58UxPzvLjEO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9gefMZBqYzzLw5ba5XIUapNiYoYyHVJLQjdlTL3XVE=;
 b=nvs6za0SB7KTMOTqjHBmzG3qk3342/tOJZWuHXCwkTR1nDMKUEBnl10j2iUxmIWr2b0G5Do4PnPAHvTruuaDFzqEP34oehTZRyPEVs+R1Jat9+eJFVnFEwZQuvApSn9gjUTAMnqEDp//N3kP+s8ms1Q/cAvvH6sdas1IHVUmYxJsj/crXu0DvP9bBSQdELO7UNs2VT7kjMkD2VIzPK/38Z1mzkNsfSw3IDY5KFWaxhGNgSZHGTd/+nHOjaUhA1A0XST4gPdx15ENrBGsJDLoFU1ljS1/v++pSgN8zUBxrNN+WnBeZKU1Ci/uux5NcpGKWXBxGgNGw60lV7nlyOl+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9gefMZBqYzzLw5ba5XIUapNiYoYyHVJLQjdlTL3XVE=;
 b=gCcg0YmSfWjCYncS3qE+T+eEIGgNe5LIDBpnH6Rf9y86C2gKVGdJz/CtGWDl8GxcRiPcc43VX2NF/txDxe8OQmifx5P4FmPAYSX633Z/GV/KACT1cM5nr+bMIBqPRsRroE0v7LG7b6d7y+IUJwTixspACQfgWnJxgTuq/ikGYt9XazeWRbnH/pdVAtk2YUAyNTNNRYK5D8bMCSPE4hUVZaatZgbR1FxiHEYzjnS+7bx+cPgR4KYsUL5EMUlwqLKaRUNLXLlU4utRrxWexh6c3bGmbxdwYduyEGdvDoeGsnrk2aFgwkRf1paBQ41aVamxPVY8KycjXR/urTcx/F7YpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 02:00:12 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 02:00:12 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH v2 0/2] rust: pci: don't probe() VFs in nova-core
Date: Wed,  1 Oct 2025 19:00:08 -0700
Message-ID: <20251002020010.315944-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 116be443-cde7-4dcd-16d1-08de01576bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rX1OPcoLp4UxdWbjv8VRlSOML+m8nTSv7ZoXX+yNu1MwhTMAHLrMeXaYYX6g?=
 =?us-ascii?Q?VclI0DYYuqiMsg/lsbYS6/s7BKjAEoxSMJCoRnkkyQx/+G74LtMhroDMcGpz?=
 =?us-ascii?Q?bEBVkI1pq9QVUnVIAy1kVjFsMATqOlvrzWlZQzr/lqB/qUrRJtKtyrcciWp6?=
 =?us-ascii?Q?FKSNJSula7qXuFMrvPW10luR5dlE1Skz291PVI8Icovhma4hYhTTYBEOOOgW?=
 =?us-ascii?Q?uhMrc6IOT4vgSdhDfrh/ZE265TFkOji3bx5iORAs8SsOBB2vSpRItFA3kmsq?=
 =?us-ascii?Q?srAGXdAZCKKmOr/AW/tXpTzVI+sKSTRoLnxPwd7kSrQpNOF3o6776zz61R39?=
 =?us-ascii?Q?CcXMPwPn33T/25pbvlsg74quGT5PXiK5K+Dyriok1j8o3wHIxbD3xCAPU8c3?=
 =?us-ascii?Q?uP8Lo3jPEp7Ast2gq/n76pkUHsKnRWdun/zqaNkNdbbmuSJIVF4veXGIQu1s?=
 =?us-ascii?Q?fAnGos38mDQ00zLAVlEUZ/ADxQ1xuuFcv+Op1CgkplbMKLQQ/z6pjJZor6tv?=
 =?us-ascii?Q?L8i8YqWNq46hlvIf/EsVPYRHO2HoyeC2Xp3ISKYgU2fcEUzXdaYnVa+Y+198?=
 =?us-ascii?Q?KV7ZPHaCaeqgRVQYsWDmDawR91LSKbi4itRQ363UpCCZ46MwxDSTHPRT0dEO?=
 =?us-ascii?Q?OY6w/NggvYFbA5x+oIGGwbIP7JUFDoRmJon3OE9KKQ5DyfKjjRWDZlxsPIoh?=
 =?us-ascii?Q?4wZncroMFDG9F9UEbpzSpMcI6334MitD+dktxBkn6uzYWax+LHFyrRmRWu6U?=
 =?us-ascii?Q?ht3Vh6kyWNUOBagN4Q3Mc+UzcCivsKHunvpAZYXZbCUUA8+rYpffb/eDaIJS?=
 =?us-ascii?Q?PntuOFhURQaaeNKeJ131StuR7EqMs3i8WSSul01y/rzYzL4/RxSydSHsMDQa?=
 =?us-ascii?Q?7YS3DZBOseZlIaplIgWGcj0Px+BSnT7sIifMaoUvNBWPfCodwtQ9dPSHUD7r?=
 =?us-ascii?Q?xtTw0/zFoJ5SmmkQT1eDAn+h1cgr5yKR6YPY5t7cz8aXrwJm3s4ukrt3SGF1?=
 =?us-ascii?Q?duGuhmXgc/th/a3a2K+kicJjNSy9Kv1hh/I8GRMroTwFR7EoBAOdnBYzZh2l?=
 =?us-ascii?Q?aardDqaOmsYgLg8a8MOCoIOBXTGok19S9f5CQLRip7n6m9Pc0Qq69cWc+VVn?=
 =?us-ascii?Q?tX6BaWEDfhydnwBF0gFEMjP/MTgc7ezUP3oTWCCTa3BCFsydRhS3qjD+qkId?=
 =?us-ascii?Q?pftN7v29S6b/U4xvzi1SXwtB5r6T/Bub3K6EhNwK84sjGNlgYRZyGkkL4PGE?=
 =?us-ascii?Q?ItqHOC8hrqIgH/eSFj2dIHDRmLlj/ugq3qiVGICzQw5AkNuv54AJMbw7RBdT?=
 =?us-ascii?Q?kuC3cIIAg5uZCQ4GTQAroln11fflKQD3tU6ypdEMybb3+JHy4zcbMfarDrBs?=
 =?us-ascii?Q?edGS/2Isq4X7LkbRIJFYq+2c8njoyn4mTGtgHM7nD0xq51Bhp+0DPFyv/ObV?=
 =?us-ascii?Q?4oApinrb5Xb5hcVb9ZIDWn3hSvUbEIdLBIaILcxZFs+K69tahjm5hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORQwzOmal1cJzXtBfHwfJ5AADc3JVxb0WOhZEm8wHpjQtjS2xgp/RvbR9xZC?=
 =?us-ascii?Q?fegrXLw9aIBCP/7TSsdQ+irHm12jkEpfaLmN4z29VAD899qEVamXa7abmhwc?=
 =?us-ascii?Q?ynzfgc0jPLjEudaIE4fhutpVC+3W2QAa2JnZItn7aXs8sVWCSbF5115YZ4lK?=
 =?us-ascii?Q?6F01b6R4/HioeNfRqN8N89RU6H4V/f8tZmajomDrlKx9T311MCvN19/K4D2y?=
 =?us-ascii?Q?OLXr9wlSUj3f7ZEY3G0WiCb4azfEN+cYQAuWPh47d1ANUVuYS8g4S+Ur4p2m?=
 =?us-ascii?Q?bs3sCeWjpYnzto31YQhcMOfl9aodVZv8rtQZD0rIOkdYoFurcDb5goUbMJV7?=
 =?us-ascii?Q?x8rzCz89M0cHVNBUZ+nMPF1wc+GYE0fJIbUYEuG0MfeHzX/WDzEW+kaYiW8R?=
 =?us-ascii?Q?BYyoX6DJio85dpWm715Ljhq6Ru9Z5XCfX2fwZe7cdea/5ufvZYqWkRPz0pXH?=
 =?us-ascii?Q?swWhB8fUbDYpFnoSkBYknzB70Tie9v9lbLj1tf0eHIfYnos2u/T8IkaE8LEC?=
 =?us-ascii?Q?9UJg+xA2cTQpex8wzhlrtlZiUwB4cAl2R+tYsWCzJ+0QbD+XHL219ffPUkNj?=
 =?us-ascii?Q?+Td2rCJsJBLVCLNv+/x5zdEV/B0YWzBbyX/W5szRxtVHsEg0AS8PaEniBNmO?=
 =?us-ascii?Q?Nk+5gl/1RmLReIH6HPDe48tU4CsmMzgKil3I//xQVIHW4Vw4/njV5ATPDV0a?=
 =?us-ascii?Q?JxbikRsmSBFBGN0aXgeGyvmiZgq3b8dA24Nj4tZ63RIBtWhyXWsZv07HC9NX?=
 =?us-ascii?Q?ZkeYNyly0znMqnnQMn9LE1nZrd9uCpz2Y9VWlzPr8UFjdZGyl58HDm9+Be5p?=
 =?us-ascii?Q?rWsvsLmDVk8lRDlUOSPdPgliwufnKHE5g3KtJKTsfl9IO4WVFOUmIu/fnqfh?=
 =?us-ascii?Q?e1iesxOCtmbPIayrzVJhRVeLpSgO8bGNyldQT25equNyipcpsnMH/64FSFcZ?=
 =?us-ascii?Q?uH5VmiW/XCNw0ErYbnb4EUs6Jps9UT51fi63+tGlpN35f+HvmdY3mVuPL4JA?=
 =?us-ascii?Q?tBU7z5Lkz1p9s6Msj6wDf3rJCV027FPcB4vgsX7+J+4gP0bDhtDPGYIYQmiU?=
 =?us-ascii?Q?djeF6N4Eurue0FWMPdGKApQyW+k8jfVRiP+NrD8E3eSi2yVxtQocbBUoLaTS?=
 =?us-ascii?Q?ciRr3VkVDAR7lt0n5gsYjwk9t4dQNeujuQKg5bE0KC6GjEpiWaoERehyaAGL?=
 =?us-ascii?Q?bremiVwVwotmPR7zXpiwRx53Uleo8jCt+1vn9DzEXDE6+bpxL09wvNiPDMiM?=
 =?us-ascii?Q?jUu6LbSj8TcZiXyciqTxNFYg9R3UEgQxKMVw0xHALjDf+XMCwwdms/lQTg2J?=
 =?us-ascii?Q?r0iaXptCuQVNpGmGIL4edPDTC/9q+minZaIe6oELfNCXoX94Bx3YYy1sJx6P?=
 =?us-ascii?Q?9gHyr9T8dcQm1pXTXZDB9gUQPvV5SCyBZmjppCLPc0Kew4Lxr6H9FnpbtMJ2?=
 =?us-ascii?Q?5+34lpgaR9aYlEmdvEBsPrbe4DMhy8BAu2ibHv115cfO5S3lKnNN1ZcOOCty?=
 =?us-ascii?Q?Ta/+JOK2zH1P0L7/234K6YVRXpQyTx1WiV5r2hbsdWzJZcPNseN7QPZSHYlN?=
 =?us-ascii?Q?RGy7kmHCvsyZhur3ynCC+12ojyLNN/NeiYo/m/mM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116be443-cde7-4dcd-16d1-08de01576bed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 02:00:11.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4603w7AQXWZVU0482WP9LmT6ld0zbyumr/woez/fAXi4u4Q/8K2XWRucwz9MhLGeJPXRdOFSaw3dOlkIXKIlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

Changes in v2:

1) Completely rewrote the series, using Danilo's suggested approach of
"driver supports VF probing or not": the PCI driver core will skip
probing any device's VFs if the driver has coded itself as "not
supporting VFs".

2) Included Joel's clarification, as a comment in the code, about what
happens if VFs are probed.

As with v1 [1], I've based this on top of today's driver-core-next [2],
because the first patch belongs there, and the second patch applies
cleanly to either driver-core-next or drm-rust-next. So this seems like
the easiest to work with.

[1]] https://lore.kernel.org/20250930220759.288528-1-jhubbard@nvidia.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>

John Hubbard (2):
  rust: pci: skip probing VFs if driver doesn't support VFs
  gpu: nova-core: declare that VFs are not (yet) supported

 drivers/gpu/nova-core/driver.rs | 5 +++++
 drivers/pci/pci-driver.c        | 3 +++
 include/linux/pci.h             | 1 +
 rust/kernel/pci.rs              | 4 ++++
 4 files changed, 13 insertions(+)


base-commit: 6d97171ac6585de698df019b0bfea3f123fd8385
-- 
2.51.0


