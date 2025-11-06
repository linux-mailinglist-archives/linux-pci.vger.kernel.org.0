Return-Path: <linux-pci+bounces-40521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D62C3BFD6
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3423A4540
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1232ABD0;
	Thu,  6 Nov 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azYLhaCz"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEE1FCFEF;
	Thu,  6 Nov 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441865; cv=fail; b=HcvutdgzfRS7dwYNQ2oh/cT9ZvF2q3i0xLflUYU5xxdp3tHHZAQa6clNsVhUTJKKegzlu1EQKC5bqXWG0phcl917AMZHVJ/SzeJi5ETiaF0GzzzX9Nx9uJ2OBhNmEt3NYnfxQsuaU3E0fqWbRxqu5N4Utn+VjEFGcEAWKU8nxME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441865; c=relaxed/simple;
	bh=MdghgW4o3k53o043mtlV/zseEf2JXpTZd/QMKYO53+o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH+nm3cUWZcPvwzS32D75vKbIddoMwyXorVXoxofFnfL83b4JC35ddPD1YW+Lt09GxU0Go2Lp1fq834mwYWDb5eMaMD/3SYdjI4woV44MUiKrt8GT+ypHFqtwrlZEBAnPx5QPOHuLC2c9lpFG9NSJ66ZABcWWsozwDi664ccWfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azYLhaCz; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4GnSc8HpUGLOTr+o7j3ySezbEs/DxS+sPYzZ+idGGy4RmeNVHjLEmNK0i5kU1eW++/zMw7JWh2+V+gPLl3m5AoJ5dS0qro7++MG1cxEk+KWAW6n9zSt0smaDCYEMhljYy1QS2sKF1ECj88XV6e6cEFvmFqympI4ItZvSHerpkc3uuosyHvvtucOroewza0DFKsYGJy3LR7PlakY0Xz+7NvQVadYMSLk6QJxYWU+7ztpnR4HPKq+0CIU/Y29R4RShsVnK0DZWM6s4FC3+b0pEbeZoue6kVrwFYMLE4h9jJfMDFFmopt2SImTvyweCHRerU/WI5RxCL4mwwMz4HhcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re962i08Ve0BvWFYHf1zi5xWUPx8PT4+vyTAybzn8zY=;
 b=VEgsdhTZM/JmxVcYBnLE1TSSckHVVHblkcbsLOeByF8KGJ6OqO4X9ELjRcOss+badvKyK3fdxytXUIOEdWtUJcwIWxiA5YCH+OXPiA/m6L7Nd9G/fg/bbSWhKCVRXH7SPs6Z6QWQ8ONhFomNaHXzTsSi30kwsDyThljkSPwwItwMN+6Fg//cKY/OJJRttD01eSLLb+K1BqUT6rFNjrK/EOBpIOBBBGY6/ECLvpo2J1AIvhu1uUtRFuv1rvIs/y6rSPSZ8ATEEVrOooCXkTbc+egXZrP+zRP5srRs6q+aRkL69syJOEVytAaTepu0iEwnqntqC9icD3ALjb7iHWfA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re962i08Ve0BvWFYHf1zi5xWUPx8PT4+vyTAybzn8zY=;
 b=azYLhaCzRg8R7nOl2kn8WLXsr4ZCQhA4VmebcUtK0ekrKYyp5vkIT/szPIlTos3evfMwjmXapeNH+F4L479PlqHwjU019NsDn3jJv1/jq+hQHyuYkcnT49J2DEXPOin6e8WuYqx3i3v93z/tEBySADKNjEfmeWD73tw2N+whOTo2jvv9mvQpy06Uf/UT97HKig2Jj41JAa4oXvISfOLdPnLtnXqX7DDJXG+oziEsMD/T5zQle9y3VULFmgFUgw+kg+OmBOBplO0FoX5aSde2SHyd2N9lpAERs+B8DhLLQdi0aF7U2d2vRbJ7QU8cp9+EG4mhnsDuutVUWUwDQj289g==
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 15:10:57 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::a5) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 15:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:10:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:10:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:10:35 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 07:10:27 -0800
Date: Thu, 6 Nov 2025 17:10:26 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH v5 2/7] rust: devres: style for imports
Message-ID: <20251106171021.3e724b36.zhiw@nvidia.com>
In-Reply-To: <CANiq72kE9QFdAP2cTjBaxwsQ_H=BmMyabY9vSWUdfj0Ai0QZCA@mail.gmail.com>
References: <20251106102753.2976-1-zhiw@nvidia.com>
	<20251106102753.2976-3-zhiw@nvidia.com>
	<CANiq72kE9QFdAP2cTjBaxwsQ_H=BmMyabY9vSWUdfj0Ai0QZCA@mail.gmail.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 500172f4-bb94-4afa-f161-08de1d46b008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWRPUUlMclRDellUaGthMzBHQlZGcWd4amhwd1FRYStSajlLUmFoL1Q0NEQ5?=
 =?utf-8?B?WG81SDNSSUtnbnQ4bm5FU0I1NHRwT0FENnE1M1ZjLzZwakpEVVpLQ0gyWkRO?=
 =?utf-8?B?T3hueFZWWGRpcTJoYmQxakJBUTU1cHUwRW1MMFZXTXhpM2xWSWRYck41N20r?=
 =?utf-8?B?K284Uk01WWxSREl3ei9UYkw2RUZtOVBJMDd6RTJxZU1OUDFybDJnMm13dkR6?=
 =?utf-8?B?eTFGMGlwS0JBbnE0aWFOM3VFYy9Td2FOYTRmMGJEalRMZ09yV25kQktkRmJZ?=
 =?utf-8?B?bVlYRlA4NkVzRCtWVWI5NDk2cTY0RC90WFFvUW5Fa3ovRG9kekQzTUNpUWlt?=
 =?utf-8?B?WjVZL2ZucEh5cEpjSDUyRzE1WEF2ZmR0TmZJMzhzWld3RGo4QXNFaDFSTTJs?=
 =?utf-8?B?VFlXenZwNGhaZ1Y2bmdROXhuWUNDRkJHWEVDNVNrdU1Wdkt0SFBCSi9rYnNL?=
 =?utf-8?B?d1gvZ3Z4MGwzWk5ZdmdYTFVkV2g4bko4Z2dWbmxnZklzNEx1UWg3aUhaZ2Ew?=
 =?utf-8?B?aStOZW5lSkJjT1VuUjZud2dCekhJWHg1UTlXb05uRGJ4Qjg5dzgzNjR3ZEJQ?=
 =?utf-8?B?cGUyaTAwUjFpTTVNd2RPQS9DZEdmODdUNnlGY0t0c25HZ2d3UUQ0UXlLQ2hj?=
 =?utf-8?B?SnZZd0VBRDhCSFNCWU9XbFV2YkZPU0xDOTdSb3MwUmxlNlBJTTZzN041R0RN?=
 =?utf-8?B?TXd5YzZ5OE1yVjhaSlFsa01ZR1k0aEFqSjNCdnFpNFZ4QzNpS0ZOSDBRL1hD?=
 =?utf-8?B?U1VNd1U2QVBrRURVb0lQQXFkM1VWeVlveS9GdHNiK0VvL24yTzg2aGQ4dG0z?=
 =?utf-8?B?QUZMRXBqRVZzSUY0WlRBQlNJbEh1aVpxVVBOWVh3VmtQV0pESUo3Qk4rKzA5?=
 =?utf-8?B?QU4wT3A1amUyaDRNcXlsenZvbUxQWmkyZFRZQWJ4OHpVMGZWUlRKbnoxWmVz?=
 =?utf-8?B?SG5NNHpxRTdEL2srUE1uQzN4MjFRZE5kZUR5QW9HbzE2S1pJZVdCVXU0Zzgz?=
 =?utf-8?B?ejBnVjcvd3pPYllyNVp0THQ4ci94ektYUnh2bGpBL0lFZHJpUDJNU1c2a2Jt?=
 =?utf-8?B?TU96N0llRmRra0RwRlcyV0dmYitZV2llUzVqdHV6L1p5WGpTVVBNK1lHUDg3?=
 =?utf-8?B?RUhSN28zWmZCR290UmFZTGJYWjhsbG9jTjh0eVdRMUpGNGZiak9YMkVzS2Fz?=
 =?utf-8?B?bzZ4Rk1QdVpKZ2VXMk92UGdoYXlZdEdEN0hhSnNyUFRSVUZVbG1hTzBxdlpR?=
 =?utf-8?B?YVVhYW9VY0R2TlZCRGNwcG1sWnVDVDBFcjFsNVJqcTRBUHZ5NHNBKzJHTTRq?=
 =?utf-8?B?RXR5WVlKTlF2aUVFM2NmMU4reHBvcXpTSUF5Yy95bVRDTDVuWm9lZVFKcHhY?=
 =?utf-8?B?Z0VvaGFzT3JMUnc3OUY1b0NwQXI1Zm9senBOWHN4M25RRXZVVWlwcEovQXMy?=
 =?utf-8?B?NzY3Ui90TUI1UGJlbWhJcUhuNzNyZHBYVmJqZEdOZTNPSTNrQ3ZMcHlIZVFO?=
 =?utf-8?B?YW84NmlpeFpCSGpOS0NCbHhWbFMxMkpEbGVrT1BER2txVmRmUDV0SElVdVg1?=
 =?utf-8?B?bTlHTkZBWVh2STF2R0dXY1hGZDVHdjBzcVczVnRJL3hPQVNQYUYwRnhkVkFV?=
 =?utf-8?B?WVBESWJ1STl0cEdKcHJLZ2YzMUxhLy9oZmc2WThXY05ZbUJmVHVsS1ZMNWN4?=
 =?utf-8?B?K3FVRzNyUTY1OXRvSGc2TmNXS2N4TVZ0MHlxd09iUnNtMlVZOTFRU2Q0U3Ez?=
 =?utf-8?B?TGNBTHFaWGh0VGxyaVJUNHpPZ0NBRWhJZTlRbGRnNTlaL0VaYloybWNnM2pT?=
 =?utf-8?B?OUltY0xMREppc2tLSWVXQjF2Y2ZiY1A0aHhicERYQ3R2d2Q4aVZrbzliNzc2?=
 =?utf-8?B?c3JDb0oySzJqMUVhbDBkQThERU5zTHcrWFRQVlJyMDlOdkNiUisyWFZXSXNX?=
 =?utf-8?B?aUxvdndyVjVKT1MxWnNSbDcxcEl5RWt0aVlTdmRTbjBTZERMZXdEeXNwQ0JC?=
 =?utf-8?B?VFRwYnJUVVZjR1UycjZCOG1Hc2ljU1dscXRLemZDS3dvZUFOeHcvU3VhWXZH?=
 =?utf-8?B?VWphT2sxMXUwVTd2YmpCTU9HdEtYMS8zNWVsMitGVk5tbnI2aXRkMVFnUHht?=
 =?utf-8?Q?j7wg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:10:56.9965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500172f4-bb94-4afa-f161-08de1d46b008
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

On Thu, 6 Nov 2025 14:34:25 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Thu, Nov 6, 2025 at 11:28=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
> >
> > +///     device::{Bound, Device},
>=20
> Is this one converted?
>=20
> > +    /// # use kernel::{
> > +    ///     device::Core,
>=20
> This hides only the first line, which will look quite confusing when
> rendered -- please double-check with the `rustdoc` target.
>=20

Thanks for the pointer. Let me take a look and fix it in the next
re-spin.

> Thanks!
>=20
> Cheers,
> Miguel


