Return-Path: <linux-pci+bounces-40225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C0C321DC
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A616E1889E37
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E4335097;
	Tue,  4 Nov 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRgM6xfu"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06892335560;
	Tue,  4 Nov 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274607; cv=fail; b=HZnJmGEFyqkug2Sskv5QtyplRmCVvjSQQtGhTW55IDpXXxcwOrBlNwNIXK+GS28d2+eY4Zq4Mtutn49n/1Lk5OGunnvuSxFnxnKUuFOUH+nfwOdClWeSDXCZxyIi7QY3b7WyA1S6vZ0Py3Z1ydwhGxBC7TZz+rsz2LsJhoIq/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274607; c=relaxed/simple;
	bh=6h22ke2MOMEdnq4CG8dZ8e1YrIHON2q7rAgXKSNts0Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itLDcAh25lKDKg+PlThhiMLnjmszpR+OhINnjRcxKHq9db6Crc5zx8kNJtLXFgFfpPhjSthdDIoFFZWVS5jk0qW9rCZAb/OuRsFqnxlaBwIdMpZp76D+cxPIwQc/BLRsAPGEZvWyWhbzTIQUmo/9twafmLpVRuFMmYe9vc0PUFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRgM6xfu; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLFbWLpEdMtNRkEkiiod60N6tYrnKGiBOsaCi1WLGYdmW5xBr48MM+9dCvS5uVIR5U2ZNB3pnzLDufGMC0p2Y6GYewBxJZ/ei8kNdrCIFAE8MxuVfYw/NpudT2EB12/hDLc7VAMiaKCAd27BQ+BL/huxNV1uw9eZcDGLw5CEJtBE/XAsUS0HLvlvb/v6ov8Rr4vORDirvZ08qOjd4itHjxHqToU6B7vxmJa54pvAy2K5jGdD+neLHmImCHo1hoaaNNhJChUVfUY0GkKYhQiCMgVvmb46F3AszonoosgKR5opvMph797CfGCGpa+0uJ+Ievlr++Yu4EbDhYu+1a6Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmDKguMWHc8YxI3SvQiyX3YEnBrQLnuSQwHNfasZSs0=;
 b=e7WYvD1H2RzAxsAmDmPb/giA2xGBXqdMMmM60Hzw5pV6qHwPp26K/yXXbp8y0HQodqcVwfmfvkw7nF2n/U1UOBtfbMehuJzRFbVw0b9td8fHuTEGjS077/XwkQbkiPq2CHASlsf70J1BpUx7gkm0MWCPogDnED9XIKLHrH5FONdWoLxi6HCa5g6BtAMYzPgL/OxEb9HkU6hCd70HzkgcDfgqtBKg4hXdBKoYHWB1tCQH/KBjca+ygikUldV9IllL3hEgTbgHwUoDW8lCPYAKwvWp060NXbgsFLIAG2OaajjUkcsnRVaXQWdSgZxOYEfxLdG2EqIZGwQdiF7zV5CCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmDKguMWHc8YxI3SvQiyX3YEnBrQLnuSQwHNfasZSs0=;
 b=nRgM6xfu47tNBLdHnp+eKQpZeINx8UROqR6cKU3Sw5LyHgkzyIJwzTFnaCQNYE+6qUSRf3mIhPdyQ4HQiJP3+amnW9Ry8244v7UYQ2TBW0GU5OTo/pNupfsjNeWQBOtJn4BKzH26xZ1MwLFOo1W2mUT+ZrYRZUqA49BaOuywlXPWU3PXN8whSD4NLdtCPdCw3vbKAizPe7bGxQgdWhEqulEhpqR6PA+OvO5zbAyxwfmdp+nzged8Fr9UPBKrAHfsi8WOhiykHuai7JuAnJAAABbNMeT18sP/2cVr2rhoBHna62afu8u0GxHCZHe2cE9h1sZ0Z0C+H6XArGgzYGu3uA==
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:43:17 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ba) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 16:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:43:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:42:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:42:55 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 08:42:46 -0800
Date: Tue, 4 Nov 2025 18:42:45 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH RESEND v4 4/4] sample: rust: pci: add tests for config
 space routines
Message-ID: <20251104184245.2cc7e661.zhiw@nvidia.com>
In-Reply-To: <DE00WIVOSYC2.2CAGWUYWE6FZ@kernel.org>
References: <20251104142733.5334-1-zhiw@nvidia.com>
	<20251104142733.5334-5-zhiw@nvidia.com>
	<DE00WIVOSYC2.2CAGWUYWE6FZ@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d4e042-dfc0-49e1-7daa-08de1bc140fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qc2sUiCN0S00e4yyxThSZNgaM7efdwy14DTLibvhLAM0YvNunWQRx3fUcm7g?=
 =?us-ascii?Q?jZdjgQ5/kvVaSG7AHL0pc4q3KjbnyUgmCB61mYZXAGlhj190mBJMyZoWGenM?=
 =?us-ascii?Q?ZMb3JcDFUA/V8VqLutDnpGkfAa7lP/z+7u7Knayy9JtxH1A+TjyRhsJlB8WM?=
 =?us-ascii?Q?2P6WhKVVYab4XRAKuQvJFSKOXaEISoyw9VsGdS3BH3joyrRshDrlQTK/P+1o?=
 =?us-ascii?Q?D6Gl46oSOdLe50oQVuwUTItR/Cro7xGScO4fGKA9JrXUDBMtR8N7ycfFUr5/?=
 =?us-ascii?Q?w+aNcmQvO+NW7NK1Rix7PTdxEPcajQuxk1WqMohwEfd8IY/NsJzRjiDdIpCJ?=
 =?us-ascii?Q?0ZzoMgsj54ntjVThEuts4d/zzM9MH/nepdVvvpNWtcg7qTFvgHiiZnG55444?=
 =?us-ascii?Q?HhhYcoZaro5pP9wR1p2e8Oc5Dvh+vss51GcQTcaQ4qieWfkxiJk242lBCqw+?=
 =?us-ascii?Q?t/1HzkscCQSy0WzfAq9cc73nUvT94MJpnsLuXRHOjWkEJc2UDjbb2UJcQ3yJ?=
 =?us-ascii?Q?4n6EKzUwGyOQN8mDqwkjIUgg5Z0kMfMDU3BesMw5T2/tv4CmX9oTwU1/mvr6?=
 =?us-ascii?Q?u/BdWnMFsqzzSuLZPUSvFC6moMZbIx/9C/zeIUWfTLany5jUtSRcPrNRCuJp?=
 =?us-ascii?Q?1dDLXrPjQATfi6FuVQg84Revyfq70pfhcj47FRKrrP4aFxBvN3OlBKoT32gh?=
 =?us-ascii?Q?Mznrhd+Iyf0i770K/lDRIOndV7CShTO/3WrVMN+iYW8WTUF379YMtxu3Nfd3?=
 =?us-ascii?Q?PF9SpFZzwrtQEXLM7AtRf6BcAR0IWXz8hluEWgo0gMH5hDGF1hMoLv+iCNyE?=
 =?us-ascii?Q?7jjysrwTThKZKqHCCXjijL5Z/c8WLeE5IIELJPPE/EbKLa+846O3lZfGFFiO?=
 =?us-ascii?Q?/SHXU9AFgjLOm06J7LboXS/W8GVeyU6CS46iXuFzXM8uMD9FeZLAxR+lPF6r?=
 =?us-ascii?Q?wMRQsgM84SzC3H/r/QGrOvHg4pBG3VysCTgqoYH7Qd1ed4ubgVW3kMq73YmJ?=
 =?us-ascii?Q?ZoKa87LVvjdU+RmqmzN8vKmmTFonh60XXWLNc/XTfWAdJSW6OMgAyUHwGYMr?=
 =?us-ascii?Q?a/G0pc1GkMiNyEKq8f78bVuS/DOO0CBuqnHG0CHTVIwg4M8f1zMi/FsLu/4T?=
 =?us-ascii?Q?7ahAhNVVa1ij0efzZGUPxYTUSLuspmFpx8d08BbcYpJRs7pwrYu6WdmC6Ua2?=
 =?us-ascii?Q?jXtfRJ56Np+jZ4GjHtvYndYZBBmLYPPTxuxQ2VynzPF7CieyuG/dvIs2eOHv?=
 =?us-ascii?Q?pCgL3RYyeCBo2FimB6aoxcksYJAWdml7JhEJWDM9uEv8Ngcjqel1qfaSR3Fc?=
 =?us-ascii?Q?Bp99He1VA65sKLyB5yPRU57B8bsR6btb3qfheILrUQN/2fj4Ekw5IHADgyZC?=
 =?us-ascii?Q?C64LZi0JsQMU0FTbGJd9eVaazdDrUHzz/+KztQyAJ/M50gpcV3+XiTJxfs74?=
 =?us-ascii?Q?hxkh8UVyVB9UGaZltRvwJRzzedZlLaL3tDCFirL/WQEOp8zfz69n6MN/QNZM?=
 =?us-ascii?Q?5468t+IaVLWgziGAJtkdnERIeIk9H/gaafPbMqQkYv3yh9PEs71iRUGFzWun?=
 =?us-ascii?Q?HP3dz5q/tPTENFgfLxI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:43:16.4894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d4e042-dfc0-49e1-7daa-08de1bc140fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Tue, 04 Nov 2025 16:41:56 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Nov 4, 2025 at 3:27 PM CET, Zhi Wang wrote:
> > +    fn config_space(pdev: &pci::Device<Core>) -> Result {
> > +        let config = pdev.config_space()?;
> > +
> > +        // TODO: use the register!() macro for defining PCI
> > configuration space registers once it
> > +        // has been move out of nova-core.
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space read8 rev ID: {:x}\n",
> > +            config.read8(0x8)
> > +        );
> > +
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space read16 vendor ID: {:x}\n",
> > +            config.read16(0)
> > +        );
> > +
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space read32 BAR 0: {:x}\n",
> > +            config.read32(0x10)
> > +        );
> > +
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space try_read8 rev ID: {:x}\n",
> > +            config.try_read8(0x8)?
> > +        );
> > +
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space try_read16 vendor ID:
> > {:x}\n",
> > +            config.try_read16(0)?
> > +        );
> > +
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space try_read32 BAR 0: {:x}\n",
> > +            config.try_read32(0x10)?
> > +        );
> 
> If we want to demonstrate the fallible accessors we should try
> accesses outside the bounds of the requested config space size.
> However, that doesn't really make sense, because in this case the
> driver could have been calling config_space_extended() instead.
> 
> So, I think the fallible versions don't really serve a purpose and we
> should probably drop them.

We can add them back if there is a use case in rust driver later.

Should I arrange the traits like below?

Io trait - Main trait + 32-bit access
 | 
 | -- Common address/bound checks
 |
 |	(accessor traits)
 | -- Io Fallible trait - (MMIO backend implements)
 | -- Io Infallible trait - (MMIO/ConfigSpace backend implements this)
 |
 | -- Io64 trait - For backend supports 64 bit access
	   |      (accessor traits)
           | -- Io64 Faillable trait (MMIO backend implements this)
	   | -- Io64 Infallible trait (MMIO backend implements this)

I am also thinking if we should keep 64-bit access accessor in the
backend implementation instead in the Io trait (like {read, write}
_relaxed), because I think few backend (PCI Config Space/I2C/SPI) would
support 64-bit atomic access except MMIO backend.

Z.

