Return-Path: <linux-pci+bounces-20532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E91A21C85
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093221649F4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B71D90B1;
	Wed, 29 Jan 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="NB+xIyjG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjVVgQeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140481D8E10;
	Wed, 29 Jan 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151604; cv=none; b=N0RhDJxWaI+iadn5FndE/iJqDRN+w9a4eYyECD1KSr3Ck1FuDjE2Ej5VOlW8hZngeUolJ3H+IIu5b+Wm6s9Vjf/h02t16CRjc46WQ7sZBMEsyeYu4E/+8nvGOypLcXFW1mvjtcaqqFJhYpdrS1nFYMwhGdetjbXI9nxM897mvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151604; c=relaxed/simple;
	bh=kjClw47FHDQHlQQV0V96Wr3SEi2HA2uZHAK1YtvAQLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR0DqFXtHWZsFietix92M2KxUtOoF9Adh6CgCnRyssIEWuxigMv6QvLicUzQ88rWzwZRfNOa8fsH6oq7rdIjtzMBhwLAiAHwFVwmsuO+RBE9OSTARR27bfSi7u6SnrIVGcvaYyDaC9mTSTbzbUlZwJaUTdceeHrjvz7bTgvntsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=NB+xIyjG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjVVgQeY; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 923C31140142;
	Wed, 29 Jan 2025 06:53:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 06:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738151600;
	 x=1738238000; bh=5kVjsOjJ1lV0xf8PMGyEsjXHM5+QwpgL4ePKOXTO7Gw=; b=
	NB+xIyjGD2gE9KRKrDaxud6TIUdIG1QSObSAQ9M3vAtucwPxhjGblTtuQSJvGVWy
	ndVPifH5YN1yhfBT+2lPAk1PQQdhCfpOJX5FeaU7oFust2aNlAk5MEpYe8uUvm/y
	KvjdAklO5cUcMzhF3VfkFnJcryeOg5ChWKfSv/tvdZIl89P8IbOMoZVB3zClWsby
	q6yCVtxGqOrufdW5mYdLVc5V80Z8z0A/uu3ysZvc2IKEmB5b5FHoD/+lhojZOlNq
	vZH9U9ruW0il/Dg8YbkhzwU7Dsp1B1C3dEdaHdxjOYJ11QxS4yUMlMcRuPoUp+Y/
	lBAlAOLzwlaCTF7/o0rZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738151600; x=1738238000; bh=5kVjsOjJ1lV0xf8PMGyEsjXHM5+QwpgL4eP
	KOXTO7Gw=; b=IjVVgQeYtvf6xJclgFgzYn4q4xdff5x8LH0/x3m/Ks+X6mzqUy8
	Spn0KawrTC1u6+JuRsSyeuMjX2mFJIpI7BRvhL/MY6zle5kyDzBIy0WsPbbn5we/
	d82fXF/dBmEbzXPmzZAoXVdYlv8J9D+3FfUuLwDPApXb9ENm7PvQcZu3FmSUOTn9
	rtVoF3ayXZ+SyhDDYdxoUafO1B2M0AozfCSLBUd3+fRtDiREwgu/yJ8En2WdBZTY
	yHDMZwjXBUVSY63tZq+4YgEKP1BDW+ORHHw1x3I1NbGflRkrDfg+JSCQ1W/29/1+
	uODGXGjFnBuuZMHJeXXbE51LfNu5zbn7afQ==
X-ME-Sender: <xms:rxaaZxZHIhPNfz9J7puVjg0g-XbQhGEV4mw8LhRtIO2uUmuGbkOdUg>
    <xme:rxaaZ4YktNWiCg_5XxfU_9Mx8-UQyqULE9inctYc1Qs2AD7rkbpxkjYNimRKTHLSC
    BdpnWGXM7geEQ>
X-ME-Received: <xmr:rxaaZz9JbK0JxP83b6LWLXBxVtmvSThIFhiKHeZqFTwKg7X87NikVRWKKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
    grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
    rfgrthhtvghrnhepgfduleetfeevhfefheeiteeliefhjefhleduveetteekveettddvge
    euteefjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnh
    gspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsggv
    uhhlihgthhesshhushgvrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthht
    oheprhhoghgvrhdrphgruhestghithhrihigrdgtohhmpdhrtghpthhtohepsghorhhish
    drohhsthhrohhvshhkhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepgigvnhdquggv
    vhgvlheslhhishhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgv
    ghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnsg
    gusehnsggurdhnrghmvg
X-ME-Proxy: <xmx:rxaaZ_o14Y1yYSHINJ9lVdCij1hHDGJS00znShf0NjFe1WjVNb3HYA>
    <xmx:rxaaZ8pbHoprt6ZkjabWHGfbHbJso-CoBM7yp-91YaBaM_QWI6OsCg>
    <xmx:rxaaZ1Qtg2BTUuYw-qyH0eOUvmvmW0h5Z75JtwutuAbyEhG7skIiRA>
    <xmx:rxaaZ0pWoQYrxpW1Qkjonw9uwntE0msRt4vCjY7Z27VW-S7GDqWGzQ>
    <xmx:sBaaZ561c46PVu3fMc4UG3ul1Y9PryvVUZgBzi3sKqsBcp5BAgtaD89n>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 06:53:17 -0500 (EST)
Date: Wed, 29 Jan 2025 12:53:15 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <Z5oWq4YgMgwWvl2G@mail-itl>
References: <Z5mOKQUrgeF_r6te@mail-itl>
 <20250129030315.GA392478@bhelgaas>
 <Z5mfA32bvEn6yD-C@mail-itl>
 <22ad7276-624d-49fb-a2bb-1b7908318a4e@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a+GZJj6pK/SHY+Cv"
Content-Disposition: inline
In-Reply-To: <22ad7276-624d-49fb-a2bb-1b7908318a4e@suse.com>


--a+GZJj6pK/SHY+Cv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jan 2025 12:53:15 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)

On Wed, Jan 29, 2025 at 10:17:20AM +0100, Jan Beulich wrote:
> On 29.01.2025 04:22, Marek Marczykowski-G=C3=B3recki wrote:
> > On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
> >> The report claims the problem only happens with Xen.  I'm not a Xen
> >> person, and I don't know how to find the relevant config accessors.
> >> The snippets of kernel messages I see at [1] all mention pciback, so
> >> that's my only clue of where to look.  Bottom line, I have no idea
> >> what the config accessor path is, and maybe we could learn something
> >> by looking at whatever it is.
> >=20
> > AFAIK there are no separate config accessors under Xen dom0, the default
> > ones are used. xen-pcifront takes over PCI config space access (and few
> > more) only in a domU (and only for PV), when PCI passthrough is used.
> > Here, it didn't went that far...
> >=20
> > But then, Xen may intercept such access [2]. If I read it right, it
> > should allow all access (is_hardware_domain(dom0)=3D=3Dtrue, and also t=
he
> > device is not on ro_map - otherwise reset wouldn't work at all).
>=20
> The other day you mentioned (on Matrix I think) that you observe mmcfg
> not being used on that system. Am I misremembering? (Since the capability
> where the control bit lives is an extended one, that capability would
> neither be read nor modified when mmcfg is unavailable.)

Yes, but later (once dom0 starts) it switched back to mmcfg. Now I see
this:
(XEN) PCI: MCFG configuration 0: base e0000000 segment 0000 buses 00 - ff
(XEN) PCI: Using MCFG for segment 0000 bus 00-ff

Another thing I noticed in the bug report - the reporter says warm
reboot from 6.11 (where it works) to 6.12 avoids the issue (not sure
about further reboots). Cold boot directly to 6.12 results in this buggy
behavior.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--a+GZJj6pK/SHY+Cv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmeaFqsACgkQ24/THMrX
1ywvTQf/YYurxRaUAGuLjE9v/1EfWAM03m/V7lXiOvaN91b2+QkGZhFeQjEnpgwC
1y+Qyhfyd/CYfTs5pX/3OJ2PvGHDOMBaRKHrPer+C31qBYf2025xPK/M345aLiHp
XMjaIaI6JCVvVO718jleh/+mqtCGCPW4VB4liMmyHGquUrs72mBacofGKYEgh149
sL3UEpSrAoFmy9mxVkNdGJLSZp6oW6zuXpkAJx4QeW5TzgY0F26BZUCDi5Py1R0m
DvDmauAZRPKJH6/7lpw4aacRrLk9Y/dIbX51ELBxP1n3BcDmyHLEw1TECE+NPTGX
HOfpgyyvw+YPtsG6sbXgLqYOoyZsaQ==
=uRq/
-----END PGP SIGNATURE-----

--a+GZJj6pK/SHY+Cv--

