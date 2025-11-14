Return-Path: <linux-pci+bounces-41257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922DC5EB65
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0696A363E90
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673AF2D3A93;
	Fri, 14 Nov 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZDau9eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B99339B51;
	Fri, 14 Nov 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141264; cv=fail; b=YwuJhNW5pV+nH0oBDnbc2LNRGFVMS58cph/bFLBDXXRpPb51Mj5oWQfctJak0Q3g2BmXqQnPcqhhSRpt1Z4b/FfUFFbrs1ani3ssDrXgUUspRVjAZ04Dazxi0vj4bnxODdQMBXOvMG4N1DP4nG4xDLdj7UoJNFCJiv/4pWLFqdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141264; c=relaxed/simple;
	bh=udSTIv5G6xHl9ix2KcC/0pI3KYegpmHqUcpA5DSQjdU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOe+Tn3KbmTJjYvVHdcnU+MFHChFsqRS7MlPQPryPOpvHAHl+ZYW2+xm4V4rmCJU2TSGR2nWfEvXefniXxJ7t7hb37si0uedSI0N187dsT26NV1g1liF8xptpXLRf+hOVq5I43O4SdRu0PQi2TkkSGbpRiEuLRHT3pXwAsm7Fjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZDau9eg; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjPZuQvH8/vO5xdKNp40VmqDF12ea68C1FoMOT74okP7IX8s2lLzbUPIxyX2N+bBQSuNELflbJOgy+6/CUTqHAGFuuHQzHnqMu3tiS+FO4GvcXD+qIIDaug8Ktdg5PeR0GvS5Qa8rnsQ9m+ZdiiEHzhhw3FEvH1FlhlEy3DmBS5rNfivL9Udst3+OpcWVzr+N9CJe9oe+3sQHni/N8FMB3LKZVsutNZHuJ4ZacElep2wyL6Vpqw77rZBYcLRjRMyLwdtv9bSZOOs22VFFHQy11ayiZqNPCaySOiFlbh5SFGn0urKLbxSak4pEK0EdTXdB3HZRTkT+hVH2oEy9Fj7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L43rGTl6WWNgGSPOVyZQps50YcKq+Sju9yJwnDEXD9M=;
 b=w2Lnx1QWg1IG7pttMdjx54z8/AI7JJPXSC0gM1uTLtPwUaYb5mTFPgmy2QLIsC/RaxEhsq2wX9nwVZmCwj8cEqbXH57ouKgCHY98ahqi7qO0KTk4wc2kFlzCGnwKT7nhAR3f9aTnhPXdphR3Ml/R9jEKYmeqpMs0OEF/Z/dkIKeFbqNrGMtuLUgMmDQ23isQe0Y6Lfrd5x68QbYQnJEH8DCb8o/qmIX4uX9XqLe/QpEhH6q/axSiBiGVj4+D8LzFxxeru14bkgeVzfCZXMZ1MEFhNU0CwYysfUUW1qvuP2veMNElHolcHUV49bhpHe4hDGkVpr9Zrn91cUZ/nkqbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L43rGTl6WWNgGSPOVyZQps50YcKq+Sju9yJwnDEXD9M=;
 b=AZDau9egjnaQaAFD5/Cgq8Uw/OkWf46YnGg1vhclHm7lgjrXR1ttU4xOWjPuuB/I69BkEQOo2oac/zJf2gAT3WCaBbErE5LMWlLC2Nxcoo02x8x0Rper7/HIhRxr2UaNinds07ExX4ovSQQIvjY3+lkef4pjq4O4qqbtIQNsL+0Ugxtpqbcj278qrRKTOL8nGANPUDNNfFI7UEL8jvLXuZRK+J8Qn2JXMagHkQOPHRkFrUUy+rSB/b8MzP1lTNDS2C6rNLsDXpTpaAmDgpqfzeS4wmTsgSYWIsfKQLgVKXGRDYuJkev5XtP4YsjQjCdntql7AFzXOw41DBcxo3uGFg==
Received: from BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 17:27:36 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f5) by BY5PR17CA0034.outlook.office365.com
 (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 17:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 17:27:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 09:27:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Nov 2025 09:27:27 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 09:27:20 -0800
Date: Fri, 14 Nov 2025 19:27:19 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into
 Io trait
Message-ID: <20251114192719.15a3c1a7.zhiw@nvidia.com>
In-Reply-To: <aRcnd_nSflxnALQ9@google.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<20251110204119.18351-5-zhiw@nvidia.com>
	<aRcnd_nSflxnALQ9@google.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e9e54-c61a-4134-e368-08de23a31a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQ0wmx055DPRDOYDvJ6CwYxOV/Neqza0baYTjBPRdx0gDz/DSOxhriBXOk2C?=
 =?us-ascii?Q?zPI7PEsysbB9UNqHcR1liF1D5pz/x8O8g7qKhAxgBgFG23SEk+xkXVvFlSVR?=
 =?us-ascii?Q?6rmsEP942afuCFVBhNgNPDjEsgq9T+UNVQW+2GA3GIaxBsqRCilwggEhk6O2?=
 =?us-ascii?Q?2O47bVAvRKnnm9DpCO2bD2pVyV0/GlkcfclLL5TsIIVWzXtwN2KabKiKsFtI?=
 =?us-ascii?Q?6jfjcpFrn5AfyvV3G+uD1daUWWRG/n1WYvo7ThONzpntxMQSDK6R2FhbJDVq?=
 =?us-ascii?Q?kPOnUkmmMvb1HNERPDuKXm5ZqfZGbvfdJNtSa30G3zR06r3oIgyln7xgJ2ys?=
 =?us-ascii?Q?HxrZ74Io1H5fVNmNUVQHeLb2Nfs3zj7oGcrtDNXaWwPCHDUIlv5v+M4JfhVb?=
 =?us-ascii?Q?RXa/iRVlmeVWkIFDeyDKTQASTkMsXd6XWezOAnAp8VZmo08VZX4PX1IzvCAS?=
 =?us-ascii?Q?2MZWE7Ns08mjNM7+NZHXZbnHoZVa9/hxZ8y8RRkhqfypdmz/q32uOMeLNLZx?=
 =?us-ascii?Q?mgHx4ocmoaNykuCPdAHaedtqZTeL0jYC6YMi1RCdmbly1O8n7DFHztRTPG5s?=
 =?us-ascii?Q?QFzwwylfojSU0j0SUdPtPQD1a41CoR0RmM33YTvQkxFWvl0BlbLzslpGOQMX?=
 =?us-ascii?Q?2LWcG6r+9LroECqilQWWo/5DABmLrJuOruhjfjzBhY5pOxvTtLtrNX233CqI?=
 =?us-ascii?Q?swC3DdggUuDQ4cvjw1bWuibR2N38Mfx041q4r+3zZ4BMWk8Y2VdHO+LcmJGM?=
 =?us-ascii?Q?CJVocLeKFwaRCYvdVo4FwqxlFT/xMzjeu3xf07k6DpUoo9qlsXILWof52NIj?=
 =?us-ascii?Q?zxb12FRyc5jLPRlpNNcnwMAUFWE5vfJ9sqW6nTVmCZm6CeJ28w6zeNgGu6vR?=
 =?us-ascii?Q?fCZEyfv1kP1NCdjyh+T4xXtYv+XIsD48TUaUP+CWcCIswXRRABKGQdYVpcS8?=
 =?us-ascii?Q?nc9tMsVRfGgRc3dPif3eUPqfrBa+rgICYzl5src2nGoEK9VoU6xY3kf3a6m5?=
 =?us-ascii?Q?rb0UgGsW8o9Jlr/IzB7fiGSMDL5ThuvqkYEErZGZjxtp68FIDw1uuojpnxwZ?=
 =?us-ascii?Q?8EiJOtB5qEyZe/QZLSj7DFiuEvB+/aFBQ8Sb2EHXL7Hbkwpd3iCZfhz5sx2a?=
 =?us-ascii?Q?Xr4BFMDCXB9KUaf1dhBeXWJ40zq8mJb2SehS0Re/g9YCICZqepUMuz3XrF8L?=
 =?us-ascii?Q?LJWNJxc7mBARtkurPQrN3NI3YSijRHzbopMuDlcQmHnMyZqyDobenYh4EkQm?=
 =?us-ascii?Q?Fkh91suU8/Yb4iCZJhET3qWFiWG86V8rKMa0m9YBMBb7vFn9o2AFTeqlwBUX?=
 =?us-ascii?Q?7ltxbp8Wr0In8UI6/w71ddeOqDRxY5lgoEvrhUWPfZF0PPODqT/JQeWfIPl3?=
 =?us-ascii?Q?5BoDFWeylD+Mp6U2JN7yLknCYB3jxr538RU5gOyd3Kc58tGM2ANyQxaLYdSR?=
 =?us-ascii?Q?2+exM0ojXb06U9Gff5NXlUeRkqSxaGPSB2G508JxRRcNL97shCoOEvL2Bgyl?=
 =?us-ascii?Q?qDwPD0l6YLcNbbqk4+WE3Pg+BeNZwDgOQLEKuINhU+hEkjaugYlOiiim7vUh?=
 =?us-ascii?Q?AveI8zBUhdanM4bpiV2BPAe0t+7Ibb7ERwOgLxxp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:27:35.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e9e54-c61a-4134-e368-08de23a31a30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

On Fri, 14 Nov 2025 12:58:31 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Nov 10, 2025 at 10:41:16PM +0200, Zhi Wang wrote:
> > The previous Io<SIZE> type combined both the generic I/O access
> > helpers and MMIO implementation details in a single struct.
> > 
> > To establish a cleaner layering between the I/O interface and its
> > concrete backends, paving the way for supporting additional I/O
> > mechanisms in the future, Io<SIZE> need to be factored.
> > 
> > Factor the common helpers into a new Io trait, and move the
> > MMIO-specific logic into a dedicated Mmio<SIZE> type implementing
> > that trait. Rename the IoRaw to MmioRaw and update the bus MMIO
> > implementations to use MmioRaw.
> > 
> > No functional change intended.
> > 
> > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> 
> This defines three traits:
> 
> * Io
> * IoInfallible: Io
> * IoFallible: Io
> 
> This particular split says that there are going to be cases where we
> implement IoInfallible only, cases where we implement IoFallible only,
> and maybe cases where we implement both.
> 
> And the distiction between them is whether the bounds check is runtime
> or compile-time.
> 
> But this doesn't make much sense to me. Surely any Io resource that
> can provide compile-time checked io can also provide runtime-checked
> io, so maybe IoFallible should extend IoInfallible?
> 
> And why are these separate traits at all? Why not support both
> compile-time and runtime-checked IO always?
>

Hi Alice:

Thanks for comments. I did have a version that PCI configuration space
only have fallible accessors because I thought the device can be
unplugged or a VF might fail its FLR and get unresponsive, so the driver
may need to check the return all the time. And Danilo's comments were
let's have the infallible accessors for PCI configuration space and add
them later if some driver needs it. [1]

I am open to either options. like have both or having infallibles first
and fallibles later.

> I noticed also that the trait does not have methods for 64-bit writes,
> and that these are left as inherent methods on Mmio.
> 
> The traits that would make sense to me are these:
> 
> * Io
> * Io64: Io
> 

Hehe. I had the same idea here [2]:

> Io trait - Main trait + 32-bit access
>  | 
>  | -- Common address/bound checks
>  |
>  |	(accessor traits)
>  | -- Io Fallible trait - (MMIO backend implements)
>  | -- Io Infallible trait - (MMIO/ConfigSpace backend implements this)
>  |
>  | -- Io64 trait - For backend supports 64 bit access
> 	   |      (accessor traits)
>          | -- Io64 Faillable trait (MMIO backend implements this)
> 	   | -- Io64 Infallible trait (MMIO backend implements this)

I am struggling with how many IO backends actually need 64bit read/write
other than MMIO backend. E.g. SPI, I2C. The conclusion we had so far was
we can add it at any time when someone need it. If we think this is
necessary, I can add it in the next spin.

[1] https://lore.kernel.org/all/DE00WIVOSYC2.2CAGWUYWE6FZ@kernel.org/
[2]
https://lore.kernel.org/all/e7a75899-be93-4f0f-9c9f-0d63d03f4806@kernel.org/

> where Io provides everything the three traits you have now provides,
> and Io64 provides the 64-bit operations. That way, everything needs to
> support operations of various sizes with both compile-time and
> runtime-checked bounds, but types may opt-in to providing 64-bit ops.
> 
> Thoughts?
> 
> Alice


