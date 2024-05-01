Return-Path: <linux-pci+bounces-6957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDE8B8CF4
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5930C1C20846
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8854FA1;
	Wed,  1 May 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONZNOUWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E076C2FD;
	Wed,  1 May 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577304; cv=none; b=eP0iPX0sCEflloA2SZqWejnPyWpW4UQDwDi5Dh1yNe3G0N0xx/BfJ1Xx174TCrGuJGCxzefjUwMGEVSloKoG9iwHqZ8okg04YQQyETBEGcwTLlKLrWhmfJduv32pRcz0FQEUEeX7CYUEI7dhgUP18GyCZynN7t42E3sqD3mpKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577304; c=relaxed/simple;
	bh=jv+X8Y1RHXOI4u8Pe4gD5ozH+iXIvKkQEoDBIMs4+Tc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOfb62B9WXpa9WtZzsCuizBI/2tSRu6yxFxBP0HAhza9r+L4XZYuSMlLFUhun4oP32p9U4+Ih2ag7jApEpoZ/vgbTF1mwaEIef71iEif15BBcldeJqQhJUGwDbspspsYzTD9YOiGZodZGPf8EU/yM77xcaFyyOABgl1lYWwkryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONZNOUWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A09C072AA;
	Wed,  1 May 2024 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577304;
	bh=jv+X8Y1RHXOI4u8Pe4gD5ozH+iXIvKkQEoDBIMs4+Tc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ONZNOUWbITC13CvnD0SHYICamRkoq/0mqmgJc7uJ54AJiOAIxiMD50gTVSL8kJ1WQ
	 bB97CwahAdB14XYqsHcu36mI99FdQiGxqEjb62w3jGver85vXDAtRpuFTc8a39W8eF
	 uOC0pNGig85qWzCRujlfZEcpxEDBDTLt/HHv4elxb0eitUobotcoUSjWp6a2TKfco8
	 KRrDvXHYbU4bsh58A/kRvRKo1Xh0KiVBAjNsFmGbAYZpFqqYu9NWpeeEfdj7ALK+O1
	 xHk6kIkdYmSicgmM1rEA5Qt/O3G7fKN/eGwP6KFwSCoO6CJwBziCNm6yIkHnQkZTXC
	 pnvecS/d1KTVw==
Message-ID: <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 08:28:22 -0700
In-Reply-To: <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
	 <20240429153138.GA681245@bhelgaas>
	 <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 11:35 -0700, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Sun, Apr 28, 2024 at 10:57:13PM -0700, PJ Waskiewicz wrote:
> > > On Tue, 2024-04-09 at 08:22 -0500, Bjorn Helgaas wrote:
> > > > On Sun, Apr 07, 2024 at 02:05:26PM -0700,
> > > > ppwaskie@kernel.org=C2=A0wrote:
> > > > > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > > > >=20
> > > > > Currently, Type 3 CXL devices (CXL.mem) can train using host
> > > > > CXL
> > > > > drivers on Emerald Rapids systems.=C2=A0 However, on some
> > > > > production
> > > > > systems from some vendors, a buggy BIOS exists that
> > > > > improperly
> > > > > populates the ACPI =3D> PCI mappings.
> > > >=20
> > > > Can you be more specific about what this ACPI =3D> PCI mapping
> > > > is?
> > > > If you already know what the problem is, I'm sure this is
> > > > obvious,
> > > > but otherwise it's not.
> [..]=20
> > It's just a buggy BIOS that doesn't supply _UID for an ACPI0016
> > object, so you can't locate the corresponding CEDT entry, right?
>=20
> Correct, the problem is 100% contained to ACPI, and PCI is innocent.
> The
> ACPI bug leads to failures to associate ACPI host-bridge objects with
> CEDT.CHBS entries.

Sorry for the confusion here!!  I was definitely not trying to blame
PCI.  :)

>=20
> ACPI to PCI association is then typical pci_root lookup, i.e.:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_root =3D acpi_pci_find_roo=
t(hb->handle);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge =3D pci_root->bus->brid=
ge;

Yes, this here.  In my use case, I'm starting with a PCIe/CXL device.
In my driver, I try to discover the host bridge, and then the ACPI _UID
so I can look things up in the CEDT.

So I'm trying to do the programmatic equivalent of this:

Start here in my PCIe/CXL host driver:

/sys/devices/pci0000:37/firmware_node =3D>
../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:02

Retrieve _UID (uid) from /sys/devices/pci0000:37/firmware_node/uid

Buggy BIOS, that above value resolves to CX02.  In fact, it *should* be
49.  This is very much a bug in the ACPI arena.

The kernel APIs allowing me to walk this path would fail in the
acpi_evaluate_object() when trying to pass in the bad _UID (CX02).

Again, sorry for the confusion if it looked like I was trying to
implicate PCI in any way.  The whole intent here was to leave some
breadcrumbs so anyone else running into this wouldn't be left
scratching their heads wondering wtf was going on.

Cheers,
-PJ

