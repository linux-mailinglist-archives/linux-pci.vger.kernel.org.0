Return-Path: <linux-pci+bounces-21363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D28A34A82
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677F016D30F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7E21D3FC;
	Thu, 13 Feb 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="LLZWOp/k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A920409D
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464259; cv=none; b=eaE35/os3CN0iSP2InMIKvGUPqXVmvZn/uiENoIDV5QMfx5tbveBrbY82ZzmIShsjZZX0AcpKrNM4yQc1LPmfpvhQkPd5wRyYYsG9DUbaPxXY9irojG2M3r9EYj9MQN6CGiYA/a3ktriNxQZ5vC3EST2vQo3hQVIlt5xecVb8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464259; c=relaxed/simple;
	bh=o/51IyMp1iadw96C4sTg3+7DcvmfdS8ffzuD5PVOLzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDF08W0QKjSm7xSRuwYGMkbTRwWS08zn+oudR7CpQdC1pA7HER+nU6YyqZ7DvOIkza3HjOOxQVk4R2vOnKJKisvHuSKsM4C7Dj7URfo9D7ye5fMY7R6KyGIuZ3AM45lNYxaDMl3ZGbftvoplJa/G946aPX97jKfX8Sskng86f9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=LLZWOp/k; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so1739577a12.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739464256; x=1740069056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/51IyMp1iadw96C4sTg3+7DcvmfdS8ffzuD5PVOLzM=;
        b=LLZWOp/k9O0iQdBoTYYkLC2opbafdJaOulLUXwXvahvC4NpRFlO4efhb49LikbQS44
         DyjLuvXMZ8RTJM/9sZDT+pKaymsgQ1NUS3RtRqKGlGMtH4Hc6WqSE2Kag30lyYT6BPnK
         2sdSgd+OaiF7rdiVqT8w0fvfeRCdP49MCQ02lQGeJdAx+7DtLUC/kDhjhdWVq+fJEYhn
         qIApuq3jdCGeo1vOf3owgNVqYWcKNbig9H+iZzdH3C4RkJNnEdpghw7klAyVQbmcZkgl
         yxevGvbxlbGA5G/Sm1mlvDvVmUe7JM1XfahWbQgkdJK/O5B+mHWqdJknptRkOH3fJeGY
         5GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464256; x=1740069056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/51IyMp1iadw96C4sTg3+7DcvmfdS8ffzuD5PVOLzM=;
        b=R6lRIWx+9ODzzgs6+kXsSd43QHMMXTkfkEeDOJZg4XZizMUlRBslRpQfjUYgKAuhHd
         kEdogbXgAG5K38fWY9LCHuOhTwfH4D/PRt4Tbs4kmpaufxWDETJSfwXVPwqGa/WhoHLf
         CE8qDyCYj8S27Tqnjx18XRFNhFdZYXGtEwRf5a3TaxRKdMDmh4sUK617mn9MSumz8tXf
         Ueqvt6IRDiANwAC/XAW2lWwyRmcZnqseItR0QQSXPOK2N4U+jg3o1ZpkEab+76/ZgAuN
         hprg5pQ/rH+VtKW2cesBv7lnpWGuZ/Bt8iPh+P3MjMEMCwDPOpOGz8bQTU6Ug9UDApGo
         KIew==
X-Forwarded-Encrypted: i=1; AJvYcCUwB4wQpXG5Hqdlp1BiYN4dB+fTregC+vl48vPk15gr1VRr1/kdQAznKb6mz0G/jVpKzVxnWaV9/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/00vtZPJc7faKJqhTSWdIlLf6wBrhUxda1CU15ibm9hLZRKI
	BoJk3WZymF9+JPEtdtOgWUFaoNg3cKcRxZNALN/sD42keIAJ9CKbH/GYhXLLxJDAzSkB88eAp1u
	vp1kX0qJepG11+kxAJJ3/9WMjYOjJQ+1uU0s4ZQ==
X-Gm-Gg: ASbGncuPYbo4kxUwPNoYZtEaR38v0FloPx//WsjRdjzB09vgM2yphHGXciMV8TyqmeQ
	Aj1G8Wx3IjJY+UMRFD2KwDrXHYcqfJskzNmBSiTve3VnobH+JQyTa8f8BIkWH4eNTrKa+k97MSY
	0+a3fOFx5/O4Vwu96wu1OkuAs/a6G5
X-Google-Smtp-Source: AGHT+IH5GCCG2j+0durJuW8Oa03Wrl0Cv4HeP5h1Abx+8pHhFwZ922emqHD5DAYivn9wYSdjWCmVxGwnF2qbKv7sLSM=
X-Received: by 2002:a17:907:1909:b0:ab3:76fb:7523 with SMTP id
 a640c23a62f3a-aba501bce21mr457456966b.53.1739464255721; Thu, 13 Feb 2025
 08:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com> <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
In-Reply-To: <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
From: Phil Elwell <phil@raspberrypi.com>
Date: Thu, 13 Feb 2025 16:30:44 +0000
X-Gm-Features: AWEUYZnIbvhJ2Gv987WOr8gH33pSGmprAqtfnZVU0XicGf3dfKPk3tqt9y_XRUs
Message-ID: <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Andrew Lunn <andrew@lunn.ch>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrea della Porta <andrea.porta@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, 
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

Hi Andrew,

On Thu, 13 Feb 2025 at 16:27, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Feb 13, 2025 at 05:14:35PM +0100, Herve Codina wrote:
> > Hi Phil,
> >
> > On Thu, 13 Feb 2025 15:18:45 +0000
> > Phil Elwell <phil@raspberrypi.com> wrote:
> >
> > > Hi Andrea,
> > >
> > > The problem with this approach (loading an overlay from the RP1 PCIe
> > > driver), and it's one that I have raised with you offline, is that
> > > (unless anyone can prove otherwise) it becomes impossible to create a
> > > Pi 5 DTS file which makes use of the RP1's resources. How do you
> > > declare something as simple as a button wired to an RP1 GPIO, or fan
> > > connected to a PWM output?
>
> Where is this button or fan? On a pluggable board? Isn't that what
> overlays are for, and they are stackable. So when you probe the
> pluggable board via its eeprom etc, you find the overlay and load it?

In the Raspberry Pi ecosystem it would be the firmware that applies
the overlay, and it can't do that if the resources the overlay refers
to are not yet present in the dtb.

> Or do you mean a custom board, which has a CPU, RP1 and the button and
> fan are directly on this custom board? You then want a board DTS which
> includes all these pieces?

That depends on whether you count the Raspberry Pi 5 as a custom board.

Phil

