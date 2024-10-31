Return-Path: <linux-pci+bounces-15720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1419B7EB9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECCA1F21355
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE11A255A;
	Thu, 31 Oct 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDHBLa0S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5919EED7;
	Thu, 31 Oct 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389367; cv=none; b=LE32hez0O5XNYlLTz+/Hhq/vrNIG+EhCyrPZaLe4pM7aJMhEsdu2UC2bLiADLsGk3AVaqKtKl/iUGhJ4fY3V8bvNxVzcp2KA021hYbV8UhPrIc6y8jOoEJMr+0WLbOSziEac4KN8pXlNQWNEKNsPJFRtbbBd/+SF7EXXCLkfJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389367; c=relaxed/simple;
	bh=uSgsP+2WXwyESpGCC6UzoCc4+vP2ShPPHr5kyF8rBmE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bPvo4h1e9zwEWPDM0yVG6KYHj6E97/jtF0tXHZiEKLn8tGXwstvT1yvMYyaIASDvJEsORPmKfUDAFxf35oIUWgcxVMtlDeflm4yu8fnxZFi4QNOWqtvgr8iHnAtL0zcWOWW9EwmtRJifFEuPMebsYTz87Oqm7wIjW82MreU0qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDHBLa0S; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730389366; x=1761925366;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uSgsP+2WXwyESpGCC6UzoCc4+vP2ShPPHr5kyF8rBmE=;
  b=cDHBLa0SMbHYMxoe0GG+vVaV9gIhMvbaHbmWVfd/xx3borDxWvxp/Dbh
   wBS15tTkoeLiycgb6pGJpm8DoC1FVZ2/OXQEql6m5l/QBG/D/nWPVzaOq
   3O2SkR+ZBF5YJXBR3d0FglEQJSaZIkJ5Rayg30uMSMTIc9ppsZAfHtRcg
   ikqIG3BXOKePUAam4DBVRHyse93Fjebbl+sdM1cDSkYJ5Owr3zEz6WCFU
   /IGSDJilsoJlpQkj9fI9s38pVjK0I4KFDB5wbcg2gCK5CnhSt0gFs5CJ4
   v4rUnrYqJgzWuEszAwH2Quqsp09KbkNyhqvbysuL17vY4EWam9fhr7KkS
   A==;
X-CSE-ConnectionGUID: iorL6Kp+Tqa1EED4dnZXGg==
X-CSE-MsgGUID: v2nuJY53TO+sOPym8tcJQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="33938248"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="33938248"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:42:46 -0700
X-CSE-ConnectionGUID: LrUSuH0DSZiT1PihnNNkfw==
X-CSE-MsgGUID: Mv6aeGsXTsSTt96lm7Z3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87468690"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:42:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 17:42:34 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, 
    "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
    "avadhut.naik@amd.com" <avadhut.naik@amd.com>, 
    "john.allen@amd.com" <john.allen@amd.com>, 
    "mario.limonciello@amd.com" <mario.limonciello@amd.com>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, 
    "richard.gong@amd.com" <richard.gong@amd.com>, 
    "jdelvare@suse.com" <jdelvare@suse.com>, 
    "linux@roeck-us.net" <linux@roeck-us.net>, 
    "clemens@ladisch.de" <clemens@ladisch.de>, 
    "hdegoede@redhat.com" <hdegoede@redhat.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>, 
    "carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH 06/16] x86/amd_nb: Simplify root device search
In-Reply-To: <20241031153444.GB1511886@yaz-khff2.amd.com>
Message-ID: <1ca45a43-070b-bd5e-995b-243b9644dde7@linux.intel.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-7-yazen.ghannam@amd.com> <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com> <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
 <20241031153444.GB1511886@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1839920720-1730389354=:939"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1839920720-1730389354=:939
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 31 Oct 2024, Yazen Ghannam wrote:

> On Thu, Oct 31, 2024 at 12:08:20PM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 31 Oct 2024, Zhuo, Qiuxu wrote:
> >=20
> > > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > [...]
> > > > +struct pci_dev *amd_node_get_root(u16 node) {
> > > > +=09struct pci_dev *df_f0 __free(pci_dev_put) =3D NULL;
> > >=20
> > > NULL pointer initialization is not necessary.
> >=20
> > It is, because __free() is used...
> >=20
> > > > +=09struct pci_dev *root;
> > > > +=09u16 cntl_off;
> > > > +=09u8 bus;
> > > > +
> > > > +=09if (!boot_cpu_has(X86_FEATURE_ZEN))
> > > > +=09=09return NULL;
> >=20
> > ...This would try to free() whatever garbage df_f0 holds...
> >=20
> > > > +=09/*
> > > > +=09 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> > > > +=09 * Bits [7:0] (SecBusNum) holds the bus number of the root devi=
ce for
> > > > +=09 * this Data Fabric instance. The segment, device, and function=
 will be
> > > > 0.
> > > > +=09 */
> > > > +=09df_f0 =3D amd_node_get_func(node, 0);
> >=20
> > ...However, the recommended practice when using __free() is this (as=20
> > documented in include/linux/cleanup.h):
> >=20
> >  * Given that the "__free(...) =3D NULL" pattern for variables defined =
at
> >  * the top of the function poses this potential interdependency problem
> >  * the recommendation is to always define and assign variables in one
> >  * statement and not group variable definitions at the top of the
> >  * function when __free() is used.
> >=20
> > I know the outcome will look undesirable to some, me included, but=20
> > there's little that can be done to that because there's no other way fo=
r=20
> > the compiler to infer the order.
> >=20
> > That being said, strictly speaking it isn't causing issue in this funct=
ion=20
> > as is but it's still a bad pattern to initialize to =3D NULL because in=
=20
> > other instances it will cause problems. So better to steer away from th=
e
> > pattern entirely rather than depend on reviewers noticing the a cleaup=
=20
> > ordering problem gets introduced by some later change to the function.
> >
>=20
> I originally read that in the context of using a guard(). But really we
> should do like this in any case, correct?
>=20
> struct pci_dev *df_f0 __free(pci_dev_put) =3D amd_node_get_func(node, 0);

Yes, that is the recommendation. It says "always" so not only the cases=20
where guard() or other __free()s are used.

Of course this only applies to use of __free(), other variables should=20
still be declared in the usual place and not spread around.

--=20
 i.

--8323328-1839920720-1730389354=:939--

