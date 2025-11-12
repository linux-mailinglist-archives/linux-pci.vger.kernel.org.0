Return-Path: <linux-pci+bounces-40944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B7C503DB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 02:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A921887BA1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6D28B4F0;
	Wed, 12 Nov 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="g2OnEPAA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CC28DB49;
	Wed, 12 Nov 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912301; cv=none; b=AwO4LasLnpwrOqJ85sdBkjZ5lhoRLQAP7hiJJFUyT6JfZgwz3p3GmL8hI0rgpeFHsJy5xIPiPxGQntMGT4oq0BDYERUDwqhKoSMd7czkXt+Bpeamu8x5HO3adUemmQ2oPKrh4Uqm3+UCz16Ff8RveB7yLfTkkT5UrsjlVU7473w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912301; c=relaxed/simple;
	bh=i3Nk53O/boHBuFajvOJf0+NAQQ8HEj8mlkMRb6nOWXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeyJok8gqktXrFr5MR3Axm8qAj7Gyq6xKqYJL/NSaeMdc/K3Fhp9zMyIcwIoonjSLDsdmLhJLFyKe4WKJVyi3S86mdxbcWGHLygMST7GZN+E8VTUpsurthTT098AWz/jDpKFt1/nCVXxvNk8qmMwa9VhYIZWv4Zd4b9u0h9+jxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=g2OnEPAA; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hYfwcXlk1yVhq5DVinFiJbUOXo8e/FkjNZ+187JUQvQ=;
	b=g2OnEPAAzyP8npm4AZ+DsbfBUsKE+VOkkIsHbR8DM5R8ndnfTRN9gZOsm006g7
	1gy1K3u7D2+fX5wx+0jMYPvwLLbgT2EQLiigh52k0OxTyufcz35V4g8MERCGW4EV
	IwkqXZzqMk5ENaydSxSc6uknGetzcgC+qBNYW8fSqpGek=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3XBjz5xNpPSHPAQ--.5419S3;
	Wed, 12 Nov 2025 09:50:45 +0800 (CST)
Date: Wed, 12 Nov 2025 09:50:43 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
 supports-clkreq property to PCIe M.2 port
Message-ID: <aRPn89vIkmije-Ks@dragon>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-2-hongxing.zhu@nxp.com>
 <aRLhko0h1OZgvo2o@dragon>
 <AS8PR04MB8833D099959C62A97AC8CB868CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <aRNf3TUTawixqGR1@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRNf3TUTawixqGR1@lizhi-Precision-Tower-5810>
X-CM-TRANSID:M88vCgD3XBjz5xNpPSHPAQ--.5419S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4kWrWrZw1DtFy5JFW5Wrg_yoW5Zr4DpF
	WUGF4DGF18WFyrJwsFqFyFkFyDtwn3AFsI9r1DWryUtrZ0kF1FqF429rs3ur1Dtr48K3y0
	vF1qq3sag345Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbVysUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiORZWu2kT5-bznwAA3F

On Tue, Nov 11, 2025 at 11:10:05AM -0500, Frank Li wrote:
> On Tue, Nov 11, 2025 at 08:02:35AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Shawn Guo <shawnguo2@yeah.net>
> > > Sent: 2025年11月11日 15:11
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
> > > supports-clkreq property to PCIe M.2 port
> > >
> > > On Wed, Oct 15, 2025 at 11:04:18AM +0800, Richard Zhu wrote:
> > > > According to PCIe r6.1, sec 5.5.1.
> > > >
> > > > The following rules define how the L1.1 and L1.2 substates are entered:
> > > > Both the Upstream and Downstream Ports must monitor the logical state
> > > > of the CLKREQ# signal.
> > > >
> > > > Typical implement is using open drain, which connect RC's clkreq# to
> > > > EP's clkreq# together and pull up clkreq#.
> > > >
> > > > imx95-15x15-evk matches this requirement, so add supports-clkreq to
> > > > allow PCIe device enter ASPM L1 Sub-State.
> > > >
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > > b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > > index 148243470dd4a..3ee032c154fa3 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > > @@ -556,6 +556,7 @@ &pcie0 {
> > > >  	pinctrl-names = "default";
> > > >  	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > >  	vpcie-supply = <&reg_m2_pwr>;
> > > > +	supports-clkreq;
> > >
> > > Is binding updated for this property?
> > >
> > > Shawn
> > >
> > Hi Shawn:
> > As I know that It's a documented binding property as below.
> > - supports-clkreq:
> >    If present this property specifies that CLKREQ signal routing exists from
> >    root port to downstream device and host bridge drivers can do programming
> >    which depends on CLKREQ signal existence. For example, programming root port
> >    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> > ./Documentation/devicetree/bindings/pci/pci.txt
> 
> Shawn:
> 
> 	This file should be removed. It is already merge to Rob's dt-scheme
> as PCIe standard properties.
> 
> See: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

Ah, thanks!

Rob,

So it's no longer the case that kernel Documentation/devicetree/bindings
has all bindings documentation?  Or it's never been the case?  I used to
grep a property in the folder to see if it's documented or not.

Shawn


