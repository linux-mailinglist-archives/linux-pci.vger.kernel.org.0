Return-Path: <linux-pci+bounces-41119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C082C58B63
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12E004EEFEE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253F342518;
	Thu, 13 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Crqr6pJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3A2F90C5;
	Thu, 13 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049391; cv=none; b=nHVhUhCbFVPh10zeUONRaR+hU4kOO3Rr6fd9R6u/iwIW3lEsF/MKrnS1VeLIqXuW0Gfw+NWh9uDMPdPeVrtrSuEcA4vnaQc5SjT06zaPxjwdz7mabScR/N2uH97d22t6ydHreamRaQeDrpPzViFatB6z2ct6NqbVEuxAOc6LjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049391; c=relaxed/simple;
	bh=qi0VduJ3q4LlN3ypA1D4cqv/xmGMRFYGUvSvvFXqbEg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ntJIEVBMx+EhP3kWucFhFP6jvtBDwBVwguWreqX04DEg8dFxom46mW7uW8NataQ3qZNbH7naQUAWhL3th6w/24pO63kqbtZDYaX3pcCSTm1i4dbZJ9xM2oEJ38OSKPLV0z3JQiOsjepQKn0dTPzdoWexLT5LMnrUgBwVgipshwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Crqr6pJ2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763049390; x=1794585390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qi0VduJ3q4LlN3ypA1D4cqv/xmGMRFYGUvSvvFXqbEg=;
  b=Crqr6pJ2W+PZvqn+mOt9CaOIelD/w9Fd5JGSfb1+KaW52v108UC171fF
   etZqgYMzDuHl78AdbwNKP2OtSFdBJTWeasdXTgsApCVqd+32M8+D06jpg
   6eQ3ETwo1n7plhC4IatxsptmXuK8+FLAIETMHbHZoHx04P4BYLCCN2gLp
   3z45xiP00LOJQp2S0J+6lolK5w5lkDgX5f2eTsHwYvQFjHA3ygiVpdKUH
   8q1a4jvOooVIpyNiy7xnhtOpOk3FY5LQxWvE8q3Vf+rXEvEu+oSr3lraF
   zNhg75oc4Avu66QsgHpUkwiYnpC/07uP0czv+LAVS/y6TNf0RKSs0eXVq
   Q==;
X-CSE-ConnectionGUID: Abrg1aBSSkekJlwe2fPqDw==
X-CSE-MsgGUID: m1/ttwsjTRiYrT7I+D3clQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75449599"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75449599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:56:29 -0800
X-CSE-ConnectionGUID: 5Q3fWISCQ1is7ToHEb2EBw==
X-CSE-MsgGUID: FzBA1utJSVaatum3p4QUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220182536"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:56:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Nov 2025 17:56:16 +0200 (EET)
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
    sparclinux@vger.kernel.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Yinghai Lu <yinghai@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/24] sparc/PCI: Remove pcibios_enable_device() as they
 do nothing extra
In-Reply-To: <d221be13-f652-cc75-90d1-92cf38e0110e@linux.intel.com>
Message-ID: <f8231cc3-a3ba-fc58-077e-90cce1a94429@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>  <20250822145605.18172-3-ilpo.jarvinen@linux.intel.com> <8fcc0fd4b74f99d5c4d80d3907e7607a7d4c89da.camel@physik.fu-berlin.de> <d221be13-f652-cc75-90d1-92cf38e0110e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-135835264-1763049376=:1464"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-135835264-1763049376=:1464
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Nov 2025, Ilpo J=C3=A4rvinen wrote:

> On Thu, 6 Nov 2025, John Paul Adrian Glaubitz wrote:
>=20
> > Hello Ilpo,
> >=20
> > On Fri, 2025-08-22 at 17:55 +0300, Ilpo J=C3=A4rvinen wrote:
> > > Under arch/sparc/ there are multiple copies of pcibios_enable_device(=
)
> > > but none of those seem to do anything extra beyond what
> > > pci_enable_resources() is supposed to do. These functions could lead =
to
> > > inconsistencies in behavior, especially now as pci_enable_resources()
> > > and the bridge window resource flags behavior are going to be altered
> > > by upcoming changes.
> > >=20
> > > Remove all pcibios_enable_device() from arch/sparc/ so that PCI core
> > > can simply call into pci_enable_resources() instead using it's __weak
> > > version of pcibios_enable_device().
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  arch/sparc/kernel/leon_pci.c | 27 ---------------------------
> > >  arch/sparc/kernel/pci.c      | 27 ---------------------------
> > >  arch/sparc/kernel/pcic.c     | 27 ---------------------------
> > >  3 files changed, 81 deletions(-)
> > >=20
> > > diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pc=
i.c
> > > index 8de6646e9ce8..10934dfa987a 100644
> > > --- a/arch/sparc/kernel/leon_pci.c
> > > +++ b/arch/sparc/kernel/leon_pci.c
> > > @@ -60,30 +60,3 @@ void leon_pci_init(struct platform_device *ofdev, =
struct leon_pci_info *info)
> > >  =09pci_assign_unassigned_resources();
> > >  =09pci_bus_add_devices(root_bus);
> > >  }
> > > -
> > > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > > -{
> > > -=09struct resource *res;
> > > -=09u16 cmd, oldcmd;
> > > -=09int i;
> > > -
> > > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > > -=09oldcmd =3D cmd;
> > > -
> > > -=09pci_dev_for_each_resource(dev, res, i) {
> > > -=09=09/* Only set up the requested stuff */
> > > -=09=09if (!(mask & (1<<i)))
> > > -=09=09=09continue;
> > > -
> > > -=09=09if (res->flags & IORESOURCE_IO)
> > > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > > -=09=09if (res->flags & IORESOURCE_MEM)
> > > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > > -=09}
> > > -
> > > -=09if (cmd !=3D oldcmd) {
> > > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd)=
;
> > > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > > -=09}
> > > -=09return 0;
> > > -}
> > > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > > index ddac216a2aff..a9448088e762 100644
> > > --- a/arch/sparc/kernel/pci.c
> > > +++ b/arch/sparc/kernel/pci.c
> > > @@ -722,33 +722,6 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_=
info *pbm,
> > >  =09return bus;
> > >  }
> > > =20
> > > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > > -{
> > > -=09struct resource *res;
> > > -=09u16 cmd, oldcmd;
> > > -=09int i;
> > > -
> > > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > > -=09oldcmd =3D cmd;
> > > -
> > > -=09pci_dev_for_each_resource(dev, res, i) {
> > > -=09=09/* Only set up the requested stuff */
> > > -=09=09if (!(mask & (1<<i)))
> > > -=09=09=09continue;
> > > -
> > > -=09=09if (res->flags & IORESOURCE_IO)
> > > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > > -=09=09if (res->flags & IORESOURCE_MEM)
> > > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > > -=09}
> > > -
> > > -=09if (cmd !=3D oldcmd) {
> > > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd)=
;
> > > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > > -=09}
> > > -=09return 0;
> > > -}
> > > -
> > >  /* Platform support for /proc/bus/pci/X/Y mmap()s. */
> > >  int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_stru=
ct *vma)
> > >  {
> > > diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> > > index 25fe0a061732..3d54ad5656a4 100644
> > > --- a/arch/sparc/kernel/pcic.c
> > > +++ b/arch/sparc/kernel/pcic.c
> > > @@ -641,33 +641,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> > >  =09}
> > >  }
> > > =20
> > > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > > -{
> > > -=09struct resource *res;
> > > -=09u16 cmd, oldcmd;
> > > -=09int i;
> > > -
> > > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > > -=09oldcmd =3D cmd;
> > > -
> > > -=09pci_dev_for_each_resource(dev, res, i) {
> > > -=09=09/* Only set up the requested stuff */
> > > -=09=09if (!(mask & (1<<i)))
> > > -=09=09=09continue;
> > > -
> > > -=09=09if (res->flags & IORESOURCE_IO)
> > > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > > -=09=09if (res->flags & IORESOURCE_MEM)
> > > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > > -=09}
> > > -
> > > -=09if (cmd !=3D oldcmd) {
> > > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd)=
;
> > > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > > -=09}
> > > -=09return 0;
> > > -}
> > > -
> > >  /* Makes compiler happy */
> > >  static volatile int pcic_timer_dummy;
> >=20
> > This change actually broke driver initialization on SPARC, see:
> >=20
> > https://github.com/sparclinux/issues/issues/22
>=20
> Does the attached patch help?

Second fixup patch attached.

--=20
 i.

--8323328-135835264-1763049376=:1464
Content-Type: text/x-diff; name=sparc-pref2.patch
Content-Transfer-Encoding: BASE64
Content-ID: <474a4557-bd2d-a362-a883-08ba47f89a36@linux.intel.com>
Content-Description: 
Content-Disposition: attachment; filename=sparc-pref2.patch

RnJvbTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50
ZWwuY29tPg0KU3ViamVjdDogW1BBVENIXSBTUEFSQy9QQ0k6IENvcnJlY3Qg
NjQtYml0IG5vbi1wcmVmIC0+IHByZWYNCg0KU2lnbmVkLW9mZi1ieTogSWxw
byBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0K
DQotLS0NCiBhcmNoL3NwYXJjL2tlcm5lbC9wY2kuYyB8IDE5ICsrKysrKysr
KysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9rZXJuZWwvcGNpLmMgYi9h
cmNoL3NwYXJjL2tlcm5lbC9wY2kuYw0KaW5kZXggYTk0NDgwODhlNzYyLi4z
Yjg1NzU4OTEwMDYgMTAwNjQ0DQotLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9w
Y2kuYw0KKysrIGIvYXJjaC9zcGFyYy9rZXJuZWwvcGNpLmMNCkBAIC0xODEs
NiArMTgxLDI0IEBAIHN0YXRpYyBpbnQgX19pbml0IG9mcGNpX2RlYnVnKGNo
YXIgKnN0cikNCiANCiBfX3NldHVwKCJvZnBjaV9kZWJ1Zz0iLCBvZnBjaV9k
ZWJ1Zyk7DQogDQorc3RhdGljIHZvaWQgb2ZfZml4dXBfcGNpX3ByZWYoc3Ry
dWN0IHBjaV9kZXYgKmRldiwgaW50IGluZGV4LA0KKwkJCSAgICAgIHN0cnVj
dCByZXNvdXJjZSAqcmVzKQ0KK3sNCisJaWYgKCEocmVzLT5mbGFncyAmIElP
UkVTT1VSQ0VfTUVNXzY0KSkNCisJCXJldHVybjsNCisNCisJaWYgKCFyZXNv
dXJjZV9zaXplKHJlcykpDQorCQlyZXR1cm47DQorCWlmIChyZXMtPmVuZCA8
PSB+KCh1MzIpMCkpDQorCQlyZXR1cm47DQorDQorCWlmICghKHJlcy0+Zmxh
Z3MgJiBJT1JFU09VUkNFX1BSRUZFVENIKSkgew0KKwkJcmVzLT5mbGFncyB8
PSBJT1JFU09VUkNFX1BSRUZFVENIOw0KKwkJcGNpX2luZm8oZGV2LCAicmVn
IDB4JXg6IGZpeHVwOiBwcmVmIGFkZGVkIHRvIDY0LWJpdCByZXNvdXJjZVxu
IiwNCisJCQkgaW5kZXgpOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyB1bnNpZ25l
ZCBsb25nIHBjaV9wYXJzZV9vZl9mbGFncyh1MzIgYWRkcjApDQogew0KIAl1
bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCkBAIC0yNDQsNiArMjYyLDcgQEAg
c3RhdGljIHZvaWQgcGNpX3BhcnNlX29mX2FkZHJzKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKm9wLA0KIAkJcmVzLT5lbmQgPSBvcF9yZXMtPmVuZDsNCiAJ
CXJlcy0+ZmxhZ3MgPSBmbGFnczsNCiAJCXJlcy0+bmFtZSA9IHBjaV9uYW1l
KGRldik7DQorCQlvZl9maXh1cF9wY2lfcHJlZihkZXYsIGksIHJlcyk7DQog
DQogCQlwY2lfaW5mbyhkZXYsICJyZWcgMHgleDogJXBSXG4iLCBpLCByZXMp
Ow0KIAl9DQoNCi0tIA0KdGc6ICgzYTg2NjA4Nzg4MzkuLikgc3BhcmMvZHQt
Zml4dXAtcHJlZiAoZGVwZW5kcyBvbjogbWFpbikNCg==

--8323328-135835264-1763049376=:1464--

