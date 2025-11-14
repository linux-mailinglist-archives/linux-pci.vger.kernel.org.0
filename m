Return-Path: <linux-pci+bounces-41196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1FC5AC06
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 01:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966453BB36E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC12066F7;
	Fri, 14 Nov 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kKDtuTcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0401A2392;
	Fri, 14 Nov 2025 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763079614; cv=fail; b=TTWOxay1t4BEU0/H+W2mCCaS1h6xsBG12yCpi+2ilUFk3eIkliPHQEtAFXFjGdQ5f1ZAEOGBj8kPLebJ3Rjv7lT5FWyFCuLV8NGxG041ezlUpkh3p5Ex+M+9md3UD/A6naL7bR9waoLvIA0CftNaXcXTr6afpj1ccR1QKR4r3J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763079614; c=relaxed/simple;
	bh=pavSEeMpOcxcpM3O4NEFnKMV4EITg03anxSwjpY5SLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L5h8aHgR8sW1xMb7KQO0tz35Zee/gqD9NL5+VOPL9AwAJAbYpLaxq/wPuFA+QCyLRUEco7+0n26Hj18Ku+IpbR+C+SmRJtk+m0vIY2nMfjwa+UjP51Sebf8LX5GDVx2EbfwXUqANiym+po0Savw8o7uSSEcPRZlukgbr7/OLpeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kKDtuTcW; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYKLzS1aZXioUAyI2dRpRXyw4qZNCSHtwVdxZiUGQzd+X4gH6f9XhCNwdMtb4JYFBIS/WB7woNe1uBW4WdGz8dHShCsqBT+hezON7fHdzkmAgb6bYLQL16NYONq3Gna29V1MhrtiAIDQYM6/t/lsxy6YshPSwIUmym7CQ0+sRGq4AYnK3hEQHro3k+7CkcM5DHcgXPP5yIgedwpb9Ux3LWpdabTj9XjRpO0HelLwHkeIsAv5eRugFYQd7Bc7iACZ61Q6JUvDveuF95F8n/k5047lMGeU16o3/ky9U8Vnpv8RDjfo9dvJFAK+enfoC6SSjkcM5KbruPwCOohuzmt6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvRpmKvh0p8/gZpRZOzSfg5h1JwVdhuYmXtoy1mVMe4=;
 b=HDHFbFeqIcrThRQpVAgJ25G3UCsiUbHJaQw7GT3yvmQqZ5vvLiGJQSMtOu/u6lkQ+whrqc1TNBjBkSERkUYiUa7jgh7eYmVX6SNTuX7XyndGLvM6E9ppCYXh4yNuA/pxgaPOrMLKfNV577g+9IP4EYS3HD4fzQjAWbUZgkQwoafvStfIIuIkfxqDB2eDhDs/ltPYUvUGoEbKXN2MMMjdRCR9Ou8utfdzYwz/BFSw2Q1oqTkn2EQ8QeByvT+E0W0w+dHklyTibShqah0Y+06NBsp5aSnMy3bS8Dms6Lj+2XXoqoEIf31iypu0XM7s4TK6TCE5URlWVk1ppPExDntqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvRpmKvh0p8/gZpRZOzSfg5h1JwVdhuYmXtoy1mVMe4=;
 b=kKDtuTcWETItuSl/THGkaQfC5TW8TcbzzURbPCcGa9+PxYxk1EyvzepyHXisN5sNOM6iZDL5FNQdCmInC5g+ZklEaaQPszTeKOzIz2hRzR786QCCV14t3mb0K6VHluV3jsPJBGls9qD5DV3D4/FU0JZ0Pr7Xjp1OLOD9ypSjS8Uhb1mkezxWiXAuSINPXZZgrhhmtm0dyxoYZoBE/laBkCYsr95EWyP+PIh6ZZpB/qho3VbMP7bpv+8HcfOvqJWao1y6DAvmivh3m96TBUJ4ICoM6IyclHHsIcaopfF9miTCyMan53Nva3VyQL7LxFvOjxem7Y33I3Z1dfkhmD3ZAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 00:20:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 00:20:06 +0000
Date: Thu, 13 Nov 2025 19:20:05 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
	aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
	acourbot@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
Subject: Re: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write
 support
Message-ID: <20251114002005.GA2384907@joelbox2>
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-7-zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110204119.18351-7-zhiw@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 941f21bf-f9be-4359-b845-08de2313905b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACHWjziVK2cxYyWnYhM2Wqh0WiFAzQuriXUy4e1DujPaneOo+S3ItwxUQ2FI?=
 =?us-ascii?Q?9yRgO8D7VVq0t8xp913hbL0E93o4bpCXSbIrA9+D0QScZPKgabeezxyAuEyP?=
 =?us-ascii?Q?8HS2BQtQv+qlh/ZejoEOpChS38fxl1GbE8mOdVzx/jpdFBylw4hVl0pMGpZC?=
 =?us-ascii?Q?UtWLYpuqevPdbPaIhjX1pPP3w6VdS6doemjbE9ObzLCN4pkVxL6HEXffA01f?=
 =?us-ascii?Q?gRQfpiwCjOhgR/qOJCbgcEQf020bH/CxuKIuApTSVBcoQ28vHYao4tssAf/p?=
 =?us-ascii?Q?jEpSfhC2l/aUupmqIQccypWJ2I1MPb2e0AOdhU5rNNr3iDwagx95/wv6ff5e?=
 =?us-ascii?Q?bKIBWD6xgraQfS1LQlna1DufRZ4ExkGMmdPTf6pyAmvg7N0DTOIsFD7GJwsQ?=
 =?us-ascii?Q?Iz+ckl84WhxoH33VGo/4YjQo+ft23PX8lcWsXBtVzieI/m91WTfUQUOrSm/Z?=
 =?us-ascii?Q?5KVjttG6rZrHrs8oOA3mtr++ZV70ocKyPNk/Md0XLdEi9lPa19JaBiYIqsTo?=
 =?us-ascii?Q?Q9elqxUiCVuirHlU2GeSgZCSnpzDphGblzvVm5j/uYhXqI9m0rumdrAQHwmI?=
 =?us-ascii?Q?PDpUH+8OxkHnP82FukeCtnR2Pli0jH7eRa8amdpd68vy5qBR0lBPXCFswLNW?=
 =?us-ascii?Q?matWfteVX//nFclFGgJgBvpsmdX/+XCZJehEelQn2UiwO5dF5ILuxtcVJ1vC?=
 =?us-ascii?Q?q9Jr+U6DQarJio/rSu3wGBKnaibAHLz1/iz7z4p37hJAD7TGc6rejLT0SY58?=
 =?us-ascii?Q?HPXVSX3iiHGbXip7JfR+U7SZJPFanqtwudzeK8vNy9LTqx3eA6vGjUiR1C4w?=
 =?us-ascii?Q?MlJjl/Hv+C61OKxOLyOIGvytk1Nf18gr53n/SkXnM2tTHm/wSQTLR0XlS/Dj?=
 =?us-ascii?Q?f5xE8n1CeCSV3FJACxUlImv+wJ068aO7VWl6hELpTXNYRYByM7d3Gmv4oKcF?=
 =?us-ascii?Q?qwWc2QVjtwcJyKsZ+yQTrit+qduyf9QIlzixGuQV4Y/r81DfRryL6+UKxKfP?=
 =?us-ascii?Q?F/vfHIHT3c/LfpkPulMw/28S5oNTAjGIxvrdEvWEj7uXLZrKt9PhZIetwyvK?=
 =?us-ascii?Q?7gFdQn3NEZQ+lEBAA/XIYrUhv3kdNcrjh+olxHtPtmJh4gaoNtuQn3ueTuKE?=
 =?us-ascii?Q?qXPJES2fduJm6FZhMibqHiuW3CAzCWBvlkpBU926YKZg6pEWvY9UdkxMI0qE?=
 =?us-ascii?Q?6XapvmUPtEXqYi1u5htizBAtCDSL2F4xCFnjN5AOE/SPW7eEBmJQmfSnOFWC?=
 =?us-ascii?Q?NQgFxqNWG6FsJ7Gj8v+WHRpi9wqMkhWrUts5ml0FzvGqmJ7Tvw3hAydx72iX?=
 =?us-ascii?Q?ztWtfFK3N2c26uaK+UMMY0OXI9JG6/fbVzOyra0tHjdnXtU1XKvJe0xcIVCo?=
 =?us-ascii?Q?izRSWcrKxPyVjFOuepz/QFZV0ifcCpxONoBipROSOabDoq+763TFyzTR0l8q?=
 =?us-ascii?Q?Te6TPUm2DtBR7Iew68QINXr72UTT3yTm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSxGPD0bnQx9/0oDD7zIbtNZnGKcErpHx0zGtpcMePJEkEIOT0goyT/Nm9wO?=
 =?us-ascii?Q?9VlIXoVA90nSTd9jzaZwSHuA1l0uPEDh1PHqhDnFgJw3qodnfrEm/p7V35hD?=
 =?us-ascii?Q?uZTKn4lYOpHjrmZ7QUJHAqj9MwAnZqcWgu9GmpYWOqqHN36f64+OCXxiI8Vt?=
 =?us-ascii?Q?ilNEjP75GVMrTlDCyVcJLhoRLpsb3F4q2zaczYuj8wzsppIfT1Hi+3plyLFb?=
 =?us-ascii?Q?+hqlQblQ0rLTh7e74ZDQIvJM2kCEus0tge9ngEqsd+Q5tEgI8bJtvx+qpNZ9?=
 =?us-ascii?Q?jY+VOzEfsDFKcMLu1MzwTGYbKs2IK5+8jGzFXD99v/6POhOx4v0gLCJWDJyx?=
 =?us-ascii?Q?e7qBLcpeuiONz6DuhK5fiXbhRIU68apMMmY2iYhdQAyf+mxfHsy313ooJ6TQ?=
 =?us-ascii?Q?GC89NpvAuutUOsmAw+28gAsCPKoehVWwFzSfVJdRriMMS6pCKcWK2TGQa/IZ?=
 =?us-ascii?Q?9eiVlbkHvoTqN9OGISlOva0PFWd4wE4WjGKE4auvzrK3S1NCHLRZlTOV3hvk?=
 =?us-ascii?Q?D7x+v3DucSnjHdxi4R9MwMk9ZErb32vvH5ZMBCwWOrSoxpxQ18/YVSGj3hCl?=
 =?us-ascii?Q?wVnmjIv2Z+Z5ppOJ+5+fakkg18D5iDr8XewuqXS7NGDO6Qep5L0gBlEvPyF9?=
 =?us-ascii?Q?tmEsT4+/UZyXrCP1JmH93PLSSiy1BtMiE/LclQBCckamUIq3oZWUst67pQlW?=
 =?us-ascii?Q?xtQ9AA5egyu+z4jk9U9IbaKrx7JJyYrKu1Ok452PB8osRK5yGaXJ5t1/pqwZ?=
 =?us-ascii?Q?aeGpqu4HDjfWox3bO2eE2PSIxCAjrl/pZUOME6PQSR7TSWWNJBhnSOrIQqXt?=
 =?us-ascii?Q?3zuoex9N4mDMmdv/GtfhjU/RbF6QJi0J8XPUWf+X/w4Qzw/gD3qTy15Ei2Aj?=
 =?us-ascii?Q?mmogRmTdtYnulkyMn9RSvR6ILa+Bqzk6/dKcM9doX7oNT2mEqOWhRsu4gKY5?=
 =?us-ascii?Q?XMN4i3xxbX2KTIBUev4t3lCJGzqC6ua8ahZQtuRlAFOf8PEKeYyNHcn/QKFu?=
 =?us-ascii?Q?nj4CtkxlRBVTM7udQzvh/I5JnviOLBCdX/sqHNCwIxiCQ9Rwytsw35Tz20KH?=
 =?us-ascii?Q?Fwp3SY8N0uaXrvVWQcwpAMcRsDbilDAZOYThpmqLK6tvoVsCTxEgAxyXfIb/?=
 =?us-ascii?Q?ps9l9BCUGw9kXse1bEtYg+8gS4luyoON5O9Z+UM/nR0zE0c2v9dBuVQrIS5T?=
 =?us-ascii?Q?kv6FbpejVETuVO2bdfF3qjtYQ+0rbn4ZF5YMXUEzED+/mzpFRlmiBzyDNBQ6?=
 =?us-ascii?Q?Z9paHk516jGHlNoBFHC8xAcHKGJtV/fg0WjKKT2roJVhJOLmTVfmGERPc2zt?=
 =?us-ascii?Q?DQhxGBv0Ee1WjOGR/R3hOvCCZJ0T/6c8m3QFGaaJYwBH4KXe54oXSdQVAYGh?=
 =?us-ascii?Q?I+8IzNbEpd0isTVW4V4krQK+iVhHrbVq6nt+9MKKOewaajIaiSxbHDb9airt?=
 =?us-ascii?Q?kSuARC0gUbw6Rai5MxcTBmgl6JVw34MGiLNHIHmztDH4L2R9Ww75Uv2s8n9e?=
 =?us-ascii?Q?GdQ3d4Nw1p0cyZBHWhu1ESUcc+LHENdHFKVwGmx7X0ivK1qhzS3DwQPW72Tx?=
 =?us-ascii?Q?6OefcNMZbpft0+Wh4U/Lp+3bEJB5F4W3xA7kpvdx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941f21bf-f9be-4359-b845-08de2313905b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:20:06.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQGZRptcKuQAYpquhp3zCPyF4KFvg/cQ4UkOGJM+hmaZ2I6rRJ0cUtxmSIccQHIvkRZKy42xZzY2PNP3jexW9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

Hi Zhi,

On Mon, Nov 10, 2025 at 10:41:18PM +0200, Zhi Wang wrote:
[..]  
>  impl Device<device::Core> {
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 2bbb3261198d..bb78a83fe92c 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -2,12 +2,19 @@
>  
>  //! PCI memory-mapped I/O infrastructure.
>  
> -use super::Device;
> +use super::{
> +    ConfigSpaceSize,
> +    Device, //
> +};
>  use crate::{
>      bindings,
>      device,
>      devres::Devres,
>      io::{
> +        define_read,
> +        define_write,
> +        Io,
> +        IoInfallible,
>          Mmio,
>          MmioRaw, //
>      },
> @@ -16,6 +23,58 @@
>  };
>  use core::ops::Deref;
>  
> +/// The PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space).
> +pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
> +    pub(crate) pdev: &'a Device<device::Bound>,
> +}
> +
> +macro_rules! call_config_read {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
> +        let mut val: $ty = 0;
> +        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
> +        val
> +    }};
> +}
> +
> +macro_rules! call_config_write {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
> +        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };

unsafe block needs safety comments, also I understand 'as' to convert is
generally forbidden without a CAST: comment or using ::from() for conversion
because it can by a lossy conversion.

Also we should have a comment on why its safe for _ret to be ignored.
Basically what guarantees that the call is really infallible? Anything we can
do to ensure errors are not silently ignored? Let me know if I missed
something.

[..]

> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_exteneded<'a>(

typo in func name.

thanks,

 - Joel

> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }
> -- 
> 2.51.0
> 

