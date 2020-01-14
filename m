Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC95713B576
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 23:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgANWtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 17:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgANWtN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 17:49:13 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B8A24658;
        Tue, 14 Jan 2020 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579042151;
        bh=USH4cDaTFMq1G14orlJyfFDl9RLVgu9Ieb4nlkJjpLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HM/8NEAbYvuXXJi+ZdC9VR+D5JSMZAJ2GXoPm44fW78gFLwJdKUO7OswY7kXYM0NH
         UiBMsiI4eMhwgDtPvxRQUPtqXF9pX8rvIAXvkNlAG8fkKGmmgQUjQnvlf3iA3TRRPH
         VymBHQpUUyjvRX2baoA8M2UMtvWWRZHbA2qklMTA=
Date:   Tue, 14 Jan 2020 16:49:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com
Subject: Re: [PATCH] PCI: Improve link speed presentation process
Message-ID: <20200114224909.GA19633@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578989494-20583-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 04:11:34PM +0800, Yicong Yang wrote:
> Currently We use switch-case statements to acquire the speed
> string according to the pci bus speed in current_link_speed_show()
> and pcie_get_speed_cap(). It leads to redundant and when new
> standard comes, we have to add cases in the related functions,
> which is easy to omit at somewhere.
> 
> Abstract the judge statements out. Use macros and pci speed
> arrays instead. Then only the macros and arrays need to be
> extended when next generation comes.
> 
> Link: https://lore.kernel.org/linux-pci/20200113211728.GA113776@google.com/
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Previously we get speed from sysfs likes "16.0 GT/s", etc. In this PATCH,
> we get the speed string from pci_bus_speed_strings[], and it'll look like
> "16.0 GT/s PCIe", etc. It makes no more affects and maybe make the information
> more detailed.

I like the direction this is heading a lot.

It'll be a little redundant in __pcie_print_link_status(), e.g.,

  - nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:01.1 (capable of 31.504 Gb/s with 8 GT/s x4 link)
  + nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s PCIe x4 link at 0000:00:01.1 (capable of 31.504 Gb/s with 8 GT/s PCIe x4 link)

Prior to this patch, the strings containing "PCIe" are only in
bus_speed_read(), i.e., only for PCI slot "cur_bus_speed" and
"max_bus_speed" sysfs files for slots.  I'm not sure "PCIe" really
adds anything there -- I would think the question for a PCIe slot is
"how fast is it *and* how wide is it?"  That's what people need to
know when selecting a slot to plug a card into.

But I think we can defer the sysfs file question and keep all the
user-visible strings the same by removing "PCIe" from the
pci_bus_speed_strings[] and sprintf-ing it back in (when appropriate)
in bus_speed_read().

This patch both (a) removes a lot of redundancy and (b) adds 32 GT/s
in a couple places.  Those should be split: one patch should add 32
GT/s (this is probably just the first version you posted), and a
second patch should combine the strings.

That way the 32 GT/s change isn't buried in a big patch, and if the
string change ("16.0 GT/s" -> "16.0 GT/s PCIe") is in a patch by
itself that we can easily revert if it turns out to be a problem.

Side note: can you add a comment at the pcie_link_speed[] definition
about the index being the Current Link Speed field?  Maybe also a note
at the pcix_bus_speed[] definition (the index is the "Secondary Bus
Mode and Frequency" from the PCI-X Secondary Status Register in the
PCI-X Bridge Capability.

>  drivers/pci/pci-sysfs.c | 24 +++---------------------
>  drivers/pci/pci.c       | 12 +-----------
>  drivers/pci/pci.h       | 20 ++++++++++++++------
>  drivers/pci/slot.c      |  2 +-
>  4 files changed, 19 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7934129..8bcb136 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -175,33 +175,15 @@ static ssize_t current_link_speed_show(struct device *dev,
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	u16 linkstat;
>  	int err;
> -	const char *speed;
> +	enum pci_bus_speed link_speed;
>  
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
>  	if (err)
>  		return -EINVAL;
>  
> -	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> -	case PCI_EXP_LNKSTA_CLS_32_0GB:
> -		speed = "32 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_16_0GB:
> -		speed = "16 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_8_0GB:
> -		speed = "8 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_5_0GB:
> -		speed = "5 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_2_5GB:
> -		speed = "2.5 GT/s";
> -		break;
> -	default:
> -		speed = "Unknown speed";
> -	}
> +	link_speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
>  
> -	return sprintf(buf, "%s\n", speed);
> +	return sprintf(buf, "%s\n", PCIE_SPEED2STR(link_speed));
>  }
>  static DEVICE_ATTR_RO(current_link_speed);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e257..ea72e6d8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5658,17 +5658,7 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>  	 */
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  	if (lnkcap2) { /* PCIe r3.0-compliant */
> -		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
> -			return PCIE_SPEED_32_0GT;
> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
> -			return PCIE_SPEED_16_0GT;
> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
> -			return PCIE_SPEED_8_0GT;
> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
> -			return PCIE_SPEED_5_0GT;
> -		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
> -			return PCIE_SPEED_2_5GT;
> -		return PCI_SPEED_UNKNOWN;
> +		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
>  	}

Remove the braces since there's only one line left.

>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947e..90cacf6 100644
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
> @@ -286,17 +287,24 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
>  
> +/* PCIe link information from Link Capabilities 2 */
> +#define PCIE_LNKCAP2_SLS2SPEED(mask) \
> +	((mask) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
> +	 (mask) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
> +	 (mask) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
> +	 (mask) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
> +	 (mask) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
> +	 PCI_SPEED_UNKNOWN)

The argument here is not really a "mask"; it's the entire LNKCAP2
value.  I'd call it "lnkcap2" so it's a hint about what callers should
pass.

>  /* PCIe link information */
>  #define PCIE_SPEED2STR(speed) \
> -	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
> -	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
> -	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
> -	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
> -	 "Unknown speed")
> +	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
> +	 pci_bus_speed_strings[speed])

I think this will be a problem because pci_bus_speed_strings[] is
defined in slot.c, which is only built when CONFIG_SYSFS=y.  But
PCIE_SPEED2STR() is used by __pcie_print_link_status(), which can be
built without CONFIG_SYSFS=y.  Maybe a preliminary patch could move
pci_bus_speed_strings[] to probe.c, near the related pcix_bus_speed[]
and pcie_link_speed[]?

Also, bus_speed_read() contains what is basically an open-coded
PCIE_SPEED2STR(), except that bus_speed_read() does a bounds check.
I think we should maybe add that bounds check to PCIE_SPEED2STR() and
use it in bus_speed_read().

So I'm envisioning several patches here:

  - Add 32 GT/s to PCIE_SPEED2STR() and PCIE_SPEED2MBS_ENC() (your
    original patch).

  - Move pci_bus_speed_strings[] to probe.c.  No change at all except
    to become non-static.

  - Change PCIE_SPEED2STR() to use pci_bus_speed_strings[] and add
    bounds checking, remove "PCIe" from pci_bus_speed_strings[], use
    PCI_SPEED2STR() and add "PCIe" back in bus_speed_read().

  - Rename PCIE_SPEED2STR() to PCI_SPEED2STR().  Could be squashed
    with above, but keep it separate to start; I can trivially squash
    if it makes sense.

  - Add PCIE_LNKCAP2_SLS2SPEED() and use it in pcie_get_speed_cap().
    Separate patch because it's not related to the strings.

>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> -	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
> +	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
> +	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
>  	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index ae4aa0e..08a59ed 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -50,7 +50,7 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  }
>  
>  /* these strings match up with the values in pci_bus_speed */
> -static const char *pci_bus_speed_strings[] = {
> +const char *pci_bus_speed_strings[] = {
>  	"33 MHz PCI",		/* 0x00 */
>  	"66 MHz PCI",		/* 0x01 */
>  	"66 MHz PCI-X",		/* 0x02 */
> -- 
> 2.8.1
> 
