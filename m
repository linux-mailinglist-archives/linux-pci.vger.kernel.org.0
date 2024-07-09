Return-Path: <linux-pci+bounces-10007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F892BF81
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17F0B28FAC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B4158A36;
	Tue,  9 Jul 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWGpJxc0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBBA34;
	Tue,  9 Jul 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541808; cv=none; b=Do5OO0Ok6huvtIbYT+L7+He7FCw+m6hVmDxVIlySX6biprTyDChpXVAg8ffwOgN1CIaGaUWX9DZi0zQRSEB8VwWccgvK4P4r4PMmS7ZosNLHhHxKsV0f34NZa0mnBHnMyaMJ5CNHMw4lbwcP08C6fXnHbLegrokh2yrPbz66gNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541808; c=relaxed/simple;
	bh=vdma4KF67C8gW5qlqW+swN2xS/cp0Eop6RE/FsVYWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YkI6CMjfQI7MYOTiPr49XnTUVA1pV2E29g+3vsRHl97C450G4nK42eddJOrxdEZ1ozCo4kM7s9QfhqKIh8gvIni3vDEgJwVfHdXVpmcZYb31axpz7cZnkOGurJeEpuSDN15BNZlbQaGRcOwFoOEFr9TFA9W98J20dIYoiL4EGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWGpJxc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A75C3277B;
	Tue,  9 Jul 2024 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541808;
	bh=vdma4KF67C8gW5qlqW+swN2xS/cp0Eop6RE/FsVYWdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HWGpJxc0J4bXMh2e7MJaz+CAQlgTrxDNNH8x86vxaWuDwsovOMtWeJkA/kB3kAbNz
	 ndTm8BXgmSRIFNZWcaSJMW9FbNeuN5VbPn9Yhld4zfk0AHR2WqjOuDrhdZUh82w3S9
	 E3OdPLJDh9WytoN0ui2HvPKl+JJT/GiPYsa3MVHOJRxNLC9qWJa1w9cUJ43CD1j3Dw
	 QaoD0+H4y8Ca1yty2zRCstkkhb5ca+JiUvWhDtn7/UN0RR1WryEGGT0O/36g8Lie3v
	 CQPFlZUzTKwnRl5Z5IeGCTNiUjV5dX0uSxjTvVxy5CD5JTJ9WxcSHZtbKGRJeAktQJ
	 BPQXYHuJgwJaw==
Date: Tue, 9 Jul 2024 11:16:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: restore memory decoding after reallocation
Message-ID: <20240709161646.GA175516@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709133610.1089420-4-stewart.hildebrand@amd.com>

On Tue, Jul 09, 2024 at 09:36:00AM -0400, Stewart Hildebrand wrote:
> Currently, the PCI subsystem unconditionally clears the memory decoding
> bit of devices with resource alignment specified. Unfortunately, some
> drivers assume memory decoding was enabled by firmware. Restore the
> memory decoding bit after the resource has been reallocated.

Which drivers have you tripped over?  Those drivers apparently don't
call pci_enable_device() and assume the firmware has left memory
decoding enabled.  I don't think there's any guarantee that firmware
must do that, so the drivers are probably broken on some platforms,
and we could improve things overall by adding the pci_enable_device()
to them.

> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> Relevant prior discussion at [1]
> 
> [1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
> ---
>  drivers/pci/pci.c       |  1 +
>  drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f017e7a8f028..7953e75b9129 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6633,6 +6633,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  
>  	pci_read_config_word(dev, PCI_COMMAND, &command);
>  	if (command & PCI_COMMAND_MEMORY) {
> +		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
>  		command &= ~PCI_COMMAND_MEMORY;
>  		pci_write_config_word(dev, PCI_COMMAND, command);
>  	}

It would be nice if this could be contained to
pci_reassigndev_resource_alignment() so the clear and restore could be
in the same function.  But I suppose the concern is that re-enabling
decoding too early could be an issue in a hierarchy where bridge
windows are also reassigned?

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ab7510ce6917..6847b251e19a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2131,6 +2131,29 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>  	}
>  }
>  
> +static void restore_memory_decoding(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *b;
> +
> +		if (dev->dev_flags & PCI_DEV_FLAGS_MEMORY_ENABLE) {
> +			u16 command;
> +
> +			pci_read_config_word(dev, PCI_COMMAND, &command);
> +			command |= PCI_COMMAND_MEMORY;
> +			pci_write_config_word(dev, PCI_COMMAND, command);
> +		}
> +
> +		b = dev->subordinate;
> +		if (!b)
> +			continue;
> +
> +		restore_memory_decoding(b);
> +	}
> +}
> +
>  /*
>   * First try will not touch PCI bridge res.
>   * Second and later try will clear small leaf bridge res.
> @@ -2229,6 +2252,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	goto again;
>  
>  dump:
> +	restore_memory_decoding(bus);
> +
>  	/* Dump the resource on buses */
>  	pci_bus_dump_resources(bus);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e83ac93a4dcb..cb5df4c6a999 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -245,6 +245,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>  	/* Device does honor MSI masking despite saying otherwise */
>  	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
> +	/* Firmware enabled memory decoding, to be restored if BAR is updated */
> +	PCI_DEV_FLAGS_MEMORY_ENABLE = (__force pci_dev_flags_t) (1 << 13),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.45.2
> 

