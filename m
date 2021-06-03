Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09A39A915
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFCRZA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 13:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCRZA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 13:25:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD55F613BA;
        Thu,  3 Jun 2021 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622740995;
        bh=H31JsL6zbuRbFwi59OTB4iN2slHNfCC0KUrU618hVrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ORkYe/YOQtyhZIMArVq/Jg6gjyM6AqtW+uVpExVURCx8d+oF38u0hlDxUlgcfIjuK
         +se68dCK19GL3rQzXuPNjWMzSbUopnIcEXsMX2JGotNYYwwgOqnlc85nRPxhw1gW7J
         G4a3zaS/f1/u+gMsqWaPRRFGOwstes+dPI4t0kTU3wfInStUJTmmh3Ulx+6oVjQlrw
         mEe18bEKdnOiaW53kly1jD9SFYIUofFoBnDCYaKX7Tz6xBzud2ykgT4SEo2u2g57ov
         T0hdP8FUUoigDRLvl9l5KSy5VpiDXenBIDybC07f8nEamuUg8Y3wx0hh2vvA0G1Q+H
         4hmUW1aget0Rg==
Date:   Thu, 3 Jun 2021 12:23:13 -0500
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
Message-ID: <20210603172313.GA2123252@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c046f34-8bf1-97ff-3440-7351c7b2d528@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 10:03:47AM -0700, Florian Fainelli wrote:
> On 5/25/21 2:18 PM, Bjorn Helgaas wrote:
> > On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
> >> The shutdown() call is similar to the remove() call except the former does
> >> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
> >> if it does.
> > 
> > This doesn't explain why shutdown() is necessary.  "errors occur"
> > might be a hint, except that AFAICT, many similar drivers do invoke
> > pci_stop_root_bus() and pci_remove_root_bus() (several of them while
> > holding pci_lock_rescan_remove()), without implementing .shutdown().
> 
> We have to implement .shutdown() in order to meet a certain power budget
> while the chip is being put into S5 (soft off) state and still support
> Wake-on-WLAN, for our latest chips this translates into roughly 200mW of
> power savings at the wall. We could probably add a word or two in a v2
> that indicates this is done for power savings.

"Saving power" is a great reason to do this.  But we still need to
connect this to the driver model and the system-level behavior
somehow.

The pci_driver comment says @shutdown is to "stop idling DMA
operations" and it hooks into reboot_notifier_list in kernel/sys.c.
That's incorrect or at least incomplete because reboot_notifier_list
isn't mentioned at all in kernel/sys.c, and I don't see the connection
between @shutdown and reboot_notifier_list.

AFAICT, @shutdown is currently used in this path:

  kernel_restart_prepare or kernel_shutdown_prepare
    device_shutdown
      dev->bus->shutdown
        pci_device_shutdown                     # pci_bus_type.shutdown
          drv->shutdown

so we're going to either reboot or halt/power-off the entire system,
and we're not going to use this device again until we're in a
brand-new kernel and we re-enumerate the device and re-register the
driver.

I'm not quite sure how either of those fits into the power-saving
reason.  I guess going to S5 is probably via the kernel_power_off()
path and that by itself doesn't turn off as much power to the PCIe
controller as it could?  And this new .shutdown() method will get
called in that path and will turn off more power, but will still leave
enough for wake-on-LAN to work?  And when we *do* wake from S5,
obviously that means a complete boot with a new kernel.

Bjorn
