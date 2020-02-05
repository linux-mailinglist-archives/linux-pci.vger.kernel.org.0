Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4325315387F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBESyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 13:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBESyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 13:54:49 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C90A214AF;
        Wed,  5 Feb 2020 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580928888;
        bh=gluyRShhWV7MUVWMFGR5oPnvaFvLOBbs1W1HSk3nqAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vul4b2ZVfTFd8XXQiF7s8qo28DvIFssRc2FIh7VdGVZ/xvP5VGvgsuUn2rmtzTtkO
         sTq+9/hsfrRA9C0hI3dhv3ursQrxAbfvJbTjpROBsYU8P+HmHo7IV6s4n+FdVt16KG
         PhFmud9JcSnSXmsCMD9EBKzgPvG656ruiQQALjZE=
Date:   Wed, 5 Feb 2020 12:54:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com
Subject: Re: [PATCH 5/6] PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
Message-ID: <20200205185446.GA231340@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579079063-5668-6-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:04:22PM +0800, Yicong Yang wrote:
> Add PCIE_LNKCAP2_SLS2SPEED macro for transforming raw link cap 2
> value to link speed. Use it in pcie_get_speed_cap() to reduce
> redundancy. We'll not touch the functions when new link
> speed comes.

The patch seems OK to me, but I don't see where it reduces redundancy.
There was one copy of "lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB" before,
and there's one copy after.  It's just moved from pci.c to pci.h.
Or am I missing something?

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pci.c | 17 ++++-------------
>  drivers/pci/pci.h |  9 +++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dce32ce..2ef4030 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5780,19 +5780,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>  	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
>  	 */
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
> -	if (lnkcap2) { /* PCIe r3.0-compliant */
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
> -	}
> +
> +	/* PCIe r3.0-compliant */
> +	if (lnkcap2)
> +		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
>  
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5e1f810..3d988e9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -290,6 +290,15 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
>  
> +/* PCIe link information from Link Capabilities 2 */
> +#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
> +	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
> +	 PCI_SPEED_UNKNOWN)
> +
>  /* PCIe link information */
>  #define PCI_SPEED2STR(speed) \
>  	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
> -- 
> 2.8.1
> 
