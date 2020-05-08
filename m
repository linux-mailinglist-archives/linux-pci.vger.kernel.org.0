Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1D1CB85C
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEHTeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 15:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 15:34:44 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA742184D;
        Fri,  8 May 2020 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588966483;
        bh=1hUwFfzEcUZwoxVfZXocLGcacNeAw7nbeQ0hdIZswyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xeizsLOvp0BJhjU5dW7s4MSkDsuKCLkwKFVKKdm1CDubYDkqp1o+av6is+N3NkxZq
         hs2WgEUNUlS+6j0dkuX5ptpl0bgHfkpGjX7gIu8SThaYirm3kwqmhW4EewP26LvvV+
         s0YqBtvlLXxpr/uFaHfLYBLrJbLXR7F++Dd1lSmo=
Date:   Fri, 8 May 2020 14:34:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200508193441.GA79854@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C23FC3E-6BBF-47EB-8EE6-89EAC5A28104@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 09, 2020 at 01:28:24AM +0800, Jiaxun Yang wrote:
> 于 2020年5月9日 GMT+08:00 上午1:17:30, Bjorn Helgaas <helgaas@kernel.org> 写到:
> >On Fri, May 08, 2020 at 07:34:02PM +0800, Jiaxun Yang wrote:
> >> This controller can be found on Loongson-2K SoC, Loongson-3
> >> systems with RS780E/LS7A PCH.
> >> 
> >> The RS780E part of code was previously located at
> >> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> >> driver implementation.
> >> 
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >
> >> +static void system_bus_quirk(struct pci_dev *pdev)
> >> +{
> >> +	u16 tmp;
> >> +
> >> +	/* 
> >> +	 * System buses on Loongson system contain garbage in BARs
> >> +	 * but their decoding need to be enabled to ensure devices
> >> +	 * under system buses are reachable. In most cases it should
> >> +	 * be done by the firmware.
> >
> >This isn't a very satisfying explanation because devices that have
> >decoding enabled can interfere with other devices in the system, and I
> >can't tell whether that's a problem here.
> >
> >What happens when you turn on MEM/IO decoding below?  Does the device
> >decode any address space?  How do we know what it is?  Is it related
> >to the BAR contents?
> >
> >I'm a little dubious about the need for the PCI_COMMAND write because
> >the previous version didn't do it (since it incorrectly wrote to
> >PCI_STATUS), and I assume that version worked.
> 
> Sorry, but that's all I can tell from the chips manual as I'm not a
> employee of the vendor.
> 
> My assumption is these BAR contains the address of those system
> components that already configured by firmware and we shouldn't
> touch it.

What are the values in the BARs?  Do they look like addresses?  Would
they make sense in the iomem_resource, i.e., in /proc/iomem?

If the BARs contain addresses of devices, the kernel needs to avoid
that address space when allocating space for other devices.  But
without probing the BARs, the kernel has no idea what the *size* of
the regions is.  Does the manual say anything about that?

Can you tell if there's anything at all Linux could do with these
devices?  If they don't have BARs and they don't document any
device-specific registers in config space, there's not much value in
treating them like PCI devices at all.

I wonder if we should just make a way to completely ignore them, e.g.,
a way for pci_setup_device() to return an error.   I guess we *could*
do that already by making your early fixup set dev->hdr_type to 0xff
or something.

> In fact according to my tests if we let Kernel probe these BAR then
> the system will hang immediately.
> 
> Chip manual suggested OS to ensure decoding is enabled so I'm doing
> like this. But without this system can also work.
> 
> Do you think I should drop it until figure out what was it actually
> doing?

