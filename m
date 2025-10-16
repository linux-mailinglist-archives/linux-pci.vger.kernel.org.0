Return-Path: <linux-pci+bounces-38293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1501BBE15BF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 05:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E63919C4EBA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176E18D656;
	Thu, 16 Oct 2025 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="R/5pbsqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BC21257B
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585352; cv=pass; b=SXtyAuxlUjepEkriQm+gaXu9J5o33JJI4uURTUbJll55AGsGpdMMxN140/2x7DtTdHz/AdT+BW7DN3fPtz6nKhZ+fAqc7+Z32FOmfAkNEav/nFNXCp6lmEoATuwQkwu8zJpwYwXn+AsaILlt8avVkxt4/jfagHI9EhqWBkDE0zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585352; c=relaxed/simple;
	bh=U1QVdd6JW1LVq5T13CF2TXWHmO7bdk1xu1u07tqkK8c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=UUnNE4Gz1LKMv4IpsUgrk1WAOOV5ueZvOamaU4gi3McDKGLzaVrNDxReLxY+NPEloN+eGHlEibuPtHGco0pR6GfrE5CdGG9uQDgTBUCn/ziLOtdJW+s+obHyGfEICz3ooQpkGLoaxiOgsMxoPPDHhQwOFrFRRoZl215Ac90rwgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=R/5pbsqG; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760585320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Du8SE+AQx70knP5bBVWvf1UyPfqlyTXouAxGiB/esD8HkuLeSlYHYBv04ucJY0jVGy
    rdfnon3jViq1DDUhDXSaMyi2dCZW5Sf8pStHcCHgjvYk0bfC2C61EqNM8xsBdzb9DPDw
    AwCo77hMK45hfe6haowVPZFJuhH7a1nWu6ZOY6BVF92BwoKZ69b5EPYl4HVHxvhFeTlz
    s49aQuMqbAZDOwvlMu4alOdTmrQQRpAyjYCaHmBEAbBgfsLXiA4dkYPXOFxQUyDQ5qSQ
    OvHUzQFzv9bMKwBpyI029hOSsaWoJkLuYy/PslIKmGLPkZX690zd6eP/CL8TLkZSb/am
    JR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760585320;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=U1QVdd6JW1LVq5T13CF2TXWHmO7bdk1xu1u07tqkK8c=;
    b=fqucTLmLVdqXoSwNWjy76LCF2XjZw7YF+oWRO2uUI79W/ObtXYTSUaN2s4UlXnch5Q
    NSqnNt/sYSbKkAGlomw+eyMhCP5OONJyExt2EHwQVKISz/s6Wl9H8/B1/sTY6NYWXOD7
    7C9ArjRhvjui/bNazzdalkjmNEOMERFknaxhh3Dq78Nl5lCNEobflh88jfLp2cS5Qjwq
    QHUZOY+2YKwDG/gA9Aviru2KUBg6u2c2W4wVOgtDBqFtE7iuxAPaQxtv1K9G0WD6KKCV
    Sx0+iUqr7WBBO2xkdlkNxS0oXK1zzQVSOPQEgGnZTIOVu0I7NqVmKLfXfaEQW/41E+rE
    DM2Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760585320;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=U1QVdd6JW1LVq5T13CF2TXWHmO7bdk1xu1u07tqkK8c=;
    b=R/5pbsqG+oRmSjcLn+iM6jCmmOEnRWvlpSCnbmbuEVjEhT4a41syRZ1QufiSG7cPhO
    Ucfyyuuxk+ZTwO6/5Wh7y70PFYMVKSAnZROx7FJtBJ9nwZwuVzUHY9eKVVjL5Z++117g
    bU4oIsOFBljq5csIwdBvKDWoSLdqQM+HGT96tfW7b0eScR4FaLLy9KPtKxGFu4gj10Bp
    xzHrSsMttCwLbnXsHU+27Tz1Bg314fJ7sNEy5ZrBWLbn6Mb1sQpRf4IJsOFncR8CKphk
    ZoY6SBFVF9mt/6O2jTjNBAvlwqfAAaTikYT3AXHZmweBPte0lOwsD2kyTNrC4AD3G3St
    cQsw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6P1rfO5KiO55fErql7iEPqvUkiut3rDMpXKOGwiWMRFXLr21cvQN8g=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619G3SdZOK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Oct 2025 05:28:39 +0200 (CEST)
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
Date: Thu, 16 Oct 2025 05:28:28 +0200
Message-Id: <A1E3F83C-3AE8-43B7-9DCB-6C38C94F8953@xenosoft.de>
References: <20251015153442.423e2278@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20251015153442.423e2278@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
X-Mailer: iPhone Mail (23A355)



> On 15 October 2025 at 03:51 pm, Herve Codina <herve.codina@bootlin.com> wr=
ote:
>=20
> =EF=BB=BFHi Christian,
>=20
> On Wed, 15 Oct 2025 15:14:28 +0200
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>=20
>>> Am 15 October 2025 at 02:59 pm, Herve Codina <herve.codina@bootlin.com> w=
rote:
>>>=20
>>> Also when it boots, it is not easy to know about the problem root cause.=

>>>=20
>>> In my case, it was not obvious to make the relationship on my side betwe=
en
>>> my ping timings behavior and ASPM.
>>>=20
>>> Of course 'git bisect' helped a lot but can we rely on that for the aver=
age
>>> user?
>>>=20
>>> Best regards,
>>> Herv=C3=A9 =20
>>=20
>> I think I will revert these modifications for the RC2.
>=20
> I don't know what is the future of those modifications but maybe instead
> of fully reverting them, maybe you could perform calls to
> - pcie_clkpm_override_default_link_state() and
> - pcie_aspm_override_default_link_state()
> only if a new Kconfig symbol is enabled.
>=20
> Of course this symbols will be disabled by default but if you want some
> people to test behavior, it could be interesting to have the code
> available in the kernel.
>=20
> I don't know, this was just an idea.
>=20
> Of course, reverting the patch is simpler than adding this new Kconfig
> symbol.
>=20
> Best regards,
> Herv=C3=A9

Hi Herv=C3=A9,

Do you mean an option in the kernel config? If yes, then it is a great idea.=


@Mani
Could you please create an option in the kernel config that enable or disabl=
e the power management for PCI and PCI Express?
If yes, then I don=E2=80=99t need to revert the changes due to boot issues a=
nd less performance.

Just for info: Simon Richter wrote:

Intel B580 on TalosII has trouble growing the BAR with 6.18.

Power management changes should not affect PPC because it is broken anyway =E2=
=80=94 PCIe bridges are assumed to be managed by OpenFirmware, so the "pciep=
ort" driver is not registered, so bridges have no power management, so downs=
tream devices cannot enable it either.

- - -

Thanks,
Christian=


