Return-Path: <linux-pci+bounces-40779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE8C4949D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8563B2925
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6232F2616;
	Mon, 10 Nov 2025 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="euWWmRGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179B2F2915;
	Mon, 10 Nov 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807346; cv=fail; b=U+zCt1c3G5gUnkhx9giwSbvMNeGA4xLqddUCUmpKyJfMbELicqZL5yuB8qguF7g0f8mktjGCnnl1o941DbyX/DPFb64NVdfxSX88N8BsIWxfI4t7VJBXuzDGwOOGYqlE1LTKjxTknF9u2axDJ9c4ZhDfl9cs71xAoFVVJVuBh34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807346; c=relaxed/simple;
	bh=OjmkX9cZdbeTJtC8H/VtuQT13DH2b/srUEiqfaki6RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXJ4zZPBDozqyrm/U2DngFG/XL81vL9y9OVDtsks1v839cdrM67Rlugab3ODl4OSyYpVUsKZ8oIbSODx3aw0jOR4PUo25arL/AEpRm5Z7Z0LQmCYqT9Mo9398MvGJgm4MZMTpXUmHpSd4G44QyEFpm6LEs11pZ2aO3Wl3J7/YJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=euWWmRGy; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3Qlz3W2pcRx99FEi/6XhM+IxAEhJrl6EJCjfHF0cicjZsosz8t3Q+ySU2HxoQ8yAovKtF4vCpxKpixzzRIm9SPtvplfkbNWiaO1MTIrOJTI1Zr5+xQnHrk5roT3U0cg2IExAQLbCGTff+dBYevgQNCe5hgC/GfSbtzzLdlHSY+ok9UZR0z+QojJ9hDtbie7id4K92ivRwB/27mxkX5uxRO0ODGQdNOTROl2aLRcN8wMv08uF5F6x6nCNOFImQ3L1sMG9CCBko6IyROPfh3Ahj30iUWtJuMqRqgz9sqPSXY/vuJDdESphoEoFHUpFkwkbpmOAeJn6Z5QqPFU7BY/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+x7tNPZSP1pwYR5mUookBrzPncXbJXt/+lUQQ4Gm1U=;
 b=m4N1YPYyGy0VI6uaut6m6xgvU2J6QBeuSngLMwhyKgJbi9A9O+eSFLNXZYEZWSSjphNCEy5p7K6bMAlg856u0CCEWNgOf75cziQ+DEEtAPDP6isMhAmx1GWgmH2ibsRiLcSf97Olaf4R7WKi4mrLI3sqLb4PdkswobjYGnOcuvjP12mt8pTx4E6cN1EoCtlYkxi4eolEQ5791eGeTSGWDgNEoRyJw9ajNiPMwgTM0YydtEm/8fxwkUFZfDITUlcb0ofqnMGxk0Fr/e0aM6uumsXjyVyCAxzAbjZ1urIPw3PRu5TZtWHSGXaS2/pGSWz2zetVWWjmgw2DZ6iqhivCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+x7tNPZSP1pwYR5mUookBrzPncXbJXt/+lUQQ4Gm1U=;
 b=euWWmRGy2xDfMNZpaa8gcIifX5xFqQfG1pyWYtiSow70cO6t71QH7nkNkCm5yl31zxmGDTdo7dYHo+qRfMTkjTbF4eC5nhrPfTIr9V/sC4mKzYaEGOzXN5g3AZc9aTQZFHgyC6xdWBmgFrie0pZXdZj7twhITw4HP3EDXFY0wN7jHwVXSCEryDgMX3wrILd39pty0ejRqCA2Z3jW/PPhVsYIE7xH7vYS4xrxnod8rYk6cd9tztn54kfpHuH0pgC66xTCulCUkS7Y8e2A0qje6DxxncTWbCeJT7stuqbos0uunRXTVMjCvTjPYxRJqQ6i6O18xampsw7S72oKMeWPzA==
Received: from CYZPR10CA0021.namprd10.prod.outlook.com (2603:10b6:930:8a::14)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Mon, 10 Nov
 2025 20:42:21 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::3e) by CYZPR10CA0021.outlook.office365.com
 (2603:10b6:930:8a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:59 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:41:51 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v6 RESEND 3/7] rust: io: style for imports
Date: Mon, 10 Nov 2025 22:41:15 +0200
Message-ID: <20251110204119.18351-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9c399a-b018-40c0-57a0-08de2099a586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9fcr4QC1fAZ0ssQPriZsTWaQVYSzUXoUnL2fcK75KViLXIQwDd0BDdL/Xb8b?=
 =?us-ascii?Q?09oB5JeAv6cPYvTbW9c3QiNrNAIDWKsv5+eGUD2/SUJ/6LFb3oUsLjvPUcUZ?=
 =?us-ascii?Q?ZRzxknI1ZkoseybmcmmcUeVnS/facspfik7OnU0cbZRH92pbgxmkNqLOlvgR?=
 =?us-ascii?Q?gZ4+YRXDEuKCErxUGQEXcndJM9Jo5+UYNyBQnVbmM9pLH63iBlBJU8oVxTt4?=
 =?us-ascii?Q?ZbdTYlnjd7I3c22w60526/STBRdaABWMjvPz0SinT0f8a1Ss45dyVhmR50g7?=
 =?us-ascii?Q?FPcE7zWxfKDdJwAlAOWbkRurrgVnbBJESOWorXGs1M9PqRDrMj47BAkNOoMz?=
 =?us-ascii?Q?qJ9c+CC40oJUqKGW5OHFnZIZIb1xYKP4stPoSxP/d02VUdrspx7s+4kf8QmW?=
 =?us-ascii?Q?rN4T1f/CxqlXYsJ8wWdX7i2m9P0y7ByNmVBvzwsj2SrOz08DCnHhwskpuv5G?=
 =?us-ascii?Q?ijwxaGNlIl3UdQexfQe13Ccnl7WFpuRJrmRM7VjDB570hlVDtot5GGQ0pcKP?=
 =?us-ascii?Q?TXriwME87EHXCUz42e5Ri4zDEk1G1bXR8Wyd36mMc6GOAoc3CbJ5gHsv0k8G?=
 =?us-ascii?Q?ljhShRlE5F6Vuf4WjM6NPN9EKP7ylbDW+klANoU5PmLjAG+At1u3TLM+OZJ1?=
 =?us-ascii?Q?J/Liswsde3KDo2OdgAtHj79eln6MBvaTu0cGKBE7XSLWF1sG59+uEBpwWBPu?=
 =?us-ascii?Q?zSXYD5yWUMW4akDs3ITuqkOWuJ1L1+nsLO7Sf0L8mrOL8taa44I1hunsaH9n?=
 =?us-ascii?Q?RX/kiKAcIYosagpTfHCKwFQdvOKzUqj+ttzhWK+pSYWiJSwMgCTpfO1HWhCC?=
 =?us-ascii?Q?xI5BC+3Y07NZrX2lmfmDLZhU2eduwMOOW+RlSVPdF1eyTj73pdESUaScvm5p?=
 =?us-ascii?Q?RofWnCv2uW8Rgl3KHTPcdhT2YuWbumDvy6n9JgDcgskLD+jbXPBg1LYL7MfR?=
 =?us-ascii?Q?sdnVq2HgkXrzaC9bg1Tcb+YQMmmQ5LaLIb2ITuO0SP6fdqZfAkgJAGVr8cFG?=
 =?us-ascii?Q?vLQsK8PLG9XG3nA+X8wcLhQrJtF4M9O57F1jvdQrBPuRaYQPoya/SOrJL6Bw?=
 =?us-ascii?Q?l6S4GT7FQNTabELce07c70zC2Wk9jV7tE2wIvd8V63pdZr2H6sEAXN4U99iN?=
 =?us-ascii?Q?7G15VbMab2MQUQ7SZeKuY1F3beiQ3BBmXU9kYo/PuiFnVXu/IchhJOKE/XLj?=
 =?us-ascii?Q?PQ0jQKhDPZtIP3/8ay5erDShcn0XZjliIY5pGZ/n6m3u48g63+ptR9lmcKkc?=
 =?us-ascii?Q?a1UYdqsiYorlzVECEHo2V2FiUnNuHcTGjHlwLEfZoTtg93xIYe8bP0BJ5KX/?=
 =?us-ascii?Q?t7LPtn3kTfdXK/PM3/BrndVcoKomeIIEn7RamY3L+UJNGp7d9WP9VroWldbL?=
 =?us-ascii?Q?ILjV8TsEm+C4g2AS6kzJHrEITEnMuLq5aBs2gk+ZagFivONZUkumaAo7alvS?=
 =?us-ascii?Q?8vj7LBvZbVzzPQbvsbsLZTZF3AH3za0ZSqAVP/EK+3INs6mMOjvEQoaPcQef?=
 =?us-ascii?Q?KCR/j73Px6ugYxyPtLw+j4ahQn9JuV5vC5FO+JLLUNocBvfQbd909Ra8Q3Ip?=
 =?us-ascii?Q?YrcSL6HCe5W1NAn8LuM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:21.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c399a-b018-40c0-57a0-08de2099a586
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212

Convert the imports in the commit in io to use "kernel vertical" style.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 1aa9495f7774..5af04c3b807b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -64,7 +64,14 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
+/// # use kernel::{
+/// #   bindings,
+/// #   ffi::c_void,
+/// #   io::{
+/// #       Io,
+/// #       IoRaw, //
+/// #   }, //
+/// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-- 
2.51.0


