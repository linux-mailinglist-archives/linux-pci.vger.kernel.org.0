Return-Path: <linux-pci+bounces-42850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F35CB0413
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934CE3064351
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A782C158D;
	Tue,  9 Dec 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hy4QEHp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590A26E6F2;
	Tue,  9 Dec 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290214; cv=fail; b=amUXdKpEvyDstjeVXFU+VzpC9jRvEJudVBrCan4Q7dMNM+6lzX+JbDMGSyPpv201uQwmd/8TH7AZaN6Z0jCZHAteeTJ8XmHPR79mRrSulUBp635M1FqwJGpmt50xmP0k7W1Vz5nR2JK7pTh14VHoFw+EQWbDshrU/Og3EBZ6jAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290214; c=relaxed/simple;
	bh=i8rU5M5eed0p3hcy02gLAP2nEok4x3VfLUoZovho3wI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdX/u9nhFgdtdYQkR33Ohz+yZ39InRoC3Yl6xX4QlhFQpjnHdmrmRz8eCfZK56BMTLFv3wwvJhouhOZj2cKd3AvsVo1xPeFFdFgsbOsmm1sO+nCVG7ojv4wzAnvilRPDPdl7V4gDpH5TiG0ghG7xJUCigrHGl3/WOOCGvpvBlkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hy4QEHp5; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmMMzKKqCvsy69B6r/gmkp1nAhG6EDh693Uq1DxvJX02sUur/Xkz9tqWHWTmG7wDrpP2Yt1eHML03VFsIdhj+kCM9/LIsD7C9zwFSWaph4gExxN+rzcnYSrFBC3efLMKwMvBnWWMdKacUvH2MYFIr30XvhNNMRqlVgu7iZRFicWVPECJHYtfnBHi1hPy0oFvDbp27V7rH63MLi0rLvaNl3L2aCiRsJLi1sr+PYUh/bIVbM5UgjyGQispRuvOV9FRpKoGrIdg79hh0VqbRbv+tGLaZsaerhqo9xjaaIO0HfzTr06e9CAzhfhNhR+N1hiujWE8Qyn9VhYP4VOBThNFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5ZRpf6xdwd04/4S2K5JU96SxLzT1iZmKvlOA95eG1Q=;
 b=qFvz4RV5tSk0aSQoh56ZduBgwv7TipQq6ufxBnodnmDQMygFTw6fYt9lZ6lruK3fRf7ibDH10dcHi88Fz4g2y2n+CODBww0rFPkZfz7TvtiVbBbNwvQkN0X8RJ748nDXGYbYyTg4X7F82WN5Cl8Kin7aA+YfaYPpIw/vo47cJ7MhVv3lKvWXyly/AumcC4ARFC24/S3Gzpt3rQfhY8qlgaw3lS4wF2hlKzr9XcYYeAEOpybMbDkSj3DZWdesZ/hqaheF2fIWAuBSOAqKWJVrYsr+pyUHu2ng/h7uZPoNeSjCgs8EPOCi+Qk66U0aemGtH+W1+51waPUUQkevQPIdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5ZRpf6xdwd04/4S2K5JU96SxLzT1iZmKvlOA95eG1Q=;
 b=Hy4QEHp5pfxFN1hwdwCuMP97zeFzcmXRiC8epDQ6wl4Gs2Wlbvg88T18kGMhUyxq8vNIGimzWjvolejLXHJMR6M3G5t6bM5RR54fkLsPSlfeZkEZfd5Yd7ZqgoBJNA5oSZjy1aW+st3c2ImSdHSo8Y3Y1kluJ+wTda9bxbh6Zms/p3+Afmgtiv0pHGMRUlirPnxSuuV7M3NfCwSB9Gw6F8EwVjb+8IG04GK5BkfEhFzU/Loq3SjC5n2/1kVLT3O0Oc9ZCwj88xcJ9/IPuBlW+vzElgPlxDkUSFJQiZFpfoIkEDnBqz9gIRTdWM+fEl4tqqDID7S9nHrLaj8Kr6RvMA==
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 14:23:24 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::26) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 14:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 14:23:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:23:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:23:10 -0800
Received: from inno-ThinkPad-X280 (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 06:23:03 -0800
Date: Tue, 9 Dec 2025 16:22:58 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Dirk Behme <dirk.behme@gmail.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
Message-ID: <20251209162258.541a2a5b@inno-ThinkPad-X280>
In-Reply-To: <ca549425-e10b-4d54-aebe-278d90c8cb92@gmail.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
	<20251206124208.305963-2-zhiw@nvidia.com>
	<ca549425-e10b-4d54-aebe-278d90c8cb92@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: b9873472-81f4-4270-f8c3-08de372e838b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6flTwJEvuulJNPqVZAdTX++OQU7LtRCk3y4pS2zvJ7sY9XjiluhWWfGpIsFs?=
 =?us-ascii?Q?Vs0FRdUf3/X0EJtNMwt1YUFfRCf5jbtPzqb4/sP0c154GZ55Xpcv5JEOnkOv?=
 =?us-ascii?Q?fuHmMRIb0DrVg6K502W5hZPw8l9u4GJuD6M9nnTdGMyFainGIMOldABEIj4e?=
 =?us-ascii?Q?0Imgfp1cHJYtMtwprDPmE/RfhDa4Gv5aYc+RUULMT4PrQWaHHxVdFs/pB0HD?=
 =?us-ascii?Q?lFg4oHgfqQXvM2ToqY+xAro+el+lThxzSchLQOd6Pb0z6sUqHDh5zY0A/1bP?=
 =?us-ascii?Q?3Tw5yE1EV85LZJFAOKArY23AE2UYrWfEd733/N3qVnfOaZUqUnZ0tkMwGku/?=
 =?us-ascii?Q?ROyROcfLbzUa4Ggfv3L2WDr6eeA7U8dKefHkR7oNOErQ5e5Rk5Qta9yJNW42?=
 =?us-ascii?Q?cC2qFrF7nGDjrdt7vCjX3GeWHMT5q1EebY0hg5fmdQ/CeH//H6p5AEeYqFZB?=
 =?us-ascii?Q?Yntb9qpgXFrYIFC1yNfqyVUgG/yghiQkSpqJ0QMpP5V0TbAZfZrWDtj//fA4?=
 =?us-ascii?Q?qN18HeLSaYKwOr2t6kkGJN6CbHGH4sQjV07B/ytrpjuVvQlhSC6N2oUJusi1?=
 =?us-ascii?Q?PNjPXBXDMLkbOZ+2UWWuxuBC20NfUgVnjeik7R7EguFp8oUWkXVmDoMyxEmd?=
 =?us-ascii?Q?IrP7iQyMA+jtF4jVMI1I4UpPW0y28YMywfLfF25QV2VUNy9gZWKf5gj/tq+g?=
 =?us-ascii?Q?LQmoecONfRsXdezlmtMBgJE+Ey74pCGtEEQ/sqTD9rfiVpXHpHf3iCz/okO1?=
 =?us-ascii?Q?4f8oY0b8tKwja4EAsZhh55W9Y3G5RAO7KYgcY8+vePJkUz1QAw4ht44UAxdw?=
 =?us-ascii?Q?AbmfP8u/nPULK8/ozH2ykdZjD9/bbLrx9gXaF1H5ObIGJp2PF0S5fIj1MhDf?=
 =?us-ascii?Q?eiBo+TX9syqSyfGE9QdCh8YooBLxKsAUUJCeMJj2PkDpXfZylDshDrqrbcf2?=
 =?us-ascii?Q?eq7ATLEcNyCi5dbvkb38BMJeO+THwjWHBgq7MgJdnZYFQ2QXJkV7ncQHCQJg?=
 =?us-ascii?Q?J1RtuT5JXTEouh5Id65dcJ9pJ5XWTOe6nngn+eAWnefP4G5uNa1UYaZD3+Iv?=
 =?us-ascii?Q?O/uvV6E+6ZQoy38DuVStK7OlpfN48S25SnXbsPxl63otVlAwY8aMuTO7M/no?=
 =?us-ascii?Q?FKz0Zyvaeeu9KEYfy2/HlmhsstS3Z8g2Ogl1qOkb9YbQAuebJVUQ0lwzMwvx?=
 =?us-ascii?Q?Gbk86hP4w/v7Of+lpiyI1fQj/gMKQFmisN39wr0nhkJ+thiL87xT+5DTvzKz?=
 =?us-ascii?Q?ASaX/IF505IK0UN6i2cm8v2rKj/SPxj04S+09wt/vYPlngzfjM28fxeQ612z?=
 =?us-ascii?Q?69VXi+utbRY2WLLnoDb6Ta4ru5yliFuN91dvakuWA1IkPxjdJ5HOIC7JcuaI?=
 =?us-ascii?Q?2ks91aZrp+INMhwdI6wJBXJW12W4dogfHywXFO9RInrP9JeMFoCOPFPKw2dr?=
 =?us-ascii?Q?EBep7xiUQ+4v+Cf80UZJF4w9Ix+v+kSkd1LMwWvNTuIYZ9vmUWVMZroHWjku?=
 =?us-ascii?Q?59FOmGWbNA95SiNXtdAVsgfk4Gw1iTbov/Lbr+adHEr1hUCIec9zn1+MZJbS?=
 =?us-ascii?Q?1IifH8Ztu8G67weaHiKCwUErWmSmdRB62Hl6QaGJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:23:24.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9873472-81f4-4270-f8c3-08de372e838b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

On Sun, 7 Dec 2025 08:12:10 +0100
Dirk Behme <dirk.behme@gmail.com> wrote:

> On 06.12.25 13:42, Zhi Wang wrote:

snip

> In the thread [1] there was some discussion about the `if {} else {}`
> "style". From that discussion I "distilled" 6 options [2] which I
> liked for having an overview :) Of course not all of these applied
> there (const), neither will they here. And all have pros and cons. I
> think in the end option #4 was selected.
> 
> What's about to do something similar here (and in the 2/7 patch as
> well)?
> 
> if vfs == 0 {
>     return Err(ENODEV);
> }
> 
> Ok(vfs)
> 
> Dirk
>

Hey Dirk:

Thanks for the detailed summary! As a C programmer before, I tend to do
as above, because it improves a lot of readability on success path.
While playing with rust, I tend to use 5). Personally, I try to stay
away from if let chains, as some lifecycle changes happen in rust 2024
[1]. It wouldn't bite right now, but stay away from the bumps. :)

As Miguel's comment in another thread, I would improve this as
discussed.

[1]
https://doc.rust-lang.org/edition-guide/rust-2024/temporary-if-let-scope.html
 
> [1]
> https://lore.kernel.org/rust-for-linux/CANiq72kiscT5euAUjcSzvxMzM9Hdj8aQGeUN_pVF-vHf3DhBuQ@mail.gmail.com/
> 
> [2] Options distilled from the thread [1]:
> 
> 1.
> 
> if let Some(sum) = addr.checked_add(PAGE_SIZE - 1) {
>     return Some(sum & PAGE_MASK);
> }
> None
> 
> 
> 2.
> 
> addr.checked_add(PAGE_SIZE - 1).map(|sum| sum & PAGE_MASK)
> 
> 
> 3.
> 
> if let Some(sum) = addr.checked_add(PAGE_SIZE - 1) {
>    Some(sum & PAGE_MASK);
> } else {
>    None
> }
> 
> 
> 4.
> 
> let Some(sum) = addr.checked_add(PAGE_SIZE - 1) else {
>     return None;
> };
> 
> Some(sum & PAGE_MASK)
> 
> 
> 5.
> 
> match addr.checked_add(PAGE_SIZE - 1) {
>   Some(v) => Some(v & PAGE_MASK),
>   None => None,
> }
> 
> 6.
> 
> Some(addr.checked_add(PAGE_SIZE - 1)? & PAGE_MASK)
> 


