Return-Path: <linux-pci+bounces-31525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA8AF8FE1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150AE5A026B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96052BDC2E;
	Fri,  4 Jul 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWn66K/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DF184
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624432; cv=none; b=nN/96Yb/UNpZGXPbbPZSkyzkubUD6xAdchXFW9KXGyQVx7nXJtRalbbmcgirVP4C7wmJ2hBwVoEZSeuoFqEaJwtkMXIAfS0d7/V35Q5P5A0JnlkuuZQjecqdUjH/uRPWsl2g7iBiOf+hH0rD+WLwAPmxuV91mox8wFUAoFVlXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624432; c=relaxed/simple;
	bh=ihW4iPZ31s71Gp30ze4uTJD/jIlzIo/IvlnO2kZlb8g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TjHorslEMLvmz7I7aKLp2V0IYmvC/xzmcAssmfon97McO/6msemr15VTuNvrTSvKoZEdTw5PfHiUiScbliaqvdb4W2KIIFgjMlpnsplbuCXEcXANjJjfRf+WV1JcxjX605ws7/rEhH9vzrb04HuxSMtSNcyM/3b4BknsFK2U8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWn66K/h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751624431; x=1783160431;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ihW4iPZ31s71Gp30ze4uTJD/jIlzIo/IvlnO2kZlb8g=;
  b=IWn66K/hxhwtLY7yZUj1kYuGUF31JdG0u5szsJQ8YR0TqxOrnptTu1g1
   UQshNulJS2ET07BE31obfhCoDC3i0UP2g0bgrhIfRwmWlDN5dKJgwuUoW
   H3Ba1z5CxgDwiOt3M4N1caCGgfO5onTdEAbk5ad6Kew9KD+um7R9Vz99+
   GEp86mSJnG+QHeW5wEWfTDD+mosELoo2AHoe7Z20hkQQiWBKvrBBe60id
   3Pczx2D1sa+pn1Vt24yuyjVLl556ueMJ1YHYxSb1t96D0MtywwfjBXQk/
   2nSjUk8FerzHQSfDqvJvDaDWb1aAibb1ZhWi03zICksQCG9HwNHBbuGj7
   w==;
X-CSE-ConnectionGUID: 1tno9+qWRjiSz19pY3mjJw==
X-CSE-MsgGUID: KbglQIdeQtKmQftBjU5YDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53181309"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53181309"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 03:20:30 -0700
X-CSE-ConnectionGUID: PxtMqr/jTL+Y+kt2T1Pjfg==
X-CSE-MsgGUID: sGGIYFRdSv+gTjPzg20HJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="191781782"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 03:20:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Jul 2025 13:20:24 +0300 (EEST)
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    macro@orcam.me.uk, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250703235316.17920-1-mattc@purestorage.com>
Message-ID: <62c702a7-ce9b-21b8-c30e-a556771b987f@linux.intel.com>
References: <eb43f8c8-cf36-0c94-e87d-78d8ef8efb9c@linux.intel.com> <20250703235316.17920-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1260387681-1751622904=:1116"
Content-ID: <91df46f4-71a9-bc73-508a-0f7142d27fe7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1260387681-1751622904=:1116
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <28f602c0-759b-97d7-eed6-fa3b2cc602bd@linux.intel.com>

On Thu, 3 Jul 2025, Matthew W Carlis wrote:

> On Thu, 3 Jul 2025, Ilpo J=E4rvinen wrote:
> > Is this mainly related to some artificial test that rapidly fires event=
=20
> > after another (which is known to confuse the quirk)? ...I mean, you say=
=20
> > "extremely likely".
>=20
> I wouldn't describe the test as "rapidly fires" of events because we have=
 given
> conservative delays between injections (waiting for DLLA & being able to =
perform
> IO to the nvme block device before potentially injecting again).

Okay, I asked this because I saw one other test which did hotplug add &=20
remove in millisecond timescales which was way too fast for hotplug driver=
=20
to keep up (and thus it couldn't reset LBMS often enough).

The other question still stands though, why is LBMS is not reset? Perhaps=
=20
DPC should clear LBMS in some places (that is, call pcie_reset_lbms()).=20
Have you consider that?

(It sound to me you're having this occur in multiple scenarios and I've=20
some trouble on figuring those out from your long descriptions what those=
=20
exactly are so it's bit challenging for me to suggest where it should be=20
done but I the surprise down certainly seems like case where LBMS=20
information must have become stale so it should be reset which would=20
prevent quirk from setting 2.5GT/s).

> In any case
> the testing results are clearly worse when moving from a kernel that didn=
't
> have the quirk to a kernel that does which is a regression in my mind.
>=20
> > I suppose when the problem occurs and the bridge remains at 2.5GT/s, is=
 it=20
> > possible to restore the higher speed using the pcie_cooling device=20
> > associated with the bridge / bwctrl? You can find the correct cooling=
=20
> > device with this:
>=20
> Yes the problem is when a device is forced to 2.5GT/s and it should not h=
ave
> been. I did not test with the patches for CONFIG_PCIE_THERMAL because our=
 drives
> would not need thermal management by the kernel,

Fine, but all it technically does is exposes interface to bwctrl set speed=
=20
API, the pcie_thermal driver itself agnostic to whether userspace uses=20
that for thermal management or some other purpose. There's no kernel side=
=20
thermal management in that driver. It was just more natural to expose it=20
there than inside PCI subsystem.

> but if I use "setpci" to
> restore TLS & then write the link retrain bit the link would arrive at th=
e
> maximum speed (Gen3/Gen4/Gen5 depending).
>
> I have other vendor drives as well, but we design and build our own drive=
s
> with our own firmware & therefore are able to determine from firmware log=
ging
> in the drive when the link was most likely guided to 2.5GT/s by TLS. We a=
re
> also able to see the 2.5GT/s value in the TLS register when it happens. I=
 have
> less visibility into drives from other vendors in terms of ltssm transiti=
ons
> without hooking up an analyzer.
>=20

--=20
 i.
--8323328-1260387681-1751622904=:1116--

