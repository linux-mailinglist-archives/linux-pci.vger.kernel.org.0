Return-Path: <linux-pci+bounces-22523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4AA4753A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C9188BA78
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16091EB5F8;
	Thu, 27 Feb 2025 05:31:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221511E5210;
	Thu, 27 Feb 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634274; cv=none; b=H5Z5kK7dQGAI9sgNuXwFoeK2z2boVYUulf6CMVLFeE+1u5ybMYx3RLpNpvsl7fVvgwNoUxF9IABl9KCKwqL3G2fY3jGSxW5Fv9e0BmHUMOu6z5rtWe4Pjj3zPsKHe3dBViXTiGjRXXGzEYol4/ry2H6uThihM4jVfu5+7rMYLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634274; c=relaxed/simple;
	bh=Ubkpo2yfm2TxLNOmS+RA8sofbSaJ0lFhErUT9aL6IP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbA6bf7+MaIOraQZ3RJyaAKe0LUNMW0Oxc2p5G00+rUyLrAWG40LMtFEOe/FzxrXgFSwHc+KRS3ifiA1vOz8WeZfxLeuTjG5muI8z5hyQ9z/qsdb2C3Q2c3UgvLqBE1FCsAf5KSH8LrB6Y9EbC/PLCaso5yMKwiIQRUl/fIle6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C767B2800B484;
	Thu, 27 Feb 2025 06:31:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C0E0B1AAC71; Thu, 27 Feb 2025 06:31:08 +0100 (CET)
Date: Thu, 27 Feb 2025 06:31:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during reset
Message-ID: <Z7_4nMod6jWd-Bi1@wunner.de>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
 <Z7RL7ZXZ_vDUbncw@wunner.de>
 <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com>

On Mon, Feb 24, 2025 at 05:13:15PM +0200, Ilpo Järvinen wrote:
> On Tue, 18 Feb 2025, Lukas Wunner wrote:
> > On Mon, Feb 17, 2025 at 06:52:58PM +0200, Ilpo Järvinen wrote:
> > > PCIe BW controller enables BW notifications for Downstream Ports by
> > > setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
> > > Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
> > > 7.5.3.7).
> > > 
> > > It was discovered that performing a reset can lead to the device
> > > underneath the Downstream Port becoming unavailable if BW notifications
> > > are left enabled throughout the reset sequence (at least LBMIE was
> > > found to cause an issue).
> > 
> > What kind of reset?  FLR?  SBR?  This needs to be specified in the
> > commit message so that the reader isn't forced to sift through a
> > bugzilla with dozens of comments and attachments.
> 
> Heh, I never really tried to figure out it because the reset disable 
> patch was just a stab into the dark style patch. To my surprise, it ended 
> up working (after the initial confusion was resolved) and I just started 
> to prepare this patch from that knowledge.

If the present patch is of the type "changing this somehow makes the
problem go away" instead of a complete root-cause analysis, it would
have been appropriate to mark it as an RFC.

I've started to dig into the bugzilla and the very first attachment
(dmesg for the non-working case) shows:

  vfio-pci 0000:01:00.0: timed out waiting for pending transaction; performing function level reset anyway

That message is emitted by pcie_flr().  Perhaps the Nvidia GPU takes
more time than usual to finish pending transactions, so the first
thing I would have tried would be to raise the timeout significantly
and see if that helps.  Yet I'm not seeing any patch or comment in
the bugzilla where this was attempted.  Please provide a patch for
the reporter to verify this hypothesis.


> Logs do mention this:
> 
> [   21.560206] pcieport 0000:00:01.1: unlocked secondary bus reset via: pciehp_reset_slot+0x98/0x140
> 
> ...so it seems to be SBR.

Looking at the vfio code, vfio_pci_core_enable() (which is called on
binding the vfio driver to the GPU) invokes pci_try_reset_function().
This will execute the reset method configured via sysfs.  The same
is done on unbind via vfio_pci_core_disable().

So you should have asked the reporter for the contents of:
/sys/bus/pci/devices/0000:01:00.0/reset_method
/sys/bus/pci/devices/0000:01:00.1/reset_method

In particular, I would like to know whether the contents differ across
different kernel versions.

There's another way to perform a reset:   Via an ioctl.  This ends up
calling vfio_pci_dev_set_hot_reset(), which invokes pci_reset_bus()
to perform an SBR.

Looking at dmesg output in log_linux_6.13.2-arch1-1_pcie_port_pm_off.log
it seems that vfio first performs a function reset of the GPU on bind...

[   40.171564] vfio-pci 0000:01:00.0: resetting
[   40.276485] vfio-pci 0000:01:00.0: reset done

...and then goes on to perform an SBR both of the GPU and its audio
device...

[   40.381082] vfio-pci 0000:01:00.0: resetting
[   40.381180] vfio-pci 0000:01:00.1: resetting
[   40.381228] pcieport 0000:00:01.1: unlocked secondary bus reset via: pciehp_reset_slot+0x98/0x140
[   40.620442] vfio-pci 0000:01:00.0: reset done
[   40.620479] vfio-pci 0000:01:00.1: reset done

...which is odd because the audio device apparently wasn't bound to
vfio-pci, otherwise there would have been a function reset.  So why
does vfio think it can safely reset it?

Oddly, there is a third function reset of only the GPU:

[   40.621894] vfio-pci 0000:01:00.0: resetting
[   40.724430] vfio-pci 0000:01:00.0: reset done

The reporter writes that pcie_port_pm=off avoids the PME messages.
If the reset_method is "pm", I could imagine that the Nvidia GPU
signals a PME event during the D0 -> D3hot -> D0 transition.

I also note that the vfio-pci driver allows runtime PM.  So both the
GPU and its audio device may runtime suspend to D3hot.  This in turn
lets the Root Port runtime suspend to D3hot.  It looks like the
reporter is using a laptop with an integrated AMD GPU and a
discrete Nvidia GPU.  On such products the platform often allows
powering down the discrete GPU and this is usually controlled
through ACPI Power Resources attached to the Root Port.
Those are powered off after the Root Port goes to D3hot.
You should have asked the reporter for an acpidump.

pcie_bwnotif_irq() accesses the Link Status register without
acquiring a runtime PM reference on the PCIe port.  This feels
wrong and may also contribute to the issue reported here.
Acquiring a runtime PM ref may sleep, so I think you need to
change the driver to use a threaded IRQ handler.

Nvidia GPUs are known to hide the audio device if no audio-capable
display is attached (e.g. HDMI).  quirk_nvidia_hda() unhides the
audio device on boot and resume.  It might be necessary to also run
the quirk after resetting the GPU.  Knowing which reset_method
was used is important to decide if that's necessary, and also
whether a display was attached.

Moreover Nvidia GPUs are known to change the link speed on idle
to reduce power consumption.  Perhaps resetting the GPU causes
a change of link speed and thus execution of pcie_bwnotif_irq()?


> > This approach won't work if the reset is performed without software
> > intervention.  E.g. if a DPC event occurs, the device likewise undergoes
> > a reset but there is no prior system software involvement.  Software only
> > becomes involved *after* the reset has occurred.
> > 
> > I think it needs to be tested if that same issue occurs with DPC.
> > It's easy to simulate DPC by setting the Software Trigger bit:
> > 
> > setpci -s 00:01.1 ECAP_DPC+6.w=40:40
> > 
> > If the issue does occur with DPC then this fix isn't sufficient.
> 
> Looking into lspci logs, I don't see DPC capability being there for 
> 00:01.1?!

Hm, so we can't verify whether your approach is safe for DPC.


> > Instead of putting this in the PCI core, amend pcie_portdrv_err_handler
> > with ->reset_prepare and ->reset_done callbacks which call down to all
> > the port service drivers, then amend bwctrl.c to disable/enable
> > interrupts in these callbacks.
> 
> Will it work? I mean if the port itself is not reset (0000:00:01.1 in this 
> case), do these callbacks get called for it?

Never mind, indeed this won't work.

Thanks,

Lukas

