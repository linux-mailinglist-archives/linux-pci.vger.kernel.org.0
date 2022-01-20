Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2A494747
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358706AbiATG0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 01:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiATG0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 01:26:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB056C061574;
        Wed, 19 Jan 2022 22:26:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81D68B81A7F;
        Thu, 20 Jan 2022 06:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89758C340E0;
        Thu, 20 Jan 2022 06:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642659972;
        bh=50/ufx0m6AcTfkIB8K9DDFKGidfKTV/nhrA30Cc07/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/ZPvrSdEGRvqIbHqfd/hIsBCAgwOz+MCwUrDdPGBERcgEGzFn+0JdJuAz5sIiGiK
         PxgpXylLkdM4zR64eAkqto5hzA3Yk8fo7WLqT0NkwZMGrzbDUiebIgOI2NgoZMLpal
         sxgSjhuneGdSUR79b5yBDSBQAhR+kf36OC3u8WAI=
Date:   Thu, 20 Jan 2022 07:26:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vikash Bansal <bvikas@vmware.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com, srinidhir@vmware.com,
        anishs@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Message-ID: <YekAgfkDgV6z6hYV@kroah.com>
References: <1642526161-22499-1-git-send-email-bvikas@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642526161-22499-1-git-send-email-bvikas@vmware.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 09:16:01AM -0800, Vikash Bansal wrote:
> In the current implementation, the PCI capability list is parsed from
> the beginning to find each capability, which results in a large number
> of redundant PCI reads.
> 
> Instead, we can parse the complete list just once, store it in the
> pci_dev structure, and get the offset of each capability directly from
> the pci_dev structure.
> 
> This implementation improves pci devices initialization time  by ~2-3% in
> case of bare metal and 7-8% in case of VM running on ESXi.

What is that in terms of "wall clock" time?  % is hard to know here, and
of course it will depend on the PCI bus speed, right?

> It also adds a memory overhead of 20bytes (value of PCI_CAP_ID_MAX) per
> PCI device.
> 
> Signed-off-by: Vikash Bansal <bvikas@vmware.com>
> ---
>  drivers/pci/pci.c   | 43 ++++++++++++++++++++++++++++++++++++-------
>  drivers/pci/probe.c |  5 +++++
>  include/linux/pci.h |  2 ++
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb394986a..8e024db30262 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -468,6 +468,41 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
>  	return 0;
>  }
>  
> +
> +/**
> + * pci_find_all_capabilities - Read all capabilities
> + * @dev: the PCI device
> + *
> + * Read all capabilities and store offsets in cap_off
> + * array in pci_dev structure.
> + */
> +void pci_find_all_capabilities(struct pci_dev *dev)
> +{
> +	int ttl = PCI_FIND_CAP_TTL;
> +	u16 ent;
> +	u8 pos;
> +	u8 id;
> +
> +	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
> +	if (!pos)
> +		return;
> +	pci_bus_read_config_byte(dev->bus, dev->devfn, pos, &pos);
> +	while (ttl--) {
> +		if (pos < 0x40)

What is this magic value of 0x40?

> +			break;
> +		pos &= ~3;

Why ~3?

> +		pci_bus_read_config_word(dev->bus, dev->devfn, pos, &ent);
> +		id = ent & 0xff;

Do you really need the & if you are truncating it?

> +		if (id == 0xff)
> +			break;
> +
> +		/* Read first instance of capability */
> +		if (!(dev->cap_off[id]))
> +			dev->cap_off[id] = pos;

Shouldn't you have checked this before you read the value?

> +		pos = (ent >> 8);

What about walking the list using __pci_find_next_cap() like before?
Why is this somehow the same as the old function?

> +	}
> +}
> +
>  /**
>   * pci_find_capability - query for devices' capabilities
>   * @dev: PCI device to query
> @@ -489,13 +524,7 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
>   */
>  u8 pci_find_capability(struct pci_dev *dev, int cap)
>  {
> -	u8 pos;
> -
> -	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
> -	if (pos)
> -		pos = __pci_find_next_cap(dev->bus, dev->devfn, pos, cap);
> -
> -	return pos;
> +	return dev->cap_off[cap];
>  }
>  EXPORT_SYMBOL(pci_find_capability);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..bacab12cedbb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1839,6 +1839,11 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->hdr_type = hdr_type & 0x7f;
>  	dev->multifunction = !!(hdr_type & 0x80);
>  	dev->error_state = pci_channel_io_normal;
> +	/*
> +	 * Read all capabilities and store offsets in cap_off
> +	 * array in pci_dev structure.
> +	 */

Comment is not needed if the function name is descriptive.

> +	pci_find_all_capabilities(dev);

And it is, so no need for the comment.

>  	set_pcie_port_type(dev);
>  
>  	pci_set_of_node(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..d221c73e67f8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -326,6 +326,7 @@ struct pci_dev {
>  	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
>  	u8		revision;	/* PCI revision, low byte of class word */
>  	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
> +	u8              cap_off[PCI_CAP_ID_MAX]; /* Offsets of all pci capabilities */

Did you run 'pahole' to ensure you are not adding extra padding bytes
here?

>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> @@ -1128,6 +1129,7 @@ void pci_sort_breadthfirst(void);
>  
>  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
>  u8 pci_find_capability(struct pci_dev *dev, int cap);
> +void pci_find_all_capabilities(struct pci_dev *dev);

Why is this now a global function and not one just local to the pci
core?  Who else would ever need to call it?

thanks,

greg k-h
