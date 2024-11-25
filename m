Return-Path: <linux-pci+bounces-17274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF29D7DCA
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FB11619ED
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D718E023;
	Mon, 25 Nov 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TYtW/zP3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46318CBF2
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524883; cv=none; b=haeU4Bwomxyknd0cugYDMchLLz6TNDUpyFSZzyZhOSo2mJhtxbXzJE2LvoUYXxk3SYFUHPZxnaWbu50yaQJEyBFKX5lT6ZRVZJDIK5bdAW0NbYBJhYnT5Xfm3XHk5oRHJP3q0Y2OYcMK9fQQiIcanpWtpDaxhSiOfdDchyHAW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524883; c=relaxed/simple;
	bh=uZFCAWid8rhJHzelkWD3pFnre9T42ijXLP2LF1wPb9E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA1e4BxHEL0e78OfCrBLFkwtpKeHQiwK3tRsG+3b2Mv1FwGgsZwQdy1gwQsuDGniqhxN0xQ5FMM4/s0Gu1yAzFjVGX/vgGRXy4uxQg+tqYygxTSahwQsm3xQdo7Vh4G0GqnY99kbuZfKWNLo1aWiHWBGVRH0WKaG2wTIDp2be5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TYtW/zP3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso8840627a12.0
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 00:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732524879; x=1733129679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBZh/dlJgKLPhdmjnm36EVhHzC98YQaW9Lth/5vAKvc=;
        b=TYtW/zP3oxM1vFpM4KM8y6kvAht7l8o2L3yAU4ZwzteZAKmcbfAw8/WaoqTT3dTtiC
         cUftivx1BsOxrK0/JqNDCiJc366IyQbjOH4EI6rY7ZiYoX0xhGT2irkgFxMdJcmyAVel
         c/sjwVbyA4syCPaIRvjcuuZOi6VOS9DkpMBAOnNcGvcnPFrn9zNn6z1FYBNEfhObgdnJ
         rzU21xHVizGo+uiDf1yW/OlhTtMQ3w39bQL9SOVSncSGPWMPfFo43Nx2Q1m1p1HYCgIK
         0jqtquHIKJIzjITbwZf4Aif6uFYkC8+8Fu3RC6hb9avaZ1Q0rGptY2c+B4ggNkffJ57D
         J84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524879; x=1733129679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBZh/dlJgKLPhdmjnm36EVhHzC98YQaW9Lth/5vAKvc=;
        b=MSpzXnnI8nA2SeWqnQF57+pjp8rWD5YfXL6TtnBGuzWz2hbxaKEX8n4uV9BkQRsR5v
         Otcfm7TkZBZYldHT4llJw01n1mKVOqanCJoTgXLHiHx4SlidCeh66s4TsTbCNRXhkofa
         Jj6/+JLIXuptQ31o3G4EK3/rQrvzleyjFXTk1/J6785+WMR0GJek1rDAV9xEkW4T7qJN
         TilTD4niJOsNM40bfdvcql1MqWzWRO6dgL+gdQq0C6l1wfzvh9quYiG7BF4VZocVQu92
         6AOfzGWUVsXifJ71roAwyRdz9MMQUCtpgneI+sDaxNGH4Z2C45JnRLhk2H5rA9X99/2d
         cC/A==
X-Forwarded-Encrypted: i=1; AJvYcCVtEw0PDruMgSCv4JICYiYnBD4UX40+Vk2jqlrjmHIOm1+K4Ei9QCuz6uFlZGrOolOs4bVr1rDdlLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvH6AWhSnN8iH1totfLIMKlFJ2OqQHAZ3dJtDKjeLXcAK7/Ni
	afxojOBD4SGxL6mNe/lzUokI8+lbU8O2GX1e6KK9NDM1+Djy0U1Sug6IXuOzH6w=
X-Gm-Gg: ASbGncuAX/+9yCuRD0d2lC6XU8fVJQlKdGy17AqIRfbMPzJ5ij5wC050sDmoD+9SB2s
	er3QOlRDwIqlzbI82MGC7kzoCv2Sh0yN8JctpLF7WhFT+1ih2tdntU9vUKBHUNW9mXaFA/Ifv+Q
	oLVZEM6BQsl1rawcr9mfcWak8ooCDTegKeQTap93ONEXwTXP5oVDWxD8ilVdYFZiMtMEvm1Oiv7
	mLX6j/5JmfdX4h3SBfEGPkome/RnyxB47+a8RUZ9yteYjOxjHqCUkI+dybznSgsfusPfyLxHeF7
	hsVjOMx+kZJskXiNHcSc
X-Google-Smtp-Source: AGHT+IFNCFEK1ia8R/Vdi4LB9FLJuTXnKmbw4fkVMzsCxQu2qYrzuZQkQ2EAs+H3uMAiTz2NmcDbIA==
X-Received: by 2002:a17:907:60ce:b0:aa4:e53f:5fbe with SMTP id a640c23a62f3a-aa509a1c2f9mr1339686366b.19.1732524879322;
        Mon, 25 Nov 2024 00:54:39 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa51759732asm406733166b.14.2024.11.25.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:54:38 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 25 Nov 2024 09:55:11 +0100
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 09/10] arm64: dts: bcm2712: Add external clock for RP1
 chipset on Rpi5
Message-ID: <Z0Q7b-Qgjqs7NLS2@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <8deccbd7ab8915957342a097410473445987b044.1732444746.git.andrea.porta@suse.com>
 <9abb376c-3399-4c2c-8e7c-cea1184ea370@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abb376c-3399-4c2c-8e7c-cea1184ea370@lunn.ch>

Hi Andrew,

On 20:41 Sun 24 Nov     , Andrew Lunn wrote:
> On Sun, Nov 24, 2024 at 11:51:46AM +0100, Andrea della Porta wrote:
> > The RP1 found on Raspberry Pi 5 board needs an external crystal at 50MHz.
> > Add clk_rp1_xosc node to provide that.
> 
> I'm wondering if this is the correct place for this clock. From your
> description, the bcm2712 itself does not provide the clock. There is a
> crystal on the board. So the board provides the clock. What happens
> when the RP1 is used on other boards? Also, does the RP1 need an
> actual crystal, or can you feed it a clock? Often such inputs are
> flexible, you can connect a crystal across two pins, or you can feed a
> clock into one pin.

AFAICT the only choice would be a crystal (I'll try to confirm that with
Rpi folksi, just to be sure).
In fact, I've expressed your same concern in the dicsussion that followed 
previous patchset revisions, and it seems that the preferred way is still
to stick to the current hw: since the crystal is on the same board as bcm2712,
it should not be described on the overaly.
I think you're right though on moving the clock definition to the board dts.
I'm still planning to define the clock in the rp1 overlay if any
new PCI card will contain it in the future: after all it will not cause any
clash with the clock defined in the board dts, which could be then removed
gradually.

Many thanks,
Andrea

> 
> If a crystal is the only choice, i would probably have it part of the
> RP1 overlay. If a clock can be used, i would make it a board property.
> 
> 	Andrew

