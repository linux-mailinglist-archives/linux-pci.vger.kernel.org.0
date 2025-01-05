Return-Path: <linux-pci+bounces-19317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB889A01B3C
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 18:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9169A162EB1
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11BE1C5F21;
	Sun,  5 Jan 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5OPUmOZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD937B658;
	Sun,  5 Jan 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099866; cv=none; b=BTLvA4+G2xwNvQjKKHfyMpjCKYXoZzl031OYdfPTB9FiEMK24h8NPjNI4xSsdjTWB8z0SxnH3S7feUikfnjH+Yra8QE1CddWCNGMNal3H0SkDV7Ti1PaORDCglzHYYeGarnCtcVhO6Pf2T94qw5+WWymbqS6QItPR5XM3egpJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099866; c=relaxed/simple;
	bh=qaj6ShFf1yb97B5DeaBeisueJcWkihN9Avq69HblRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTJimjLct1s9yh7QTQDgdQVEMYwMtmKXkHtC78WeDTsYZ0POnqhFiomuZjGJ5q+vWrbiYr7UTjM1U9Z3cS0WhLFUp2NlZR3acDrbv6r6luTjiYZCI20MzHKYh0tECzpIdZO3n73Oy7sOYM6Luj0Uqk+6/PN3+WuvYbWAdJFUea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5OPUmOZ3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T7UsKrbMGaYAZ3fGhh5FClLeroSco1WoimCzDT9Vf7U=; b=5OPUmOZ3o/p2aRzIxC2coxZwSb
	iXPBt1P6j5PHapItsuOIhVh5ofmhzUoep7Ou153gc+mZFWbR0tmVR///7EfWDlN8U6y94gLQEdy4d
	0r5YwgG9jVKYql3edBmad9lUO3B+L/du3yyam3IpUAgvmo2+TsMcE73Iy6o1r3iDIl7Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUUsN-001dMh-VD; Sun, 05 Jan 2025 18:57:23 +0100
Date: Sun, 5 Jan 2025 18:57:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
 <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>

On Sun, Jan 05, 2025 at 11:16:21PM +0530, Anand Moon wrote:
> Hi Andrew,
> 
> On Fri, 3 Jan 2025 at 21:34, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +&gmac1 {
> > > +       clock_in_out = "output";
> > > +       phy-handle = <&rgmii_phy1>;
> > > +       phy-mode = "rgmii";
> >
> > rgmii is wrong. Please search the archives about this topic, it comes
> > up every month. You need to remove the tx_delay and rx_delay
> > properties, and use rgmii-id.
> >
> According to the RKRK3588 TRM-Part1 (section 25.6.11 Clock
> Architecture), in RGMII mode,
> the TX clock source is exclusively derived from the CRU (Clock Request Unit).
> To dynamically adjust the timing alignment between TX/RX clocks and
> data, delay lines are
> integrated into both the TX and RX clock paths.
> 
> Register SYS_GRF_SOC_CON7[5:2] enables these delay lines,
> while registers SYS_GRF_SOC_CON8[15:0] and SYS_GRF_SOC_CON9[15:0]
> are used to configure the delay length for each path respectively.
> Each delay line comprises 200 individual delay elements.
> 
> Therefore, it is necessary to configure both TX and RX delay values
> appropriately
> with phy-mode set as rgmii.
> 
> [1[ https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c#L1889-L1914
> 
> I have gone through a few of the archives about this topic
> 
> [2] https://lore.kernel.org/linux-rockchip/4fdcb631-16cd-d5f1-e2be-19ecedb436eb@linaro.org/T/

O.K, let me repeat what i have said a number of times over the last
couple of years.

phy-mode = "rgmii" means the PCB has extra long clock lines on the
PCB, so the 2ns delay is provided by them.

phy-mode = "rgmii-id" means the MAC/PHY pair need to arrange to add
the 2ns delay. As far as the DT binding is concerned, it does not
matter which of the two does the delay. However, there is a convention
that the PHY adds the delay, if possible.

So, does your PCB have extra long clock lines?

Vendors often just hack until it works. But works does not mean
correct. I try to review as many .dts files as i can, but some do get
passed me, so there are plenty of bad examples in mainline.

	Andrew

