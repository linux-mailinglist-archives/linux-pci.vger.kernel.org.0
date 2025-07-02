Return-Path: <linux-pci+bounces-31267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80DAF596A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092841891200
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6142857D7;
	Wed,  2 Jul 2025 13:29:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A82857CA
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462999; cv=none; b=jvVC8KAi0bNqYdA4cR74cgfQwqiyUf0QjGvSHNU6oU6+c2rDWCb5N6ZMDvgAhKUCLwDRZzTVtk4u2oBZpa7ETPufgDtHmyDmhZMV4vUCAmi+jIsYyhrNe9LGlEaNyDPAayWfAsW+nk2lvP3UcqZREpqb8X3lO5NjI8XB0X0UI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462999; c=relaxed/simple;
	bh=CWd2WKm0oM/5FeHrFr3gmO0oEPsXtMk0+Zip/vYuZ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIrG8ufFN9bYRiyoEI1btDDtffito9k9FyNAITYhWuBdH+pn0qpfhdqQd4vfZitNjLgoI5w7jSJdYE0eGLlRlHEatAzyUKv3DaEgvYGrX4hdoLymfK2W0Nlvg0kfTvWNRySg9xXWkkvj83LuPuYdm4DHbbICq4vNJwwgh8ndbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1C0102C06E2D;
	Wed,  2 Jul 2025 15:29:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 05510402D89; Wed,  2 Jul 2025 15:29:49 +0200 (CEST)
Date: Wed, 2 Jul 2025 15:29:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, David Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aGU0TL7t9IRbqqpa@wunner.de>
References: <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
 <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
 <aFwIu0QveVuJZNoU@wunner.de>
 <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
 <e0bcd0a8-dbb5-4272-a549-1029f4dd0e41@redhat.com>
 <aGUOVbmH1bObAF1r@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGUOVbmH1bObAF1r@wunner.de>

[cc += tglx, start of thread:
https://lore.kernel.org/r/f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de/
]

On Wed, Jul 02, 2025 at 12:47:49PM +0200, Lukas Wunner wrote:
> On Mon, Jun 30, 2025 at 01:10:24PM +0200, Hans de Goede wrote:
> > ping? It would be good to get some consensus on how to
> > fix this and move forward with a fix. Either the patch from
> > this thread; or my patch:
> > 
> > https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
> > 
> > Works for me, the most important thing here is to get this
> > regression fixed.
> 
> You seem to have a machine where you can trigger the
> "Resources present before probing" message.
> 
> Would you mind enabling CONFIG_DEBUG_DEVRES=y and adding
> "log_devres=1" to the kernel command line so that we
> can understand what kind of resource is attached to
> the AMD IOMMU, and where that happens.
> 
> I don't see invocations of devm_*() in arch/x86/ or
> drivers/iommu/amd/ that would explain the error message.

I just remembered that an MSI is set up for the AMD IOMMU.
And sure enough:

amd_iommu_enable_interrupts()
  iommu_init_irq()
    iommu_setup_msi()
      pci_enable_msi()
        __pci_enable_msi_range()
	  pci_setup_msi_device_domain()
            pci_create_device_domain()
              msi_create_device_irq_domain()
                msi_setup_device_data()
                  msi_sysfs_create_group()
		    devm_device_add_group()

... introduced by bf5e758f02fc ("genirq/msi: Simplify sysfs handling").

Not sure if this is the only one or if there are other resources
added anywhere else for the driver-less AMD IOMMU.

We'd have to rework MSI handling to not use devm_*(), so that MSIs
can be requested for a device without it being bound to a driver.
But I suspect tglx may have deliberately designed it to not
support that, in which case what the AMD IOMMU driver does
is somewhat dodgy...

Thanks,

Lukas

