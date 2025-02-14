Return-Path: <linux-pci+bounces-21462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63629A36033
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E62E1893558
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87F264A82;
	Fri, 14 Feb 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+oengna"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463B22E405;
	Fri, 14 Feb 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542842; cv=none; b=sz4hez6V/doZv+GnAXE6zxfaNyWQFD1FBg8RMhtYfgGkaW4eEDo2PBF8d10Tk39OzZK4STsq5rv819Us+KTefBg0mk37FLEBkK/WH9TaxR2NWtMCP9+IQiLAAdyRIHoL/LeOB27a2Pk+m9OlIcVkHhJMm8lgbwTVRB1a+pCHsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542842; c=relaxed/simple;
	bh=+BoJUTYiUXLY4ADWAJfvGxG7gOy6R+8l/PK5l6b+W/U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GMrKJJpiQ+fzVx3kDds8DwtcPUB+OGlkEQiEpYDhINY4F71F8hEoqSZQlfsCQgLTE2MvvCJnnQYmEWByTUYJZ+qzhNNNV45gnju5gGeXQrf/2h6nDOjic/S8qO5Pa94IGOvB2MRphVlvz249rdjVBvmcG/C/kRvFoSPVSmZj+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+oengna; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739542841; x=1771078841;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+BoJUTYiUXLY4ADWAJfvGxG7gOy6R+8l/PK5l6b+W/U=;
  b=R+oengna2oqlmMOv/BVEw4YOCorrUV7HC/sHh13rNu5wYpumjI0N86Gh
   IcmX6G2JIXyUt7ZU08Se5psBkEiRRLyE+YgFIKSRbayHT6iKrR/XeiEYH
   2UzsN0ZT2OMsl2ZTlFDYfrCd06lPI6Mg4sQD5ZJt2K924Eax1kjDOAHzR
   h0oftqL/TLILjTgqaTpxgf5iJTcY2UKXClWPFn+kZc0SyOnXIDJfcELHV
   mDFGVI6aeVpKTmKTzm1k5sw5n3OqvMTpoAo+jMY57JPvLjw7AhQ87TqYG
   e3Zq69UTtPbpR4kjEN/WcOiD3Zl1gFaqtc7iF3X7gF6lPZ/+q2oUo4nZ0
   w==;
X-CSE-ConnectionGUID: 3O/aBGa7RAK3l5/+3j19ow==
X-CSE-MsgGUID: gigUwS0/QrKBE8MTZyZTxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="51692281"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="51692281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:20:40 -0800
X-CSE-ConnectionGUID: nW6MOpGtQpOMH2AYPi+YbA==
X-CSE-MsgGUID: ogpQ13uCTPe8fxE5cv2hMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118401372"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:20:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Feb 2025 16:20:34 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Alex Williamson <alex.williamson@redhat.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: Avoid pointless capability searches
In-Reply-To: <20250213163850.GA114277@bhelgaas>
Message-ID: <c45cf368-a31d-6b5d-f7fb-23dcc6cfc420@linux.intel.com>
References: <20250213163850.GA114277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-976812073-1739542834=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-976812073-1739542834=:944
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Feb 2025, Bjorn Helgaas wrote:

> On Thu, Feb 13, 2025 at 03:52:05PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 7 Feb 2025, Bjorn Helgaas wrote:
> > > Many of the save/restore functions in the pci_save_state() and
> > > pci_restore_state() paths depend on both a PCI capability of the devi=
ce and
> > > a pci_cap_saved_state structure to hold the configuration data, and t=
hey
> > > skip the operation if either is missing.
> > >=20
> > > Look for the pci_cap_saved_state first so if we don't have one, we ca=
n skip
> > > searching for the device capability, which requires several slow conf=
ig
> > > space accesses.
>=20
> > > +++ b/drivers/pci/vc.c
> > > @@ -355,20 +355,17 @@ int pci_save_vc_state(struct pci_dev *dev)
> > >  =09int i;
> > > =20
> > >  =09for (i =3D 0; i < ARRAY_SIZE(vc_caps); i++) {
> > > -=09=09int pos, ret;
> > >  =09=09struct pci_cap_saved_state *save_state;
> > > +=09=09int pos, ret;
> > > +
> > > +=09=09save_state =3D pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > > +=09=09if (!save_state)
> > > +=09=09=09return -ENOMEM;
> > > =20
> > >  =09=09pos =3D pci_find_ext_capability(dev, vc_caps[i].id);
> > >  =09=09if (!pos)
> > >  =09=09=09continue;
> > > =20
> > > -=09=09save_state =3D pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > > -=09=09if (!save_state) {
> > > -=09=09=09pci_err(dev, "%s buffer not found in %s\n",
> > > -=09=09=09=09vc_caps[i].name, __func__);
> > > -=09=09=09return -ENOMEM;
> > > -=09=09}
> >=20
> > I think this order change will cause a functional change because=20
> > pci_allocate_vc_save_buffers() only allocated for those capabilities th=
at=20
> > are exist for dev. Thus, the loop will prematurely exit.
>=20
> Oof, thank you for catching this!  I'll drop this for now.
>=20
> It would be nice to make pci_save_vc_state() parallel with
> pci_restore_vc_state() (and with most other pci_save_*_state()
> functions) and have it return void.  But pci_save_state() returns the
> pci_save_vc_state() return value, and there are ~20 pci_save_state()
> callers that pay attention to that return value.
>=20
> I'm not convinced there's real value in pci_save_state() error
> returns, given that so few callers check it, but it definitely
> requires more analysis before removing it.

Indeed, I also though that -ENOMEM even in the original is questionable.
These are not the real sources of the failure but just secondary effect=20
from the failure that occurred earlier in _pci_add_cap_save_buffer().

--=20
 i.

> > >  =09=09ret =3D pci_vc_do_save_buffer(dev, pos, save_state, true);
> > >  =09=09if (ret) {
> > >  =09=09=09pci_err(dev, "%s save unsuccessful %s\n",
> > > @@ -392,12 +389,15 @@ void pci_restore_vc_state(struct pci_dev *dev)
> > >  =09int i;
> > > =20
> > >  =09for (i =3D 0; i < ARRAY_SIZE(vc_caps); i++) {
> > > -=09=09int pos;
> > >  =09=09struct pci_cap_saved_state *save_state;
> > > +=09=09int pos;
> > > +
> > > +=09=09save_state =3D pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > > +=09=09if (!save_state)
> > > +=09=09=09continue;
> > > =20
> > >  =09=09pos =3D pci_find_ext_capability(dev, vc_caps[i].id);
> > > -=09=09save_state =3D pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > > -=09=09if (!save_state || !pos)
> > > +=09=09if (!pos)
> > >  =09=09=09continue;
> > > =20
> > >  =09=09pci_vc_do_save_buffer(dev, pos, save_state, false);


--8323328-976812073-1739542834=:944--

