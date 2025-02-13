Return-Path: <linux-pci+bounces-21355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2FA34766
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854173B0F79
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3861139566;
	Thu, 13 Feb 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VN++il+2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2C26B0BF
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459941; cv=none; b=rVovilK2jU5pGWxLd4q0DP8FAf0joHVrct9TylJSACrWniUlgyNL+Nd4M2PhCtEmx7C3w1KwqJl1xqeLvIGLwGBuBH0a+9LKyXBGHHUUUMT0lzFNvoQew14m3SS9fMZ+QZwriXoT/PxtdQmQ3X0t6vlw8Bq4ttuo3X53CTloiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459941; c=relaxed/simple;
	bh=6/MHXBt3ThyNTmD9iHOOhPj6W2u7EZRVkOK3ed1Q64Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZaBRzJ963xHs4+Ivj2rb90uUC9kAWE6bIPjvlcoNFdxwsLpmHwkpqHsg2WWgTgrTUdWk6E6wgX05mBZG806jr6OCNUFlSZiOhiPiW8OC+dT/1u8/r6AsamvukpyJgRo9p25KrGrldHKZ4FcqfcB3+cq16f3rXxhtDmnBYhkX8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=VN++il+2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so217155966b.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739459938; x=1740064738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/MHXBt3ThyNTmD9iHOOhPj6W2u7EZRVkOK3ed1Q64Q=;
        b=VN++il+2NcLZMuXmB7DtC6t8u7pwISgu60YeSAlSoDlhL+Rz+BjYOrCDuKKGSqJNTv
         +u7wrbDiN6GxzM+lVgGdMuQoo4n9N7OdMHV2clzOhPj+5yq4lXOQQx/M/Mf+WNf2LfGS
         roSljNZR/rru7d2FngHpHdE9M5hnfNZ898pmXAsos05p8zy6zGs1CZ4hGWJxMxi47uwU
         +2ULc+oM+L2mH+Pz2q1MBLw/y7NUaI/FWZ0X/y37mRxw4CBIDGmyGja3Nxyu39j92DDC
         DCdVSScmyexP+VnO4sXZN/4KACKpyrO8nkBqH+vWulEO4uU2T5Ri9VWcZAFsWSgUhwcD
         3q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459938; x=1740064738;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/MHXBt3ThyNTmD9iHOOhPj6W2u7EZRVkOK3ed1Q64Q=;
        b=V6rGHfOrGywlw7TvtgDpGCxm15tmDkmNxPRHTP1hmOe5Pb4cjeprxtwiwv9HnwHWLi
         9dGkpq83qNvZ3xZcsJwyON2LqeB3LdfLnH1Fma3In/eeKqMp/4BHCH+uUibWgfdwn9mI
         wPTJIHrQqdLiGFRrlCubKISu0ZvrbcXZtKPAsZFiB3TPLFtSnwG2yDJoeE8vcZ1hhHSg
         fjbrWH4DppdH02H3SvYBX12HG7lEjlfsaPKyqkNSDksOz01dxxsfBb6oBilu9UZ97kUu
         HSi6RleC/yjIYJJSSjNC7arGjsvlt/dUIBbNdzhmLekziJ1Z+fIwVyQGP6x9mEKpjjEQ
         qz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQmy/jm5K6m+6sKX+uJVGC6O84Vbx1snkZ0QoXSpNIxdvM33fR8dZfZtlr1FQvkpOIXDFl0zo8mJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFiikiCZ9WKA3ZmWIuKgEITsEEwdn+wSPlp/dEIpLW2BM4Y2h
	RYVA1y3xvr0pBql/Qy6pH6c0Db18juGyQyFIsslIw1duDv2qO5ZHDcwJFTOGdAUnNRT5PlOPXhu
	CPr0e+yyxxS6nfU0i2E2UCTaYoJmPhYLh1vfdQw==
X-Gm-Gg: ASbGncs+wVSX4Mfqs18eJQORd5yE8j6HktnJ35aT9TBVv5+sQCkFofwTM3ONb+wMINK
	rxMFHDm+lN4ngpAJplz1MEgAOOhFuc5QDocrXusa+NEm1pWlR4cz3t0UUh73PRI7R8ZfGN6glts
	moNKxOsC7mz92iPjlDdf77xL5m+eYb
X-Google-Smtp-Source: AGHT+IEUUAMp1A3OZpYQwTyMrudMkiFtVUqwOeMuLEVr7St6uJlPcG5asSsJxDTLPpX7Ju1+2ET5B41boTMft3YQY5k=
X-Received: by 2002:a17:907:3f25:b0:ab7:e278:2955 with SMTP id
 a640c23a62f3a-ab7f34a31b8mr633294966b.38.1739459936619; Thu, 13 Feb 2025
 07:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Phil Elwell <phil@raspberrypi.com>
Date: Thu, 13 Feb 2025 15:18:45 +0000
X-Gm-Features: AWEUYZmetnZU5U18XyjwhGQ_ZYLhS4_yaGIMiS4tC4pNvrJmSgh7GCx5E_wteQI
Message-ID: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Andrea della Porta <andrea.porta@suse.com>
Cc: andrew@lunn.ch, Arnd Bergmann <arnd@arndb.de>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com, brgl@bgdev.pl, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com, 
	devicetree@vger.kernel.org, dragan.cvetic@amd.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, herve.codina@bootlin.com, krzk+dt@kernel.org, 
	kw@linux.com, Linus Walleij <linus.walleij@linaro.org>, 
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

Hi Andrea,

The problem with this approach (loading an overlay from the RP1 PCIe
driver), and it's one that I have raised with you offline, is that
(unless anyone can prove otherwise) it becomes impossible to create a
Pi 5 DTS file which makes use of the RP1's resources. How do you
declare something as simple as a button wired to an RP1 GPIO, or fan
connected to a PWM output?

If this is the preferred route to upstream adoption, I would prefer it
if rp1.dtso could be split in two - an rp1.dtsi similar to what we
have downstream, and an rp1.dtso that #includes it. In this way we can
keep the patching and duplication to a minimum.

Thanks,

Phil

P.S. Apologies for the lack of context - your emails don't make it
through to rpi-kernel-list, and gmail doesn't make it easy to interact
with a mailing list.

