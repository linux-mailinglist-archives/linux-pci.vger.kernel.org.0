Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D392E26E757
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIQVYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQVYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:24:36 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FE6206BE;
        Thu, 17 Sep 2020 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600377876;
        bh=dl73Cr1XOOSVh9GU3wBIplx858mHA88k2Tec02O/9XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l/mXdjffboynn7vtuOn2h+dA3x4LmHp+1uC1Hj+7IvIJb9D40H3vGvTG1UD3IvjmX
         NPTeVS5T0fLgVNFnEi8t5zdcRM/t2OSuXSgvpvLDi4WaYWa2r4b8r0LEvA2M76BwrL
         zm7xqaizW9gMmaTdSfF+i0cfaTktpA95iisupjjc=
Date:   Thu, 17 Sep 2020 16:24:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Reduce noisiness on hot removal
Message-ID: <20200917212434.GA1736630@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45e46fd8a6aa6930aaac9d7718c2e4b787a4e5e.1595935071.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 01:24:10PM +0200, Lukas Wunner wrote:
> When a PCIe card is hot-removed, the Presence Detect State and Data Link
> Layer Link Active bits often do not clear simultaneously.  I've seen
> delays of up to 244 msec between the two events with Thunderbolt.
> 
> After pciehp has brought down the slot in response to the first event,
> the other bit may still be set.  It's not discernible whether it's set
> because a new card is already in the slot or if it will soon clear.
> So pciehp tries to bring up the slot and in the latter case fails with
> a bunch of messages, some of them at KERN_ERR severity.  The messages
> are false positives if the slot is no longer occupied and annoy users.
> 
> Stuart Hayes reports the following splat on hot removal:
> 
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Timeout waiting for Presence Detect
> KERN_ERR  pcieport 0000:3c:06.0: pciehp: link training error: status 0x0001
> KERN_ERR  pcieport 0000:3c:06.0: pciehp: Failed to check link status
> 
> Dongdong Liu complains about a similar splat:
> 
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
> KERN_INFO iommu: Removing device 0000:87:00.0 from group 12
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> KERN_INFO pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
> KERN_ERR  pciehp 0000:80:10.0:pcie004: Failed to check link status
> 
> Users are particularly irritated to see a bringup attempt even though
> the slot was explicitly brought down via sysfs.  In a perfect world, we
> could avoid this by setting Link Disable on slot bringdown and
> re-enabling it upon a Presence Detect State change.  In reality however,
> there are broken hotplug ports which hardwire Presence Detect to zero,
> see 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired to
> zero").  Conversely, PCIe r1.0 hotplug ports hardwire Link Active to
> zero because Link Active Reporting wasn't specified before PCIe r1.1.
> On unplug, some ports first clear Presence then Link (see Stuart Hayes'
> splat) whereas others use the inverse order (see Dongdong Liu's splat).
> To top it off, there are hotplug ports which flap the Presence and Link
> bits on slot bringup, see 6c35a1ac3da6 ("PCI: pciehp: Tolerate initially
> unstable link").
> 
> pciehp is designed to work with all of these variants.  Surplus attempts
> at slot bringup are a lesser evil than not being able to bring up slots
> at all.  Although we could try to perfect the behavior for specific
> hotplug controllers, we'd risk breaking others or increasing code
> complexity.
> 
> But we can certainly minimize annoyance by emitting only a single
> message with KERN_INFO severity if bringup is unsuccessful:
> 
> * Drop the "Timeout waiting for Presence Detect" message in
>   pcie_wait_for_presence().  The sole caller of that function,
>   pciehp_check_link_status(), ignores the timeout and carries on.
>   It emits error messages of its own and I don't think this particular
>   message adds much value.
> 
> * There's a single error condition in pciehp_check_link_status() which
>   does not emit a message.  Adding one allows dropping the "Failed to
>   check link status" message emitted by board_added() if
>   pciehp_check_link_status() returns a non-zero integer.
> 
> * Tone down all messages in pciehp_check_link_status() to KERN_INFO
>   severity and rephrase them to look as innocuous as possible.  To this
>   end, move the message emitted by pcie_wait_for_link_delay() to its
>   callers.
> 
> As a result, Stuart Hayes' splat becomes:
> 
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Cannot train link: status 0x0001
> 
> Dongdong Liu's splat becomes:
> 
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): No link
> 
> The messages now merely serve as information that presence or link bits
> were set a little longer than expected.  Bringup failures which are not
> false positives are still reported, albeit no longer at KERN_ERR
> severity.
> 
> Link: https://lore.kernel.org/linux-pci/20200310182100.102987-1-stuart.w.hayes@gmail.com/
> Link: https://lore.kernel.org/linux-pci/1547649064-19019-1-git-send-email-liudongdong3@huawei.com/
> Reported-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reported-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v5.10, thanks!

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c |  4 +---
>  drivers/pci/hotplug/pciehp_hpc.c  | 15 +++++++++------
>  drivers/pci/pci.c                 |  5 ++---
>  drivers/pci/pcie/dpc.c            |  7 +++++--
>  4 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 6503d15effbbd..2f5f4bb42dcc6 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -73,10 +73,8 @@ static int board_added(struct controller *ctrl)
>  
>  	/* Check link training status */
>  	retval = pciehp_check_link_status(ctrl);
> -	if (retval) {
> -		ctrl_err(ctrl, "Failed to check link status\n");
> +	if (retval)
>  		goto err_exit;
> -	}
>  
>  	/* Check for a power fault */
>  	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 53433b37e1812..fb3840e222add 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -283,8 +283,6 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
>  		msleep(10);
>  		timeout -= 10;
>  	} while (timeout > 0);
> -
> -	pci_info(pdev, "Timeout waiting for Presence Detect\n");
>  }
>  
>  int pciehp_check_link_status(struct controller *ctrl)
> @@ -293,8 +291,10 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	bool found;
>  	u16 lnk_status;
>  
> -	if (!pcie_wait_for_link(pdev, true))
> +	if (!pcie_wait_for_link(pdev, true)) {
> +		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
>  		return -1;
> +	}
>  
>  	if (ctrl->inband_presence_disabled)
>  		pcie_wait_for_presence(pdev);
> @@ -311,15 +311,18 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>  	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
>  	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
> -		ctrl_err(ctrl, "link training error: status %#06x\n",
> -			 lnk_status);
> +		ctrl_info(ctrl, "Slot(%s): Cannot train link: status %#06x\n",
> +			  slot_name(ctrl), lnk_status);
>  		return -1;
>  	}
>  
>  	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
>  
> -	if (!found)
> +	if (!found) {
> +		ctrl_info(ctrl, "Slot(%s): No device found\n",
> +			  slot_name(ctrl));
>  		return -1;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 501035cc0409e..f369934867a06 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4702,9 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  	}
>  	if (active && ret && delay)
>  		msleep(delay);
> -	else if (ret != active)
> -		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> -			active ? "set" : "cleared");
> +
>  	return ret == active;
>  }
>  
> @@ -4838,6 +4836,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  		pci_dbg(dev, "waiting for link to train\n");
>  		if (!pcie_wait_for_link_delay(dev, true, 0)) {
>  			/* Did not train, no need to wait any further */
> +			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
>  			return;
>  		}
>  	}
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index daa9a4153776c..e05aba86a3179 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -103,7 +103,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	 * Wait until the Link is inactive, then clear DPC Trigger Status
>  	 * to allow the Port to leave DPC.
>  	 */
> -	pcie_wait_for_link(pdev, false);
> +	if (!pcie_wait_for_link(pdev, false))
> +		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>  
>  	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>  		return PCI_ERS_RESULT_DISCONNECT;
> @@ -111,8 +112,10 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);
>  
> -	if (!pcie_wait_for_link(pdev, true))
> +	if (!pcie_wait_for_link(pdev, true)) {
> +		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
>  		return PCI_ERS_RESULT_DISCONNECT;
> +	}
>  
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
> -- 
> 2.27.0
> 
