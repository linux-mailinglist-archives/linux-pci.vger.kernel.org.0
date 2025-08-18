Return-Path: <linux-pci+bounces-34147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF88B29648
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 03:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2224E3F29
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5212343C0;
	Mon, 18 Aug 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YC5KdXPz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353B22F386;
	Mon, 18 Aug 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480796; cv=fail; b=olqy0G3/esncQ2/SwhMV9nYplyFuRbUWNa3sPACAORJK19n69sjtZXztxTglnWoAGt3QwPU1L4uC/scd+RB5BlSphjCXuPGBiTDivSsOwtUNJzRA7xha7uTvvo9El00Ia5rKTQNeqq4zCrmQ373tiGuKY6T2P6+Rye+kkuseGzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480796; c=relaxed/simple;
	bh=/U2qljAWmaCq9oda63/+OkeOx+82bEKrjMGAg27p3lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNVOOIrdBbckdmbhm2VHKncMinRLhVXGE1zgVqC2dm4CtqSeVDezQhjkMcPRD2vd2EdEAJ6hJPkuLlsKKNyz0yJufkD9gL38L0/SVJAg6niDzI9mJ4XT5zJvD8wqx4b9P+B8a5IT1mQwhu4YenbGok12kWlK9bOZe5ozSkSqCKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YC5KdXPz; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN/Go+ol90BY1XfAZ62Gira/oTt6voyshlg+KGdT681rq1QX9l4fNHJXrh7wgcOGwPsHrUJlqv7bWaHyNwIc3PNQ2zeWA3Gv89NgS2wR2wUMsK/cZ//PMUMEe5tS2/018yUTaec1Ln9yUTjl00/m1826UDTLi1HdU8XEibAdmRZ9E2Yc1YohwiJagnZOqFaLufK5+uYdkOiifk9XJs4iZ/GcnMz6vxsWx6IWf6VZTOFa+gnzhNtI8/VHpNGqWuBNmv1V0R9TLn4oOLWFotD6v5YhsZC8JCjiw3M1rB9VTM9d5B+E4wiOd+lUFJuJsDOeaicCEOGG8PnRFccO+sQYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQpM8RYKkxE1VNtqUd31Ft6JnWOdFCQmpPJUugzcLDw=;
 b=d7cMgyOZ7nfpkEtObs/EqbqIKH7c7Lw+zpy7Vf8LdwYPm6IUDp3Wu7nIMqXxBzfdLiYS1Q6df7/mTxs8g05dGUdnh1k8nONJROpLVy/rwb6kf9AG8j/XRJUjTPfkOEak3Y2rN3Us2our8EAPwXTGPcB/lobJ1DVkQL8Dd6SSZjjgG03PqWfb/BlZbB/UxbXD0Y3a9sqvW6AKkWgXjpnsfDMSNQyJA0oM2vD23KdTpn4XF86jJThQIjGcVGeuN4Cs4d98kBznxc27paWzK4O/lAsXzVx/mBv+SCLfMO8RHCZtdR3HwkF+oQ2VbrZRT4c67Zo2BfdQFGDN4uiw3P+4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQpM8RYKkxE1VNtqUd31Ft6JnWOdFCQmpPJUugzcLDw=;
 b=YC5KdXPzqL7UyC1l6xgJjO0htcQ6G5F8qsN+MJ89SzJmQS/6C3qAnompO58uHXfRM3g6ioIOSdJ4zoQlYPqgjX8Wr9ZDp/abE5dZryO08IJVQqga9iCEbQ14r1xEqMVQIczFIFDIuOYWf42l4fEzY7rjFFVbwYu5U4zgv/wDK6ELC+vZ4kuNERfRpC27PmTd3UEOexRtj8UPa2l0IwMVePdsZES+FBMHxdyChz8QWIpoIjCvizdYYzjFrFj9gmBYH2OMChupuHwa6obK0od0iRJnxCfqJUHZJCHYKtadjSCXJUFMC08+HlhxiekxYSTRuyzTHOHKATOFS4PvvY/SvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 01:33:12 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 01:33:12 +0000
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
Subject: [PATCH v2 2/3] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Sun, 17 Aug 2025 18:33:04 -0700
Message-ID: <20250818013305.1089446-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818013305.1089446-1-jhubbard@nvidia.com>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e0d48-b70c-4436-3142-08ddddf731e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ow0+TnTUN58fuBzrv635QNl7K525uD00Z6jYKnM/8Gr9dNqpaQeJRQ3VWA/y?=
 =?us-ascii?Q?nWZcg7QIGLrlyzUec4LYJ1LvJZez5vw1NYQEy+yPTGFEFq8Tmo8T+HOqRZ6s?=
 =?us-ascii?Q?YDjR5meGUz6EYxI44aNmB6xjYeA0geD0FfKlK5oLdIKe6laWApG0PkuS7MLH?=
 =?us-ascii?Q?HilHqFFGvqAqBMBxbyWVK8a5nfVjiQ6wzFznmW2YKMxkmvl7ujsyPXTvdaX6?=
 =?us-ascii?Q?bW5xNZdOsv1wIaNbfPTvVDCddP2EZCQ71JLn8wJpaCYzoycMxwj1lFYZaBB3?=
 =?us-ascii?Q?IVQ0JaTnC7QeCPM0RJgoK12kPbAyjR+6aMBLlRFZiGP8sX/nG3LI5JbNJ/m1?=
 =?us-ascii?Q?7faHiw+rXdTVSV7yE7FaWAqKZiEj7m7tqjnSfqL3lzJabs1HFRxFDxYUPkvw?=
 =?us-ascii?Q?o2wSharH9wU2cPuvsiFWpoiWfr965MMexLvEhwh2taViRuh0glNrAn6t2wix?=
 =?us-ascii?Q?16MO6LAPZWomoohltJcDOBK7iWXU6niT6iPTw1zNhG6lqxxJOq4GEmvxgtBd?=
 =?us-ascii?Q?pCfTKcsNGTfGDNy/1VF1t9X0lVI/n0M/l2HUCFqn6t4v9X+zaD+8O2dIyDl8?=
 =?us-ascii?Q?00ky89AqlRxUgahhaAndBWBMp1sLjGUKAr8v2B8vC4bjARZe6HIi3XgPOWSj?=
 =?us-ascii?Q?7JX4DO2ncht0HrpSZY5FITMu91w0ESviFqIiPnlyaGxat/Qsp7IT9vYTPOV/?=
 =?us-ascii?Q?1ysBo76AS2ARSTDGT38s4Kcvvygby7ai4o+d9qYTRcklMHKbK0W+Vj37RJKv?=
 =?us-ascii?Q?q7gbTfrjmxI5r2QOWCLvNwtQo/tm8hK3UTmB4CynXdMukCAczKyWRwX/tBht?=
 =?us-ascii?Q?X4AZghwvDFkkg9LRtv+r9Row0AbBu70uuQ0BCdtNY1WoWrjb5DNYHXZgzCsu?=
 =?us-ascii?Q?IMARBBjTWxFtlux6j83vvD2URqmSyhTlcnM4Xcw2F5GB7lUW9EWSnkX8D5O5?=
 =?us-ascii?Q?zDjWfFSDbXYlhuFQ+8iiuXUf3mxpxaiF8laT1q0OIy8C/ocErbqVz0H4N1Ui?=
 =?us-ascii?Q?1H/UBcSUEF7vtizTrmri3bo7ncFR+bmzBwUeYcuIWwPeziQgh20q+Li5m9C6?=
 =?us-ascii?Q?oBkZTXUX+Lxec3Q+67nZkfI/xxcnjqLxfSgRsGclN6yqhJYe7qEx0YdBi56w?=
 =?us-ascii?Q?2VbHnr7PqkQfaLey9537RoWR3UZHsLHlfkObVdTR3xSUpjp1JdAmtLnB3Wf4?=
 =?us-ascii?Q?DekgexpJnMV7+/jdTu8W0Z4st3I1b5/5/Thzf9A/UXm+8rU6N5FBHyqs+MzM?=
 =?us-ascii?Q?ZOvcq4qNehgznwUX2RnQ5JdWXATDMwzMjS6CRy2Qi44ZUv9Do5OZbh1g799j?=
 =?us-ascii?Q?YjVsWcFpr15/SdxH093MSqVEMP4APUUsGKvWyfl/Nv1F6RdH5PuTFh7VIYT0?=
 =?us-ascii?Q?e+lAFSAxsoqEqw4kx1fn8jNN6IxvuJEWmOng4UXCVm3IsVG5TLfhEUkMDeTe?=
 =?us-ascii?Q?0JyLTG1QrLk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8ayyYB8imIA9h6xqccjaGMYKRm6RiRGyjPa1xWkhflTp06PdfGf/+awj8UB?=
 =?us-ascii?Q?QI8+QkV72/CdX2FV+1iYSMZBWqXifu4DQNqvN/MXaiWD1Ebnp+qqD1392kp2?=
 =?us-ascii?Q?cPjHuxeb615kBP5LJVKcZsWaidUbesZ9UTdOu+9SHtouEiTT6Y4hzLHegZ1Z?=
 =?us-ascii?Q?yiOFMcFjbs1k6WqeGWj/YcXTnLL07wvN5gmoz+InOHpTYFss2ulqO4KfFRUc?=
 =?us-ascii?Q?wET0rhPG9kPavhCykI+FhvQC6fIZTJEJ33NLtz8vEGG26lt3t/KCWZQGpqMd?=
 =?us-ascii?Q?TIN82SsQrTQlxgSVTqaaEAa4Pam2moEk9vRq4uxWk3+4fSAZ5cy1thEqQu89?=
 =?us-ascii?Q?E1jspm8As+h6crUvkd3vlEgfJjYjVWokRd9ctu3/q5949fpUr2MhVQfCLzx5?=
 =?us-ascii?Q?Mi1cz8qReQHDNtTQ3sua4chht/8XcsLWqDQA/ql3Y2BPkjdT1NVB9GwDmCYv?=
 =?us-ascii?Q?8w3SBpGY+ROgf9p08kdoqUF89J7q3v3Mjeq7vvVfvhJFL8qY9Bk2u9LjMhj2?=
 =?us-ascii?Q?QCv0cg1c7/ZlitsEr7iqDMZb4cbKMrC7aFptFiueJMbq1htW0MJ7wbr8Z1iX?=
 =?us-ascii?Q?VJSZLR69dmHGJ/z1HXg5YB1l+ya4TcnyxcIaWp5yi9PYMxmLz0uGLbfDvmBz?=
 =?us-ascii?Q?dLvIe35cYMN7xAZke7Z5qFE05xl9Wu486I1XJKuvL5xrHGv4oBpB8YhnCn5x?=
 =?us-ascii?Q?sIgb6upqMctAGjOxP/M+2LCWVPqVQFuP8CNlGNmLnFAgvhGxzG1zC1KFiSRu?=
 =?us-ascii?Q?pWnn60vp7KfTRQ1VzvGRgxaDHcBYXpO+u23bW8yN3084LAKdvb+wH71vao5O?=
 =?us-ascii?Q?7pE4UkVf93mB4RJg00dGHQmDak9uqK/GKuT4LpGuI08b4c5Wz2bQ/3yOK4Z8?=
 =?us-ascii?Q?58lqL77uGPQoGs5OLIzApK+7fWz9/+/XVjuTtmFYdohxcbSK1DVCoWtXxOsF?=
 =?us-ascii?Q?2q68nVLkbOCo0RxWfJR5pD9I2AZbB+Gqg3D0+/v0DtTN75J9XzQKEmo31a7M?=
 =?us-ascii?Q?HPotLlW5noAmDFcbGqf2gcUPHNfMNTFOpjU4FBYG2LYSgbSF/Ey34KstavHO?=
 =?us-ascii?Q?I1QYTmUlLV1/m5DvydEyJ43mkVwLYZUaRyz1JfEStNoi+O2L0b/T6ChAV34u?=
 =?us-ascii?Q?ulCDzfI0L7UxM9kfdFiwHg8B52M5Ol0o3TiYusFhWGCiv/o3fQ/IkOY1TFTx?=
 =?us-ascii?Q?uyn9GN+r/8yOZnPif210OwHsnq9zf/74+Ii3GccHH0r39D3tiQ9WEbsS9Ngd?=
 =?us-ascii?Q?l5Z9hUf5YP3AyCl3iAl1wAS+yPTnOt8DETcZ1+qyZliCLYRGJq2q076Vx00a?=
 =?us-ascii?Q?z2O0vmh+wzw3bs+ss+91ns7lRkdgf5i/bbaS7IVN5+lVtuGskYVw1jk++/NB?=
 =?us-ascii?Q?rYACs2EoA/KlFRcnh5r8iildktjZLUr+Pmi9GA+je0U9D6i322JF46KbkD2t?=
 =?us-ascii?Q?ra436OKxrCbl/afjnxvKQqKLLZZCNkm8ifO42w0fkTRyFg+341z5hSQozjUg?=
 =?us-ascii?Q?urQPx+kq5c6/SgZJhe0HMn6Yw02L76PN6VohSxM5Z4F0rD7bDoDgjWNFL6yM?=
 =?us-ascii?Q?TpkioohpAWI1MxtGMHpEcwXmxv21+BWbfDBZ4Utt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e0d48-b70c-4436-3142-08ddddf731e0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:33:12.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or9iQayOicorRwCdEPQbXmewXnX3VKRvKgzVRhZcP/naXBwhJuKmggZHeEq1kdy1beeNfZ4tlHlQixtKUA0WZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

NovaCore has so far been too imprecise about figuring out if .probe()
has found a supported PCI PF (Physical Function). By that I mean:
.probe() sets up BAR0 (which involves a lot of very careful devres and
Device<Bound> details behind the scenes). And then if it is dealing with
a non-supported device such as the .1 audio PF on many GPUs, it fails
out due to an unexpected BAR0 size. We have been fortunate that the BAR0
sizes are different.

Really, we should be filtering on PCI class ID instead. These days I
think we can confidently pick out Nova's supported PF's via PCI class
ID. And if not, then we'll revisit.

The approach here is to filter on "Display VGA" or "Display 3D", which
is how PCI class IDs express "this is a modern GPU's PF".

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..4ec5b861a345 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{
+    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
+};
 
 use crate::gpu::Gpu;
 
@@ -18,10 +20,25 @@ pub(crate) struct NovaCore {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <NovaCore as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings::PCI_ANY_ID as u32),
-        ()
-    )]
+    [
+        // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_VGA,
+                Class::MASK_CLASS_SUBCLASS,
+                bindings::PCI_VENDOR_ID_NVIDIA
+            ),
+            ()
+        ),
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_3D,
+                Class::MASK_CLASS_SUBCLASS,
+                bindings::PCI_VENDOR_ID_NVIDIA
+            ),
+            ()
+        ),
+    ]
 );
 
 impl pci::Driver for NovaCore {
-- 
2.50.1


