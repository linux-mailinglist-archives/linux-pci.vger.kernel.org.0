Return-Path: <linux-pci+bounces-37927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA0BD50A1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB09B567ACC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411F311598;
	Mon, 13 Oct 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkvy2/y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16931311594;
	Mon, 13 Oct 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369988; cv=none; b=giTGbkyx6D+7i7uyrI9oxgBopMbRXXPTluEjHrWjKH/KRCKcOmIm1a7bgNEysjzQ2ODN2+9Nl0mD7F21LmsdyZHExGymZ6xfF+ubTiBf5dZw+BHoS27e5lw6sWbdWaKSbRb5SyQI3pduV1q5+MBl09/AaSAM3iDiUczLzBMTL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369988; c=relaxed/simple;
	bh=XRgqPt8ELkRS40SVE58RMNMVvTbxBt/VeZAjuuaA3M4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=FmJqzba4BYYzUx7otuYfCeZ12ZFMajwefIFfP8VictpjxqovJmkxNKKchwAkpJAB7ymkeXHV8NY81ktyH+jNXUxHV78FxdCM0xLWhLAQ6G+oM5uRg1lz5OY56LB8xhAlOu3+OQKr2XpDT3UfcwCGhafAzqkzCNjI0nhj7Bw66+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkvy2/y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA0CC4CEFE;
	Mon, 13 Oct 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369987;
	bh=XRgqPt8ELkRS40SVE58RMNMVvTbxBt/VeZAjuuaA3M4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=mkvy2/y7vTOu187LZixltm3qHwr20EFGugwcNe8cFE/WaTTzns28FHi1uDurmW3uI
	 tANDFvmfF/wPxnM+OiyWJtEdhG9Bc99EcD9nPqachN3H22ONjtZFCXdf4xrTnQTX7C
	 O61Ph3BOUT2H4/bv9FZEIq9ySW0bMhY8OGu8EbfI+VgS07tOZdiX5YvmD45RCKHFCD
	 XR/CQE0n3Hsfu3sxcvkhu+pnzkZHr19kZ3vRZYkmzGxT9R8tF1jhgoQPvX913XQ5Bh
	 i7rgGSlfyPl3l+TVUIT+rIFPCIfaTtChT7tuTspP0j1aMlWwvHoZpI3cKQ/bPADwFi
	 tRkSz4rqInUEg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Oct 2025 17:39:41 +0200
Message-Id: <DDHB2T3G9BUA.18YWV70J82Z01@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC 0/6] rust: pci: add config space read/write support
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20251010080330.183559-1-zhiw@nvidia.com>
In-Reply-To: <20251010080330.183559-1-zhiw@nvidia.com>

Hi Zhi,

(Cc: Alex, Joel, John, Markus)

On Fri Oct 10, 2025 at 10:03 AM CEST, Zhi Wang wrote:
> This ideas of this series are:
>
> - Factor out a common trait IoRegion for other accessors to share the
>   same compiling/runtime check like before.

Yes, this is something we want to have in general:

Currently, we have a single I/O backend (struct Io) which is used for gener=
ic
MMIO. However, we should make Io a trait instead and require a new MMIO typ=
e to
implement the trait, where the trait methods would remain to be
{try_}{read,write}{8,16,..}().

We need the same thing for other I/O backends, such as I2C, etc.

@Markus: Most of the design aspects for the PCI configuration space below s=
hould
apply to I2C I/O accessors as well.

>   In detail:
>
>   * `struct ConfigSpace<SIZE>` wrapping a `pdev: ARef<Device>`.

There are two cases:

  (1) I/O backends that embedd a dedicated device resource. For instance, a
      pci::Bar embedds an iomapped pointer that must be wrapped with Devres=
 to
      ensure it can't outlive the driver being bound to its corresponding
      device.

      In this case we have a method pci::Device<Bound>::iomap_region(), whi=
ch
      returns a Devres<pci::Bar>.

  (2) I/O backends that don't need to embedd a dedicated device resource be=
cause
      the resource is already attached to the device itself. This is the ca=
se
      with the PCI configuration space; drivers don't need to create their =
own
      mapping, but can access it directly through the device.

      For this case we want a method pci::Device<Bound>::config_space() tha=
t
      returns a ConfigSpace<'a>, where 'a is the lifetime of the
      &'a Device<Bound> given to config_space().

      This ensures that the ConfigSpace structure still serves as I/O backe=
nd
      for the types generated by the register!() macro, but at the same tim=
e
      can't outlife the scope of the bound device.

      (Drivers shouldn't be able to write the PCI configuration space of a
      device they're not bound to.)

Besides that, we should also use the register!() macro to create the common
configuration space register types in the PCI core for driver to use.

Of course, there is no need to (re-)implement the following one, but it's a
good example:

	register!(PCI_CONFIG_ID @ 0x0 {
	    31:16   device_id ?=3D> pci::DeviceId, "Device ID";
	    15:0    vendor_id ?=3D> pci::VendorId, "Vendor ID";
	});

	// Assume we have a `&pci::Device<Bound>`, e.g. from probe().
	let pdev: &pci::Device<Bound> =3D ...;

	// Grab the configuration space I/O backend; lives as long as `pdev`.
	let config_space =3D pdev.config_space();

	// Read the first standard register of the configuration space header.
	let id =3D PCI_CONFIG_ID::read(config_space);

	// `id.vendor()` returns a `pci::Vendor`. Since it implements `Display`
	// the `dev_info()` call prints the actual vendor string.
	dev_info!(pdev.as_ref(), "VendorId=3D{}\n", id.vendor());

> Open:
>
> The current kernel::Io MMIO read/write doesn't return a failure, because
> {read, write}{b, w, l}() are always successful. This is not true in
> pci_{read, write}_config{byte, word, dword}() because a PCI device
> can be disconnected from the bus. Thus a failure is returned.

This is in fact also true for the PCI configuration space. The PCI configur=
ation
space has a minimum size that is known at compile time. All registers withi=
n
this minimum size can be access in an infallible way with the non try_*()
methods.

The main idea behind the fallible and infallible accessors is that you can
assert a minimum expected size of an I/O backend (e.g. a PCI bar). I.e. dri=
vers
know their minimum requirements of the size of the I/O region. If the I/O
backend can fulfill the request we can be sure about the minimum size and h=
ence
accesses with offsets that are known at compile time can be infallible (bec=
ause
we know the minimum accepted size of the I/O backend at compile time as wel=
l).

Accesses with offsets that are not known at compile time still remain falli=
ble
of course. That's why we have both, e.g. write32() and try_write32().

