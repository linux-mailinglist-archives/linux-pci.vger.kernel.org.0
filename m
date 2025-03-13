Return-Path: <linux-pci+bounces-23588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5EA5EE91
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD933B0A63
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81513262D03;
	Thu, 13 Mar 2025 08:54:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911A1FBE86
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856089; cv=none; b=StophNuh2ui9CCPn5aUNfPI3i16iVVFMjXrPpGb9Jc8p6Av6rrmzzUhCawTYWyAy4XmiAbQfsBqGDdVYuQF2q4tVYOOni7bGOxMHBXf8Biu3XdO8k9eUeW2DD+uM2yajlbl3v4/K5kRUAMIfGkMq4QbGHmyylBZLC1khtiHGf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856089; c=relaxed/simple;
	bh=z4kFVAh8ZwdeetGifHupttht3HiRwRg8if5+O9Ubfv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SHBHEg7vzmSvR7J8TIQ3TBW1RVBujEBAqEjhqlvQyPL9AdWSKJABPkIOhih2iLc9fWyRFzcIZv7sdeq6KLLg2z9SEtFUVVAsDJ/H0M3o0T7UHQFrHCWXDXDBLnDpa79U4+8ERHllOVdCX3bDnPW/KIihLDu/ANKa8TgvGNMWvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tseKg-00021i-Us; Thu, 13 Mar 2025 09:54:26 +0100
Message-ID: <b425a7c7a7d6508daf23fe7046864a498029a7ac.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the
 hardcodes
From: Lucas Stach <l.stach@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
  "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,  "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,  "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,  "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 13 Mar 2025 09:54:25 +0100
In-Reply-To: <Z9GYm/jp9VIhCEeY@lizhi-Precision-Tower-5810>
References: 
	<AS8PR04MB8676E66BD40C37B2A7E390178CD12@AS8PR04MB8676.eurprd04.prod.outlook.com>
	 <20250311155452.GA629749@bhelgaas>
	 <DU2PR04MB8677AC699DF11D847AB768708CD02@DU2PR04MB8677.eurprd04.prod.outlook.com>
	 <fcb5f09f8e4311c7a6ef60aaf3cb4e3f05a8f05e.camel@pengutronix.de>
	 <Z9GYm/jp9VIhCEeY@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Am Mittwoch, dem 12.03.2025 um 10:22 -0400 schrieb Frank Li:
> On Wed, Mar 12, 2025 at 09:28:02AM +0100, Lucas Stach wrote:
> > Am Mittwoch, dem 12.03.2025 um 04:05 +0000 schrieb Hongxing Zhu:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: 2025=E5=B9=B43=E6=9C=8811=E6=97=A5 23:55
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > > kw@linux.com; manivannan.sadhasivam@linaro.org; bhelgaas@google.com=
;
> > > > s.hauer@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.=
org;
> > > > linux-pci@vger.kernel.org; imx@lists.linux.dev; kernel@pengutronix.=
de;
> > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace th=
e
> > > > hardcodes
> > > >=20
> > > > On Tue, Mar 11, 2025 at 01:11:04AM +0000, Hongxing Zhu wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 23:11
> > > > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > > > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > > > > shawnguo@kernel.org; l.stach@pengutronix.de; lpieralisi@kernel.=
org;
> > > > > > kw@linux.com; manivannan.sadhasivam@linaro.org;
> > > > bhelgaas@google.com;
> > > > > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > > > imx@lists.linux.dev; kernel@pengutronix.de;
> > > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.=
org
> > > > > > Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replac=
e the
> > > > > > hardcodes
> > > > > >=20
> > > > > > On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > > > > > > Use the domain number replace the hardcodes to uniquely ident=
ify
> > > > > > > different controller on i.MX8MQ platforms. No function change=
s.
> > > > > > >=20
> > > > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++------=
--
> > > > > > > =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > index 90ace941090f..ab9ebb783593 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > > > @@ -41,7 +41,6 @@
> > > > > > > =C2=A0#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> > > > > > > =C2=A0#define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> > > > > > > =C2=A0#define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11,
> > > > 8)
> > > > > > > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> > > > > > >=20
> > > > > > > =C2=A0#define IMX95_PCIE_PHY_GEN_CTRL			0x0
> > > > > > > =C2=A0#define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > > > > > > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct
> > > > > > > platform_device
> > > > > > *pdev)
> > > > > > > =C2=A0	struct dw_pcie *pci;
> > > > > > > =C2=A0	struct imx_pcie *imx_pcie;
> > > > > > > =C2=A0	struct device_node *np;
> > > > > > > -	struct resource *dbi_base;
> > > > > > > =C2=A0	struct device_node *node =3D dev->of_node;
> > > > > > > =C2=A0	int i, ret, req_cnt;
> > > > > > > =C2=A0	u16 val;
> > > > > > > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct
> > > > > > platform_device *pdev)
> > > > > > > =C2=A0			return PTR_ERR(imx_pcie->phy_base);
> > > > > > > =C2=A0	}
> > > > > > >=20
> > > > > > > -	pci->dbi_base =3D devm_platform_get_and_ioremap_resource(pd=
ev,
> > > > 0,
> > > > > > &dbi_base);
> > > > > > > -	if (IS_ERR(pci->dbi_base))
> > > > > > > -		return PTR_ERR(pci->dbi_base);
> > > > > >=20
> > > > > > This makes me wonder.
> > > > > >=20
> > > > > > IIUC this means that previously we set controller_id to 1 if th=
e
> > > > > > first item in devicetree "reg" was 0x33c00000, and now we will =
set
> > > > > > controller_id to 1 if the devicetree "linux,pci-domain" propert=
y is 1.
> > > > > > This is good, but I think this new dependency on the correct
> > > > > > "linux,pci-domain" in devicetree should be mentioned in the com=
mit log.
> > > > > >=20
> > > > > > My bigger worry is that we no longer set pci->dbi_base at all. =
 I
> > > > > > see that the only use of pci->dbi_base in pci-imx6.c was to
> > > > > > determine the controller_id, but this is a DWC-based driver, an=
d the
> > > > > > DWC core certainly uses
> > > > > > pci->dbi_base.  Are we sure that none of those DWC core paths a=
re
> > > > > > important to pci-imx6.c?
> > > > > Hi Bjorn:
> > > > > Thanks for your concerns.
> > > > > Don't worry about the assignment of pci->dbi_base.
> > > > > If pci-imx6.c driver doesn't set it. DWC core driver would set it=
 when
> > > > > =C2=A0dw_pcie_get_resources() is invoked.
> > > >=20
> > > > Great, thanks!  Maybe we can amend the commit log to mention that a=
nd
> > > > the new "linux,pci-domain" dependency.
> > > How about the following updates of the commit log?
> > >=20
> > > Use the domain number replace the hardcodes to uniquely identify
> > > different controller on i.MX8MQ platforms. No function changes.
> > > Please make sure the " linux,pci-domain" is set for i.MX8MQ correctly=
, since
> > > =C2=A0the controller id is relied on it totally.
> > >=20
> > This breaks running a new kernel on an old DT without the
> > linux,pci-domain property, which I'm absolutely no fan of. We tried
> > really hard to keep this way around working in the i.MX world.
>=20
> 8MQ already add linux,pci-domain since Jan, 2021
>=20
> commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> Author: Peng Fan <peng.fan@nxp.com>
> Date:   Fri Jan 15 11:26:57 2021 +0800
>=20
> Only missed is pcie-ep side, which have not been used at all boards dts
> file in upstream.

I wasn't aware of this. 2021 is quite a while ago, so I suspect that
nobody is going to run a new kernel with a DT this old. I retract my
objection.

Regards,
Lucas

