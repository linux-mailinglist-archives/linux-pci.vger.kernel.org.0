Return-Path: <linux-pci+bounces-7212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2968BF586
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 07:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAE1C2139A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6D9168DC;
	Wed,  8 May 2024 05:14:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21943182C5;
	Wed,  8 May 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145291; cv=none; b=iv6XLQSoRVqEz4ezY8xBBaoXKcUcDGXerH2xHIZy8utZiub80gWdtR2AQTXbmSQOty5HXGG8wFZzy/PQv1EmicS/5JF9a7kspjB5AeAfKgEJ1dfqDC87h2mksySSqXCGl4GTSl84LP1zG++kzM/M0YOrJpyHZb9fVJFh4q/b9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145291; c=relaxed/simple;
	bh=/YST7JttZYUhFEhxiwIV1PLpBD/c9+ByZTl2gJ9FNTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZW9qPvK0sxR3Pd4In7sl8swDHUKfnpJSGkEJRbjOvNYz6hQ96B+AZ8exwg/VOdhaSw3tKSOkQ+YUMSyxAgv9S+omH52DBTj56FC1cvTMOMYMird6HdOLEBPCwSOCfHi3wrrNT5+pB0GF+taZfZVMQ9PtDnUZda6dPJcidcWk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 28390101EB72D;
	Wed,  8 May 2024 07:14:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A9A594FB157; Wed,  8 May 2024 07:14:37 +0200 (CEST)
Date: Wed, 8 May 2024 07:14:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZjsKPSgV39SF0gdX@wunner.de>
References: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>

On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> That is correct, when the user-visible issue occurs, no driver is
> bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> attach to the external-facing root port because of the security
> policy, so the NHI and XHCI are not seen by the computer.

Could you rework your patch to only rectify the NHI's and XHCI's
device properties and leave the bridges untouched?

The thunderbolt driver will then rectify the bridge's properties
using the patches on this branch (particularly the one named
"thunderbolt: Mark PCIe Adapters on Root Switch as non-removable"):

https://github.com/l1k/linux/commits/thunderbolt_associate_v1

This approach keeps most of the code in the thunderbolt driver
(which has a very clear picture which PCI bridges belong to the
Host Router and which to Device Routers).  The footprint in the
PCI core is thus kept minimal, which increases upstream
acceptability of your patch.

You can match the NHI using DECLARE_PCI_FIXUP_CLASS_FINAL():

* Search for PCI_CLASS_SERIAL_USB_USB4 with class shift 0
  to match a USB4 Host Interface from any vendor.
* Seach for PCI_CLASS_SYSTEM_OTHER with class shift 8
  to match a Thunderbolt 1 to 3 Host Interface.
  I recommend checking the is_thunderbolt bit on those devices
  to avoid matching a non-NHI.

Then fixup the device properties of the NHI so that it can bind.

To also rectify the properties of the XHCI, you'd have to use
pci_upstream_bridge() to find the Downstream Port above, check
whether that's non-NULL.  The bus on which the Downstream Port
resides is pdev->bus.  On all Host Routers I know, the XHCI is
below slot 02.0 on that bus, so you could use pci_get_slot()
to find that Downstream Port, then use pci_get_slot() again
to find slot 00.0 on that bridge's subordinate bus.  If that
device has class PCI_CLASS_SERIAL_USB_XHCI, you've found the
XHCI and can rectify its properties.  Device references acquired
with pci_get_*() need to be returned with pci_dev_put().

The quirk should be #ifdef'ed to CONFIG_ACPI.  Alternatively,
it could be declared in pci-acpi.c near pci_acpi_set_external_facing().


> > However that doesn't appear to be sufficient:  I notice that in your
> > patch, you're also clearing the external_facing bit on the Root Port
> > above the discrete host controller.
> 
> Rajat (rajatja@google.com) in an internal review had suggested I add
> that, and leave it up to kernel maintainers to decide if it's strictly
> necessary.

I'd recommend to leave the Root Port's properties untouched
unless that's necessary.


> I don???t have this device available at my office. I just saw that
> StarTech sells a universal laptop docking station with chipset-id
> Intel - Alpine Ridge DSL6540. Then I looked up the device, and found
> it here: https://linux-hardware.org/?id=pci:8086-1577-8086-0000
> 
> Therefore, I concluded that the DSL6540 has an NHI component.
> 
> If these logs are important, I could probably make a case to purchase
> that docking station and get the info that you need. Please let me
> know!

Never mind, this scenario is being tested internally at Intel
and the above-linked branch contains a commit to avoid binding
to a Host Interface exposed by a Device Router.

Thanks,

Lukas

