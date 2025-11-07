Return-Path: <linux-pci+bounces-40578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD8C400AC
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE450188C444
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C682BEC42;
	Fri,  7 Nov 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="wiJdXsVg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9492BDC34;
	Fri,  7 Nov 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520978; cv=none; b=M6PhUku/TcmChr2umLRseWfTA6rD4GNsLwCEMepdAgSN2RW13Poc3dti400F0cK00SPGC2qN/ctpAipzsp8mFZAqjmJij7NgSvNOAei36SQ7ZCQ+1h9VNC65Geqzm6cDRMykXdYdyOBbJBo8y0eAVrEUwnkS5x5nxsHcQFKleHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520978; c=relaxed/simple;
	bh=4Ddae25sqG738EaVw5RvrZNH1hBC2JAp7XDsKznyjlg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cA5avrOqk/mlzIGji5463E9M5vzen5Qu21R4at0YHqTB1kLJgkmaoZgalSD85ODiwQjB75YpvX07Xn8jwzagylBI6jU25K1OBrbuzsoGMBNtXoLlEXZlnbHvMreAEVFbHgZRNAg9jg3HpnNep4rRAzX20wZro/qDxu6A5e+3yKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=wiJdXsVg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762520960; x=1763125760; i=spasswolf@web.de;
	bh=C8JSblNcI1zOZZ07ilFFhicMfhhYHjHHDyckzH5IIxQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wiJdXsVg5xGXRmSRup6oB6Yu+BJVKbDkCrbfGndCkEnamI07ZSCQbTNq8koKbF3g
	 e8UwEwUdveVS+rN1+Jke6MInZeB5r7ZXft/QctwM5ed/EAfX4L7vwjESTdSCbyfxA
	 YHnB4NF4xs/unnpLI9OV98ZMqDU5PHUGFfDblV+x2aqobRXxBBHf3Mqm8MjRLYR/W
	 8HamPKJimIoQ1DqOfp/p+73Gmn3O5eW7VlZ5GrEuqosPmT3ywD/DkSm++DLiLD8nA
	 pT2pb+fOCNiV+5cnVj1DX8QFg9Sf/ObR8r5/A7ov0CJnBuRGKOLoDZhPgZV+7dEGD
	 lMmzXdZKyr+udcpzxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1vwPz732Ja-00jVXB; Fri, 07
 Nov 2025 14:09:19 +0100
Message-ID: <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, spasswolf@web.de
Date: Fri, 07 Nov 2025 14:09:17 +0100
In-Reply-To: <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
	 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
	 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
	 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
	 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
	 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
	 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
	 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
	 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
	 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cwwvGof3jLSNg0rClU314UgVju483p/vCHF2hs6IGVaZu/tjpEv
 XLagxUR8bhCzzajJaLzlAKYtzmaruWxVp4Gv1Uws9IWnKUJhmdCOJLVLKM3qUc+8Kx8hiDI
 LN9PFB3l1bRaURgD8sYwx1QdB2z6xRj7N3kNcBSHQbRC1IxZamXN4E/p9kVNJX4FZPHPB3P
 RvcbovRRut/r8NhgyCmwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I79Uwc4qfLM=;wmwGdeNP/11VC+9fY1jHMNQ9YD4
 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

Am Mittwoch, dem 05.11.2025 um 15:31 -0600 schrieb Mario Limonciello (AMD)=
 (kernel.org):
>=20
> Once you're done with your bisect I'd be really interested if you can=20
> still reproduce the splats and NULL pointer on the recovery path using=
=20
> amd-staging-drm-next.
> >=20

There are good news and bad news on this:

The good news: I found out that one can generate a large number of ACPI GP=
P0 events
and resumes by scrolling through a large pdf (1305 pages - Gravitation by =
Wheeler, Misner and Thorne)
using the arrow keys. This can generate these crashes quite fast.

The bad news: Using the method above I could generate these crashes in v6.=
13 and v6.14,
so all the previous bisecting was completely useless.

Version v6.12 has not (yet, ...) crashed so I might be able to bisect betw=
een v6.12 and v6.13.

Here's a short log of the recent tests and time to crash (with number of G=
PP0 wakeup events and GPU resumes)

Retest:
6.14.0-stable		booted 18:11:24, 6.11.2025, crashed 18:45:30 (~34min, 588 G=
PP0 events, 210 resumes)

Retest:
6.14.11-stable		booted 19:09:33, 6.11.2025, crashed 19:17:42 (~8min (new r=
ecord!), 122 GPP0 events, 44 resumes)

Testing (this was tested by the old method of starting evolution by script=
):	=09
v6.13			booted 23:46:21, 6.11.2025, GPU lost 4:38, 7.11.2025 (~5h, 760 GPP=
0 events, 807 resumes) no crash

Retest:
v6.13			booted 9:12, 7.11.2025 crashed 11:25, 7.11.2025 (~1.25h, 351 GPP0 =
events, 330 resumes)

Testing:
v6.12.52		booted 11:27, 7.11.2025 no crash after 1h, 735 GPP0 events, 301 =
resumes

Testing:
v6.12			booted 13:00, 7.11.2025 no crash after 1h, 890 GPP0 events, 287 re=
sumes


Bert Karwatzki

