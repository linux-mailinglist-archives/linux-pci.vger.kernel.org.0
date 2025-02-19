Return-Path: <linux-pci+bounces-21810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBEA3C5A1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0638188C415
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C521421D;
	Wed, 19 Feb 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3GT3MVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D233214216;
	Wed, 19 Feb 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984803; cv=none; b=giZujX1v9PcLaLUBSRLf9wca3k8OHVzTVAI9w+qv63T9etyx5GrRrb4E2GpdCDIQZN0E4Uw7gdKY6Bi7U54xSGuhIpUONuYpWcj0NwHfuOT37zDARIELyFbzxJla801A6OoXa5g5Iii2/bGONrm72eH6pVMS4GSRZ7EhNH/+vEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984803; c=relaxed/simple;
	bh=MyfLEvfS7yxTS8fAcMru9YtZORPP55M03oOVf1wJwag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kGF4R4ivL5cPuYYMHOeN62bV+uZoua9l5HE/vWz/zrb7uGP/iXNWHOh7eKwZmpcuaBbMao50w8fPXDIUOfnpzJVphel55AyuLdI1SwXhjx9QkHEg2bVzYO28nrdmo6R/5QK3KSqKG5JLTNG+2v0S7/IispFUILwwf9EHmH3LXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3GT3MVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FBAC4CED1;
	Wed, 19 Feb 2025 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739984802;
	bh=MyfLEvfS7yxTS8fAcMru9YtZORPP55M03oOVf1wJwag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N3GT3MVnRSqdikNeUBuH8nooDmDSlHq7qhQNbdzQQCBEGY3dgQF0c2xzPbt3cCgiA
	 lhHU9ac9zww9+54xp2eKqSDGZxs75xiSiOssp9krqAWzxWE+s6Oe9DhqUR77zl4qrc
	 A6EmmpD2rftmBbwBcwNpj0lgDLE1HXFvJl+Dd28ZnoM1iO2OC5HGl973pPhUaPIZlq
	 0hmYPkmqrNwb1egOEbiaDPZ2azBpMG8b2a49onzyMIiRwc2pDpqLzb8M1DYWorRpPR
	 b9JuBolf8uORmuCE3CnN2fH5FMWgUs0XAJCEvfHt/da38pNyBNJQOXY5+pBaG2Q7VS
	 SkQqm5nFNM+jw==
Date: Wed, 19 Feb 2025 11:06:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250219170640.GA219612@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMciSVU4vv7=WjVUhuP3PJHdpnYqrgMPCmz-HnijEbhyxk54eQ@mail.gmail.com>

[+cc linux-acpi]

On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> Hi all,
> 
> I am writing to seek assistance with an issue we are experiencing with
> a PCIe device (PLDA Device 5555) connected through PCI Express Root
> Port 1 to the host bridge.
> 
> We have observed that after booting the system, the Base Address
> Register (BAR0) memory of this device gets reset to 0x0 after
> approximately one hour or more (the timing is inconsistent). This was
> verified using the lspci output and the setpci -s 01:00.0
> BASE_ADDRESS_0 command.
> 
> To diagnose the issue, we checked the dmesg log, but it did not
> provide any relevant information. I then enabled dynamic debugging for
> the PCI subsystem (drivers/pci/*) and noticed the following messages
> related ACPI hotplug in the dmesg log:
> 
> [    0.465144] pci 0000:01:00.0: reg 0x10: [mem 0xb0400000-0xb07fffff]
> ...
> [ 6710.000355] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [ 7916.250868] perf: interrupt took too long (4072 > 3601), lowering
> kernel.perf_event_max_sample_rate to 49000
> [ 7984.719647] perf: interrupt took too long (5378 > 5090), lowering
> kernel.perf_event_max_sample_rate to 37000
> [11051.409115] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [11755.388727] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [12223.885715] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [14303.465636] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> After these messages appear, reading the device BAR memory results in
> 0x0 instead of the expected value.
> 
> I would like to understand the following:
> 
> 1. What could be causing these hotplug_event debug messages?

This is an ACPI Notify event.  Basically the platform is telling us to
re-enumerate the hierarchy below RP01 because a device might have been
added or removed.

Unfortunately the only real information we get is the ACPI device
(RP01) and the notification value (ACPI_NOTIFY_BUS_CHECK).

You could instrument acpiphp_check_bridge() to see what path we take.
The main paths look like enable_slot() or disable_slot(), but those
both include a pr_debug() than you apparently don't see.

A remove followed by add would definitely reset the device, including
its BARs.  But you would normally see some messages related to
enumerating a new device.

If this doesn't help, try to reproduce the problem with a recent
kernel, e.g., v6.13, and post the complete dmesg log.

> 2. Why does this result in the BAR memory being reset?
> 3. How can we resolve this issue?
> 
> I have verified that the issue occurs even without loading the driver
> for the PLDA Device 5555, so it does not appear to be related to the
> device driver.
> 
> Any help or guidance on debugging this issue would be greatly appreciated.
> 
> Thank you for your assistance.
> 
> Best regards,
> Naveen

