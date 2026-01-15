Return-Path: <linux-pci+bounces-44911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0DD230D8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9523300A871
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43247325726;
	Thu, 15 Jan 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gC1PFzxx"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5632B9A7;
	Thu, 15 Jan 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464957; cv=fail; b=rdAVgJrgp+voSzI1xfwUFsYZjkMpy9U4LE1VxOB0dCoNjiwq9S4TEb/PPEEfeZi4+LSgZ5qUAAnMhhNBr3738yIIaL8I7f0cMKHKpb+rZ7dDfck0nexR23xV82bESqX7HhFH7XcF419uM3RrCKyExbFtyR2V/AKNVigBoYkwtQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464957; c=relaxed/simple;
	bh=6Lt/6KeySDBdOA7INzNlUFbjwBKFPuGPXA0TfhC3XdI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNimnwXsExjI5aIPKUuX/NLB1tekMqxpo6ZRdfrwhOen6QmU+7BcL16v6O/RT+cKwRFYms611H7f4LflVRXPNoDieuheV+dn9fSKXZyxFcThdw3oIIVWOx4iZk1TYFq9u77wp08PsXnN/YJnLTiYCKp2SNOHTg91JmI0ecCEIBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gC1PFzxx; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxFqEaOp2T9+goJ76EneEGTD6FgWE52CMp04DPhxpuPYx5AzajHDRbf/apRcheoskFr2tEMruc0dJYyy6WY1mSYuifjPtXqET85aRpdfkmQTBREtXZjsIUAncQrpYMjYFXYxNHVxSrXmf/Yhg3j8JXsK0pBjSHfTkIO9Eh1jXzMZcIcFzO3sR1YXBovZCNxJ9f01qelQGnqcYOlZRVMyUDD4GZSTo7Y/ykRR4IxDZmquZgRl5zl0TVeDLyqYiNZBWJR1CefwC9v9xCyVWdgyNkssgtLRmkUtDN+2SOzbwQNNKIwMemEfMwCOAY3vDc54FfQq2QmXC36RkWdyJy1RTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqM5xLoq/2Gm8x/5T89OnM0unhZvYIfQv59xQIlrrMg=;
 b=iIidokCBBOlU8qDcjCMP5/TNC7g5h//q/fviQOR1ZAcbLx1RuJpH72AfvTjWtPO1RGWetxLL1VoN+MKzB1Yot9m/3gW+NbpZvym4Kao1Klm1rk2n/ab3VTYcxypJyYnDWVrVrfmsqzIirztD7cTM5C63KMqubQpz2Qwy5Jx0Oj2vhN1V7AtKJWtvbM/AMDmy6J4Ba+VL4E8iCsKaCUaZ00dFo5ezmXGe1H0JBhB4Wlamqz/WS2VZluBemVkyARhcOsiPHb1BlEostoIk5D7zLjXiW7dmEktfoS75XlUJ0O55Lnf/ZxULs6mwpoZknWGcJC2P6qQ2b5HSik7rHd4S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqM5xLoq/2Gm8x/5T89OnM0unhZvYIfQv59xQIlrrMg=;
 b=gC1PFzxxCHNkq/bY1atJA2zsS6DHi2N1yAJ5aBkB9T/fGImh7J2uQk+QyrlIV9K8zM/t4ye0W2e3zEITinRVltDiFE2kwJuW+D1C+TH2TI0lgBEVbqFat6T0dkOkzNfF3rH0cFp0caNzhh5dpVohh71SWdUjAjOCXmEXnQdGJ2cxqlNIvCITA8vs3geddJdH/MfYOkcvMRQnQ+UAMWVOSqxW0GUN5ecaXHI6MgDZoS+HwkYdn/dVd6Gyn5d9CQi8f/b0/i+9HZ7PPSiRLWAJyo43LGJbk3Fg4WWdPw672XqibTA5vVMHT8zkB8YUnhSvYBOOby937+qa2dNFqsZuLg==
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:15:48 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e5:cafe::a7) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 08:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Thu, 15 Jan 2026 08:15:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:15:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:15:33 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 00:15:26 -0800
Date: Thu, 15 Jan 2026 10:15:25 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v8 4/5] rust: pci: add config space read/write support
Message-ID: <20260115101525.7537fb9e.zhiw@nvidia.com>
In-Reply-To: <20260113092253.220346-5-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
	<20260113092253.220346-5-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 009647a1-b6ff-4b9f-c696-08de540e4a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2JPV2FORk04QzNqeGk0OS95Q01lNDNqR0lMb3JVaVB1dHFObVMwbEFDZFN6?=
 =?utf-8?B?bDdING9sdjM1YUJxaitPdWY0ZSttVVFNd0d0MmNLQk5pZ1JRMWgwTlloY0VX?=
 =?utf-8?B?TXlnNjNvOGV5Rlh6TmxvUWM4Vm9HelZYdjVYbXZzSGZZOExCYWxuY01abFlG?=
 =?utf-8?B?ZHZ2REh1cWdwWk1TajFENnR1Q1ZGR2E0ZWk5ai84aHRwSkcwZHdPNjQxOWhS?=
 =?utf-8?B?U2cxVGZ6MkZOcXVNdi94L2FEK3E2R0VNTlp4eHA0UEEweHlyd082Vk5vNEg3?=
 =?utf-8?B?R21EYTdVelJYSzJwdVhLRnc4K0N4NHVKOG5OL3J1RUIwRkdzbHpzNXN3YlJI?=
 =?utf-8?B?WC85eTlBTTkzdU8zNUpwZ1NoRXBmeE54ZWx2TmZQd1RzM3NXMnhGWDdaYW5X?=
 =?utf-8?B?SGRoeTJ5K3MzRDAzM0hUdjhRaUthRnR4RnVPR3VZTXM4V1NMdDZGbUJ3MEZw?=
 =?utf-8?B?dk5LeVJKdStjcUVOZHlrWS8yaE9ubFpVSXc5c3d4aG9sV2d2RHpUSU9yVlFC?=
 =?utf-8?B?dzhjdVczYml3aDFTUzJsdXBaMFJ4NFF2dGQvNk5XN0dIMU9HbWNSOXNVRHpZ?=
 =?utf-8?B?a3RsSHNBRDRTN1JFOU4wZDZyNGY5ZmZDMXYwUTJxWDQ2T1grM0JlRW95ZlJi?=
 =?utf-8?B?ZzI0d1RvV1NVQ2FWTmVUaG9PcWZNNmcrSmtoN0UxM3oySm5ZR1lYbHIzZ0Zm?=
 =?utf-8?B?UWc1TWRuMHdWT3dCYU9TdlhYMW14RlIyRG40UTg2WjFWVmQvUnZDY3BEMkVW?=
 =?utf-8?B?N25mSis1VEhHNUFiekwxZ1g2WUhnREtraHpGSTFYOFZNQ2U0RHZYZE1YVW11?=
 =?utf-8?B?dnkvTk44VnFncmFNTm1GamhBWFJ0eWFrRFFSdStBN3Z0UzNnV0RDT1BZZkR4?=
 =?utf-8?B?RlRzWHIxdlVzVHBqVHdCdjAyNUpGV0Q0dWpMc0lBT2ROcUQ0Nzc4SWRzdWlv?=
 =?utf-8?B?SHhpck9ORGgvcHNkZS9iOWJrTS9DWjY0RmhWdi9XOWZWb3dBTGUrR3lqelh1?=
 =?utf-8?B?UUwxNXc0L2RmWmxmQkFpV0o3SGU4VE4xUlRKTFJTNTgwNmhhSzF2MURsa0lL?=
 =?utf-8?B?NytUbWVRcDYxOFREUmNiWTJPeDVnbGlYbXp2NXRZRTdFakVGRWNSM3BQa3RM?=
 =?utf-8?B?d3J1RWtKUXljRmw2VDdIejNRM0g2TUZFOEx2dEFWQWs4Zkx6SzVKVXk4QXQx?=
 =?utf-8?B?NDI0cENTbjBHRFlIYWFtTVFkbnRHSHVqbXJDejN2ZWdvV29uN2JORW1JZGRx?=
 =?utf-8?B?Z1hqL3RJRlMrK0NuOGpMb2ppelRhTXl0Y1U1WUVlSjhvQWFJeW1NMUFoV0dx?=
 =?utf-8?B?SjEzUjYzVUJlemd3UGVlLzJuRjVIRlNsbUo4SGVwNEJ3QVVhdmxpUVhxaXE5?=
 =?utf-8?B?NkhDbnhWeHNZdE5EQXNoZi9PODU1eklKMVhSb3lTc1lVSGtadlY4K3l4ZVZk?=
 =?utf-8?B?ZVlVOGdwWSt0MTRzT1BLWDZtZURXWHhVNzNYUlNQMnYrV0t3ZFBZWm5rTFdo?=
 =?utf-8?B?UzBPL0dBdHNIaVkyWGZZeldsOU5VV2J0RTJITk9oUjFpTDN4OHpNbFh3WHpn?=
 =?utf-8?B?Nk9SS2ZTOURRRDRvYWFnTTBXUSsxeUl5SXVoVmdJem5POUh2anl5VU8vVS92?=
 =?utf-8?B?d0lTTXB1R1ZRQWo0bTN6RFFrNXVXV1RLencxOVZFMTZrdjI5TlN3UVJzVy90?=
 =?utf-8?B?YnJPWGxuZW05WUFCZ2s0YThWVVUvT0JFZjJmK1B6V3R1OU9sb2RkSWRyd1J6?=
 =?utf-8?B?QWxZM3pRSHJYcnNuRW92cms3eDRWaS9XMnNJd3RXY291a2lZTGFPd1NtbXJJ?=
 =?utf-8?B?VG96bGgxaUdkZ1ZxU2RadGZOSWJtOXBWQkJJeituNnROa1E0ZmlQRnlVZmcx?=
 =?utf-8?B?b0hzeXJGVi83SVhscnNZZDh4VEw0UDVRT20ycmErZUZqbytsS3dieWJoWVR0?=
 =?utf-8?B?RUtJV0JVbGpKRnl1WjJFWW1sdld4OXlsbE1oZTZ3dFByYmYxNzl3RUlXRzZG?=
 =?utf-8?B?WFF1azZQNGY4MkRVTU8wZm5FeFFOTVRqeDZGeVFpTVZpZGVsUlQ1VTRzeEUv?=
 =?utf-8?B?OUhtNENwZ2I2Q1htVkJNSTNkKzFKL244emFnbGxIT0kyNEhIb0hEM3dTM3NQ?=
 =?utf-8?B?ZWxkWXNFUjMva3UxeW1tcEpJaG5NcXN2RkJXUU82NmlvSndwUUhBWGtIYkRn?=
 =?utf-8?B?K05TdDlDcTN6QXNUeWlQVEFIdzBmSU5MSEVmV2g4elJCNTlBWU1HQXFqQUJ2?=
 =?utf-8?B?N25TVWU5aHNiTzVnVzE4c2h0TndRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:15:48.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009647a1-b6ff-4b9f-c696-08de540e4a57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

On Tue, 13 Jan 2026 11:22:51 +0200
Zhi Wang <zhiw@nvidia.com> wrote:

Thanks, I will re-spin this today.=20

> Drivers might need to access PCI config space for querying capability
> structures and access the registers inside the structures.
>=20
> For Rust drivers need to access PCI config space, the Rust PCI
> abstraction needs to support it in a way that upholds Rust's safety
> principles.
>=20
> Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
> accessors for PCI config space. The new type implements the `Io` trait to
> share offset validation and bound-checking logic with others.
>=20
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs    |  43 ++++++++++++++-
>  rust/kernel/pci/io.rs | 118 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 82e128431f08..f373413e8a84 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -40,7 +40,10 @@
>      ClassMask,
>      Vendor, //
>  };
> -pub use self::io::Bar;
> +pub use self::io::{
> +    Bar,
> +    ConfigSpace, //
> +};
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> @@ -331,6 +334,30 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>      }
>  }
> =20
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space
> of 256 bytes, +/// or an *extended* configuration space of 4096 bytes as
> defined in the PCI Express +/// specification.
> +#[repr(usize)]
> +pub enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub const fn as_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so
> the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize
> +    }
> +}
> +
>  impl Device {
>      /// Returns the PCI vendor ID as [`Vendor`].
>      ///
> @@ -427,6 +454,20 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct
> pci_dev`. Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct
> pci_dev`.
> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
> +        match size {
> +            256 =3D> Ok(ConfigSpaceSize::Normal),
> +            4096 =3D> Ok(ConfigSpaceSize::Extended),
> +            _ =3D> {
> +                debug_assert!(false);
> +                Err(EINVAL)
> +            }
> +        }
> +    }
>  }
> =20
>  impl Device<device::Core> {
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e3377397666e..c8741f0080ec 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -2,12 +2,19 @@
> =20
>  //! PCI memory-mapped I/O infrastructure.
> =20
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
> +        IoBase,
> +        IoKnownSize,
>          Mmio,
>          MmioRaw, //
>      },
> @@ -16,6 +23,101 @@
>  };
>  use core::ops::Deref;
> =20
> +/// The PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*`
> helpers. +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space).
> +pub struct ConfigSpace<'a, const SIZE: usize =3D {
> ConfigSpaceSize::Extended as usize }> {
> +    pub(crate) pdev: &'a Device<device::Bound>,
> +}
> +
> +/// Internal helper macros used to invoke C PCI configuration space
> read functions. +///
> +/// This macro is intended to be used by higher-level PCI configuration
> space access macros +/// (define_read) and provides a unified expansion
> for infallible vs. fallible read semantics. It +/// emits a direct call
> into the corresponding C helper and performs the required cast to the
> Rust +/// return type. +///
> +/// # Parameters
> +///
> +/// * `$c_fn` =E2=80=93 The C function performing the PCI configuration =
space
> write. +/// * `$self` =E2=80=93 The I/O backend object.
> +/// * `$ty` =E2=80=93 The type of the value to read.
> +/// * `$addr` =E2=80=93 The PCI configuration space offset to read.
> +///
> +/// This macro does not perform any validation; all invariants must be
> upheld by the higher-level +/// abstraction invoking it.
> +macro_rules! call_config_read {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =3D> {{
> +        let mut val: $ty =3D 0;
> +        // SAFETY: By the type invariant `$self.pdev` is a valid
> address.
> +        // CAST: The offset is cast to `i32` because the C functions
> expect a 32-bit signed offset
> +        // parameter. PCI configuration space size is at most 4096
> bytes, so the value always fits
> +        // within `i32` without truncation or sign change.
> +        // Return value from C function is ignored in infallible
> accessors.
> +        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr
> as i32, &mut val) };
> +        val
> +    }};
> +}
> +
> +/// Internal helper macros used to invoke C PCI configuration space
> write functions. +///
> +/// This macro is intended to be used by higher-level PCI configuration
> space access macros +/// (define_write) and provides a unified expansion
> for infallible vs. fallible read semantics. It +/// emits a direct call
> into the corresponding C helper and performs the required cast to the
> Rust +/// return type. +///
> +/// # Parameters
> +///
> +/// * `$c_fn` =E2=80=93 The C function performing the PCI configuration =
space
> write. +/// * `$self` =E2=80=93 The I/O backend object.
> +/// * `$ty` =E2=80=93 The type of the written value.
> +/// * `$addr` =E2=80=93 The configuration space offset to write.
> +/// * `$value` =E2=80=93 The value to write.
> +///
> +/// This macro does not perform any validation; all invariants must be
> upheld by the higher-level +/// abstraction invoking it.
> +macro_rules! call_config_write {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr,
> $value:expr) =3D> {
> +        // SAFETY: By the type invariant `$self.pdev` is a valid
> address.
> +        // CAST: The offset is cast to `i32` because the C functions
> expect a 32-bit signed offset
> +        // parameter. PCI configuration space size is at most 4096
> bytes, so the value always fits
> +        // within `i32` without truncation or sign change.
> +        // Return value from C function is ignored in infallible
> accessors.
> +        let _ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr
> as i32, $value) };
> +    };
> +}
> +
> +impl<'a, const SIZE: usize> IoBase for ConfigSpace<'a, SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +
> +    /// Returns the base address of the I/O region. It is always 0 for
> configuration space.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0
> +    }
> +
> +    /// Returns the maximum size of the configuration space.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.pdev.cfg_size().map_or(0, |v| v as usize)
> +    }
> +}
> +
> +impl<'a, const SIZE: usize> IoKnownSize for ConfigSpace<'a, SIZE> {
> +    define_read!(infallible, read8,
> call_config_read(pci_read_config_byte) -> u8);
> +    define_read!(infallible, read16,
> call_config_read(pci_read_config_word) -> u16);
> +    define_read!(infallible, read32,
> call_config_read(pci_read_config_dword) -> u32); +
> +    define_write!(infallible, write8,
> call_config_write(pci_write_config_byte) <- u8);
> +    define_write!(infallible, write16,
> call_config_write(pci_write_config_word) <- u16);
> +    define_write!(infallible, write32,
> call_config_write(pci_write_config_dword) <- u32); +}
> +
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
>  /// I/O backend assumes that the device is little-endian and will
> automatically @@ -144,4 +246,18 @@ pub fn iomap_region<'a>(
>      ) -> impl PinInit<Devres<Bar>, Error> + 'a {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_extended<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw()
> }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }


