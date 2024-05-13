Return-Path: <linux-pci+bounces-7421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224678C4109
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F6F1C22D01
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C6152180;
	Mon, 13 May 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PfvJ4kSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4A1509B2;
	Mon, 13 May 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604657; cv=none; b=MB/DhgQFYt7VYbpcefEe3MNyDIgj7ZtlugVB99dbpxJi0rocvlyliJUJAJsurIOZADiZ39NoyAgnmcXt/Q22iN4hfW2DKqjc+Kh22VIwYLYX6c/5WuIFPrX9YxJNiky+mOOT+P0B4MbA+66DGRgY5n5cy9h9X0dh5rSbYItuWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604657; c=relaxed/simple;
	bh=ibad/oLXETdJ6gFZRASre3kHqdrQdhHpfWRltMesjec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5bgkqQs/DDmw5nJA9CmXzcTiwzlsAHRqXhqlcXlcOAmuaRqfp7qPiGKPHZjmtO3ho2xRcLCBLb1iM2VDzILajax3qEPy4KMLqGjPU7rwsCbRw5Qt+EP8djDI8ZVFzDgfuvtb6QtvSXk1O99GW8WezO5EnXscVYw6V7wBYeeVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PfvJ4kSM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DD66FF802;
	Mon, 13 May 2024 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715604653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCTHEqncHX7PpEXTjLxoQdryl0DYK6TWxvSfa/L8L6Q=;
	b=PfvJ4kSMsWdc2j20yS/BOvIQFEbCf0UaU26pGEq3zLcq4cfh7I6E2XepIPqefEp7JIoS3q
	+frr91kLTPSGDdBbWLqlB9rTxQZrHw/1NkU+teVpLo98aE/NMjQZAKTFZAf12w5Opo9lyj
	C5Btp70PYJWoZlhmyRjNrONij0ceSrk7knM6u84j1Mp55i2iUCEEN4LvCb0FL1goTfQxMP
	g02b39pfRFpXccgMNDb7AreOac005qT1B9SZ/HksUJQrwC9q69TCmDLYo6oiAm1qTJpeNR
	zDDyg7AJolHp2Z4jmB3izsOiRXr3gheK1EMpsKWhfhfhkPq6uDiJsrl28nsYBw==
Date: Mon, 13 May 2024 14:50:49 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: <Steen.Hegelund@microchip.com>
Cc: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <lee@kernel.org>, <arnd@arndb.de>,
 <Horatiu.Vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <saravanak@google.com>, <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
 <Lars.Povlsen@microchip.com>, <Daniel.Machon@microchip.com>,
 <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <Allan.Nielsen@microchip.com>, <luca.ceresoli@bootlin.com>,
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 12/17] irqchip: Add support for LAN966x OIC
Message-ID: <20240513145049.25695b4a@bootlin.com>
In-Reply-To: <D143YFK7334S.3MM7YORC0H24X@microchip.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-13-herve.codina@bootlin.com>
	<D143YFK7334S.3MM7YORC0H24X@microchip.com>
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

Hi Steen,

On Wed, 8 May 2024 08:08:30 +0000
<Steen.Hegelund@microchip.com> wrote:

...
> > +/* Mapping of source to destination interrupts (_n = 0..8) */  
> 
> Are the indices really needed on LAN966X_OIC_DST_INTR_MAP* and _IDENT*
> You do not appear to be using them?
> 
> 
> > +#define LAN966X_OIC_DST_INTR_MAP(_n)   0x78

Indeed, I missed them.
These registers are defined from 0 to 8 in the document:
  https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,intr

The code use only the indice 0.
In the next iteration, I will keep indices and update the definition of
registers like that:
  #define LAN966X_OIC_DST_INTR_MAP(_n)   (0x78 + (_n) * 4)

Best regards
Hervé

