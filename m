Return-Path: <linux-pci+bounces-4094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818A868D06
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42339286D6D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA26137C47;
	Tue, 27 Feb 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=radomirpolach.cz header.i=@radomirpolach.cz header.b="G/+9o/ow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E201384B1
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028649; cv=none; b=ZEpMjrCC45zp+E6QoY55gf199yBIEBvDnzTlGPGcdk1+8QQZ9HIuJ0PrbbDfeM7QHEjIn4ApeRTdeah2gWbNPxWH2g+bzeexTf3JuZtRNAUqMYnWtKxa810HtEaYHxetwV2WTc0cWQjkpxG/ldDXquILZFsEvMleI1swzn5WUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028649; c=relaxed/simple;
	bh=AZIftr687pvw2dFr26PjLoD7IgKtGiMncNZH/STpj1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4zXvSPD8fjo72ss8L/EA/FWYcmArlhoU7xdtPsCzyVCayyFsZ1C0+GJmkD4l+pK88vLD07oYT7F2iYp+O/OsF4sNhxKSQn0vVd1fsHKwXinerJoKrMzXkTgCcxQi4gHnOegweF2aP9WEoAe3JpwxuS6HRTQ/EaSRvuBzLbuOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radomirpolach.cz; spf=pass smtp.mailfrom=radomirpolach.cz; dkim=pass (2048-bit key) header.d=radomirpolach.cz header.i=@radomirpolach.cz header.b=G/+9o/ow; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radomirpolach.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radomirpolach.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=radomirpolach.cz;
	s=protonmail2; t=1709028635; x=1709287835;
	bh=AZIftr687pvw2dFr26PjLoD7IgKtGiMncNZH/STpj1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G/+9o/owVOhONbd2eDi3h+ZtKID4t6GsiC2obzUi0IYpC5aeOjKJIi4AuL5yf4ToF
	 H/MYxiBKghDiAXSXdIAtkC4nsrwPV+enpkVdGBkOL5ThMlCiU3Uwx2UBoRMavcrvSF
	 zuCo34nyBT7ZFU1F7KxM0j4NHVqk1I69HYNoG9eahDHMf1TgvxXdOW+rYJi2FsbXys
	 MrviYvwdoFjoYZuaICFzTX95EtOoz9e3L1RQpxggqi1VBFs0DEu/H/Ul5DsG9R9B2i
	 o1HOLMSCotRJENNdWrNO6JpXZEoaCFYAkfUGDW9v+XuFmeyMp27+xEWgSa51tKlwMF
	 h/nuiak9aKBZQ==
Date: Tue, 27 Feb 2024 10:10:14 +0000
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
From: =?utf-8?Q?Ing=2E_Radom=C3=ADr_Pol=C3=A1ch?= <mail@radomirpolach.cz>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI-e endpoint GPU implementation
Message-ID: <uiFd-b5bqi83xbkdfe9z92Fv4Fka4CA5akSVl6QDQ6W94Y5oq2OsucJgcPuFxnPitVf2dncFS03iXqSIjYByKMdEqaMcrtG2XgH8bbv6PNs=@radomirpolach.cz>
In-Reply-To: <20240227093957.GJ2587@thinkpad>
References: <11bRGBmeRj22pJZUyP2a-6-cKdYhSVPGtHAdWNpCQ--bqhWb4d0n81xlSQtDdQc21UD1zKAvqVwH45gcemleu8bk2aJtcBZ9ElPqkfvVsxQ=@radomirpolach.cz> <20240227093957.GJ2587@thinkpad>
Feedback-ID: 20506470:user:proton
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for the response!

Virtio endpoint support would solve this entirely for me. Will look into vi=
rtio-gpu in the meantime.

Ing. Radom=C3=ADr Pol=C3=A1ch

On Tuesday, February 27th, 2024 at 10:39, manivannan.sadhasivam@linaro.org =
<manivannan.sadhasivam@linaro.org> wrote:

> + linux-pci
>=20
> On Mon, Feb 26, 2024 at 08:05:06PM +0000,
>=20
> Ing. Radom=C3=ADr Pol=C3=A1ch
>=20
> wrote:
>=20
> > Hello,
> >=20
> > I have seen your presentation on kernel PCI-e endpoint drivers:
> > https://www.youtube.com/watch?v=3DL0HktbuTX5o
> >=20
> > And I would like to ask if you know of any PCI-e endpoint GPU implement=
ation or related source.
> >=20
> > What I would like to do is to emulate GPU by writing endpoint driver an=
d offload the GPU rendering to GPU integrated in the SoC. Basically take SB=
C that has SoC with PCI-e endpoint support and use it as GPU.
> >=20
> > I have found several sources for PCI-e endpoint NVMe drivers, but I hav=
e not found anything about GPUs.
>=20
>=20
> Please look into virtio-gpu implementation. We are planning to implement =
the
> virtio support for the endpoint subsystem in the coming days, so adding t=
he
> virtio-gpu driver on top of that would be the way to go.
>=20
> - Mani
>=20
> > Sincerely,
> >=20
> > Ing. Radom=C3=ADr Pol=C3=A1ch
>=20
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=
=E0=AE=AE=E0=AF=8D

