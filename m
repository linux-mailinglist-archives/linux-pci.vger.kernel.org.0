Return-Path: <linux-pci+bounces-41728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDDC72596
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1C6D34B2A6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB22E541F;
	Thu, 20 Nov 2025 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6W1S8RO"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8612DA767;
	Thu, 20 Nov 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763620367; cv=fail; b=VIOPNnmmhxep6RvvF3lpsocQZh0vaeUjwq4vv4OTUyjg4Q/dqsHvctkWuX4bAJaclM/tKPIoGINE9LEpyPbC/lJMW/DvCyyr6eX0S084gG2XKYwZTOfZqSgEtNHfTMZDZFlabBb1VdSqRAWCidPcEruJozu5cUVoPiuf5yVhGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763620367; c=relaxed/simple;
	bh=wXYjzHqTRlNmY5G+r93lf8u8m1UvMF/l5+j904Gfkwg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oc+9WwWq3oBe+dRREggEr05QHUpcDUSsKVsAIwFPPriFzp/lUIBYKtJkYbQcmL6aGW4PPqcqGJ0IiuXoqT5KdCMUnaCFDkN7BRZ3vdm4cLhkw2mzShabME1YcILea0WGZChpH4R/ASadGilg3uvwzvpXQtyZ7Jl1yPM5dn5JxCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6W1S8RO; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w80LTuWCTmSdrTBpKFfpshCTqUH6u6mHRzxmcohLbw0xTxdLDIzVDSOucaaJbjKi6vvVSn1vWB7amefPHs3T80FDZn/Vrla39Qd0WyGygDWVMCgPokbyT1XSqCYEtAVrNg6KUOfFDIqDyPfqjF58YYUMKMBMa/t+kUDMZVEpvhTnO1DvXSJ1aTkoReJliyBCJku3RHJdf6D8oSgYKAfY/XLlwi+D5J9flxAU2x8iKF/iSwJfJjkbvfCZzCuw8TzjMb5PytJ262V7TYRj9ejI5AKmU+rGnIfts8gl9OfVulNAo3RtyN96QtOg3jcjar+zBp8HRBLyWBVPRJUQVypRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etMT3RZkhRBXYV6KwzG/Dy9QOCskv4g61s8VaWMYnb8=;
 b=zKpffkIkH7HtM40MRB3PEwpjPBP7gXglhHb+gSRZv24sRPe4Lbed1hGEQ+IqkgqKX4Uqv+W7n5pKuK3ZIb64zkT0NTiFPky/TIA/CPVOUFK7cn7Z8ofW98HZTum34mcr8OFAHjx6T/1AA2CvVilDSlYSn64KPiQ6GrnLZ74qbP6WcZU1fzw9Hf9YTXD2cLJoh6eL29RfoeQp6vc94aAt3zNR4Zz/zSyBP83nPPiwHNDTN48ED/m379ohkfsiidgO24lj7iESAa2GRF7CoK25Rg59PUQbE/6ECxx1reqNZeaeV9QMnMLHq0Fh3cMwIHhMsLugPwT3weBrkJF0sotT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etMT3RZkhRBXYV6KwzG/Dy9QOCskv4g61s8VaWMYnb8=;
 b=l6W1S8ROvKbv6RJ51Pf8nwXJY/SQtsvsII5ujmYiMHJ9EK4jgdUIB83vpVPHQWoqqTKDJ008nGOu+ipJiB2JziEGCJCQlgq4Lt/QFlB7vpiJdZlQ9ak1PRnwlQXZMntfqWCrZdq0cts85Coy3yDsrqMt8zj7xKn6HrrH7d3lO4jr6FyZJaeEj+4ZND9vVQmPTNWPaA+nlcIPPc4iak+ImLfMw8fXKw/o/0h30VUipEtTLcufykloe1eBYLb+tG/kuBNVaDUHNBvJ3HV5gHR76DkAyXsv6MWIuQWRw2k71pKhhxO/dtQMcv6beZuzV5w3VxiJFnNlhAEVCd9QiUtbhQ==
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 06:32:41 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::c) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 06:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 06:32:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 22:32:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 22:32:23 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 19
 Nov 2025 22:32:15 -0800
Date: Thu, 20 Nov 2025 08:32:13 +0200
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
Subject: Re: [PATCH 0/8] rust: pci: add abstractions for SR-IOV capability
Message-ID: <20251120083213.6c5c01a5.zhiw@nvidia.com>
In-Reply-To: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 998b290b-459a-4341-a9df-08de27fe9b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOc1tAsyVqcc7lxlldKSyiIZQZo4iCsMdr7lsF9KyWGc3SyL2Ebq/eksSmmG?=
 =?us-ascii?Q?XYlQcLiF3TpsWNbPB+t4anoelWSicY8XR/0B8DqdPBRu/8PHlRAHbjH5TxFC?=
 =?us-ascii?Q?fLuyjpjJvN4vcPNM7OQ8oEUxaLvLO9iSnQDYBaXNL7zvpAQhe2PGHTflfbYe?=
 =?us-ascii?Q?9mo8hT4wVDaiaBRIMXWwylAQJmfpoqkA8/Gi8ZJYv5WmfZMg7vvhR9DqP4Lk?=
 =?us-ascii?Q?Es6r92RvfFnoW/DT5PWz/xbIFl9lOQw2MKmlZSzGxFFs5xWc1t5A1KWt8cNm?=
 =?us-ascii?Q?Pa5KTEuVYyfepnup50LQUtijHEEhzlQE90c47kcZqQrKE+4oQFvcag8uwO5Q?=
 =?us-ascii?Q?Y9dXtqjnjX3BVun5l8yiiRvwM1PAgexR0kC70+UXCoqNhTsFOcpireUrCgKT?=
 =?us-ascii?Q?YxpD05qAXsJ2SvjHdw8e79qbp0RxIPUkfqfE3JvtU3cFuqfNQDJLC6q7drmA?=
 =?us-ascii?Q?BEypUi5gDxQ5tX4WiZ+AmGnj2736UjPhwYYrniZhqYrDv1mtr7ItH6CrOJSJ?=
 =?us-ascii?Q?qyDVf9WYKzUoGWuE8rk5/pjChhko5FsoB6Z70d3r8w4NGDYCC6Ge+PU1Paqa?=
 =?us-ascii?Q?r2oXcTu6ee5v1S03F32BCjzbi9n5/7eptGNh83vGcTGjaDhZ6k7xpxOchH17?=
 =?us-ascii?Q?QbeMOwI+tGrfq8z9hvDlOtorjOcK5QYuy+pEdkEu4nMrBa/ZkJbiCjokt9Z1?=
 =?us-ascii?Q?yWnu6lOsZjAZ3o2k09CSRWlICM61Q/Xtm75+uAdLwOClN77CwDpR+zh1lDne?=
 =?us-ascii?Q?9oGQ6R2Ar1/B1F+ynuYT369FA8I8P4TBd6vnwFhEr/o8fjXnNKTt06rKOf2f?=
 =?us-ascii?Q?qfQ6ya05ubH7DI2iPUlRNjiPrtQzMannQ4kffJIVi9VcFzESq+ex2JtdQMrJ?=
 =?us-ascii?Q?W819LC0EH6D5pDzxOiM2hbMFI827FdHlTCsj3uXX4eRoXe6Ry4B5V6kXaCTz?=
 =?us-ascii?Q?n+8AZWAwzkllcWgMa+l98vE4PjMBHaHydbcRBR48PQrrV4rBdeWG62p1XRPV?=
 =?us-ascii?Q?axSnvtYhWDc9pylw/nQnuXxrGE+r7rXrmOok9ySugBV7ftq/+wcaKX8gng4w?=
 =?us-ascii?Q?7JWH7v3GDnBxWPyRLNfeEOPNwBd4TFMJGMhmJynLYju8arj2vDI1W6YPrQ37?=
 =?us-ascii?Q?rc7InU5Efd2ClFGr3pxVI2Qi+1LrVQja/nWjAqKZdwX8nUr0IpQvwKpafVWi?=
 =?us-ascii?Q?1WB9v/yHlRebMKAEVKmGYm8IpoOClL1wqv3uKl8Lv0DjLU0+0vLdqgXnME6Z?=
 =?us-ascii?Q?RzMl2Zg7hcWVfMUg7gAJxb1b2I6xQvuqy21XxFKCBc3qy2Q47wpN9QkHqey3?=
 =?us-ascii?Q?LPRlUVyOX+1LuImCm09gsBdbibQ0V+jMiRkenhKw03bjHww1H7KVVDsJwPtJ?=
 =?us-ascii?Q?BcPGWd841kE1JF26Aj5zGookFdt4EnmHuILQpLcrj9D6aZ5mKZkNg0KuIIao?=
 =?us-ascii?Q?rZvU8gdbvgPfDs4JFavINgIZjTg3QTO8kAwmYJBw/YWo7Trn22oYlYGXabYh?=
 =?us-ascii?Q?4uC3XC2hMbp4+VQE63+F0Xf8lXQIUK3EUNGN7O8iIykdfNntWER13KzaOX+Q?=
 =?us-ascii?Q?sj6U5mu5SLdABl2f1uE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:32:41.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998b290b-459a-4341-a9df-08de27fe9b51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

On Wed, 19 Nov 2025 17:19:04 -0500
Peter Colberg <pcolberg@redhat.com> wrote:

Hi Peter:

Thanks for the patches. :) I will test them with nova-core and come back
with Tested-bys.

Nit: Let's use "kernel vertical" styles on imports. [1]

[1] https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/

> Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> capability of a PCI device. Provide a minimal set of wrappers for the
> SR-IOV C API to enable and disable SR-IOV for a device, and query if
> a PCI device is a Physical Function (PF) or Virtual Function (VF).
> 
> Using the #[vtable] attribute, extend the pci::Driver trait with an
> optional bus callback sriov_configure() that is invoked when a
> user-space application writes the number of VFs to the sysfs file
> `sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].
> 
> Add a method physfn() to return the Physical Function (PF) device for
> a Virtual Function (VF) device in the bound device context. Unlike
> for a PCI driver written in C, guarantee that when a VF device is
> bound to a driver, the underlying PF device is bound to a driver, too.
> 
> When a device with enabled VFs is unbound from a driver, invoke the
> sriov_configure() callback to disable SR-IOV before the unbind()
> callback. To ensure the guarantee is upheld, call disable_sriov()
> to remove all VF devices if the driver has not done so already.
> 
> This series is based on Danilo Krummrich's series "Device::drvdata()
> and driver/driver interaction (auxiliary)" applied to
> driver-core-next, which similarly guarantees that when an auxiliary
> bus device is bound to a driver, the underlying parent device is
> bound to a driver, too [2].
> 
> Add an SR-IOV driver sample that exercises the SR-IOV capability using
> QEMU's 82576 (igb) emulation and was used to test the abstractions
> [3].
> 
> [1] https://docs.kernel.org/PCI/pci-iov-howto.html
> [2]
> https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
> [3] https://www.qemu.org/docs/master/system/devices/igb.html
> 
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> ---
> John Hubbard (1):
>       rust: pci: add is_virtfn(), to check for VFs
> 
> Peter Colberg (7):
>       rust: pci: add is_physfn(), to check for PFs
>       rust: pci: add {enable,disable}_sriov(), to control SR-IOV
> capability rust: pci: add num_vf(), to return number of VFs
>       rust: pci: add vtable attribute to pci::Driver trait
>       rust: pci: add bus callback sriov_configure(), to control
> SR-IOV from sysfs rust: pci: add physfn(), to return PF device for VF
> device samples: rust: add SR-IOV driver sample
> 
>  MAINTAINERS                           |   1 +
>  rust/kernel/pci.rs                    | 148
> ++++++++++++++++++++++++++++++++++ samples/rust/Kconfig
>    |  11 +++ samples/rust/Makefile                 |   1 +
>  samples/rust/rust_dma.rs              |   1 +
>  samples/rust/rust_driver_auxiliary.rs |   1 +
>  samples/rust/rust_driver_pci.rs       |   1 +
>  samples/rust/rust_driver_sriov.rs     | 107 ++++++++++++++++++++++++
>  8 files changed, 271 insertions(+)
> ---
> base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> change-id: 20251026-rust-pci-sriov-ca8f501b2ae3
> 
> Best regards,


