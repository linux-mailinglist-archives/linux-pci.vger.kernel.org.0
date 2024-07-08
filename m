Return-Path: <linux-pci+bounces-9917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6256929F3E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF731F23AFC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38403307B;
	Mon,  8 Jul 2024 09:37:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFE55E58
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431476; cv=none; b=aK9l8dnO7U+HrWJflf6gHBuTCeru/Z5kmFB8lzjj/qfDbIanUJCRfferuPfsCMputOImisEwoD3ptzc4NvwCdFPKEpzB9S3obBVbdyGzPbdiHPL0kCyMYv24rbe+ajMa5phn2mh5DOyD1WLtwVtWlhTMWoAeuykKI19W1kORrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431476; c=relaxed/simple;
	bh=DXnAO9oTLT+9nHV2nOnL2+Hmnnpe2sgFkKUdaKBOwkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8EyXSXkfo2+1FAbaUuADr7QeH6Nc/WyA+9qjPRiIUEzfGRXzvGIqTGbAL7r3PLT4WHqqYVd4YsUcGtmV7OKhQRgEFj6GN57TQPcsultp/O49vJAaEZlPa5XnQBck2nMO8l+HHgFU/v3zGGBhwP67G0e2aYLgjHfAY2ajfLJ4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQko6-000785-St; Mon, 08 Jul 2024 11:37:14 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQko5-0080kk-Js; Mon, 08 Jul 2024 11:37:13 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sQko5-00058U-1i;
	Mon, 08 Jul 2024 11:37:13 +0200
Message-ID: <7b03c38f44f295a5484d0162a193f41b39039b85.camel@pengutronix.de>
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jim Quinlan <james.quinlan@broadcom.com>, Stanimir Varbanov
	 <svarbanov@suse.de>
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
Date: Mon, 08 Jul 2024 11:37:13 +0200
In-Reply-To: <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
	 <20240703180300.42959-5-james.quinlan@broadcom.com>
	 <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
	 <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
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

On Fr, 2024-07-05 at 13:46 -0400, Jim Quinlan wrote:
> On Thu, Jul 4, 2024 at 8:56=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.=
de> wrote:
> >=20
> > Hi Jim,
> >=20
> > On 7/3/24 21:02, Jim Quinlan wrote:
> > > The 7712 SOC adds a software init reset device for the PCIe HW.
> > > If found in the DT node, use it.
> > >=20
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/cont=
roller/pcie-brcmstb.c
> > > index 4104c3668fdb..69926ee5c961 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -266,6 +266,7 @@ struct brcm_pcie {
> > >       struct reset_control    *rescal;
> > >       struct reset_control    *perst_reset;
> > >       struct reset_control    *bridge;
> > > +     struct reset_control    *swinit;
> > >       int                     num_memc;
> > >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > >       u32                     hw_rev;
> > > @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platform_dev=
ice *pdev)
> > >               dev_err(&pdev->dev, "could not enable clock\n");
> > >               return ret;
> > >       }
> > > +
> > > +     pcie->swinit =3D devm_reset_control_get_optional_exclusive(&pde=
v->dev, "swinit");
> > > +     if (IS_ERR(pcie->swinit)) {
> > > +             ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit)=
,
> > > +                                 "failed to get 'swinit' reset\n");
> > > +             goto clk_out;
> > > +     }
> > >       pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->=
dev, "rescal");
> > >       if (IS_ERR(pcie->rescal)) {
> > >               ret =3D PTR_ERR(pcie->rescal);
> > > @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platform_dev=
ice *pdev)
> > >               goto clk_out;
> > >       }
> > >=20
> > > +     ret =3D reset_control_assert(pcie->swinit);
> > > +     if (ret) {
> > > +             dev_err_probe(&pdev->dev, ret, "could not assert reset =
'swinit'\n");
> > > +             goto clk_out;
> > > +     }
> > > +     ret =3D reset_control_deassert(pcie->swinit);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "could not de-assert reset 'swinit'=
 after asserting\n");
> > > +             goto clk_out;
> > > +     }
> >=20
> > why not call reset_control_reset(pcie->swinit) directly?
> Hi Stan,
>=20
> There is no reset_control_reset() method defined for reset-brcmstb.c.
> The only reason I can
> think of for this is that it allows the callers of assert/deassert to
> insert a delay if desired.

The main reason for the existence of reset_control_reset() is that
there are reset controllers that can only be triggered (e.g. by writing
a bit to a self-clearing register) to produce a complete reset pulse,
with assertion, delay, and deassertion all handled by the reset
controller.

regards
Philipp

