Return-Path: <linux-pci+bounces-20786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B864A2A0DB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 07:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF439188492D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090F22370F;
	Thu,  6 Feb 2025 06:22:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081F2561D;
	Thu,  6 Feb 2025 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822920; cv=none; b=UilJFr8eaPpWmO1uKssiQ9VGTDCClAm2UNd0O1QX/N8xPwVGlmuxlJOrTpM8xBbNzLJA/01dJ2e9opy8JCvPFI7c+pyTg/og6PGCE+rO7zcOGbOGJpisBBK8P61YU49a4A4Unur3XydOUVlg+f3L2nKaOYBdnvPW6K9MQ/MHwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822920; c=relaxed/simple;
	bh=Mek6kuOM8DwB7YmKr4tEPA/pcm7AycVDP6/Jk1peRK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERRmA8PopQCrXA86v/ZBfdxbCvfAbSoDpWt/9GsQShWGFfbG3s5vK2j+2p5HxVAeb62/njFLoTNYwg5RqcOoyjxCvFNx3S8vfk/CBNAEI/1R4YctnkXGNSUAQQ9C7maK33s0z/nU9ZocFWD7WTA/T30LZFvOstTQEJsKm73mFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id DE6ED3000D5D0;
	Thu,  6 Feb 2025 07:21:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C0FBE538C2F; Thu,  6 Feb 2025 07:21:47 +0100 (CET)
Date: Thu, 6 Feb 2025 07:21:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6RU-681eXl7hcp6@wunner.de>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
 <Z6HcoUB3i51bzQDs@wunner.de>
 <Z6LhzGaYBW5S41MJ@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6LhzGaYBW5S41MJ@U-2FWC9VHC-2323.local>

[to += Rafael, start of thread is here:
https://lore.kernel.org/all/Z6HcoUB3i51bzQDs@wunner.de/
]

Hi Rafael,

On Wed, Feb 05, 2025 at 11:58:04AM +0800, Feng Tang wrote:
> On Tue, Feb 04, 2025 at 10:23:45AM +0100, Lukas Wunner wrote:
> > On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> > > There was a irq storm bug when testing "pci=nomsi" case, and the root
> > > cause is: 'nomsi' will disable MSI and let devices and root ports use
> > > legacy INTX inerrupt, and likely make several devices/ports share one
> > > interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> > > interrupts, and  actually asserts the command-complete interrupt.
> > > As MSI is disabled, ACPI initialization code will not enumerate root
> > > port's PCIE hotplug capability, and pciehp service driver wont' be
> > > enabled for the root port to handle that interrupt, later on when it is
> > > shared and enabled by other device driver like NVME or NIC, the "nobody
> > > care irq storm" happens.
> >
> > Is there a section in the PCI Firmware Spec which says ACPI doesn't
> > enumerate the hotplug capability if MSI is disabled?
> 
> No, I didn't get it from spec, but found the logic by code reading
> during debugging the irq storm issue. The related code is about:
> 
> #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> 				| OSC_PCI_ASPM_SUPPORT \
> 				| OSC_PCI_CLOCK_PM_SUPPORT \
> 				| OSC_PCI_MSI_SUPPORT)

Commit 415e12b23792 ("PCI/ACPI: Request _OSC control once for each root
bridge (v3)") contains a change which doesn't seem to be explained in
the commit message:

If the user passes "pci=nomsi" on the command line, Linux doesn't
request hotplug control (or any other control) from the platform.
So ACPI always remains responsible for hotplug in the "pci=nomsi"
case.

The commit sought to fix a cpu hog issue:

https://bugzilla.kernel.org/show_bug.cgi?id=29722

It's unclear to me if that bug was fixed by requesting _OSC only once,
as the commit message suggests, or if the addition of OSC_MSI_SUPPORT
to ACPI_PCIE_REQ_SUPPORT fixed the issue.

Since the latter is not mentioned in the commit message,
it seems plausible to assume that the OSC_MSI_SUPPORT change
was unintentional.

In any case it doesn't seem to make sense to not request any
control in the "pci=nomsi" case.

It's also worth noting that the behavior is different on
Apple machines as they use a fixed _OSC set even for "pci=nomsi".

I'm wondering if OSC_PCI_MSI_SUPPORT should simply be removed
from ACPI_PCIE_REQ_SUPPORT, but I'm worried that it may cause
reappearance of the cpu hog issue.

Thoughts?

Thanks,

Lukas

