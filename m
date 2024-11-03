Return-Path: <linux-pci+bounces-15870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7F9BA58B
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40388B20A39
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555816DEB3;
	Sun,  3 Nov 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b="stz/t4mI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpx012.webglobe.com (smtpx012.webglobe.com [62.109.150.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96A23774
	for <linux-pci@vger.kernel.org>; Sun,  3 Nov 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.109.150.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730639231; cv=none; b=TAdp3M2yQ722fHS50B7R28gdw1+nZnLqQuvK4Td1yFVkcIdUDqiwnRR0Qc3VDx0snJBQiuuCy678v7qW2M/W1OJEKWBSc91iA3J4N+UuaAexsLhj72IZ9ufFF44exMNb9JU26Kb/J2mpV3A0Z0qIyvs5iaEiqsHBN8/zNqL/mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730639231; c=relaxed/simple;
	bh=0+WL+i9QZoQCHsgL5hUT3TEsNaFGEUJmq1M56akl3/g=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=sh107LhTDHgwYMeCPWvUWdwRVraal2xDUcqp31Wrntav5NC2l+L77iQytYs+7U+Uu9+36XgE8N2DRnT9nPQ4o+yliWoW7++6JUIR2K/jAHQU3DWoEqHM56jixICKW7X+c2h+omfCwfia2bNB6njy32+9K+wzTfXuss08r8i7tR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz; spf=pass smtp.mailfrom=xoores.cz; dkim=pass (1024-bit key) header.d=xoores.cz header.i=@xoores.cz header.b=stz/t4mI; arc=none smtp.client-ip=62.109.150.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xoores.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xoores.cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xoores.cz;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:To:From
	:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0+WL+i9QZoQCHsgL5hUT3TEsNaFGEUJmq1M56akl3/g=; b=stz/t4mIND+LF4T4ASZvsebqoY
	T1OtZ87VzQo1+XiUceXovW5x720faiNZrEXF8moAPL639HCOIAowsfr2jt4oXiOe7fvphoZuIv8Yw
	LUlKG63ZnqxWIJOWd2KnVvLlUWHi2Etps+Zgt+f+hn4Kat9oVLdFudT6jfItqPEgYzJw=;
Received: from [62.109.151.61] (helo=mailproxy11.webglobe.com)
	by smtpx012.webglobe.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t7a5j-00CBdD-UO
	for linux-pci@vger.kernel.org; Sun, 03 Nov 2024 13:52:27 +0100
Received: from 160-218-189-249.rea.o2.cz ([160.218.189.249])
	by mailproxy11.webglobe.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <me@xoores.cz>)
	id 1t7a5h-003A1M-6Z
	for linux-pci@vger.kernel.org; Sun, 03 Nov 2024 13:52:27 +0100
Message-ID: <117b71d187214442cbcec407a618ff546e5d4386.camel@xoores.cz>
Subject: IWL errors when reading PCI config through /sys
From: Jan =?iso-8859-2?Q?=A9=EDdlo?= <me@xoores.cz>
To: linux-pci@vger.kernel.org
Date: Sun, 03 Nov 2024 13:52:24 +0100
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

Hello,

I'm not sure if this is the right place - if not, I'm sorry! It is the firs=
t time I'm trying to join a linux
mailing list so I may have missed something or I may have done something in=
correctly. I'm not even sure if
this is the right way to send a message, but I have to start somewhere :)

I'm trying to hunt down few issues with my new-ish HP ZBook not wanting to =
go to deeper C-stsates, which is
kind of painful for a laptop (battery drain is ~5-10%/hour). For this I cre=
ated a little python script that
gathers all the info about all the components from the system and periodica=
lly reports the status (every 3s or
so) including PCI and USB devices. To gather some information (specifically=
 about ASPM) I'm reading /config
file for each PCI device in /sys device tree and parsing it. I'm not readin=
g only /config but it is a prime
suspect, because I excluded WLAN card from this reading routine and the cra=
sh took much longer to occur -
hours instead of minutes.

When I run this script, the IWL subsystem crashes after some time (minutes =
to hours). There is clearly
something going on the PCI bus that I don't really understand. Since the er=
ror I get from IWL is changing, I
suspect there is some kind of race condition that is triggered by my script=
. I opened a bug [1] and after some
back and forth with Emmanuel Grumbach, he said that this kind of error is c=
aused by IWL not being able to talk
to the WLAN device (at all) and to try to get your opinion on the matter :)

I have tried two different kernel versions (6.11.5 and 6.10.10), two differ=
ent WLAN cards (BE200NGW and
AX211NGW) and multiple versions of firmware for the cards. The error is sti=
ll present, so I would say I'd need
to dig deeper, but I'm not really familiar with PCI subsystem and how to de=
bug it efficiently given the amount
of data going through.

What can I do to debug this issue further?

Thanks
Jan

1 - https://bugzilla.kernel.org/show_bug.cgi?id=3D219457

