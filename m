Return-Path: <linux-pci+bounces-11511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30394C560
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED251C21E3F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17A144D27;
	Thu,  8 Aug 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZR9Q2Js"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594C7E792;
	Thu,  8 Aug 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145854; cv=none; b=kIeCw7C/Uj6Eh7HAQevohs36NYd3AbdWSuKuZ/05e1dBXyfxsVJohO/6+yt9Ro/TXMKKsJw2xteUJMQes3S73BA403NEc8coFY5qfbyOPEzyUhBvJIq13R1Jt7fYEU84u4GhFbjO8RzFyVg9ZskP16uW2UOoMEI2G6JH2iOLjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145854; c=relaxed/simple;
	bh=VR1QlqidgbMkxepuxECLL/dcokm+qkCt2cFfPO2PbdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sfagDuVbmvEmxG1stiY3wfpTl0XblwYMOGBU7xCVEgftC0hs4xOr1Rt64QNPr38/b6quDqqCNpQnN3IZja9uNs8BRM2LbgPGK5JGxqIlh+qcDAYYcXe1s+JOht4YB4gd0iTFhJIA8QgXEycmrNuSiIrEgRYDgL/uXU5txL1mkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZR9Q2Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D40C32782;
	Thu,  8 Aug 2024 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723145854;
	bh=VR1QlqidgbMkxepuxECLL/dcokm+qkCt2cFfPO2PbdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oZR9Q2JsbeRsZs7FaifIYdxPh7hagSpMvAPhW+NA+gxRubZ5xtB3Mt3IVYCERTg/h
	 aQQC75CTSv4PbPXhjaHoZEVnICD8aHlw/0qAf1vKKSso6Bk45R6qHTGmNAMoAIo4i3
	 k1yt/7SrJCnIqwg/MQ8JpORjs0C3gk0vM/v5FiYi3cDIaDtnOR17MM12phzlzbg6VQ
	 1ESLLVlabImIytXHyt4qguaJr9A2njdQHmcIjKE/47M5EKeQJU5QgXy0R8dNUWZgDp
	 oc3Bl8pNiYQtXve773A1J7zHKtOjDRmx32TR9HOE7498zCY5tBrUcr1oxnjLS6y/2d
	 TgvIP9/yHEg9Q==
Date: Thu, 8 Aug 2024 14:37:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] PCI: Restore memory decoding after reallocation
Message-ID: <20240808193731.GA156598@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807151723.613742-5-stewart.hildebrand@amd.com>

On Wed, Aug 07, 2024 at 11:17:13AM -0400, Stewart Hildebrand wrote:
> Currently, the PCI subsystem unconditionally clears the memory decoding
> bit of devices with resource alignment specified. While drivers should
> call pci_enable_device() to enable memory decoding, some platforms have
> devices that expect memory decoding to be enabled even when no driver is
> bound to the device. It is assumed firmware enables memory decoding in
> these cases. For example, the vgacon driver uses the 0xb8000 buffer to
> display a console without any PCI involvement, yet, on some platforms,
> memory decoding must be enabled on the PCI VGA device in order for the
> console to be displayed properly.
> 
> Restore the memory decoding bit after the resource has been reallocated.
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> v2->v3:
> * no change
> 
> v1->v2:
> * capitalize subject text
> * reword commit message
> 
> Testing notes / how to check if your platform needs memory decoding
> enabled in order to use vgacon:
> 1. Boot your system with a monitor attached, without any driver bound to
>    your PCI VGA device. You should see a console on your display.
> 2. Find the SBDF of your VGA device with lspci -v (00:01.0 in this
>    example).
> 3. Disable memory decoding (replace 00:01.0 with your SBDF):
>   $ sudo setpci -v -s 00:01.0 0x04.W=0x05
> 4. Type something to see if it appears on the console display
> 5. Re-enable memory decoding:
>   $ sudo setpci -v -s 00:01.0 0x04.W=0x07
> 
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
> index acecdd6edd5a..4b97d8d5c2d8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6676,6 +6676,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  
>  	pci_read_config_word(dev, PCI_COMMAND, &command);
>  	if (command & PCI_COMMAND_MEMORY) {
> +		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
>  		command &= ~PCI_COMMAND_MEMORY;
>  		pci_write_config_word(dev, PCI_COMMAND, command);
>  	}
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

The fact that we traverse the whole hierarchy here to restore
PCI_COMMAND_MEMORY makes me suspect there's a window between point A
(where we clear PCI_COMMAND_MEMORY and update a BAR) and point B
(where we restore PCI_COMMAND_MEMORY) where VGA console output will
not work.

This tickles my memory like we might have talked about this before and
there's some reason for having to wait.  If so, sorry, and maybe we
need a comment in the code about that reason.

>  	/* Dump the resource on buses */
>  	pci_bus_dump_resources(bus);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4246cb790c7b..74636acf152f 100644
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
> 2.46.0
> 

