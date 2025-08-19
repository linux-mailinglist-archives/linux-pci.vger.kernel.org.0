Return-Path: <linux-pci+bounces-34234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1923B2B76C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D8E7AF8E4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662372D24A8;
	Tue, 19 Aug 2025 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxGnYtnk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4A2D248A;
	Tue, 19 Aug 2025 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573087; cv=fail; b=Ot6mEIVtsW+pQXNELpJ19eMfL91V7UN7lJL7himLFmZ+4n+vrQSsa1n6CTAmUjGchMvjp705PGz0FudUMgWCohc48nD0ga6d4KnCTSSV9A3Ou+VomA9G2lEUELx+Z0xtiI9zSnUNk591xVRfWFgQcpGfAgJQn1JI3HRVwQgYlhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573087; c=relaxed/simple;
	bh=L2nhXSi0CAfUxiUrMwksaL+FEqAuOY4UPXgqhOPFmNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFfUsEN59a4lDnVK3P98PSY9J0kqbwOjjJeuLsSz+vE/a9yUtpAoqWZc3J59Jf3rFPAJmZJdiEn89SQPeIjBDz+ym0CBW9VuWdFbf5QRj+pPAaOOf/RABr8jiu7YLCHnm6Udgi7Qf+jW0BXtB6iMN39ruuQcGBKJ2jzNN1Q7X8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxGnYtnk; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhz5oCzMXXHalkZfMoc5aPIF2F7KuSK8RVwkSAx+h4YIv7w74/V6oMqFNjQEh0+PfEt/EKLJbxzpicDaRy+IIs2Hw6rT7I9mKFMcWnNLNfBRjJy68A6wnm18OSPcA4Q9G1C68aH5Kv87gCuUE4ZwAmmbEwFTbqh/Osk6wtwEHDfySK1BniSWByVo6Nzev1aHkr2bW8/6TdJmTymtDl57U7x8trS5vp3A+9K96EbZktttlAjgHl+Zg2CU9X+MK58qgBI9QuQQAB2lswgDT64u+E0u2qbKLmKfXXQwOyLZEQvFPlxXnLhDUFB8wpOXWHUVqY+3oiAP9zTJFnZ3+eeYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZswuQFjN6EDvVAgxZX/+T6WhsK+dqNsL3GwLWwktgI=;
 b=idIIyJ+v5kYKLCTtdI70z2pPQ+EKp83lssoesgmaxVWmlaNI+BPCROQgakNEq/sn8fBr2c0ZZzAwRM7PnPgA+7t7i8E3+YYExpsXxZb00taEhmrXqgppmXyuQvEzK+di29xPdf4o+kiAuSExyvLwe2Lk8NOhkEMWWOVvOG4T8SH/WjAqiSbXiH7Rn5/4ur6Dq2YilpHof2Psqp4DhUTewXhpeUavRKxK+sfeWfBuREPaT9fehxMsikkMOd7Ru4xHWq3kXLsmi+23kJfsJ5Yuza34pkWFVH5zi5Gpcrmucn2uYmKToKCKJLoZNoPWnrcg/Zgd87ESK/26eBSV65jb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZswuQFjN6EDvVAgxZX/+T6WhsK+dqNsL3GwLWwktgI=;
 b=jxGnYtnkcE1pMvKcJvQAymnYxx6KO4eNuBj62PWDEDkUFcFj+4h1abFawZovndDz5Kr07sZYcAasMc4x+FbYUPEM+wXBSCh0uqvCi3Q36zKcAaQHIvuvTLF/hfHX66aYIpp9JIBlSREEtxm4od45xJevaxQloBDb77jGzt9sb6O0ZVNPiDhJrL2Tt0wZY/DuWJjZ+NvpecSb/WNTNPRZZryHAoGeNGUJt3fTcvykEFl7PCWrum7kTHejdTnZcTdaliW+8R8Hs0LImO/gNO59XzzALZpXDNAUpQm7h8ydgZ2mvCT/Ae9qnm9IkHBZOp9szugP0sFWegU5A01LfkfGOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 03:11:22 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 03:11:22 +0000
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
Subject: [PATCH v3 1/3] rust: pci: provide access to PCI Class, subclass, implementation values
Date: Mon, 18 Aug 2025 20:11:15 -0700
Message-ID: <20250819031117.560568-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819031117.560568-1-jhubbard@nvidia.com>
References: <20250819031117.560568-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 957016d8-565f-4a95-c35e-08dddece12ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9gix0LSJUH/lhH8SZN/Qtb3a7krlRJrvEzHkMPw3JPL2kX+Inw/HGzb72uKQ?=
 =?us-ascii?Q?xlP92AV2s9BLYZ7Te+IPbKLOzJvA8tLoy7S7jS4FQVd8USc6vGcZzUV87KK8?=
 =?us-ascii?Q?sE4IS2YSjxarB9/IH+aYk/CoMJFjdPZguBc2or8tiK/00qoveoAXxAh37cKz?=
 =?us-ascii?Q?Tf+Y8XBL+tJ1y1fwI9c0cbvEv7p/GAL6VVpG+fMoS5W0p1swKwoT38LyqxcJ?=
 =?us-ascii?Q?+pzw/bg/mAaEc68AnrW8HDeY1JwI2LWlwaJcxj0XZj38gXSQWp1GwCV7F0z3?=
 =?us-ascii?Q?9g+O0+XJ6HUi/Ca5693RO4Irz/2xmG/60/sNcWc9PJFtddIct5NSxlCOKxBa?=
 =?us-ascii?Q?HYGquLWLo8jtN6eLbaBQRNOI2GIRthTxTmmcn59Me+Yj63phBF1yUMul4jz+?=
 =?us-ascii?Q?H11MCX9itdAxhIRkuXeHAdk2M8EjBHq0f2sLvIxXNZCjlfxpuoBcNtAuRwwC?=
 =?us-ascii?Q?s1eZst8fWeTcba8PP+0E3zSzdSrEh3JSUEIb3A9Pjf9hXo5/X6twwDfYMqoY?=
 =?us-ascii?Q?nibbQ5WPeLNjWN7vSOsnxYlaj85gU2ZjGBEUHlhn7kxRWhemgCTAPWcasPzB?=
 =?us-ascii?Q?OmV44fNvU2NWYhv/iTusmJLZu5vUAi7qu9UH+2ydPzOlvXf+iERTs2iCZkqW?=
 =?us-ascii?Q?eXBkndn4a2aCUQVCyUqk6eF1MBccno1r5l9Prls9WNcOy5PpQPH9Z62cbK46?=
 =?us-ascii?Q?ylbVose0Q2GLujhOqWuPbdTmA8cp86vm442yFXl8WLcZaMaqHeeWfG29igNw?=
 =?us-ascii?Q?FYm8JHVl68164I16IYKvxceqBCNFS4eLHW/dAyFiXaHxZ/gE7q29jUiUv9AH?=
 =?us-ascii?Q?sjHdaotZMklXPe0alj0Fd1cQVVvrKhQLuqJkbXfdjDP5DQmTYEmdcDA2BEyC?=
 =?us-ascii?Q?itsF+SBZ0MzX75PrqJ1L8pYW4Wfu6v841vxJTifuG9J7o1iPxMv0vleg08P6?=
 =?us-ascii?Q?yo7vVYis2vni9TqBnuvRVKxrBNrMNwrnn8Qm+ANv/QzqNitJh20MjtbEEenK?=
 =?us-ascii?Q?sKp0kYfoGB1shn9E+HaWwhfNQFvg3ueBKxApkLfb+crQncjrRKOS+jrC1fZZ?=
 =?us-ascii?Q?XYKGrrcZk4Uh2gwKfRFdKUz21Maclz2JRBpi6OddS/iN6Y9SPXNqJaX15jMQ?=
 =?us-ascii?Q?3Kt95IQaz1boByND7C/1ynfsmnNW8ueT92eJOpmiKaTBdyV9GkWl9F/+QyGP?=
 =?us-ascii?Q?qnFzs89V0kcTKCkmohoTY/RdFIE3eYA8LMPzmsPKfujjvSpBneuwYshzo5GY?=
 =?us-ascii?Q?nvmLSAyvXCiQkI8XQc3AF2T6qfee7lCWL2AzIx1kxSAOz2WozQBFRiCHWEyZ?=
 =?us-ascii?Q?rA59d01TqWW+2F2NuPpqKNtM3jQ4kL18GyMb7PHgc8x0OKLnzHn0N/WKnG8L?=
 =?us-ascii?Q?rA3cYDyOQCDOr8L1RPnp2NbuFgO0/sDXIEr8Ttnd+Kp5RSt1yjJnW/0gZEUj?=
 =?us-ascii?Q?1zHSQG4zEQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYhxkGS8TC1v+v1JgXspZbnLUzwFVU4MXJCdI7O2ApfvPvNg0Gv9UeHT9G/i?=
 =?us-ascii?Q?Tp06p6o817bS+cGBfeYn/vDtdVXZ+P+L1PQJPkjAnQ9lcRYa1J5UBxtQoUBc?=
 =?us-ascii?Q?tpnslK4i4pMOapOU6hie2F4AYpF8anxrUPHqhOOBaBPG4RWuOdZnNA1VyI/g?=
 =?us-ascii?Q?YogG6L7tm+TtSBetZQz6gCGGHxn7GjoJbnfdBxhrtMvXdatSkMiweIV/+smu?=
 =?us-ascii?Q?gtsltayiLoQD5jLIr/TTXzr/X5xht0CFX4XRoclyX/rUghhFquttpf39Yf9t?=
 =?us-ascii?Q?l2wR/fIVG+6gwnqejgh1cvWF4A9L27gsy98Pb+UYyTRIwfniASlRrnoPqD8F?=
 =?us-ascii?Q?l4Aie8AkyIuGjbaluuMzKIzVsGrfAY/cZO2ydudVgJz/ITTCT4apLlh1axQ1?=
 =?us-ascii?Q?8KvBSyXZJLhJlqcMkgNrXa7fijPy31+aLRLKbjn+bVxq39Lta5B+v6RgsEpP?=
 =?us-ascii?Q?I2Gg0Ub6eX9bzROh2CR56/20aO/uIjw6qolvRUPezTcYCuOqLdGKGvV5nsyQ?=
 =?us-ascii?Q?do1uSHSGb+qloi9m/35lwtwdz4lW4ow3N2VZfMPmCZgQ0cTEYo2B/oKisys1?=
 =?us-ascii?Q?ZJKD797Q/9bx1KxwnXllh9Yhe6xyvOVwDLYfq+Hi9xZxD6cuwfmICOPDpvYo?=
 =?us-ascii?Q?me0bo/Ji/Vpki+SKtXjn7m5S/zDjnhm99mRdSsM2pS11brtF4oOi4km8DckJ?=
 =?us-ascii?Q?1u4FLV8YgGn9w3DVbLx6jUIAEGbNQfjynVZ4oYCAyXdNg/0yPJTz12XLC5+F?=
 =?us-ascii?Q?s1PQxt5Jjakm3BOGIvG+lNvVb23djw1nXOpwOMYRWv1YipRmGpfVSiXoLHTF?=
 =?us-ascii?Q?BtP7FAHI2HoaqkgjtMg28GOls+LwZo/2O19WbX7euYueRV8NStKu08j2+BKU?=
 =?us-ascii?Q?tzHon7XF8JsNXEa5dwa1OTLYyNtxUcdA6MkNX03525dMX2dqQvknS5UFc0Y6?=
 =?us-ascii?Q?wJ7Rl6ihHLIUsg1E4iHkxyONEIPwtKosIsHFLgOflJp8C2pQl/v7c+cPdvll?=
 =?us-ascii?Q?Lq9rIQoJudJFKsSvi4NqhDO3/o+YCTjZ9dEyNFJv+GzxApSE2ycyI4IFAUYH?=
 =?us-ascii?Q?XWKqN90jTAf9t6sKwdpoqi1PzCM/VTGtnY/XlFwmeB5UY7uHJu69nAKxiigt?=
 =?us-ascii?Q?uh40Zg4Ud9qJn09sMy0VNa8t9O0wTlIqTulVQ79hvYDf2Wj9SEjorAPRWbRS?=
 =?us-ascii?Q?bunOytLUehlgPmSBZ6YVf7OYpVDX8te15cDtF1SaGW/XVjgr6briSmp0Amfj?=
 =?us-ascii?Q?vcKVWyOES71R7C/EQ3OJ3Hz3h7iLHlqxVtXEnxUIVRqiNGw6L5aIl+EWHpJE?=
 =?us-ascii?Q?JOznC1JFRj9jfoTUOgBPVtBQn+kQLT8a68US+VVxoshwE7joC3E4ywWK0vfJ?=
 =?us-ascii?Q?6/3LgS5BmgqH937i+kGUCt71an8Id3UNz/Lt+xYD6MolE3d6ypHpZYuauqUF?=
 =?us-ascii?Q?CgHJhH9VE6VSQ6VA6eEp7jSaQSKPexCUbjtU8a/dOBjKUvxN5VTHtbzot6DD?=
 =?us-ascii?Q?O1v1A3BnABeoEXQLnC6CCtrFaKBQzFBkGtvu9R1rM2PsVnsR3xsMpMb06q3N?=
 =?us-ascii?Q?WEEBcsnBVOK6fe/Fja9fR5E23KrY2RSUZ+aaYxgl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957016d8-565f-4a95-c35e-08dddece12ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:11:21.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hsx9cmTTUafWsCjwdrlL9ArpIdDN0OmzcGQy9BPLWTNW1DFGBmGMklzoPtjvEQ/ysyfam9A6tWCjpBPFQu74yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::as_u32()
    Class: TryFrom<u32> for Class
    Class::MASK_FULL, MASK_CLASS_SUBCLASS
    DeviceId::from_class_and_vendor()
    Device::pci_class_code_raw(), pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 227 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..bd34b1a54ecc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,6 +23,204 @@
 };
 use kernel::prelude::*;
 
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
+///         "Detected PCI class: (0x{:06x})\n",
+///         pci_class.as_u32()
+///     );
+///     Ok(())
+/// }
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Class(u32);
+
+macro_rules! define_all_pci_classes {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+
+        impl Class {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self(Self::to_24bit_class($binding));
+            )+
+        }
+
+        /// Try to convert a raw 24-bit class code value to a `Class`.
+        /// Returns `ENODEV` if the value doesn't match any known PCI Class code.
+        impl TryFrom<u32> for Class {
+            type Error = Error;
+
+            fn try_from(value: u32) -> Result<Self, Self::Error> {
+                match value {
+                    $(x if x == Self::$variant.0 => Ok(Self::$variant),)+
+                    _ => Err(ENODEV),
+                }
+            }
+        }
+    };
+}
+
+impl Class {
+    /// Match the full class code.
+    pub const MASK_FULL: u32 = 0xffffff;
+
+    /// Match the upper 16 bits of the class code (base class and subclass only).
+    pub const MASK_CLASS_SUBCLASS: u32 = 0xffff00;
+
+    /// Get the raw 24-bit class code value.
+    pub const fn as_u32(self) -> u32 {
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
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -157,6 +355,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
+        Self(bindings::pci_device_id {
+            vendor,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: class.as_u32(),
+            class_mask,
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
 }
 
 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
@@ -410,6 +625,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the full 24-bit PCI class code as stored in hardware.
+    /// This includes base class, subclass, and programming interface.
+    pub fn pci_class_code_raw(&self) -> u32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).class }
+    }
+
+    /// Returns the PCI class as a `Class` struct.
+    pub fn pci_class(&self) -> Class {
+        Class(self.pci_class_code_raw())
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.50.1


