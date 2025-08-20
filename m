Return-Path: <linux-pci+bounces-34338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AFB2D2B9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA097A728B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02D1F0E34;
	Wed, 20 Aug 2025 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="iN4wyHl4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDD2BB1D
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661853; cv=none; b=dX9481OOZyD8z+ZeXIwkPv6CTTlDEJ+OPcLgkRs4s2brKZw/c2TKCi0v2oftOxuUIE3UKlsnLLxEvmWr5tRJTbamEm2NOeSui31viL2OfVUMInr3qKqVgFmTFPJCO7S0oXXNlIvxVnjqQCYBI2z5/KJUp1P+8d47llQm+/AfYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661853; c=relaxed/simple;
	bh=CWLihZiq5DZ+BtWOx3p4ga02FpdbSI3rbYrSMDo+0Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NocZumT+dzRplGcz8y7oEL7P2OkSAcKjjuoakm73Iovg6jbPMFmgoo+GJqnSFyR7y9N+uXRKAbASg4OZlq53J47avbf2m1DqwyGlIFU/l+rOzLPfVaP15AKxJ4AiWkdoK5FfSskhwylI4FMzPi4fRieYKMbvVTQJ+Pyu1QhViBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=iN4wyHl4; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755661849; x=1755921049;
	bh=Pcc0kL2+l9Pmm6KFyVG73R66uWz7dqU0MavY6sZy6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iN4wyHl49SXYoo53Uk5Gv10Pdv8gmbqWjP6t/XOahDK1Zd5b8JnMiAEZDhzcMfjXU
	 q2bW3kwrjQuPCaWTe/Rj5BHmxIiOB3yoXdgIh1Wu8sZ4tFT/1MK8+rxphnvzt97bLT
	 tX+lzE8NJDfAr7kc209VeF0V9HEwanB9bHCMiiYZdvIwGoyB4BtLZCqTy0gn0cITxg
	 lQ8tyIBL3cR7NgQ4x+hh0XhvauDMHZfnb/ekYLaSmkYGVij4p3dylQIGM+4now+Qlu
	 8JJmsdLsWFO2GNM7Nr60E+dEnEFRH1tPUO2p3jnGCPTZqByGRBdrJme312MutMMi7m
	 NqG6apNiGXStg==
X-Pm-Submission-Id: 4c6CCq1vDSz1DDrj
Date: Wed, 20 Aug 2025 03:50:44 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] gpu: nova-core: avoid probing non-display/compute
 PCI functions
Message-ID: <aKVGFC4UVpjyAXWO@archiso>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818013305.1089446-3-jhubbard@nvidia.com>

On Sun, Aug 17, 2025 at 06:33:04PM -0700, John Hubbard wrote:
> NovaCore has so far been too imprecise about figuring out if .probe()
> has found a supported PCI PF (Physical Function). By that I mean:
> .probe() sets up BAR0 (which involves a lot of very careful devres and
> Device<Bound> details behind the scenes). And then if it is dealing with
> a non-supported device such as the .1 audio PF on many GPUs, it fails
> out due to an unexpected BAR0 size. We have been fortunate that the BAR0
> sizes are different.
> 
> Really, we should be filtering on PCI class ID instead. These days I
> think we can confidently pick out Nova's supported PF's via PCI class
> ID. And if not, then we'll revisit.
> 
> The approach here is to filter on "Display VGA" or "Display 3D", which
> is how PCI class IDs express "this is a modern GPU's PF".
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 274989ea1fb4..4ec5b861a345 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
> +use kernel::{
> +    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
> +};
>  
>  use crate::gpu::Gpu;
>  
> @@ -18,10 +20,25 @@ pub(crate) struct NovaCore {
>      PCI_TABLE,
>      MODULE_PCI_TABLE,
>      <NovaCore as pci::Driver>::IdInfo,
> -    [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings::PCI_ANY_ID as u32),
> -        ()
> -    )]
> +    [
> +        // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_VGA,
> +                Class::MASK_CLASS_SUBCLASS,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),
> +            ()
> +        ),
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_3D,
> +                Class::MASK_CLASS_SUBCLASS,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),
> +            ()
> +        ),
> +    ]
>  );
>  
>  impl pci::Driver for NovaCore {
> -- 
> 2.50.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

