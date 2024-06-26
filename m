Return-Path: <linux-pci+bounces-9269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E300591797A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122F31C231CD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE31598E3;
	Wed, 26 Jun 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wbjJLIHS"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25145978;
	Wed, 26 Jun 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386274; cv=none; b=LyR5PrUxJRbN/c0V/kpNYrq2xC3mGVWQtcr3nMYKTbEYFmwZJ4lmwWfCVDXqbbGrcvj6XsIFFn9ZgehXUfN5O6w8UJHKrXIdx8na5HuaztqPytDAswdr9PbTbAGGcyd8SKbNM3xkTugn4/tXIqV+Kjw7ElfL/W6hl+4hCx4I4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386274; c=relaxed/simple;
	bh=NNwvsHzCjMXIwRySc9XDZBYK6afUB3U1wQUOdXPORNk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0r2ykrgTnQDA0ZIM16NPomd77E2ff3bWL85X1gs7OyNvhhuXThY+LXPlCQVyk2oZcXBRX/b0kwraNhN5ah+VsjhXAVFrBxkmEz/4TuULLpWmRtkj+KL6RipXgJEfty58csBhuxiNEWz7HSyqdX4gi2Y61eBByNLr0tRQ/HPFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wbjJLIHS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719386272; x=1750922272;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NNwvsHzCjMXIwRySc9XDZBYK6afUB3U1wQUOdXPORNk=;
  b=wbjJLIHShhOc8nG0tLtmbbYUjfgTFadyBqWk4mjVdIf591UDcmzPCF1Q
   4ZCIDX5QDsWTnKrDn+s6LFTCkjuTND4bBDXuwmWaGFYPv86C2r1HQCqhA
   i40cdZmOfzvwY0ry1P04EzNjcnTrukrbuCjHbfI3L9bPRjWr3dqv4Z1Zc
   rBQDdfzTpfB6lFioN+rvyeT16qm++TcPjH+WerhygjN5Bv3iBddx5Ueqr
   ImfrxZSG90Hp5REb4PG1P0OkyuU1VpeoLb1h7ZA5bEg9ctUaoDm/Ec3gR
   8QaXmYcTuLSn0qYOe3KJo7XVRwbKsgW5Jj8a5Ulmalih5o7/zB/tzkays
   g==;
X-CSE-ConnectionGUID: zmiLeBagSOCL5GSsV7txlw==
X-CSE-MsgGUID: rYtxGmevRsiWMD2me9JSwQ==
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="28486986"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2024 00:17:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 26 Jun 2024 00:17:15 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 26 Jun 2024 00:17:09 -0700
Message-ID: <f695618054232c5f43c2148c5e6551f3ab318792.camel@microchip.com>
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Herve Codina <herve.codina@bootlin.com>
CC: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
	<saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Allan Nielsen
	<allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 26 Jun 2024 09:17:11 +0200
In-Reply-To: <e85511af9db9de024b5065eeee77108be474f71e.camel@microchip.com>
References: <20240621184923.GA1398370@bhelgaas>
	 <e85511af9db9de024b5065eeee77108be474f71e.camel@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Bjorn, and Herve,

Bill Mahany from Microchip has now been in contact with PCI-SIG, and
has been able to get confirmation that Vendor ID 0x1055 is still
belonging to Microchip even though this is not visible on their
webpage.

I have attached a snippet of the conversation.

I hope this settles the matter of the Vendor ID 0x1055.

Best Regards
Steen

=3D=3D=3D Copied from the conversation =3D=3D=3D

   Hi Bill,
   =20
   Thank you for your email. We can confirm VID 4181 (1055 Hex) is
   Microchip=E2=80=99s. This is not listed on the website because we are on=
ly
   able to list one VID per company.
   =20
   Please feel free to contact us if you have any questions.
  =20
   Best Regards,
  =20
   PCI-SIG Administration
  =20
   Main: 503-619-0569 | Fax: 503-644-6708
   3855 SW 153rd Drive, Beaverton, OR 97003 USA
   Email: administration@pcisig.com
  =20
  =20
   =20
   www.pcisig.com | Connect with us on LinkedIn and Twitter @pci_sig
   =20
   From: bill.mahany@microchip.com (administration)
   <administration@pcisig.com>
   Sent: Monday, June 24, 2024 11:07 AM
   To: administration@pcisig.com
   Subject: RE: vendor id missing from member companies list
   =20
   Hello once again.
   =20
   Please refer to the below. Could you please reverify that Microchip
   Technology is still in control of 4181 (0x1055).
   =20
   Apparently, the lack of a search result for 4181 (0x1055) at
   https://pcisig.com/membership/member-companiesis
   Is still causing issues in the Linux community -
   https://lore.kernel.org/all/20240621184923.GA1398370@bhelgaas/
   =20
   Thanks
   =20
   Bill Mahany
   =20
On Mon, 2024-06-24 at 13:46 +0200, Steen Hegelund wrote:
> Hi Bjorn,
>=20
> I am not sure what went wrong here.
>=20
> I have seen that lspci lists 'Microchip / SMSC' for the 0x1055 Vendor
> ID value and as mentioned previously there has been a number of
> aquicisions over the years, so that the ID has been absorbed but not
> necessarily re-registered.
>=20
> Anyway I have started an investigation, so we can determine what
> up/down in this.
>=20
> I agree that for now this will have to be PCI_VENDOR_ID_EFAR, and I
> will return with an update as soon as I know more.
>=20
> Best Regards
> Steen
>=20
> On Fri, 2024-06-21 at 13:49 -0500, Bjorn Helgaas wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Fri, Jun 21, 2024 at 05:45:05PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Herve Codina
> > > <herve.codina@bootlin.com> wrote:
> > > > On Thu, 20 Jun 2024 18:43:09 +0200
> > > > Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > On Thu, 20 Jun 2024 18:07:16 +0200
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > On Thu, Jun 20, 2024 at 5:56=E2=80=AFPM Herve Codina
> > > > > > <herve.codina@bootlin.com> wrote:
> > > > > > > On Wed, 5 Jun 2024 23:24:43 +0300
> > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > > > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina
> > > > > > > > kirjoitti:
> >=20
> > > > > > > > > +static struct pci_device_id lan966x_pci_ids[] =3D {
> > > > > > > > > +=C2=A0=C2=A0 { PCI_DEVICE(0x1055, 0x9660) },
> > > > > > > >=20
> > > > > > > > Don't you have VENDOR_ID defined somewhere?
> > > > > > >=20
> > > > > > > No and 0x1055 is taken by PCI_VENDOR_ID_EFAR in pci-ids.h
> > > > > > > but SMSC acquired EFAR late 1990's and MCHP acquired SMSC
> > > > > > > in 2012
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/et=
hernet/microchip/lan743x_main.h#L851
> > > > > > >=20
> > > > > > > I will patch pci-ids.h to create:
> > > > > > > =C2=A0 #define PCI_VENDOR_ID_SMSC PCI_VENDOR_ID_EFAR
> > > > > > > =C2=A0 #define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_SMSC
> > > > > > > As part of this patch, I will update lan743x_main.h to
> > > > > > > remove its own #define
> > > > > > >=20
> > > > > > > And use PCI_VENDOR_ID_MCHP in this series.
> > > > > >=20
> > > > > > Okay, but I don't think (but I haven't checked) we have
> > > > > > something like
> > > > > > this ever done there. In any case it's up to Bjorn how to
> > > > > > implement
> > > > > > this.
> > > >=20
> > > > Right, I wait for Bjorn reply before changing anything.
> > >=20
> > > But we already have the vendor ID with the same value. Even if
> > > the
> > > company was acquired, the old ID still may be used. In that case
> > > an
> > > update on PCI IDs can go in a separate change justifying it. In
> > > any
> > > case, I would really want to hear from Bjorn on this and if
> > > nothing
> > > happens, to use the existing vendor ID for now to speed up the
> > > series
> > > to be reviewed/processed.
> >=20
> > We have "#define PCI_VENDOR_ID_EFAR 0x1055" in pci_ids.h, but
> > https://pcisig.com/membership/member-companies?combine=3D1055=C2=A0show=
s
> > no
> > results, so it *looks* like EFAR/SMSC/MCHP are currently squatting
> > on
> > that ID without it being officially assigned.
> >=20
> > I think MCHP needs to register 0x1055 with the PCI-SIG
> > (administration@pcisig.com) if it wants to continue using it.
> > The vendor is responsible for managing the Device ID space, so this
> > registration includes the burden of tracking all the Device IDs
> > that
> > were assigned by EFAR and SMSC and now MCHP so there are no
> > conflicts.
> >=20
> > I don't want to change the existing PCI_VENDOR_ID_EFAR, and I also
> > don't want to add a PCI_VENDOR_ID_MCHP for 0x1055 until that ID has
> > been registered with the PCI-SIG.
> >=20
> > So I propose that you use PCI_VENDOR_ID_EFAR for now, and if/when
> > MCHP
> > registers 0x1055 with PCI-SIG so it is unambiguously owned by MCHP,
> > we
> > can add "#define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_EFAR" or similar.
> > As Andy points out, this would be a separate logical change in its
> > own
> > patch.
> >=20
> > Bjorn
>=20


