Return-Path: <linux-pci+bounces-6485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362AF8AB1AC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6344B1C22E28
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DD12F361;
	Fri, 19 Apr 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS0Ip06S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87912F59D
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540000; cv=none; b=WrF19a/l2mAGVnTdhfs0GVZd6Hii3xoV5gihW569Slv4p3Xir/uVQGaKr7cOuyu6In5qZrqI/TjT0jfzUvuBiDFDAHOCDzV7L9cxhUiwDpmx2blUqdpNGIBeBpqo/pkyL0Ult5K3jr/gYxLTT7icuS+t+7wZrL6pbIYTpQe+4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540000; c=relaxed/simple;
	bh=qhOE3Yb7V3JQqVSIsrx3PWiHzh7iX0+BAa9qNUG7gcE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MJn124nPfSXg/CEUQeetBt66WuIyikfLSOORPE3NVZtWa5DRBwBpdDh8nMgjxlBTKHi1JJ3qIkQLAB561UqSKG0e8rscbyBP9XK0kvDdyFIWYzENDJ1l5Lw2G6o83dJm/Di+Dgm+bwhkqFTg57Zcre+rtEZ84PujFcbNQwtcrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MS0Ip06S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713539999; x=1745075999;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qhOE3Yb7V3JQqVSIsrx3PWiHzh7iX0+BAa9qNUG7gcE=;
  b=MS0Ip06S6xFixwZwxxnnpxXdBiENg18PCIMZHWzjSB/tDN6a1AGC6a4C
   0idgHQEaP70To4CdWbFKixhcGl1Nf3z80oItQdQ8saP6d61CJX6LtyqwM
   9SbIu7r64VfD58a/tJeKBXIW6Uz7mDNkfbxAslPgTnNd4ii/ekVvCDy1y
   j0Ahnvu8YbVd4W6E8t7f+t/x3axxteO1bf0mrRUC25PuKkUhD/ePftc7z
   dgnm+ZrgNSoX4ImqDs3aCa599SIfPW3UIkzjEBgSnUIGSKT3z6H0RwGbW
   lwsLc4oDMJp91fI4mXRXzBZU6XTxpcYKAKKn26vTl4/Xi6yXBap4qr154
   g==;
X-CSE-ConnectionGUID: f0gxYni/THOS5WGY7ep+fw==
X-CSE-MsgGUID: 6oafxXmYTlicL8XMYOmI4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34543257"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="34543257"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 08:19:58 -0700
X-CSE-ConnectionGUID: GkS7RgS9SLOLNcMIbPuoKA==
X-CSE-MsgGUID: aBKENOgkRw+7jzZ6VFUKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28014288"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.38])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 08:19:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 19 Apr 2024 18:19:50 +0300 (EEST)
To: Dag B <dag@bakke.com>
cc: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
In-Reply-To: <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
Message-ID: <815337f1-920f-b2ad-7f28-b1b366eb23f5@linux.intel.com>
References: <20240417151313.GA202307@bhelgaas> <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com> <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com> <fbc9f2c1-2e5a-4611-801e-f055e6042897@amd.com> <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1106066836-1713539990=:1032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1106066836-1713539990=:1032
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Apr 2024, Dag B wrote:
> On 18.04.2024 14:24, Christian K=C3=B6nig wrote:
> > Am 18.04.24 um 12:42 schrieb Dag B:
> > >=20
> > > [SNIP]
> > > >=20
> > > > > >=20
> > > > > > Is there a good ELI13 resource explaining how resizable BAR wor=
ks in
> > > > > > Linux?
> > > > > >=20
> > > > > > My current kernel command-line contains: pci=3Dassign-busses,re=
alloc
> > > >=20
> > > > That's a really really bad idea. The "assign-busses" flag was intro=
duced
> > > > to get 20year old laptops to see their cardbus PCI devices.
> > >=20
> > > I threw a lot of mud at the wall to see what stuck. Removing it now d=
id
> > > not make a big difference.
> > >=20
> > > Removing realloc prevents the second TB3 GPU from being initialized, =
so
> > > keeping that for now.
> >=20
> > That's really interesting. Why does it fail without that?
> >=20
> > It basically means that your BIOS is somehow broken and only the Linux =
PCI
> > subsystem is able to assign resources correctly.
> >=20
> > Please provide the output of "sudo lspci -v" and "sudo lspci -tv" as fi=
le
> > attachment (*not* inline in a mail!).
>=20
>=20
> In case I have expressed myself awkwardly, the realloc=3Doff case appears=
 to
> make the device driver have issues with the second GPU.
>=20
>=20
> I have attached both outputs, for realloc=3Doff.
>=20
> Not knowing what is considered acceptable message sizes on this m/l, I
> uploaded the same for realloc=3Don, as well as output from dmesg for both=
 cases
> to:
>=20
> https://github.com/dagbdagb/p53
>=20
> If the m/l has mechanisms to archive attachments and replace them with li=
nks,
> I'll redo the exercise in a follow-up email. I understand the value of ha=
ving
> the 'context' of the discussion readily available in one place.

The mem BAR & bridge window configuration is identical between=20
realloc=3Don/off.

The error seems to relate to io BAR:

[    2.782439] nvidia 0000:09:00.0: BAR 5 [io  0x0000-0x007f]: not claimed;=
 can't enable device
[    2.783139] NVRM: pci_enable_device failed, aborting

With realloc=3Don, the entire IO window is disabled for the bridges and for=
=20
some reason nvidia doesn't abort in that case.

--=20
 i.

--8323328-1106066836-1713539990=:1032--

