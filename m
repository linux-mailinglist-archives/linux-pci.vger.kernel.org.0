Return-Path: <linux-pci+bounces-20283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57295A1A404
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A606163D10
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8420C477;
	Thu, 23 Jan 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTOl/VN1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C3288CC;
	Thu, 23 Jan 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634555; cv=none; b=QQyBH8x1rTeBC1XjXojsrkorN4b0yvy2Ns1Uda4SW3neYPa+k3fzQtWD+oYjQY4nEzvRuutRbweMwV1UVQwLhhlXi1Ssn/w0koKh6Y8FbOES3AlViuts/MROxvoQfjetgs8dTI3uVMORLk7dr0js6kMA9WYojdqECUFfx+JMOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634555; c=relaxed/simple;
	bh=6qvTMpHaB03y5SPSqGcqw1nObLgYje4GKTATZ8gY+kg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UxLiMoGlfNipU2oRW05cD25O6nRyU5+fjtE2jhKNzSGES+cuu5ROoYNYAgajgxh8BH4o6/4n4qhmximgt+fKcIAuDVDn+jjFzCyJUgWIWB2/sBqgbxg1ywhgodY8+ikwEED+TwK8h00h6ugq25MYHocZXXnJd+48tg6VlTvYlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTOl/VN1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737634554; x=1769170554;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6qvTMpHaB03y5SPSqGcqw1nObLgYje4GKTATZ8gY+kg=;
  b=FTOl/VN1TDmiNAo5EywWXywOUimMv305Xq8iEBuqVycczwgKbkXRvCoX
   9FaKVN/c538wYqbQ4SBVhnYEUro2cNnIyfRhnQ9BV4HabYKmRwH0g8v3q
   u8UqLmQEBBput+ikj5FHSSJMoWsFRaagXJoTXB6TToUT0ReW5bmdce+A/
   wGLU8/BKlW5A6aR18vy+TNQ0SeTUUwvxw6qNibpA/li0T7AkTLI9vXzxN
   kL6zHNbgzYYHgs+qiglD4X5GMx/RNYyZzKGFpdmedEyZVNsUUx8ctyBOh
   evliw7aRpiwUaI/bsBzndAGlWv8gfIXDFHd/2Uhy3+IrcX6Uu41utH1g+
   w==;
X-CSE-ConnectionGUID: PXPne1YtSzmyA/euKB1KHQ==
X-CSE-MsgGUID: 4ynglUvvTq6qIVyRZ8kuKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38045280"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38045280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 04:15:53 -0800
X-CSE-ConnectionGUID: d13nqyvIQ0KIZn8olZdBkw==
X-CSE-MsgGUID: nWf6q6CgSh+UEVR+WSGhNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112563243"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 04:15:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 23 Jan 2025 14:15:47 +0200 (EET)
To: Alex Williamson <alex.williamson@redhat.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, mitchell.augustin@canonical.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
In-Reply-To: <20250120182202.1878581-1-alex.williamson@redhat.com>
Message-ID: <138929ec-966d-d7d2-55be-7aa00289ac74@linux.intel.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1372012423-1737634547=:1068"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1372012423-1737634547=:1068
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Jan 2025, Alex Williamson wrote:

> Toggling memory enable is free on bare metal, but potentially expensive
> in virtualized environments as the device MMIO spaces are added and
> removed from the VM address space, including DMA mapping of those spaces
> through the IOMMU where peer-to-peer is supported.  Currently memory
> decode is disabled around sizing each individual BAR, even for SR-IOV
> BARs while VF Enable is cleared.
>=20
> This can be better optimized for virtual environments by sizing a set
> of BARs at once, stashing the resulting mask into an array, while only
> toggling memory enable once.  This also naturally improves the SR-IOV
> path as the caller becomes responsible for any necessary decode disables
> while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> VF Enable rather than toggling the PF memory enable in the command
> register.
>=20
> Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZg=
QZub4mDRrV5w@mail.gmail.com
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>=20
> v2:
>  - Move PCI_POSSIBLE_ERROR() test back to original location such that it
>    only tests the lower half of 64-bit BARs as noted by Ilpo J=C3=A4rvine=
n.
>  - Reduce delta from original code by retaining the local @sz variable
>    filled from the @sizes array and keep location of parsing upper half
>    of 64-bit BARs.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

>  drivers/pci/iov.c   |  8 +++-
>  drivers/pci/pci.h   |  4 +-
>  drivers/pci/probe.c | 93 +++++++++++++++++++++++++++++++++------------
>  3 files changed, 78 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4be402fe9ab9..9e4770cdd4d5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  =09struct resource *res;
>  =09const char *res_name;
>  =09struct pci_dev *pdev;
> +=09u32 sriovbars[PCI_SRIOV_NUM_BARS];
> =20
>  =09pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>  =09if (ctrl & PCI_SRIOV_CTRL_VFE) {
> @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  =09if (!iov)
>  =09=09return -ENOMEM;
> =20
> +=09/* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> +=09__pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> +=09=09=09   pos + PCI_SRIOV_BAR, sriovbars);
> +
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  =09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  =09=09=09bar64 =3D (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>  =09=09else
>  =09=09=09bar64 =3D __pci_read_base(dev, pci_bar_unknown, res,
> -=09=09=09=09=09=09pos + PCI_SRIOV_BAR + i * 4);
> +=09=09=09=09=09=09pos + PCI_SRIOV_BAR + i * 4,
> +=09=09=09=09=09=09&sriovbars[i]);
>  =09=09if (!res->flags)
>  =09=09=09continue;
>  =09=09if (resource_size(res) & (PAGE_SIZE - 1)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..6f27651c2a70 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_b=
us *bus, int devfn, u32 *pl,
>  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_t=
imeout);
> =20
>  int pci_setup_device(struct pci_dev *dev);
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +=09=09=09unsigned int pos, u32 *sizes);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -=09=09    struct resource *res, unsigned int reg);
> +=09=09    struct resource *res, unsigned int reg, u32 *sizes);
>  void pci_configure_ari(struct pci_dev *dev);
>  void __pci_bus_size_bridges(struct pci_bus *bus,
>  =09=09=09struct list_head *realloc_head);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..bf6aec555044 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -164,41 +164,67 @@ static inline unsigned long decode_bar(struct pci_d=
ev *dev, u32 bar)
> =20
>  #define PCI_COMMAND_DECODE_ENABLE=09(PCI_COMMAND_MEMORY | PCI_COMMAND_IO=
)
> =20
> +/**
> + * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
> + * @dev: the PCI device
> + * @count: number of BARs to size
> + * @pos: starting config space position
> + * @sizes: array to store mask values
> + * @rom: indicate whether to use ROM mask, which avoids enabling ROM BAR=
s
> + *
> + * Provided @sizes array must be sufficiently sized to store results for
> + * @count u32 BARs.  Caller is responsible for disabling decode to speci=
fied
> + * BAR range around calling this function.  This function is intended to=
 avoid
> + * disabling decode around sizing each BAR individually, which can resul=
t in
> + * non-trivial overhead in virtualized environments with very large PCI =
BARs.
> + */
> +static void __pci_size_bars(struct pci_dev *dev, int count,
> +=09=09=09    unsigned int pos, u32 *sizes, bool rom)
> +{
> +=09u32 orig, mask =3D rom ? PCI_ROM_ADDRESS_MASK : ~0;
> +=09int i;
> +
> +=09for (i =3D 0; i < count; i++, pos +=3D 4, sizes++) {
> +=09=09pci_read_config_dword(dev, pos, &orig);
> +=09=09pci_write_config_dword(dev, pos, mask);
> +=09=09pci_read_config_dword(dev, pos, sizes);
> +=09=09pci_write_config_dword(dev, pos, orig);
> +=09}
> +}
> +
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +=09=09=09unsigned int pos, u32 *sizes)
> +{
> +=09__pci_size_bars(dev, count, pos, sizes, false);
> +}
> +
> +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *s=
izes)
> +{
> +=09__pci_size_bars(dev, 1, pos, sizes, true);
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
>   * @type: type of the BAR
>   * @res: resource buffer to be filled in
>   * @pos: BAR position in the config space
> + * @sizes: array of one or more pre-read BAR masks
>   *
>   * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
>   */
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -=09=09    struct resource *res, unsigned int pos)
> +=09=09    struct resource *res, unsigned int pos, u32 *sizes)
>  {
> -=09u32 l =3D 0, sz =3D 0, mask;
> +=09u32 l =3D 0, sz;
>  =09u64 l64, sz64, mask64;
> -=09u16 orig_cmd;
>  =09struct pci_bus_region region, inverted_region;
>  =09const char *res_name =3D pci_resource_name(dev, res - dev->resource);
> =20
> -=09mask =3D type ? PCI_ROM_ADDRESS_MASK : ~0;
> -
> -=09/* No printks while decoding is disabled! */
> -=09if (!dev->mmio_always_on) {
> -=09=09pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> -=09=09if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> -=09=09=09pci_write_config_word(dev, PCI_COMMAND,
> -=09=09=09=09orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> -=09=09}
> -=09}
> -
>  =09res->name =3D pci_name(dev);
> =20
>  =09pci_read_config_dword(dev, pos, &l);
> -=09pci_write_config_dword(dev, pos, l | mask);
> -=09pci_read_config_dword(dev, pos, &sz);
> -=09pci_write_config_dword(dev, pos, l);
> +=09sz =3D sizes[0];
> =20
>  =09/*
>  =09 * All bits set in sz means the device isn't working properly.
> @@ -238,18 +264,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_b=
ar_type type,
> =20
>  =09if (res->flags & IORESOURCE_MEM_64) {
>  =09=09pci_read_config_dword(dev, pos + 4, &l);
> -=09=09pci_write_config_dword(dev, pos + 4, ~0);
> -=09=09pci_read_config_dword(dev, pos + 4, &sz);
> -=09=09pci_write_config_dword(dev, pos + 4, l);
> +=09=09sz =3D sizes[1];
> =20
>  =09=09l64 |=3D ((u64)l << 32);
>  =09=09sz64 |=3D ((u64)sz << 32);
>  =09=09mask64 |=3D ((u64)~0 << 32);
>  =09}
> =20
> -=09if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> -=09=09pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> -
>  =09if (!sz64)
>  =09=09goto fail;
> =20
> @@ -320,7 +341,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_ba=
r_type type,
> =20
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, in=
t rom)
>  {
> +=09u32 rombar, stdbars[PCI_STD_NUM_BARS];
>  =09unsigned int pos, reg;
> +=09u16 orig_cmd;
> +
> +=09BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> =20
>  =09if (dev->non_compliant_bars)
>  =09=09return;
> @@ -329,10 +354,28 @@ static void pci_read_bases(struct pci_dev *dev, uns=
igned int howmany, int rom)
>  =09if (dev->is_virtfn)
>  =09=09return;
> =20
> +=09/* No printks while decoding is disabled! */
> +=09if (!dev->mmio_always_on) {
> +=09=09pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> +=09=09if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> +=09=09=09pci_write_config_word(dev, PCI_COMMAND,
> +=09=09=09=09orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> +=09=09}
> +=09}
> +
> +=09__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
> +=09if (rom)
> +=09=09__pci_size_rom(dev, rom, &rombar);
> +
> +=09if (!dev->mmio_always_on &&
> +=09    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> +=09=09pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> +
>  =09for (pos =3D 0; pos < howmany; pos++) {
>  =09=09struct resource *res =3D &dev->resource[pos];
>  =09=09reg =3D PCI_BASE_ADDRESS_0 + (pos << 2);
> -=09=09pos +=3D __pci_read_base(dev, pci_bar_unknown, res, reg);
> +=09=09pos +=3D __pci_read_base(dev, pci_bar_unknown,
> +=09=09=09=09       res, reg, &stdbars[pos]);
>  =09}
> =20
>  =09if (rom) {
> @@ -340,7 +383,7 @@ static void pci_read_bases(struct pci_dev *dev, unsig=
ned int howmany, int rom)
>  =09=09dev->rom_base_reg =3D rom;
>  =09=09res->flags =3D IORESOURCE_MEM | IORESOURCE_PREFETCH |
>  =09=09=09=09IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
> -=09=09__pci_read_base(dev, pci_bar_mem32, res, rom);
> +=09=09__pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
>  =09}
>  }
> =20
>=20
--8323328-1372012423-1737634547=:1068--

