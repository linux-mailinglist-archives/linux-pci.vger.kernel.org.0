Return-Path: <linux-pci+bounces-38031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 320ABBD8D23
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF6944E8501
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789E2FB98A;
	Tue, 14 Oct 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftXQjyzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BC2EC0AB;
	Tue, 14 Oct 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439271; cv=none; b=kb+OShYEQX5aT/W6QgPOVRs5faByJhZx0DaGBX/0EhyDFKmFUER9FBiVcgvVMXpuHmcQRWRwW7gc7Ckj9S0GaYAy6BtXwSCxBpcEtkNsglL6h4nT6juW81HI3PbGDrcSt4Y0AvejF+w1tnflyd+E0MpcQhhxAFLDp+nQguBZ1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439271; c=relaxed/simple;
	bh=wwM5MLWzqHFEUsTKO1erEDUHOxRMjh9fiKGXTE8KNN0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zg05TRbbQoly81LAiB5oeALV9vznp5iBJePfnjjdgpF9OqkeEFv8MmBVQZHxKzhEHBJICybBJSILJbHoxceD4YvHhnXSsBklfVE2aSjFxGJFexQCdX00sCP6rYrAjcKZKnQssiYh1voU0d6rijGgYBmOrAfS6kYD5cZSR1KXGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftXQjyzx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760439270; x=1791975270;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wwM5MLWzqHFEUsTKO1erEDUHOxRMjh9fiKGXTE8KNN0=;
  b=ftXQjyzxP2xhPHlMN2m1VFj+I1qbwZWbNble4ycGSXHG+f2gIzrjemPp
   jy+2RO7b/HkUTLWE8+ZbtrXJIZFU12SmxqzPyTbSHd612Hl1pmuoXA35+
   9nw3NT5GJr7KQOPkeIdjXqAMFJ6vF736Opy8pyQHjkGlXSIOL9Csi/oN1
   t1xCR6SxzZXy6RW3RWjdPCaXZUM8RCZ7ca1wyrzljeXzIUt7O3AxeCy2Y
   6hg/RGthG4o2PC+3GeIkXGWaU0rSaDNqkBd3wo9ZwBHXl2hyM4OsN9Gwh
   GO2bu9XMFkwmXjamtNGBo/Jn7JGrKRaN8qBa2J7PTfWufNuoDfWHdPx7t
   A==;
X-CSE-ConnectionGUID: VFnbyYHaT1mBr5SJ8MJ3pg==
X-CSE-MsgGUID: FqvnaJSuSAWMPmE0iZhrDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61804768"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="61804768"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 03:54:29 -0700
X-CSE-ConnectionGUID: WU8qr8eNQMCKTQnY6aTvbg==
X-CSE-MsgGUID: fwjUt3AuT+q9kp1505LpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="181806607"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 03:54:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 13:54:22 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Guenter Roeck <linux@roeck-us.net>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
Message-ID: <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de>
 <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-94048299-1760439262=:925"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-94048299-1760439262=:925
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Oct 2025, Maciej W. Rozycki wrote:

> On Mon, 13 Oct 2025, Thomas Bogendoerfer wrote:
>=20
> > > This patch causes boot failures when trying to boot mips images from
> > > ide drive in qemu. As far as I can see the interface no longer instan=
tiates.
> > >=20
> > > Reverting this patch fixes the problem. Bisect log attached for refer=
ence.
> >=20
> > Patch below fixes my qemu malta setup. Now I'm wondering, why this is
> > needed. It was added with commit
> >=20
> > aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.=
")
> >=20
> > Maciej, do you remember why this is needed ?
>=20
>  I do.  The reason is preventing PCI port I/O mappings below 0x100, which=
=20
> interferes badly with how the PIIX4 decodes port I/O cycles.  That did=20
> happen in the field, wreaking havoc and prompting my change.
>=20
>  By the look of the code it would definitely trigger for the Bonito64=20
> system controller, which has a fixed port I/O target address range and,=
=20
> depending on the settings left by the firmware, it might also trigger for=
=20
> the Galileo GT64120A and SOC-it 101 system controllers, which have=20
> variable port I/O target address ranges.
>=20
>  Here's an example map of Malta port I/O resources (SOC-it 101 variant):
>=20
> 00000000-0000001f : dma1
> 00000020-00000021 : pic1
> 00000040-0000005f : timer
> 00000060-0000006f : keyboard
> 00000070-00000077 : rtc0
> 00000080-0000008f : dma page reg
> 000000a0-000000a1 : pic2
> 000000c0-000000df : dma2
> 00000170-00000177 : ata_piix
> 000001f0-000001f7 : ata_piix
> 000002f8-000002ff : serial
> 00000376-00000376 : ata_piix
> 00000378-0000037a : parport0
> 0000037b-0000037f : parport0
> 000003f6-000003f6 : ata_piix
> 000003f8-000003ff : serial
> 00001000-00ffffff : MSC PCI I/O
>   00001000-0000103f : 0000:00:0a.3
>   00001040-0000105f : 0000:00:0a.2
>     00001040-0000105f : uhci_hcd
>   00001060-0000107f : 0000:00:0b.0
>     00001060-0000107f : pcnet32_probe_pci
>   00001080-000010ff : 0000:00:12.0
>     00001080-000010ff : defxx
>   00001100-0000110f : 0000:00:0a.3
>   00001400-000014ff : 0000:00:13.0
>   00001800-0000180f : 0000:00:0a.1
>     00001800-0000180f : ata_piix
>=20
> As you can see there are holes in the map below 0x100, so e.g. if the bus=
=20
> master IDE I/O space registers (claimed last in the list by `ata_piix')=
=20
> were assigned to 00000030-0000003f, then all hell would break loose.  It=
=20
> is exactly the mapping that happened in the absence of the code piece in=
=20
> question IIRC.
>=20
>  The choice of 0x1000 as the lower boundary IIRC has something to do with=
=20
> alignment; I think the decoding base has to be a multiple of 0x1000 and=
=20
> given that the ACPI resource is decoded by a non-standard BAR at 0x40 in=
=20
> the configuration space (set up by `malta_piix_func3_base_fixup' BTW) we=
=20
> just need to match its setting.
>=20
>  Can you please check what the port I/O map looks like with your setup=20
> with and without your patch applied?
>=20
>  NB there is still something fishy with the setup of SOC-it 101's PCI=20
> decoding windows, which is why I have forced `defxx' with a patch to use=
=20
> port I/O, as reported above.  The driver uses MMIO unconditionally on PCI=
=20
> systems nowadays, but using MMIO prevents it from working with the SOC-it=
=20
> 101 system controller and I yet need to debug it.  Conversely MMIO used t=
o=20
> work just fine with the Galileo GT64120A system controller while I still=
=20
> had one operational.

Are you sure pci-malta.c has to do anything like this as=20
pcibios_align_resource() does lower bound IO resource start addresses if=20
PCIBIOS_MIN_IO is set?

How about this patch below?

(I'm not sure if it should actually be
=09PCIBIOS_MIN_IO =3D 0x1000 - hose->io_resource->start;
to allow resources starting from 0x1000 if ->start is not at 0.)

--
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Tue, 14 Oct 2025 13:47:49 +0300
Subject: [PATCH 1/1] MIPS: Malta: Use pcibios_align_resource() to block io =
range
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

According to Maciej W. Rozycki <macro@orcam.me.uk>, the
mips_pcibios_init() for malta adjusts root bus IO resource start
address to prevent interfering with PIIX4 I/O cycle decoding. Adjusting
lower bound leaves PIIX4 IO resources outside of the root bus resource
and assign_fixed_resource_on_bus() does not put the resources into the
resource tree.

Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
the arch specific pcibios_enable_resources() did not check if the
resources were assigned which diverges from what PCI core checks,
effectively hiding the PIIX4 IO resources were not properly within the
resource tree. After starting to use pcibios_enable_resources() from
PCI core, enabling PIIX4 fails:

ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable=
 device
ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22

MIPS PCI code already has support for enforcing lower bounds using
PCIBIOS_MIN_IO in pcibios_align_resource(). Make malta PCI code too to
use PCIBIOS_MIN_IO.

Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
Fixes: aa0980b80908 ("Fixes for system controllers for Atlas/Malta core car=
ds.")
Link: https://lore.kernel.org/linux-pci/9085ab12-1559-4462-9b18-f03dcb9a408=
8@roeck-us.net/
Link: https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2510132229120.39634=
@angie.orcam.me.uk/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/pci-malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index 6aefdf20ca05..f4ea1c99852f 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -231,7 +231,7 @@ void __init mips_pcibios_init(void)
=20
 =09/* PIIX4 ACPI starts at 0x1000 */
 =09if (controller->io_resource->start < 0x00001000UL)
-=09=09controller->io_resource->start =3D 0x00001000UL;
+=09=09PCIBIOS_MIN_IO =3D 0x1000;
=20
 =09iomem_resource.end &=3D 0xfffffffffULL;=09=09=09/* 64 GB */
 =09ioport_resource.end =3D controller->io_resource->end;

base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
--=20
2.39.5


--8323328-94048299-1760439262=:925--

