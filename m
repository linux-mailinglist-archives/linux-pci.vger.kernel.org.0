Return-Path: <linux-pci+bounces-38305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293BBE1F72
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514A419A8686
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D3301712;
	Thu, 16 Oct 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSFn2lnF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2462FDC51;
	Thu, 16 Oct 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600565; cv=none; b=Lc/Txr7hJ/RHlOGSICFr5TF5HeDsheUU/f5l1eGuV91yCjqQKPY9bu/oBlzSJqFoLBsFdtECvgjdLqheBGz8WrWxBPPvhi1XqPOE0aMdpyHxhfpSRpo88aY0dM1aN0tMwhIMf1NbA/RrFtDixfNY4DI4aU8apv3kO1juQ/Eokvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600565; c=relaxed/simple;
	bh=/BhJAu/ou9XnXIn3SfQ7l0bSbgnmCrIk7nRE8O1cXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmS3YqLbxAr3d3VC1yil9LDuB9LpMvn63/H85kdXlN6naW7JxRSoCybdcPoMh4gJdZ1GqJkn0IkxRZSnnJbMVjxNXD/BbU8W+f61cckYUufakg7j4LF8P9ZUtmtMDYDPvGcjhbZiOeZF1p1XH/00v2vI5WeBbNsUSBuFQSO01+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSFn2lnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E8C113D0;
	Thu, 16 Oct 2025 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760600565;
	bh=/BhJAu/ou9XnXIn3SfQ7l0bSbgnmCrIk7nRE8O1cXwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSFn2lnFMcE0F/Lsv5EGTxXzOWAHMf7Ud9Z/4qmOErqPTKjyu6sSAPkVDYxveaMWb
	 5yfwgXsQfcLv+taPjNDyd5C/iX09tpyjJjpsBT3TNBnzInhg5H/w1Qto0/IZxANLeO
	 PZa982EntazUU3+jy+S3DLzexgV+p5y46qzQEOit6gYCh+eT38HkzP1d5o16f3MyM3
	 YLMfofxgKKHo/NmlktHEEzjAkVWWoNuFyRXGKgWPqki9CXh8Aj8+ShZ8gZpn8NWhEr
	 feXqSm0KcAVanMHrmpsXpaUqFRiI2JkO+ziho+0xx6iu2H6FXBUiWuACYceSFymwmd
	 1PxXYwKXld25Q==
Date: Thu, 16 Oct 2025 13:12:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Val Packett <val@packett.cool>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <w7typaxh6kw5diqgqmc2tzwk3mjxeee66vjae64tdwv52i3sai@vvoqoh5og72l>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
 <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
 <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
 <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>

On Tue, Oct 07, 2025 at 06:43:03PM +0300, Ilpo Järvinen wrote:
> On Mon, 6 Oct 2025, Val Packett wrote:
> > On 10/6/25 7:46 AM, Ilpo Järvinen wrote:
> > > On Mon, 6 Oct 2025, Val Packett wrote:
> > > > On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
> > > > > Bridge windows are read twice from PCI Config Space, the first read is
> > > > > made from pci_read_bridge_windows() which does not setup the device's
> > > > > resources. It causes problems down the road as child resources of the
> > > > > bridge cannot check whether they reside within the bridge window or
> > > > > not.
> > > > > 
> > > > > Setup the bridge windows already in pci_read_bridge_windows().
> > > > > 
> > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > Looks like this change has broken the WiFi (but not NVMe) on my Snapdragon
> > > > X1E
> > > > laptop (Latitude 7455):
> > > Thanks for the report.
> > > 
> > > > qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> > > > pci_bus 0004:00: root bus resource [bus 00-ff]
> > > > pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address
> > > > [0x0000-0xfffff])
> > > So this looks the first change visible in the fragment you've taken from
> > > the dmesg...
> > > 
> > > > pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> > > > pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> > > > pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > > pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > > ...What I don't understand in these logs is how can the code changed in
> > > pci_read_bridge_windows() affect the lines before this line as it is being
> > > printed from pci_read_bridge_windows(). Maybe there are more 'PCI bridge
> > > to' lines above the quoted part of the dmesg?
> > 
> > Sorry for the confusion, the 0x100000 shift was caused by unrelated changes
> > (Qcom/DWC ECAM support) and I wasn't diligent enough with which exact log I
> > picked as the working one.
> 
> Okay, I certainly couldn't figure out how that could have happened, no 
> wonder then. :-)
> 
> > Here's the actual difference. Good:
> > 
> > ❯ dmesg | rg 0004: | rg brid
> > [    1.780172] qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> > [    1.781930] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > [    1.781972] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
> > [    1.781998] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > [    1.782043] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff
> > 64bit pref]
> > [    1.800769] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > [    1.976893] pcieport 0004:00:00.0: bridge window [mem
> > 0x7c400000-0x7c5fffff]: assigned
> >
> > Bad:
> > 
> > ❯ dmesg | rg 0004: | rg brid
> > [    1.380369] qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> > [    1.442881] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > [    1.449496] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
> > [    1.462988] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > [    1.476661] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff
> > 64bit pref]
> > [    1.502299] pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]:
> > assigned
> > [    1.509028] pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff
> > 64bit pref]: assigned
> > [    1.509057] pci 0004:00:00.0: bridge window [io 0x100000-0x100fff]:
> > assigned
> > [    1.509085] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > [    1.509099] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
> > [    1.509124] pci 0004:00:00.0:   bridge window [mem 0x7c300000-0x7c3fffff]
> > [    1.509133] pci 0004:00:00.0:   bridge window [mem 0x7c400000-0x7c4fffff
> > 64bit pref]
> 
> Interpreting these logs is usually hard even when given the whole log, it 
> becomes even harder when they're filtered so that many lines of interest 
> are not shown (I tried to correlate the working case to the previous 
> "wrong" "correct" log but I've no guarantee the rest would remain same).
> 
> > I've also added log lines to pci_read_bridge_bases where the other calls to
> > the same pci_read_bridge_* functions are called, and turns out they did *not*
> > happen.
> > 
> > So it seems to me that the good reason you were wondering about for why the
> > resources were not set up in pci_read_bridge_windows, is that they must not be
> > set up unconditionally!
> >
> > I think it's that early check in pci_read_bridge_bases that avoids the setup
> > here:
> > 
> >     if (pci_is_root_bus(child)) /* It's a host bus, nothing to read */
> >         return;
> 
> If there's a PCI device as is the case in pci_read_bridge_windows() 
> which inputs non-NULL pci_dev, the config space of that device can be read 
> normally (or should be readable normally, AFAIK). The case where bus->self 
> is NULL is different, we can't read from a non-existing PCI device, but 
> it doesn't apply to pci_read_bridge_windows().
> 
> I don't think reading the window is the real issue here but how the 
> resource fitting algorithm corners itself by reserving space for bridge 
> windows before it knows their sizes, so basically these lines from the 
> earlier email:
> 
> pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
> pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]: assigned
> pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
> 
> ...which seem to occur before the child buses have been scanned so that 
> space reserved is either hotplug reservation or due to "old_size" lower 
> bounding. That non-prefetchable bridge window is too small to fit the 
> child resources.
> 

Yeah, this is specifically the reason why the issue only affects the WiFi card
and not NVMe on this platform. The NVMe is powered on by the bootloader/BIOS
and it doesn't use the pwrctrl framework to handle the power management. But on
the other hand, the WiFi is not powered on by the bootloader and powered on by
the pwrctrl framework (which happens after the bridge windows are allocated).
Since the Root Port is not hotplug capable, the initial bridge window assigned
is not enough for the WiFi card that comes up later and hence the failure.

This also rings a bell that I should change the way the pwrctrl framework power
on the devices. I think the devices/slot should be powered on before scanning
the secondary bus of the Root Port so that the resource fitting algorithm knows
how much bridge window memory should be allocated.

I did notice the similar issue while trying to use the pwrctrl framework to
power on an endpoint connected to a PCIe switch. But your patch made it obvious
that the issue gets triggered even for the endpoints connected to the Root
Port. I didn't digged into this issue yet, but this is the theory I came up
with.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

