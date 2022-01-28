Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146A49F71A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiA1KSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 05:18:23 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:53459 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347783AbiA1KSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 05:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643365088; x=1674901088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HD8VUoGAefvu5KRKNUGAfMOw0x7r1CIsl8hKJAxyTng=;
  b=Ba2VF7lyvY4uJ/l2a0tQbFMT/F+jhrEYtfJ8aqc3IPckU5uDGxPx3wcp
   qkrhpsfjc6gODuK+G439ceYZyYSrjRrH7feq6oBJT56W7vyQtWyqO/WgE
   OnXTybQw03ugijFCFjjqtImbOvdOWVDOFamlRxjK8JdmYhV/8jtnoLxnw
   Y6uXiWY3dxG6o3dztt/lJWfoTTCmZTh7T72gFivG4RRC4JmplBTTq+yoj
   AiPFJrhGwvGvjlGTwEEgPBPrniVVlH0p5cySLQH27qUYQa+jvUp3j3V1u
   ZTZ/QF+Okzpyn064P/vhhuw0IYgIXX8kJOuXtv3ysm4AcYM855XORWoM1
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="21770186"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Jan 2022 11:18:07 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 28 Jan 2022 11:18:07 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 28 Jan 2022 11:18:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643365087; x=1674901087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HD8VUoGAefvu5KRKNUGAfMOw0x7r1CIsl8hKJAxyTng=;
  b=i+MXVzWZ57kn3vPQPfjb5IaBVnOFkaoW7cS15EnLBiayjF2J1J4eH40k
   5ZTadmalivJvUsv5EvNWvNgG5dfK1pJ6MZJ+ySj2f6vNkbw49uQTzWjNf
   av2zgR6L12nPxMF7jcuZ8lsNWSWWLBsu00opm3bcHarJhuvoZrwqRQYgF
   Ld1+XK+LHexaOYU+nms02naVWI018HbB8Rrq4EUtk7KzhJMKjzIdZTqPe
   osDnbgTuGLAqf5ZNB9jN3vIVWKZ7zGruiAeMyRF1YWtbE9uv6XOd2LYb1
   Bti1jChU5JVl/G2tFuycAT5XrOmRDYOx8Dw2uGUTDGBtLwi8O4pUFilPV
   w==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="21770185"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jan 2022 11:18:07 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DEF61280065;
        Fri, 28 Jan 2022 11:18:06 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: (EXT) RE: [RFC PATCH] PCI: imx6: Handle the abort from user-space
Date:   Fri, 28 Jan 2022 11:18:04 +0100
Message-ID: <4621593.CQOukoFCf9@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <AS8PR04MB8676E90C0A394C82BB0A890B8C229@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220128082920.591115-1-francesco.dolcini@toradex.com> <AS8PR04MB8676E90C0A394C82BB0A890B8C229@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, 28. Januar 2022, 10:25:11 CET schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Sent: 2022=E5=B9=B41=E6=9C=8828=E6=97=A5 16:29
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > <l.stach@pengutronix.de>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> > Rob
 Herring <robh@kernel.org>; Krzysztof Wilczy=C5=84ski <kw@linux.com>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; Jason Liu <jason.hui.liu@nxp.com>
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Shawn
> > Guo <shawnguo@kernel.org>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>
> > Subject: [RFC PATCH] PCI: imx6: Handle the abort from user-space
> >=20
> > From: Jason Liu <jason.hui.liu@nxp.com>
> >=20
> > The driver install one hook to handle the external abort, but issue is
> > that if the
 abort introduced from user space code, the following code
> > unsigned long instr =3D *(unsigned long *)pc; which will created another
> > data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.
> >=20
> > The patch does not intent to use copy_from_user and then do the hack due
> > to
 the security consideration. In fact, we can just return and report
> > the external abort to user-space.
> >=20
> > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > We have this patch from NXP downstream kernel [1] in our kernel branch
> > [2]
> > since a long time, to me it would make sense to upstream it. Any concer=
n?
> >=20
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
rce.
> > codeaurora.org%2Fexternal%2Fimxsupport%2Flinux-imx%2Fcommit%2F%3Fid
> > %3D62dfb2fb953463dd1b6710567c9e174672a98f24&amp;data=3D04%7C01%7
> > Chongxing.zhu%40nxp.com%7Ccbe193ab4c3e4ad11bcb08d9e2384a1f%7C68
> > 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637789553659549198%7
> > CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> > iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DMwhx8DFF7EDJdpqTsHT
> > %2BBAGzhQadDOqcgJnVjeoi1yk%3D&amp;reserved=3D0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
=2Etora
> >=20
> > dex.com%2Fcgit%2Flinux-toradex.git%2Fcommit%2F%3Fid%3D2b42547cf659f
> > 979be2defdff6a99f921b33d0f1&amp;data=3D04%7C01%7Chongxing.zhu%40nx
> > p.com%7Ccbe193ab4c3e4ad11bcb08d9e2384a1f%7C686ea1d3bc2b4c6fa92c
> > d99c5c301635%7C0%7C0%7C637789553659549198%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C3000&amp;sdata=3DQEW1frh8WacCzniWo4ng1cy3Z1UZ9uMRFw
> > GBKuIh7zE%3D&amp;reserved=3D0
> > ---
> >=20
> >  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> >=20
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 6974bd5aa116..6b178a29e253 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -27,6 +27,7 @@
> >=20
> >  #include <linux/resource.h>
> >  #include <linux/signal.h>
> >  #include <linux/types.h>
> >=20
> > +#include <linux/uaccess.h>
>=20
>=20
> [Richard Zhu] Thanks for your kindly help.
> This header include is not required actually, please remove it.

It should be <linux/ptrace.h> instead, for using user_mode().
Best regards,
Alexander


> >  #include <linux/interrupt.h>
> >  #include <linux/reset.h>
> >  #include <linux/phy/phy.h>
> >=20
> > @@ -297,8 +298,15 @@ static int imx6q_pcie_abort_handler(unsigned long
> > addr,
> >=20
> >  		unsigned int fsr, struct pt_regs *regs)  {
> >  =09
> >  	unsigned long pc =3D instruction_pointer(regs);
> >=20
> > -	unsigned long instr =3D *(unsigned long *)pc;
> > -	int reg =3D (instr >> 12) & 15;
> > +	unsigned long instr;
> > +	int reg;
> > +
> > +	/* if the abort from user-space, just return and report it */
> > +	if (user_mode(regs))
> > +		return 1;
> > +
> > +	instr =3D *(unsigned long *)pc;
> > +	reg =3D (instr >> 12) & 15;
> >=20
> >=20
> >  	/*
> >  =09
> >  	 * If the instruction being executed was a read,
> >=20
> > --
> > 2.25.1
>=20
>=20




