Return-Path: <linux-pci+bounces-41453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C556C661C7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 19BCE29716
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E33446A4;
	Mon, 17 Nov 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKxyV9pb"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA673446D9;
	Mon, 17 Nov 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411332; cv=fail; b=dfMJkhwpjxBTI9k+05e72kis+m0eW4kdUfqP/cguFVHxpD3+qAjC3f9qEYhuSWRWB0Gre0hWbrbF8CjgZwkJvAG4iSMhQptVnj9swXY/tbehzqYi+vUZZH+dtJAxOMclRUI/hcX/fwCt606Rcg3LmpfXoj4DiWwUSlEcT6e0G8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411332; c=relaxed/simple;
	bh=i8QD0AjEIwIpuxvU0kXnkLtdVls768w3atbGXMLxM+E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eptD6/O65B9xAqluNT2pBq6q34o7SEfPrNpAUWXg+Bplpo/Z6U2s1B4YCwv3lXh/uQsKZcUl7sLvubjMP+73nwnkhkZeCxHLnj87gWJltC9nDJXpdbzeq8Fk8Ipy1yClPziQsUhumQ2Y34i2IsH4RFaRXzfYyodhTf14AW44PPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKxyV9pb; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFYjkaS5t3BxvRAqV8tsoYo8kU9FelLz75S0tEely5cvF/XZyYfpUVCxoI0ggR7zv5zrrf4VG6XMtHhYldCO/xlwkpQ5sJsCSZ4V80T75S/p492xUzUPbwK769XVcqh+U29Q7kW2nWmaPaVVUlwURUtHb3jeKwuYOCW7WtJVU90QDHIysKYQ11mDnF7IMcM05XKF9na0dhdPLJH91wsoGIvuz2fnsZuIP8oKJBgsrW+dbifrTFMpGDzT9lIUWOqMZtYoIgsc2eMMtd2dlMEQsW8LXPwsycudtyF009+g2qBY5YL4L7wSPSzHo+bmuAvKGG1wHPvZeyFiz/81v3AA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT6v1OdkuhlhAKNI+7nOrHNLMDU8keSZD7SCXPsHUEg=;
 b=rTxEYrCZkFD1JT9BS5hdRwCC4rQJ35k+/uKfV+qHen/nZoiNXTwNUyd/m4/WxwQ2/4c3/1Fg1sUPujY9crEZbKEQxnh7qdYhFVEDjJurswZueeD56nMifvr23FTfqwaaqPeD+WRvb9zKsX8Ms44nDEk39SeQkQyJZoWNRGE7BwBiQ8h1Pz5HiGhkF2alqRvRtIyzvQzdF2sJp/Aq72JA7d0IrVdF1Q3puQwAaMX7YiLlECbX80D8+wMXHHxZ32E6GY01TZyc8NrwCiWrC671aAbIJga//uzYw9Z6AaHGFUeld3RiGDB6in+ReQcWw/iUk3VJZdMXjl/cbGuq8AY8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT6v1OdkuhlhAKNI+7nOrHNLMDU8keSZD7SCXPsHUEg=;
 b=FKxyV9pbhrQHX8SiUvo6hCqbHyq3/fsNp+0jv9l2aLUDGfNAIDdpRve7qEXQ3ZQDmA9Ozza6ipUzqhzWaMTJnoxqDc7dvVfY1TfZWu3yRKYShQ4OPQoYdeBC1n+8hP2/v5vZxFXcMSpKUMCHIszWuypsUeSjecIu7H+ZcyQ8niq/v9fFGm0AiHsOLz1+frlZULIUiAHyADPWegI1JrBZ+G7eRVcjSaIf89E5+p7KhHjE677WdekM3BkkuOkHOcn55ZtdCa4ULlJDrWI/uUcJJvpBXD8r3JnPOMwbFlShzm6OBmP63D5/TXQLut/vmHhZm2B62dse3QDJ/cY3/1R7uw==
Received: from CH5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:1f1::22)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 20:28:32 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9f) by CH5PR03CA0009.outlook.office365.com
 (2603:10b6:610:1f1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 20:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 20:28:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 12:28:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 12:28:15 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 12:28:07 -0800
Date: Mon, 17 Nov 2025 22:28:06 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write
 support
Message-ID: <20251117222806.49d1a13d.zhiw@nvidia.com>
In-Reply-To: <20251114002005.GA2384907@joelbox2>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<20251110204119.18351-7-zhiw@nvidia.com>
	<20251114002005.GA2384907@joelbox2>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f730a7-871a-4139-467e-08de2617e059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iljeI+Km1wZKsziVKg+ieDIjeduoEbdb9h/t5c/VhRq1/cPLqkISlzptoBIh?=
 =?us-ascii?Q?Z/xbo4skcmDtNxTu09rRfiakQKix+Fmw47wvZXrj8uaIDrxVpATuZmwTHAvG?=
 =?us-ascii?Q?VImfeTpJLb5qqzUcCI+HJg+nq4UtqDERvsQxvchan5Zv/CzKEFYL9PlUgCst?=
 =?us-ascii?Q?KTPvM2AZNTQs2OQaryIh/IeKgq45Q6wqUi/X4TicNsQKpjIKBR4hLkKkY9BC?=
 =?us-ascii?Q?ijh1GDawCwBx40WwcPQKh6cRSfDQAkE1o4DUjVpotuH698uStP55dP8bMvpj?=
 =?us-ascii?Q?jS3ASWJwoDs9Ixc0ESGg8L+p3Vop6cPU7xtYq7VHW4kdObD191UnPqugxrx5?=
 =?us-ascii?Q?waFQU4IfSU6xA+lbrCqYXi3nHoN55Me3++JK2/0IsRLlRyI/NbRrZHSnINE2?=
 =?us-ascii?Q?A5hY75jOlabDV4mdSI29DhQUKQHgH51WkDFRlMQVyLoyAto1j/QjGQnQ0Sci?=
 =?us-ascii?Q?/B3vjdp5XoAQGCeDlIUibJLgSnsXvtbpQprVycF7JQK8KHX9s+QicV5Uh5wo?=
 =?us-ascii?Q?Hx3EDcf2P5cZnfjgIAU6P1t+9ao2UAyi+6+PgRDt+1x7S+y9q3ouKB+iQUaV?=
 =?us-ascii?Q?ONPtoz/yxbk17fLKOxC5M9P4w31GMSUdyxcyloBm6BQkhJMHfRR+/hs2A0Gw?=
 =?us-ascii?Q?VCdNkViFjuACAPmbfD/3SeD7RutHx3bYR0gvA1uQJKhRxKoaY250LvdkEE/3?=
 =?us-ascii?Q?W5tYHJYxMpNbaVr+Kv3UPYCfVYjRV27lgV7fjOG+V79ZlftE1675Hr4fpRxo?=
 =?us-ascii?Q?SEcLeeecfPyNuvR3ww53rvVSSrqG9eOvd0p6gJ3yj09kKNb7fQ5aJPUAHHF9?=
 =?us-ascii?Q?vgiL5hrx0wQONfxLqGq3/AiI/fUjwMGpnsbFgkmMqqluthqCQRhhV9vYfNAx?=
 =?us-ascii?Q?B8VYmIB9USPo3Z2OHTTXV8D5451k2IBCW0ujIaPo9Tlv2WrtqxTKj61Am2er?=
 =?us-ascii?Q?dMZyBfxB0IVa3u6BhRH8Mu97TLXEspKlQ1kZqqaVrZ4g4wPI1i9C51yeKbKe?=
 =?us-ascii?Q?Ur9bzDoFl5Bpz5GWdzDOd6jfKzlt8a74RMf+DQMHTXYJxYfrWNS3JMMIXOK/?=
 =?us-ascii?Q?EUODb93JfdukAtwEDJWjO8eOzFycIW8/BMans3HxKA45re2nfJMQe0I0KJt3?=
 =?us-ascii?Q?i3/RJPSISer/3kAU9f+cvu6LH7ycpMSzDaD27L14rU1ytMzUgn/DE23xUUFe?=
 =?us-ascii?Q?pwwNuvPfyw247yDC0wDVVX++q4RASXG6+FpQRQZGuH49LpiNAvtqRPtSq+mr?=
 =?us-ascii?Q?XRX809j+J2h01U7f/7EefBwgA8TuEAqSAsw7WFvbpT/JCNK9MzYfRconBRqq?=
 =?us-ascii?Q?s4DCrWjRHaruQ1OiE6gvtABmQm+/QFZWlTO0cI9orFNwPYWnZH7IpdUSfOOB?=
 =?us-ascii?Q?B6OAnjyKQJr9iK5aqD/LVXqBkeuhqFHK/ETK/GVP1zn+r0lS1DJnZ7cOZJDO?=
 =?us-ascii?Q?U55X0xjctQ/Ud69N2/HCClSS+g5cCvLLcOGWaddDkgdD1OUhPgX72X/XE12k?=
 =?us-ascii?Q?rX3BmnAOCOOen0mKjn9YqkugHYD/jcf9lVVQfAx/hO22IpXhClZmCUkSgXN5?=
 =?us-ascii?Q?IpQACGA+1u35CVv2esk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 20:28:32.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f730a7-871a-4139-467e-08de2617e059
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682

On Thu, 13 Nov 2025 19:20:05 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Hi Zhi,
> 
> On Mon, Nov 10, 2025 at 10:41:18PM +0200, Zhi Wang wrote:
> [..]  
> >  impl Device<device::Core> {
> > diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> > index 2bbb3261198d..bb78a83fe92c 100644
> > --- a/rust/kernel/pci/io.rs
> > +++ b/rust/kernel/pci/io.rs
> > @@ -2,12 +2,19 @@
> >  
> >  //! PCI memory-mapped I/O infrastructure.
> >  
> > -use super::Device;
> > +use super::{
> > +    ConfigSpaceSize,
> > +    Device, //
> > +};
> >  use crate::{
> >      bindings,
> >      device,
> >      devres::Devres,
> >      io::{
> > +        define_read,
> > +        define_write,
> > +        Io,
> > +        IoInfallible,
> >          Mmio,
> >          MmioRaw, //
> >      },
> > @@ -16,6 +23,58 @@
> >  };
> >  use core::ops::Deref;
> >  
> > +/// The PCI configuration space of a device.
> > +///
> > +/// Provides typed read and write accessors for configuration
> > registers +/// using the standard `pci_read_config_*` and
> > `pci_write_config_*` helpers. +///
> > +/// The generic const parameter `SIZE` can be used to indicate the
> > +/// maximum size of the configuration space (e.g. 256 bytes for
> > legacy, +/// 4096 bytes for extended config space).
> > +pub struct ConfigSpace<'a, const SIZE: usize = {
> > ConfigSpaceSize::Extended as usize }> {
> > +    pub(crate) pdev: &'a Device<device::Bound>,
> > +}
> > +
> > +macro_rules! call_config_read {
> > +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =>
> > {{
> > +        let mut val: $ty = 0;
> > +        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(),
> > $addr as i32, &mut val) };
> > +        val
> > +    }};
> > +}
> > +
> > +macro_rules! call_config_write {
> > +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr,
> > $value:expr) => {
> > +        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(),
> > $addr as i32, $value) };
> 
> unsafe block needs safety comments, also I understand 'as' to convert

snip

> is generally forbidden without a CAST: comment or using ::from() for
> conversion because it can by a lossy conversion.
> 

Let me take a look, basically this was similar with the define_{read,
mmio} macros, which has originally been from the mainline. Might have to
fix that part as well.

> Also we should have a comment on why its safe for _ret to be ignored.
> Basically what guarantees that the call is really infallible?
> Anything we can do to ensure errors are not silently ignored? Let me
> know if I missed something.
> 

This was discussed with Danilo on Zulip. The driver will observe a
!0 value on read when an error occurs in the infallible accessors. For
writes, I think the driver should read the value back. (similar with
MMIO cases)

Besides those, I think the driver needs to use fallible ones if it
really cares about the return.

Z.

> [..]
> 
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space_exteneded<'a>(
> 
> typo in func name.
> 
> thanks,
> 
>  - Joel
> 
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, {
> > ConfigSpaceSize::Extended.as_raw() }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> >  }
> > -- 
> > 2.51.0
> > 


