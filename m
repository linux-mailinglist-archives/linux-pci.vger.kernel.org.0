Return-Path: <linux-pci+bounces-40477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE70C39E19
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8871A410D3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA530C611;
	Thu,  6 Nov 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jp7kGB/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44B218845;
	Thu,  6 Nov 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422276; cv=fail; b=V84tq3+4ltpaFuZnB+NJBSH1aoPd2yGn6rK9sslwzgjlz8J1FHJK1PT5dK0pjRDPROJf6h3BHu48h8+bjlNF/7cIdrV1opxyC5M7mS9tzcweHMEBQfoycumM5sllA+rOo0VgtYQLO3unv66jaBQrvbOdQYmV63WXgDcwuca44qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422276; c=relaxed/simple;
	bh=HoNhxPKLzGazgVciNHddmrVSCEDz5irIxlJISJ3phb8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLtMmr44VZGWDl5eFPHi6AI6xzUZChpLIh9pq4tEaJbuyRG81xFYiuFoycd83Vo8n3T2hFW2RAF5b5vTzywXqlfTD4u97+j3nTBzNud2IIQcDBz6l0FP1raqYLfRj7avA8nIGJVq+Hu/IHO858Oy+wYV/8Ez8AAUSeGc4TNdZ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jp7kGB/J; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN05KMEbKM0h6xLaM6g6b5UwNmsS+8XQBfMg/7NBkgQW0jOqh+9jA5vbCrbauYvTxsAx81Wbnrm6ANjEE2tjJEhzfwu3A6WObAsmqrNjw2Sc3USBp9A4tIzd1o5dzHH2tldLb17W4klo44UpriM1FI05KsEyvkxjdasKTsaWth7083vdIZnwD3InKqSh+whZg5FwmIe3IeLFe3GHdLFQJQ4C3gCE8KX/FU4emunmzTzaxIMUMjsmn4FOq4Kl8P0b6k8W3Whd61EUqcEP/BNxXi+HXyBK+5uvCw8HFo7beBwLRYbVHkmHnwGy+Mq9vuW1rATyOebxygmvpTQXQMOQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BHAC32eqxjFGLpzNnxWkDsRhgWFwcZQEWIbn4H3pjs=;
 b=g23+oAC4MXSQ1HWwTU5yIsMNsm4IllnwQ+k8lbjMe/6wpTQhm4JLO30xTIJQo/JxOTXZS8Kk6UHPRg7y2F8Y6w1pHj8vGEmycU66IBxG3NFXulXVMpz4su0qPxRsRAlfKGXDEA8/RYDz6l4pc4oi8L+JK22v2is8ovrJqoxUUfFAS7gKoA0bfC7mxy8alcA4jcZNLNswbxMl/VSI8tvCPhkOIMmV+hEgV51OiIkznVQ/UaB90Iu42fIAGBGDkYzWyLy4qtkjTOE51lx/3yD8fHaT9Z8lNTxLxWDgnzt7COmNffCixN6KsNIVjwC3t4VYBFXQu0/u4jU0FPtpzO02yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BHAC32eqxjFGLpzNnxWkDsRhgWFwcZQEWIbn4H3pjs=;
 b=jp7kGB/JCh0lDABGxwco5Hg4NGQGn9+O7cgF/dl3Nl6JL7LTzavsT3omdKojN4XqRMVUXUi26KL0j9LtZNKbMn8cThEWe9iTdQ/cHLb/MhkVtTdGAz79LLfUqTLvKI8G59+YubVhkjViYe+oTlvVeHOAA27up+cQDWK0N5aWrsCOv+m5Jx6iEGRiDEosK3acv/HIZrxNgTleYORW5W1FCot2ALSeAOwkeiGo2IM9rteTy3AdOW2LVQGDh2TP323/dLV8wUzT7f7+VckCqt/mgBD5dUbfFkGmiih348nRRzcyZC7YdH3Lu4EOx/S6Ts+BEm32qxWfoK/hHYNRofAZ6w==
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 09:44:26 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::d7) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:44:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 01:44:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 6 Nov 2025 01:44:16 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 01:44:12 -0800
Date: Thu, 6 Nov 2025 11:44:11 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pci: use "kernel vertical" style for imports
Message-ID: <20251106114411.370711ce.zhiw@nvidia.com>
In-Reply-To: <20251105120352.77603-1-dakr@kernel.org>
References: <20251105120352.77603-1-dakr@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6a206d-a82b-48ca-eea7-08de1d1912d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WplZEbyvg4oe+k8Qm5ZsN4qB1Q3nCScsOnt853l2z5ObS/Azn/OYOBgF4wTb?=
 =?us-ascii?Q?HH5mlSmBwRisL5Bh8lv2EiXhxiq7/FzWvfT8yFdzJLvq02myNmi+8R76J2xP?=
 =?us-ascii?Q?ew8FTEv/th82CuIKuOB3ioFurtyMkrtwSuxLH5nSiYtWLdn/e166rKUeqoWk?=
 =?us-ascii?Q?u3dZk4fSFUnOfk3G7lOwEkzVTS1QqmFF8VFjEEl7EHvmkHAayepk9ZFKPqeO?=
 =?us-ascii?Q?tJTM0t87AmSxVz609mEzQ01PJ8l+HLbs2bQWy8drh7AIRUG7g7Ro3qrTHG2Q?=
 =?us-ascii?Q?N/wWnoaOCwUOsgE2q0pHO53ppB/8et6M3qgds4J637dJpb1tvb9XsCapIgwM?=
 =?us-ascii?Q?bmynMas5XFjsLVh63UDzom7ITw0rSbsNSojuBI5zqJ8E61+ER13OOT9ujQam?=
 =?us-ascii?Q?8C2x/tD88kysXulcnXNi1SfFreq9G6wKK+5RDcoDvVFyDIe4b2OvHp6Yp9XF?=
 =?us-ascii?Q?Giv6VfCEeTRpP0FkBlx3RCOFuqWCXpqngYgU6Qz2Gf7FLlxu0fN8noDSvnHO?=
 =?us-ascii?Q?ufiCbM6w2qWLG+L/JTzsr0n4PkuEKVKCu/bsUH0lKofyZ54fvRN0ln6TsujH?=
 =?us-ascii?Q?XQKottgIa9qV7/fMZ6yw113DD7Y4dNWsfmUWf8pul7KsHWwmjmPUliaW1+jb?=
 =?us-ascii?Q?BNMQcnGVFj4RkQqrk03uLdrp5Y+SAJ881FeVlMa8Ql7SlrE1aMYXTOK+9I5w?=
 =?us-ascii?Q?JslrIbe63pgEka1xWo4eVlpMEiuOSYzU6lQ9qmYNZhtc3yVIUTCoRqtixIv1?=
 =?us-ascii?Q?6zUBM+2SJswyTNFjvC0qNanpdXMmrpsirGK10+YQVvzwKyBUcRIrXKgqwpPy?=
 =?us-ascii?Q?oIZAHaAYaj9oKF96TZiQTgoYda5HXgdWUH3VBmtNx37FavqYdstsfZYqrYCH?=
 =?us-ascii?Q?YW1HfLob7F8nPrqCGUISM7xP5T1sUzyk2yksityLpVF2562CzTOq3l7ytd6A?=
 =?us-ascii?Q?dJz6Qf49moS9bX0Hg4WOPHGGRk4lCOvr2v6E2mjPZJP2+BjOESV36XGd4VJ5?=
 =?us-ascii?Q?9NQCr8gIZHYkU3AQfzecvgXU3OcBaEv2zgCUU5LEl8BurM5hSpOzqkqfgGZ0?=
 =?us-ascii?Q?+9JbB8g33gn2xbm0DQwRrbzUjAk9SrtyJfxpcqmxfZMvvegIh5WN5SBmh75P?=
 =?us-ascii?Q?hPNpRHL8GHNegynbx6Rd5jl0yS5HSzAHIFHq9NYYCd+zGksJ4+wh6neqVNKH?=
 =?us-ascii?Q?h8cmOkHRLmaYakFTc1tVvRc32mlIn7uKoxMKlMlexCuLdF8pMFo+1P28ntna?=
 =?us-ascii?Q?NBacnS8Q/4VAJypcyLqcpYBgjWJFZd75MH1wUtAo88yDSDWEVNOXAoNZVPLt?=
 =?us-ascii?Q?O1Md1sAPoDyNRYcPIxO3ZLKBCXNPK6/OjvCKHECdDan4uuEKmnpZ/bz0J2XP?=
 =?us-ascii?Q?r4/yNjzOONwwX+5rtcp6AhzmJSCkfdkEhjD5O7Y96L8E1zhlACM1q3pUQuZ3?=
 =?us-ascii?Q?pviMNiR0dWBUSho0nsD3FVAKVpocTLuOpczstyAHSMX4rRNr68qJpE3sH5Fc?=
 =?us-ascii?Q?IiVNuvYeFL3zMflGS1oktU4YRz3P/0Wil26C98sRjsQ5SlgFxpqgyLJVik+3?=
 =?us-ascii?Q?jXNBW9gZdQlrXuYnaWM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:44:25.9913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a206d-a82b-48ca-eea7-08de1d1912d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287

On Wed,  5 Nov 2025 13:03:28 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> Convert all imports in the PCI Rust module to use "kernel vertical"
> style.
> 
> With this subsequent patches neither introduce unrelated changes nor
> leave an inconsistent import pattern.
> 
> While at it, drop unnecessary imports covered by prelude::*.
> 

Looking good to me and test on the driver-core-testing branch.

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs     | 35 +++++++++++++++++++++++++++--------
>  rust/kernel/pci/id.rs  |  5 ++++-
>  rust/kernel/pci/io.rs  | 13 ++++++++-----
>  rust/kernel/pci/irq.rs | 14 +++++++++-----
>  4 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index b68ef4e575fc..410b79d46632 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -5,27 +5,46 @@
>  //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
>  
>  use crate::{
> -    bindings, container_of, device,
> -    device_id::{RawDeviceId, RawDeviceIdIndex},
> +    bindings,
> +    container_of,
> +    device,
> +    device_id::{
> +        RawDeviceId,
> +        RawDeviceIdIndex, //
> +    },
>      driver,
> -    error::{from_result, to_result, Result},
> +    error::{
> +        from_result,
> +        to_result, //
> +    },
> +    prelude::*,
>      str::CStr,
>      types::Opaque,
> -    ThisModule,
> +    ThisModule, //
>  };
>  use core::{
>      marker::PhantomData,
> -    ptr::{addr_of_mut, NonNull},
> +    ptr::{
> +        addr_of_mut,
> +        NonNull, //
> +    },
>  };
> -use kernel::prelude::*;
>  
>  mod id;
>  mod io;
>  mod irq;
>  
> -pub use self::id::{Class, ClassMask, Vendor};
> +pub use self::id::{
> +    Class,
> +    ClassMask,
> +    Vendor, //
> +};
>  pub use self::io::Bar;
> -pub use self::irq::{IrqType, IrqTypes, IrqVector};
> +pub use self::irq::{
> +    IrqType,
> +    IrqTypes,
> +    IrqVector, //
> +};
>  
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 7f2a7f57507f..a1de70b2176a 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -4,7 +4,10 @@
>  //!
>  //! This module contains PCI class codes, Vendor IDs, and supporting
> types. 
> -use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
> +use crate::{
> +    bindings,
> +    prelude::*, //
> +};
>  use core::fmt;
>  
>  /// PCI device class codes.
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 3684276b326b..0d55c3139b6f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -4,14 +4,17 @@
>  
>  use super::Device;
>  use crate::{
> -    bindings, device,
> +    bindings,
> +    device,
>      devres::Devres,
> -    io::{Io, IoRaw},
> -    str::CStr,
> -    sync::aref::ARef,
> +    io::{
> +        Io,
> +        IoRaw, //
> +    },
> +    prelude::*,
> +    sync::aref::ARef, //
>  };
>  use core::ops::Deref;
> -use kernel::prelude::*;
>  
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 782a524fe11c..063b6a5101ff 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -4,16 +4,20 @@
>  
>  use super::Device;
>  use crate::{
> -    bindings, device,
> +    bindings,
> +    device,
>      device::Bound,
>      devres,
> -    error::{to_result, Result},
> -    irq::{self, IrqRequest},
> +    error::to_result,
> +    irq::{
> +        self,
> +        IrqRequest, //
> +    },
> +    prelude::*,
>      str::CStr,
> -    sync::aref::ARef,
> +    sync::aref::ARef, //
>  };
>  use core::ops::RangeInclusive;
> -use kernel::prelude::*;
>  
>  /// IRQ type flags for PCI interrupt allocation.
>  #[derive(Debug, Clone, Copy)]


