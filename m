Return-Path: <linux-pci+bounces-2416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6029836381
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6874B2A834
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD13A8C4;
	Mon, 22 Jan 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnJqEA5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF33D0A4;
	Mon, 22 Jan 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927064; cv=none; b=isUoaOmQXRtNx10qty/OqzVetiPHAAwGeeXgl6VZqECbWPJH2I+OV/YtteRJC3vKEJr91TR816GfstOds34+8S7Q7It+eIdfVNd4hJzCPa2Hfa050H4UNxjIdtFKsILtRAW5sr2hcAoDMsuGkG+tvVHqom0eFLPy1F9uI/MqVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927064; c=relaxed/simple;
	bh=zZ7VyaY9jknU4h6LzfcJIs/cUxR9mreT6SqqwuqVAtk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uK0fdrk/d8jgtN3Q7kD0/2TP6lP2TCeXyWtkTgeZQ17YKiSYNsy3586m9oqIE3QDjoE+FI8oBX77wqacpAl5yeaO8GtBoulEJz9xeaGGVWbsEngqtvkDjzmE38IPftZYFKotAfI1i0EqXXVH2QIm21mev8y4fsT5znnfyCqC3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnJqEA5P; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705927062; x=1737463062;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zZ7VyaY9jknU4h6LzfcJIs/cUxR9mreT6SqqwuqVAtk=;
  b=WnJqEA5PkKC0c3ng30TKjUveovo+bQylu08DcEx5fWN21K7In5obl4B/
   SdLLGPtu4PE7fOT3HC+2owsvUmRWWs4FEiapFF/xwzIi3ujDKqW+ZQ4F4
   Iwl8zb0F21aycFUiiVE36D+7HW9ql/6SRbcQp2q+Q0C2tnybbbjxmtfuu
   mdXYItm/zt6/o8dRZ1/zRl8MNnwFrduV/ytK7Syyzt8diEPFzFbHdfw+T
   dM2T3u/+k0rUvkOgvlJvaRUysvBzNlb8CfTVrRZ2g1CjNFxocOcbAfpXH
   04EklTdnnv12hgVDJj0EgL39C97+py+zshaSPOe2nxkjOIdNTADr31j/T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="465459070"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="465459070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1273050"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.150])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:37:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Jan 2024 14:37:32 +0200 (EET)
To: Jonathan Woithe <jwoithe@just42.net>
cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <Za2YtnwLKKeMquv6@marvin.atrad.com.au>
Message-ID: <62b66d58-7824-3650-6a73-12068a22563e@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com> <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com> <ZZaiLOR4aO84CG2S@marvin.atrad.com.au> <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au> <ZajJzcquyvRebAFN@marvin.atrad.com.au>
 <Za0T_siv79qz1jkk@smile.fi.intel.com> <Za2YtnwLKKeMquv6@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-707510617-1705927052=:994"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-707510617-1705927052=:994
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 Jan 2024, Jonathan Woithe wrote:

> On Sun, Jan 21, 2024 at 02:54:22PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote:
> > > On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:
> > > > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> > > > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > > > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > >=20
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > Here's a series that contains two fixes to PCI bridge window =
sizing
> > > > > > > algorithm. Together, they should enable remove & rescan cycle=
 to work
> > > > > > > for a PCI bus that has PCI devices with optional resources an=
d/or
> > > > > > > disparity in BAR sizes.
> > > > > > >=20
> > > > > > > For the second fix, I chose to expose find_empty_resource_slo=
t() from
> > > > > > > kernel/resource.c because it should increase accuracy of the =
cannot-fit
> > > > > > > decision (currently that function is called find_resource()).=
 In order
> > > > > > > to do that sensibly, a few improvements seemed in order to ma=
ke its
> > > > > > > interface and name of the function sane before exposing it. T=
hus, the
> > > > > > > few extra patches on resource side.
> > > > > > >=20
> > > > > > > Unfortunately I don't have a reason to suspect these would he=
lp with
> > > > > > > the issues related to the currently ongoing resource regressi=
on
> > > > > > > thread [1].
> > > > > >=20
> > > > > > Jonathan,
> > > > > > can you test this series on affected machine with broken kernel=
 to see if
> > > > > > it's of any help in your case?
> > > > >=20
> > > > > Certainly, but it will have to wait until next Thursday (11 Jan 2=
024).  I'm
> > > > > still on leave this week, and when at work I only have physical a=
ccess to
> > > > > the machine concerned on Thursdays at present.
> > > > >=20
> > > > > Which kernel would you prefer I apply the series to?
> > > >=20
> > > > I was very short of time today but I did apply the above series to =
the
> > > > 5.15.y branch (since I had this source available), resulting in ver=
sion
> > > > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after=
 the
> > > > bisect reset, so the resulting kernel was not correctly built.  It =
booted
> > > > but thought it was a different version and therefore none of the mo=
dules
> > > > could be found.  As a result, the test is invalid.
> > > >=20
> > > > I will try again in a week when I next have physical access to the =
system.=20
> > > > Apologies for the delay.  In the meantime, if there's a specific ke=
rnel I
> > > > should apply the patch series against please let me know.  As I und=
erstand
> > > > it, you want it applied to one of the kernels which failed, making =
5.15.y
> > > > (for y < 145) a reasonable choice.
> > >=20
> > > I did a "make clean" to reset the source tree and recompiled.  Howeve=
r, it
> > > errored out:
> > >=20
> > >   drivers/pci/setup-bus.c:988:24: error: =E2=80=98RESOURCE_SIZE_MAX=
=E2=80=99 undeclared
> > >   drivers/pci/setup-bus.c:998:17: error: =E2=80=98pci_bus_for_each_re=
source=E2=80=99 undeclared
> > >=20
> > > This was with the patch series applied against 5.15.141.  It seems th=
e patch
> > > targets a kernel that's too far removed from 5.15.x.
> > >=20
> > > Which kernel would you like me to apply the patch series to and test?
> >=20
> > The rule of thumb is to test against latest vanilla (as of today v6.7).
> > Also makes sense to test against Linux Next. The v5.15 is way too old f=
or
> > a new code.
>=20
> Thanks, and understood.  In this case the request from Igor was=20
>=20
>     can you test this series on affected machine with broken kernel to se=
e if
>     it's of any help in your case?
>=20
> The latest vanilla kernel (6.7) has (AFAIK) had the offending commit
> reverted, so it's not a "broken" kernel in this respect.  Therefore, if I=
've
> understood the request correctly, working with that kernel won't produce =
the
> desired test.

Well, you can revert the revert again to get back to the broken state.

--=20
 i.

--8323328-707510617-1705927052=:994--

