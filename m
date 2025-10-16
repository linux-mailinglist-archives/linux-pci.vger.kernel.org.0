Return-Path: <linux-pci+bounces-38398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80FBE580D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9F51A67CC0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1A2DCBF1;
	Thu, 16 Oct 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ApLno2vs"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA32E22B5;
	Thu, 16 Oct 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648601; cv=fail; b=eOXy7DgisLe8LbRo057jDmN1CSFW+8ZXPh3wCbTbciIf2r7eO13WenTYMEHXE5S+hPxQipQu2ucvmqBvvZn0ij4l0mtUwUbDK00mcYjiyyGYsIlADNxCqJAnreUskNVK1r+kN+V1K+n6egG2RMR3KFb3nmrBau4K7DjeGFGLq+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648601; c=relaxed/simple;
	bh=q5ivPaKXTUSOO1QkeH09WNWGWgmc6pNENiICGG3tmlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uArBlC71qp4M2JS+wJ8iYF1dCIL/1X/n9PfbfpXXKex4vG8ZGz2fBhpO+7YZ0pZ8zdv6KNHbz9P5rMSNC8IyGBASP6qBeHtBKbOzCLmAre+oq+AmDvfHxaTHx2D6HgYQrMOMTmHpLJrQuCGHN/cXzrJE4T3MuRM3dna5dWKjQ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ApLno2vs; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rin9LllL+tn7paVUDXs3Mri5IvSAZ45ooQVnb/vnONAv+hcGdLXv6CePhdjrWUjGCc7yd3rqVG4GE5X7eeP5zU2Hata5CUviy1AhYD+TbBnqoebCnsKtwbjlN5XJWIqzPwO1y2DnsiRSD92Ku88vAoyb9I0mqn/B4xwchrkAZB0Rw/gtjtRZC+OJrgI+1O7/s9kqMQJpgW1gkWuS5wC8ZWqeE2DZ6CYGMj/3PsPp/uEjIuZrQQKPB5nQJlkchSY1dHG2vMSlVq5xNeQtoCvNQT9jfcnvd7IdxJRQn6hpOkMXOhU5VHQ0hHnBLCsCTRTI6onrBTRkfILKFRopcSnWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywDWsnI93/+tLrLwPz44Wc6XYBuu1N3etd1Keyb+ru8=;
 b=v1VMLy2jBtCdn/vZRaYIj/YrKdFIEz0ksSxsxKH+eOek2X8Ub+Sb+ddUkf9DCCGmzU3R1omJUZQBNAwdVN/G7gQWD8pewGqsGo34Kg6GSayjG/mrvn1ZKcTR5E5fh0ccGXpr1TBla32oOPwfLvyhF3K6XORwNkNCdpwsAufgSxbLrn4jE7KrcDM2oei/tgK2eKT0np+7rI4o/BzEPU693i8Lezik/LmU7rgpZRv8GkFmpcQa3cBWjyJq4IIWmz8ILigkY6l9QHmix0GNDccJXxVuDDaC0lNpVHHSHHkY/BiUL9tdz8C/UlrYqM/Hi9TUcRPmNzVF1E4ycrzx1g0d5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywDWsnI93/+tLrLwPz44Wc6XYBuu1N3etd1Keyb+ru8=;
 b=ApLno2vsZXmkAGbkHBgXjHQHm+3pgVmL6ITbZsCZ2l+xILn4kMjX6NpA6quVLURng5imvbP/86UbOGRDFq95VfCOR5/p2SC2GW2zx+TfPnm1zIBpyhFwiU2PPTghsqpNI87w3yR7IzaK+EyHtdhfvIdTAjbiHnzXB5A0SqUJH3CZ+wvynKTBEQtxkhEAGpxKsgng0X84PmHuqhTeUe6yq7SuoOLgHO+f4gdoebyYkzYRXelgYatMfA+mQingk+kEBA5td4LzsbBM9oV+Enx67w9KtrSDS5PygcwmTHaoDzqdV2k1WZY1SGhWsskO5JEyoOfZV0gjWScJpEdmrV4T5g==
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 21:03:16 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::2f) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Thu,
 16 Oct 2025 21:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Thu, 16 Oct 2025 21:03:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:59 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:59 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: [PATCH v2 5/5] nova-core: test configuration routine.
Date: Thu, 16 Oct 2025 21:02:50 +0000
Message-ID: <20251016210250.15932-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016210250.15932-1-zhiw@nvidia.com>
References: <20251016210250.15932-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: c15c89a5-952e-43b8-506c-08de0cf76d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UxRVWlteCP0fj1yS0LLoWYmSF9fvMQXbj5ApJAGsuvPkTW8kOrmU6vuVnhg?=
 =?us-ascii?Q?V/ZIrSIFAWDkJT0y1qqTZDj2XrD3Cy2XMGUeGnY4tu93yqx4jX8jOJ2tJMcW?=
 =?us-ascii?Q?xn6c3ZlpjXnDoHuv0ddF6DYlxD2pVMjbiSczlHRVrNLafEyf9Rcwi+aO7z9o?=
 =?us-ascii?Q?E3lonu6Z9GExQraiv3WiXupfDbaOZo3mMwzkknNRhyyzDDpvghd3sE2Wn4gE?=
 =?us-ascii?Q?3QvI8FXlfaDS2AowrZaKlEv+x0kbBS5R0ipbnbaGi/KgnJN1qDBjbDIE7lKN?=
 =?us-ascii?Q?TrL7fW/4gycpY48ZT4/VewFPoi2kw39oN/WiMNtK5pXt1zV83eaPGthIbRDB?=
 =?us-ascii?Q?EEnECAmqrWFOVl7Ve80S7a/RZpVRGgMm7LvVAMWelTatKmBBJZ1DKPsWiIFe?=
 =?us-ascii?Q?Ib5zP7YGv3X0Gba/5yvHu/6IaxZJxAOyXdkgFr9y0oiquSxaf8qqCvp03LJv?=
 =?us-ascii?Q?zQ6kNl2EP+mcDcHTjZVrAqWcmaBfs1psXbsO+G7Rml/q3Ej4aT+17KLjbF0P?=
 =?us-ascii?Q?dh/Xzbd7mZBS48R+yf3Szg7p7KfwnTfoVvXeHpSgJdof+J7L6+WesNuZtxmH?=
 =?us-ascii?Q?hH2Muc0mp394u02b4/AZqGthW+8HB6xlyBrHKOy2B6e7wCSvR90iPmF27poB?=
 =?us-ascii?Q?lIKRX2UyyoEpi+yAzXFF14HViLwyiom72XpxlGctmrjJF1dIPlc/CBMWCMDd?=
 =?us-ascii?Q?Rc4Xb1HJrAbrn5m1wqFkSbpikp4J329V1H8lGTzXQ6QtWvOXpToEgBz2uF6m?=
 =?us-ascii?Q?XPdBBAt+ZB9yrX4F4RZsvsaR8PXeTcyV+NojTO78xC6pFtZ5wHqToGHSq1G+?=
 =?us-ascii?Q?7E4gIJ/8syhfxCCUAf/xS6gw+SPZiQpHFvVNaZGxllK3Z5F4o6pmXEkoQ1HB?=
 =?us-ascii?Q?up7XUkmWEP6tYe1VuTlrTx98l4MNmdt4qTR6112liBo09+qP4LbOmNbzntNT?=
 =?us-ascii?Q?RpxKFiUoDZrt0FRQEkQKlA/DSpvJTXAtARlEUvgRhM2qd2rbYYafLeGo9CXg?=
 =?us-ascii?Q?jJjhBEU/Zu4W9TajcjeUV9GEYc8U9UEVFI4+2akCrC/ocupv3VM9wRXCbrkS?=
 =?us-ascii?Q?qi6SEc5eR8WnSs3CuV+d1va5APn1VKclleitFj+Wa93+kRxF/fnvIxHblje5?=
 =?us-ascii?Q?/Hd9IH0SCq6WHlpOk0IbBbszrdU7SuykUOUDoZsImxtkqP1dnWvW1tzrJ5MY?=
 =?us-ascii?Q?q8nPLESAiorDm4Z59v+yujXt8InoaaAEBOc+/crHoaWlw7cyPNLYm0tvWSFN?=
 =?us-ascii?Q?cu18CklFR/D7QEY2mCSwAtSVOu7FNLPPIZfi5TEeFVeOH2VUJF7fvtCojuJy?=
 =?us-ascii?Q?pzTFkjkLRXyhLl54Iq+XFDknU0E+oI5AeMxt62w2C2CRTRBEHP9aeW75gd3+?=
 =?us-ascii?Q?oun7sJOEjWW7F3PGEJq7DbH4mvreXETCSEGwhLh6TgsSJVo0WNpyd/wv0zfX?=
 =?us-ascii?Q?eSuPOAkvlnzYHG2qDUI749MIDacqQmjriCC+mWCMnn77EvHwVlhnNQAv06ld?=
 =?us-ascii?Q?TkMY2h9XIfpuBMjwZK96gD/B+Fb5E/R5EXrR/BCjYD5xQaK0nKDNZnq7v/a/?=
 =?us-ascii?Q?eljC3AzWt3Nj7WI5PwI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:15.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15c89a5-952e-43b8-506c-08de0cf76d1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index edc72052e27a..48538aa72dfd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -67,6 +67,10 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         let bar_clone = Arc::clone(&devres_bar);
         let bar = bar_clone.access(pdev.as_ref())?;
 
+        let config = pdev.config_space()?;
+
+        dev_info!(pdev.as_ref(), "Nova Core GPU driver read pci {:x}.\n", config.read16(0));
+
         let this = KBox::pin_init(
             try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, devres_bar, bar),
-- 
2.47.3


