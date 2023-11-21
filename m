Return-Path: <linux-pci+bounces-51-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DE7F35D2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CCB1C20D65
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A82208D;
	Tue, 21 Nov 2023 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR90IS6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E32206D
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E3AC433C7;
	Tue, 21 Nov 2023 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700590774;
	bh=j7HBjbV0HBXxOEcT0OG9f5FjRXuKR0dQ3RimJ19uarQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UR90IS6tEP7ZH2Mu//OVccMIjGE9Vfl31LFB4El1nPF2ME8r7MMhbJAEfIoHe/tY0
	 yflc2zxpNeR3lm0pOY5pTyPelPCqTaXnBpamkUhP3cPZe4uhe/N9ORKaOYvpU6yRbk
	 wwRIEoS1TTof4N+ylTO2ur+LBoJM5h4jdbeQuXbjG8RMYJQkA1kltTm8oae4AORsJc
	 kofl5OLse5z+UlsudmRzP52jMFc7wzD+CWsOk2JVqNYBZ1B13iknFXUXlNJNp9Cndq
	 eJGM+6jfUQIdSPhFsfppv4UaWAe/MqQwNjD32OaNC5SDg74EZuilu0oIHaU0y7Obh6
	 3LCOJmrFHWiqQ==
Date: Tue, 21 Nov 2023 12:19:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Pala <gotar@polanet.pl>
Cc: linux-pci@vger.kernel.org, Dan J Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David E Box <david.e.box@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hans de Goede <hdegoede@redhat.com>,
	Florent DELAHAYE <linuxkernelml@undead.fr>,
	Konrad J Hambrick <kjhambrick@gmail.com>,
	Matt Hansen <2lprbe78@duck.com>,
	Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
	Benoit =?utf-8?B?R3LDqWdvaXJl?= <benoitg@coeus.ca>,
	Werner Sembach <wse@tuxedocomputers.com>,
	mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Manciulea <manciuleas@protonmail.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231121181933.GA240494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121152407.GA13288@polanet.pl>

On Tue, Nov 21, 2023 at 04:24:07PM +0100, Tomasz Pala wrote:
> On Mon, Nov 20, 2023 at 10:29:33 -0600, Bjorn Helgaas wrote:
> 
> > Thank you!  A BIOS update is almost never the answer because even if
> > an update exists, we have to assume that most users in the field will
> > never install the update.
> 
> Not to mention enabling 64-bit BARs, which is even more cumbersome
> ixgbe-specific magic that requires entirely dedicated tools...
> 
> >> .text .data .bss are not marked as E820_TYPE_RAM!
> and
> >> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000df243000-0x00000000df251fff], contact BIOS vendor for fixes
> >> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000000df243000-0x00000000df251fff]
> [...]
> > I think Linux basically converts the info from EFI GetMemoryMap
> > to an e820 format; I think booting with "efi=debug" would show more
> > details of this.
> 
> The dmesg I've attached today is with efi=debug, but the weird thing is
> - both of the above warnings manifested themself only once, with the
> first (verbose debugging: "MCFG debug") patch applied... Anyway.

OK.  I don't know what (if anything) to do about the above.

> The "memremap attempted on mixed range 0x0000000000000000 size: 0x8000
> WARNING: CPU: 0 PID: 1 at kernel/iomem.c:78 memremap+0x154/0x170" also
> seems to be triggered by "efi=debug", so my guess is that it's unrelated.

Yes, I think so.  This is from efi_debugfs_init(), which we only run
when "efi=debug", and I think it comes from memremapping this area:

  efi: mem00: [Boot Code   |   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000007fff] (0MB)

Bjorn

