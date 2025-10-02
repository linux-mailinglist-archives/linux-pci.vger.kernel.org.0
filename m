Return-Path: <linux-pci+bounces-37389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A7BB250F
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9DE16ADD3
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F254652;
	Thu,  2 Oct 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9/pJszH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19C4501A;
	Thu,  2 Oct 2025 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370421; cv=fail; b=iyXDK/kmngv45LfQtMBvDmGjxjTfH5mLthGx1VfRZBL0RngCupEhWQE3aHg4/B0sPOCOfw5NnotGX6v9ZpPUNx5S+iN+9yGHEk2/seqk7i0XPnhy8Wtx86eP/ALL/mf4dDcIG+h0C/zbX3XiGcajObFmyJDHLq0AJtwRUey/IlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370421; c=relaxed/simple;
	bh=9ti1RY4tnYGfEpxCJPPYIHzK2nGEXAwJzQ2DTN/DmW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tgLtDtt1fW9r+IzRVlX/ieHq+7uWhIhikXPvtsGsciCIEumrsV26aEQ5PVGJKG69o7TF7wYp13mBUSqRyNSFNXDF/+mZLX51V72aAEBrxLWih4xbHAK3tgnBy3KqPSOXU2YzfUEI4CTtJsi3LWUaTlp23ZSO3/HBNke/1AlQnzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9/pJszH; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZItLrjQi1ahEAbLpYtzv5bXZ4hNmWxt2rWFaPAtiVEhVZJuGWj9x6/CIIr+pMs9G/H9wQ0vkUVz6RvxKlVAH/zi5d2dWXOGl7r2oMzHrnkJ2V38ZqkU7/DjYx2ZMU4IhZAUfHosyX+oum8x5Xo7sjzOOhr7QkLRrC5KTjRMgRN13gRb9/VWFrsSTF3z4Zb7nRh6YFwsROxcr5F6qZv7LGDs5a9L1YVMrgfx6mn9JA7UdDqHGBJG6zTyqba0G/3IUEdqwn41UGeaYbnWluY958RhggYkAxW6kuryH3HcvRYOC770a1CeHQu1ph4uPouKNVf2a/tZFrTatZ/uHrOXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwfEW0YJBdcmT++kJ9/+tQzte04D/gqXK/xnobDMRQI=;
 b=GFK0NwWQ5U21Vqmx58aK2py3PtBXeDpyh+7p57yMvqWp2FkXYxUw5Nho6CKIzMXcPR4vc3azN06UBDSJRO3E9WzcWwdCKUEYC5HvERL6sfflnmhJDV84xVxSA8Zg9ftDibPrmKWSK251EwRqhWy4fcib+3OwNvql2JdRrgUWxes+Q7fy1PAjTOzvFXD1emeFNuY0lQ7v01jHPlItbmSV0SnTncJ7EdPZUI/58sHiY89i30zqzKZqkR0O4/UnTCWielqiV5BGwEg5Rr84sbTMUgFMxeuEZ5ACIpUmysb7V7FMRevAd94qGKk2IUwiRVr1xsANUTuG0YE/uPaywHzFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwfEW0YJBdcmT++kJ9/+tQzte04D/gqXK/xnobDMRQI=;
 b=i9/pJszHR4cgoL0UIQF7878M5upYpBTCPvOtiCjdkbFj6BjyP2ar9WRPDfifUsiG+ubsffVL6gd6dCKnUhRQfHGp5ESRDo12ZGpqk8Paywe8k1P7zfIiPOpjk+bZ0d388jwi/iD8AY8Hn5zluKB7Be2H0hEsKUqcS6iGEL/VIJVAi1gwYoMbziNByRaGxeZYw+XislOxk5pDyMPnv9VJlgnbvZGrhDdzge6AuB4oed7dR5rEMyrgk/GYGjhgMyRlCjj2pkEDE2pdRcIavx/CUY3IEjeBX8TPKr63Il1dwGYkxiFM+UBbIJFzg39bcKbjGh6rwlJOfYxfKvGMMdLz2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 02:00:13 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 02:00:13 +0000
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
Subject: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't support VFs
Date: Wed,  1 Oct 2025 19:00:09 -0700
Message-ID: <20251002020010.315944-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002020010.315944-1-jhubbard@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: b26fa8c5-226c-4c97-fc8f-08de01576c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKaSh+5iD+x8pn3R4ZIEi9+AkKhQUH8NHnVU2g8411SkxBYMxcPHfarLLW5D?=
 =?us-ascii?Q?AU+nhv2MOeJmhZMgKg420RH4CK8mCXeo2WX9MDxNSftcg3WwtEhwwc54Ew+0?=
 =?us-ascii?Q?oB7GJ6OpeMxWgyPA1NbJPB/tc85lkEMptSQgzsEsWWdxlkz/fYVeISCGu8Fn?=
 =?us-ascii?Q?yO3y+rJnt3wnUmLx6jx4eoFK3APPEDivu4DGgl94tJACwbDqHHzPUh+SXj8E?=
 =?us-ascii?Q?fmN80pmcZY8FPyYIF5XawkUkvI+9mdMwhYNnQ5k6MT//G4W1OWwWYV7zsFcQ?=
 =?us-ascii?Q?5oVeOAwwoxyEscIJ6cBh4YBo1byuKZMF7H3xW0oTwtDot2DVmZ4oE6waMIyK?=
 =?us-ascii?Q?SNSvGO8F3Xenvo6nY4CtpZjzxj61hzCiZ7btwXhRPfOa7KymCAGDNuz+wEPU?=
 =?us-ascii?Q?i9CIFYakp3KU6UDhEq+Go/YiSvut3h89Yn5LFGmlTnwSfr8T4118mBtuEklC?=
 =?us-ascii?Q?UFazGxoRzwB27qbntCftMKY7fSRnw7L/vEqAqsIrFlhZKESBB2wnIj4RoZlO?=
 =?us-ascii?Q?MDOk5unemHLsghIzchDKFGcx8Y+pJUgkkdk9DkJqVW/62IQOh2vlNZUuXlwA?=
 =?us-ascii?Q?9c0TXHvsuJeXs7gvRvHSF3QzyulUf/rQj9KvQGyZvAhv9aVDOszx63YPU3AK?=
 =?us-ascii?Q?8h2ISwpiH+DrzhzCaObWAeaduY5AZ/Zt+GFNo93X3YXRacNPfKj3HovyZWOw?=
 =?us-ascii?Q?oTAKLTguLJ8yq15f3ABTiYB/1gOU4bHqtDZpuNxocOI8bn4UTVb3Ju5nLXmz?=
 =?us-ascii?Q?6JaRvuDHhG4fyqMfhvNUbj4J4+7zORDdscZeGnzp1wVPzk4Sr1guYAb/XTlL?=
 =?us-ascii?Q?U4WHlcOJWcXaYy90/kiR+7bzcbvgfD25mxucLzd0KdZyaecUSQTJU+4Qr5l+?=
 =?us-ascii?Q?HeJC4ldrsvUGi6wF9BbE2wH0O5WBWXEmPI2f6auHDHm61MwB9DBH73a1b+XK?=
 =?us-ascii?Q?kEOVaV83MmEdHWQfOQ2sXL0pGcKhluRYlYzSKxpEOPfHgAiRr0AwNqSVGSPw?=
 =?us-ascii?Q?vqQKBcy+lYzKCoN4nBR1hlUae/db48KX+BAOiO7paeodTBKgVb7+utV4UT9r?=
 =?us-ascii?Q?3GD3w5GhzC8z6Xnlv7Uqm/IR9qXNDSEcWdnPBnOLfovuCmOzwQnISb9E0x1C?=
 =?us-ascii?Q?gESU2onYbYWqPqfGeOdEOlZF9iaRvHp8jq1bwtatY6rFy7e4q/adcwKSLw55?=
 =?us-ascii?Q?q4vr83lEcv+xnOI+fszEJGkJcX6Ijy0mPNmG4ndk2oNvFH4eUvuSSO7eFTfG?=
 =?us-ascii?Q?7B/g5TjPxYlJ2zcKtDNHhEqv6CL+JfqRaRIx70kzkYfcz5MzD02Dt1h2ijxt?=
 =?us-ascii?Q?QJHhHYlr8lz15lH8SZAI23lo134vosx8iGw0x0wABl+3fPKjIjTV+A49WCIt?=
 =?us-ascii?Q?l+MDP9ZCTAZ6zrQUiuWlkv+EUL40zkZtDPgCi0N3CyTNiKCQBW6O5rglZywv?=
 =?us-ascii?Q?IkMI3LAbihWsekr7XzAqdt3R1iX9+SAG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kx49t+/kch77OBZrZtRwNdZF9sIxAixv2Bd6upfM4kyx3wpxN6MkY3CzYnEO?=
 =?us-ascii?Q?a7E/49kpSnxQz7kvlLMSZJOsddzE3gslWtS3PIpWLAoyyAQqkIosk1w7CXdO?=
 =?us-ascii?Q?1r2dxw2VqwguOwdLn8+skN2DctV07WXp8wXBF/t4elLkMk6LA6qBJ10pvayi?=
 =?us-ascii?Q?1Ftqg+2PjmEmBblsG5NntiV8R9kh0WszfnR462YFZjtN+bjiVxEFGdDMCSg7?=
 =?us-ascii?Q?QjC6nmiJmZVUj32Skx5OqIldfftKTyNBH0Eof5/tduc7LH5rWy9kUowwsn8S?=
 =?us-ascii?Q?fK5C3L1lCcRC0Sj59K0Opra/XJUKaVGMRV1iJMHxnlx/ELbO8oGZGoWlieEz?=
 =?us-ascii?Q?C3KA52343LHAE0hiCbPqWluKt3QEYnMH3BzcpBOxznxnbdD/TBZTf8RbwwWh?=
 =?us-ascii?Q?+5JyyG5M2kjX64MnGmeQgNIJySpuiSAM1bLi/6i865REtOlk3+LEAsajlJbt?=
 =?us-ascii?Q?Icm2pAZxViAqB2kdazoVvgC/FHUTPqChPCJOgfQt/FW/9Tzp5xrKIhJ8utQH?=
 =?us-ascii?Q?H+nqmnH8WbSkOumBebneCxHLbj3uHDxo6wp6EGdmbSoTTMfcXoTc2h8KHllo?=
 =?us-ascii?Q?kThnGPJPvi6vedAgc4L2PjZXQyil/DlLyVPBLJNpbZRegO8KVkzMY1Wz72Yf?=
 =?us-ascii?Q?REYdaEl5HRzl1kGEmc/WvMFC7Cw6gq0jKP9fykfbROVhymHgBV7qiv9RX/wv?=
 =?us-ascii?Q?en2K59r0xNJmc0+A+FSV3Yxkx+LeDoKuhPO6rs/PtJMaYu21GA2I5+tySNzD?=
 =?us-ascii?Q?nRaQhiGOzr+dvumKovyZX26RybSQ16ZbJl2Ye4O3qOjTskXlIAw9UstbqwnB?=
 =?us-ascii?Q?PlXFeOoT5ZfT7aZZKZUVebOnrjwsWP1kP88QtE2J2Nov/2Tww1jX4WVziZji?=
 =?us-ascii?Q?rVH1iFoUMVpQCmOXULTbX6ouCbNhKtsbo5V+OKIMJ3QcPrsFUZpzIw2trpQE?=
 =?us-ascii?Q?ZV/QqP/ZISOt9toVrtK2h98KMWe/9YRi6mPJwkF9Vw1L8Yoj83BDuJmc2tj/?=
 =?us-ascii?Q?ixNohMubkk1UouvU+lu2XzxLxMd2TW7kNo/ogOmbGiGwU6hVpOrOUv+pIxLF?=
 =?us-ascii?Q?LjnbHTjIkRCbCELHh6pTNDXGgbJLjKPOcNMz3UwvFkWuQ13pA1RSZbLKzI5S?=
 =?us-ascii?Q?sW+NWa/E3rZf6eIRKxyHCM6KnGO8a9L7F1Dk8AA0XUj+N/vTl5P8PCLyC4R7?=
 =?us-ascii?Q?F9PhjvdUH8yvfv21eLRz//+TvCEvSQgIGSJJ+91ChTuIYzhbimarDVhjrbaG?=
 =?us-ascii?Q?g5uNzNRqCY7mxKiKzFeqWXbkpJylHxkG6MVy1UeawgDvbccxo/OiKmS733zk?=
 =?us-ascii?Q?64w05zXQ29k8MDNVc4EXi6H4jkc1llyicQv9vhVejP6WjIpff9JLJd3apV9u?=
 =?us-ascii?Q?eGSRTFyvqXm5J2UXkaMKxC0xzOlZlMNKhd6Vh3iNMKma+BVL4DxThNG/BRQN?=
 =?us-ascii?Q?S4vut2qgPAB68MoMMHbCDYF0uFIbcjL8cxCNVItqoDr4oLQ0LT/tcFDQXEai?=
 =?us-ascii?Q?43rhJ7VhFg3y2JSxJ1whUAwQAMVr23o4qaRWKXGCJvWYUtQCArqyZr9qurlV?=
 =?us-ascii?Q?wLj2OytXgF7o3iQQV64vVj9XHdJrNPp9OLNaivVt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26fa8c5-226c-4c97-fc8f-08de01576c62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 02:00:12.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FELov16ZFGWAumCMZaeoAVKaZB9wN3abN+bfCXfTHA/gTyV1DWlXcaed6n3lgZ8dfeLEjAyE9M5Qr4vhSbjRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

Add a "supports_vf" flag to struct pci_driver to let drivers declare
Virtual Function (VF) support. If a driver does not support VFs, then
the PCI driver core will not probe() any VFs for that driver's devices.

On the Rust side, add a const "SUPPORTS_VF" Driver trait, defaulting to
false: drivers must explicitly opt into VF support.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/pci/pci-driver.c | 3 +++
 include/linux/pci.h      | 1 +
 rust/kernel/pci.rs       | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 63665240ae87..588666cc7254 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -412,6 +412,9 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	if (drv->probe) {
 		error = -ENODEV;
 
+		if (pci_dev->is_virtfn && !drv->supports_vf)
+			return error;
+
 		id = pci_match_device(drv, pci_dev);
 		if (id)
 			error = pci_call_probe(drv, pci_dev, id);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..92510886a086 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -983,6 +983,7 @@ struct pci_driver {
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
 	bool driver_managed_dma;
+	bool supports_vf;	/* Will bind to Virtual Functions */
 };
 
 #define to_pci_driver(__drv)	\
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..c5d036770e65 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -47,6 +47,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).supports_vf = T::SUPPORTS_VF;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -268,6 +269,9 @@ pub trait Driver: Send {
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
+    /// Whether the driver supports Virtual Functions.
+    const SUPPORTS_VF: bool = false;
+
     /// PCI driver probe.
     ///
     /// Called when a new pci device is added or discovered. Implementers should
-- 
2.51.0


