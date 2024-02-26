Return-Path: <linux-pci+bounces-4052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F048680DA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 20:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B40B2A9F1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88212F361;
	Mon, 26 Feb 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="QyS7hGWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6D12BF27;
	Mon, 26 Feb 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974966; cv=none; b=pt9X7s+JsrzsgCugxdLOdWdJlA3GKI0D3YeQz1VAk9oHN9ZPUEtU3h4agku2Ra5loOHKcrEXSUWnryH1anbbBxWXnUD56Ow3gDHPgOmRpa8sU+wRvm1LdWZ5lqJNmZYDfr3aATceqlGqQ21Jl7VTdvtoQTw3p/7sQKqvJaoiqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974966; c=relaxed/simple;
	bh=O0ZIo6cxxJHxd5FG0ZXs1D3kPCmDGTjZpf2SePW4mK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1uuwnBnW1GX4cc1Q5iqSicrBDaIQdGQIZ5PU5gqVcf5IasZXO93FGADeCaqV0GF+yYcyIue75KWMf32+GzS5LsV9wRms9nE2uRJbYN9fcKK0828BjsYslBgXkyKMvsWKFxktikMIYUrMyIzW+s5/e90fJWrnkHJA0k64MP9QzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=QyS7hGWI; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=OTrgJSJ1jDEPsGQxe8NHCf/xZH4XRsuoxTPG/b1FsiA=; b=QyS7hGWI1LCToHyw7V9iQMYHun
	l7QpKUvlkFmqUnyTqBxsxezsPT4BE+q4DF+ZiOHNgkEOdd8bjWVEhO6cizyxFAEZD2mOdPidhrH+h
	nQxqOMMVb51ZFFZwIrzRq1MkLntB29UnFBXaPsZhaCNAuay4/FZCAZ+le/Uw8oAVxwITbFd+zmCqc
	g3N+RXuLRLwlgKmLTPF2bgYqVpcsH1tm/ZRxHby6c6AQlRinRmt9CSBuY/Bh8MX4iXWzL32pV3Ys+
	74cpgV+eN6Wyzdbqmf88v1Y8Qc6qqD/eWTDsuAKtzWdrKACXsmtwDfRccbUmBuQxUVQVaQ/a+yBai
	xAQaB4hw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1reflL-004AMc-1u;
	Mon, 26 Feb 2024 19:31:39 +0100
Date: Mon, 26 Feb 2024 19:31:38 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Message-ID: <ZdzZClVcyHXKwsUJ@aurel32.net>
Mail-Followup-To: Minda Chen <minda.chen@starfivetech.com>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <20240218101831.113469-1-minda.chen@starfivetech.com>
 <20240218101831.113469-2-minda.chen@starfivetech.com>
 <SHXPR01MB0863FCE82CA2155E52A3EB6FE650A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CAEn-LTphwFA6KgCZWsqiMMob2Xw4t4sCZ70U0u0z2=yJOpyGHA@mail.gmail.com>
 <SHXPR01MB0863DBBEB8C6AD12F3C0056DE657A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SHXPR01MB0863DBBEB8C6AD12F3C0056DE657A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,

On 2024-02-21 10:10, Minda Chen wrote:
>=20
>=20
> >=20
> > On Tue, Feb 20, 2024 at 1:02=E2=80=AFPM Minda Chen <minda.chen@starfive=
tech.com>
> > wrote:
> > >
> > >
> > > >
> > > > As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
> > > > plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an
> > > > interrupt controller.
> > > >
> > > > Microchip PolarFire PCIE event IRQs includes PLDA interrupts and
> > > > Polarfire their own interrupts. The interrupt irqchip ops includes
> > > > ack/mask/unmask interrupt ops, which will write correct registers.
> > > > Microchip Polarfire PCIe additional interrupts require to write
> > > > Polarfire SoC self-defined registers. So Microchip PCIe event irqch=
ip ops can
> > not be re-used.
> > > >
> > > > To support PLDA its own event IRQ process, implements PLDA irqchip
> > > > ops and add event irqchip field to struct pcie_plda_rp.
> > > >
> > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../pci/controller/plda/pcie-microchip-host.c | 66 +++++++++++++++=
+++-
> > > >  drivers/pci/controller/plda/pcie-plda.h       |  3 +
> > > >  2 files changed, 68 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > index b3df373a2141..beaf5c27da84 100644
> > > > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > > @@ -770,6 +770,64 @@ static struct irq_chip mc_event_irq_chip =3D {
> > > >       .irq_unmask =3D mc_unmask_event_irq,  };
> > > >
> > > Hi Thomas
> > >   I think this patch code it is easy to review. If you busy, Could you
> > > let other IRQ maintainer review? Thanks.
> > >
> > > Hi Lorenzo, Bjorn and Krzysztof
> >=20
> > Hi Minda,
> >=20
> > This patchset seems to have broken threading (lore, mailman). I have se=
en other
> > folks on IRC mentioning that too.
> >=20
> > I am not sure if that requires re-sending, but let's wait for others to=
 comment.
> >=20
> > Cheers,
> > david
> >=20
> Do you mean the auto test error in linux-riscv?=20
> I can see that. But In v14 resend version, There is no error. Version 15 =
just add
> a new patch. Other no change. It is very strange.
> If not this error, I will waiting others comment.

V15 is wrongly threaded:
- Patch 2 has no In-Reply-To / In-Reply-To headers
- Patch 3 to 13 reference patch 2 instead of the cover letter
- Patch 14 has no In-Reply-To / In-Reply-To headers
- Patch 15 references patch 14 instead of the cover letter
- Patch 16 has no In-Reply-To / In-Reply-To headers
- Patch 17 to 23 reference patch 17 instead of the cover letter

Said otherwise, the patches appears as (sorry for the long lines):

[PATCH v15 00/23] Refactoring Microchip PCIe driver and add StarFive PCIe
=E2=94=94=E2=94=80>[PATCH v15 01/23] dt-bindings: PCI: Add PLDA XpressRICH =
PCIe host common properties
[PATCH v15 02/23] PCI: microchip: Move pcie-microchip-host.c to plda direct=
ory
=E2=94=9C=E2=94=80>[PATCH v15 03/23] PCI: microchip: Move PLDA IP register =
macros to pcie-plda.h
=E2=94=9C=E2=94=80>[PATCH v15 04/23] PCI: microchip: Add bridge_addr field =
to struct mc_pcie
=E2=94=9C=E2=94=80>[PATCH v15 05/23] PCI: microchip: Rename two PCIe data s=
tructures
=E2=94=9C=E2=94=80>[PATCH v15 06/23] PCI: microchip: Move PCIe host data st=
ructures to plda-pcie.h
=E2=94=9C=E2=94=80>[PATCH v15 07/23] PCI: microchip: Rename two setup funct=
ions
=E2=94=9C=E2=94=80>[PATCH v15 08/23] PCI: microchip: Change the argument of=
 plda_pcie_setup_iomems()
=E2=94=9C=E2=94=80>[PATCH v15 09/23] PCI: microchip: Move setup functions t=
o pcie-plda-host.c
=E2=94=9C=E2=94=80>[PATCH v15 10/23] PCI: microchip: Rename interrupt relat=
ed functions
=E2=94=9C=E2=94=80>[PATCH v15 11/23] PCI: microchip: Add num_events field t=
o struct plda_pcie_rp
=E2=94=9C=E2=94=80>[PATCH v15 12/23] PCI: microchip: Add request_event_irq(=
) callback function
=E2=94=94=E2=94=80>[PATCH v15 13/23] PCI: microchip: Add INTx and MSI event=
 num to struct plda_event
[PATCH v15 14/23] PCI: microchip: Add get_events() callback and add PLDA ge=
t_event()
=E2=94=94=E2=94=80>[PATCH v15 15/23] PCI: microchip: Add event irqchip fiel=
d to host port and add PLDA irqchip
[PATCH v15 16/23] PCI: microchip: Move IRQ functions to pcie-plda-host.c
=E2=94=9C=E2=94=80>[PATCH v15 17/23] PCI: plda: Add event bitmap field to s=
truct plda_pcie_rp
=E2=94=9C=E2=94=80>[PATCH v15 18/23] PCI: plda: Add host init/deinit and ma=
p bus functions
=E2=94=9C=E2=94=80>[PATCH v15 19/23] dt-bindings: PCI: Add StarFive JH7110 =
PCIe controller
=E2=94=9C=E2=94=80>[PATCH v15 20/23] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT=
_MS waiting time value
=E2=94=9C=E2=94=80>[PATCH v15 21/23] PCI: starfive: Add JH7110 PCIe control=
ler
=E2=94=9C=E2=94=80>[PATCH v15 22/23] PCI: starfive: Offload the NVMe timeou=
t workaround to host drivers.
=E2=94=94=E2=94=80>[PATCH v15 23/23] riscv: dts: starfive: add PCIe dts con=
figuration for JH7110

I *think* it is the reason why some tools are not able to consider all
the patches as a single patchset.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

