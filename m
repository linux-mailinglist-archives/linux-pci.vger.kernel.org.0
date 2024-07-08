Return-Path: <linux-pci+bounces-9928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44B92A399
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFD41F21DF8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BFA13774A;
	Mon,  8 Jul 2024 13:26:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF70B665
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445200; cv=none; b=EZtVZJocM1kHszlF3nmsXVRVxL4pnOFbYoUxkKeMi6G48g3PR0UfdOV6l8lJFnn04V0MvgR72OK9FrDVkBrXcrgg+HHznpV1qiD3SS4nn+2RcVZo1GiL2PY0ll/OQO0bHbsg4jmebnTJSk4lz1ns7Gf1kUcF/dKpZoWV6+10PaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445200; c=relaxed/simple;
	bh=AvFqGfbnluOKabfJ1gbc14MMS0SNBJ1bdZX+YIROD1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WErsNBvr3gz/8oGOK47hDd/GKQAP8xyiQpVlbkFZPi3ChGNI79zgMa09jMENSSC1bbkfaqSWIMtshzrGew8qFAM8I7F73zyN7tsrg5B0UoudWfpyMHbaPKhQA+8QEGsvVIO1WaHexvfSzP89LlhsLu89lIU9GtK76yuPbnFdkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQoNn-0000eo-AU; Mon, 08 Jul 2024 15:26:19 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQoNl-0083J2-Sg; Mon, 08 Jul 2024 15:26:17 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQoNl-000AG3-2b;
	Mon, 08 Jul 2024 15:26:17 +0200
Message-ID: <39583bdf7e79d33240e7dd5f09123b94cab4147c.camel@pengutronix.de>
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stanimir Varbanov <svarbanov@suse.de>, Jim Quinlan
	 <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Cyril Brulebois <kibi@debian.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,  Florian
 Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>, "moderated list:BROADCOM
 BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 08 Jul 2024 15:26:17 +0200
In-Reply-To: <f89d7f45-5d2b-4d8b-9d6a-2d83cd584756@suse.de>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
	 <20240703180300.42959-5-james.quinlan@broadcom.com>
	 <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
	 <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
	 <7b03c38f44f295a5484d0162a193f41b39039b85.camel@pengutronix.de>
	 <f89d7f45-5d2b-4d8b-9d6a-2d83cd584756@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hi Stanimir,

On Mo, 2024-07-08 at 14:14 +0300, Stanimir Varbanov wrote:
> Hi Philipp,
>=20
> On 7/8/24 12:37, Philipp Zabel wrote:
> > On Fr, 2024-07-05 at 13:46 -0400, Jim Quinlan wrote:
> > > On Thu, Jul 4, 2024 at 8:56=E2=80=AFAM Stanimir Varbanov <svarbanov@s=
use.de> wrote:
> > > >=20
> > > > Hi Jim,
> > > >=20
> > > > On 7/3/24 21:02, Jim Quinlan wrote:
> > > > > The 7712 SOC adds a software init reset device for the PCIe HW.
> > > > > If found in the DT node, use it.
> > > > >=20
> > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/=
controller/pcie-brcmstb.c
> > > > > index 4104c3668fdb..69926ee5c961 100644
> > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > @@ -266,6 +266,7 @@ struct brcm_pcie {
> > > > >       struct reset_control    *rescal;
> > > > >       struct reset_control    *perst_reset;
> > > > >       struct reset_control    *bridge;
> > > > > +     struct reset_control    *swinit;
> > > > >       int                     num_memc;
> > > > >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > > > >       u32                     hw_rev;
> > > > > @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platform=
_device *pdev)
> > > > >               dev_err(&pdev->dev, "could not enable clock\n");
> > > > >               return ret;
> > > > >       }
> > > > > +
> > > > > +     pcie->swinit =3D devm_reset_control_get_optional_exclusive(=
&pdev->dev, "swinit");
> > > > > +     if (IS_ERR(pcie->swinit)) {
> > > > > +             ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pcie->swi=
nit),
> > > > > +                                 "failed to get 'swinit' reset\n=
");
> > > > > +             goto clk_out;
> > > > > +     }
> > > > >       pcie->rescal =3D devm_reset_control_get_optional_shared(&pd=
ev->dev, "rescal");
> > > > >       if (IS_ERR(pcie->rescal)) {
> > > > >               ret =3D PTR_ERR(pcie->rescal);
> > > > > @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platform=
_device *pdev)
> > > > >               goto clk_out;
> > > > >       }
> > > > >=20
> > > > > +     ret =3D reset_control_assert(pcie->swinit);
> > > > > +     if (ret) {
> > > > > +             dev_err_probe(&pdev->dev, ret, "could not assert re=
set 'swinit'\n");
> > > > > +             goto clk_out;
> > > > > +     }
> > > > > +     ret =3D reset_control_deassert(pcie->swinit);
> > > > > +     if (ret) {
> > > > > +             dev_err(&pdev->dev, "could not de-assert reset 'swi=
nit' after asserting\n");
> > > > > +             goto clk_out;
> > > > > +     }
> > > >=20
> > > > why not call reset_control_reset(pcie->swinit) directly?
> > > Hi Stan,
> > >=20
> > > There is no reset_control_reset() method defined for reset-brcmstb.c.
> > > The only reason I can
> > > think of for this is that it allows the callers of assert/deassert to
> > > insert a delay if desired.
> >=20
> > The main reason for the existence of reset_control_reset() is that
> > there are reset controllers that can only be triggered (e.g. by writing
> > a bit to a self-clearing register) to produce a complete reset pulse,
> > with assertion, delay, and deassertion all handled by the reset
> > controller.
>=20
> Got it. Thank you for explanation.
>=20
> But, IMO that means that the consumer driver should have knowledge of
> low-level reset implementation, which is not generic API?

Kind of. If the reset controller hardware has self-clearing resets, it
is impossible to implement manual reset_control_assert/deassert() on
top. So if a reset consumer requires that level of control, it just
can't work with a self-deasserting controller. The other way around, a
reset controller driver can emulate self-deasserting resets, iff it
knows the timing requirements of all consumers.

If the reset consumer only needs to see a pulse on the reset line, and
there are no ordering requirements with other resets or clocks, and the
device either doesn't care about timing or the reset controller knows
how to produce the required delay, then using reset_control_reset()
would be semantically correct.

> Otherwise, I don't see a problem to implement asset/deassert sequence in
> .reset op in this particular reset-brcmstb.c low-level driver.

When reset_control_reset() is used, every reset controller that can be
paired with this consumer needs to implement the .reset method,
requiring to know the delay requirements for all of their consumers.
The reset-simple driver implements this with a configurable worst-case
delay, for example. As far as I can see, that has never been used.

So yes, in this particular case, pcie-brcmstb only ever being paired
with reset-brcmstb, it might be no problem to implement .reset in
reset-brcmstb correctly, if all its consumers and their required delays
are known.

regards
Philipp

