Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F902FF7F9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 23:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbhAUWca (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 17:32:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbhAUWcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 17:32:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 248C8239EF;
        Thu, 21 Jan 2021 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611268301;
        bh=EEf8rabDeI15xaIquULAh8d9pPh9A++4exLQ0e/ACdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=byN+jFdhb7bSBDjr2iwxHKQVRmnDYUmTvXjhAtxBXtU69FjhISlVnP4oNAYtj97cj
         NXzfaCIQmuADYionFEpJq0GgE//3I0lCbuaGUjhkzolNhA0DOLeb6e5ljwC/0sGnzD
         97bmLd+bNkXSsErv9j7P1uVSHhxKOaiye6hb9rGcZR2i4HWQhyHsOAA/ifLMElysbY
         ecWPlg3IDRo3xF6JZQ0069/lN7oNjDOeU7p6csPluvEcdVdAHRODGEU65IezLghgjW
         Goe6G83GUVziPEWEzHkr/KwTj7p251a8CF8jy0XhqxVkHO7n8Uq95xhxlO03QWbDcK
         7pn+rHxWhNJEA==
Date:   Thu, 21 Jan 2021 16:31:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        linux-pci@vger.kernel.org, mingchuang.qiao@mediatek.com,
        matthias.bgg@gmail.com, lambert.wang@mediatek.com,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Re-enable downstream port LTR if it was
 previously enabled
Message-ID: <20210121223139.GA2698934@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119131410.27528-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex and Mingchuang et al from
https://lore.kernel.org/r/20210112072739.31624-1-mingchuang.qiao@mediatek.com]

On Tue, Jan 19, 2021 at 04:14:10PM +0300, Mika Westerberg wrote:
> PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
> LTR enable bit if the link goes down (port goes DL_Down status). Now, if
> we had LTR previously enabled and the PCIe endpoint gets hot-removed and
> then hot-added back the ->ltr_path of the downstream port is still set
> but the port now does not have the LTR enable bit set anymore.
> 
> For this reason check if the bridge upstream had LTR enabled previously
> and re-enable it before enabling LTR for the endpoint.
> 
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I think this and Mingchuang's patch, which is essentially identical,
are right and solves the problem for hot-remove/hot-add.  In that
scenario we call pci_configure_ltr() on the hot-added device, and
with this patch, we'll re-enable LTR on the bridge leading to the new
device before enabling LTR on the new device itself.

But don't we have a similar problem if we simply do a Fundamental
Reset on a device?  I think the reset path will restore the device's
state, including PCI_EXP_DEVCTL2, but it doesn't do anything with the
upstream bridge, does it?

So if a bridge and a device below it both have LTR enabled, can't we
have the following:

  - bridge LTR enabled
  - device LTR enabled
  - reset device, e.g., via Secondary Bus Reset
  - link goes down, bridge disables LTR
  - link comes back up, LTR disabled in both bridge and device
  - restore device state, including LTR enable
  - device sends LTR message
  - bridge reports Unsupported Request

> ---
> Previous version can be found here:
> 
>   https://lore.kernel.org/linux-pci/20210114134724.79511-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Corrected typos in the commit message
>   * No need to call pcie_downstream_port()
> 
>  drivers/pci/probe.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0eb68b47354f..a4a8c0305fb9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2153,7 +2153,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCIEASPM
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> -	struct pci_dev *bridge;
> +	struct pci_dev *bridge = NULL;
>  	u32 cap, ctl;
>  
>  	if (!pci_is_pcie(dev))
> @@ -2191,6 +2191,21 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>  	    ((bridge = pci_upstream_bridge(dev)) &&
>  	      bridge->ltr_path)) {
> +		/*
> +		 * Downstream ports reset the LTR enable bit when the
> +		 * link goes down (e.g on hot-remove) so re-enable the
> +		 * bit here if not set anymore.
> +		 * PCIe r5.0, sec 7.5.3.16.
> +		 */
> +		if (bridge) {
> +			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
> +			if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
> +				pci_dbg(bridge, "re-enabling LTR\n");
> +				pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> +							 PCI_EXP_DEVCTL2_LTR_EN);
> +			}
> +		}
> +		pci_dbg(dev, "enabling LTR\n");
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> -- 
> 2.29.2
> 
