Return-Path: <linux-pci+bounces-21651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA7A38A4B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC82E189510B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3822759B;
	Mon, 17 Feb 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Uj/pIdLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E092227588
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811830; cv=none; b=gP2Xux2uPKaTx01tSF6P3JJ3XKIOqF9k3iB0RmJXmGSGKweZfdvppQUMugkK9MumKArtHvpOdwQxKAg0xYG/kOx4EjW0WmNmSZKxXi4yQ4eNQh4IBuK4GfkCoELGBRFvOJCAytJHD0GmQRD8tLpRO3llNLrovetvHhd72SVgnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811830; c=relaxed/simple;
	bh=sVe4+bfdWEjsoANvC8eHlYrzwyl246zxZjPy+JCIdt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD73QYAwyBX1j40eBWVtDGKgUvoCs+zu5i7SsOabZ5wphA9+qxJOEH7tHNs7jJVnRh2kSa8x0Eyhy8y8EY/hABmC44dT7BTRm+AYIpsvlRhecTxgKkMYijMk+5U//9oH/am6HQ3pWbwRPhRgvkPdStucLj8hDf/s5Ba4BcA2wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Uj/pIdLV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso687064966b.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739811827; x=1740416627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVe4+bfdWEjsoANvC8eHlYrzwyl246zxZjPy+JCIdt0=;
        b=Uj/pIdLVrb1JsxVQ5DSgHObs/ghRS9jMTCilgZ29atub3HO7Fm8v/BzaA+FJAo1Jzd
         8KN1fn5GM4+w7R1s3mwuoUCDDOu9I7SxAbq2heYGejB22DTlXMjGhdFMGHR1m1lfGdAS
         jt8o/n0QITzjgyeEWUKcAAt0S6aL8oR9974QhK2AtMpX8Oaoa7nR6YM2xVGz7ISAxhAo
         tqpiUyhcJUZVxitUAxERcsF3PhC5Y2wIRKRdonH10PBMiECP2FKMw0Ispe+/9A/5LlZT
         WDIh43piz0GgMKlcRmLxb10DvJjfyz/LiYQrqt6unjLSXmc4uaxIJov6Mt5LGGcfHPDr
         KTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811827; x=1740416627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVe4+bfdWEjsoANvC8eHlYrzwyl246zxZjPy+JCIdt0=;
        b=EXZdoMq7GVJVEGGGNkItrsw7AmwbWtDSTa19mkIOVipz43FmeUhu43NsWXcVTj2iWp
         SCFrHPSeX+SIj1hemttDqW9Re3HIn/gIIGtSgQbksZrZHWoEzknK9a4Q3t+IECzuL/mN
         syi2GZbV+soUamujwjabAf0a4dkQUCMDSHpZWr8CBvjYhW2BNMZA1dkBSypSmkpxBi21
         yIarTdJOyA0TJB4YCF6mnEDJcbHNcR3XV07FfiTDDWHMildslZKFPxZMgXiV9tsorkFp
         oAhAYF3gUBk/9PhweZGbEQCe7MaMPGCrSTvCdG8dGKlyKRw/dYvLbUWZ0/uh5D562WeT
         nPZA==
X-Forwarded-Encrypted: i=1; AJvYcCX5/jIVIsu518+ObzFOqX5NH/V+bzg+IX0TtiVCz/zt9yNJ/P2kYgLRv50erZOYWEYLiTauQi9w6Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPOfJye/rJoOmfptQTxM1foNp+D/PPttqERkO0nqVBQ7s4pfL
	zYFEEkXTUkZNSwC32QZyOHB+c+tzUmDXwSYrJB5MyzBI0HwxBgpYJQNxX3n8S52sZ0aPzaSqA9n
	SLgW58/bMlHF7a6Mhu+Jxl24LGeIB/AnTITNQmA==
X-Gm-Gg: ASbGncsXWaTvPlkJwncfSML1jeraYV+c6xj3v1zaVq+avGhmv589PoO6xXhBJxY+wMw
	VzcMS518RCy1xOtvW0rFOnU2VNUne0heTpx1S8M2AZgCckLwc7nc+GG93Gn2c9FwYkDwgOxaa+W
	DYZGOpeTtYEQ9jhu89z0JxOV4Rj4fE
X-Google-Smtp-Source: AGHT+IFkoXeeLdTp4ohksx/YA+HrSV2VwP7+Qhyrz/nRGWdx2ClM/1bE+rZOPCDLjkQFeVjoPNdqjMROBQE6WvwLweM=
X-Received: by 2002:a17:906:f10d:b0:abb:83b9:4dbe with SMTP id
 a640c23a62f3a-abb83ba516emr844832566b.47.1739811826606; Mon, 17 Feb 2025
 09:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com> <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
 <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
 <821d4c74-09b0-4c1b-b8ef-f8c08d0f6b5b@lunn.ch> <CAMEGJJ0QbzCScfTRA_pw_8A=iMYMAAFs69zFNLwcOxF5Syugpw@mail.gmail.com>
 <20250213195304.3a2df02c@bootlin.com> <CAMEGJJ0kGCj=tjM6KswbG_+ZFkzMwPY+06BXCU0qSnbBKz0=ug@mail.gmail.com>
 <20250213220639.373da07b@bootlin.com> <CAMEGJJ2_HVKfsE3P22baadbzxSDAX=yTr=m76YuXa5A2cJsJig@mail.gmail.com>
 <20250217165306.3f055b94@bootlin.com>
In-Reply-To: <20250217165306.3f055b94@bootlin.com>
From: Phil Elwell <phil@raspberrypi.com>
Date: Mon, 17 Feb 2025 17:03:34 +0000
X-Gm-Features: AWEUYZm71GLVUoOTfXPdGocteYtufVoYDo-ggiP-vBU3iN5Twxu9zylrsVoZz_U
Message-ID: <CAMEGJJ13476pKJb441o5X0Y+rbfromj5-3V-j2KZiOt326OL4A@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrea della Porta <andrea.porta@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com, brgl@bgdev.pl, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com, 
	devicetree@vger.kernel.org, dragan.cvetic@amd.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, kw@linux.com, 
	Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, lpieralisi@kernel.org, 
	luca.ceresoli@bootlin.com, manivannan.sadhasivam@linaro.org, 
	masahiroy@kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, saravanak@google.com, Stephen Boyd <sboyd@kernel.org>, 
	thomas.petazzoni@bootlin.com, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Mon, 17 Feb 2025 at 15:53, Herve Codina <herve.codina@bootlin.com> wrote=
:
>
> Hi Phil,
>
> On Thu, 13 Feb 2025 21:12:43 +0000
> Phil Elwell <phil@raspberrypi.com> wrote:
>
> > On Thu, 13 Feb 2025, 21:06 Herve Codina, <herve.codina@bootlin.com> wro=
te:
> > >
> > > Hi Phil,
> > >
> > > On Thu, 13 Feb 2025 20:15:06 +0000
> > > Phil Elwell <phil@raspberrypi.com> wrote:
> > >
> > > > Once more, with plain text, which I'd hoped the Android GMail clien=
t
> > > > would work out for itself.
> > > >
> > > > On Thu, 13 Feb 2025, 18:53 Herve Codina, <herve.codina@bootlin.com>=
 wrote:
> > > > >
> > > > > Hi Phil,
> > > > >
> > > > > On Thu, 13 Feb 2025 17:57:37 +0000
> > > > > Phil Elwell <phil@raspberrypi.com> wrote:
> > > > >
> > > > > > On Thu, 13 Feb 2025 at 17:45, Andrew Lunn <andrew@lunn.ch> wrot=
e:
> > > > > > >
> > > > > > > > > Or do you mean a custom board, which has a CPU, RP1 and t=
he button and
> > > > > > > > > fan are directly on this custom board? You then want a bo=
ard DTS which
> > > > > > > > > includes all these pieces?
> > > > > > > >
> > > > > > > > That depends on whether you count the Raspberry Pi 5 as a c=
ustom board.
> > > > > > >
> > > > > > > So you mean the Pi 5 board would itself make use of the resou=
rces the
> > > > > > > RP1 device has? They are not simply connected to headers for =
plugin
> > > > > > > boards, but used by the main board? Hence you want to describ=
e them in
> > > > > > > the board .DTS file.
> > > > > >
> > > > > > That's correct. But even for plug-in devices, those which are o=
n
> > > > > > non-discoverable buses need overlays to declare them, which cau=
ses a
> > > > > > problem when the overlay application happens before the kernel =
is
> > > > > > started.
> > > > > >
> > > > >
> > > > > Hum, I see.
> > > > >
> > > > > We worked on overlay usage on non-discoverable buses wired to a c=
onnector
> > > > > and we did a talk about issues we are facing on at Plumber [0].
> > > > >
> > > > > You can also find our big picture in [1] and a last contribution =
introducing
> > > > > export-symbols feature in [2]. export-symbols is also under discu=
ssion on
> > > > > some other threads.
> > > > >
> > > > > Also, we proposed the i2c bus extensions feature [3] whose goal i=
s to allow
> > > > > an addon board to add devices on an i2c bus provided by a base bo=
ard and
> > > > > wired to an connector the addon board is connected to.
> > > > >
> > > > > Maybe in your case, you can decouple resources (gpio, pwm) provid=
ed by the
> > > > > addon board and used by the base board using also nexus node.
> > > > >
> > > > > We use a nexus node [4] (not presented at the Plumbers talk becau=
se the idea
> > > > > came during 'out of talk' discussions in Plumbers) in order to al=
low our
> > > > > addon board to use resources provided by the base board.
> > > > >
> > > > > In your case, if I understood, you are in the other direction but=
 why not
> > > > > using also a nexus node to decouple and translate resources in th=
is other
> > > > > direction ?
> > > > >
> > > > > Don't know if this idea can help but feel free to ask for some mo=
re
> > > > > information if needed.
> > > >
> > > > Nexus nodes look interesting - I see them as adding a layer of
> > > > abstraction such that, for example, boards can declare which of the=
ir
> > > > specific resources performs a common function so that clients can
> > > > treat them all the same. We do the same thing in a limited way by
> > > > using common labels on nodes, but this goes much further.
> > > >
> > > > In the case of Pi 5 and RP1, I imagine you are proposing that the P=
i 5
> > > > dtb declares the connector node and the overlay fills in the conten=
t
> > > > with references to its GPIO controller, PWM controller etc. However=
, I
> > > > think the overlay would also have to be board specific because it's
> > > > not possible to patch part of a property from an overlay, so you'd =
end
> > > > up overwriting the GPIO number as well as the controller reference.
> > > >
> > > > What is needed to make this work is the ability to cope with
> > > > unresolved references in the base dtb, to be resolved as each overl=
ay
> > > > is applied, with runtime checking that each reference is resolved
> > > > before it is used, all of which sounds like a nightmare. Plus, we
> > > > really don't want to have to change the way all our camera and disp=
lay
> > > > overlays work on all Raspberry Pis just to accommodate somebody's i=
dea
> > > > of how RP1 should be handled.
> > >
> > > Just to be clear, my comments were not there to tell you how RP1 shou=
ld
> > > work. I just proposed ideas without trying to force anything and I ca=
n
> > > fully understand that ideas proposed don't feed your needs.
> > >
> > > Sorry if my approach was misunderstood.
> >
> > I feel I've been misunderstood - I appreciate your ideas.
> >
> > Perhaps it would help if you could outline how you think we could
> > apply your suggestions?
> >
>
> I was thinking about what your mentioned, i.e. the overlay fill the nexus=
 node.
> No sure to understand why the overlay should patch some properties.
> Also where are the unresolved references in that case. The base DT refers=
 to
> the Nexus node.
> The issue will probably be that the translation performed by the nexus no=
de is
> not available until the overlay is applied. The consumer will see errors =
other
> than PROBE_DEFER when if probes while the overlay is not applied.

The job of the nexus node would be to translate a generic request for
a numbered resource to a specific request for an RP1 resource with
arbitrary properties. The arbitrary properties could be GPIO offsets,
which are board specific, while the node supplying the resource is
provided by the overlay. This means that an entry in the table,
described by a single property, could have contributions from the base
DT and the overlay, which is not possible since overlays overwrite
whole properties.

Perhaps that particular problem could be overcome by creating a
single-entry map, using the map-mask feature to pass through all of
the GPIO offset and flags to the parent, so that the whole table
becomes a proxy for RP1's GPIO controller. Is that what you had in
mind?

> Also, the solution will lead to memory leak at runtime. Indeed, the overl=
ay
> add properties in an already existing node.
> If the overlay is applied by the Kernel itself, this lead to memory leak =
when
> the overlay is removed.
> Indeed, an overlay can add/remove node without any issue but it cannot
> add/remove properties to/from existing nodes.

Fortunately for me I'm not arguing _for_ the use of an overlay.

> In the case described here, the nexus node is already present in the DT a=
nd the
> overlay add/remove properties to/from this existing node.

I think I can see how that could be made to work for GPIOs. It looks
as though the GPIO subsystem is the only one making use of
of_parse_phandle_with_args_map. Interrupts seem to have an open-coded
equivalent, and iommus. What about I2C and PWM?

Phil

