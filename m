Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7C38CF6E
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhEUU66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 16:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhEUU6z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 16:58:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 052EA613EC;
        Fri, 21 May 2021 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621630652;
        bh=qqA/7MwrbV3/4dwT/MGseHW0sYgG3QSvsuZtq6OX9lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p3ednAxjiY+FmqzbvsWeOV4fBKaWUkndkKkdH/JXTqUzE7i0jdLQO+FGNtrHanCD6
         lSUScYWMdgUeiRCrdmm4BEdpV/nGxn5gCySATXJrk+jHRhl+8yrW2BCHjQL67CxwTg
         UOltmWeP7dvreEPLwv57ydfcMSft1RYpGSDdeusOCggSy78RAKcmqyilocLrLh013J
         4Dwbto1RImQx39tEdANVxLriEE/0wGtZlTSwhu2iWPux20dS6wvBtRgS/VmK1JWpLt
         l6TdnXpcTCpdeiYztHxeJjtE++1etqHMOMS3wUFCbkGr2n+wd0qSpuJLE867G6gIgB
         vfzNErQ0zIvnA==
Date:   Fri, 21 May 2021 15:57:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v4 2/2] PCI: Add sysfs "removable" attribute
Message-ID: <20210521205730.GA444958@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513232701.411773-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 04:27:01PM -0700, Rajat Jain wrote:
> A PCI device is "external_facing" if it's a Root Port with the ACPI
> "ExternalFacingPort" property or if it has the DT "external-facing"
> property.  We consider everything downstream from such a device to
> be removable by user.
> 
> We're mainly concerned with consumer platforms with user accessible
> Thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> ports to be identified by firmware as "ExternalFacingPort". Devices in
> traditional hotplug slots can technically be removed, but the expectation
> is that unless the port is marked with "ExternalFacingPort", such devices
> are less accessible to user / may not be removed by end user, and thus not
> exposed as "removable" to userspace.
>
> This can be used to implement userspace policies tailored for
> user removable devices. Eg usage:
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> (code uses such an attribute to remove external PCI devices or disable
> features on them as needed by the policy desired)
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Greg, feel free to merge both these via your tree.

> ---
> v4: - code comments, commit log updates
>     - Make "removable" attribute show up only under devices that are
>       really removable.
> v3: - commit log updated
>     - Rename set_pci_dev_removable() -> pci_set_removable()
>     - Call it after applying early PCI quirks.
> v2: Add documentation
> 
>  .../ABI/testing/sysfs-devices-removable       |  3 ++-
>  drivers/pci/probe.c                           | 22 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> index acf7766e800b..bda6c320c8d3 100644
> --- a/Documentation/ABI/testing/sysfs-devices-removable
> +++ b/Documentation/ABI/testing/sysfs-devices-removable
> @@ -14,4 +14,5 @@ Description:
>  
>  		Currently this is only supported by USB (which infers the
>  		information from a combination of hub descriptor bits and
> -		platform-specific data such as ACPI).
> +		platform-specific data such as ACPI) and PCI (which gets this
> +		from ACPI / device tree).
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8869..812e0d7fd7a7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1575,6 +1575,26 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>  		dev->untrusted = true;
>  }
>  
> +static void pci_set_removable(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
> +
> +	/*
> +	 * We (only) consider everything downstream from an external_facing
> +	 * device to be removable by the user. We're mainly concerned with
> +	 * consumer platforms with user accessible thunderbolt ports that are
> +	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> +	 * the firmware as external_facing. Devices in traditional hotplug
> +	 * slots can technically be removed, but the expectation is that unless
> +	 * the port is marked with external_facing, such devices are less
> +	 * accessible to user / may not be removed by end user, and thus not
> +	 * exposed as "removable" to userspace.
> +	 */
> +	if (parent &&
> +	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1822,6 +1842,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
>  
> +	pci_set_removable(dev);
> +
>  	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
>  		 dev->vendor, dev->device, dev->hdr_type, dev->class);
>  
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
