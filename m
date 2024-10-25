Return-Path: <linux-pci+bounces-15345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70B9B0A70
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5053B1F23DA4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CA1FF04A;
	Fri, 25 Oct 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3rE6DF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487481FB8B3
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875447; cv=none; b=mkNw+GD+18W3dtSDpCwJI7ZZ8d1EZJnLPwXESQTHq1SHYwrK/6rA51nhoXNDshfw+atVa+udJEwf1TewEyf916UbfBMH6lZ5I44NdguldQmbDVz8IzJI0kL4jZmZQ5ctNacsmzdWdN5f5VtGp3tgOZV8RNYddGgDSflKl9/+8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875447; c=relaxed/simple;
	bh=Lj623PMJwlkglnCLCLxYKpmC4cw4XQ/U733BIv5mpFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=smbTbwr2Rw19yQq/nS4U+IfvH14xDax6Ys0hfaKApLTl9b3sCZ7eXmuFIah1KcvsWj4gb0Q8UxQgemrjEHujBFPiycWyAGPn0pUWaq5f6HC0Y/FiUYy2fH3pKUU5cldlJEV2h438kMaprfOpr1tKnmZVudlZQxeEJMUOnOACoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3rE6DF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1248C4CEC3;
	Fri, 25 Oct 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875446;
	bh=Lj623PMJwlkglnCLCLxYKpmC4cw4XQ/U733BIv5mpFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n3rE6DF+hflxIMltVH+8PfWAOZzmUiW3SS0cSwUkvLkJJh82V5xXQNoAUt0ZMuV5a
	 Eew0HLRJ3s1d7gPn2d5uz5A4sijuotR2EatVanP5X62/UgvagyRR0DbL3gWJ2npPfd
	 hsRfPAAiuznOkKqf65qQw5v5QaqJGUbS1cpUvpsPCvA62BPo7OfCefkI2b4puZ/A6j
	 OHIF54wyTYP/kwO7zjOhUsWaGlOXtGhCiPrAP45ajp/HUPYrvSmfGNG9843Ta5DD6N
	 HGnagU16cXqYWuFf6aN3wKtTIPBX8ZSR+0ODFDfR4FQyDXAgXs7nAeLzP9mKeGAT6r
	 tND0nJwjEcGzQ==
Date: Fri, 25 Oct 2024 11:57:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Amey Narkhede <ameynarkhede03@gmail.com>,
	Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] pci: provide bus reset attribute
Message-ID: <20241025165725.GA1025232@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025145021.1410645-1-kbusch@meta.com>

[+cc Alex, Amey, Raphael]

On Fri, Oct 25, 2024 at 07:50:21AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Attempting a bus reset on an end device only works if it's the only
> function on or below that bus.
> 
> Provide an attribute on the pci_bus device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> method.

I confess to being a little ambivalent or even hesitant about
operations on the pci_bus (as opposed to on a pci_dev), but I can't
really articulate a great reason, other than the fact that the "bus"
is kind of abstract and from a hardware perspective, the *devices* are
the only things we can control.

I assume this is useful in some scenario.  I guess this is root-only,
so there's no real concern about whether all the devices are used by
the same VM or in the same IOMMU group or anything?

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 23 +++++++++++++++++++++++
>  drivers/pci/pci.c       |  2 +-
>  drivers/pci/pci.h       |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d0f4db1cab78..616d64f12da4d 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -521,6 +521,28 @@ static ssize_t bus_rescan_store(struct device *dev,
>  static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
>  							    bus_rescan_store);
>  
> +static ssize_t bus_reset_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct pci_bus *bus = to_pci_bus(dev);
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
> +static struct device_attribute dev_attr_bus_reset = __ATTR(reset, 0200, NULL,
> +							   bus_reset_store);
> +
>  #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
>  static ssize_t d3cold_allowed_store(struct device *dev,
>  				    struct device_attribute *attr,
> @@ -638,6 +660,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  
>  static struct attribute *pcibus_attrs[] = {
>  	&dev_attr_bus_rescan.attr,
> +	&dev_attr_bus_reset.attr,
>  	&dev_attr_cpuaffinity.attr,
>  	&dev_attr_cpulistaffinity.attr,
>  	NULL,
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

