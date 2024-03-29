Return-Path: <linux-pci+bounces-5412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A149C891F90
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551CB28C47B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB212A144;
	Fri, 29 Mar 2024 13:37:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913941C7C;
	Fri, 29 Mar 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719431; cv=none; b=TS4hvEjycXWlFh857GuzGXaackrgJB0Bl0xNmmUgghqZFTPFoCDeITTrYtpH/3ApeFXRQJ4WZB05oDo4rNJasCef/U1ZBc9hoHiX317mP3p1Eqw8emBhQcXBSSBFGXKodierHxBncnFlkVVobkXQ4hCZFNTysotTlYb6cwMqPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719431; c=relaxed/simple;
	bh=DtoTAQjupKMSfIUCutH4u+VOc8cctrujprJ6Hy4mG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0JY9w19GqWtu39Z+TGJ3aF2dcouyaexECQ4LoeRnSDFEi+gLXU89Yqi08zN5v5X8gvSU1U4DJ9PstUWUFu1LQY8HraH2dKW7vy1rb0HQcSvy/Kr3uFUe4VFvVJCaSrwF8VeBfB9AA/jo1TT8uhet1GAG431W5i1voiHt/efhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id BBBA7100DCEF9;
	Fri, 29 Mar 2024 14:37:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 932C126E89; Fri, 29 Mar 2024 14:37:05 +0100 (CET)
Date: Fri, 29 Mar 2024 14:37:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <ZgbEAa91hYmmhj7h@wunner.de>
References: <20240326131858.GA140624@workstation.local>
 <20240327150119.GA1502858@bhelgaas>
 <20240328144201.510f6d5e.alex.williamson@redhat.com>
 <ZgZGbMj0I3_6Rt0f@wunner.de>
 <20240329081219.GC231329@workstation.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329081219.GC231329@workstation.local>

On Fri, Mar 29, 2024 at 05:12:19PM +0900, Takashi Sakamoto wrote:
> On Fri, Mar 29, 2024 at 05:41:16AM +0100, Lukas Wunner wrote:
> > Just checked the ACPI tables and there's an FPEN method below the
> > FRWR device which toggles GPIO 48 on the PCH.  Checked the schematics
> > as well and GPIO 48 is marked FW_PWR_EN.  The GPIO controls load
> > switches which cut power to the FW643 chip when nothing is connected.
> > 
> > Also, FW_PWR_EN feeds into an SLG4AP016V chip where it seems to
> > internally gate FW_CLKREQ_L.
> > 
> > I'm guessing the driver may need to call the FPEN ACPI method after
> > issuing a SBR to force the chip on (or perhaps first off, then on)
> > and thereby re-enable Clock Request.
> > 
> > It's a pity the ohci.c driver doesn't seem to support runtime PM.
> > That would allow cutting power to the chip when nothing is connected
> > and thus increase battery life.  The ACPI tables indicate that the
> > platform sends a notification when something is plugged in, so all
> > the necessary ingredients are there but we're not taking advantage
> > of them.
> 
> Yup. In both PCI drivers and unit drivers belonging to Linux FireWire
> subsystem, any type of runtime PM is not supported. If I integrate 1394
> OHCI driver, I should implement all of the above in any callback of
> runtime PM, or the part of the above is already supported by any driver
> in parent PCI layer?

The power management method Apple uses to cut power to the FireWire
controller, Thunderbolt controller and discrete GPU is nonstandard.
It's *implemented* in ACPI, but doesn't *conform* to ACPI:  There are
no Power Resources described in the ACPI tables, just custom methods.

This can be made to work on Linux by assigning a dev_pm_domain to the
Root Port above the FireWire controller.  The dev_pm_domain callbacks
cut power to the FireWire controller on ->runtime_suspend() and
reinstate it on ->runtime_resume().  The reason this needs to be done
at the Root Port level is that the PCI core assumes the FireWire
controller is powered on when it calls pci_pm_runtime_resume() for it.
Normally that function would reinstate power through ACPI via
pci_power_up(), but that doesn't work due to the nonstandard nature
of Apple's ACPI tables.

I've implemented this 8 years ago for Thunderbolt but unfortunately
got sidetracked and thus haven't been able to finish upstreaming it yet:

https://github.com/l1k/linux/commit/a53d44439d42

I'm not as familiar with ohci.c as I am (or was) with thunderbolt.ko.
If you could amend ohci.c to call pm_runtime_get() when something is
attached and call pm_runtime_put() when something is detached, I could
look into bringing up the ACPI stuff.  You could acquire one runtime PM
ref for each attached device or just acquire a single ref if *anything*
is connected at all.  Doesn't matter.  But acquiring one ref per attached
device might be simpler.

I would also need a function to perform a bus scan upon runtime resume
which looks for new devices and acquires refs as necessary.  Once that
infrastructure exists, adding the Apple-specific ACPI stuff wouldn't
be too hard for me to do as I could just adapt what I did for Thunderbolt.

Thanks,

Lukas

