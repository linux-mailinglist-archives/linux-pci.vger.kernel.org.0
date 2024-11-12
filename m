Return-Path: <linux-pci+bounces-16611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D6F9C64FB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090C91F23714
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A492201266;
	Tue, 12 Nov 2024 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNAyrrY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354001CD1E1
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453385; cv=none; b=BqoIVFSvPhxVmPnNwUL7LdCVTaq39tqV1Wc+ga4/otdqBvvQ3ONoC+TLq0Q2FcTNEB7SJrddd4OZnxts+kdQyxJMVFgX9S+o88Ga6w6NLO2yo43rKrKdla1GZHL7DIn+Hm8iA6ShHN80TbR8MkFsNlG8ulaC7TFz2Sy7AFXFJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453385; c=relaxed/simple;
	bh=zDS4TFXOG8R2cB6izC9zqF5HHfV7gRtpjXZv6SlqcoE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AxQbrEGNy50N3Lgo5bUPhuSmIFHCDUQDhfIVOzFXqoUiiMrmCiPzGIgBIDABD5Br++Ug/8OnIDYu/2Haffm3udiN1H4PZErj4CLTCbMHcJa9aYakdU/lXQyOZTXG+5ZehjpHJVdd/AAReqzuLhgLp16M8BAulDpWGtm0gEhN+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNAyrrY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA1BC4CECD;
	Tue, 12 Nov 2024 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731453384;
	bh=zDS4TFXOG8R2cB6izC9zqF5HHfV7gRtpjXZv6SlqcoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RNAyrrY89zY9ytaknKX355I3BE3gxBK8eVmmpKLVR4LicB51idBNdyY6zAhvL8VsG
	 LE/G/uYZEKulV7juSirO4TtSQdpL96L3+jbgrViT7/xDeZORsTYR4IYqQ/odGpWHmm
	 LfBgxb9yIjrpzvu6l83TqxqHYtwH4UyhAdhxX2IK0wA2TmEysQ9Kluk86Jbab+ZR+h
	 y+bRHIOEur8NQBghtonGNDz6uqHY1ffFcH4HQM9LW7qZX/RGnxMAXOW+T01c7f0eS5
	 B5GEpq6dYlaUyxh++c6xWyvbKjQYVLuk9CkC0uIYFG6BY/PQ4OsnObZxVYQbEgRELA
	 5e6puWXnXSEbw==
Date: Tue, 12 Nov 2024 17:16:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, ameynarkhede03@gmail.com,
	raphael.norwitz@nutanix.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <20241112231623.GA1866148@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>

On Fri, Oct 25, 2024 at 03:27:54PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Resetting a bus from an end device only works if it's the only function
> on or below that bus.

Can we clarify this wording?  "Resetting a bus from an end device"?

I guess this has something to do with pci_parent_bus_reset(dev), which
declines to call pci_bridge_secondary_bus_reset() if there are any
other devices on the same bus as "dev"? 

pci_parent_bus_reset() is only called from pci_reset_bus_function(),
which is used by the "bus" and "cxl_bus" reset methods.

So I guess the point is something like:

  The "bus" and "cxl_bus" reset methods reset a device by asserting
  Secondary Bus Reset on the bridge leading to the device.
  pci_parent_bus_reset() only allows that if the device is the only
  device below the bridge.

  Add a sysfs attribute on bridges that can assert Secondary Bus Reset
  regardless of how many devices are below the bridge.  This makes it
  possible for users to reset multiple devices in a single command.

I omitted "safely" because this doesn't do any checking to ensure
safety, so I don't know in what sense it is safe.

It seems like this is partly just a convenience, to reset several
devices at once.

But I think it is *also* a new way to reset devices that we might not
be able to reset otherwise, e.g., if there's more than one device on
the bus, and they don't support ACPI, FLR, or PM reset, there
previously was no reset method that worked at all.  Right?

> Provide an attribute on the pci_dev bridge device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> action.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Moved the attribute from the pci_bus to the bridge's pci_dev
> 
>   And renamed it to "reset_subordinate" to distinguish from other
>   existing device "reset" attributes.
> 
>   Added documentation.
> 
>   Follow up patch to warn if the action was potentially harmful.
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 11 +++++++++++
>  drivers/pci/pci-sysfs.c                 | 23 +++++++++++++++++++++++
>  drivers/pci/pci.c                       |  2 +-
>  drivers/pci/pci.h                       |  1 +
>  4 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 7f63c7e977735..5da6a14dc326b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -163,6 +163,17 @@ Description:
>  		will be present in sysfs.  Writing 1 to this file
>  		will perform reset.
>  
> +What:		/sys/bus/pci/devices/.../reset_subordinate
> +Date:		October 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		This is visible only for bridge devices. If you want to reset
> +		all devices attached through the subordinate bus of a specific
> +		bridge device, writing 1 to this will try to do it.  This will
> +		affect all devices attached to the system through this bridge
> +		similiar to writing 1 to their individual "reset" file, so use
> +		with caution.
> +
>  What:		/sys/bus/pci/devices/.../vpd
>  Date:		February 2008
>  Contact:	Ben Hutchings <bwh@kernel.org>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d0f4db1cab78..480a99e50612b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -521,6 +521,28 @@ static ssize_t bus_rescan_store(struct device *dev,
>  static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
>  							    bus_rescan_store);
>  
> +static ssize_t reset_subordinate_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_bus *bus = pdev->subordinate;
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val) {
> +		int ret = __pci_reset_bus(bus);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(reset_subordinate);
> +
>  #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
>  static ssize_t d3cold_allowed_store(struct device *dev,
>  				    struct device_attribute *attr,
> @@ -625,6 +647,7 @@ static struct attribute *pci_dev_attrs[] = {
>  static struct attribute *pci_bridge_attrs[] = {
>  	&dev_attr_subordinate_bus_number.attr,
>  	&dev_attr_secondary_bus_number.attr,
> +	&dev_attr_reset_subordinate.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..338dfcd983f1e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5880,7 +5880,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
>   *
>   * Same as above except return -EAGAIN if the bus cannot be locked
>   */
> -static int __pci_reset_bus(struct pci_bus *bus)
> +int __pci_reset_bus(struct pci_bus *bus)
>  {
>  	int rc;
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa9..1cdc2c9547a7e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -104,6 +104,7 @@ bool pci_reset_supported(struct pci_dev *dev);
>  void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> +int __pci_reset_bus(struct pci_bus *bus);
>  
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
> -- 
> 2.43.5
> 

