Return-Path: <linux-pci+bounces-16001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD309BBFF2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911141C21AEC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C051FCC63;
	Mon,  4 Nov 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b="FbFYNNwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpx011.webglobe.com (smtpx011-96.webglobe.com [62.109.151.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DC1FCC56
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.109.151.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755373; cv=none; b=Axz0uU0MB1RLaOQQPhk41gC+ZkBPlR5YZeJvuEV95Ua8Fny4GWUL/3pPd0lDvQv7AQlRbETOnuhbSdZJs7NPue0SbX2h3e9NL2FiATUIVIWjaOzrHQp5KVK7cRUVpLDe8DzJ0Jzri3OFw6DhzjiktE9+17LD4MUrWYIA84TY0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755373; c=relaxed/simple;
	bh=tDCKH8Msr4EVIPQ3lf0w9Bb1bQFMEdIP+7AXyUeq/gA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYXNv3pxtgJGPgB+VLthkGDHyLHUNIQ0P6E59moa848IfIMZ6Kavx0KwwDZt7dOmubRFWtmmOmU8Kri5imXrmbmHyC2VcNfGEEDWMMbDenVp7f9Q+5JwZLJpk8KEA07M4pgTcWFx62HEt3ESytE3DY54DRRNbY0SiM9P50LlJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz; spf=pass smtp.mailfrom=xoores.cz; dkim=pass (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b=FbFYNNwY; arc=none smtp.client-ip=62.109.151.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xoores.cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xoores.cz;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eKusev793xU9FPvlRIdhLxCVlhXSiIlic24q/1paXFU=; b=FbFYNNwYX7O9Ky4V1RABk/3rTL
	aorW+stEybPYGGmsyv0EUSUdro3BUw6sUbvsiW9YFK6m53CDimg/lLAbQEaV2tf4LnHa3t5a5n4Dw
	T0ucHYaDKAkSkai3hCGwul+OzselgrOf+k9ocnUtqSyvITm2cq5m3dFNyIep0vW9FQsk=;
Received: from [62.109.151.61] (helo=mailproxy11.webglobe.com)
	by smtpx011.webglobe.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t84Ww-00GY4M-Kw
	for linux-pci@vger.kernel.org; Mon, 04 Nov 2024 22:22:34 +0100
Received: from [5.181.93.113] (helo=[192.168.20.60])
	by mailproxy11.webglobe.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t84Wu-0072Qi-IN
	for linux-pci@vger.kernel.org; Mon, 04 Nov 2024 22:22:34 +0100
Message-ID: <79a68530f5a9d154d4838a700172c5509fee84ff.camel@xoores.cz>
Subject: Re: IWL errors when reading PCI config through /sys
From: Jan =?iso-8859-2?Q?=A9=EDdlo?= <me@xoores.cz>
To: linux-pci@vger.kernel.org
Date: Mon, 04 Nov 2024 22:22:31 +0100
In-Reply-To: <117b71d187214442cbcec407a618ff546e5d4386.camel@xoores.cz>
References: <117b71d187214442cbcec407a618ff546e5d4386.camel@xoores.cz>
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

Hi,

I have new findings - I was mistaken when I put the blame on PCI config of =
the device. After some more digging
(and many reboots), I can now trigger the bug at will - all I have to do is=
 write "powersave" to pcie_aspm
policy:
  echo powersave | /sys/module/pcie_aspm/parameters/policy

Few seconds after that I get the ol' crash:

04.11 21:54:03  root[11383]: Calling 'echo powersave | /sys/module/pcie_asp=
m/parameters/policy'
04.11 21:54:10  kernel: iwlwifi 0000:04:00.0: Error sending SYSTEM_STATISTI=
CS_CMD: time out after 2000ms.
04.11 21:54:10  kernel: iwlwifi 0000:04:00.0: Current CMD queue read_ptr 30=
9 write_ptr 310
04.11 21:54:10  kernel: iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
04.11 21:54:10  kernel: iwlwifi 0000:04:00.0: Transport status: 0x0000004A,=
 valid: -1
04.11 21:54:10  kernel: iwlwifi 0000:04:00.0: Loaded firmware version: 92.6=
7ce4588.0 gl-c0-fm-c0-92.ucode
....

I tested it multiple times and it is definitely consistent.

I always thought that pcie_aspm/parameters/policy should be generally safe =
(as long as I use
default/performance/powersave and not pcie_aspm=3Dforce on the cmdline). Am=
 I mistaken and should this setting
be avoided as unsafe?

If not, can I somehow help to get to the bottom of this?

Thanks
Jan


On Sun, 2024-11-03 at 13:52 +0100, Jan =C5=A0=C3=ADdlo wrote:
> Hello,
>=20
> I'm not sure if this is the right place - if not, I'm sorry! It is the fi=
rst time I'm trying to join a linux
> mailing list so I may have missed something or I may have done something =
incorrectly. I'm not even sure if
> this is the right way to send a message, but I have to start somewhere :)
>=20
> I'm trying to hunt down few issues with my new-ish HP ZBook not wanting t=
o go to deeper C-stsates, which is
> kind of painful for a laptop (battery drain is ~5-10%/hour). For this I c=
reated a little python script that
> gathers all the info about all the components from the system and periodi=
cally reports the status (every 3s
> or
> so) including PCI and USB devices. To gather some information (specifical=
ly about ASPM) I'm reading /config
> file for each PCI device in /sys device tree and parsing it. I'm not read=
ing only /config but it is a prime
> suspect, because I excluded WLAN card from this reading routine and the c=
rash took much longer to occur -
> hours instead of minutes.
>=20
> When I run this script, the IWL subsystem crashes after some time (minute=
s to hours). There is clearly
> something going on the PCI bus that I don't really understand. Since the =
error I get from IWL is changing, I
> suspect there is some kind of race condition that is triggered by my scri=
pt. I opened a bug [1] and after
> some
> back and forth with Emmanuel Grumbach, he said that this kind of error is=
 caused by IWL not being able to
> talk
> to the WLAN device (at all) and to try to get your opinion on the matter =
:)
>=20
> I have tried two different kernel versions (6.11.5 and 6.10.10), two diff=
erent WLAN cards (BE200NGW and
> AX211NGW) and multiple versions of firmware for the cards. The error is s=
till present, so I would say I'd
> need
> to dig deeper, but I'm not really familiar with PCI subsystem and how to =
debug it efficiently given the
> amount
> of data going through.
>=20
> What can I do to debug this issue further?
>=20
> Thanks
> Jan
>=20
> 1 - https://bugzilla.kernel.org/show_bug.cgi?id=3D219457
>=20
>=20


