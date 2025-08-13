Return-Path: <linux-pci+bounces-34010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411DB257C4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8201717A2CA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21312FC898;
	Wed, 13 Aug 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKCA+dRU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D02FC866;
	Wed, 13 Aug 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129020; cv=none; b=nPWVBfO3/23j1McUDqtctZbyATvnHFxbCpXL46FYDtpAaGZVZkVKZT+0omjC6kTrKL2cjERyup665ia2YTivpj7SIrSVY/psMcDbIeIgKmW3Gv1zPRD+hka36M8bcSim7nJGu76R1Qpg0Y/M/tnXQbcHlRqxLwE0JnwYoajsXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129020; c=relaxed/simple;
	bh=UOQSz/cxSX+gmmStNPE2E1T/NKJU7ozuDXqNyfgHgww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=j3g2FTmoDR0g4QKqcbv2z7cLnjCgAjz07KzBfd4vUAej9WTJcxQAju8YG0hJzef1SaJ4ttqPupaYyG6WEMw4nyNT5M8Qcl2ZcGHZnxKfErAIS/t86G8y8Geawbs5lnOMduLsyvi1WrjPt04vQC3BTDyMdRvSiZ4HBPHNGfArYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKCA+dRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8529C4CEEB;
	Wed, 13 Aug 2025 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129020;
	bh=UOQSz/cxSX+gmmStNPE2E1T/NKJU7ozuDXqNyfgHgww=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WKCA+dRUfarK/+pDGu5pYNM0sLNOxHcij9cd9XFvkyYOZIGuqgm8N+vnXdHIDHb4i
	 E2MAq6bOVvrxYJm5qdwv6SGQn3ILI9W3FKujPIUzlunOXrbycGA2wksi1xwrhIVS5q
	 3uobXo1SOyUs3aZiNlpacKsdYlnARfohbqFvY78eAuXtqhaaaPi53cTlrWQQ8Q2XBT
	 66Iej23Nc5ShfOXbRlymtA7879MyCFoPAopCPNeIrL/qOdBARRptuRzY8zi0FlK/C9
	 jWewO74xntVS99NwDvBSnVaPMHd0cUWUZ8fn8CMms6hN2cb/EFp5Mi2ZGGTgve5Br9
	 xyGonmaTUyCGg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 01:50:14 +0200
Message-Id: <DC1PB630413R.33T95R794VWMC@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: avoid probing non-display/compute PCI
 functions
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250813232859.224316-1-jhubbard@nvidia.com>
In-Reply-To: <20250813232859.224316-1-jhubbard@nvidia.com>

On Thu Aug 14, 2025 at 1:28 AM CEST, John Hubbard wrote:
> NovaCore 0000:c1:00.0: GPU instance built
> NovaCore 0000:c1:00.1: Probe Nova Core GPU driver.
> NovaCore 0000:c1:00.1: enabling device (0000 -> 0002)
> NovaCore 0000:c1:00.1: probe with driver NovaCore failed with error -22
> ...
> Bad IO access at port 0x0 ()
> WARNING: CPU: 26 PID: 748 at lib/iomap.c:45 pci_iounmap+0x3f/0x50
> ...
> <kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x2=
c/0x70 [nova_core]
> devres_release_all+0xa8/0xf0
> really_probe+0x30f/0x420
> __driver_probe_device+0x77/0xf0
> driver_probe_device+0x22/0x1b0
> __driver_attach+0x118/0x250
> bus_for_each_dev+0x105/0x130
> bus_add_driver+0x163/0x2a0
> driver_register+0x5d/0xf0
> init_module+0x6d/0x1000 [nova_core]
> do_one_initcall+0xde/0x380
> do_init_module+0x60/0x250
>
> ...and then:
> BUG: kernel NULL pointer dereference, address: 0000000000000538
> RIP: 0010:pci_release_region+0x10/0x60
> ...
> <kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x3=
6/0x70 [nova_core]
> devres_release_all+0xa8/0xf0
> really_probe+0x30f/0x420
> __driver_probe_device+0x77/0xf0
> driver_probe_device+0x22/0x1b0
> __driver_attach+0x118/0x250
> bus_for_each_dev+0x105/0x130
> bus_add_driver+0x163/0x2a0
> driver_register+0x5d/0xf0
> init_module+0x6d/0x1000 [nova_core]
> do_one_initcall+0xde/0x380
> do_init_module+0x60/0x250

This is caused by a bug in Devres, which I already fixed in [1].

With the patch in [1] nova-core should gracefully fail probing for the
non-supported device classes as expected.

However, I think we still want to filter by PCI class, so the patch is fine=
 in
general. :)

Few comments below.

[1] https://lore.kernel.org/lkml/20250812130928.11075-1-dakr@kernel.org/
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 13 +++++++++++++
>  rust/kernel/pci.rs              |  6 ++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 274989ea1fb4..4e0e6f5338e9 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -31,6 +31,19 @@ impl pci::Driver for NovaCore {
>      fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<P=
in<KBox<Self>>> {
>          dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
> =20
> +        let class_code =3D pdev.class();
> +
> +        if class_code !=3D bindings::PCI_CLASS_DISPLAY_VGA
> +            && class_code !=3D bindings::PCI_CLASS_DISPLAY_3D

I think it would be nice if we could provide a Rust enum for PCI classes, s=
uch
that this could be pci::Class::DISPLAY_VGA instead.

Of course the same is true for PCI (sub)vendor, (sub)device IDs.

> +        {
> +            dev_dbg!(
> +                pdev.as_ref(),
> +                "Skipping non-display NVIDIA device with class 0x{:04x}\=
n",
> +                class_code
> +            );
> +            return Err(kernel::error::code::ENODEV);

With the prelude included you should be able to use ENODEV directly.

> +        }
> +
>          pdev.enable_device_mem()?;
>          pdev.set_master();
> =20
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs

Please split the PCI part up into a separate patch.

> index 887ee611b553..b6416fe7bdfd 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -399,6 +399,12 @@ pub fn device_id(&self) -> u16 {
>          unsafe { (*self.as_raw()).device }
>      }
> =20
> +    /// Returns the PCI class code (class and subclass).
> +    pub fn class(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).class >> 8 }
> +    }
> +
>      /// Returns the size of the given PCI bar resource.
>      pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_si=
ze_t> {
>          if !Bar::index_is_valid(bar) {
>
> base-commit: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
> --=20
> 2.50.1


