Return-Path: <linux-pci+bounces-38421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC8BE6583
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 06:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525B34E1DEF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AB30B52B;
	Fri, 17 Oct 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsbMV1wc"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0D4204E;
	Fri, 17 Oct 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760676951; cv=fail; b=S/cr6uTYCCasu+lz4PDWrrNZQ+NtqLdvhKzgchwCVux7UOQr39D4gu8NqHS5HArEJvWinl6NslwM9uOgjSd08ymeFjWFV4CuTgHR4ieKqxBJ/9MZSmcUA0berj8hmrzHzUND87kLTbA/xpq7SAlcBlYFpRVG9C6lAUpsxjsbDgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760676951; c=relaxed/simple;
	bh=KKsTaQXe7XsFoL4+OUjAYXcRtSPAJ3x1dXxB9m7o6ck=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsqXe0H36dgGA4A+qe82MWEtonEbiOo4Dkrwuo29aBlNqmDnuPzEQVe5DtYQ9w7TUU0BLpEzpLuuwFwRzXdmO6dzHA+2PQsIcWkFg61SGPTauP+tHjc2zxjd8ypcNNo9zDg23c85z8wJdt1w1Ck+QsSWg/ggsvPYhBtoqtv9ioQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsbMV1wc; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puMD/glEzO6vaWSbJcce8cnhSapkhCZRjAhPYQChvjmwzfnw+TiVFru3FBEMRRMHzdrwmYydKNL2ACBbIFUVIO9BL+Ukn3bjrfMWy3B7gjSLZfVxZwtwjyRFE5kzaXNpnEx0h8A1EN6eTFRt4CVpYMgqVYJ6zAEvHv0G7mLsPh3HmSZp1mwRl0xmbimlzUGaUXee/yuZ71apBy5t7jjEkDhd7UXsjTbSeYdESBprmbjvbrpLfascdMswckB363q/zRa41LmqbIypSoA6U7WwMWE3lTClyeNAcQE271hD7e/suGihD7v/Nd1WIhET27hugfVoTjYZXjtnZJKLClIf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZaUEUV3nd0UFZ8AhJ3oupZQhmQb2faM48m9ZT0Z5PQ=;
 b=PBioU0c4ecxxT6Zlq5nYKJmAmL8jtDkMnPEQM1vyoTxYcJtRWnyflR4jS3fH+LXDEqtJ2uPigFc8jpOuAU5F29+xSpZwGlhHXKkS3EUke8xC89Gr0+6pZZJZtoiRoGTa703rQIBkp8ZR+aGXx130DQPu/r30ljFVfKrJnByWXVjkTVJc3QQcKkIxavz6eztPyRD6XD5IsdBAKNe2hNN+4zg+I8SBjzCFXUU+OmM/HFEX7ljVzjjJaOIrknz2frNU5O0plqa8th4y6gyrhK6lDeY+T0lvzas9qrk66s5glpvwENV5uE3SsiR7l7PZi1m1oFpUAkJimTOPdE+GshEwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZaUEUV3nd0UFZ8AhJ3oupZQhmQb2faM48m9ZT0Z5PQ=;
 b=XsbMV1wcr34rS5aMUAx442XO8aH20G2alEHv4Kh+XAw/l5/gfcQv4qQXO7e5OWTD2PmCBtjKM03Jx3p6Zx8QoIOAi8orDPlWi8xc6HI0Pa6s0aJnL6sZ6POBXf5zFLkv8hOikBkXI/lbhDhuv/t5C2Qp9koK4M5ACIMPwl1LIbWfklkAV9lyzBCw5/XkmfFS5l/p7VgxzODiWb2WJHnLd3X9KcZhvx64iSoBF8B3pojwSxX+F0v9ysMcXrWxK8YoagNRykJKK6YhSjuZ48Fyhku892gAa80hERGgQMf9lb5rn+BD2mLDgMdY1I1bwFFKOsagWw1w3d0zeni6rkXMSQ==
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 04:55:43 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::82) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 04:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 17 Oct 2025 04:55:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 21:55:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 21:55:32 -0700
Received: from inno-thin-client (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 16
 Oct 2025 21:55:24 -0700
Date: Fri, 17 Oct 2025 07:55:22 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiwang@kernel.org>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [PATCH v2 5/5] nova-core: test configuration routine.
Message-ID: <20251017075522.6f662300.zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-6-zhiw@nvidia.com>
References: <20251016210250.15932-1-zhiw@nvidia.com>
	<20251016210250.15932-6-zhiw@nvidia.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: e528b176-0aac-439c-dfdb-08de0d396d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDlqOty0zxtQOvIZR0rCEqoSlDb2iL3Mm1GUpnsYSIXc72WGkHH18zVcx3ss?=
 =?us-ascii?Q?PvJ9FSrXdxUQWEku7PGPptQ0yIkEFAtbhU+CFPQKor3OYZnHEtTxs+hSz46x?=
 =?us-ascii?Q?d+wDRQO7vnsRKwzvDhjnQ8qvrXkUiey0LTMTpAXdmuYwkDHpV04qxDQov7wL?=
 =?us-ascii?Q?1uHSfFI7eECGtVlkp7bJZ9TAAZqvVk/LO2MmyoEazjjz1wwIXfRs7Xx8q/AN?=
 =?us-ascii?Q?PJk9sUJYOnVelPtCU5RpzXvOq9yu8pN/2ROMMnfgrftHqGNWODjyJngfwu5e?=
 =?us-ascii?Q?OcY0nhqL0cXWQ084vozYuK1TyQtUr8lkDm5jRvr/Z444Ola7tKsEOLSUQPRm?=
 =?us-ascii?Q?Mv4+Y/+qGorC9FLBFv+iWka0gEbokYW/LjzTPU/CZj383lUuVitXrkFG3oCG?=
 =?us-ascii?Q?tMVqgTfij4D2MldJp7VMGIE7hfiRhGT2vqlXPeGZhoN9uT1dxrpe/oRODO5p?=
 =?us-ascii?Q?kArYbWyTkHsOh3yGEYQTzSUpUEYSEpMaNvdaEe5aUhZwJKXRUn71pLg9U0+V?=
 =?us-ascii?Q?8gGeOVqE6WKe5kElnAL/b1h8IpM9LzFGfDoAgDipSRsap38tGYMVg1tsEfVm?=
 =?us-ascii?Q?A2zYwWsZlxn9FH33Yh3qmx7E/sOOZdXeYM8dLcJn/q8r1qUblz6oRPC9jxmI?=
 =?us-ascii?Q?Z3XHTSprpYA4Jy9pKsIIQYVGM5de6K4TrmemIvzCmDjWPiWN53xAGuI9uYoj?=
 =?us-ascii?Q?H7fWkitIoX6yfn2Cl4/Zjw0XPVnvrpCR8KI7QrWi1chjWnAIrKfe1ungt5tx?=
 =?us-ascii?Q?Khv6510k0cw1WdfF0GE4OdYUys3UHzG94SKCQVVog7czDJBjXKOFaENNFGM1?=
 =?us-ascii?Q?dQtskFHbPh6dH4ifoyfiXQrCmi7XPSw75mqtU8ethLfavnLmz84BnfIU+Iw/?=
 =?us-ascii?Q?owcMpdlDZIQKbnjAibQX37Wq+6OFSrCbLdHjbLsaBB8p9tPufx5c1/7TUQB0?=
 =?us-ascii?Q?ZFYohUM5tLl//4Vn6QlafOGhHamWcd+PRq37lGD+5gGKATTqU7cJiYF1OwcY?=
 =?us-ascii?Q?etlTTa6EJfYO1TjC2sqkthTuGVFOWT6toD9r7dlpNhaFoma4D4WTQjRScMN/?=
 =?us-ascii?Q?9LRKISa2M7upCe1JbERn1BnDmt7xplY+3NOaThk2Fi/9Veu3m/zLafx8ainU?=
 =?us-ascii?Q?JVxFQLRPEgGJOd0GwKAXED2pVIGKzY30UePDNaM4K3PMTzssKsSCj6W3IPsq?=
 =?us-ascii?Q?/WBLLgwa1mQV1k5ilsBoaQGDG3BuiWuhGzcNktNfcGEuAj3WyEHSUP5BonSn?=
 =?us-ascii?Q?mPXbwIcXXXIs7nY/kQ/jbi301qQXyKvBLqvIFadY9Dijojh4E/8oRbh+jGHd?=
 =?us-ascii?Q?TEgM1e7F4KYcDrVCTonv9QXt0pjGoFlH8YQrt/vak/1exnamX1Jw/NVwZsE1?=
 =?us-ascii?Q?vHX+u/RvRHSY1M/2H7ztTpdHT9WbZl/S1VoaA5hFAuxjRDQqmf8ucGA+M5gL?=
 =?us-ascii?Q?hJFxYqEwTRiYWlj9+lU9CTo7Pew8g+U0Xms0tXQX4KAyOj0mOOftJUlQYCUa?=
 =?us-ascii?Q?l+DIhIF6aPQhJV2uA6fEY3+Ja/aLMsKGzPqDlwfAKFnlNV2Lf5HMkut/WnRL?=
 =?us-ascii?Q?IyLomzdCMQyCq58RJxo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:55:43.2527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e528b176-0aac-439c-dfdb-08de0d396d74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

On Thu, 16 Oct 2025 21:02:50 +0000
Zhi Wang <zhiw@nvidia.com> wrote:

Hi guys:

To avoid misunderstanding, this is just meant for folks to test, not for
merging. I will drop this one in the next re-spin.

Z.

> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs
> b/drivers/gpu/nova-core/driver.rs index edc72052e27a..48538aa72dfd
> 100644 --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -67,6 +67,10 @@ fn probe(pdev: &pci::Device<Core>, _info:
> &Self::IdInfo) -> Result<Pin<KBox<Self let bar_clone =
> Arc::clone(&devres_bar); let bar = bar_clone.access(pdev.as_ref())?;
>  
> +        let config = pdev.config_space()?;
> +
> +        dev_info!(pdev.as_ref(), "Nova Core GPU driver read pci
> {:x}.\n", config.read16(0)); +
>          let this = KBox::pin_init(
>              try_pin_init!(Self {
>                  gpu <- Gpu::new(pdev, devres_bar, bar),


