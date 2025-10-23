Return-Path: <linux-pci+bounces-39184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1BC02C69
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A6C1AA561B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941F34A770;
	Thu, 23 Oct 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ4QZwDF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7334A3DA
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241395; cv=none; b=LNyllrr99XJaG1kQ/CI2+OBEKqHTb61hw+pSnTLzml8kUqeMxp5rtqRm1jLc8qaiIulZuaCUpI+AYfnjvxFEkiAeC+I4r/oZ3XLoKL9dETh2PlYK4CBvFwg26FTq99rn28eN0Ag0V/lT8cWuucnMEoL5DhkjcomI2xEaZPHV+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241395; c=relaxed/simple;
	bh=lBogzcavFia1tq1/hy2llZwqk3cknuFx94ohvomXMBA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gul78mtSnfnIRNgh/S/wIjQWwWXntgYQ3lJ1Jfs0+Oe7woPeDjxH7rols5Qjd7cNZoj1Zuw+DoWy2aEX4X4djZKYdRAt3tJQ0GBqggvwkEm/5rfeEAz9bchdQ7S1vX4xNHvK41yzNw0BBPQ2YDCzd3o1QK7FVTN2hXoGBLM3zY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ4QZwDF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761241393; x=1792777393;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lBogzcavFia1tq1/hy2llZwqk3cknuFx94ohvomXMBA=;
  b=IJ4QZwDFGetACI0MXLH1J7DUSzmGMCd+n2t3ubsIFfBYVLxCvIHp/e9K
   opbVmrk3cFLZ6mLksYedfwQ3WgsESeqTkbB/YE+JWclm2bHv3lXtgXGoE
   87q/c2wXJZ8MI0aPTxMdUcw0rsGIFRSna8LXGOaXEklEQDwnoOZdYspsC
   jALl3r8T9gIuhmbddIlbN4J2MvT3vG96Go9MnZZiiu1ziy02S0/NXTkun
   Ondjw28Bn/7rkWBa4HFv9+mVTmJdALLxKPbbrT/KzeDMbFHjh06j1uE8g
   YAiqKsIERqaWYd1kK8TTm8zU6IfIyed2+8p8wJf8eTAOj5rCT5Pi4wBS8
   w==;
X-CSE-ConnectionGUID: 9bUnEVOeTkeZJD90ax96Zg==
X-CSE-MsgGUID: BEyQD5TKTrqgrynphMRR3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63125358"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63125358"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:43:05 -0700
X-CSE-ConnectionGUID: KyhLV5dhTR+V6DJO+HlNKA==
X-CSE-MsgGUID: nkm4X9Q6SCOpy1ru1Fvulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="188280889"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:43:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 23 Oct 2025 20:42:56 +0300 (EEST)
To: Simon Richter <Simon.Richter@hogyros.de>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: BAR resizing broken in 6.18 (PPC only?)
In-Reply-To: <af2ed697-4856-4477-8da8-2838ceaf3179@hogyros.de>
Message-ID: <4fbe3ae1-0752-33f3-35c2-d81e21031f8a@linux.intel.com>
References: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de> <a5e7a118-ba70-000e-bab4-8d56b3404325@linux.intel.com> <67840a16-99b4-4d8c-9b5c-4721ab0970a2@hogyros.de> <922b1f68-a6a2-269b-880c-d594f9ca6bde@linux.intel.com>
 <af2ed697-4856-4477-8da8-2838ceaf3179@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-303087025-1761221295=:1016"
Content-ID: <256de186-4697-84cb-cf91-ad575ccac02f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-303087025-1761221295=:1016
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <395cf5de-bb93-a13b-3583-453330015155@linux.intel.com>

On Wed, 22 Oct 2025, Simon Richter wrote:
> On 10/22/25 1:20 AM, Ilpo J=E4rvinen wrote:
>=20
> > Could you please test if the patch below helps.
>=20
> Yes, this looks better.
>=20
>  - "good" is the 6.17 reference
>  - "shrink" is with this patch and the BAR0 release from Lucas
>  - "bar0" is with this patch, with the bridge BAR0 still mapped (i.e. wit=
hout
> the patch from Lucas)
>=20
> If you compare "good" vs "bar0", the differences are now fairly minimal. =
The
> non-prefetchable window has shrunk, but assignments are otherwise the sam=
e.

If a window has extra size prior to any resource fitting operation, the=20
kernel will recalculate the size based on what it knows about the=20
downstream resource sizes, no more so extra size is removed.

I thought that old_size was to prevent such shrinkage, but it is=20
problematic as we've seen here (and also in a some other cases).

It would be possible to move the max for old_size outside of align so=20
something like this instead of the patch you tested:

-       return ALIGN(max(size, old_size), align);
+       return max(ALIGN(size, align), old_size);

That would not try to make the bridge window larger due to alignment than=
=20
what the old_size was, so it should still fit to its old range keeping=20
its old size.

> I've added "lspci -v" output as well, which shows the bridge configuratio=
n.
> I'm still not sure that the address mappings between PCI and system bus a=
re
> 1:1.
>=20
> So the BAR0 release patch from Lucas seems to be no longer required with =
this,
> although it does align the prefetchable area better, so in theory it woul=
d
> allow a 512G BAR to be mapped. In practice, there are no Intel dGPUs with=
 512G
> VRAM.
>
> > There's indeed something messy and odd going on here with the resource =
and
> > window mappings, in the bad case there's also this line which doesn't m=
ake
> > much sense:
> > +pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 6=
4bit
> > pref]: can't claim; address conflict with 0030:01:00.0 [mem
> > 0x6200020000000-0x62000207fffff 64bit pref]
>=20
> > ...but that conflicting resource was not assigned in between releasing
> > this bridge window and trying to claim it back so how did that
> > conflicting resource get there is totally mysterious to me. It doesn't
> > seem related directly to the the resize no longer working though.
>=20
> That is the upstream bridge's BAR0 mapping, which is not a bridge window,=
 so
> presumably the window allocation algorithm is unaware of it.

Resource tree is independent of PCI's resource allocation algorithm. Now=20
that I look the numbers and logs again, this doesn't look valid resource=20
tree state (from iomem.good!):

6200000000000-6203fbfffffff : pciex@620c3c0000000
  6200000000000-6203fbff0ffff : PCI Bus 0030:01
    6200020000000-62000207fffff : 0030:01:00.0
    6200000000000-6203fbff0ffff : PCI Bus 0030:02
      6200400000000-62007ffffffff : PCI Bus 0030:03
        6200400000000-62007ffffffff : 0030:03:00.0

6200020000000-62000207fffff and 6200000000000-6203fbff0ffff appear as=20
siblings and those addresses conflict. It seems this "good" kernel is=20
"cheating" by double counting addresses... ;-D

I've now found the cause in part thanks to another reporter with=20
similar impossible resource conflicts (an old bug in the resizing=20
algorithm which is there since BAR resizing was introduced).

It will take me a few days to fix all this as fixing the claim issue=20
will make other domino bricks to fall so I'll have to refactor this=20
pci_resize_resource() interface now, unfortunately.

> > > It's a bit weird that there is a log message that says "enabling devi=
ce",
> > > then
> > > the BARs are reconfigured. I'd want the decoding logic to be inactive
> > > while
> > > addresses are assigned.
>=20
> > So no real issue here and only logging is not the way you'd want it?
>=20
> It works for the GPU, but I'm unsure about my FPGA designs now, for the m=
ost
> part, I would have expected that the "enable memory decoding" bit had to =
be 0
> while BAR registers are being written, and I would have expected the driv=
er to
> resize the BAR first, then enable the device.

Lucas did move resizing earlier but I guess it still occurs after enabling=
=20
the device. I don't know enough about xe driver to say how early BARs=20
could be resized.

--=20
 i.
--8323328-303087025-1761221295=:1016--

