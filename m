Return-Path: <linux-pci+bounces-19311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F9A01AAE
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851C11882BCC
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B189155A59;
	Sun,  5 Jan 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/6pZt1O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1E14F9FB;
	Sun,  5 Jan 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736095399; cv=none; b=ntQYDVPk0GFdkE5GbgV6l0gIiBGCBFfaO9Badxc8X1zScmrSSd7QMxpGBKHRAjsczVx98j5zur+L06bEPc2VC04PCkKWES7naVsaiSsB4r+yRWjXRZLQoWPtMVvKRhlYPdrw72Rh2DemzIuUBH1DlcmtT81rVU9mwN0dwLY8HFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736095399; c=relaxed/simple;
	bh=vvJ+Yp3leDodK0CvCdi9+gRe6EvxCrT8p2X4U/O0HQc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ToH2BNhNffMIl5mn1P0elowJCeh0l8m9QdkHGfhnwakLbPJfP6/deqUmmwHng23PxvuXjGqANYzKYrRGxJZPf2jtV3tnkVvwcmRIk6bRgxbZw9gsjd1idwsnEMuDGfCqDYnmL5w3shQNkL2Nw/P1/QBJXBbJHcOffafe8AZlxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/6pZt1O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736095397; x=1767631397;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=vvJ+Yp3leDodK0CvCdi9+gRe6EvxCrT8p2X4U/O0HQc=;
  b=F/6pZt1O1MbNe6skYxAtIKm7zn3iPBViANAzYv0kwNOMaYUp0bOqPlrE
   oROP0s6ALD9LAo/VcXwJq0y0f8vqydDu7Jzrk44VRpov2gJrLAmIQc0B2
   8aQR1lJlij8B6v48qpJ9JcDxvVBbViONaOcAfZupMJcRtLBdZRS3zqElQ
   HAxwDaukHqvy4uweggE8LOjqrpMmhCxImZ3Dve7NQRqgm4vHIwT/L8nwL
   tZegtwGUoFkiogRL06HLACzVkE9riaIj6wEIoRuWpdLGlAxKRqkjLwUYt
   NC2sAPzlF2eMCa3qQZLVTpO8wTRrU9Oy+sUmlCQeQlAK6NhnVuWg4myqa
   w==;
X-CSE-ConnectionGUID: 5LwvYmLCTk6SCSS83far7g==
X-CSE-MsgGUID: fgN4YZbqTaGBDLacMEEC7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="61632337"
X-IronPort-AV: E=Sophos;i="6.12,291,1728975600"; 
   d="scan'208";a="61632337"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 08:43:16 -0800
X-CSE-ConnectionGUID: 6sYrLDRiQaySabinfUYJsA==
X-CSE-MsgGUID: Hgoa4TgmTTCtmTY1unR+UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106870333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 08:43:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 5 Jan 2025 18:43:07 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
In-Reply-To: <Z3Zso3vXrzR79s2o@wunner.de>
Message-ID: <b0183c5d-3fbc-3823-e653-31e3999ca5ca@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com> <20241018144755.7875-8-ilpo.jarvinen@linux.intel.com> <Z3Zso3vXrzR79s2o@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1558070145-1736093219=:924"
Content-ID: <a86c63c4-52de-ae50-e7d1-c803f42ed965@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1558070145-1736093219=:924
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d99ca1d3-d107-6a7b-c5d2-02cd1bdca6c3@linux.intel.com>

On Thu, 2 Jan 2025, Lukas Wunner wrote:

> On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo J=E4rvinen wrote:
> > @@ -142,9 +304,11 @@ static int pcie_bwnotif_probe(struct pcie_device *=
srv)
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> > -=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> > -=09=09port->link_bwctrl =3D no_free_ptr(data);
> > -=09=09pcie_bwnotif_enable(srv);
> > +=09scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> > +=09=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> > +=09=09=09port->link_bwctrl =3D no_free_ptr(data);
> > +=09=09=09pcie_bwnotif_enable(srv);
> > +=09=09}
> >  =09}
>=20
> The "data" pointer is allocated with devm_kzalloc().
> There's no __free(kfree) anywhere.
>=20
> So what's the motivation for the no_free_ptr()?
> Is this a remnant of an earlier version of the patch set that can be dele=
ted
> or is there actually a purpose to it?

Remnant it was so it is okay to remove it in your fix.

--=20
 i.
--8323328-1558070145-1736093219=:924--

