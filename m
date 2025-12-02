Return-Path: <linux-pci+bounces-42535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17913C9D1EA
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3044E02FD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F332F691E;
	Tue,  2 Dec 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxRhsdzb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F2222597
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712445; cv=none; b=MUho/1kzVNKdPBjO4c+N9L8YjYhNPLi8CF6uJFhMKpxaM17Tuj7EqEzZ0h+terMh2vrdpxRRnZ/4lu/rLi+QmSx8mdk2qsFgzbfjugNbdeUv4og8tyUM6QCZDE2vnJXoyERuFaPbCla7cYC7KN0wlxrIQdoKKFQlXzN4YEAupIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712445; c=relaxed/simple;
	bh=W0V7P93neIn2iB64a++B6hESjcI5jM/+kLB2CBVwbE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq5h53vzv6+szlEy/ToI7piVyH4wwMw2l65zQ8DTK0DTNuwZvXEA8nFOUpMGfD/+OwaaHk/CI1azQrrmWDAkRAsxGmIEff9Z0MJWUsY6E8a31CJX77kBqpfiddXl7yOLpcAdIuvg1fg6VxTM16unq6PBoUj0bWaXpEQXbdKdMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IxRhsdzb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so3349109a12.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 13:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764712443; x=1765317243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCirGjV3/DFcYbsMad4kR06svckBi7sOFnowquKvHe8=;
        b=IxRhsdzbjnlBqrmLK6HY6DG20Kt9moUsiravYscYmyxRjkrlDfBwizHlsYmFAM6FZ1
         4iTBgb3x9R0cro4QdNG3y1vD4IYRm5wNQXJSyh/fyF+rfegb9RuCtNaFPg0pGS/U0a2N
         lfmKDF+J5W6leG57b+3OL3Q1YzjNoHFL41n34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764712443; x=1765317243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCirGjV3/DFcYbsMad4kR06svckBi7sOFnowquKvHe8=;
        b=or3Q6L6CIxgD6KYmKFGbvhtluTDzH4ASTKvmV4Kr5dUV7/xZy+6B3sFbTPtqtWDtBE
         8zBPyqtg7eIcia4Mm3GPvxmvWk4ThyIDbmZzDIOye6VhI/X4YQtTktQzMSe360m0U08t
         rH6B+xa6IP8rKCIhWvazhfKjoUrOph5tI3ww682eyQKxcxe4HR8rxDgFdow/LY+G8kra
         r7D1xuNZd/V2vHG3EDvUyrOXjWW2kdW0SKLNii8IPV56ZuQyLOskShmSi1e5OFUnHQDP
         XOT9JGEXDhQ9bbsmfY3Qpxf2Vm7+j3eD78D2WpQfX+EiK72h+YT2h6KxN0Bqqoob4RY/
         0TTw==
X-Forwarded-Encrypted: i=1; AJvYcCVolWQ5mcOVD9QkDwOkSXWd/HQUol7M3S6iTIKP2FDuWbVvUgwkRgUMWheASbGLfwKEsbLuTRbZ65w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmb5G1NgF2dQdVhBV0/Qmxw3u5V4PS0PqvY+GoMSFG4B2UC8Up
	1HczOkSB/FwHNVmaOhn895cNAMV4hMK8bY2cCw3vMRBenAC+D/nDV+wVYMhB5+uMXQ==
X-Gm-Gg: ASbGnctwPpJscx+eKmktzhrosXluC8fB14Cz9FR7d6y2xGqHh/Z3f+EoLGUyjBCKEKj
	oQShXzC5Kz5xs1HaQfsa1fRoUqwtD5msZqdQLXRDF6UL2Xz5chgSv3R4n7CQmIoHqUV4JBxsFKB
	ire+yey4qI5yv6FwHrCNCvmm244rfLtUnipBG7FhCWhNoljK3uWIP0mXVTz6Aq/Odzc1HfHVlO+
	zcKlN4AcP+YCf9t+DQrK492SORXO571Pu4Sqr6u8T5qDpUV7Cxu7NpvXThVifk2u+BHv+z09Ixk
	fKICxvvs19wYaG4FXlw3rg6XHHv/tlLCr0qT5tG7PGMyOZDTXmC4ljNZY7dCiv80sP5nYegfvJ2
	LYGlOmIxE2Xqyyd642sk59xLH6BDvteSeXFiLvTF7xQoaJDw2jb3QVl3KVUneF5YYuI8jASJhjX
	KbTHLYB9fM5fFKDJ2j8i3bzq/hsKGcrJRbAXxHQUfx3i1dqh2/OA==
X-Google-Smtp-Source: AGHT+IHnvrGhJjf68XCIDP9snnMvR3mnikEUomrgLZk61aCRBp4DY9aPnTFoOtshoIIKWOLqNcEWbQ==
X-Received: by 2002:a05:7300:e8b0:b0:2a4:3593:468a with SMTP id 5a478bee46e88-2ab92f7e159mr37332eec.38.1764712442741;
        Tue, 02 Dec 2025 13:54:02 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a9653ca11esm57570220eec.0.2025.12.02.13.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 13:54:02 -0800 (PST)
Date: Tue, 2 Dec 2025 13:54:00 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Riccardo Mottola <riccardo.mottola@libero.it>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
Message-ID: <aS9f-K_MN0uYUCYx@google.com>
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202172837.GA3078292@bhelgaas>

On Tue, Dec 02, 2025 at 11:28:37AM -0600, Bjorn Helgaas wrote:
> I think we need some kind of analysis of what is happening to the PCI
> devices here.  I don't know why the CPU architecture per se would be
> related to PCI power management.

Agreed, and I think it will be very hard to ever make any traction on
modernizing the PM stack here if we can't any sort of "why?" answer out
of the systems that don't work. The last time this came up, the answer
was essentially:

https://lore.kernel.org/all/CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com/

  The DMI check at the end of pci_bridge_d3_possible() is really
  something to the effect of "there is no particular reason to prevent
  this bridge from going into D3, but try to avoid platforms where it
  may not work".

i.e., no specific reason, but a vague understanding that there is some
old HW that doesn't work. That's not very helpful for supporting non-DMI
systems that don't have a programmatic notion of "old."

OTOH, I sympathize with Rene, that it's hard to dig into what amounts to
new development on old platforms, and yet, they do remain broken.

> pci_bridge_d3_possible() is already a barely maintainable hodge podge
> of random things that work and don't work.  Generally speaking most of
> those cases relate to firmware.  

I wonder if we could take a different approach that helps straddle the
uncertain boundary here a bit:

 1) be more aggressive at *permitting* runtime PM / D3 for bridges
 (i.e., if we think a bridge might be OK to go to D3, then manage its
 get()/put() properly); and

 2) be less aggressive about default-enabling runtime suspend / D3
 (i.e., only call pm_runtime_allow() in drivers/pci/pcie/portdrv.c in
 limited circumstances).

For #2, that would actually match the documentation:

  Documentation/power/pci.rst

  The driver itself should not call pm_runtime_allow(), though.  Instead, it
  should let user space or some platform-specific code do that (user space can
  do it via sysfs as stated above), but it must be prepared to handle the
  runtime PM of the device correctly as soon as pm_runtime_allow() is called
  (which may happen at any time, even before the driver is loaded).

So instead of portdrv.c calling pm_runtime_allow(), we'd leave that
decision to user space (i.e., udev or similar). That will help limit the
impact of getting #1 "wrong." And it's possible the bad systems didn't
really want aggressive PM anyway, so it's not worth much trouble.

For #1, that means pci_bridge_d3_possible() would become more like
pci_bridge_d3_impossible(). We could leave it as-is, or at least ensure
it fails toward the "possible" side.

IOW, user space can choose to opt in by way of:

  echo auto > /sys/bus/pci/devices/[port device]/power/control

That might require some new udev rules if existing x86 systems are
supposed to retain their old behavior.

Personally, I care more about #1 (that the kernel manages pm_runtime_*()
refcounts properly, so that my systems *can* opt into aggressive PM),
and less about #2 (it's a fact of life that PM policy often requires
careful udev / sysfs management, and that the defaults will not
necessarily give the best power savings).

This might leave some old unmaintained systems as "D3 possible", but we
don't actually exercise it if user space doesn't poke
/sys/bus/pci/devices/[port device]/power/control.

Brian

