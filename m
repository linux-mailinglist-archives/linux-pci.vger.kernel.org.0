Return-Path: <linux-pci+bounces-12950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38889719F3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBBA2838A6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653E1B86EB;
	Mon,  9 Sep 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHbOSJG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E11B7904;
	Mon,  9 Sep 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886251; cv=none; b=uKaVnNWGNk3rJfx6wFeq1UWUmtPmi1e4N9y93VSgxKlu/Dz3KQa2lgP6h4ZDrw7VY3p3JbCklZwSrc5hDtSuOORteB2/nsX8uiLEuh0n/lqyXZRlYxMevqQ1XK7n6eKwXVJ8zimhYy9Nwsr3ByapUQXmn/jb7M2qKa7du8bl2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886251; c=relaxed/simple;
	bh=B8xNfrh4X6WUnOc5r7AikSWyUA5ZNSWVWonlubRMeAo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aivZ9XxOsmGZj7yojW48qa2TpIynNt8t15PEqy+xCv/Oyhcbdcd3RG07z2+BdsS0NRT+BJc7dS45vRJulB9Wshor+yMzZRV8u8nt2fwq1tbzldLROZcHexONgv7mZdb/YT9YiAvlNJjTkDJ/U0MSoZ5Wry3/Px0lLCyjX1l27/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHbOSJG3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725886250; x=1757422250;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B8xNfrh4X6WUnOc5r7AikSWyUA5ZNSWVWonlubRMeAo=;
  b=mHbOSJG37PE3ixX9Ip+RTJi2UKUCRZR7o3IB4ymkWRLzrkLPNsjcDB65
   1GuOIwVVSE+fQqLAATDvtKPrE67YOlDxhDC/3Z8uv4y07fqVtduB6TzPP
   B6tXnjZenmHiVRUSnXQyDQ2sUSoWGM4VB984cdzA3yGS0IOifZuPqyo5t
   Q4exz4K/4wPk7U8LIk8HO5+vkEhbV2up8w4vZQ2/v35rbImtCtaS8hGco
   kx5S9Ma9nP6iOvknHVmNlp5IpXKELBcmqoVE2ZkykOf41RBA2VT7/dC+4
   FCk3h/759s26qTGxrcHRadEVKX7QZLLtiR8Wwc1tdxa6YWvk+/P9F6C+Q
   A==;
X-CSE-ConnectionGUID: uFYD45HBQ1+XAgPhHpyQnA==
X-CSE-MsgGUID: fvxLj3rpSr2VrKgrwGFTZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35155113"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35155113"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:50:49 -0700
X-CSE-ConnectionGUID: cicXpB1NSoG4z2zTYan8SQ==
X-CSE-MsgGUID: 9Mp/Ta9TRzGMVsRoIokaeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66633903"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:50:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Sep 2024 15:50:41 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
In-Reply-To: <db382712-8b71-3f1c-bffd-7b35921704c7@linux.intel.com>
Message-ID: <fad13835-c426-fde5-786c-bd4c88a4d35f@linux.intel.com>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk> <alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk> <db382712-8b71-3f1c-bffd-7b35921704c7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-294635700-1725886241=:1029"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-294635700-1725886241=:1029
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Bjorn,

You still seem to have the old version of this patch in enumeration=20
branch.

Could you please consider replacing it with this v3 one that is slightly=20
better (use_lt was changed to true because it makes more sense).

On Mon, 26 Aug 2024, Ilpo J=E4rvinen wrote:
> On Sun, 25 Aug 2024, Maciej W. Rozycki wrote:
>=20
> > When `pcie_failed_link_retrain' has failed to retrain the link by hand=
=20
> > it leaves the link speed restricted to 2.5GT/s, which will then affect=
=20
> > any device that has been plugged in later on, which may not suffer from=
=20
> > the problem that caused the speed restriction to have been attempted. =
=20
> > Consequently such a downstream device will suffer from an unnecessary=
=20
> > communication throughput limitation and therefore performance loss.
> >=20
> > Remove the speed restriction then and revert the Link Control 2 registe=
r=20
> > to its original state if link retraining with the speed restriction in=
=20
> > place has failed.  Retrain the link again afterwards so as to remove an=
y=20
> > residual state, waiting on LT rather than DLLLA to avoid an excessive=
=20
> > delay and ignoring the result as this training is supposed to fail anyw=
ay.
> >=20
> > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > Reported-by: Matthew W Carlis <mattc@purestorage.com>
> > Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorag=
e.com/
> > Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorag=
e.com/
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Cc: stable@vger.kernel.org # v6.5+
> > ---
> > Changes from v2:
> >=20
> > - Wait on LT rather than DLLLA with clean-up retraining with the speed=
=20
> >   restriction lifted, so as to avoid an excessive delay as it's suppose=
d=20
> >   to fail anyway.
> >=20
> > New change in v2.
> > ---
> >  drivers/pci/quirks.c |   11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > linux-pcie-failed-link-retrain-fail-unclamp.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> > @@ -66,7 +66,7 @@
> >   * apply this erratum workaround to any downstream ports as long as th=
ey
> >   * support Link Active reporting and have the Link Control 2 register.
> >   * Restrict the speed to 2.5GT/s then with the Target Link Speed field=
,
> > - * request a retrain and wait 200ms for the data link to go up.
> > + * request a retrain and check the result.
> >   *
> >   * If this turns out successful and we know by the Vendor:Device ID it=
 is
> >   * safe to do so, then lift the restriction, letting the devices negot=
iate
> > @@ -74,6 +74,10 @@
> >   * firmware may have already arranged and lift it with ports that alre=
ady
> >   * report their data link being up.
> >   *
> > + * Otherwise revert the speed to the original setting and request a re=
train
> > + * again to remove any residual state, ignoring the result as it's sup=
posed
> > + * to fail anyway.
> > + *
> >   * Return TRUE if the link has been successfully retrained, otherwise =
FALSE.
> >   */
> >  bool pcie_failed_link_retrain(struct pci_dev *dev)
> > @@ -92,6 +96,8 @@ bool pcie_failed_link_retrain(struct pci
> >  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> >  =09if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) =3D=3D
> >  =09    PCI_EXP_LNKSTA_LBMS) {
> > +=09=09u16 oldlnkctl2 =3D lnkctl2;
> > +
> >  =09=09pci_info(dev, "broken device, retraining non-functional downstre=
am link at 2.5GT/s\n");
> > =20
> >  =09=09lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> > @@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci
> > =20
> >  =09=09if (pcie_retrain_link(dev, false)) {
> >  =09=09=09pci_info(dev, "retraining failed\n");
> > +=09=09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
> > +=09=09=09=09=09=09   oldlnkctl2);
> > +=09=09=09pcie_retrain_link(dev, true);
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.


--8323328-294635700-1725886241=:1029--

