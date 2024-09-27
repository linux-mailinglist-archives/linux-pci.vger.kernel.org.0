Return-Path: <linux-pci+bounces-13593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450F988158
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4559D281F4B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86591BAED4;
	Fri, 27 Sep 2024 09:29:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD51BAED0;
	Fri, 27 Sep 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429346; cv=none; b=s00Ji5KmzEwCvelHlMXYfLb3RTElWJrDn1V7cT1UKFzTMvtwx1PeKusDbKZUHgKTRpvmMfa8LH9Wg3YFwcepyrbcQF8vIgRPhTZ6Kwsmr5BJQ+bt0hrXhGigXxGehv/YEQMyRKVzfZVoWlSJ/cWQVjxKPYRw/ArYIpnuYKcg6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429346; c=relaxed/simple;
	bh=JF+sDDOK5PxGb3aYQzqGRu08TbXb26q+zXfIZ0oadcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scnd+UZah9zrAT6j8tsPyi1YbKL7K1vYnm9fV2B3Mt+5og48u5mG11nfa7wrB0Bn7QIJqL3a7h0gEZ/r4z2SCL6TUeg+r0EGDsoJEGuZoyb+kLea8dfe9DwaGwjhf3obNBQMZWmxuyZ3Aj6qZQta552yLE3MwPBWxUynenDhXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BE7232800F0B1;
	Fri, 27 Sep 2024 11:28:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A2869268E83; Fri, 27 Sep 2024 11:28:54 +0200 (CEST)
Date: Fri, 27 Sep 2024 11:28:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <ZvZ61srt3QAca2AI@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>

On Fri, Sep 27, 2024 at 03:33:50PM +0800, AceLan Kao wrote:
> Lukas Wunner <lukas@wunner.de> 2024-9-26 9:23
> > On Thu, Sep 26, 2024 at 08:59:09PM +0800, Chia-Lin Kao (AceLan) wrote:
> > > Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). This
> > > fixes a system hang that occurs when resuming after a Thunderbolt dock
> > > with attached thunderbolt storage is unplugged during system suspend.
> > >
> > > The PCI core already handles setting the disconnected state for devices
> > > under a port during suspend/resume.
> > > 
> > > The redundant bus walk was
> > > interfering with proper hardware state detection during resume, causing
> > > a system hang when hot-unplugging daisy-chained Thunderbolt devices.
> 
> I have no good answer for you now.
> After enabling some debugging options and debugging lock options, I
> still didn't get any message.

Have you tried "no_console_suspend" on the kernel command line?


> ubuntu@localhost:~$ lspci -tv
> -[0000:00]-+-00.0  Intel Corporation Device 6400
>           +-02.0  Intel Corporation Lunar Lake [Intel Graphics]
>           +-04.0  Intel Corporation Device 641d
>           +-05.0  Intel Corporation Device 645d
>           +-07.0-[01-38]--
>           +-07.2-[39-70]----00.0-[3a-70]--+-00.0-[3b]--
>           |                               +-01.0-[3c-4d]--
>           |                               +-02.0-[4e-5f]----00.0-[4f-50]----01.0-[50]----00.0  Phison Electronics Corporation E12 NVMe Controller
>           |                               +-03.0-[60-6f]--
>           |                               \-04.0-[70]--
> 
> This is Dell WD22TB dock
> 39:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge 2020] [8086:0b26] (rev 03)
>        Subsystem: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge 2020] [8086:0000]
> 
> This is the TBT storage connects to the dock
> 50:00.0 Non-Volatile memory controller [0108]: Phison Electronics
> Corporation E12 NVMe Controller [1987:5012] (rev 01)
>        Subsystem: Phison Electronics Corporation E12 NVMe Controller [1987:5012]
>        Kernel driver in use: nvme
>        Kernel modules: nvme

The lspci output shows another PCIe switch in-between the WD22TB dock and
the NVMe drive (bus 4e and 4f).  Is that another Thunderbolt device?
Or is the NVMe drive built into the WD22TB dock and the switch at bus
4e and 4f is a non-Thunderbolt PCIe switch in the dock?

I realize now that commit 9d573d19547b ("PCI: pciehp: Detect device
replacement during system sleep") is a little overzealous because it
not only reacts to *replaced* devices but also to *unplugged* devices:
If the device was unplugged, reading the vendor and device ID returns
0xffff, which is different from the cached value, so the device is
assumed to have been replaced even though it's actually been unplugged.

The device replacement check runs in the ->resume_noirq phase.  Later on
in the ->resume phase, pciehp_resume() calls pciehp_check_presence() to
check for unplugged devices.  Commit 9d573d19547b inadvertantly reacts
before pciehp_check_presence() gets a chance to react.  So that's something
that we should probably change.

I'm not sure though why that would call a hang.  But there is a known issue
that a deadlock may occur when hot-removing nested PCIe switches (which is
what you've got here).  Keith Busch recently re-discovered the issue.
You may want to try if the hang goes away if you apply this patch:

https://lore.kernel.org/all/20240612181625.3604512-2-kbusch@meta.com/

If it does go away then at least we know what the root cause is.

The patch is a bit hackish, but there's an ongoing effort to tackle the
problem more thoroughly:

https://lore.kernel.org/all/20240722151936.1452299-1-kbusch@meta.com/
https://lore.kernel.org/all/20240827192826.710031-1-kbusch@meta.com/

Thanks,

Lukas

