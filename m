Return-Path: <linux-pci+bounces-20194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61674A17FF6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEA166F59
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D11F3FC0;
	Tue, 21 Jan 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V7Jh7V3C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382651F1508
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470274; cv=none; b=TzugwJ19q+Tj7218JL09z0yTTX8EbsCw05d6M1hcCyiIPuqn0mxnnLoW//NkWMBuevQfBXte8nBjfcrp7fMG3BRq4pTfY9T5cWGyOi556Yvu5jtc0H+ADjwn1x9+sjXzoqyrpz0XdKWfkxXsVd84Sj5tSdsJgUrigk7ScxDftCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470274; c=relaxed/simple;
	bh=dSRv4Z+gtUFCtc/LYOBMFVK+8Os64RgJXKR8uIWokc8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmyij9onV2Ph1/ksVXX6diirfDdHL1/QuIeQqsFqBz7UklIcyKR2qJ0diY+yT8Vmdr+8Yyk9VT17ESAVyEwTXxQB7u/VwqQ6ZDrMBaS7kKV4dk7+1t7QaCEkCVuwF3u85whbXgN3TW8MVkIGAWVGOX36HI1WpmDoGJhZFqoXx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V7Jh7V3C; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so8482515a12.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737470269; x=1738075069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OP+yLZsGZnxZl3XcQ+L57qZeoo+bUmeJesOySRXDb2M=;
        b=V7Jh7V3CnncDJtbb8BG8tMUpk7GbX2Mhe20YwMr1qfCPFx6/n22zmyEIHvET25lmk7
         BOZ6oSV1el/JTWGFIx1SScJNEgAB4vo/kZaYVlKJDY/VCYj+vwdwJjKDU53kwpjoIemN
         TZoy6ZwsWi7B7N6jzZV4JZhhuzD3Ko3DlyrWsrqd9nw7iLYDxtr+1/qk8V8ookkYqQLf
         E9TnLsbRqfwWMElnqhy+pEje8fN7HuzSY1PhvKkK3GVK3E8EMY3dxhP3ugGYRgVmrzpJ
         Twf7FUqZTf1j4vAdHg6h1BTKAcomstHvuf1vPvCsEbyCtViG7sbvdSn+e8JXVxi7Pe3Q
         ldGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470269; x=1738075069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP+yLZsGZnxZl3XcQ+L57qZeoo+bUmeJesOySRXDb2M=;
        b=DkOwnRf5faH5WuuV2oMNUTvee2WshjDzRm4m2kOfMABDj9ZBmwv+cUKCVM1hQv3vMQ
         2KVOpt/yQvMpYr/2rrF1BN/wcMBd6BIHbb9JA+vs78iRTc/CAuE27ONHnLxxyGis4ijM
         IxdT1UGgpIwwQno6NMEFqLahsxnvv3XnDM/2SXObaxzpp2OmPJpcHXkNc4Xh8FuDMKtH
         XEFvLRa78ft7/7D8hwAlxZ2tkSTMneOyS9ezgL9FIspiK9dcwH5ucb2jP8fvYItptMws
         vXE4Ye/3B+pDDi4xAoESnwXM+4UdLSujmqz0vLHNHy5wvWKlg2DMtB4oYIjqUqz5T/Ev
         jn0g==
X-Forwarded-Encrypted: i=1; AJvYcCXqQsghZYEG/Xh24U0xnECqmBYs3hEuKObGFhRerN39zDNxCstUEL5+LFFsPzpX+sd5Q1CmAxOnJ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfraxJig8fZnAHjGj7V4Os0wGHp2lYGMr4lXJaUilF2gqWkhsp
	jneLbkKM8rxlgUKj140VHlTCL4FhbVtGn1YH7zZzAabbWd2uN+dS6e2ofMYkXE8=
X-Gm-Gg: ASbGnctCXWwvjg6W9+mN4UTHwSZ4IOPWnWzlFB7Vdlva22igm7fK+zlL7ruxPuSUWwA
	TUgPYMbjdn57qjhWHKmfUPO2E4fLxIxPtQiY3nPbUEfGnbNGIiTMZ5D7c4tzsC3Jmq2NDqj9Mox
	gw7rL9isBZtvgSa0kVTjotlaqtjzIC2uzVMeJuYt0EQwexAWxG3U9Be7SGMFIEv9ssWam/X5VWd
	8JWQhS2lz0k9ElyNrYmPooPmhuMivSL61YHH6dj36r0sHIHquJ193sLvJFdr4WKkDH5tPDJwraC
	emJsBSxv8mD1cvBVDWe60xInPhpC5hqndrCSlebI
X-Google-Smtp-Source: AGHT+IHrdKVrwSeMZy2lajXUFaaswl4BBAIMKjnMweMj9CE4d/aKkVXO5Bbtz0sEBeHig2196Qh7kg==
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5db7db07334mr41029714a12.22.1737470269436;
        Tue, 21 Jan 2025 06:37:49 -0800 (PST)
Received: from localhost (host-87-14-236-197.retail.telecomitalia.it. [87.14.236.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab64998511esm53461766b.68.2025.01.21.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:37:49 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 21 Jan 2025 15:38:42 +0100
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z4-xcjov0HLivfVX@apocalypse>
References: <cover.1736776658.git.andrea.porta@suse.com>
 <550590a5a0b80dd8a0c655921ec0aa41a67c8148.1736776658.git.andrea.porta@suse.com>
 <2025011722-motocross-finally-e664@gregkh>
 <Z49eOdVvwknOoD3E@apocalypse>
 <2025012143-rippling-rehydrate-581b@gregkh>
 <Z4-oORWO4BgOqibB@apocalypse>
 <2025012157-bonsai-caddie-19b2@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012157-bonsai-caddie-19b2@gregkh>

Hi Greg,

On 15:18 Tue 21 Jan     , Greg Kroah-Hartman wrote:
> On Tue, Jan 21, 2025 at 02:59:21PM +0100, Andrea della Porta wrote:
> > Hi Greg,
> > 
> > On 09:48 Tue 21 Jan     , Greg Kroah-Hartman wrote:
> > > On Tue, Jan 21, 2025 at 09:43:37AM +0100, Andrea della Porta wrote:
> > > > Hi Greg,
> > > > 
> > > > On 12:47 Fri 17 Jan     , Greg Kroah-Hartman wrote:
> > > > > On Mon, Jan 13, 2025 at 03:58:07PM +0100, Andrea della Porta wrote:
> > > > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > > and others.
> > > > > > 
> > > > > > Implement a bare minimum driver to operate the RP1, leveraging
> > > > > > actual OF based driver implementations for the on-board peripherals
> > > > > > by loading a devicetree overlay during driver probe.
> > > > > > 
> > > > > > The peripherals are accessed by mapping MMIO registers starting
> > > > > > from PCI BAR1 region.
> > > > > > 
> > > > > > With the overlay approach we can achieve more generic and agnostic
> > > > > > approach to managing this chipset, being that it is a PCI endpoint
> > > > > > and could possibly be reused in other hw implementations. The
> > > > > > presented approach is also used by Bootlin's Microchip LAN966x
> > > > > > patchset (see link) as well, for a similar chipset.
> > > > > > 
> > > > > > For reasons why this driver is contained in drivers/misc, please
> > > > > > check the links.
> > > > > 
> > > > > Links aren't always around all the time, please document it here why
> > > > > this is needed, and then links can "add to" that summary.
> > > > 
> > > > Ack.
> > > > 
> > > > > 
> > > > > > This driver is heavily based on downstream code from RaspberryPi
> > > > > > Foundation, and the original author is Phil Elwell.
> > > > > > 
> > > > > > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > > 
> > > > ...
> > > > 
> > > > > > diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..3e8ba3fa7fd5
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/rp1/rp1_pci.c
> > > > > > @@ -0,0 +1,305 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> > > > > > + * All rights reserved.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/err.h>
> > > > > > +#include <linux/interrupt.h>
> > > > > > +#include <linux/irq.h>
> > > > > > +#include <linux/irqchip/chained_irq.h>
> > > > > > +#include <linux/irqdomain.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/msi.h>
> > > > > > +#include <linux/of_platform.h>
> > > > > > +#include <linux/pci.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +
> > > > > > +#include "rp1_pci.h"
> > > > > 
> > > > > Why does a self-contained .c file need a .h file?  Please put it all in
> > > > > here.
> > > > 
> > > > I agree with you. Indeed, the very first version of this patch had the header
> > > > file placed inside the .c, but I received concerns about it and some advice to
> > > > do it differently, as you can see here:
> > > > https://lore.kernel.org/all/ZtWDpaqUG9d9yPPf@apocalypse/
> > > > so I've changed it accordingly in V2. So right now I'm not sure what the
> > > > acceptable behaviour should be ...
> > > 
> > > It's a pretty simple rule:
> > > 	Only use a .h file if multiple .c files need to see the symbol.
> > > 
> > > So no .h file is needed here.
> > 
> > Perfect, I'll revert back that two lines to V1 then. Please be aware
> > though that this will trigger the following checkpatch warning:
> > 
> > WARNING: externs should be avoided in .c files
> 
> Well where are those externs defined at?  Shouldn't there be a .h file
> for them somewhere in the tree if they really are global?

Those symbols are deined in drivers/misc/rp1/rp1-pci.dtbo.S (added by
this patchset) and created by cmd_wrap_S_dtb in scripts/Makefile.lib.
They are just placeholders that contains rp1-pci.dtbo as
a binary blob, in order for the driver (rp1_pci.c) to be able to use
the binary buffer representing the overlay and address it from the
driver probe function.
So there's no other reference from outside rp1_pci.c to those two symbols.
In comparison, this is the very same approach used by a recently accepted
patch involving drivers/misc/lan966x_pci.c, which also has the two externs
in it and triggers the same checkpatch warning.

Many thanks,
Andrea

> 
> thanks,
> 
> greg k-h

