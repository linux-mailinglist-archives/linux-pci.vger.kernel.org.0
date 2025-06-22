Return-Path: <linux-pci+bounces-30313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D0AE2E5F
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 06:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CC718914DE
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827B13AA2A;
	Sun, 22 Jun 2025 04:43:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B32260C;
	Sun, 22 Jun 2025 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750567424; cv=none; b=urFIvyXeESZ1IxAlvqn8XFZr4vqxN4TFU/FUBx7fWk7jftiZjxITB4F+E/27Rq0/XXeUgxoI3KY1iFp0+BgKVPiWO9sdKmASZuzd2LRc/pHo2gM1ACMDePFcRUBwGhQmLfcjGrufwSBzNNcDVjwYUL6wL/5xXHSJTr1ZowX/OSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750567424; c=relaxed/simple;
	bh=KLLyLEQjm23ZIz/fQWFb/8mCekceppLu6KDxT/WM8vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrDtxCLlQQkRWARucd7+N17AWCiyoBDIwIWzdZYeGCEJqYB+bm1A2FjvtBYo/XVzo1Zxs6cfGGN411vWPCHV440ZU1PKa7/ZuAkYwJoKBx+sUzcXKbYxiHGZzfGASZhHZrMBJjGxXBGUqSCZHbI2+KNmIRyktFjP9pQjRjgQMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D0C0F2C051D9;
	Sun, 22 Jun 2025 06:43:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B72ED34F192; Sun, 22 Jun 2025 06:43:31 +0200 (CEST)
Date: Sun, 22 Jun 2025 06:43:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFeJ83O9PRUrM2Ir@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>

On Sat, Jun 21, 2025 at 02:56:08PM -0500, Mario Limonciello wrote:
> On 6/21/25 2:05 PM, Lukas Wunner wrote:
> > In the dmesg output attached to...
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=220216
> > 
> > ... the device exhibiting the refcount underflow is a PCIe port.
> > Are you also seeing this on a PCIe port or is it a different device?
> 
> The device with the underflow is the disconnected PCIe bridge.
> 
> In my case it was this bridge that was downstream.

Okay, in both cases the refcount underflow occurs on a PCIe port.
So it seems likely the gratuitous refcount decrement is in portdrv.c
or one of the port services drivers.

Your patch changes the code path for *all* PCI devices.
Not just PCIe ports.  Hence it's likely not the right fix.

It may fix the issue on this particular PCIe port but
I strongly suspect it'll leak a runtime PM ref on all other devices.


> > So the refcount decrement happens in pcie_portdrv_probe() and
> > the refcount increment happens in pcie_portdrv_remove().
> > Both times it's conditional on pci_bridge_d3_possible().
> > Does that return a different value on probe versus remove?

Could you please answer this?


> > Does any of the port service drivers decrement the refcount
> > once too often?  I've just looked through pciehp but cannot
> > find anything out of the ordinary.
> > 
> > Looking through recent changes, 002bf2fbc00e and bca84a7b93fd
> > look like potential candidates causing a regression, but the
> > former is for AER (which isn't used in the dmesg attached to
> > the bugzilla) and the latter touches suspend on system sleep,
> > not runtime suspend.
> > 
> > Can you maybe instrument the pm_runtime_{get,put}*() functions
> > with a printk() and/or dump_stack() to see where a gratuitous
> > refcount decrement occurs?
> 
> That's exactly what I did to conclude this call was an extra one.
> 
> Here's the drop to 0:

The drop to 0 is uninteresting.  You need to record *all*
refcount increments/decrements so that we can see where the
gratuitous one occurs.  It happens earlier than the drop to 0.

However, please first check whether the pci_bridge_d3_possible()
return value changes on probe versus remove of the PCIe port
in question.  If it does, then that's the root cause and there's
no need to look any further.

Thanks,

Lukas

