Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7001F4896
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgFIVEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 17:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgFIVEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 17:04:02 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F19920734;
        Tue,  9 Jun 2020 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591736642;
        bh=+/YoObOnMTDr/Y8JbI9ZCCUUmEH6TYbQ6zaa5y0pJ34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eWWyU3V/twwncnFiKsfRI/Dw6AP48xi4InRBRSrOY2/B4bTSH30r2sa6yQY1cu/x+
         PcHuEl/kz/e6+wYxEd2sMi4JQjN4uC/aDh7WWb6W/9m29cHvl6fkE7R7yH5tWDXQyj
         dUvc/2Xxcln6+QeuMlKWp/tV6P7x1gN1uFcCJNhk=
Date:   Tue, 9 Jun 2020 16:04:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200609210400.GA1461839@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607113632.GA49147@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:

> Your "problem" I think can be summed up a bit more concise:
> 	- you don't trust kernel drivers to be "secure" for untrusted
> 	  devices
> 	- you only want to bind kernel drivers to "internal" devices
> 	  automatically as you "trust" drivers in that situation.
> 	- you want to only bind specific kernel drivers that you somehow
> 	  feel are "secure" to untrusted devices "outside" of a system
> 	  when those devices are added to the system.
> 
> Is that correct?
> 
> If so, fine, you can do that today with the bind/unbind ability of
> drivers, right?  After boot with your "trusted" drivers bound to
> "internal" devices, turn off autobind of drivers to devices and then
> manually bind them when you see new devices show up, as those "must" be
> from external devices (see the bind/unbind files that all drivers export
> for how to do this, and old lwn.net articles, this feature has been
> around for a very long time.)
> 
> I know for USB you can do this, odds are PCI you can turn off
> autobinding as well, as I think this is a per-bus flag somewhere.  If
> that's not exported to userspace, should be trivial to do so, should be
> somewere in the driver model already...
> 
> Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> sysfs for all busses.  Do those not work for you?
> 
> My other points are the fact that you don't want to put policy in the
> kernel, and I think that you can do everything you want in userspace
> today, except maybe the fact that trying to determine what is "inside"
> and "outside" is not always easy given that most hardware does not
> export this information properly, if at all.  Go work with the firmware
> people on that issue please, that would be most helpful for everyone
> involved to get that finally straightened out.

To sketch this out, my understanding of how this would work is:

  - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
    today, but doing so would be trivial.  I think I would prefer a
    sysfs name like "external" so it's more descriptive and less of a
    judgment.

    This comes from either the DT "external-facing" property or the
    ACPI "ExternalFacingPort" property.  

  - All devices present at boot are enumerated.  Any statically built
    drivers will bind to them before any userspace code runs.

    If you want to keep statically built drivers from binding, you'd
    need to invent some mechanism so pci_driver_init() could clear
    drivers_autoprobe after registering pci_bus_type.

  - Early userspace code prevents modular drivers from automatically
    binding to PCI devices:

      echo 0 > /sys/bus/pci/drivers_autoprobe

    This prevents modular drivers from binding to all devices, whether
    present at boot or hot-added.

  - Userspace code uses the sysfs "bind" file to control which drivers
    are loaded and can bind to each device, e.g.,

      echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind

Is that what you're thinking?  Is that enough for the control you
need, Rajat?
