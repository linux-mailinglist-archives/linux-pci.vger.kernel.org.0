Return-Path: <linux-pci+bounces-23332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C681CA59AE8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA53A872E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5522FE02;
	Mon, 10 Mar 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A9g/0upB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327CA22FDFF
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623931; cv=none; b=m4/SYpnFPhpZi4WlrtC01IJPN4dj3UWSR+wjxXIqjhzkqv9Vbwr6//TiA3qQfcfg5a+Y2YxzUOeZ3zbEZooRhFDeKh2StDxYQKpM1roVDHCCIGoF1eZtmjtNU67e2OwVCCflxALM/YGJYCjx0UHJCgWQ5/Vr/u9vj3bFQGWi+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623931; c=relaxed/simple;
	bh=nWkFwwrLc+aYxF0iZWY2bTRbIpx7h70e0m3QKsoBFUo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akQHCBDTzHjts0oYIVpWpOama8WQSZFzes6j2o6V1gRgT4j/y4K2vUkuP3o0oL66t+KRrVg7G7eBRY0hEKfj6IMm27pNzIi1VgjUpUr8Sf5gnhk2teSJ3cXbEJc23VHddOLrHZP1M77DsLXVdYEN3A1zdD4obEXwnoWF5EpMS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A9g/0upB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeec07b705so692420566b.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741623927; x=1742228727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Z0f+eg+DGAv8ZQV/jNF7Kb50O1PslkOh6D6/Tb4Gs=;
        b=A9g/0upBx1fIABuJOwifCj6OWijnrVIKsOGxjtPEgWmYBgQLwmxIlQJM0N/4GukjP2
         rFby8wj2faBd1uiMcas6t2DzyOJ/45NBjhdKUyizcElWXA2299KKNlyA3Gs18YOIY5lU
         D8c1qZgtcMROFBvJCpIvcmTtxwteVRPuP6NSBXp5atsjv5FR9OW6icrmy+o29MiYVTxh
         xuQazBk0RVvpQ4HyuR2f/l/g8wzUMWq53YM9oKYiAHtgbURi/5xD0Y/IQdD5GkNTjTcr
         S5U/w7VV5+uHzLO5uzEqzzhJoC50+dQ5T4RgOf0omG+NVsJosYICoc8AQesk5AexkPfK
         FXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623927; x=1742228727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Z0f+eg+DGAv8ZQV/jNF7Kb50O1PslkOh6D6/Tb4Gs=;
        b=orvPl8azoepwU5GkcRDWNQCi1kQqffYYaAcJbgdd/9UwJoceMD8Z8j29LHENfcvVL5
         TOBStgwAFdawXCRuO44siRB35EuSCazhi7XOTmm54pCagbYtXOwZc+2U11EG48uDNLLw
         HDtPv5FH8tLvyCh7OmfXIh2j/9lAg/r8KUeIzRLVwrQE4ezZnAJFEwjtpnVkH8SIvFsW
         7B7FJi9iCE24cBiZxSkFRPyVTdj4R3JBDGJXIWWB01FRK88iEvdyER1XmE2AUL6Ak3uJ
         HjOznsWnodMtimsNcHgAtvJyNLYtEEJeDVMzCIvlK1ve6IEaTO9viL8cAnI606UxabkY
         LzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWucyCDHJBvxMYiy8uxL4rPI6qFA+b4ACs4mMQ0t/SUhpnbz+qahY/tL2MSXo+ln+k/+COTkj6Q0g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMT278b4r02mG51zZk4PPlMZDhaXy9S+eg4bEYohrjtOYTfcj4
	Ryxp08HgLdull0/7qsbB2cWt3fDHnYksgkXoxCxNWFZRbiXN7AbfsifDI6Q69NE=
X-Gm-Gg: ASbGncvt5XQttRCgBN/utBoy9ZiwBfd6nzyZEAx3PF1a2Nh1xk+aqdtEXDerdR9UiJv
	j9hXzOh5DolpilSoyJNusp24dTPUI1DwltFeGGqtrhEXVp/y8ZO3afgEs6PzL3BQSLzQF2bvtv7
	1QkQbmBg+a7ZA1mUf1IJO09Uz+vOzC5/9P6Mt7UYpOFhITe5G5G0yPko51f1tvOByKvUVjN9EYN
	aC8IDbEvRA1hUQvGdYW9TVQDgL5s1/yjaoQ+dn6htYZ1n89VivLZ7xVBvWqP3gB4ZrjcE62bGYL
	jvy6fJNbGhqOOm363IhLWLLG8STMbh+8APSxGNzouAcg0gxklMF4MqBimQmMi9VqO7fbvtb4si6
	ww2MgmpC0qh8j
X-Google-Smtp-Source: AGHT+IEF4RrMX0Se6BFeWVbwyO+I7ul3eer8KyKrzFnfeVIwfzLuGjn2ndfHjDR1WQOdWyC5VAq9Sg==
X-Received: by 2002:a17:907:93c6:b0:abf:5778:f949 with SMTP id a640c23a62f3a-ac2b9ea163bmr21665566b.42.1741623927360;
        Mon, 10 Mar 2025 09:25:27 -0700 (PDT)
Received: from localhost (host-87-14-236-98.retail.telecomitalia.it. [87.14.236.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2b8584feesm19463766b.6.2025.03.10.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:25:26 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 10 Mar 2025 17:26:36 +0100
To: Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Herve Codina <herve.codina@bootlin.com>, andrew@lunn.ch,
	Arnd Bergmann <arnd@arndb.de>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	bhelgaas@google.com, brgl@bgdev.pl,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com,
	devicetree@vger.kernel.org, dragan.cvetic@amd.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
	kw@linux.com, Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	lpieralisi@kernel.org, luca.ceresoli@bootlin.com,
	manivannan.sadhasivam@linaro.org, masahiroy@kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, saravanak@google.com,
	Stephen Boyd <sboyd@kernel.org>, thomas.petazzoni@bootlin.com,
	Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z88SvEmaZYfysQ-k@apocalypse>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
 <CAMEGJJ1++aeE7WWLVVesbujME+r2WicEkK+CQgigRRp2grYf=A@mail.gmail.com>
 <Z87wTfChRC5Ruwc0@apocalypse>
 <CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com>

Hi Phil,

On 14:21 Mon 10 Mar     , Phil Elwell wrote:
> Hi Andrea,
> 

...

> 
> This is indeed our current DT usage for the Pi 5 family - a single DTB
> describing each board - although I would like to make it clear that
> overlays can then be applied on top of it describing the attached
> peripherals.

Indeed. Thanks for specifying that.

> 
> > 2 - RP1 LOADED FROM OVERLAY BY THE FW
> >
> > In this case the rp1 dt node is loaded from overlay directly by the fw and the
> > resulting devicetree is exactly equal to the monolithic dtb scenario.
> > In order for that overlay to be loaded by fw, just add 'dtoverlay=rp1' in
> > 'config.txt'.
> 
> This halfway house combines the advantages and disadvantages of
> scenarios 1 and 3. Compared to scenario 3 it gains support for
> applying overlays that make use of interfaces provided by RP1 - I2C,
> SPI, UARTs etc. Compared to scenario 1 it loses the ability for the
> base DTB to refer to elements of RP1, other than by replacing these
> DTB elements with overlays that must be loaded after the RP1 overlay.
> As such, we would see that as a backwards step and not use it.

This is in fact the second side of the problem I was mentioning: being
able to reference RP1 nodes from base tree (this of course arise only for
case 2 and 3, i.e. in case overlays are used). Some solutions to this have
been added by Herve (nexus nodes) and it seems promising, but I still
don't have a complete and tested solution.
My intention here is to verify if it is worth spending time on figuring
out a solution for the overlay case, since in case we only accept the
monolithic approach we won't use overlay for rp1 at all.

My idea is that we can still provide the dtbs for all three cases for the
user to choose from (so to potentially benefit from all advantages every
single solution provides), and refine the overlay case as we go, since we
can still fallback to the monolithic dtb in case we can't find a viable
solution to the across-overlay referencing issue.  But I'd like a confirm
from upstream too.
I think that this problem should really be addressed sooner or later (I'm
hinting at fpga hw, but lately we're seeing other appliances of this paradigm
arising more often), so maybe this is a good opportunity to lay the ground
for a proper solution that could be generalized for other situations too, but
again, not at the cost of slowing down rpi5 upstream efforts.

> 
> > 3 - RP1 LOADED FROM OVERLAY AT RUNTIME
> >
> > Here it's the rp1 driver that loads the overlay at runtime, which is the case
> > that this patchset originally proposed. The devicetree ends up like this:
> >
> >   axi {
> >     pcie@120000 {
> >       pci@0,0 {
> >         dev@0,0 {

...

> >         / {
> >                 ... all rpi5 board dts ...
> >                 &pcie2 {
> >                         #include "rp1-nexus.dtsi"
> >                 };
> >         };
> >
> >
> > with only minimal changes to the rp1 driver code, I can confirm that all those
> > scenarios can coexits and are working fine. Before processding with a new patchset
> > I'd like to have some thoughts about that, do you think this is a viable approach?
> 
> Thank you for this - the creation of a core RP1 declaration that can
> be tailored to multiple applications using different wrappers is
> exactly what I had in mind. I agree that your partitioning scheme can
> cater for the 3 usage scenarios, but for the reasons outlined above I
> think scenario 2 is not useful to us, although it isn't impossible
> that U-boot might see things differently; I see no harm in having it
> supported, but I wouldn't want anyone to go to unnecessary effort to
> make it work.

In all truth, this is in fact exactly your proposal (we discussed internally with
Dave also), just slightly re-arranged by me.
I agree with you about not wasting time, as I also mentioned above.

Many thanks,
Andrea

> 
> Phil

