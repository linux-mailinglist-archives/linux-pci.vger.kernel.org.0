Return-Path: <linux-pci+bounces-30024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22814ADE768
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 11:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5478164BB7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC328466C;
	Wed, 18 Jun 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qupafl0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44A283FDB
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239941; cv=none; b=bttBDydTi8pI2AGDTIvoAuXZh2stUEOuetHkMAF4BJT+LpYKRRZyXQ0tA9kerYt6q/AbtmOWtDQ/qdErWlleP7HE3nNdu8aLYmIxIbRrfFkJmQ4KeL8tFCiY4MZb5vAaH5SUypv8Ul/I18oUK/wqS6Dgx4gyhGVF/tYfinABpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239941; c=relaxed/simple;
	bh=iAjLoMsszcwu/0Vb0KghUOteF+dXhpPUULmxrg+YQxU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRychlL6/eXR962p8keFoINU+QO+6QoeEURopqVbzKofD24ArDQb07Rx/j6g4ERSRC3/X6OYuj1PIYG4BVYqVVl9OBlxV69j88/uRV+40N2YP6cDkUyFxNvcYDcRIZgVTcuCt6ngYhbWCSR/yzEiv+4DhevplTjcWHzMRGCFVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qupafl0c; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb4e36904bso1295033666b.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750239938; x=1750844738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYnRFTZ45S0BZCYHJEL9/estxYeR2eD0JqS9fCRB9Zg=;
        b=Qupafl0c5CMMKlHN7UvUZrt/02ySqRGQpRAnC5qKjbRYjkqTLAMniB2gGJwOWDcYYA
         RAG4LIIOepVqdNxJJ5QtX5Zizs/sZ4ef7KQzgDot1F3FYYZIGWR70raM5X/d855K4Ile
         QtSHCO85ZvwhZSvehGiplrMrkwezuYMQvYC0cd+xheUti/NVFcQnVXSI/J45jPYicrga
         zVoEcyLbUiokXNk0wmuI+3eoa16RUoBfy8jg0hmuGJSVtOeGtRIbelVF4hyTgjgi+Ixa
         dnM7scfcH9aph4NEjaaonb4apI8T/MgDa9qmaIsEOplGxlEO/JaQFJSPIiRDAY+ZR0s1
         IDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239938; x=1750844738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYnRFTZ45S0BZCYHJEL9/estxYeR2eD0JqS9fCRB9Zg=;
        b=Va3/KCfY/tdKKDPV7hjrbXEabUKKNhC2LuDkW0a0SbVVLJxRaQScmlLLmnpeJxBDs3
         KGBIO3FyNqU0ZsuKxC0+u3HFzmXIEWEcE5S9NePjLCDPmS95LQHBrOG6REqOtroVtB2n
         x3NOY9QkJV4fxK1CiUmvHdGYrrgwKt7Dp96evY5JTEoK0z8KDLpLETLZk7GYR0qnC54P
         nlL31KqIjJWaBL9m9uGxz4jCOH8z7Y0rYdJ8TGmiZ6royloqKN0S0xMWyWWlvzH1fZBO
         h1uv9/a3GThSlWWKX4NIWRXo9bkNeuNiOYx4DeJM+RyKO3w82HPyVOvlpJLAsd817vhT
         yPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMWpOwKXojPrV83Xjy1PGjbHvreO9t5z1XNUiAdko/4jmuPtcQsv4oufsKgr91RVi5UQUssBkqwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHLf3aXBI7fDHPZoZ6gIEBclCX+sMOYkgu4cI4fN//Tfd/XHK
	q8ov1N3TSvYEJ+PgnU+BVKm6U2Ubis/FgdMjx2ATgZmTMV/xk6YgTGkqOTG0jqPeAfQ=
X-Gm-Gg: ASbGnctveyXP+y7OZH0Bal1uYrUPyyZdgu5W6ZKDkLmkpBlW8US32pX+gdtm0CWYAMl
	VueK+f2iKNpQlOg3qadZreu48l5Cp7VvdCapB7bC0LmN3MG8Z3vacW+LUGmstvqW80XbKmeqWsG
	gxtJmwoezENiMejr1dim9H9NP4/e5gwO8tO+ZZGcWzVJcY54ijDeT/HljxFBizcxMNq2psAzOWM
	FgnCJPlANmtuDZLI05PpmqzAOXl2JETRog8aEn3trz7p927tOB5ybxtA8vE+hTGLBVqpXr6fs1z
	QgRkhusVVLlI/ZjPPjdvWqm4glldqhh6PzsXZLPHZs5eJQ8N32qN7/6eYxcMpOH9agmfuQUog+r
	++T+BaACfET5uphAwgS0tE2i5D/D4KWmW9FeUp+DbPW0=
X-Google-Smtp-Source: AGHT+IHVR01GWZaWv7baTcjU5O0kFwotFGhrlpvKdhdubFxB0wxEVad57csE1YDZMPi3+Mm5z4P0Fw==
X-Received: by 2002:a17:907:3c90:b0:adb:2577:c0c5 with SMTP id a640c23a62f3a-adfad5c74fdmr1544262766b.38.1750239938008;
        Wed, 18 Jun 2025 02:45:38 -0700 (PDT)
Received: from localhost (host-79-23-237-223.retail.telecomitalia.it. [79.23.237.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8158d4dsm1015674366b.28.2025.06.18.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:45:37 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 18 Jun 2025 11:47:16 +0200
To: Bjorn Helgaas <helgaas@kernel.org>
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
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH stblinux/next 2/2] clk: rp1: Implement ramaining clock
 tree
Message-ID: <aFKLJELw3JuFI9GR@apocalypse>
References: <b70b9f2d50e3155509c2672e6779c0840f38ad5e.1750165398.git.andrea.porta@suse.com>
 <20250617145144.GA1135520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617145144.GA1135520@bhelgaas>

Hi Bjorn,

On 09:51 Tue 17 Jun     , Bjorn Helgaas wrote:
> On Tue, Jun 17, 2025 at 03:10:27PM +0200, Andrea della Porta wrote:
> > The RP1 clock generator driver currently defines only the fundamental
> > clocks such as the front PLLs for system, audio and video subsystems
> > and the ethernet clock.
> > 
> > Add the remaining clocks to the tree so as to be completed.
> 
> In subject, s/ramaining/remaining/

Ack.

> 
> I guess we actually get some functional benefit here (something that
> previously did not work, will start working after this patch)?  It
> would be good to mention that here.  "Completing the tree" sounds
> nice, but if I were being asked to merge this, I'd like to know what
> benefit it brings.

Sure, I will add details in the next revision.

Many thanks,
Andrea

> 
> Bjorn

