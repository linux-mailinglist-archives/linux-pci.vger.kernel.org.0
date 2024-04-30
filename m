Return-Path: <linux-pci+bounces-6892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7F8B7BEE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F71F22891
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B714374D;
	Tue, 30 Apr 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Asu18Cpb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDA770F2;
	Tue, 30 Apr 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491639; cv=none; b=XiG/smNoEsPZhMXbQTrPcsU1l+YgO+njy8KA/uGioWIF6vCUcaIYJoIaRL9EnlSb1/U+n0oB3AbqgVw9iOMjTDEWmmGLLBgcaMSJquwv/JkIAVY69ie1KW2ntt50TfXbZL6R9BzIL5beSxZg5lON9m1vcmtyqNUv3qE2DOKR/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491639; c=relaxed/simple;
	bh=3YMP6pSgBBioceZpWJJBMi0WiZgs2qMWAZjRqieBRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEfDCz78md7DoBYtkrBk5dAgVV8UhDcj25UxAULurhlQ6sZ6/QVO0yg2Gh7X8LjYp4SgwNRVh2YzwFv7jB1XYaYfDVvpqYfv8ZLL4AiSJJa5YCnDcNrwpk6w80XT13NrtAafn4B5PpSwE2GVCrtsIVbjr/m8HoIwklNXuomM+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Asu18Cpb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3CD71BF207;
	Tue, 30 Apr 2024 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714491629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+cbSiCWqxupPEH7bg78CMjuOeT84VG73wF/YcMcoBg=;
	b=Asu18CpbZFU7KZq8qT6sXy2TVSu2PEKElKdAxkrvGU3+Z/X9VRq3ii8G/8YyictrIDuCTh
	rlTz5HRbXlhZPOLHfVNMEksHnkfieaypj8/AVwsMiLK/BmeUsNsfXIq3vqYsGEYchIt1qD
	kwf5Xe8qWczC40Ddi/DM1Y+MVw0Yu8VQBPxeoDamtNuhTkHXE9LQTjUSPcZL/Nt6+KFt2B
	avZf/aImihbeaH8tv20TcLrpTthuxQrrvI9JuUm/BOZReJ4bTW1mQj38LWUDCSIHvZr6F3
	UXgL+HJGWG1b5kPauMm+s/BvrMiEPwVrx2HGSWaEsExoHbCsMDET/JPmX/Ty7A==
Date: Tue, 30 Apr 2024 17:40:23 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <20240430174023.4d15a8a4@bootlin.com>
In-Reply-To: <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-7-herve.codina@bootlin.com>
	<5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrew,

On Tue, 30 Apr 2024 15:55:58 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Apr 30, 2024 at 10:37:15AM +0200, Herve Codina wrote:
> > Add the (optional) resets property.
> > The mscc-miim device is impacted by the switch reset especially when the
> > mscc-miim device is used as part of the LAN966x PCI device.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/net/mscc,miim.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> > index 5b292e7c9e46..a8c92cec85a6 100644
> > --- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
> > +++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> > @@ -38,6 +38,14 @@ properties:
> >  
> >    clock-frequency: true
> >  
> > +  resets:
> > +    items:
> > +      - description: Reset controller used for switch core reset (soft reset)  
> 
> A follow up to the comment on the next patch. I think it should be
> made clear in the patch and the binding, the aim is to reset the MDIO
> bus master, not the switch. It just happens that the MDIO bus master
> is within the domain of the switch core, and so the switch core reset
> also resets the MDIO bus master.

Exactly.

> 
> Architecturally, this is important. I would not expect the MDIO driver
> to be resetting the switch, the switch driver should be doing
> that. But we have seen some odd Qualcomm patches where the MDIO driver
> has been doing things outside the scope of MDIO, playing with resets
> and clocks which are not directly related to the MDIO bus master. I
> want to avoid any confusion here, especially when Qualcomm tries
> again, and maybe points at this code.
> 

Sure.

We have the same construction with the pinctrl driver used in the LAN966x
  Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml

The reset name is 'switch' in the pinctrl binding.
I can use the same description here as the one present in the pinctrl binding:
  description: Optional shared switch reset.
and keep 'switch' as reset name here (consistent with pinctrl reset name).

What do you think about that ?

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

