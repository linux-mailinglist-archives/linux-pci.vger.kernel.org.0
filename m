Return-Path: <linux-pci+bounces-16020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DB9BC1FC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779A82827F1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D2AD39;
	Tue,  5 Nov 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b="HTUZE2/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpx012.webglobe.com (smtpx012.webglobe.com [62.109.150.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E92CA4E
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.109.150.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766319; cv=none; b=RuA0uJ+E3aYePTHYdNr+rN+Bv0+NpH4qxR4hEOX3Nz3BrEO824T1MnFfMInc7XSNLUE2o4LPfyay+0kaRjo4C0rbVcS/oSRcTRmqSzZF+8Xi4ZPrarvZPmyRGj9y8ySQaKO0a81xTyQe5UGFXlqt/gOHrzCP4hizPWCrf61qmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766319; c=relaxed/simple;
	bh=pkr5bGntrTrN6a6EihbHrH7Bg0ayso/BO5vpdAGDViA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Twml1LXq6ODxR7pji6ygDkeL54f6NY1mswep8+/7gxLzrWiq+TQVvBkNdgQtCp/tTlcTuqGfr2WD4eTsjydqhV8jSdHQH7CGt2X7VPhaktUMQ9OgCr1zaSFzJjKjHNpH7zQSPXPrwaiin63pjhBUI4mhTcyU+LLhFSipeKv4b/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz; spf=pass smtp.mailfrom=xoores.cz; dkim=pass (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b=HTUZE2/Y; arc=none smtp.client-ip=62.109.150.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xoores.cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xoores.cz;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pkr5bGntrTrN6a6EihbHrH7Bg0ayso/BO5vpdAGDViA=; b=HTUZE2/YA2Cy+nlYB+DZo0z4M5
	AaA7Ps3G4GHLuwKTe65lyoV8u2dzEpZHn0nLBTZdLIiFo2YOI0UKXEssNOz1ed81bz+XWO/GU8dAl
	MxdFp0Oqt79LA1wJjGxb8Bn1xwstb+VE+o9tJmRlCAgpP198psBSLa25dH/Tw/QPm6do=;
Received: from [62.109.151.61] (helo=mailproxy11.webglobe.com)
	by smtpx012.webglobe.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t87NV-00GT8U-U6; Tue, 05 Nov 2024 01:25:01 +0100
Received: from [5.181.93.113] (helo=[192.168.20.60])
	by mailproxy11.webglobe.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t87NT-007EO2-U8; Tue, 05 Nov 2024 01:25:01 +0100
Message-ID: <5ec705d88869e774ea18b46fe7f2bb5d0378c808.camel@xoores.cz>
Subject: Re: IWL errors when reading PCI config through /sys
From: Jan =?iso-8859-2?Q?=A9=EDdlo?= <me@xoores.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>
Date: Tue, 05 Nov 2024 01:24:59 +0100
In-Reply-To: <20241104233301.GA1433525@bhelgaas>
References: <20241104233301.GA1433525@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated-Id: me@xoores.cz
X-Mailuser-Id: 694419

On Mon, 2024-11-04 at 17:33 -0600, Bjorn Helgaas wrote:
> It *should* be safe to read "config" from sysfs at any time, and also
> to write to the ASPM "policy" module parameter file at any time, but
> there could be bugs there.
>=20
> When you say "crash", I guess you mean all the iwlwifi error logging
> and the WARN_ON() stacktraces, right?=C2=A0=C2=A0 I don't see an actual o=
ops or
> panic in the logs yet.

There is no crash in form of an oops from the kernel fortunately :) But the=
 WLAN card stops talking & IWL
driver is not able to recover. Only shutdown fixes the issue. I did not try=
 just reboot to be honest as I
thought that full powercycle is necessary to properly reset the device - bu=
t I can try tomorrow if necessary.

> I assume none of these happen unless you are running your script or
> writing the "policy" parameter?=C2=A0 Does the problem happen if you *onl=
y*
> run your script to scrape the info from "config"?=C2=A0 What about if you
> *only* update the "policy" parameter?

The error does not happen if I read the config - I tested that properly. Wi=
thout touching the ASPM policy the
script is able to run without any problems. And also I can trigger the bug =
immediately when I write
"powersave" to the ASPM policy without the script.

> Emmanuel is right; the iwlwifi logging (e.g., "iwlwifi 0000:04:00.0:
> 0xFFFFFFFF | ADVANCED_SYSASSERT") sure looks like reads from the
> device are failing so we get ~0 data.=C2=A0 I'm guessing those come from =
a
> BAR, so the BAR could be disabled or the device might not be
> responding e.g., if it is in a low-power state (D1, D2, D3hot, D3cold)
> or being reset.

Device is reported being in D0 through the sysfs, but I'm not sure if that =
is really correct, because if I do
echo 1 > remove and rescan, the kernel complains about not being able to ta=
lk to the device. I can get the
exact error tomorrow if you'd like.

> I don't know whether iwlwifi checks for any PCIe failures like this.
> I see iwl_trans_is_hw_error_value(), but that must be for some
> iwlwifi-specific error thing, not for PCIe errors, because it checks
> for things like 0xa5a5a5a0.=C2=A0 For PCIe errors, we would see ~0
> (0xffffffff).
>=20
> My guess is that all the other WARN()s and stacktraces are just a
> consequence of trying to do things to a device that isn't responding.

You are probably right, Emmanuel did mention similar thing - that these err=
ors are typically thrown around
when the iwl driver cannot talk to the card (at all).

> > I have tried two different kernel versions (6.11.5 and 6.10.10), two
> > different WLAN cards (BE200NGW and AX211NGW) and multiple versions
> > of firmware for the cards. The error is still present, so I would
> > say I'd need to dig deeper, but I'm not really familiar with PCI
> > subsystem and how to debug it efficiently given the amount of data
> > going through.
> >=20
> > What can I do to debug this issue further?
> >=20
> > 1 - https://bugzilla.kernel.org/show_bug.cgi?id=3D219457
>=20
> Any clue if this is a regression?=C2=A0 Seems like a common device and we
> should have lots of reports.=C2=A0 That would suggest something related t=
o
> scraping the "config" file or updating ASPM "policy" at runtime.=C2=A0 So
> I'd say the first step is to confirm that one or both of those is
> implicated.

Updating policy definitely triggers this (at least on my ZBook) reliably. S=
craping config is fine, I wrongly
thought it was the problem (mea culpa) :)

TLP (common power management tool for laptops) can also write this policy, =
but I don't know if it is enabled
by default (I believe it is not) so that might be the reason there are not =
lots of these reports.

I also believe that I did not encounter this error when I was using TLP on =
this laptop earlier - and I *had*
this policy enabled. However I stopped using TLP some time ago (unfortunate=
ly I can't remember when exactly)
and switched to a set of custom scripts when I was trying to hunt down the =
shallow cstates/bad S0ix residency.

I saw "queue Y is stuck" quite often, but these were not annoying enough to=
 make me dig deeper as the iwl
would recover from this with just few second long outage.

I'm not sure yet if this is a regression, but I can test out few older kern=
el versions. Gentoo still has 5.10
and up so it should not be that hard to try out if you think it will help. =
:)

Thanks for your time!

Jan

