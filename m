Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394524C79B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHTWLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 18:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgHTWLp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 18:11:45 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0922E207DA;
        Thu, 20 Aug 2020 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597961504;
        bh=hQLn8f05VaasNn8PdcyJKXuA9IhbW747RfOgp0dwy1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JisBUDGzywd0EU23tAc0zxOcZggfK7/Yd5/DGGteUVJ0i+5IAoF2IZ2egdnOYRgma
         dUi3XDECWHRabaC0FReJ92JAeL9UPMku0wh2iJ86Z5uPar0R9NH+NaFnTq7SHDsUGH
         ukorNBEAIcX5CE4gLT0W0pStS0c2rDhhfZZiFa0Y=
Date:   Thu, 20 Aug 2020 17:11:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     ray.jui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
Message-ID: <20200820221142.GA1571008@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 06, 2020 at 04:14:55PM +1200, Mark Tomlinson wrote:
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
> 
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

Applied with collected reviews/acks to pci/enumeration for v5.10,
thanks!

> ---
> changes in v4:
>  - Use bitfield rather than bool to save memory (was meant to be in v3).
> 
>  drivers/pci/access.c | 9 ++++++---
>  include/linux/pci.h  | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..b452467fd133 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	 * write happen to have any RW1C (write-one-to-clear) bits set, we
>  	 * just inadvertently cleared something we shouldn't have.
>  	 */
> -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> -			     size, pci_domain_nr(bus), bus->number,
> -			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +	if (!bus->unsafe_warn) {
> +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +			 size, pci_domain_nr(bus), bus->number,
> +			 PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +		bus->unsafe_warn = 1;
> +	}
>  
>  	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..85211a787f8b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -626,6 +626,7 @@ struct pci_bus {
>  	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
>  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
>  	unsigned int		is_added:1;
> +	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
>  };
>  
>  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> -- 
> 2.28.0
> 
