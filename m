Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C90497D3D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 11:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiAXKfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 05:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiAXKfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 05:35:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC22C06173B;
        Mon, 24 Jan 2022 02:35:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BA652CE1084;
        Mon, 24 Jan 2022 10:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B8C340E1;
        Mon, 24 Jan 2022 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643020509;
        bh=4DW+brPdZos02wxjXVsOUcvneTuVQw0JJNkmVqyY/VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRev4780I1jkQoy4By4NlAYN0dfeX1CgpypbsoanFqV2ZffzOPxiGk1pj7SQQjal5
         L4xvzrRP1vIP/BRCYr03DPVj+d+8qjG7gcoc2HpM7rA1s/F/kDhlLIYPt37uQgFiTs
         rcH64RTKpESXdHxvAqql85mTf0rpxnzIcY0uNVRs=
Date:   Mon, 24 Jan 2022 11:35:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vikash Bansal <bvikas@vmware.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com, srinidhir@vmware.com,
        anishs@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com
Subject: Re: [PATCH v2] PCI: Speed up device init by parsing capabilities all
 at once
Message-ID: <Ye6A2uB/zX5GaliR@kroah.com>
References: <1642881286-31024-1-git-send-email-bvikas@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642881286-31024-1-git-send-email-bvikas@vmware.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 22, 2022 at 11:54:46AM -0800, Vikash Bansal wrote:
> In the current implementation, the PCI capability list is parsed from
> the beginning to find each capability, which results in a large number
> of redundant PCI reads.
> 
> Instead, we can parse the complete list just once, store it in the
> pci_dev structure, and get the offset of each capability directly from
> the pci_dev structure.
> 
> This implementation improves pci devices initialization time  by ~2-3%
> (from 270ms to 261ms) in case of bare metal and 7-8% (From 201ms to 184ms)
> in case of VM running on ESXi.
> 
> It also adds a memory overhead of 20bytes (value of PCI_CAP_ID_MAX) per
> PCI device.
> 
> Run pahole for pci_dev structure. This patch is not adding any padding
> bytes.
> 
> Signed-off-by: Vikash Bansal <bvikas@vmware.com>
> ---
>  drivers/pci/pci.c   | 43 ++++++++++++++++++++++++++++++++++++-------
>  drivers/pci/probe.c |  1 +
>  include/linux/pci.h |  2 ++
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..b361788bcc27 100644
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
> +			break;
> +		pos &= ~3;
> +		pci_bus_read_config_word(dev->bus, dev->devfn, pos, &ent);
> +		id = ent & 0xff;
> +		if (id == 0xff)
> +			break;
> +
> +		/* Read first instance of capability */
> +		if (!(dev->cap_off[id]))
> +			dev->cap_off[id] = pos;
> +		pos = (ent >> 8);
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
> index 17a969942d37..b2fa5b2c42f6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1831,6 +1831,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->hdr_type = hdr_type & 0x7f;
>  	dev->multifunction = !!(hdr_type & 0x80);
>  	dev->error_state = pci_channel_io_normal;
> +	pci_find_all_capabilities(dev);
>  	set_pcie_port_type(dev);
>  
>  	pci_set_of_node(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8253a5413d7c..abcf7fdc4c98 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -335,6 +335,7 @@ struct pci_dev {
>  	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
>  	u8		revision;	/* PCI revision, low byte of class word */
>  	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
> +	u8              cap_off[PCI_CAP_ID_MAX]; /* Offsets of all pci capabilities */
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> @@ -1140,6 +1141,7 @@ void pci_sort_breadthfirst(void);
>  
>  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
>  u8 pci_find_capability(struct pci_dev *dev, int cap);
> +void pci_find_all_capabilities(struct pci_dev *dev);
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>  u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
> -- 
> 2.30.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
