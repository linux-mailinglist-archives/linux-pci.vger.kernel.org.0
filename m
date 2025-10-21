Return-Path: <linux-pci+bounces-38876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE73BF657F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E0F503854
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94432E74D;
	Tue, 21 Oct 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A51CNLfJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DB32E751;
	Tue, 21 Oct 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047654; cv=none; b=EGsk2FylYcQT9oz0jex7hESusIj+AQuGikaeDhqoa4fUjvNJUnznkPVJc40bd8zzuziJeVJP+VQxqGqCwHSqM9VU9CzbJTO/Wz0lnjGI4P8dRVf3uhCKltv/rpb1xpUU6Y6kQd2IlT1m5U9Lynt233yms7jFYppIzAzfdkmLOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047654; c=relaxed/simple;
	bh=NZk6FzYyPgktN8AE2X0boqJh/igLJoMr8CzDe5TE4gc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sZHOKoCAAukDAXwNmFQBUR3dayn8clb0CpKX1oJ03IkdDUI3uOftnXQnAH90P17DKnxxhY5YIw6IiNvsF/ZYEDiOzK2TI2fd39gRVqdr4/x3k7wGFxrg4YlH6SFUaZIqgiuDOglfVedghlRB6jRP98uUS8FjXVZDxLlTeuanEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A51CNLfJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761047653; x=1792583653;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=NZk6FzYyPgktN8AE2X0boqJh/igLJoMr8CzDe5TE4gc=;
  b=A51CNLfJZSOF0CzIixiPsTF2hZrO8Yhi9JxbHauP6S5W6w6N3icosVra
   XJAKtliPmtnB9iyHycXJFUH/4ou8ZrqOf/LlUkHN+QwpyiurYOEmUr0Hf
   MmaBB1OSMRuKlKl1yPll822DDe16P7SPfkZtm3ns8lJciEgjT5AQVQP4M
   mRXgBq5limGSI6TK0ykDvxLTpAh1A8g7h8ImRnFpMFjeKAxcIeVNnwYdj
   6j5bMguydmGbGcWDXow5uHNzrz4ykXdsQSCqpRvj9moHtpZ6TJFwVkkEv
   GwITo6bNunPbOwi7tnUBVISVmoKlBcC80n4y5rJitDcSNzg4EUBSwO1g4
   Q==;
X-CSE-ConnectionGUID: Aiyqt2GaTp+Wt5a1e56Ihw==
X-CSE-MsgGUID: PnX00FIwT/ieXkH9mtkvhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67034159"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="67034159"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:54:11 -0700
X-CSE-ConnectionGUID: EQOowvvQT1GyHOysqBCiOA==
X-CSE-MsgGUID: aRI1h1gMSgm5XxtDU1tgkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="188858336"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:54:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 14:54:03 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
In-Reply-To: <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
Message-ID: <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com> <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
 <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-761772981-1761047235=:1018"
Content-ID: <be4122cc-61a7-0fd5-7aee-a1b39006f834@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-761772981-1761047235=:1018
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <06826fd2-8c64-87f6-cce8-f57e075e7dc6@linux.intel.com>

On Tue, 21 Oct 2025, Geert Uytterhoeven wrote:
> On Mon, 20 Oct 2025 at 18:20, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> > > On Fri, 10 Oct 2025 at 16:42, Ilpo J=E4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > Here's a series for Geert to test if this fixes the improper coales=
cing
> > > > of resources as was experienced with the pci_add_resource() change =
(I
> > > > know the breaking change was pulled before 6.18 main PR but I'd wan=
t to
> > > > retry it later once the known issues have been addressed). The expe=
cted
> > > > result is there'll be two adjacent host bridge resources in the
> > > > resource tree as the different name should disallow coalescing them
> > > > together, and therefore BAR0 has a window into which it belongs to.
> > > >
> > > > Generic info for the series:
> > > >
> > > > PCI host bridge windows were coalesced in place into one of the str=
ucts
> > > > on the resources list. The host bridge window coalescing code does =
not
> > > > know who holds references and still needs the struct resource it's
> > > > coalescing from/to so it is safer to perform coalescing into entire=
ly
> > > > a new struct resource instead and leave the old resource addresses =
as
> > > > they were.
> > > >
> > > > The checks when coalescing is allowed are also made stricter so tha=
t
> > > > only resources that have identical the metadata can be coalesced.
> > > >
> > > > As a bonus, there's also a bit of framework to easily create kunit
> > > > tests for resource tree functions (beyond just resource_coalesce())=
=2E
> > > >
> > > > Ilpo J=E4rvinen (3):
> > > >   PCI: Refactor host bridge window coalescing loop to use prev
> > > >   PCI: Do not coalesce host bridge resource structs in place
> > > >   resource, kunit: add test case for resource_coalesce()
> > >
> > > Thanks for your series!
> > >
> > > I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> > > Mark resources IORESOURCE_UNSET when outside bridge windows"), and
> > > gave it a a try on Koelsch (R-Car M2-W).
> >
> > So the pci_bus_add_resource() patch to rcar_pci_probe() was not include=
d?
> > No coalescing would be attempted without that change.
>=20
> Sorry, I didn't realize you wanted that (and anything else) to be
> included, too.  Please tell me the exact base I should use for testing,
> and I will give it another run.

I'm sorry, it's indeed a bit confusing as some of these patches never=20
have been in Linus' tree.

So I'm interested on what's the result with these changes/series together:

[PATCH 1/2] PCI: Setup bridge resources earlier=20
[PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET=
=20
[PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources
[PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use prev=20
[PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
[PATCH 3/3] resource, kunit: add test case for resource_coalesce()

You might also want to change that pci_dbg() in the IORESOURCE_UNSET patch=
=20
to pci_info() (as otherwise dyndbg is necessary to make it visible).

Lore links to these series/patches:

https://lore.kernel.org/linux-pci/20250924134228.1663-1-ilpo.jarvinen@linux=
=2Eintel.com/
https://lore.kernel.org/linux-pci/7640a03e-dfea-db9c-80f5-d80fa2c505b7@linu=
x.intel.com/
https://lore.kernel.org/linux-pci/20251010144231.15773-1-ilpo.jarvinen@linu=
x.intel.com/

The expected result is that those usb resources are properly parented and=
=20
the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together (as=
=20
that would destroy information). So something along the lines of:

    ee080000-ee08ffff : pci@ee090000
      ee080000-ee080fff : 0000:00:01.0
        ee080000-ee080fff : ohci_hcd
      ee081000-ee0810ff : 0000:00:02.0
        ee081000-ee0810ff : ehci_hcd
    ee090000-ee090bff : ee090000.pci pci@ee090000

--=20
 i.
--8323328-761772981-1761047235=:1018--

