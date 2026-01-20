Return-Path: <linux-pci+bounces-45292-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCi5EK3Gb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45292-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:17:17 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4E49487
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39C6A4155B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BEA256C70;
	Tue, 20 Jan 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEArwKV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4B33C52F;
	Tue, 20 Jan 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930048; cv=fail; b=mQ8wtKOuGDr10+OobIw8J4q6+e5uuwXxXxFDdzNG/rxShfzAg2IseYJq7x6aXFBpsDOtdexcXhbDRDJ55vYU9jOkDhpxURF0wVXKdZVBKInYS3qbyFjKIm/ymEqoZlhuF8sRIgMwrzin/QgiawilnILdEiDsnX0Fe4ey4y8A/Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930048; c=relaxed/simple;
	bh=zUavny+K23BYBACKk0bPdmpxKcbZpSXwNM0wbaF7Y2E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md01A5k3/66rFytGR/7O9LX2SI4p9nzxMpFSYb9ZiRyFfW+Pb+sTc3ZNkwv6a0f+idRHL7GasWlETzvZPkxTwiJAnc+qctVxpyI1qr4lDOGsFdxIJacEAVE1NSSC10hk9/kOls8YjNvJG5rT/xcggmE0PoO3a/A9a7J+X6r0esA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEArwKV+; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afQYSz9Maf4OxCXoXbrkpgur9ZpOd4ryvh9lXmvVNNjd4R829wDSAGDv181nNY0Regm6StFEDJkuYQMsDqp+YoLPwNLQ+xC/LGd++WBjeHUi8mKlvbKz+Eron5fP5fYThUkt2XKgDwBINVCS08xrXGyVNF3qp9paIgijT0cp3oCFkrmRraPfVt7DxJDQrKMwdqrqsUePC9tDuOIJkkRwKjeJq7/tRLgHYBzZ7IKH9llbcblfuadmdPtcDXsq7xbx8VnY0yVUwpKHNoYYEgHLm7QYkKjMYlitKl5bk8Aqn68UNPcQA18Jpbls8MxELw1ScvuvXpwi3rD0hTp+MxNPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXqLlZRAo4pSK0JCi+mQkuy4BSunvNGTU+LOmFGJFHk=;
 b=w2OPNAR79KKQJubbCXbqkqo+BkUjaMype0EdRrFY2r7WbfJGo55fvpwO6NXAm8sKzAEFDc9xisUMGLbMvCKcQ57IC1xRIvDT22HHH75Qbd1U6fM8Vsg+gGs2rSXO1HP3E3oplBXWwzDZ7mi46hWE5D+RGHu3sFQK4OHbrHf71aPj8xSwyPSMkgki3N5caKt/ivo/QKAg8359jxBomEX9wKqiCJlYhQ8m1idAl5BL5JJQGE+6gbOlMc3woBK7D7LxtJUKVTVc9JMbySiRmCxv5gcjXWZe97rsFQImpCN4haz1MY799yP1ZQnadCCgFM0YARGzqXKQROTBhivD+LGn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXqLlZRAo4pSK0JCi+mQkuy4BSunvNGTU+LOmFGJFHk=;
 b=IEArwKV+oR1M22BmrYg4TZeYCjAL/OM16SgFMcnNRzmQA5LTTvJazafR7+Y6KWnPuAR0RhVs5I4MaYG74driWhtgW/ZfxQKrcYsNAicEHOxUA6yvBpdFfB0O6S+ysSQFfGrx+Ki9Ljagzw4Ttu6HZOeTZjga0BataU8fLCQYJLp3HWRKKR0208zDKllNMqHRc+ath6R9ibEx7P7yngxThfb74FUkwxETwgbugBGxFIJvcAirijeoY+A5V6lASRmyfvy6LLzxRt+1jfofFnsg56E8RT2xBOgXOGQ9avsDq7MvlgyjPf9c6xMuGW+j3/7zeJVbA8uVpCEu5zQbTStFxA==
Received: from CH0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:610:74::34)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 17:27:21 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::11) by CH0PR04CA0089.outlook.office365.com
 (2603:10b6:610:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 17:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 17:27:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 09:27:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 20 Jan 2026 09:27:01 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 09:26:56 -0800
Date: Tue, 20 Jan 2026 19:26:54 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Alice Ryhl <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Message-ID: <20260120192654.014ba848.zhiw@nvidia.com>
In-Reply-To: <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
References: <20260119202250.870588-1-zhiw@nvidia.com>
	<20260119202250.870588-3-zhiw@nvidia.com>
	<aW83HV4lVR5MQlDd@google.com>
	<DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: e0707a8a-d5c7-4a24-99c0-08de58492a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALox7BvwZuRBzRy9xnwq1WN+8a+Aha54gPmEz+2naFnTx8QfwGezzZ4UfFNU?=
 =?us-ascii?Q?EtMYMmHclJ9PVreyAODo6ya5yY6lkZf26Kt14KppaR2mhkJuhJvV53zUYfNB?=
 =?us-ascii?Q?09HdAq/F0Nr2uwqxuxEbnOtkfgickkoGsBhaTq0RWKTK6V2oaVHIigA2kUJ2?=
 =?us-ascii?Q?fnHEn+J25hYSZ+/Yv/KfnYch20alWKStbWPyB1c9lovaiGIarh1RQZbKfvh4?=
 =?us-ascii?Q?EpRme+kXw3ePGEZe3hWQp7GOuAK3lAa7OUJnycKiMPRMXP9F+cox9HMyLwUN?=
 =?us-ascii?Q?/yhDcQQHphGr/v1D3x9SBFNxKFy285qOfNU+oKdB6HFv/L5xBhg8TreA5SpH?=
 =?us-ascii?Q?MAmfstRkUu2D86UUJclhrAc/mvmOKul1Nii9m7yXUVqeqTY96a7j1CRsEeDz?=
 =?us-ascii?Q?xDjtOj5m3RPlcqNo4GwW0gaPaQ39Ts3LuLKwkdWmkO82AkJqnL4kqv/CiV9R?=
 =?us-ascii?Q?xmRAN9n/nLP84cuXXqHF7NziSKYtYZzNG13b36Me1jI1Uj0C0WNKayKkV/NU?=
 =?us-ascii?Q?/TDGs8FHfJsxxLQSWD1RACiVIVyWC8oPz8D+0eWSUr8IIb8nqyUxo+Se7/SS?=
 =?us-ascii?Q?4X63FKXqMvYCAtCg+MOyn77fOjI92X2pmI1Wvumj+OR0uJXtiSXJUu8EN6Eh?=
 =?us-ascii?Q?EE3XMrnr79HxTNybfXDcJy4yrUuza7Onm+r6K6cIeNrP/+ybzdpT8WzmlBTP?=
 =?us-ascii?Q?zUIivGOixRq+oTju4uJhvZ0BSFu9lgiiWkYFdwDjM6OF1awuC2RYAjziFFbw?=
 =?us-ascii?Q?/y45C0azqUAX6LOtIFqgEON49d766+zwxc7tYZ0h1vLfu8GwHePIzg9vmnC7?=
 =?us-ascii?Q?Wij+qdWdSsrEhnBALGhLxUn6bzLGcQaD38ifIZUPGWjuGOWdH91d8ZNQf/Fv?=
 =?us-ascii?Q?VAoMTBZM1c1FJy+xA+hSvqHnN1metgn5iJ7nmIOBCO/Cltd4IcPWLAL6LTun?=
 =?us-ascii?Q?9udOAyPO3OBd49FADfQTeq485JAu9xTRWeLmLV+brmI+tOSrqb6wcEUK6Cx3?=
 =?us-ascii?Q?XXvOAMTA2nvGciFw9Y/iNkZrs6GPqObO+fW7fGOSgQBo2jMWjZK4RUOwpKrO?=
 =?us-ascii?Q?XozO4rcO+fDP4EIR2ntgMBl8f20gKKZJkGqnkqK1LXYjscpPzGEUcjE+5QEt?=
 =?us-ascii?Q?kVxZmCWm/bT+Rx4Db22dLw9uhaNC3Apjbb3oAtea+AAHfcCPDNEQDwXQ6yUU?=
 =?us-ascii?Q?G7mqDEMwAd2QyXvdqjQnEg9qOLacLZ1chiPffWlKicIqhFb/wqyEzyMkaVq+?=
 =?us-ascii?Q?CQFpKCs6cxy3bKC99/n68ZMaHvcgEcj5BJt+CIstqdygPTIt4po+D+WXuSYr?=
 =?us-ascii?Q?RFlAvAVMQVhfB/0vihu+DjPULZcHQauRFOWn8C51SnlkgATHv40NQMqt9wrH?=
 =?us-ascii?Q?eD8hWF8UblJQer7q7kMqF2/qNZbn4YDLmo0qUbO+kVD76XQK2RB84gz8RSV8?=
 =?us-ascii?Q?9yuMgsjkjgds3UtF0P7B9mTCqeWH3yLcD2ONuPDPSJ+Ke+GV9UYKEt+TQZkz?=
 =?us-ascii?Q?p2B9LiM0LxuiYqkyJ4nVVKO+bZfxfmKnepooUn/X6Pxhs7DsIIuL8UL+/EFp?=
 =?us-ascii?Q?D8o/9bi0rmmBjYe/yLm8RuA1kAoUwstGXr1Cb+jNjbtF+It6dBCKDPBKzM90?=
 =?us-ascii?Q?Q0dS7uRuTj5lZRx8TCLM4UfwkUdjUhasMpCAsYr62+xmainp/bQfGyHb2xz/?=
 =?us-ascii?Q?Z79uaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:27:20.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0707a8a-d5c7-4a24-99c0-08de58492a95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,nvidia.com,collabora.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45292-lists,linux-pci=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhiw@nvidia.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A6B4E49487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 11:12:18 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

Hey folks:

Thanks for the comments and RBs! Agreed. I will adopt this approach in
v11: using a single series of IoCapable<T> traits and retaining
IoKnownSize.

Z.

> On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
> > On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
> > Overall looks good to me. Some comments below:
> >
> > I still think it would make sense to have `IoCapable<T>:
> > IoTryCapable<T>`, but it's not a big deal.
> 
> I think with this approach it's not necessary to have this requirement.
> In practice, most impls will have both, but I think it's a good thing
> that we don't have to have an impl even if not used by any driver, i.e.
> it helps avoiding dead code.
> 
> >> +    /// Infallible 64-bit read with compile-time bounds check.
> >> +    #[cfg(CONFIG_64BIT)]
> >> +    fn read64(&self, offset: usize) -> u64
> >> +    #[cfg(CONFIG_64BIT)]
> >> +    fn try_read64(&self, offset: usize) -> Result<u64>
> >
> > These don't really need cfg(CONFIG_64BIT). You can place that cfg on
> > impl blocks of IoCapable<u64>.
> 
> If you agree with the above, I can fix this up when applying the series.


