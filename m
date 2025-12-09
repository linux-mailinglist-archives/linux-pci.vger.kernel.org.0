Return-Path: <linux-pci+bounces-42847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C6CB0308
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE803033DE8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257E2D6E67;
	Tue,  9 Dec 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ga5CGgNF"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E9248F69;
	Tue,  9 Dec 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289157; cv=fail; b=EDF6oDUOIcvi9+ACyXzpbE/Mg9BMh7SwbgBLKsfDGF2MhKc7u9J84plaiVGari9mqapvadNUJ833vxP4yT9usHaSSgmreDokV/LeD1Dswbg6z8GGGLrKYlKWZvOm7MsJR/MO7hGP6rzczYzKRnqrxbxjoKb6bv4cDdcZZxaM1Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289157; c=relaxed/simple;
	bh=gq2gQ1Kr6Sj3kEYyAh9X7VxF9iTk+IeCM33aii1bzPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOmwjnBdVmxmjZlxg3i3Eb794tObCpzU+d8N2MflKWQQ/zIIUrYelRpKDO9uCzngn3x5XpQQCkhkqk2xEZAzIMxdmAIxPVlhhvfECGQIZVROl3dZ40y0ROq2gFCvnna+L6/FUwjfxXFA7mAimEAz+HnjuIBZOtpxFnPOxzbuU6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ga5CGgNF; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmqqxbrRO1+i3dAjNEhBjxpE6WYKIsr015HE+5t8C9N3BCXJTIhgGYvWdew+096dJxNUAS4Xhh3dwDuomTWNavX5B1zEjFaHDVlmxpDtYLsmtCRz15xmVuzombhBLngjhSjZbTjnAuoC+Bkdj/9NPRaThjlLwU8rLKqgyiI8HsTX6tSTWa6GYknWvQM4nLCtFKT6YxkXaaOd4W4Og4Cj9NN994nPAR89lTWjHtJoIlvAQ2DeTQWr+cIpKe+FyxorkEwhpb6CW3WCfINNzUM1va/0wfVb6540UaC5tpiDcXO0B6iMQvNSGTWu6VV9JLkbzqmgW5e7QIJmE7vg8U0KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TOnUZ1OezB8FZKgWqjbDgVrfnrG+bI7gdamfrGCWu4=;
 b=TqesRplJ++ZhD7K4mtUQGgaRjvCoB/N3hoWFi3uqo7+JdguyifHCP72iCPKk5DbAzymJoj1btA+kdcdXqCATVz+OKnrQ9WkEucu4Y66knRkjjw/Cnam9+TlnaB7HbPIJdCpDCbUAX9c2xH3BK9+AnEXKMzPc/JU4TWtT9RJ8pRPiZkI5CAyrXDizRw1KpFyeqqwKAUEnXMRAT7ieULCE/5rm4nfWQe/2otToRCLG6rhoYOMt8DewLUYplVRoX6kWfoOv32wDHznlBn8tyU4BwU93GTmbcC5q7W5R3gGKLoIs7ZQFLQ2JM24hiTAL/iIuAlXsK3iQHy1W5VzkCfuJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TOnUZ1OezB8FZKgWqjbDgVrfnrG+bI7gdamfrGCWu4=;
 b=ga5CGgNFQ47XD0djVE9fKlFG1QAGeqzI8dZ1MS5oROU9pYxaABdP09NPqcPKclziSWH1wSWMylR95EyuATX42Egh6zbttB3uPsQDyJa1qSKTIiYN0pNB5EFFFzgkJS+9ce+gu0PRoGEVsnS8lnk+SLSjEvlD3YdX4Bq9KLvxeg70LejIIdgUw3VHj9OlzU0c/U3wHwCk2d04TrKl60xzkdh1pFUgSAmANxo8QEyQ39EjIRKLljX4TmQyLB92S6Y9Nuui8x3KrxaGMnsQ/u7n2vbIAyG6vuOtS+LCskTDc9KIW619vuAey4A4xht4zLQxldpMA6S+UoLI7rqrhnXi4A==
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 14:05:49 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::ca) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 14:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 14:05:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:05:27 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:05:26 -0800
Received: from inno-ThinkPad-X280 (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 06:05:19 -0800
Date: Tue, 9 Dec 2025 16:05:15 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
Message-ID: <20251209160515.6658881a@inno-ThinkPad-X280>
In-Reply-To: <47c05bcf-7591-4148-8783-0c107b0c3c9d@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-8-zhiw@nvidia.com>
 <47c05bcf-7591-4148-8783-0c107b0c3c9d@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 469c9466-310a-4ded-da7d-08de372c0ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fABu7kb4Lz7lOkR68zXNmKraWNITmBHER1P3qLwt7u9qGwe4zuP7AVfIs1Fi?=
 =?us-ascii?Q?kwxd6FvfSgpZnFxLuafHpjhlXN7pCF+jMwoDHtlW9SBG57cfPhTS1X/fmvma?=
 =?us-ascii?Q?qFdwYVPXYHLd7yOy+1rUxOzsOhjCalk7EWEFteFq0v82PxJjRBUXFtIEpwD1?=
 =?us-ascii?Q?5p5pJfbhga9YKbtazmCvVDq9UnRy/7BHpYlKwgAg/ihlngjH8W7squOS9qh8?=
 =?us-ascii?Q?FAfKnJzDSuMCS+0pw4jBU3TiIN9rgVPGHQP9KOXpic1gtmd5sFkwJs5yclYx?=
 =?us-ascii?Q?op2Tpa3D8oNRKWLqDe6bmZOTIrn+AyMIFC0ou+vD9btAnSgIERp/xO6xdQ18?=
 =?us-ascii?Q?4oYUJOHI5VXhT7ZwKZQTiYMRhW/O9pqdBSvn1GDX/PqoT+gQi6lr8o9eu9eU?=
 =?us-ascii?Q?Q6ZZU3EQfKQfNSKlFKnJfd+kZr7LEmr85pWTxUO2QO2yaI4L28Bjux8swlQ/?=
 =?us-ascii?Q?yFxUH82aDm9mP9qACOn3InkVcGJ1lIabdGKjmHlMV2Rd9r1cBZGpjKV9JN6X?=
 =?us-ascii?Q?KNHULzv/La+YtZtAFwfy2GpjphdYrD+ZjPCYBRDhcqJ1nQNM6ApsAbH11VD1?=
 =?us-ascii?Q?wAM/SIm9s8n7sUUyawy5o6EWQjC0iKNUBPPYLppL0YEq/QdkMH6oi/rAyImN?=
 =?us-ascii?Q?DJi0MA3Q1EEo3j8jlgS5mqN/DtPy/drxFMUVdQ38WqnnQCf02nN4EARNDaVK?=
 =?us-ascii?Q?DM7N+xIj4qqBloKeBe9G1oH3sNDwkPIdJZ5C+hoF5dYoaKAOXM7xa2qHYf+3?=
 =?us-ascii?Q?OCuJUK2glr+C3P4sJ248dWmsmBpWdaSK6hIlMKJ2FAfjNxOR6xOsOvBp1cT7?=
 =?us-ascii?Q?xJ4ZvnsCZi5nxrhcUB4ZrNaIyFLb0pjCF7LDn8u819LhFOqXqvESPdc+7Y0O?=
 =?us-ascii?Q?OZqtcuvHWzv12+ePEOSTlurkyhVaFh5mJm+NhhwDzCYF5FzH7/n4DOQRNz8s?=
 =?us-ascii?Q?fm7Fcm6kSmZy8j1jcyiIpmCfxS3o9IIvH9Ein02t7UPUoRqcz33NkrqbaWEs?=
 =?us-ascii?Q?hFlP08XBRaUDz5bM9lcIbGnjEPv8tyWzBu29IStfa5oyI19vO5XHoqN8cT11?=
 =?us-ascii?Q?hu73hLI3Fe5x/e1EK/qM4rT/RPMtompSTkctARY4I8Nd57a+2lr2I4jyyFQA?=
 =?us-ascii?Q?jVFod2i093eQBo3MMKLJRw/iw3No4SiWwgoSc47M5a5ErCf7hYF6viXvV0As?=
 =?us-ascii?Q?K59LiKuizjmUIn/dKlCAEEP+kcK7/dwSuf7JVWk/NiJG62P7J0+lN50IN3l5?=
 =?us-ascii?Q?uhLq9rE3FIiA9DGRhM4zgGSquX+VONHxs/Wtq115LnoTZHAv3H9/+kKLVwyG?=
 =?us-ascii?Q?ILibPtdI4IQCNosWLB/WBpmm6ZwFmsG9Jg2ExzLNcQ1mcwr+cXA2jb7SzGbj?=
 =?us-ascii?Q?E3Sa8aRovgnbMtW3wdYmp6guHQtlaEpZ+Zhh318MFhOasQFCZMDUiVQwM3mO?=
 =?us-ascii?Q?jo7pD0ik3jArGKbknFrmSQr3jW2+awl+H2aF3nb6jK9sgoRldhhk8CqK5rKE?=
 =?us-ascii?Q?0Dryo8O6tYij9ru3l4ZNmz5sD5iSWt9pZ+y7YEXp0Doh+w0J18FvN3Acty94?=
 =?us-ascii?Q?Ng6H8D5la2wlMk215gw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:05:49.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c9466-310a-4ded-da7d-08de372c0ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696

On Sat, 6 Dec 2025 21:26:12 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Hi Zhi,
> 
> On 12/6/2025 7:42 AM, Zhi Wang wrote:

snip

> 
> boot() already returns -ETIMEDOUT via
> wait_till_halted()->read_poll_timeout().
> 
> The wait there is 2 seconds. I assume the scrubber would have
> completed by then.
> 1
> > +
> > +            dev_dbg!(
> > +                pdev.as_ref(),
> > +                "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n",
> > +                mbox0,
> > +                mbox1
> > +            );
> > +
> > +            if
> > !regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed()
> > {
> > +                return Err(ETIMEDOUT);  
> 
> So under which situation do you get to this point
> (!scrubber_completed) ? Basically I am not sure if ETIMEDOUT is the
> right error to return here, because boot() already returns ETIMEDOUT
> by waiting for the halt.
>
> If you still want return ETIMEDOUT here, then it sounds like you're
> waiting for scrubbing beyond the waiting already done by boot(). If
> so, then shouldn't you need to use read_poll_timeout() here?
> 
> perhaps something like:
> 
>  read_poll_timeout(
>      ||
> Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar).scrubber_completed()),
> |val: &bool| *val, Delta::from_millis(10),
>      Delta::from_secs(5),
>  )?;
> 

This is the identical implementation to OpenRM [1]. According to that
parts of code, I think the scrubber runs in the binary booting process.
When it signals the firmware booting successfully, the scrubbing should
be done. Let me change to another errno.

[1]https://github.com/NVIDIA/open-gpu-kernel-modules/blob/a5bfb10e75a4046c5d991c65f49b5d29151e68cf/src/nvidia/src/kernel/gpu/gsp/arch/ada/kernel_gsp_ad102.c#L49
> Thanks.
> 


