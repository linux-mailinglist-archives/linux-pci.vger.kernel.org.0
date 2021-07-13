Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44C3C77F6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMU2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 16:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhGMU2r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 16:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49BBF61175;
        Tue, 13 Jul 2021 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626207957;
        bh=mJtuocmKY1ZD27qCc5+iBGpIYis0OEt6fvllyrMcGh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C8aFzjtX3oYtUdlAl5siuj3PVqkJP9s4/jh6czMJUIxa9LngeXfXswIxmKscQlHg1
         e3R6M4qLVXMKE/AZwysRBqcg8uVLjFP5Qzazf7kAdMuQ735Vncd/H0G6hiNj8h4nb8
         WpTMBlCeBqEEB9tlBio+KojhBT+gWOistCNn982WVee7MhmTy19qxSjNzeUOPc/ego
         Hfcpw1oCvn2JPw2zmt55qXsADonSTmUszWrDiPejFHckhxFIfF61RVkXu0V4Qbx8ZJ
         3/NcjdJeuGCA1tmad+uBccP8FhgDNk3dzI0Hg8wLr5zcyjrx27fGHmOfJ13M6VwZcI
         Zd1QOrXy2/uQA==
Date:   Tue, 13 Jul 2021 15:25:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/VPD: Refactor pci_vpd_size
Message-ID: <20210713202555.GA1771351@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdda5f1-e1ea-af9f-cfbe-952b7d37e246@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Hannes]

On Thu, May 13, 2021 at 10:58:40PM +0200, Heiner Kallweit wrote:
> The only Short Resource Data Type tag is the end tag. This allows to
> remove the generic SRDT tag handling and the code be significantly
> simplified.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 46 ++++++++++++----------------------------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 26bf7c877..ecdce170f 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -73,50 +73,28 @@ EXPORT_SYMBOL(pci_write_vpd);
>  static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  {
>  	size_t off = 0;
> -	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
> +	u8 header[3];	/* 1 byte tag, 2 bytes length */
>  
>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
> -		unsigned char tag;
> -
>  		if (!header[0] && !off) {
>  			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
>  			return 0;
>  		}
>  
> -		if (header[0] & PCI_VPD_LRDT) {
> -			/* Large Resource Data Type Tag */
> -			tag = pci_vpd_lrdt_tag(header);
> -			/* Only read length from known tag items */
> -			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
> -			    (tag == PCI_VPD_LTIN_RO_DATA) ||
> -			    (tag == PCI_VPD_LTIN_RW_DATA)) {
> -				if (pci_read_vpd(dev, off+1, 2,
> -						 &header[1]) != 2) {
> -					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
> -						 tag, off + 1);
> -					return 0;
> -				}
> -				off += PCI_VPD_LRDT_TAG_SIZE +
> -					pci_vpd_lrdt_size(header);
> -			}
> -		} else {
> -			/* Short Resource Data Type Tag */
> -			off += PCI_VPD_SRDT_TAG_SIZE +
> -				pci_vpd_srdt_size(header);
> -			tag = pci_vpd_srdt_tag(header);
> -		}
> -
> -		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
> -			return off;
> +		if (header[0] == PCI_VPD_SRDT_END)
> +			return off + PCI_VPD_SRDT_TAG_SIZE;

This makes the code beautiful.  But I think pci_vpd_size() is too
picky even now, and this patch makes it more so.

I don't know why pci_vpd_size() currently checks the tags for
ID_STRING, RO_DATA, and RW_DATA.  That seems too aggressive to me.

I think these data items originally came from PNP ISA, and it defines
several other tags.  Of course, that wasn't for PCI devices, but a
Google search for '"invalid" "vpd tag" "at offset"' does find several
cases where VPD contains things that look like PNP ISA data items.

I think we should compute the VPD size by iterating through it looking
only at the type (small or large) and the data item length until we
find the End Tag.

This code originally came from 104daa71b396 ("PCI: Determine actual
VPD size on first access"), so I added Hannes in case there was some
reason we do the extra validation.

> -		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
> -		    (tag != PCI_VPD_LTIN_RO_DATA) &&
> -		    (tag != PCI_VPD_LTIN_RW_DATA)) {
> -			pci_warn(dev, "invalid %s VPD tag %02x at offset %zu",
> -				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
> -				 tag, off);
> +		if (header[0] != PCI_VPD_LRDT_ID_STRING &&
> +		    header[0] != PCI_VPD_LRDT_RO_DATA &&
> +		    header[0] != PCI_VPD_LRDT_RW_DATA) {
> +			pci_warn(dev, "invalid VPD tag %02x at offset %zu", header[0], off);
>  			return 0;
>  		}
> +
> +		if (pci_read_vpd(dev, off + 1, 2, header + 1) != 2)
> +			return 0;
> +
> +		off += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(header);
>  	}
>  	return 0;
>  }
> -- 
> 2.31.1
> 
> 
