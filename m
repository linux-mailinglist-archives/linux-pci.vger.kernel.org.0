Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A00153839
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgBESff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 13:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgBESff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 13:35:35 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8B920674;
        Wed,  5 Feb 2020 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580927733;
        bh=qqyLEPFXS6X0u88vB5x1VZb95nZKPBxaaGd0R3sT/C0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b7FKTqqHY+D/2me0M9aNSxe9AF80rJwVGDdDn5jXBVuNFAJfjaMZz9hz+W3Rw6WJt
         O0LNCDsvJRh20/zuhSxZcAGDcT3uExFkLjG1QysvUF0svuQBcG2fduMQVCf1T9YEEc
         hwtbLHimq7HId3lf2eWcUdBe3b414AhaPLsecBFc=
Date:   Wed, 5 Feb 2020 12:35:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com
Subject: Re: [PATCH 2/6] PCI: Make pci_bus_speed_strings[] public
Message-ID: <20200205183531.GA229621@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579079063-5668-3-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:04:19PM +0800, Yicong Yang wrote:
> pci_bus_speed_strings[] in slot.c defines universal speed information.
> Make it public and move to probe.c so that we can use it. Remove "PCIe"
> suffix of PCIe bus speed strings to reduce redundancy.

This needs to say exactly where this change will be observed: /proc
file, /sys file, dmesg, etc.  I would prefer that an observable change
be in its own patch instead of being a by-product of a structural
change like this one.

> Use PCI_SPEED_UNKNOWN to judge the unknown speed condition in
> bus_speed_read() in slot.c, as we cannot get array size from an external
> array.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> 
> The reason why I don't add a boundary check is illustrated in Patch_4
> 
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
>  drivers/pci/slot.c  | 35 +++--------------------------------
>  3 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a88c316..5fb1d76 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -9,6 +9,7 @@
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> 
>  extern const unsigned char pcie_link_speed[];
> +extern const char *pci_bus_speed_strings[];
>  extern bool pci_early_dump;
> 
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb43..3c70b87 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -678,6 +678,35 @@ const unsigned char pcie_link_speed[] = {
>  	PCI_SPEED_UNKNOWN		/* F */
>  };
> 
> +/* these strings match up with the values in pci_bus_speed */
> +const char *pci_bus_speed_strings[] = {
> +	"33 MHz PCI",		/* 0x00 */
> +	"66 MHz PCI",		/* 0x01 */
> +	"66 MHz PCI-X",		/* 0x02 */
> +	"100 MHz PCI-X",	/* 0x03 */
> +	"133 MHz PCI-X",	/* 0x04 */
> +	NULL,			/* 0x05 */
> +	NULL,			/* 0x06 */
> +	NULL,			/* 0x07 */
> +	NULL,			/* 0x08 */
> +	"66 MHz PCI-X 266",	/* 0x09 */
> +	"100 MHz PCI-X 266",	/* 0x0a */
> +	"133 MHz PCI-X 266",	/* 0x0b */
> +	"Unknown AGP",		/* 0x0c */
> +	"1x AGP",		/* 0x0d */
> +	"2x AGP",		/* 0x0e */
> +	"4x AGP",		/* 0x0f */
> +	"8x AGP",		/* 0x10 */
> +	"66 MHz PCI-X 533",	/* 0x11 */
> +	"100 MHz PCI-X 533",	/* 0x12 */
> +	"133 MHz PCI-X 533",	/* 0x13 */
> +	"2.5 GT/s",	/* 0x14 */
> +	"5.0 GT/s",	/* 0x15 */
> +	"8.0 GT/s",	/* 0x16 */
> +	"16.0 GT/s",	/* 0x17 */
> +	"32.0 GT/s",	/* 0x18 */
> +};
> +
>  void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
>  {
>  	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index ae4aa0e..140dafb 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -49,43 +49,14 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  				slot->number);
>  }
> 
> -/* these strings match up with the values in pci_bus_speed */
> -static const char *pci_bus_speed_strings[] = {
> -	"33 MHz PCI",		/* 0x00 */
> -	"66 MHz PCI",		/* 0x01 */
> -	"66 MHz PCI-X",		/* 0x02 */
> -	"100 MHz PCI-X",	/* 0x03 */
> -	"133 MHz PCI-X",	/* 0x04 */
> -	NULL,			/* 0x05 */
> -	NULL,			/* 0x06 */
> -	NULL,			/* 0x07 */
> -	NULL,			/* 0x08 */
> -	"66 MHz PCI-X 266",	/* 0x09 */
> -	"100 MHz PCI-X 266",	/* 0x0a */
> -	"133 MHz PCI-X 266",	/* 0x0b */
> -	"Unknown AGP",		/* 0x0c */
> -	"1x AGP",		/* 0x0d */
> -	"2x AGP",		/* 0x0e */
> -	"4x AGP",		/* 0x0f */
> -	"8x AGP",		/* 0x10 */
> -	"66 MHz PCI-X 533",	/* 0x11 */
> -	"100 MHz PCI-X 533",	/* 0x12 */
> -	"133 MHz PCI-X 533",	/* 0x13 */
> -	"2.5 GT/s PCIe",	/* 0x14 */
> -	"5.0 GT/s PCIe",	/* 0x15 */
> -	"8.0 GT/s PCIe",	/* 0x16 */
> -	"16.0 GT/s PCIe",	/* 0x17 */
> -	"32.0 GT/s PCIe",	/* 0x18 */
> -};
> -
>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
>  {
>  	const char *speed_string;
> 
> -	if (speed < ARRAY_SIZE(pci_bus_speed_strings))
> -		speed_string = pci_bus_speed_strings[speed];
> -	else
> +	if (speed == PCI_SPEED_UNKNOWN)
>  		speed_string = "Unknown";
> +	else
> +		speed_string = pci_bus_speed_strings[speed];

This is a little bit problematic because previously we checked the
actual array index but here we don't, so we may not index past the end
of the array.

It's possible to specify the array size explicitly in the extern
declaration, and I *think* that might mean ARRAY_SIZE() would still
work.  It's not ideal to have to update the extern declaration when
adding speeds, but at least it's something that would be noticed by
even the most trivial testing.

>  	return sprintf(buf, "%s\n", speed_string);
>  }
> --
> 2.8.1
> 
