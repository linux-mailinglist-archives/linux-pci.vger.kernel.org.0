Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE520B35F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgFZOSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 10:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgFZOSA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 10:18:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FDA208C9;
        Fri, 26 Jun 2020 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593181079;
        bh=QPTU4Y1vwrRGgF5153j76jr6ryZ826LAZeuZlTjk2jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHGnECLokQmtsfewmSKPFDJQO9bIyzoLW5WygALzMXPHvLNr9M+yRmebHA9/vhCYV
         OLgR6oEpQiKXT/ffIWresFZmoeLzxR1UJYdsRuCbopr0kDzFbWBjfhpWi6+/zWtSYS
         QCEOHsJOb2FTQ3bmmNjXDFVJxV1/fLMaw64eBQ/s=
Date:   Fri, 26 Jun 2020 16:17:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
Message-ID: <20200626141754.GB4141629@kroah.com>
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626002710.110200-2-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 05:27:10PM -0700, Rajat Jain wrote:
> Introduce a PCI parameter that disables the automatic attachment of
> untrusted devices to their drivers.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> Context:
> 
>   I set out to implement the approach outlined in
>     https://lkml.org/lkml/2020/6/9/1331
>     https://lkml.org/lkml/2020/6/15/1453
> 
>   But to my surprise, I found that the new hotplugged PCI devices
>   were getting automatically attached to drivers even though
>   /sys/bus/pci/drivers_autoprobe was set to 0.
> 
>   I realized that the device core's "drivers_autoprobe":
> 
>   * only disables the *initial* probe of the device (i.e. from
>     device_add()). If a subsystem calls device_attach() explicitly
>     for its devices like PCI subsystem does, the drivers_autoprobe
>     setting does not matter. The core will attach device to the driver.
>     This looks like correct semantic behavior to me because PCI is
>     explicitly calling device_attach(), which is a way to explicitly
>     ask the core to find and attach a driver for a device.
> 
>   * "drivers_autoprobe" cannot be controlled at boot time (to restrict
>     any drivers before userspace comes up).
> 
>   The options I considered were:
> 
>   1) Change device_attach() so that it takes into consideration the
>      drivers_autoprobe property. Not sure if this is semantically correct
>      thing to do though. If I do this, then the only way a driver can
>      be attached to the drivers would be via userspace
>      (/sys/bus/pci/drivers/bind) (Good for our use case though!).

This is the correct thing to do here, haven't I been asking you do move
this logic into the driver core so that all busses can use it?

>   2) Make the drivers_autoprobe property available to PCI to use
>      (currently it is private to device core). The PCI could use this
>      to determine whether or not to call device_attach(). This still
>      leaves the other problem (of not being able to set
>      drivers_autoprobe via command line open).

Ick, command lines are horrible, don't do that if at all possible.  On
some systems they are not able to be changed which can be good or bad...

>   3) I found the pci_dev->match_driver, which seemed similar to what I
>      am trying to do, but can't be controlled from userspace. I considered
>      populating that field based on drivers_autoprobe (still need (2)).
>      But the problem is that there is the AMD IOMMU driver which is setting
>      this independently, so setting the match_driver based on
>      drivers_autoprobe may not be a good idea. May be we can populate it
>      for untrusted devicesi, based on the parameter that I'm introducing?
> 
>   4) This patch was my option 4 that helps fix both the problems for me.

I suggest putting some of the above text in the changelog, as it has a
lot of good context, while your existing changelog is pretty sparse and
does not explain anything...


> 
>  drivers/pci/bus.c | 11 ++++++++---
>  drivers/pci/pci.c |  9 +++++++++
>  drivers/pci/pci.h |  1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3cef835b375fd..336aeeb4c4ebf 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	pci_bridge_d3_update(dev);
>  
>  	dev->match_driver = true;
> -	retval = device_attach(&dev->dev);
> -	if (retval < 0 && retval != -EPROBE_DEFER)
> -		pci_warn(dev, "device attach failed (%d)\n", retval);
> +
> +	if (dev->untrusted && pci_dont_attach_untrusted_devs) {
> +		pci_info(dev, "not attaching untrusted device\n");
> +	} else {
> +		retval = device_attach(&dev->dev);
> +		if (retval < 0 && retval != -EPROBE_DEFER)
> +			pci_warn(dev, "device attach failed (%d)\n", retval);
> +	}
>  
>  	pci_dev_assign_added(dev, true);
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce096272f52b1..dec1f9ef27d71 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -127,6 +127,13 @@ static bool pcie_ats_disabled;
>  /* If set, the PCI config space of each device is printed during boot. */
>  bool pci_early_dump;
>  
> +/*
> + * If set, the devices with "untrusted" flag shall not be attached automatically
> + * Userspace will need to attach them manually:
> + * echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
> + */
> +bool pci_dont_attach_untrusted_devs;
> +
>  bool pci_ats_disabled(void)
>  {
>  	return pcie_ats_disabled;
> @@ -6522,6 +6529,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strcmp(str, "dont_attach_untrusted_devs")) {
> +				pci_dont_attach_untrusted_devs = true;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6d3f758671064..30ffad047d926 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,7 @@
>  
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
> +extern bool pci_dont_attach_untrusted_devs;
>  
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

What happened to the split of "trust" and "internal/external" logic that
we discussed before?  This seems to ignore all of that and go straight
to some form of "we know what we trust, so all is fine!".

It's not obvious what this is really doing here at all, sorry...

greg k-h
