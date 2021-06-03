Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF06A39AC28
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFCVA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 17:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFCVA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 17:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FC4D6121D;
        Thu,  3 Jun 2021 20:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622753922;
        bh=ZgUmVsDe/y2JJgsw/jVz/sgrfKejv8VUjfp3+iSfR4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HKjMpAIrJAUBto2R9uu3vI7wBwsvSe1z73kIePLZq7GjGn21ladp6L9ustGjlDtNV
         33Xrdy04OSBcZMBcVTCL3cs8BHm7ObfyXlJ1uE7byEBNHpSUM5Hb0buLxlzUsOvZHr
         hWEDPxbDMd6Ik3/eprIYIxWY7UfLm7BZrDDjjExcETb5I/R6lmKiqS7KfISY38pV6k
         e0y+SpPBuV96iuMYCJmpnvkKZjjSDploQx9ULlp9wP/0RoGkcfZ5gEVxciKDwqRJuS
         nvkzjdiYXNrK31chC2RgnOV8uaH1HTBAvCfgDhISJOXNCq7DHxB3dJQdVNp1VEJ5OQ
         QxsUpXuAKh7dg==
Date:   Thu, 3 Jun 2021 15:58:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
Message-ID: <20210603205841.GA2139914@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd96bb2-4873-a37c-567d-ffd731beb927@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 10:30:37AM -0700, Florian Fainelli wrote:
> On 6/3/21 10:23 AM, Bjorn Helgaas wrote:
> > On Wed, May 26, 2021 at 10:03:47AM -0700, Florian Fainelli wrote:
> >> On 5/25/21 2:18 PM, Bjorn Helgaas wrote:
> >>> On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
> >>>> The shutdown() call is similar to the remove() call except the former does
> >>>> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
> >>>> if it does.
> >>>
> >>> This doesn't explain why shutdown() is necessary.  "errors occur"
> >>> might be a hint, except that AFAICT, many similar drivers do invoke
> >>> pci_stop_root_bus() and pci_remove_root_bus() (several of them while
> >>> holding pci_lock_rescan_remove()), without implementing .shutdown().
> >>
> >> We have to implement .shutdown() in order to meet a certain power budget
> >> while the chip is being put into S5 (soft off) state and still support
> >> Wake-on-WLAN, for our latest chips this translates into roughly 200mW of
> >> power savings at the wall. We could probably add a word or two in a v2
> >> that indicates this is done for power savings.
> > 
> > "Saving power" is a great reason to do this.  But we still need to
> > connect this to the driver model and the system-level behavior
> > somehow.
> > 
> > The pci_driver comment says @shutdown is to "stop idling DMA
> > operations" and it hooks into reboot_notifier_list in kernel/sys.c.
> > That's incorrect or at least incomplete because reboot_notifier_list
> > isn't mentioned at all in kernel/sys.c, and I don't see the connection
> > between @shutdown and reboot_notifier_list.
> > 
> > AFAICT, @shutdown is currently used in this path:
> > 
> >   kernel_restart_prepare or kernel_shutdown_prepare
> >     device_shutdown
> >       dev->bus->shutdown
> >         pci_device_shutdown                     # pci_bus_type.shutdown
> >           drv->shutdown
> > 
> > so we're going to either reboot or halt/power-off the entire system,
> > and we're not going to use this device again until we're in a
> > brand-new kernel and we re-enumerate the device and re-register the
> > driver.
> > 
> > I'm not quite sure how either of those fits into the power-saving
> > reason.  I guess going to S5 is probably via the kernel_power_off()
> > path and that by itself doesn't turn off as much power to the PCIe
> > controller as it could?  And this new .shutdown() method will get
> > called in that path and will turn off more power, but will still leave
> > enough for wake-on-LAN to work?  And when we *do* wake from S5,
> > obviously that means a complete boot with a new kernel.
> 
> Correct, the S5 shutdown is via kernel_power_off() and will turn off all
> that we can in the PCIe root complex and its PHY, drop the PCIe link to
> the end-point which signals that the end-point can enter its own suspend
> logic, too. And yes, when we do wake-up from S5 it means booting a
> completely new kernel. S5 is typically implemented in our chips by
> keeping just a little bit of logic active to service wake-up events
> (infrared remotes, GPIOs, RTC, etc.).

Which part of that does this patch change?  Is it that the new
.shutdown() turns off more power than machine_power_off() does by
itself?

Bjorn
