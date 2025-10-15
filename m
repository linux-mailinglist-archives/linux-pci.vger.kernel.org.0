Return-Path: <linux-pci+bounces-38203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E685BDE45B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D6B4FD825
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE21AC44D;
	Wed, 15 Oct 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="jygzf2T8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61934BA5A
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527892; cv=pass; b=eR+EUD9BaeyGuFyRaIEUh9wkcIi3mZZAR3PEHFVsvaMzUe4qXFfbgh5Egs56FQO68QbymqJCYT7f1OW2dzdn9GZd62KFH55IwQCA13q8ejZGM4NsBQirx3W7jm/07VbwRYylt9BlerruYjxV92OTee/XbBZRK+6vJqgAEjeAYkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527892; c=relaxed/simple;
	bh=tiU1hck8P6+rhjduHLx572kUy9K4fLqigLL2LLhKmuw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=plaEClOL7BlL1ewVWewbDZyVU3CFCXjkGlg3c9HgJnbkpYoQqIlFKtKcVdononrnZIWbyp8vFdrx/CIGi8C5k68dZ2l5U6o+f0KkhOD0IJeniQASedxzga1VE9piJ9Y/pCnVxI3SW3AW2jpKDU307KIr41vUlzda6V3p/yNws58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=jygzf2T8; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760527855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n/AEa3oZ9e4Gvabi/neXFnxSHRtgC57wuGH+ZkzJVjISSptuqAyfjZqCMLss6sEYDc
    O490O6bXBAM6854dy+bWw2j2LFEdOTJHSjRNgVMnoSCSACwthAe7j2raRq/NdVW/IqwF
    dRIPq4pTK2g6HdNU+cNb5tLe1M3mNlwHhhsFmHkhT6z4tQWljTW2JhvG6jxlShEqngkX
    SE36iG2xznvkhbkXhOllvHHEYtSu/ah5XrkftAd5kLoL5IaRLMxuxz/urKAF6qttQLta
    hBSCRQOYiiuknFY1FIpTtL5Z1OalD3NKSa7rcxf88FBqdXapCRQ8hS93DIDznd9iZmdv
    RPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760527855;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=tiU1hck8P6+rhjduHLx572kUy9K4fLqigLL2LLhKmuw=;
    b=slth2aItOdCwsc91y8hIBPyf4VtCnynhFsdCD7LPSUsCYDJUXx4owp+vgc6kImEFEp
    xg8Il3D3Azwc+TYAS7w5k/5j1pFEbGvZYx4zRTvIJhoTFMzfu0/qmfYpSj7timQz0xse
    l1rzNbIdTqIFliqRx5lge1sM5ReYX0EYRkfNJ1pAmE57nOkgIIltJpj8SDaTy8d6kR4U
    rRInuVncmDPyusd58pyBFHtFwQ6jBkCdJUghbOW+P8XXMP6zKO/f2its4KEw6mj3ZSQ0
    OhVQpceI5BM8wzexQkY/eEuVSW83UK+2255hHV6L9W/e5wIc42gT6+sR5evykfwRe6wv
    SxYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760527855;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=tiU1hck8P6+rhjduHLx572kUy9K4fLqigLL2LLhKmuw=;
    b=jygzf2T81XXxJeng1TAhAvfneo8m/Z2JARbCqv3s/KHuTTrgGm9SvnqaJ74SAaSlIE
    jpUUFejdR0J6u+Noym1+2tKLHws5rEiNp1+KQlyiVZDqbsyC3+njBtU1cGaZqIP5qMJI
    szo5pxuRS53A3yKNMOtMIxcN3gzIYPmINZwYmgnYd/IL5azia+fUkKwL1Xc4zSFUY5vy
    NP1piqUUwdyZAa36kNFVRbTaLXzYe7M0a/OwDTwNrWFC2mX5+Bd44Cl0ObXTEpwkKnW5
    cYYUZH659rVV23P1vmL+4xBR+Zw0VAbzabR6UWUY/k4hsbFj/3tiFnkJCBQ0gzNmvH4b
    B7dA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qwsy/HXXayq4HHiz7trzKpc/q6JeX5UCXsvg=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619FBUtX2E
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 13:30:55 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Date: Wed, 15 Oct 2025 13:30:44 +0200
Message-Id: <A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
References: <20251015101304.3ec03e6b@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20251015101304.3ec03e6b@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
X-Mailer: iPhone Mail (23A355)

Hello Herve,

> On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wr=
ote:
>=20
> =EF=BB=BFHi All,
>=20
> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all=

> ClockPM and ASPM states for devicetree platforms")

Thanks for reporting.

>=20
> Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> an the quirk also fixes the timing issue.

Where have you added quirk_disable_aspm_all?

Thanks,
Christian=


