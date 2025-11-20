Return-Path: <linux-pci+bounces-41729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E2C725CB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7900F35163E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6824CEEA;
	Thu, 20 Nov 2025 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nGnh6niN"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4BD531;
	Thu, 20 Nov 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763620921; cv=fail; b=YzT8NoHFkPa/CzqLoRycbpDEP+Aw58eQugnlRWSU67gJICtAao4uLaxpiWKMAZCacy2X33XZkjukcG5uMbsuh5V4REEYINrIBHf3ftVKPgFV6v/FedAesBqBC9dxQ8s1QXvuX+Qx4ejtxHKX+rad7XnwwXnSCYc6+kYqhxqQcb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763620921; c=relaxed/simple;
	bh=b8sxFjNUBDZ9B8GN4o3Ezwg5pjTzmCHDUev6ES/VqKI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkI9MDyineOINxbwNkuWM9klq2NDDgysnekNNXU7aCt6rAwr7en1yG3kG6mCutUSAI84/0CQ0mxM2P7Sp14GX5lMpE+1GdPJLPvZfhWXdUV3ZhmgCBt3BJ5zodT9VRqyGGgtZAK5E2CPoEzCfIPJuGn2FCQkasm9AFiV/4xJEAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nGnh6niN; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5uBpylhnT4EDN1lxP9M4x1QtWtB08EX/XBzCZJtWAWrwYs+mQF06OjoUr4HYFkF5mRNxMPAUT3HyqjJuy0sXD2lRX+EA/ZMBeXDY1H7uGrwB0kca+lYzB6ijjl2JS7wh1zCaDfIii6U90tfWuTDcM6NO1S8s3U31HhBpxCe2TQqyulmiz5rskQDX8BZ39l/zFLC3q5ucooekdSx/93f3y72iehsjfSXvREgUagfrYIkCSTPMYatsYdo1CnILQ5GpfAhbPrklyP9RRhDa8nN83XxwmgSEuWSyhhE+pUUreJJ8LgqmYot4QCQ/R9cR94P3oMsHUsJyVwQ7Wbjap1eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXGrjpqXFz47SDKvb47w91DV/t6wwUzprMcZCatP+DA=;
 b=Kq0jCq026p6LIvwEfZNfWbyK4N32eCle8assLsB2j8aF4DVL+I7yLb8wAIZuHXc1bDqG9nnO+mTVLx3j0fpjiJvZg4VbtbKgCfihea3Klr4mIsec0RqQqdyPc5ZM1FjWn2Ek1sXnw/j3O9sBAxmitzjv+C3tqPjtsZAC+d5CKUvYu4oSizxkMMqnL5j00qDDNIll1s6hAWO3TqilaYa+rbYYOXejcJYiTb9LA1DlTwerfLqQNJfeYXSdd3VdmQNboPeYfmt9AV+5EUTJ+muN272CfKtdN/B/fbBJQESU5hCVMIl9lSoxa8kYCI3Gcl72+ipd1EB4ZLwybTb+FWpY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXGrjpqXFz47SDKvb47w91DV/t6wwUzprMcZCatP+DA=;
 b=nGnh6niNKhhGdux9SXAnVK65mkIaDMlWFvK1E+BHvXqKFsp7UtHYf23x0lPJyPm6ll/dahCOyPziVRp7ALjBXSJMH1AoyT1UfufxJ/7JTffMPdEV1XkcPvFNmZuHBrFrqMwU2puCUUw27tfvxidVXs3arfSEaEAMFJstHmaRNCe1+NdMQNzoa1zUNlr1D9akjNlF4T1OIokxuH+kM7u/8LgkI3VfV8xvFpIXCNZrGkExmxpp2TvuIj32+DOQ31einmjyvqTGs9YMRxZMS8rR6qJjdRlZURV6Zqmo9vsF9GnswH1urYihwopfxXIHEcU6/+y9XCiakVLYaGfE9zMluw==
Received: from SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::28)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 06:41:55 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::10) by SA1P222CA0072.outlook.office365.com
 (2603:10b6:806:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 06:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 06:41:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 22:41:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 22:41:43 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 22:41:34 -0800
Date: Thu, 20 Nov 2025 08:41:32 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Peter Colberg <pcolberg@redhat.com>
CC: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?=
 Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue
	<abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 8/8] samples: rust: add SR-IOV driver sample
Message-ID: <20251120084132.40f72ba4.zhiw@nvidia.com>
In-Reply-To: <20251119-rust-pci-sriov-v1-8-883a94599a97@redhat.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
	<20251119-rust-pci-sriov-v1-8-883a94599a97@redhat.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e2088-8cb3-4b52-64ef-08de27ffe5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6Og+l1wUyErwpyNktOJnrSssljQrsYxzOZ9FSa+xxgsrwvQ7sV9xUA2DNj4?=
 =?us-ascii?Q?pBATNCwcGMF2Fnxjz0nMe+KLnywi151Wyo461aHa7imWkaDSbhnDaaaLKiFJ?=
 =?us-ascii?Q?QVCGDXBTz42o06RL2B+KYOG6cvczB8twABG1dakiOydZO8ocVmBmrWk6xEbp?=
 =?us-ascii?Q?5l8v4wOfm/kmk/p+mdc4yG/8Tn/8BP7ZOMvH/zXow6JQCmlvYPo45cmyK6W4?=
 =?us-ascii?Q?9kd2dTVGPwluSnRisPukODx0FEQC1XGVwAtY+q8MC0u0EV+/fLY/QMWHJApY?=
 =?us-ascii?Q?jpQ7Vco0Ji5kv/laY5yr941lQsMEnlAARt3vl5Q7bK/jEb7Cpig0wSyrJPII?=
 =?us-ascii?Q?re/6mKdoJgxVwrukZH2yHll4lB8dbARxawor+PccKZo/D5WnKURhoAgupCIi?=
 =?us-ascii?Q?rH/vsFpGP6pw6IxsZEfSZcM6keBnbFi+vt4KYyCdifreQHazuPWj4BgTvbgS?=
 =?us-ascii?Q?MM/BGnS5d+pEM4exKyrcuasJn7UTouqNVin6gRooV/El4fViS4xamN040QYu?=
 =?us-ascii?Q?JZ5EVs+YpupF1C+PwXlqwPooEoF9s2d8y+P1xgOGEEyr2c9XezYObKPPVQKc?=
 =?us-ascii?Q?a4VyXv7bTvx7QS47/qV+KwilOMRFKq56L+jTSD2sj05OudaLYHF6R/1gv7fe?=
 =?us-ascii?Q?pADdpPjbiw2y/q+Ebycz8w0OfOO9S43lWikyrYFj6wHDxGRSOM3wKl+suwnJ?=
 =?us-ascii?Q?3QzjPGbJauyFpRKfTjCJ78J1OU8mgtLh/Mu10dGYEIlsXiRD7ryaKlDCblrs?=
 =?us-ascii?Q?1YBfBlf79i6l/8MGDmOlSQsWAVy2+rWg7BddgYMTTkegnMpfbak/8fb894xL?=
 =?us-ascii?Q?Kno0OYCsCylo2nHoBaFSDFxHQ8lqo/XIHUd9Xm3Z1D1aQuana+MNYyARqWa9?=
 =?us-ascii?Q?xp9iQonC4vMssOAhQP+bCbmBeRINTvQb93CNknnvfnQ4qY0OnlR6AhANzeFh?=
 =?us-ascii?Q?VLE5OW8NvsaTUPIlh22cUnV7pFO8Vyxuu7Qf6XLLNcaEeSTsoK2+PXykydJ5?=
 =?us-ascii?Q?Q4hKze18T+I7pxGzwckrKras/5IDI4CrRKVMggFW3qQkF+95IywfjQ5JfOOK?=
 =?us-ascii?Q?1IgbPuo4bChLkGOCO2ccRB30zph4r5DyxI02Rihf690lmT9E4y7BMgTtmZnF?=
 =?us-ascii?Q?JxNcHQQmL9zBSw+J1SMEAs33VZ9HmeAvuikClgBFG52HEP7bq20plJuCPDjY?=
 =?us-ascii?Q?m2PBi+3RA/QQRrzoyQIeprUFaWsCpuF2rL69QU9V+JsQ5C5qe5EC/tR10A1k?=
 =?us-ascii?Q?TBHOYmEaB53aozybOTdE4/goEbFykL6FTZ3QHbVqHiwtsc/d5gNPCjdRqLaQ?=
 =?us-ascii?Q?oXxb4z7E2F2LCHc4sDMJErfUoWuxlWbvcI4bG0rPP2XQpKQ92ezkS3MLz4++?=
 =?us-ascii?Q?0UOIT+2okAWu2Q6+GIcSVsi4HOoyd7ayrIJq/03H6XGpd1fNpMR0oOzyPekY?=
 =?us-ascii?Q?aGVGpHXzC7tkEiguMHekwFXlWk7lkJIZnAHUmzX6ZWhz/j2bPOB2yd0ffgo+?=
 =?us-ascii?Q?BRz1PYBwJ4ewLv3EDRvii96Y07HRLL/zHvXCMvX5pMmFpPKARIaRDK+mYnb3?=
 =?us-ascii?Q?LG//moqAYvGFUN+eoS4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:41:55.5649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e2088-8cb3-4b52-64ef-08de27ffe5b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

On Wed, 19 Nov 2025 17:19:12 -0500
Peter Colberg <pcolberg@redhat.com> wrote:

> Add a new SR-IOV driver sample that demonstrates how to enable and
> disable the Single Root I/O Virtualization capability for a PCI
> device.
> 
> The sample may be exercised using QEMU's 82576 (igb) emulation.
> 

snip

> +
> +    fn sriov_configure(pdev: &pci::Device<Core>, nr_virtfn: i32) ->
> Result<i32> {
> +        assert!(pdev.is_physfn());
> +
> +        if nr_virtfn == 0 {
> +            dev_info!(
> +                pdev.as_ref(),
> +                "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +            pdev.disable_sriov();
> +        } else {
> +            dev_info!(
> +                pdev.as_ref(),
> +                "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +            pdev.enable_sriov(nr_virtfn)?;
> +        }
> +

IMO, it would be nice to simply demostrate how to reach the driver data
structure (struct SampleDriver) and its members (I think accessing one
dummy member in the SampleDriver is good enough, not something fancy),
which I believe quite many of the drivers need to do so and they can
take this as the kernel recommended approach instead of inventing
something new differently. :)

Z.

> +        assert_eq!(pdev.num_vf(), nr_virtfn);
> +        Ok(nr_virtfn)
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for SampleDriver {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_info!(self.pdev.as_ref(), "Remove Rust SR-IOV driver
> sample.\n");
> +    }
> +}
> +
> +kernel::module_pci_driver! {
> +    type: SampleDriver,
> +    name: "rust_driver_sriov",
> +    authors: ["Peter Colberg"],
> +    description: "Rust SR-IOV driver",
> +    license: "GPL v2",
> +}
> 


