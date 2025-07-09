Return-Path: <linux-pci+bounces-31760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB09AFE480
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFAE4A1139
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3913287274;
	Wed,  9 Jul 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swbcd7oV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2F287244
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054343; cv=none; b=EmM+FUyckKbmN7HOpnEIhexHWfpzL4zAnrcIu1otdL2CNlmXnpZ86G7wXvprKtOaFBn3NNS5KGS3LItYqY0OxfM5fKCfdAjDhT84jNyaZMxWtjx5hE16sEi0KyM16Y/WCOgsbb3U1xJRLyOYJZ6q1ZrQkHqRv9UMAeG2hPj232E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054343; c=relaxed/simple;
	bh=o6/CupmZZi2gGUgqDKjUsX9/QWbH+USO+WojB4mLrkM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B0rZofnmmjKze28MeK1VQRQAJX/+wcj6sclhoHRNJ4YnYrYh3m8epa/C6De/Ybmdr9I96lzQZSvOHrK8QZz+71ORZCRG1KxE52OXxMP+l0WkFiZ8/42tuvp+FNQnt6A8ie/wOx0QBIltzY+HLiYTzbrcUUt27b5x7IhYPsbWxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swbcd7oV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752054342; x=1783590342;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o6/CupmZZi2gGUgqDKjUsX9/QWbH+USO+WojB4mLrkM=;
  b=Swbcd7oV/GDbxvciUV0IhyQ8utFqEj4aSIQTFFqZYdBo5RslfRAm0B5m
   tr4MRWmI/j2YrJlWwaQE2HCn0y7dlX3JuJkhenaLNUCpm1j/A/wo+X3NG
   unvwReshK2GQRBYq7fHBeCuzQahcD0q/ScF6QcvEztf1vdgVT3nl4pg4U
   qG1RYJxVEj3nXyVhZBxOy3BuXRroDJbiUt/ShjmYi/r6uHiDKcGl4CPfg
   N4JBITo4LPHRELT5yfhxDoyRg/JupFAdDL6RgH82u1T23InDCYgwjMqCB
   +vUQXXYZnR4e2eYfXiS4UO0uZ3WDo1WhfpW8yTe5b4E1Otp4Vok7vipT/
   w==;
X-CSE-ConnectionGUID: Kuu+Nd9cTH6+zlPN2ZhmRg==
X-CSE-MsgGUID: 7mowzA6sSnm85svTmrAwmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54452844"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54452844"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:45:41 -0700
X-CSE-ConnectionGUID: D47BdDJkQAiZrvKmO/LsgQ==
X-CSE-MsgGUID: vU56ngHwTdC48aKNliWKCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155367268"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:45:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Jul 2025 12:45:35 +0300 (EEST)
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    macro@orcam.me.uk, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250708224917.7386-1-mattc@purestorage.com>
Message-ID: <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com>
References: <62c702a7-ce9b-21b8-c30e-a556771b987f@linux.intel.com> <20250708224917.7386-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1812599662-1752054335=:1149"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1812599662-1752054335=:1149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 Jul 2025, Matthew W Carlis wrote:

> On Fri, 4 Jul 2025, Ilpo J=C3=A4rvinen wrote:
> > The other question still stands though, why is LBMS is not reset? Perha=
ps=20
> > DPC should clear LBMS in some places (that is, call pcie_reset_lbms()).=
=20
> > Have you consider that?
>=20
> Initially we started to observe this when physically removing and
> reinserting devices in a kernel version with the quirk, but without the b=
andwidth
> controller driver. I think there is a problem with any place where the li=
nk
> would be expected to go down (dpc, hpc, etc) & then carrying forward LBMS
> into the next time the link comes up.

Are you saying there's still a problem in hpc? Since the introduction of=20
bwctrl, remove_board() in pciehp has had pcie_reset_lbms() (or it's=20
equivalent).

As I already mentioned, for DPC I agree, it likely should reset LBMS=20
somewhere.

We also clear LBMS after retraining to not retain that LBMS beyond the=20
completion of the retraining.

What other things are included into that "etc"?

> Should it not matter how long ago LBMS
> was asserted before we invoke a TLS modification?

To some extent, yes, which is why we call pcie_reset_lbms() in a few=20
places.

> It also looks like card
> presence is enough for the kernel to believe the link should train & ente=
r
> the quirk function without ever having seen LNKSTA_DLLLA or LNKSTA_LT.

Without LBMS that won't do anything in the quirk (except try raise the=20
Link Speed if it's the particular device on the whitelist).

> I wonder if it shouldn't have to see some kind of actual link activity=20
> as a prereq to entering the quirk.

How would you observe that "link activity"? Doesn't LBMS itself imply=20
"link activity" occurred?

Any good suggestions how to realize that check more precisely to=20
differentiate if there was some link activity or not?

> > (It sound to me you're having this occur in multiple scenarios and I've=
=20
> > some trouble on figuring those out from your long descriptions what tho=
se=20
> > exactly are so it's bit challenging for me to suggest where it should b=
e=20
> > done but I the surprise down certainly seems like case where LBMS=20
> > information must have become stale so it should be reset which would=20
> > prevent quirk from setting 2.5GT/s)
>=20
> Something I found recently that was interesting - when I power off
> a slot (triggering DPC via SDES) the LBMS becomes set on Intel Root Ports=
,
> but in another server with a PCIe switch LBMS does not become set on the
> switch DSP if I perform the same action. I don't have any explanation for
> this difference other than "vendor specific" behavior.

If you'd try this on different generations of Intel RP, you'd likely see=20
variations there too, that's my experience when testing bwctrl.

E.g., on some platforms, I see LBMS asserted twice from single retraining=
=20
(after a TLS change). One when still having LT=3D1 and the other after LT=
=3D0.

(I don't have explanation to that behavior.)

> One thing that honestly doesn't make any sense to me is the ID list in th=
e
> quirk. If the link comes up after forcing to Gen1 then it would only rest=
ore
> TLS if the device is the ASMedia switch, but also ignoring what device is
> detected downstream. If we allow ASMedia to restore the speed for any dow=
nstream
> device when we only saw the initial issue with the Pericom switch then wh=
y
> do we exclude Intel Root Ports or AMD Root Ports or any other bridge from=
 the
> list which did not have any issues reported.

I think it's because the restore has been tested on that device=20
(whitelist).

Your reasoning is based on assumption that TLS quirk setting Link Speed=20
to 2.5GT/s is part of "normal" operation. My view is that those=20
triggerings are caused by not clearing stale LBMS in the right places. If=
=20
LBMS is not wrongly kept, the quirk is no-op on all but that ID listed=20
device.

--=20
 i.

--8323328-1812599662-1752054335=:1149--

