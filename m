Return-Path: <linux-pci+bounces-3031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F289C847321
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2891C21682
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8716144629;
	Fri,  2 Feb 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp1UGuaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563522085;
	Fri,  2 Feb 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887663; cv=none; b=knv4iTU8+T3cEmmZSFJZZ5U8uXsmwKrQpCoOoYpf0KGIlJyOjWIUWh2GXv4muOipaJd1l0cQCWjcUDkaU5NYam933t9D1Yb1kf0IMDfPheDfuW1duwXYJ0EU3/HfjVlBMxzENiFJsr5AK8+JjMxakW4d8zD24hWwe9qFH47K0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887663; c=relaxed/simple;
	bh=RhCaan2xTl8pGQjWVw71sQan87Rb8PlWXG6TrDgynRg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PJIw5WLBEs3KFfcVUomraKljLAMgHxOTaCp03Stl10sCr2LXkjZFYhJFQJ8GWEPsKK4ZZpyYBWhr50Yj0Qyl/2x8K248E/krRae9jzKpj79Z3BgrmQqCqEVhinqAfYnzMpsPIazHwKYQkY+9daKd4EYV+OWzn0H3MXOFkNYfwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp1UGuaX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706887662; x=1738423662;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=RhCaan2xTl8pGQjWVw71sQan87Rb8PlWXG6TrDgynRg=;
  b=fp1UGuaXrClAb6fC5wlH2lsdisU2HNcGvL0ZZOFOAlJ8Fmc4/NSTl3Wj
   zOT2KmeX7W0jwDhDGTQUF1Vqf77YIeAttpbtd7YZqQdn1SwVw3SV/8P/A
   x6UI/BSsr+9AmQTq18SbpgctFc9J0AaM7oj5mcchlzJf/7pM7FhAcytlY
   RDmpGp0Gy9FeFllT5kCjk5EC7OhhF26WiT7pi5JvbfLkDAShJvr+xEAxd
   NknwtplfhO1v2Nzbily3n8BImnR5nHW8a9k0PpDlXBwk+0/LQIt1KfAOj
   N8MtdvFUZqi+tPWdRQeWsy6Ov8OhWMSrDgUK4LAOFvihfsKG0J+iCPhmU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="338877"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="338877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="376364"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.66])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:27:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Feb 2024 17:27:34 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk>
Message-ID: <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-987821708-1706879739=:1020"
Content-ID: <9428fc1c-220f-94a7-802d-c45a846ed36f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-987821708-1706879739=:1020
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <66007069-bb7d-66e7-d4f6-94c027dc9ebb@linux.intel.com>

On Thu, 1 Feb 2024, Maciej W. Rozycki wrote:

> On Thu, 1 Feb 2024, Ilpo J=E4rvinen wrote:

> > > >  This can be problematic AFAICT however.  While I am not able to ve=
rify=20
> > > > suspend/resume operation with my devices, I expect the behaviour to=
 be=20
> > > > exactly the same after resume as after a bus reset: the link will f=
ail to=20
> > > > negotiate and the LBMS and DLLLA bits will be respectively set and =
clear. =20
> > > > Consequently if you clear LBMS at resume, then the workaround won't=
=20
> > > > trigger and the link will remain inoperational in its limbo state.
> > >=20
> > > How do you get the LBMS set in the first place? Isn't that because th=
e=20
> > > link tries to come up so shouldn't it reassert that bit again before =
the=20
> > > code ends up into the target speed quirk? That is, I assumed you actu=
ally=20
> > > wanted to detect LBMS getting set during pcie_wait_for_link_status() =
call=20
> > > preceeding pcie_failed_link_retrain() call?
>=20
>  It is a good question what the sequence of events exactly is that sets=
=20
> the LBMS bit.  I don't know the answer offhand.
>
> > > In any case and unrelated to this patch, the way this quirk monopoliz=
es=20
> > > LBMS bit is going to have to be changed because it won't be reliable =
with=20
> > > the PCIe BW controller that sets up and irq for LBMS (and clears the =
bit).
> > > In bwctrl v5 (yet to be posted) I'll add LBMS counter into bwctrl to =
allow=20
> > > this quirk to keep working (which will need to be confirmed).
>=20
>  If there's an interrupt handler for LBMS events, then it may be the best=
=20
> approach if the quirk is triggered by the handler instead, possibly as a=
=20
> softirq.

Okay, I'll look into changing the code towards that direction. The small=20
trouble there is that soon I've very little that can be configured away=20
from the bandwidth controller because this quirk already relates to the=20
target speed changing code and the LBMS will require the other side to be=
=20
always compiled too...

> > > >  What kind of scenario does the LBMS bit get set in that you have a=
=20
> > > > trouble with?  You write that in your case the downstream device ha=
s been=20
> > > > disconnected while the bug hierarchy was suspended and it is not pr=
esent=20
> > > > anymore at resume, is that correct?
> > > >
> > > >  But in that case no link negotiation could have been possible and=
=20
> > > > consequently the LBMS bit mustn't have been set by hardware (accord=
ing to=20
> > > > my understanding of PCIe), because (for compliant, non-broken devic=
es=20
> > > > anyway) it is only specified to be set for ports that can communica=
te with=20
> > > > the other link end (the spec explicitly says there mustn't have bee=
n a=20
> > > > transition through the DL_Down status for the port).
> > > >
> > > >  Am I missing something?
> > >=20
> > > Yes, when resuming the device is already gone but the bridge still ha=
s=20
> > > LBMS set. My understanding is that it was set because it was there
> > > from pre-suspend time but I've not really taken a deep look into it=
=20
> > > because the problem and fix seemed obvious.
>=20
>  I've always been confused with the suspend/resume terminology: I'd have=
=20
> assumed this would have gone through a power cycle, in which case the LBM=
S=20
> bit would have necessarily been cleared in the transition, because its=20
> required state at power-up/reset is 0, so the value of 1 observed would b=
e=20
> a result of what has happened solely through the resume stage.  Otherwise=
=20
> it may make sense to clear the bit in the course of the suspend stage,=20
> though it wouldn't be race-free I'm afraid.

I also thought suspend as one possibility but yes, it racy. Mika also=20
suggested clearing LBMS after each successful retrain but that wouldn't=20
cover all possible ways to get LBMS set as devices can set it=20
independently of OS. Keeping it cleared constantly is pretty much what=20
will happen with the bandwidth controller anyway.

> > > I read that "without the Port transitioning through DL_Down status"=
=20
> > > differently than you, I only interpret that it relates to the two=20
> > > bullets following it. ...So if retrain bit is set, and link then goes=
=20
> > > down, the bullet no longer applies and LBMS should not be set because=
=20
> > > there was transition through DL_Down. But I could well be wrong...
>=20
> What I refer to is that if you suspend your system, remove the device=20
> that originally caused the quirk to trigger and then resume your system=
=20
> with the device absent,

A small correction here, the quirk didn't trigger initially for the=20
device, it does that only after resume. And even then quirk is called=20
only because the link doesn't come up.

On longer term, I'd actually want to have hotplug resumed earlier so the=20
disconnect could be detected before/while all this waiting related to link=
=20
up is done. But that's very complicated to realize in practice because=20
hotplug lurks behind portdrv so resuming it earlier isn't going to be=20
about just moving a few lines around.

> then LBMS couldn't have been set in the course of=20
> resume, because the port couldn't have come out of the DL_Down status in=
=20
> the absence of the downstream device.  Do you interpret it differently?

That's a good question and I don't have an answer to this yet, that is,
I don't fully understand what happens to those device during runtime=20
suspend/resume cycle and what is the exact mechanism that preserves the=20
LBMS bit, I'll look more into it.

But I agree that if the device goes cold enough and downstream is=20
disconnected, the port should no longer have a way to reassert LBMS.

> Of course once set the bit isn't self-clearing except at power-up/reset.

Okay, I misunderstood you meant it would be self-clearing whenever=20
DL_Down happens. I can see that could have been one possible=20
interpretation of the text fragment in the spec.

> > So I would be really curious now to know how you get the LBMS on the=20
> > device that needs the Target Speed quirk? Is this true (from the commit=
=20
> > a89c82249c37 ("PCI: Work around PCIe link training failures")):
> >=20
> > "Instead the link continues oscillating between the two speeds, at the=
=20
> > rate of 34-35 times per second, with link training reported repeatedly=
=20
> > active ~84% of the time."
> >=20
> > ?
>=20
>  That is what I have observed.  It was so long ago I don't remember how I=
=20
> calculated the figures anymore, it may have been with a U-Boot debug patc=
h=20
> made to collect samples (because with U-Boot you can just poll the LT bit=
=20
> while busy-looping).  I'd have to try and dig out the old stuff.

I'd guess it probably sets the bit on each try, or perhaps only on the=20
subset of tries which were "successful" before the link almost immediately=
=20
runs into another error (that 16% of the time).

> > Because if it is constantly picking another speed, it would mean you ge=
t=20
> > LBMS set over and over again, no? If that happens 34-35 times per secon=
d,=20
> > it should be set already again when we get into that quirk because ther=
e=20
> > was some wait before it gets called.
>=20
>  I'll see if I can experiment with the hardware over the next couple of=
=20
> days and come back with my findings.

Okay thanks.


--=20
 i.
--8323328-987821708-1706879739=:1020--

