Return-Path: <linux-pci+bounces-40723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC61C483D4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077A3B57EA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DF28B7DB;
	Mon, 10 Nov 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvZD8vx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025220ADF8;
	Mon, 10 Nov 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794286; cv=none; b=M02z/y13VyW1I9PeYjJryHVfDcHE1YiMi/osjJ8POhoxAf1xSdodjA7/2ys8s4tLV5R4Fqs14UQsLrEcO6yNagVhClmNwbUe3QFeQKUHQM6m9if/v5GXajTnshZqWgkQl5je1xS2moHuQhRgQgwpoaHcOZRNuD+HdoSbhS4n++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794286; c=relaxed/simple;
	bh=x5+SThPAsaS5nauv66UmWgNf8U64VnnnZxx9CiToBYY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gpSl2iflOr3ZtXvuujK9s9BcVDkNtw/Ri8D+jtqisQsw02Btk0R0sEQbbrGawAnaXEL0ulBwZJkXx1/PYYQIpv983lGIZUS6TB8lJme5irgrye7OJkWWleg34xDhE6cEsMRG4KjhZmz2LSb2NLt8sgawU4eAq8oMITtHdxppC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvZD8vx0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762794285; x=1794330285;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x5+SThPAsaS5nauv66UmWgNf8U64VnnnZxx9CiToBYY=;
  b=IvZD8vx0pvxwhaDxaXsWLmeiDNyzB1wyge30zNNPt93nSsarbiQ9XcJ1
   vHnx5SWVPMUy68Ri4UeIYbkVBA6uDW4cc+0CqUuA1qE0pIE53nRqUU8I6
   2RiQsOp1XT6KLCLbNTHixdLnLZ2SjkP18uU0OivOSnNS0ZDIwBgXaN9qW
   Ho7AiSG5GjR/N/FtJkUBKk6QBxXQ1q36vWXq1DipJwvYiP4MGz+v7Vrb+
   ZMBxCtYzoF9PhNRDwhFxMcFmwc5rgdB2+xFsKqVFielQHV49EuH0nwlL/
   Xoa/GZGbsQt53MR+6FEdp7rQXlH3mSeMdqOl2Ak7KH5zD7pxC6YEbpBc/
   w==;
X-CSE-ConnectionGUID: CV05cPGST1SHa3DlgPLyDg==
X-CSE-MsgGUID: q4HhRI6uSju7Cz+ab6rKiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63854070"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="63854070"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:04:44 -0800
X-CSE-ConnectionGUID: z3l6HQ1WR/+cp3bB1IV/lg==
X-CSE-MsgGUID: HKFgsgv8TZu/ht/cOhQStA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:04:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 19:04:32 +0200 (EET)
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
In-Reply-To: <8fcc0fd4b74f99d5c4d80d3907e7607a7d4c89da.camel@physik.fu-berlin.de>
Message-ID: <d221be13-f652-cc75-90d1-92cf38e0110e@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>  <20250822145605.18172-3-ilpo.jarvinen@linux.intel.com> <8fcc0fd4b74f99d5c4d80d3907e7607a7d4c89da.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-784219086-1762794272=:1060"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-784219086-1762794272=:1060
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Nov 2025, John Paul Adrian Glaubitz wrote:

> Hello Ilpo,
>=20
> On Fri, 2025-08-22 at 17:55 +0300, Ilpo J=C3=A4rvinen wrote:
> > Under arch/sparc/ there are multiple copies of pcibios_enable_device()
> > but none of those seem to do anything extra beyond what
> > pci_enable_resources() is supposed to do. These functions could lead to
> > inconsistencies in behavior, especially now as pci_enable_resources()
> > and the bridge window resource flags behavior are going to be altered
> > by upcoming changes.
> >=20
> > Remove all pcibios_enable_device() from arch/sparc/ so that PCI core
> > can simply call into pci_enable_resources() instead using it's __weak
> > version of pcibios_enable_device().
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  arch/sparc/kernel/leon_pci.c | 27 ---------------------------
> >  arch/sparc/kernel/pci.c      | 27 ---------------------------
> >  arch/sparc/kernel/pcic.c     | 27 ---------------------------
> >  3 files changed, 81 deletions(-)
> >=20
> > diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.=
c
> > index 8de6646e9ce8..10934dfa987a 100644
> > --- a/arch/sparc/kernel/leon_pci.c
> > +++ b/arch/sparc/kernel/leon_pci.c
> > @@ -60,30 +60,3 @@ void leon_pci_init(struct platform_device *ofdev, st=
ruct leon_pci_info *info)
> >  =09pci_assign_unassigned_resources();
> >  =09pci_bus_add_devices(root_bus);
> >  }
> > -
> > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > -{
> > -=09struct resource *res;
> > -=09u16 cmd, oldcmd;
> > -=09int i;
> > -
> > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > -=09oldcmd =3D cmd;
> > -
> > -=09pci_dev_for_each_resource(dev, res, i) {
> > -=09=09/* Only set up the requested stuff */
> > -=09=09if (!(mask & (1<<i)))
> > -=09=09=09continue;
> > -
> > -=09=09if (res->flags & IORESOURCE_IO)
> > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > -=09=09if (res->flags & IORESOURCE_MEM)
> > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > -=09}
> > -
> > -=09if (cmd !=3D oldcmd) {
> > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > -=09}
> > -=09return 0;
> > -}
> > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > index ddac216a2aff..a9448088e762 100644
> > --- a/arch/sparc/kernel/pci.c
> > +++ b/arch/sparc/kernel/pci.c
> > @@ -722,33 +722,6 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_in=
fo *pbm,
> >  =09return bus;
> >  }
> > =20
> > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > -{
> > -=09struct resource *res;
> > -=09u16 cmd, oldcmd;
> > -=09int i;
> > -
> > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > -=09oldcmd =3D cmd;
> > -
> > -=09pci_dev_for_each_resource(dev, res, i) {
> > -=09=09/* Only set up the requested stuff */
> > -=09=09if (!(mask & (1<<i)))
> > -=09=09=09continue;
> > -
> > -=09=09if (res->flags & IORESOURCE_IO)
> > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > -=09=09if (res->flags & IORESOURCE_MEM)
> > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > -=09}
> > -
> > -=09if (cmd !=3D oldcmd) {
> > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > -=09}
> > -=09return 0;
> > -}
> > -
> >  /* Platform support for /proc/bus/pci/X/Y mmap()s. */
> >  int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct=
 *vma)
> >  {
> > diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> > index 25fe0a061732..3d54ad5656a4 100644
> > --- a/arch/sparc/kernel/pcic.c
> > +++ b/arch/sparc/kernel/pcic.c
> > @@ -641,33 +641,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >  =09}
> >  }
> > =20
> > -int pcibios_enable_device(struct pci_dev *dev, int mask)
> > -{
> > -=09struct resource *res;
> > -=09u16 cmd, oldcmd;
> > -=09int i;
> > -
> > -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > -=09oldcmd =3D cmd;
> > -
> > -=09pci_dev_for_each_resource(dev, res, i) {
> > -=09=09/* Only set up the requested stuff */
> > -=09=09if (!(mask & (1<<i)))
> > -=09=09=09continue;
> > -
> > -=09=09if (res->flags & IORESOURCE_IO)
> > -=09=09=09cmd |=3D PCI_COMMAND_IO;
> > -=09=09if (res->flags & IORESOURCE_MEM)
> > -=09=09=09cmd |=3D PCI_COMMAND_MEMORY;
> > -=09}
> > -
> > -=09if (cmd !=3D oldcmd) {
> > -=09=09pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> > -=09=09pci_write_config_word(dev, PCI_COMMAND, cmd);
> > -=09}
> > -=09return 0;
> > -}
> > -
> >  /* Makes compiler happy */
> >  static volatile int pcic_timer_dummy;
>=20
> This change actually broke driver initialization on SPARC, see:
>=20
> https://github.com/sparclinux/issues/issues/22

Does the attached patch help?

--
 i.
--8323328-784219086-1762794272=:1060
Content-Type: text/x-diff; name=sparc-pref.patch
Content-Transfer-Encoding: BASE64
Content-ID: <d5e9a1c0-3012-20f8-19e5-901e9bf48c88@linux.intel.com>
Content-Description: 
Content-Disposition: attachment; filename=sparc-pref.patch

RnJvbTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50
ZWwuY29tPg0KU3ViamVjdDogW1BBVENIXSBTUEFSQy9QQ0k6IENvcnJlY3Qg
NjQtYml0IG5vbi1wcmVmIC0+IHByZWYNCg0KU2lnbmVkLW9mZi1ieTogSWxw
byBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0K
DQotLS0NCiBhcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2VfNjQuYyB8IDE4
ICsrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL2tlcm5lbC9v
Zl9kZXZpY2VfNjQuYyBiL2FyY2gvc3BhcmMva2VybmVsL29mX2RldmljZV82
NC5jDQppbmRleCBmNTMwOTJiMDdiOWUuLmVhMjFkOTBlM2Y5NCAxMDA2NDQN
Ci0tLSBhL2FyY2gvc3BhcmMva2VybmVsL29mX2RldmljZV82NC5jDQorKysg
Yi9hcmNoL3NwYXJjL2tlcm5lbC9vZl9kZXZpY2VfNjQuYw0KQEAgLTMxMSw2
ICszMTEsMjMgQEAgc3RhdGljIGludCBfX2luaXQgdXNlXzF0bzFfbWFwcGlu
ZyhzdHJ1Y3QgZGV2aWNlX25vZGUgKnBwKQ0KIAlyZXR1cm4gMTsNCiB9DQog
DQorc3RhdGljIHZvaWQgb2ZfZml4dXBfcGNpX3ByZWYoc3RydWN0IGRldmlj
ZV9ub2RlICpkcCwgaW50IGluZGV4LA0KKwkJCSAgICAgIHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqcHAsIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KK3sNCisJaWYg
KCFyZXNvdXJjZV9zaXplKHJlcykpDQorCQlyZXR1cm47DQorCWlmIChyZXMt
PmVuZCA8PSB+KCh1MzIpMCkpDQorCQlyZXR1cm47DQorDQorCWlmICghb2Zf
bm9kZV9pc190eXBlKHBwLCAicGNpIikgJiYgIW9mX25vZGVfaXNfdHlwZShw
cCwgInBjaWV4IikpDQorCQlyZXR1cm47DQorDQorCWlmICghKHJlcy0+Zmxh
Z3MgJiBJT1JFU09VUkNFX1BSRUZFVENIKSkgew0KKwkJcmVzLT5mbGFncyB8
PSBJT1JFU09VUkNFX1BSRUZFVENIOw0KKwkJcHJpbnRrKCIlcE9GIHJlZ1sl
ZF0gZml4dXA6IHByZWYgY29ycmVjdGVkXG4iLCBkcCwgaW5kZXgpOw0KKwl9
DQorfQ0KKw0KIHN0YXRpYyBpbnQgb2ZfcmVzb3VyY2VfdmVyYm9zZTsNCiAN
CiBzdGF0aWMgdm9pZCBfX2luaXQgYnVpbGRfZGV2aWNlX3Jlc291cmNlcyhz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvcCwNCkBAIC00MTIsNiArNDI5LDcg
QEAgc3RhdGljIHZvaWQgX19pbml0IGJ1aWxkX2RldmljZV9yZXNvdXJjZXMo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqb3AsDQogCQkJci0+c3RhcnQgPSBy
ZXN1bHQ7DQogCQkJci0+ZW5kID0gcmVzdWx0ICsgc2l6ZSAtIDE7DQogCQkJ
ci0+ZmxhZ3MgPSBmbGFnczsNCisJCQlvZl9maXh1cF9wY2lfcHJlZihkcCwg
aW5kZXgsIHBwLCByKTsNCiAJCX0NCiAJCXItPm5hbWUgPSBvcC0+ZGV2Lm9m
X25vZGUtPmZ1bGxfbmFtZTsNCiAJfQ0KDQotLSANCnRnOiAoM2E4NjYwODc4
ODM5Li4pIHNwYXJjL2R0LWZpeHVwLXByZWYgKGRlcGVuZHMgb246IG1haW4p
DQo=

--8323328-784219086-1762794272=:1060--

