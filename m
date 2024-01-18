Return-Path: <linux-pci+bounces-2313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4E8315C8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD761F27EBD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D21BC55;
	Thu, 18 Jan 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCN3Zo1T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178381F610;
	Thu, 18 Jan 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570072; cv=none; b=BB+osyaSS81eDAZgCrjYZOzAAHp/n81bJrzRgmP48maqbPyz0XUa88xxR3mOeNV8SqcF6gbPCQkp1vbFCVIsV9mc/uFQ0SdPtzo+jKabvkGXqtskX+rtpTF06rcXXPykesnrG5TIRCrv9AIj00Szwd5/Fp/UWKBXcw/0OZVP0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570072; c=relaxed/simple;
	bh=We42sBxpYqbo9Mmli+qZoQhq0Gf1SBcgshlP/yaPCZI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type; b=EwD2l8gOo0HrAoD9ok/V0Q4UaTs6rmX5rSvYQ1vunwAVy7FEUc2xo/V7WRkxMXlXjLOmVLrv+7UnoRDok5fz9ZpfYcW/0P6WLtrgm/x8a044L1zEN6pk1HHTZ1TKxlARBoKu5LaIm0dVrm2MdaCfWnW3HYMBVsjaBtTo9YiM8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCN3Zo1T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705570071; x=1737106071;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=We42sBxpYqbo9Mmli+qZoQhq0Gf1SBcgshlP/yaPCZI=;
  b=OCN3Zo1TlF53xTXL0YUuifxwi3J35Tel+ySBbry0tnkHBiF1ioflGTUX
   eEyKmtqtne5SUUTiL+1Gs6VxhVRTJJJRz4ANDFcO0bFpzEZxwKU0VwMZZ
   LIPNMMj+39Skq+efN9uBmaIRP6PmNPBLZTPcnXH85JWxh93yym6B3UzL2
   AG9sTDHbf8l8a/fEnlrnIrswyldF6uKnL2REfrXFT/6yKyrCYpF4vuFTi
   aFmDy3ZXzR/QePPpkmv5EAhxxFUCEHKVLfm/mnTKtyysrOEsa7BDHo9Ye
   scevbUgZLCJVhKLD94a9mv8lVoF1ezNxjBegZb3bUACQJbIE5UW8WKd/X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="293169"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="293169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 01:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="26727893"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.254.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 01:27:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jan 2024 11:27:41 +0200 (EET)
To: Jonathan Woithe <jwoithe@just42.net>
cc: Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <ZajJzcquyvRebAFN@marvin.atrad.com.au>
Message-ID: <c930a6db-f1cd-88e2-03b5-9280b755df08@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com> <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com> <ZZaiLOR4aO84CG2S@marvin.atrad.com.au> <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au> <ZajJzcquyvRebAFN@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1115935032-1705570061=:1058"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1115935032-1705570061=:1058
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Jan 2024, Jonathan Woithe wrote:

> On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:
> > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > Here's a series that contains two fixes to PCI bridge window sizi=
ng
> > > > > algorithm. Together, they should enable remove & rescan cycle to =
work
> > > > > for a PCI bus that has PCI devices with optional resources and/or
> > > > > disparity in BAR sizes.
> > > > >=20
> > > > > For the second fix, I chose to expose find_empty_resource_slot() =
from
> > > > > kernel/resource.c because it should increase accuracy of the cann=
ot-fit
> > > > > decision (currently that function is called find_resource()). In =
order
> > > > > to do that sensibly, a few improvements seemed in order to make i=
ts
> > > > > interface and name of the function sane before exposing it. Thus,=
 the
> > > > > few extra patches on resource side.
> > > > >=20
> > > > > Unfortunately I don't have a reason to suspect these would help w=
ith
> > > > > the issues related to the currently ongoing resource regression
> > > > > thread [1].
> > > >=20
> > > > Jonathan,
> > > > can you test this series on affected machine with broken kernel to =
see if
> > > > it's of any help in your case?
> > >=20
> > > Certainly, but it will have to wait until next Thursday (11 Jan 2024)=
=2E  I'm
> > > still on leave this week, and when at work I only have physical acces=
s to
> > > the machine concerned on Thursdays at present.
> > >=20
> > > Which kernel would you prefer I apply the series to?
> >=20
> > I was very short of time today but I did apply the above series to the
> > 5.15.y branch (since I had this source available), resulting in version
> > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
> > bisect reset, so the resulting kernel was not correctly built.  It boot=
ed
> > but thought it was a different version and therefore none of the module=
s
> > could be found.  As a result, the test is invalid.
> >=20
> > I will try again in a week when I next have physical access to the syst=
em.=20
> > Apologies for the delay.  In the meantime, if there's a specific kernel=
 I
> > should apply the patch series against please let me know.  As I underst=
and
> > it, you want it applied to one of the kernels which failed, making 5.15=
=2Ey
> > (for y < 145) a reasonable choice.
>=20
> I did a "make clean" to reset the source tree and recompiled.  However, i=
t
> errored out:
>=20
>   drivers/pci/setup-bus.c:988:24: error: =E2=80=98RESOURCE_SIZE_MAX=E2=80=
=99 undeclared
>   drivers/pci/setup-bus.c:998:17: error: =E2=80=98pci_bus_for_each_resour=
ce=E2=80=99 undeclared
>=20
> This was with the patch series applied against 5.15.141.  It seems the pa=
tch
> targets a kernel that's too far removed from 5.15.x.
>=20
> Which kernel would you like me to apply the patch series to and test?

Two argument version of pci_bus_for_each_resource() is quite new (so=20
either 6.6 or 6.7). If want to attempt to compile in 5.15.x, you need=20
this:

include/linux/limits.h:#define RESOURCE_SIZE_MAX        ((resource_size_t)~=
0)

And to add one extra argument into pci_bus_for_each_resource(bus, r) in=20
pbus_upstream_assigned_limit():

=09...
=09while ((bus =3D bus->parent)) {
+=09=09unsigned int i;
=09=09if (pci_is_root_bus(bus))
=09=09=09break;

-=09=09pci_bus_for_each_resource(bus, r) {
+=09=09pci_bus_for_each_resource(bus, r, i) {

Note I've written this "patch" by hand inline so patch command cannot=20
apply it but you need to edit those in.


--=20
 i.

--8323328-1115935032-1705570061=:1058--

