Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B84A7A8A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 22:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbiBBVf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 16:35:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40650 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiBBVfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 16:35:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1FE0B8311B;
        Wed,  2 Feb 2022 21:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2975AC004E1;
        Wed,  2 Feb 2022 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643837752;
        bh=7kN0xNUmp6IHM12aVfs0hbWaqrbS1EUbii1ez3Z24rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lsiVPiXb0D2xVnrJyDkYfplL4ZJ8EW6Ay2wVGBs4H9V/1p/ohfIBig4JHd2Lo5pF7
         +tSoeF8mGTmzU5EyxTVv7NmglsDQSxjbv9YfvmOodW7LFqrRcU0Gf1d9cQgKJI+6Go
         CMBORGpZPGKvtfLO60scEJCNOOLL36d5Je8BzCfJzsmLBFTaATnurgIwSIJXAysh/1
         J2katS3g8zodXIqf3KlUjSQBXWgmKTWN8tS753H7p5Tv8HLg6A2l5syIeKXhnIFBp0
         PVe/GLmGoJ6qF5Z0Rs3UDI7e7GEcZC5k6md3RJ3pRGHt36qIIraH0+F0MjmT/gvpSK
         KFS9AThjS3hOQ==
Date:   Wed, 2 Feb 2022 15:35:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vikash Bansal <bvikas@vmware.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v2] PCI: Speed up device init by parsing capabilities all
 at once
Message-ID: <20220202213550.GA44337@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A631B59-B3BD-4B3C-9DDD-795B7843333B@vmware.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 04:51:43AM +0000, Vikash Bansal wrote:
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
> Ran pahole for pci_dev structure. This patch is not adding any padding
> bytes.

I like the idea of this.

I guess the corresponding thing could be done for extended
capabilities as well, but they're not as common, there are more of
them, and maybe the benefit wouldn't be worth it.

More comments below.

> Signed-off-by: Vikash Bansal <bvikas@vmware.com>
> ---
> 
> Changes in v2:
>   - Ran pahole tool.
>   - Modified comments to add "clock time".
>   - Removed comments before call to pci_find_all_capabilities.
> 
> drivers/pci/pci.c   | 43 ++++++++++++++++++++++++++++++++++++-------
> drivers/pci/probe.c |  1 +
> include/linux/pci.h |  2 ++
> 3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..b361788bcc27 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -468,6 +468,41 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
> 	return 0;
> }
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

With the current capability infrastructure, one has to specify the
capability of interest up front, so there's no way to iterate directly
through all the capabilities.  Hence this code that looks a lot like
__pci_find_next_cap_ttl(), which knows the capability to look for and
ignores any others.

> +
> /**
>   * pci_find_capability - query for devices' capabilities
>   * @dev: PCI device to query
> @@ -489,13 +524,7 @@ static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
>   */
> u8 pci_find_capability(struct pci_dev *dev, int cap)
> {
> -	u8 pos;
> -
> -	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
> -	if (pos)
> -		pos = __pci_find_next_cap(dev->bus, dev->devfn, pos, cap);
> -
> -	return pos;
> +	return dev->cap_off[cap];

This may index past the end of the cap_off[] table.  We have no
control over the callers, so no way to prevent them from reading
arbitrary memory here.

Here's an alternate proposal:

  - Leave pci_find_capability() completely alone.

  - Don't add the cap_off[] table.  This only works for Capabilities
    (not Extended Capabilities), depends on PCI_CAP_ID_MAX (which is
    not fixed and could change in the future), and duplicates existing
    data like dev->pcie_cap, dev->msi_cap, dev->msix_cap, etc.

  - Add pci_find_all_capabilities() (I'd probably call it
    "pci_scan_capabilities()"), but extend it to iterate through both
    kinds of capabilities (probably a helper function for each kind)
    and fill in dev->pcie_cap, dev->msi_cap, dev->aer_cap, etc as it
    finds them.

  - Follow up with patches that remove calls to pci_find_capability()
    and pci_find_ext_capability() for the capabilities we've already
    located.

> }
> EXPORT_SYMBOL(pci_find_capability);
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..b2fa5b2c42f6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1831,6 +1831,7 @@ int pci_setup_device(struct pci_dev *dev)
> 	dev->hdr_type = hdr_type & 0x7f;
> 	dev->multifunction = !!(hdr_type & 0x80);
> 	dev->error_state = pci_channel_io_normal;
> +	pci_find_all_capabilities(dev);
> 	set_pcie_port_type(dev);
> 
> 	pci_set_of_node(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8253a5413d7c..abcf7fdc4c98 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -335,6 +335,7 @@ struct pci_dev {
> 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
> 	u8		revision;	/* PCI revision, low byte of class word */
> 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
> +	u8              cap_off[PCI_CAP_ID_MAX]; /* Offsets of all pci capabilities */
> #ifdef CONFIG_PCIEAER
> 	u16		aer_cap;	/* AER capability offset */
> 	struct aer_stats *aer_stats;	/* AER stats for this device */
> @@ -1140,6 +1141,7 @@ void pci_sort_breadthfirst(void);
> 
> u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
> u8 pci_find_capability(struct pci_dev *dev, int cap);
> +void pci_find_all_capabilities(struct pci_dev *dev);

Shouldn't be exposed outside drivers/pci/; could move to
drivers/pci/pci.h.

> u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
> u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
> u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
> --
> 2.30.0
> 
