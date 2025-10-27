Return-Path: <linux-pci+bounces-39436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C62C0E30B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C543742637B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3F304975;
	Mon, 27 Oct 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3c5tLKZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D02F616B;
	Mon, 27 Oct 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572964; cv=none; b=P/b/w6ArxijGbw3L3KwHuHAJSilRvj9NbCyM2X25X9X47iKiMjoCV69JBPmTCDAt/zfdl7CsOFLtR0WuVCSXXWId+Rqf853rvSiMaFY4McnCvyvK3WlhoNYWBEpJbHi+dzJsqz2kcs2+Ce/AMQVzaKzmqwgqEwnAiyR93A5qj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572964; c=relaxed/simple;
	bh=CL3sxj2TOJ4ssp9gpSjQGlP6IRcPbLwIs43eMoTBK3A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MOk0XB/30HzSdEAD8ec1WQ+jorKDT1EkHGqtjTx7xSGEB+u5oNDL9ps58DGFIlE83HHtocYNBg0JhSosVWOknmVPlI0bQn8rppI8WCfqcjKwxm5k6BXP2dJnB8Tr0/D9LCXcf8Phm6dI07gsENWsNqsYnb1WRH0mR1X7fOixTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3c5tLKZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761572963; x=1793108963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CL3sxj2TOJ4ssp9gpSjQGlP6IRcPbLwIs43eMoTBK3A=;
  b=I3c5tLKZEHAjlWlV6U/t/9lvMlKCKLbMIX/OZQH+cHzuFTbOAHTYgKsf
   McYhnjNyEIkDRYDZpCuB/aPxo1VJXPK0XcUeQmIqt5I5xKZrx9CHVFprc
   SMpHS62LcUlK63pCgU/UniCLvVm5wTbD9w+1SNZXX3ODXWHgpA+tAhgQ8
   /vUEWI+c0B7khaH+QZUhtq+J1odiuG8QuqpvytM2OWp+po5iJwANE07dB
   pnFt1cC+LAQvpSDn5hS3KOveGrY2auvQeSkxRYgQFUELwsIZg30ENi6BK
   lw3e2uvLEZzb+OYIdrfvhJqS7UIdjr3mPwYxHnfihLV3d3HVrJwg37Yek
   g==;
X-CSE-ConnectionGUID: RU5nkiIJS2qRFJomah7DIw==
X-CSE-MsgGUID: 0eap5wEdTEGSIjM9Yp9TZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63574863"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63574863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:49:22 -0700
X-CSE-ConnectionGUID: E7bQscSiT1CELxF72xsJzg==
X-CSE-MsgGUID: jcklHb9tSlStkEjQP/FhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184942814"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:49:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Oct 2025 15:49:14 +0200 (EET)
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, kw@linux.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    lucas.demarchi@intel.com, rafael.j.wysocki@intel.com, 
    Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <81fd91f2-638c-466d-9b27-705a44632713@gmail.com>
Message-ID: <3d626c68-8e63-7e5b-a08a-c47845ee06eb@linux.intel.com>
References: <20251017185246.GA1040948@bhelgaas> <702c4ad7-508b-42de-9dc3-40e4a0fe7bd7@gmail.com> <b3a49920-1cff-4ea2-519a-318030ba8797@linux.intel.com> <81fd91f2-638c-466d-9b27-705a44632713@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1426142950-1761572954=:970"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1426142950-1761572954=:970
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Oct 2025, Bhanu Seshu Kumar Valluri wrote:
> On 21/10/25 00:16, Ilpo J=C3=A4rvinen wrote:
> > On Sat, 18 Oct 2025, Bhanu Seshu Kumar Valluri wrote:
> >=20
> >> On 18/10/25 00:22, Bjorn Helgaas wrote:
> >>> On Fri, Oct 17, 2025 at 11:52:58PM +0530, Bhanu Seshu Kumar Valluri w=
rote:
> >>>>
> >>>> I want to report that this PATCH also break PCI RC port on TI-AM64-E=
VM.
> >>>>
> >>>> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up br=
idge resources earlier")
> >>>>
> >>>> Happy to help if any testing or logs are required.
> >>>
> >>> Thanks for the report!  Can you test this patch?
> >>>
> >>>   https://patch.msgid.link/20251014163602.17138-1-ilpo.jarvinen@linux=
=2Eintel.com
> >>>
> >>> That patch is queued up as
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?i=
d=3D469276c06aff
> >>> and should appear in v6.18-rc2 on Sunday if all goes well.
> >>>
> >>> If that doesn't work, let us know and we'll debug this further.
> >>
> >> I applied above patch on top of commit f406055cb18c ("Merge tag 'arm64=
-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
> >>
> >> Did pci rescan and run kselftest (pci_endpoint_test). It is working.
> >>
> >> Thanks for the patch.
> >=20
> > Thanks for testing the revert.
> >=20
> >> Happy to help if any testing or logs are required.
> >=20
> > I'd be interested to understand what goes wrong with the change I was=
=20
> > trying to make as I want to attempt the same change later, but with all=
=20
> > known issues solved by supporting changes, obviously :-).
> >=20
> > The log snippets you provided are unfortunately too short to contain al=
l=20
> > the necessary information (missing e.g. root bus resources and possibly=
=20
> > other helpful details).
> >=20
> > So if you could provide dmesg and /proc/iomem contents from broken and
> > working (with the revert) cases to let me easily compare them, that wou=
ld=20
> > help. Please take the dmesg with dyndbg=3D"file drivers/pci/*.c +p" on=
=20
> > kernel's cmdline.
> >=20
> > No further actions needed beyond that until later if I need to test som=
e=20
> > of those supporting changes before retrying all this in the mainline. I=
t=20
> > may take some time, even more than one kernel cycle as there have been=
=20
> > quite many regressions.
> >=20
> >=20
> Hi
>=20
> I captured logs with dyndbg=3D"file drivers/pci/*.c +p. See the links bel=
ow.
>=20
> Working kernel logs
> https://github.com/bhanuseshukumar/kernel_logs/blob/main/working_log
>=20
> Non Working kernel logs
> https://github.com/bhanuseshukumar/kernel_logs/blob/main/not_working_log
>=20
> Happy to help if any testing or logs are required.

Could you try if booting with pci=3Drealloc helps? (It might be that it is=
=20
ineffective like I saw in some other case.)

And also test if this old size removal patch helps:

https://lore.kernel.org/linux-pci/922b1f68-a6a2-269b-880c-d594f9ca6bde@linu=
x.intel.com/


--=20
 i.

--8323328-1426142950-1761572954=:970--

