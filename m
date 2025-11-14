Return-Path: <linux-pci+bounces-41255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48796C5E88A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DCAE502D7A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB5338587;
	Fri, 14 Nov 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDK8xQVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4177328604;
	Fri, 14 Nov 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139612; cv=fail; b=iFlX8uGtJ9Z7iTesbV5YrptWzM/bCsj234ksMTQ4kkD+WO/wcbCI0QCYOCSO/v2Bnjws0GLPFzvRyTqjBADst7uU1F6BkQLuLrbrVt1LwCfWig+48QI+fLnIIJ0wUda/jToY6yIo/N6aPqKznR3WCHrvo9vIkjYkWwwn3QlNMK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139612; c=relaxed/simple;
	bh=nm5bNcLWiygjoHqeGrV4wYZ+ndbKVxLor/EPiiaKuac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwYDcqPQva68T03U9cw6m22/5SqJBBZngLu04n3bQNI5FKmSlBhiz1K0TrwqQ8S+SglmmnxpOwqqDp2nUwzwDg8lyFjSdEbFZDgKq6SnBUwIcBZDxZOS+fbEFMWzJx9SjJ1jDYNHEScRcQRvISwXXEP7tTyDW6EFWH0AylevC4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDK8xQVC; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHhsr/lxGkHJN0UT1dckvZIUVNvcODgFyqCbJxB3gNKtf3TCZ/Bso8B3YcU8mhpaZZoz8fl4v6NcjAySLI/3WSKBZyomMUw+qMleHy1roOUGtvr59vmwKhvOXfzINd6atq/CmrGKhD2KY/VaqjdOsVpwfpJpnZXMOxq6TTDCGiGlglY4nA8fqC+f80hxReuiowBFSGQJiNDLyw978SWc9kCv+b90TiTf1IV7eojNW+Rvn2D1RAWTI+UZQzh01CPq6v/pDhrJT3F7ct06bi5IaogFjz8jApl9I4pXdWR8+0M+lrBbzOosKF443iYmapYKdWplYAtq463cQvxhWgHsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHjxsdoJmmVqjclHQ4bALwJCPZrE4RnCYSZyLwj3qG8=;
 b=F97+AzF0OCqWDkrUZi15LzIix4gXSL3Sx6MsdrX3vIP/FWgyNyuYPdZJtbDQSJVxOu2Ca0karRe369pyRXbMdwWahra1AVHpmSsWPx9NSGXGfjsCrAGQMDjWGIiIBmGgoO5nLxae4rJT8X48DpZRLAUIgvjBlkyRirh/CwiivBgXtp6LJtXgEwyJ78mAyDwgSRygttPqRULdnuelln0QRJNmkgWLQXlbvI1JyM6bty9eWK517p2tE7YZn7pn1cbdwYKcOM3a0+eGGRaoWHWZOQKyv4V3D5OR8dnGUL99uBDKQ1d/2N3zR4vzqUoWMq9esEHdNkII7Xo14u59W/azsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHjxsdoJmmVqjclHQ4bALwJCPZrE4RnCYSZyLwj3qG8=;
 b=CDK8xQVCLb1ay3xOhkPpOrlcc5sFVIlNwRxlZEWabDmMbfMgTb88I/ztVm4IQNO0bRMDapQesaE8pVbS4DqYzjN/z6KbGAOC42bptXQsnlOZzqAJ7GkN5Ua/v8e/cZ0+yu9HNairqxOvvbTUmMyA7mEyzSNLgHoaMPngFNuJ/cthikxIVkW3yuBrGdYVVU3nv5ZjirmOUL/yQklvyUD9I/Dh0g2HxhiNhCYQvg53tVpTBjzy1RUxNHIAZzE3sCikD0/tAUs62d1sYwaYWzzG3Ya/0DvWgOEuxLx6NBGtHeci88hGmRF/XlEFXbGxFsaLwmwlqtVuUx6S16u5L0m5zg==
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:00:07 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::ff) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 17:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 17:00:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 08:59:50 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 08:59:49 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 14
 Nov 2025 08:59:42 -0800
Date: Fri, 14 Nov 2025 18:59:41 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write
 support
Message-ID: <20251114185941.59717d52.zhiw@nvidia.com>
In-Reply-To: <DE7EN1I1WCL8.39OE95LPS6XXH@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<20251110204119.18351-7-zhiw@nvidia.com>
	<DE7EN1I1WCL8.39OE95LPS6XXH@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: adbeaa4f-f58a-4f01-9d29-08de239f435c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RVZ/AtryIfhaEtWwOxUCk6lO87G/UWU9qTf7I2WvHaUhjtDMS1H9A1fsazoe?=
 =?us-ascii?Q?zAsDUYF8Op4bzFJYATIIXmhdnG+WuvKsUzp14qwukTVcdx02Bn5/BAy+2093?=
 =?us-ascii?Q?fN2uIJwn5Cj7nkKqH/amm8+96b1eFbfi2CgxHhzYqYotX84Y51z4s4mApqY3?=
 =?us-ascii?Q?MlMArEwVCIe9bfNC4xzbN6zU3Vd/AEutSgJgY7XRkkEdlbXAAOf9rBm2HnRV?=
 =?us-ascii?Q?x86cK+dy8laoIlXClaeLcc3tAAUI32Ha8lwQ9bGNXeKKWOm3cF9z2cEcB52p?=
 =?us-ascii?Q?Op4j+KltCQoSSyGebfpveAD82GIZCj5LIReT6eZvO49N1gHqv/bC4sus+Ykk?=
 =?us-ascii?Q?AEjdEcJUoa/Adj3cifz4EyaBRg9dUoGrccgke5sh6xUZ+Rly/KC0fHmTdDfk?=
 =?us-ascii?Q?cXkfwDHd3iSheP/VmU9LZ/OvMXASlvwmMz6TVTLVTabji5Pe8N3lgx+hEDzu?=
 =?us-ascii?Q?XYvik80/lYYrEfHQMybKgaYvFKMiHg/Y9p08KU4Z6X/UE+GrsjAQ+a7rVszV?=
 =?us-ascii?Q?UX8eg7IIcU3jJcr3XfiIvYoi6Z6/miCqaSrRLQntuAQjUWsqKkdJlJHPjdpg?=
 =?us-ascii?Q?e2/MG11JCSh75ADNVtxhJ01KexAKuD7FSKo6skch0Bq8vrjBjghCqJAhLaIK?=
 =?us-ascii?Q?sabyK88eMTOj2JwLwxccrAfaHadILpHFThKOrlAIgBZtDo1chfzkEGcEJL20?=
 =?us-ascii?Q?nad4CLKNIFYwMv/tfNVwelMt95VlCGxXt1cggMRCANFj7pVYLUljyjHv6SmC?=
 =?us-ascii?Q?VGXmTwjWHE1xeGKA5FHtKlIC7JoW3FiHRmyjdd8iCmtUFFIblWvx2XYR81zD?=
 =?us-ascii?Q?wILYHeiXz4AqIkUF8eUuRQODNIycxT+qiCFRmY8FuFnDze5GWPHulv9FhHKk?=
 =?us-ascii?Q?cS0ninvdf/XA33PDd03KmHuh9UdDNO61XB+BhQOPn7B/2zS+6dESFcesTdDV?=
 =?us-ascii?Q?i66JzrQ1jxj6XpUr62TzA+1vWCiypjN0iRa8POLVvJk5XgpufGIpDUEJ5GWz?=
 =?us-ascii?Q?7Lq6tAtD644dxr7gshFpo/vqNsQh68Fv3hnSqewPez6LUNlNQYkpk6gteDVS?=
 =?us-ascii?Q?WQZPueFX4IHYViaKCiW4T99fJuTIyyRDOCwKceJVNxc4Rr6e5Ahmt/hRkZoI?=
 =?us-ascii?Q?JiqCBdSlaWRO6QsOyM2ZA2DcxAoA/uGQCmyxm50ZzVTJXArsz3vziDU7vukV?=
 =?us-ascii?Q?x4tT/rdEG+0K1EiSeZb4RbtAAVblhD7sM1GwJPF/JAw0vf4ESICGAYv1dYxk?=
 =?us-ascii?Q?9osV3S0IYLn9XbyrYJ/n8m8EiNDMkr+v+dBRfW44FP/DaXhfe3vR1uHmRmM6?=
 =?us-ascii?Q?/VXIQo4eBoZrrPRroc+QGc1Jpo6hBFkCMAsftoUKZbxl6emPVt0ugU7ee1RZ?=
 =?us-ascii?Q?rwvFkts3fYAv6PEAZHdcq1Nt2KFcap4UeTnqIPcLCQ6XrhLdwJdzQsrA7cE1?=
 =?us-ascii?Q?sN8+wsCNS4Upboc6jUQ8V0OlPb4vj5Ysbp04o/qrJLKMETnJ09j73IqSPRST?=
 =?us-ascii?Q?tpFvai7AaEroSj4pbwBQW0rwCtMkS1Bn4U0ckmQKp5TdvRjHzxbTXIn7ybr9?=
 =?us-ascii?Q?g8YNlYzr/c4nil5bxG8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:00:06.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adbeaa4f-f58a-4f01-9d29-08de239f435c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

On Thu, 13 Nov 2025 16:56:28 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Tue Nov 11, 2025 at 5:41 AM JST, Zhi Wang wrote:
> > Drivers might need to access PCI config space for querying
> > capability structures and access the registers inside the
> > structures.
> >
> > For Rust drivers need to access PCI config space, the Rust PCI
> > abstraction needs to support it in a way that upholds Rust's safety
> > principles.
> >
> > Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to
> > provide safe accessors for PCI config space. The new type
> > implements the `Io` trait to share offset validation and
> > bound-checking logic with others.
> >
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/kernel/pci.rs    | 41 ++++++++++++++++++++++-
> >  rust/kernel/pci/io.rs | 75
> > ++++++++++++++++++++++++++++++++++++++++++- 2 files changed, 114
> > insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 410b79d46632..d8048c7d0f32 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -39,7 +39,10 @@
> >      ClassMask,
> >      Vendor, //
> >  };
> > -pub use self::io::Bar;
> > +pub use self::io::{
> > +    Bar,
> > +    ConfigSpace, //
> > +};
> >  pub use self::irq::{
> >      IrqType,
> >      IrqTypes,
> > @@ -330,6 +333,28 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> >      }
> >  }
> >  
> > +/// Represents the size of a PCI configuration space.
> > +///
> > +/// PCI devices can have either a *normal* (legacy) configuration
> > space of 256 bytes, +/// or an *extended* configuration space of
> > 4096 bytes as defined in the PCI Express +/// specification.
> 
> The comment says this is either, but below we have:
> 
> > @@ -141,4 +200,18 @@ pub fn iomap_region<'a>(
> >      ) -> impl PinInit<Devres<Bar>, Error> + 'a {
> >          self.iomap_region_sized::<0>(bar, name)
> >      }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw()
> > }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space_exteneded<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, {
> > ConfigSpaceSize::Extended.as_raw() }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> >  }
> 
> (typo on "exteneded" btw)
> 
> Which means that a caller can infallibly (both methods return a
> `Result` but can never fail, for some reason) create a `ConfigSpace`
> that does not match its actual size.
> 
> That's particularly a problem is `cfg_size` returns `256` but we call
> `config_space_extended`, as the returned `ConfigSpace` will have a
> `maxsize` that is smaller than its `MIN_SIZE`...
> 
> I guess we should either validate the size using `cfg_size` before
> creating and returning the `ConfigSpace`, or have a single method that
> returns a Result containing an enum which variants are the supported
> sizes?
> 

AFAIU, this was intentional according to usage model of the Io trait.
It has two checking paths, one is at build time and one is at run time.
Pretty much similar with MMIO traits:

- The driver assumes a minimum/expected working region size at build
  time. In PCI configuration space case, the driver knows if its device
  have a extended area or not, and choose
  config_space()/config_space_extended() accordingly.

- The actual available region size is decided at runtime, which will be
  from maxsize() method in the trait. So accessing the region will be
  checked 

The fallible accessors will do runtime check, while infallible
accessors will do build time check.

To following that model,

- cfg_size is only known at runtime. So I didn't get it invovled
  in the config_space()/config_space_extended() path, which is for
  runtime path.

- If a driver chooses the wrong config_space()/config_space_extended()
  which doesn't match its device nature at build time and compiling
  passes:

  a. device has extended area, but driver chooses config_space():
	- the infallible accessors only allows to acccess the legacy
	  256-byte area at build time. If the driver uses the fallible
	  accessors, it still can access the extended area at runtime.

  b. device doesn't have extended area, but driver chooses
  config_space_extended():

	- In this case, the driver can use the infallible accessors to
	  reach the unexpected area and slipped away from the build
	  time check (I think it is the similar situation in MMIO path
	  since it is device specific.). The driver will get !0 at
	  runtime if it reads extended area.

	- Infallible path is not affected. 

> Just an idea for your consideration, I don't know whether that would
> actually work better. :)

It is always good to know new and nice tricks. :)

Z.

