Return-Path: <linux-pci+bounces-6863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F38B6F87
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B56280E23
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7066FC02;
	Tue, 30 Apr 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewnGzr6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976661272AB
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472493; cv=none; b=RL5e4BKYoSeEnYfy7DhA80Yy2hqKvCiktZs2gZjz8E2GH2cF03SBaIT2WkJjl9ZA/uDneTCGlOHcSeLz4oeQgGRWYTd577LHBoRD9vTH8PlcxPnUvsjuYMPFNrV1PYqt52HVhbTIrIeQC/Umf1IvrsAaDsiaL/5x959kOUksqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472493; c=relaxed/simple;
	bh=FH3O4+sb+SKhWDcEMPQ6voUUf8tR2BRfZHTQuzb0l2I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=csF94XRtYYbEAVw5y2sFZMctBTWE/McgPxZxkeUH/N1I6kUnAyCNb1xiAlI4ge5ypYVITv1O5HTHKP1NjAzFjUBfA+n7jcWWxkSruOdq4mjXaRl/dTT7KPSTTt/A5h/SSnzXM88buJ+TFVtsmmy2wcKGf+loSVWQbINq8LcFnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewnGzr6Y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714472492; x=1746008492;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=FH3O4+sb+SKhWDcEMPQ6voUUf8tR2BRfZHTQuzb0l2I=;
  b=ewnGzr6YYSf0OFxUZbRTTiDR+50rCMK6FWKs+GO0q5Kp+9eFt1WrDqhz
   RzBrPNdGpsLz0zXkpaZ0wiDcm7qRvfCN/nkyUyl9/2WvHdeg3QiNZq6/v
   3MOfm+aaiv6sZ1W8HQdteLXNbXfynI4veoF/wGJwniQrnbKdRUx8DPwm3
   OkEtFF5gDJE7NcfjMaYfbtrtbiJWBGrRcjynVc5gERj9ax7FqqVe9vkd/
   K8w/UlPLJ0moe3fnwayJTlNAA3z/6wre/sX6O608hal5OEDKjoc1MwAWY
   IrAgfDYs7zcuCO5aONs9Amuw1NSlPlBzEcOb/MIIRB64qveZd7XUI6H2n
   w==;
X-CSE-ConnectionGUID: rI7tC/V/RoypEbdGhF4i7g==
X-CSE-MsgGUID: YEN043HpSC6oJfgrWooXeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="27621124"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="27621124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 03:21:32 -0700
X-CSE-ConnectionGUID: BL9M7uY1TQOfhpPr/gY2zw==
X-CSE-MsgGUID: ff4V/IYyTLS8sVV8AXnj7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26427759"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.49])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 03:21:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Apr 2024 13:21:23 +0300 (EEST)
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: Add helpers to calculate PCI Conf Type 0/1
 addresses
In-Reply-To: <20240429192427.uqat6ix4opwwvqg6@pali>
Message-ID: <e56ae9b2-7089-397d-c672-de6c80953677@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-3-ilpo.jarvinen@linux.intel.com> <20240429192427.uqat6ix4opwwvqg6@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1670190891-1714465559=:1349"
Content-ID: <a49dcd1e-c67b-41b9-ab34-12882a03126c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1670190891-1714465559=:1349
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0c305e6b-9147-fc24-5407-c26344cb8ce8@linux.intel.com>

On Mon, 29 Apr 2024, Pali Roh=E1r wrote:

> On Monday 29 April 2024 13:46:25 Ilpo J=E4rvinen wrote:
> > Many places in arch and PCI controller code need to calculate PCI
> > Configuration Space Addresses for Type 0/1 accesses. There are small
> > variations between archs when it comes to bits outside of [10:2] (Type
> > 0) and [24:2] (Type 1) but the basic calculation can still be
> > generalized.
> >=20
> > drivers/pci/pci.h has PCI_CONF1{,_EXT}_ADDRESS() but due to their
> > location the use is limited to PCI subsys and the also always enable
> > PCI_CONF1_ENABLE which is not what all the callers want.
> >=20
> > Add generic pci_conf{0,1}_addr() and pci_conf1_ext_addr() helpers into
> > include/linux/pci.h which can be reused by various parts of the kernel
> > that have to calculate PCI Conf Type 0/1 addresses.
> >=20
> > The PCI_CONF* defines are needed by the new helpers so move also them
> > to include/linux/pci.h. The new helpers use true bitmasks and
> > FIELD_PREP() instead of open coded masking and shifting so adjust
> > PCI_CONF* definitions to match that.
>
> I introduced these PCI_CONF* macros years ago. At that time I studied
> more sources and drivers what they use. To make it clear I will first
> try to explain few things. Hopefully I do not write mistakes here, it is
> longer time.
>=20
> Configuration mechanism is a SW API which allows access config space.
> Configuration access command is on-wire "format" which allows HW bus to
> access config space.
>=20
> There are two standardized configuration mechanisms #1 and #2. #2 was
> removed in PCI 3.0 spec and is out of scope (there are no macros for
> them). #1 uses pair of I/O registers (on x86 they are CF8 and CFC; on
> ARM they are whatever vendor invented). There is an extension of #1
> which uses few reserved bits to describe config space registers above
> 255. Then there is standardized PCIe ECAM. And then there are lot of
> proprietary vendor specific ways. Proprietary vendor way can be for
> example composing PCIe packet manually or composing configuration access
> command manually.
>
> There are two configuration space access commands: type 0 and type 1.
> It is required to issue correct command type based on topology of the
> endpoint device. When mechanism #1 is used then it is HW who generate
> these commands and it takes care to correctly choose type 0 or 1. But if
> some vendor specific mechanism is used which requires SW to compose
> access command manually then SW is responsible for correct choose.
>=20
>=20
> In your change you have mixed configuration mechanism #1 together with
> configuration command for type 0. This is really a problem as it makes
> the code harder to understand and even hard to figure out how to write a
> new driver (e.g. how to compose configuration command for type 1?).
>
> Also it took me a little bit more time to understand your change.
> Format of command for type 1 and format of configuration mechanism #1
> really looks very similar. So there can be a confusion. Bit 31 is a key =
=20
> there.

Thanks a lot for chimming in!

In practice, the calculation done is very similar for many archs. I=20
initially was planning to only convert things in drivers/pci/pci.h to=20
FIELD_PREP() and be done with it, but then I came across this (a rough and=
=20
incomplete list):

$ git grep -e 'bus.*<<.*16' -B1 -A3 arch

So I ended up extending the scope and trying to find a common ground,=20
which was to make functions into include/linux/pci.h to cover the main=20
calculations. This should explain the placement which you asked in the=20
other reply. I don't think drivers/pci/pci.h is helpful when arch/ code=20
has this very calculation repeated n times.

To me it looked obvious that those calculations relate to what is=20
described in PCI Local Bus Spec r3.0 sec 3.2.2.3.1 (some even explicitly=20
indicate type 0 or type 1).

I still had to find some name for the functions and didn't see any reason=
=20
why I couldn't just use type 0 and type 1 as in that spec. To me, it's=20
hardly an accident that mechanism #1 fields are 1:1 copy of type 1=20
calculation but I think I can still see it also from your viewpoint. I=20
perhaps just look this from more practical standpoint than you (no offence=
=20
meant in any way).

I don't know if the vendor specific part is even relevant to this series
or if you just noted it for completeness. I'm looking for common ground=20
here and if vendor's copying the existing format where they could have=20
invented entirely custom formatting, but is that good enough reason to=20
name the functions differently? Or falsely claim it's vendor specific when=
=20
it's obviously nothing but copying the existing way (i.e., the fields from=
=20
type 1)?

Perhaps the main wrong here was in the naming step or in the terminology=20
I used in the commit messages, or do you think those calcs done under=20
arch/ do not related to type 0/1 in any way (despite being 1:1 copy!)?


Lets take a look at a real function in kernel (this is not the only=20
example, there are more similar ones under arch/, e.g., in
arch/alpha/kernel/core_lca.c):

static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
{
        /* Root bus is always 0 in this hardware */
        if (bus_num =3D=3D 0) {
                /* type 0 */
                return (PCI_CONF1_ADDRESS(0, 0, PCI_FUNC(devfn), where) &
                        ~PCI_CONF1_ENABLE) | BIT(32-PCI_SLOT(devfn));
        } else {
                /* type 1 */
                return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
                                          PCI_FUNC(devfn), where) &
                        ~PCI_CONF1_ENABLE) | 1;
        }
}

So is this "mixing" #1 and type 0 together? Or how you categorize this?
I suspect, by your definition, it's actually abusing what is meant for=20
mechanism #1 to calculate type 1 (obviously because the main calculation=20
is undeniably very much the same :-))?

> I understand that you want to unify drivers, so I would suggest to not
> change existing macros for configuration mechanism #1 and #1-ext.
> And rather create new macros (or functions) for composing configuration
> commands.

And what about code under arch/? I see bits 24-27 and bit #31 being=20
enabled there as well. Or do those categorize as "vendor specific" methods=
=20
so nothing can be done to them?!?

> This makes it explicitly clear that particular PCI or PCIe controller HW
> requires SW driver to compose configuration command (type 0 and 1). Or
> that HW requires from SW to compose format of configuration mechanism #1
> (or #1-ext). Also it would make pci controller drivers more readable as
> from the macro/function it would be easy to understand what it is doing.

So does this effectively boil down to instead of having a boolean enable
parameter for bit #31, I should create two functions with different names
(well, reusing the existing ones perhaps for one of them but the same=20
idea)? Couldn't I just name the function and that enable parameter=20
differently and/or document things better without having two functions?
It's not like these these two things came to be mostly the same by chance,
they're very much related.

> Also important is that if you are in pci controller driver composing
> command for type 0 then with very high probability the HW is designed in
> a way that it requires from SW to also compose command type 1. And it
> would be an mistake if the driver compose only type 0 or type 1. I
> remember from the past an issue: why endpoint PCIe card is working, but
> it is not working if it is connected behind PCIe switch. (mistake was:
> HW was always sending type 0 command due to SW issue)

Do you think this would warrant something that actually combines the=20
type 0/1 calculations inside? Just asking your opinion, I'm not sure how=20
easy the arch code would be to adapt such a bigger change because of the
variations.

--=20
 i.=20

> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pci.h   | 43 ++---------------------
> >  include/linux/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 17fed1846847..cf0530a60105 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -833,49 +833,12 @@ struct pci_devres {
> > =20
> >  struct pci_devres *find_pci_dr(struct pci_dev *pdev);
> > =20
> > -/*
> > - * Config Address for PCI Configuration Mechanism #1
> > - *
> > - * See PCI Local Bus Specification, Revision 3.0,
> > - * Section 3.2.2.3.2, Figure 3-2, p. 50.
> > - */
> > -
> > -#define PCI_CONF1_BUS_SHIFT=0916 /* Bus number */
> > -#define PCI_CONF1_DEV_SHIFT=0911 /* Device number */
> > -#define PCI_CONF1_FUNC_SHIFT=098  /* Function number */
> > -
> > -#define PCI_CONF1_BUS_MASK=090xff
> > -#define PCI_CONF1_DEV_MASK=090x1f
> > -#define PCI_CONF1_FUNC_MASK=090x7
> > -#define PCI_CONF1_REG_MASK=090xfc /* Limit aligned offset to a maximum=
 of 256B */
> > -
> > -#define PCI_CONF1_ENABLE=09BIT(31)
> > -#define PCI_CONF1_BUS(x)=09(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BU=
S_SHIFT)
> > -#define PCI_CONF1_DEV(x)=09(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DE=
V_SHIFT)
> > -#define PCI_CONF1_FUNC(x)=09(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_=
FUNC_SHIFT)
> > -#define PCI_CONF1_REG(x)=09((x) & PCI_CONF1_REG_MASK)
> > -
> >  #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
> >  =09(PCI_CONF1_ENABLE | \
> > -=09 PCI_CONF1_BUS(bus) | \
> > -=09 PCI_CONF1_DEV(dev) | \
> > -=09 PCI_CONF1_FUNC(func) | \
> > -=09 PCI_CONF1_REG(reg))
> > -
> > -/*
> > - * Extension of PCI Config Address for accessing extended PCIe registe=
rs
> > - *
> > - * No standardized specification, but used on lot of non-ECAM-complian=
t ARM SoCs
> > - * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Conf=
ig Address
> > - * are used for specifying additional 4 high bits of PCI Express regis=
ter.
> > - */
> > -
> > -#define PCI_CONF1_EXT_REG_SHIFT=0916
> > -#define PCI_CONF1_EXT_REG_MASK=090xf00
> > -#define PCI_CONF1_EXT_REG(x)=09(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_=
CONF1_EXT_REG_SHIFT)
> > +=09 pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> > =20
> >  #define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
> > -=09(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
> > -=09 PCI_CONF1_EXT_REG(reg))
> > +=09(PCI_CONF1_ENABLE | \
> > +=09 pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> > =20
> >  #endif /* DRIVERS_PCI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 16493426a04f..4c4e3bb52a0a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -26,6 +26,8 @@
> >  #include <linux/args.h>
> >  #include <linux/mod_devicetable.h>
> > =20
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/types.h>
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> > @@ -1183,6 +1185,89 @@ void pci_sort_breadthfirst(void);
> >  #define dev_is_pci(d) ((d)->bus =3D=3D &pci_bus_type)
> >  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : fals=
e))
> > =20
> > +/*
> > + * Config Address for PCI Configuration Mechanism #0/1
> > + *
> > + * See PCI Local Bus Specification, Revision 3.0,
> > + * Section 3.2.2.3.2, Figure 3-1 and 3-2, p. 48-50.
> > + */
> > +#define PCI_CONF_REG=09=090x000000ffU=09/* common for Type 0/1 */
> > +#define PCI_CONF_FUNC=09=090x00000700U=09/* common for Type 0/1 */
> > +#define PCI_CONF1_DEV=09=090x0000f800U
> > +#define PCI_CONF1_BUS=09=090x00ff0000U
> > +#define PCI_CONF1_ENABLE=09BIT(31)
> > +
> > +/**
> > + * pci_conf0_addr - PCI Base Configuration Space address for Type 0 ac=
cess
> > + * @devfn:      Device and function numbers (device number will be ign=
ored)
> > + * @reg:        Base configuration space offset
> > + *
> > + * Calculates the PCI Configuration Space address for Type 0 accesses.
> > + *
> > + * Note: the caller is responsible for adding the bits outside of [10:=
0].
> > + *
> > + * Return: Base Configuration Space address.
> > + */
> > +static inline u32 pci_conf0_addr(u8 devfn, u8 reg)
> > +{
> > +=09return FIELD_PREP(PCI_CONF_FUNC, PCI_FUNC(devfn)) |
> > +=09       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> > +}
> > +
> > +/**
> > + * pci_conf1_addr - PCI Base Configuration Space address for Type 1 ac=
cess
> > + * @bus:=09Bus number of the device
> > + * @devfn:=09Device and function numbers
> > + * @reg:=09Base configuration space offset
> > + * @enable:=09Assert enable bit (bit 31)
> > + *
> > + * Calculates the PCI Base Configuration Space (first 256 bytes) addre=
ss for
> > + * Type 1 accesses.
> > + *
> > + * Note: the caller is responsible for adding the bits outside of [24:=
2]
> > + * and enable bit.
> > + *
> > + * Return: PCI Base Configuration Space address.
> > + */
> > +static inline u32 pci_conf1_addr(u8 bus, u8 devfn, u8 reg, bool enable=
)
> > +{
> > +=09return (enable ? PCI_CONF1_ENABLE : 0) |
> > +=09       FIELD_PREP(PCI_CONF1_BUS, bus) |
> > +=09       FIELD_PREP(PCI_CONF1_DEV | PCI_CONF_FUNC, devfn) |
> > +=09       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> > +}
> > +
> > +/*
> > + * Extension of PCI Config Address for accessing extended PCIe registe=
rs
> > + *
> > + * No standardized specification, but used on lot of non-ECAM-complian=
t ARM SoCs
> > + * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Conf=
ig Address
> > + * are used for specifying additional 4 high bits of PCI Express regis=
ter.
> > + */
> > +#define PCI_CONF1_EXT_REG=090x0f000000UL
> > +
> > +/**
> > + * pci_conf1_ext_addr - PCI Configuration Space address for Type 1 acc=
ess
> > + * @bus:=09Bus number of the device
> > + * @devfn:=09Device and function numbers
> > + * @reg:=09Base or Extended Configuration space offset
> > + * @enable:=09Assert enable bit (bit 31)
> > + *
> > + * Calculates the PCI Base and Extended (4096 bytes per PCI function)
> > + * Configuration Space address for Type 1 accesses. This function assu=
mes
> > + * the Extended Conguration Space is using the reserved bits [27:24].
> > + *
> > + * Note: the caller is responsible for adding the bits outside of [27:=
2] and
> > + * enable bit.
> > + *
> > + * Return: PCI Configuration Space address.
> > + */
> > +static inline u32 pci_conf1_ext_addr(u8 bus, u8 devfn, u16 reg, bool e=
nable)
> > +{
> > +=09return FIELD_PREP(PCI_CONF1_EXT_REG, (reg & 0xf00) >> 8) |
> > +=09       pci_conf1_addr(bus, devfn, reg & 0xff, enable);
> > +}
> > +
> >  /* Generic PCI functions exported to card drivers */
> > =20
> >  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, in=
t cap);
> > --=20
> > 2.39.2
> >=20
>=20
--8323328-1670190891-1714465559=:1349--

