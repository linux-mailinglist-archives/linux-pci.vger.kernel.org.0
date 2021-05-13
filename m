Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8126037F93B
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhEMN7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 09:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhEMN7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 09:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D1761406;
        Thu, 13 May 2021 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620914308;
        bh=+2C2vXezVVrNO7tc1g+YZPiKBmWLmnx6KmsQzw5Px+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUJb0L7v3yUFEWPdVr0mFTCbxGRfUhwh/r9i4RiTXaR7HcQ9X14j4F9WMjy7P5pjc
         QR+UDnXQCO2DYo4yqXjSrF6Ryyf/zOg+9VGtwG+w6OuJPIITdpAMc0qP5Byb/2ArUK
         ZFqPa7bzU0JxHGAi6XmFQrya87qk/AwPytLCZyT4=
Date:   Thu, 13 May 2021 15:58:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
Message-ID: <YJ0wgdUaOyaJpaXi@kroah.com>
References: <20210512213457.1310774-1-rajatja@google.com>
 <20210512213457.1310774-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512213457.1310774-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 12, 2021 at 02:34:57PM -0700, Rajat Jain wrote:
> A PCI device is "external_facing" if it's a Root Port with the ACPI
> "ExternalFacingPort" property or if it has the DT "external-facing"
> property.  We consider everything downstream from such a device to
> be removable by user.
> 
> We're mainly concerned with consumer platforms with user accessible
> thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> ports to be identified as "ExternalFacingPort". Devices in traditional
> hotplug slots can technically be removed, but the expectation is that
> unless the port is marked with "ExternalFacingPort", such devices are less
> accessible to user / may not be removed by end user, and thus not exposed
> as "removable" to userspace.
> 
> Set pci_dev_type.supports_removable so the device core exposes the
> "removable" file in sysfs, and tell the device core about removable
> devices.
> 
> This can be used by userspace to implment any policies it wants to,
> tailored specifically for user removable devices. Eg usage:
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> (code uses such an attribute to remove external PCI devicces or disable
> features on them as needed by the policy desired)
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: - commit log updated
>     - Rename set_pci_dev_removable() -> pci_set_removable()
>     - Call it after applying early PCI quirks.
> v2: Add documentation
> 
>  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
>  drivers/pci/pci-sysfs.c                           |  1 +
>  drivers/pci/probe.c                               | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> index 9dabcad7cdcd..ec0b243f5db4 100644
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
> index beb8d1f4fafe..38b3259ba333 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1541,4 +1541,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  
>  const struct device_type pci_dev_type = {
>  	.groups = pci_dev_attr_groups,
> +	.supports_removable = true,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8869..3515afeeaba8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>  		dev->untrusted = true;
>  }
>  
> +static void pci_set_removable(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
> +	if (parent &&
> +	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	else
> +		dev_set_removable(&dev->dev, DEVICE_FIXED);
> +}

Always run checkpatch.pl so you don't get grumpy maintainers telling you
to run checkpatch.pl :(

And why does external_facing come into play here?  I know you say it
above, but you should also put it here into the code for when we need to
look at it in a few months and wonder what in the world this is doing.

Also, are you SURE this is correct and will handle the hotpluggable PCI
devices in things like drawers and the like?

What is the goal here in exposing this information to userspace, who is
going to use it and what is it going to be used for?


> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1822,6 +1832,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
>  
> +	pci_set_removable(dev);
> +
>  	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
>  		 dev->vendor, dev->device, dev->hdr_type, dev->class);
>  
> -- 
> 2.31.1.607.g51e8a6a459-goog
> 
