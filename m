Return-Path: <linux-pci+bounces-15222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA629AEE83
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E7B1F2346C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256E200120;
	Thu, 24 Oct 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRwu/kVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011E1FC7F2;
	Thu, 24 Oct 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792010; cv=none; b=Z6jqXldqq6UhS0IBMiKR/ZOFj+mhK0Z2U9VGJUG9pK+jnKE0oBBexuGYrCUNb0vLN42iJQfAfFFva/r/nsUGva3+IE293CxOiPnX5e00VE/s8oRemLP47U9ru6ALN2ftDXh74b8hihpAK9HBxyW6vk5bI9mXyIsKgjCZkfV5uJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792010; c=relaxed/simple;
	bh=UugEXA+hKGT0SIXPq6iPiE2aXDLoum/5sIjmSbSh8Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BLfuCyVRpjh5o5bjMJn0iOw/CEECZJh8Mx839czmj4Ta8XYaJ2CTnP2+RSv0Onc8SbXQuQyFgRjVYEOFLyWPuRdCj4PoukqVvCiyR7/JNF7qptbzvnHb0RmHed0SNmKrMB66sXH7I/BHZMl2KQdomFDGIbjWhPcWrbYkMuRCfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRwu/kVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA04C4CEE5;
	Thu, 24 Oct 2024 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792010;
	bh=UugEXA+hKGT0SIXPq6iPiE2aXDLoum/5sIjmSbSh8Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RRwu/kVjJckgvZRc7yr26KXyzMTozeyIzV6DX/j6pLBrq0F643UBta2Ce4eWftBvk
	 vFoJAKuDIztTXUjIrBIQt0tZWWzwIcAfY++nBjhtYW+x0YrxgwjRF5JHFR0+dEc1Wd
	 XFGwzScxPa9ruErNkfycwj+FSaXaQgtQA9ORojAT6XTf1dZKmze1y1l8Q6dD6QTKS+
	 F6nHlH6zPb1kjfrUt8T5tup1uuZhDO1QAFHjRELs4Rw9JdXdpfrjpcSq4njkhDRxcS
	 uGxaWjjxOda7VIi/PQnIGf7QQr09UmtcsE1kmQLl9U6sCgvfjrEn5BRSDTaNxbc31P
	 hENPIaqZZC+Uw==
Date: Thu, 24 Oct 2024 12:46:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241024174647.GA964607@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024160159.GB965@yaz-khff2.amd.com>

On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
> On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> > > Hi all,
> > > 
> > > The theme of this set is decoupling the "AMD node" concept from the
> > > legacy northbridge support.
> > > 
> > > Additionally, AMD System Management Network (SMN) access code is
> > > decoupled and expanded too.
> > > 
> > > Patches 1-3 begin reducing the scope of AMD_NB.
> > > 
> > > Patches 4-9 begin moving generic AMD node support out of AMD_NB.
> > > 
> > > Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
> > > 
> > > Patch 14 has HSMP reuse SMN functionality.
> > > 
> > > Patches 15-16 address userspace access to SMN.
> > > 
> > > I say "begin" above because there is more to do here. Ultimately, AMD_NB
> > > should only be needed for code used on legacy systems with northbridges.
> > > Also, any and all SMN users in the kernel need to be updated to use the
> > > central SMN code. Local solutions should be avoided.
> > 
> > Glad to see many of the PCI device IDs going away; thanks for working
> > on that!
> > 
> > The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
> > ideal since all those pci_get_*() interfaces are kind of ugly in my
> > opinion, and using them means we have to encode topology details in
> > the kernel.  But this still seems like a big improvement.
> 
> Thanks for the feedback. Hopefully, we'll come to some improved
> solution. :)
> 
> Can you please elaborate on your concern? Is it about saying "thing X is
> always at SBDF A:B:C.D" or something else?

"Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
nothing about the actual functionality of the device.  A PCI
Vendor/Device ID or a PNP ID identifies the device programming model
independent of its geographical location.  Inferring the functionality
and programming model from the location is a maintenance issue because
hardware may change the address.

PCI bus numbers are under software control, so in general it's not
safe to rely on them, although in this case these devices are probably
on root buses where the bus number is either fixed or determined by
BIOS configuration of the host bridge.

I don't like the pci_get_*() functions because they break the driver
model.  The usual .probe() model binds a device to a driver, which
essentially means the driver owns the device and its resources, and
the driver and doesn't have to worry about other code interfering.

Unlike pci_get_*(), the .probe()/.remove() model automatically handles
hotplug without extra things like notifiers in the driver.  Hotplug
may not be an issue in this particular case, but it requires specific
platform knowledge to be sure.  Some platforms do support CPU and PCI
host bridge hotplug.

Thanks again for doing all this work.  It's a huge improvement
already!

Bjorn

