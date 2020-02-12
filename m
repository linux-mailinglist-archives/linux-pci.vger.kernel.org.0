Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6115B3B9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 23:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgBLWbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 17:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLWbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 17:31:36 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553FE21734;
        Wed, 12 Feb 2020 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581546695;
        bh=XZLsMgDRQN99NwlGx4tVdur3BW98DgmN7qNxFIqIhO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A+6M+QmjGNZYuFhvHOjbCVqvmbkdChNWLI9cLj75Ido9OjjMuPl2j5W67NtNIxEBN
         6XMfO/DnfLBW7dG6/SjCT1dgZa7KrAkf7Ep1b9TyusJT0HWKC4rhqJGcnOk4ckYqI8
         MxD1CSBuLTNO+iKwdr8prDHrchpBTQnHvQU1hC/k=
Date:   Wed, 12 Feb 2020 16:31:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com,
        huangdaode@huawei.com
Subject: Re: [PATCH v2] PCI: Make pci_bus_speed_strings[] public
Message-ID: <20200212223133.GA177061@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580986687-9644-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 06, 2020 at 06:58:07PM +0800, Yicong Yang wrote:
> pci_bus_speed_strings[] in slot.c defines universal speed information.
> Currently it is only used to decode bus speed in slot.c, while elsewhere
> use judgement statements repeatly to decode speed information. For
> example, in PCIE_SPEED2STR and current_link_speed_show() in sysfs.
> 
> Make it public and move to probe.c so that we can reuse it for decoding
> speed information in sysfs or dmesg log. Remove "PCIe" suffix of PCIe
> bus speed strings to reduce redundancy.
> 
> Add pci_bus_speed_strings_size for boundary check purpose, to avoid
> acquiring size of an external array by ARRAY_SIZE macro.
> 
> Link:https://lore.kernel.org/linux-pci/20200205183531.GA229621@google.com/
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> 
> change since v1:
> 1. split the patch from series as suggested

That's not what I said.  What I said was:

  This needs to say exactly where this change will be observed: /proc
  file, /sys file, dmesg, etc.  I would prefer that an observable
  change be in its own patch instead of being a by-product of a
  structural change like this one.

That means I want a tiny patch that changes the strings a user will
see and a specific example in the commit log to show what change the
user will see.  For example, if it were in sysfs the changelog could
say something like:

  -/sys/devices/pci0000:00/0000:00:1c.0/max_link_speed:8 GT/s PCIe
  +/sys/devices/pci0000:00/0000:00:1c.0/max_link_speed:8 GT/s

I still don't know exactly *where* the change is (it's not in sysfs; I
just made up the example above).  But something like the above would
tell me exactly what files are affected and what the change looks
like.  That's the information people would need to update programs
that parse the file.

And the patch itself should be something like:

  +       "8.0 GT/s",             /* 0x16 */
  -       "8.0 GT/s PCIe",        /* 0x16 */

*without* the code moving between files.  This patch is basically
identical to the first one [1] except that you made it separate from
the series.

This appears to change the strings *and* move them from slot.c to
probe.c.  Those are two different things, and putting them together in
one patch makes it harder for people to figure out what's changing.

There should be one patch that *only* changes the strings and another
that *only* moves them from slot.c to probe.c.

And I don't want them as separate patches *outside* the series.  That
just makes the series itself not apply correctly.  They should be *in*
the series so the whole thing applies cleanly on my "master" brance
(v5.6-rc1).

[1] https://lore.kernel.org/r/1579079063-5668-3-git-send-email-yangyicong@hisilicon.com

> 2. add pci_bus_speed_strings_size for boundary check in bus_speed_read()
> 
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/slot.c  | 31 +------------------------------
>  3 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6394e77..e6bcc06 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -12,6 +12,8 @@
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> 
>  extern const unsigned char pcie_link_speed[];
> +extern const char *pci_bus_speed_strings[];
> +extern const int pci_bus_speed_strings_size;
>  extern bool pci_early_dump;
> 
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb43..6ce47d8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -678,6 +678,36 @@ const unsigned char pcie_link_speed[] = {
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
> +const int pci_bus_speed_strings_size = ARRAY_SIZE(pci_bus_speed_strings);
> +
>  void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
>  {
>  	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index ae4aa0e..fb7c172 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -49,40 +49,11 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
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
> +	if (speed < pci_bus_speed_strings_size)
>  		speed_string = pci_bus_speed_strings[speed];
>  	else
>  		speed_string = "Unknown";
> --
> 2.8.1
> 
