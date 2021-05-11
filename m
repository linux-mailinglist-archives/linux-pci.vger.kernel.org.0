Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2337B0CC
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 23:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhEKVb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 17:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhEKVbz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 17:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E3B061919;
        Tue, 11 May 2021 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620768649;
        bh=ZqExC12JpkhpWz/CkibWvB0TO3ks/bAKORvyV1kk7HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pnd5g0Eo7h+9XqH3dSvC9FF40a74EIu55uNt/vkGYHiV8sT/hGqOwL3dpt3uZl+xM
         nUOEwYUtR5BkuuEBSDosOrKrjA5iju9qfS9S7Dq6gYUwIf3uswbOnLjHzUH39fWgc2
         xwQpOtoJ0uepO3kwsOF+v80jAfh5HPgupXGaULmGztv3Fv2oXfFX9xdl3dGWaSk5vB
         6inU1PEivqnunT2e88QnXE5/x/qdziTLsBisTyJqCWnlZvh7MJwCUdO6WCNOqMDWJE
         vqMJhhcVfmGF1U5MYJr/32/AmCQ9k+pAe+CZmEWzZC1ddKD09rM8Pmk+mz05NPNj4S
         Mtz5Vb4wtnlfA==
Date:   Tue, 11 May 2021 16:30:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
Message-ID: <20210511213047.GA2417208@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424021631.1972022-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Oliver, David]

Please update the subject line, e.g.,

  PCI: Add sysfs "removable" attribute

On Fri, Apr 23, 2021 at 07:16:31PM -0700, Rajat Jain wrote:
> Export the already available info, to the userspace via the
> device core, so that userspace can implement whatever policies it
> wants to, for external removable devices.

I know it's not strictly part of *this* patch, but I think we should
connect the dots a little here, something like this:

  PCI: Add sysfs "removable" attribute

  A PCI device is "external_facing" if it's a Root Port with the ACPI
  "ExternalFacingPort" property or if it has the DT "external-facing"
  property.  We consider everything downstream from such a device to
  be removable.

  Set pci_dev_type.supports_removable so the device core exposes the
  "removable" file in sysfs, and tell the device core about removable
  devices.

Wrap to fill 75 columns.

> Signed-off-by: Rajat Jain <rajatja@google.com>

This looks like a good start.  I think it would be useful to have a
more concrete example of how this information will be used.  I know
that use would be in userspace, so an example probably would not be a
kernel patch.  If you have user code published anywhere, that would
help.  Or even a patch to an existing daemon.  Or pointers to how
"removable" is used for USB devices.

> ---
> v2: Add documentation
> 
>  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
>  drivers/pci/pci-sysfs.c                           |  1 +
>  drivers/pci/probe.c                               | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> index e13dddd547b5..daac4f007619 100644
> --- a/Documentation/ABI/testing/sysfs-devices-removable
> +++ b/Documentation/ABI/testing/sysfs-devices-removable
> @@ -14,4 +14,5 @@ Description:
>  
>  		Currently this is only supported by USB (which infers the
>  		information from a combination of hub descriptor bits and
> -		platform-specific data such as ACPI).
> +		platform-specific data such as ACPI) and PCI (which gets this
> +		from ACPI / device tree).
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index f8afd54ca3e1..9302f0076e73 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1582,4 +1582,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  
>  const struct device_type pci_dev_type = {
>  	.groups = pci_dev_attr_groups,
> +	.supports_removable = true,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..d1cceee62e1b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>  		dev->untrusted = true;
>  }
>  
> +static void set_pci_dev_removable(struct pci_dev *dev)

Maybe just "pci_set_removable()"?  These "set_pci*" functions look a
little weird.

> +{
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
> +	if (parent &&
> +	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	else
> +		dev_set_removable(&dev->dev, DEVICE_FIXED);
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1819,6 +1829,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> +	set_pci_dev_removable(dev);

So this *only* sets the "removable" attribute based on the
ExternalFacingPort or external-facing properties.  I think Oliver and
David were hinting that maybe we should also set it for devices in
hotpluggable slots.  What do you think?

I wonder if this (and similar hooks like set_pcie_port_type(),
set_pcie_untrusted(), set_pcie_thunderbolt(), etc) should go *after*
the early fixups so we could use fixups to work around issues?

>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
>  
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 
