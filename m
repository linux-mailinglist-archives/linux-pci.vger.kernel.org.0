Return-Path: <linux-pci+bounces-38330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F346BE2ED5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB11A640F7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F60342CB5;
	Thu, 16 Oct 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Lb9Ayz1D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D25341AB1
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611536; cv=pass; b=MXpgIJkig2U8YL5dSl9F4gF7IZmWNP2w0LTQYa20L0YGTgE/VOGZ1fTYAQgvEwxo3PuJIU2TzD4aV7EmCz8CLckSSG4F/LlKkA0I8eRhpFNucB5WnHPnHVoz9hB+ch7EjsE9tcRpTvoVZNAtvKYrT6xaVK28V/Nt36wKwb2fuFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611536; c=relaxed/simple;
	bh=0+Eri/TpZ9fsThEcu/LGojwEhPU/LNAxeQR1cKjLRUA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GN6ayhM4R9g9BsrHU5mna1o0l/Udgbnk2XLbogwKmB4lEkc2OqGCYuK0UXrzfO/08bfy3Ca1T2cJLLtUnkFxJo/VlPjJZfu8cB9rfyw2VMUxDXXLrROZPTqS1llWhq1rIyrywH3KM5tekAtBcot6+l/0htCansz4fz/2loldS2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Lb9Ayz1D; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760611511; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kgRmJhBY+/cZ7Zx+zFdReelCwqYh+oPrLOyMrge3zxrfpu45o1BOz86zaUaqoJRXIC
    3lXxFvnH/Y55RErTDlVn+ElU9kRHbgyHhx+gXy9zhsNnfeRB8NHtAWNRWNJCy0P27W1o
    TJGw27DxgXy8EvnWVAX67rTVaM9WgYbZNp/e8H2SFRUQhIwwsiFTHaFIZSjLYCIoN1dJ
    OjKCZEXSVmJl/IENHn4rLERSW993nU9YnCz1BCM6BwIn4ihV3Lfk1Up00uLEMXFIbHJF
    z34qaofNCUymv4H4BjS0Y6t3NES7DJEOlic2PvDoOS/pagbnQCgSr7nYwV0mj84c2X2S
    PsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760611511;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0+Eri/TpZ9fsThEcu/LGojwEhPU/LNAxeQR1cKjLRUA=;
    b=qdd19+QB1LWdk3ea2PbhmcA908TdutVqXmxQ+0+Y0ZAooa7ubQIGO++hpnXonoAegS
    ln6utpOa7Q2L/8GW76aRPoVyySGqhbK1j+6JqoSpjyn0Yy1z1Sbf6yGyj9SpO7goJmx1
    PvMMwE2kgYGKYEtGcXhaSQaWg2wHdCuPD1pVEKbD1nxlrQ9rJes23tUccyVwa7MdC42W
    k4wTX5G3viZqeCqB+CT4MUvBHIsov//XVENs6sd/EJez3yzeV1ExIWMRGI+hyDQ2PXD0
    RPrvJM3fkkMiIDJC0rNdtDzbg5yuBXoYX8mg6lIdy96fUrEsuDgmw1lbX0JQaLFW+0Az
    QEmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760611511;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0+Eri/TpZ9fsThEcu/LGojwEhPU/LNAxeQR1cKjLRUA=;
    b=Lb9Ayz1DVj/joNBEgULbw3HzrTMSFSYEomV1P29D+NSRTNY4bYtuGbvhGnm48GEtPe
    2aYYVpYUmrG6BaVRk9rLMaRn109TIm+MVqUG8WMOhGg0WxCz8d/n69rRKQnMcPm2N3+d
    3fd3U0+rk05Cz+hHGDvfIPlPh7xOc7UWOqP9vXleI9SUXkAB7oJrVF7UL+2m9Jsx45UE
    sTNq5VQbQdAPsZb15qpGoQOuLHhGlzTPQOl+I6yeTj3MDdyXNQgwutI1Yua8KJf+F59n
    SrUXJmicTS/7JsnWISxHKhcyOR2wbJr4FAlAtbOrWyLEBs7fuk4nIGoEngCZfhV+V4Gt
    NIKg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5iys3LBXHQhT9oAbY5gi9kPmpZaJCQDfE3RBQ0="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619GAj9cdy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Oct 2025 12:45:09 +0200 (CEST)
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
Date: Thu, 16 Oct 2025 12:44:59 +0200
Message-Id: <6E949EB0-CC46-4B08-80BA-706FBD23D256@xenosoft.de>
References: <oholvk65xtm5wlyfbx7vsi4zpmbuvih3kqblfcvt2yrw6qr5wo@zzpghtqp6cg6>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <oholvk65xtm5wlyfbx7vsi4zpmbuvih3kqblfcvt2yrw6qr5wo@zzpghtqp6cg6>
To: Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: iPhone Mail (23A355)


> On 16 October 2025 at 09:53 am, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
>=20
> =EF=BB=BFOn Thu, Oct 16, 2025 at 09:36:29AM +0200, Christian Zigotzky wrot=
e:
>> Is it possible to create an option in the kernel config that enables or d=
isables the power management for PCI and PCI Express?
>> If yes, then I don=E2=80=99t need to revert the changes due to boot issue=
s and less performance.
>>=20
>=20
> Wouldn't the existing CONFIG_PCIEASPM_* Kconfig options not work for you? T=
hey
> can still override this patch.
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=
=8D

Hi Mani,

I will try it.

Thanks,
Christian=


