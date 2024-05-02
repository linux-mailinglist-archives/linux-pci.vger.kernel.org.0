Return-Path: <linux-pci+bounces-7020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA78B9F85
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA771F23019
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE316FF3D;
	Thu,  2 May 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsEbyuAV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9A16FF3E;
	Thu,  2 May 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671030; cv=none; b=SuwEqY1iQ3jv6FMUv7wFoka3X1tGkzkrHDzOe1OoP1MRQAU3zOE8aODWrf5bAOPBelPC0jlK66Igga6m50s6v9DNk2DvkQrkAPAb3uhMCXRWdTUM2xTE+sENYOln4SCFtRw8S+SbFaBTk+i1BLwOo5iy9dZSBrc8ghGY4/RE2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671030; c=relaxed/simple;
	bh=y+jHwDvpRAz2vaEvZfsK5o22xGqUR1Wi7cLiOTAt3TQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkX3ZFHjhr+3kwjMLmt1vbWuiORlYUe72oHDn+Wh+BZDiOPzMQeLmEI4qOXKyHk19DYv6L2+rhKKHg5SZwavVBFjFIhG7fGgsPPggfKbUG0ho1CUQoH0ABaOAJPmNFzYRkWVicylQf8KxwXy4nqkDqeX7b24TbI3hHgl/1795Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsEbyuAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870B6C4AF14;
	Thu,  2 May 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714671029;
	bh=y+jHwDvpRAz2vaEvZfsK5o22xGqUR1Wi7cLiOTAt3TQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fsEbyuAVHq5v4vjlD4TvDi6GWsT6/CdfoFwikoDAR9MIXbcxLGksKJvBsoJHFW/b+
	 qE6cAijXc6dylBrNARy9MVyEOq5S9J8dM4yzaFOX9+CSMaECxJXVBfbEJrUIV6mu3e
	 /Wmarjd8+m6AHOmh+3NBJwJ00q92X6WST9n3h2C2RaLQ2LB9Y/L4IecMhcc8+/B4Fo
	 gK2nWBpVsNq3czKacFTmvtpEEx9rjNshAnw+962/HFfifgxWka2P9JIdU+whw3viSD
	 9D8KHcoXYDijHUyw7X2BXxIOPdKeFzK/uAxOk42rEijQMuDig4gLfsJpzbGc6LcS7e
	 V5qpE+i4OYpzg==
Message-ID: <a1f794140c0a3540a4fe9cdfe6a8d75d10eb5f5c.camel@kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 10:30:28 -0700
In-Reply-To: <20240501175450.GA866742@bhelgaas>
References: <20240501175450.GA866742@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 12:54 -0500, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 08:28:22AM -0700, PJ Waskiewicz wrote:
> > On Mon, 2024-04-29 at 11:35 -0700, Dan Williams wrote:
> > > Bjorn Helgaas wrote:
> > > > On Sun, Apr 28, 2024 at 10:57:13PM -0700, PJ Waskiewicz wrote:
> > > > > On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> > > > > > On Sun, Apr 07, 2024 at 02:05:26PM -0700,
> > > > > > ppwaskie@kernel.org=C2=A0wrote:
> > > > > > > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > > > > > >=20
> > > > > > > Currently, Type 3 CXL devices (CXL.mem) can train using
> > > > > > > host CXL drivers on Emerald Rapids systems.=C2=A0 However, on
> > > > > > > some production systems from some vendors, a buggy BIOS
> > > > > > > exists that improperly populates the ACPI =3D> PCI
> > > > > > > mappings.
> > > > > >=20
> > > > > > Can you be more specific about what this ACPI =3D> PCI
> > > > > > mapping
> > > > > > is?=C2=A0 If you already know what the problem is, I'm sure thi=
s
> > > > > > is obvious, but otherwise it's not.
> > > [..]=20
> > > > It's just a buggy BIOS that doesn't supply _UID for an ACPI0016
> > > > object, so you can't locate the corresponding CEDT entry,
> > > > right?
> > >=20
> > > Correct, the problem is 100% contained to ACPI, and PCI is
> > > innocent.=C2=A0 The ACPI bug leads to failures to associate ACPI
> > > host-bridge objects with CEDT.CHBS entries.
> >=20
> > Sorry for the confusion here!!=C2=A0 I was definitely not trying to
> > blame
> > PCI.=C2=A0 :)
> >=20
> > > ACPI to PCI association is then typical pci_root lookup, i.e.:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_root =3D acpi_pci_find=
_root(hb->handle);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge =3D pci_root->bus->=
bridge;
> >=20
> > Yes, this here.=C2=A0 In my use case, I'm starting with a PCIe/CXL
> > device.
> > In my driver, I try to discover the host bridge, and then the ACPI
> > _UID
> > so I can look things up in the CEDT.
> >=20
> > So I'm trying to do the programmatic equivalent of this:
> >=20
> > Start here in my PCIe/CXL host driver:
> >=20
> > /sys/devices/pci0000:37/firmware_node =3D>
> > ../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:02
> >=20
> > Retrieve _UID (uid) from /sys/devices/pci0000:37/firmware_node/uid
> >=20
> > Buggy BIOS, that above value resolves to CX02.=C2=A0 In fact, it
> > *should* be
> > 49.=C2=A0 This is very much a bug in the ACPI arena.
> >=20
> > The kernel APIs allowing me to walk this path would fail in the
> > acpi_evaluate_object() when trying to pass in the bad _UID (CX02).
> >=20
> > Again, sorry for the confusion if it looked like I was trying to
> > implicate PCI in any way.=C2=A0 The whole intent here was to leave some
> > breadcrumbs so anyone else running into this wouldn't be left
> > scratching their heads wondering wtf was going on.
>=20
>=20
> No worries, I didn't suspect a PCI issue here; I just wasn't clear on
> what ACPI=3D>PCI mapping was involved.=C2=A0 It sounds like there *is* no
> such mapping in this picture (you find the ACPI object for a PCIe/CXL
> host bridge, evaluate _UID from that object, and get a bogus value).
>=20
> So the commit log text:
>=20
> =C2=A0 However, on some production systems from some vendors, a buggy BIO=
S
> =C2=A0 exists that improperly populates the ACPI =3D> PCI mappings.
>=20
> apparently refers to improper implementation of the _UID, which
> doesn't return anything PCI related.

Agreed.  I'm happy to fix the commit message to be more accurate, if we
move forward with rolling this or Dan's (better) approach to handling
this.

>=20
> It also says:
>=20
> =C2=A0 This leads to the cxl_acpi driver to fail probe when it cannot fin=
d
> =C2=A0 the root port's _UID, in order to look up the device's CXL
> =C2=A0 attributes in the CEDT.
>=20
> I *think* strictly speaking this should refer to the *host bridge's*
> _UID, not the Root Port's, e.g., something like this:
>=20
> =C2=A0 However, on some production systems from some vendors, a buggy BIO=
S
> =C2=A0 provides a CXL host bridge _UID that doesn't match anything in the
> =C2=A0 CEDT.

Much better description.  I'll roll it in.

I appreciate the look-over and inputs!

-PJ

