Return-Path: <linux-pci+bounces-2925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E6845A88
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723501C23A15
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C465F48C;
	Thu,  1 Feb 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IU/9G31n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07945F491;
	Thu,  1 Feb 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798844; cv=none; b=Zv3l7lny6zbwgabwR6eOq3v5Qmoh25faaiBGp6dXFOzoEm8i7b/PQIuxf0UOwBwtElZ/0mCBffpmy/ezdGGe+HJLBbCoKPUk8h5/B4pBlrDZDgwogMCbLYZBmeWFWwQHGR0JrKxlS8hcgsjHz3kNapKSIzTT9bj/SkfX4lMy5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798844; c=relaxed/simple;
	bh=qgms/9isPo0TXHC6cRuho639q8nVW5hPrmWxyYGXX6Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lJR6qlSh2EfxQDqI7GLALhd/ilVPEfd25j2X00Vb2vwuGZPoT9mtO/7n58jilzimbcJ4kfUflKNReGdKOkLH8BQUlpCnRf7dpSUY5TTYQdipBL5nsp7B3QAyQDmrcRm3+XJliIiMQHpD3xzEO9YHtQaTLQn6E09wrl0E6bhQp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IU/9G31n; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798842; x=1738334842;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qgms/9isPo0TXHC6cRuho639q8nVW5hPrmWxyYGXX6Q=;
  b=IU/9G31nm9/5rgh15vuSaxp08Ulo93ev+f7aOUnfDp2/sacjBfcBXD8r
   0BOhUce4aNlHNzoJmk36LWsYWo1IiHwNI5eAq0ZKFLqRLRbp3qFd69RnZ
   pM0ZtkNqCJdGQFOBZj3ANmHTG9IsqV2aV7wjww6dpcB3OjBjplut22VZ8
   B2v4B8aV5J1jXsdHWOcaC4mdXM/bvayvNHQOb+p4nDJHoM/HlZr641Pu0
   2rtEsBnip8I/KFKs7YuJ8A01yFOzYidLMlvD5n5PjFcuu5NbBV54M/8E6
   zKM73RLf/tcOP9nrMKPZbECIm475wPuv3n8A/1fZogccAAnbAeTt1f9D1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407626471"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407626471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4394902"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.1])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:47:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 1 Feb 2024 16:47:14 +0200 (EET)
To: Jonathan Woithe <jwoithe@just42.net>
cc: Igor Mammedov <imammedo@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <ZbrOW/eTC0FFPjec@marvin.atrad.com.au>
Message-ID: <1ee94000-14af-3edf-10b6-acd821075d3e@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com> <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com> <ZZaiLOR4aO84CG2S@marvin.atrad.com.au> <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au> <ZajJzcquyvRebAFN@marvin.atrad.com.au>
 <Za0T_siv79qz1jkk@smile.fi.intel.com> <Za2YtnwLKKeMquv6@marvin.atrad.com.au> <62b66d58-7824-3650-6a73-12068a22563e@linux.intel.com> <20240122144520.7761c5a6@imammedo.users.ipa.redhat.com> <ZbrOW/eTC0FFPjec@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-945909834-1706798834=:1028"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-945909834-1706798834=:1028
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Feb 2024, Jonathan Woithe wrote:

> On Mon, Jan 22, 2024 at 02:45:20PM +0100, Igor Mammedov wrote:
> > On Mon, 22 Jan 2024 14:37:32 +0200 (EET)
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >=20
> > > On Mon, 22 Jan 2024, Jonathan Woithe wrote:
> > >=20
> > > > On Sun, Jan 21, 2024 at 02:54:22PM +0200, Andy Shevchenko wrote: =
=20
> > > > > On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote: =
=20
> > > > > > On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote=
: =20
> > > > > > > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wro=
te: =20
> > > > > > > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wro=
te: =20
> > > > > > > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > > > > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > >  =20
> > > > > > > > > > Hi all,
> > > > > > > > > >=20
> > > > > > > > > > Here's a series that contains two fixes to PCI bridge w=
indow sizing
> > > > > > > > > > algorithm. Together, they should enable remove & rescan=
 cycle to work
> > > > > > > > > > for a PCI bus that has PCI devices with optional resour=
ces and/or
> > > > > > > > > > disparity in BAR sizes.
> > > > > > > > > >=20
> > > > > > > > > > For the second fix, I chose to expose find_empty_resour=
ce_slot() from
> > > > > > > > > > kernel/resource.c because it should increase accuracy o=
f the cannot-fit
> > > > > > > > > > decision (currently that function is called find_resour=
ce()). In order
> > > > > > > > > > to do that sensibly, a few improvements seemed in order=
 to make its
> > > > > > > > > > interface and name of the function sane before exposing=
 it. Thus, the
> > > > > > > > > > few extra patches on resource side.
> > > > > > > > > >=20
> > > > > > > > > > Unfortunately I don't have a reason to suspect these wo=
uld help with
> > > > > > > > > > the issues related to the currently ongoing resource re=
gression
> > > > > > > > > > thread [1]. =20

> > > > Thanks, and understood.  In this case the request from Igor was=20
> > > >=20
> > > >     can you test this series on affected machine with broken kernel=
 to see if
> > > >     it's of any help in your case?
> > > >=20
> > > > The latest vanilla kernel (6.7) has (AFAIK) had the offending commi=
t
> > > > reverted, so it's not a "broken" kernel in this respect.  Therefore=
, if I've
> > > > understood the request correctly, working with that kernel won't pr=
oduce the
> > > > desired test. =20
> > >=20
> > > Well, you can revert the revert again to get back to the broken state=
=2E
> >=20
> > either this or just a hand patching as Ilpo has suggested earlier
> > would do.
>=20
> No problem.  This was the easiest approach for me and I have now done thi=
s.=20
> Apologies for the delay in getting to this: I ran out of time last Thursd=
ay.
>=20
> > There is non zero chance that this series might fix issues
> > Jonathan is facing. i.e. failed resource reallocation which
> > offending patches trigger.
>=20
> I can confirm that as expected, this patch series has had no effect on th=
e
> system which experiences the failed resource reallocation.  From syslog,
> running a 5.15.141+ kernel[1]:
>=20
>     kernel: radeon 0000:4b:00.0: Fatal error during GPU init
>     kernel: radeon: probe of 0000:4b:00.0 failed with error -12
>=20
> This is unchanged from what is seen with the unaltered 5.15.141 kernel.
>=20
> In case it's important, can also confirm that the errors related to the
> thunderbolt device are are also still present in the patched 5.15.141+
> kernel:
>=20
>     thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
>     :
>     thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
>     :
>=20
> Like the GPU failure, they do not appear in the working kernels on this
> system.
>=20
> Let me know if you would like to me to run further tests.
>=20
> Regards
>   jonathan
>=20
> [1] This is 5.15.141, patched with the series of interest here and the ha=
nd
>     patch from Ilpo.

Hi Jonathan,

Thanks a lot for testing it regardless. The end result was not a big=20
surprise given how it looked like based on the logs but was certainly=20
worth a test like Igor mentioned. The resource allocation code isn't among=
=20
the easiest to track.


--=20
 i.

--8323328-945909834-1706798834=:1028--

