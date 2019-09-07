Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1BAC7CA
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395015AbfIGQ4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 12:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394999AbfIGQ4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 12:56:17 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4E721835;
        Sat,  7 Sep 2019 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567875376;
        bh=ovoIkw3qvCktRFEwYzGK55+gjHN7HNorMjR1NIPKGlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jow6E0Mi1fFHMzgplTOPfR9T5/Im8/Ntqosoyztd07Z1oJ5gB+9D5dxScFglqCj5Z
         JT1CZD6P2eOJBGaRCU+7wGsB1xL55IOTRzg1s6RmzlpEnR4nOJXyCPXnr/wp4iU1lY
         FCl4VnNPty2BT9x9nLBu2fh9Hq6E6KGp3sKKgpBk=
Date:   Sat, 7 Sep 2019 11:56:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stefan.maetje@esd.eu, Patrick Talbert <ptalbert@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Robert White <rwhite@pobox.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Get rid of dev->has_secondary_link flag
Message-ID: <20190907165613.GP103977@google.com>
References: <20190822085553.62697-1-mika.westerberg@linux.intel.com>
 <20190822085553.62697-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822085553.62697-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 11:55:53AM +0300, Mika Westerberg wrote:
> In order to solve a problem on a system where PCIe switch upstream port
> incorrectly identifies itself as downstream port commit d0751b98dfa3
> ("PCI: Add dev->has_secondary_link to track downstream PCIe links")
> introduced a flag to struct pci_dev that can be used to determine which
> side of the port the link is.
> 
> The problem with this approach is that each time caller wants to
> determine whether the port is upstream or downstream, it may need to
> look at the dev->has_secondary_link as well. Making the calling code
> unnecessary complicated.
> 
> Instead of this, we can correct the type of the port itself so that
> pci_pcie_type() returns the actual type regardless of what the port
> claims it is. Then update the users to call pci_pcie_type() and
> pcie_downstream_port() accordingly.
> 
> This allows us to remove dev->has_secondary_flag completely.
> 
> Link: https://lore.kernel.org/linux-pci/20190703133953.GK128603@google.com/
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> I haven't been able to test this properly since I don't have access to any
> system having the issue. I tried on a couple of systems without the issue
> and did not see any problems, though.
> 
> @Robert, as the reporter of the original issue if you still have access to
> any of these systems I would appreciate if you could give this patch series
> a try.
> 
>  drivers/pci/pci.c       |  2 +-
>  drivers/pci/pcie/aspm.c |  8 +++----
>  drivers/pci/pcie/err.c  |  2 +-
>  drivers/pci/probe.c     | 48 ++++++++++++++++++++++++-----------------
>  drivers/pci/vc.c        |  4 +++-
>  include/linux/pci.h     |  1 -
>  6 files changed, 37 insertions(+), 28 deletions(-)

Very nice, thanks for doing this!

Applied to pci/enumeration for v5.4.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ac50710f1d4..3c0672f1dfe7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3577,7 +3577,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  		}
>  
>  		/* Ensure upstream ports don't block AtomicOps on egress */
> -		if (!bridge->has_secondary_link) {
> +		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
>  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
>  						   &ctl2);
>  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 464f8f92653f..2776d34be693 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -913,10 +913,10 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  
>  	/*
>  	 * We allocate pcie_link_state for the component on the upstream
> -	 * end of a Link, so there's nothing to do unless this device has a
> -	 * Link on its secondary side.
> +	 * end of a Link, so there's nothing to do unless this device is
> +	 * downstream port.
>  	 */
> -	if (!pdev->has_secondary_link)
> +	if (!pcie_downstream_port(pdev))
>  		return;
>  
>  	/* VIA has a strange chipset, root port is under a bridge */
> @@ -1070,7 +1070,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (!pci_is_pcie(pdev))
>  		return 0;
>  
> -	if (pdev->has_secondary_link)
> +	if (pcie_downstream_port(pdev))
>  		parent = pdev;
>  	if (!parent || !parent->link_state)
>  		return -EINVAL;
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 773197a12568..b0e6048a9208 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -166,7 +166,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
>  	driver = pcie_port_find_service(dev, service);
>  	if (driver && driver->reset_link) {
>  		status = driver->reset_link(dev);
> -	} else if (dev->has_secondary_link) {
> +	} else if (pcie_downstream_port(dev)) {
>  		status = default_reset_link(dev);
>  	} else {
>  		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338fad86..01752a63cd15 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1431,26 +1431,38 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
>  	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
>  
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent)
> +		return;
> +
>  	/*
> -	 * A Root Port or a PCI-to-PCIe bridge is always the upstream end
> -	 * of a Link.  No PCIe component has two Links.  Two Links are
> -	 * connected by a Switch that has a Port on each Link and internal
> -	 * logic to connect the two Ports.
> +	 * Some systems do not identify their upstream/downstream ports
> +	 * correctly so detect impossible configurations here and correct
> +	 * the port type accordingly.
>  	 */
>  	type = pci_pcie_type(pdev);
> -	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_PCIE_BRIDGE)
> -		pdev->has_secondary_link = 1;
> -	else if (type == PCI_EXP_TYPE_UPSTREAM ||
> -		 type == PCI_EXP_TYPE_DOWNSTREAM) {
> -		parent = pci_upstream_bridge(pdev);
> -
> +	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
>  		/*
> -		 * Usually there's an upstream device (Root Port or Switch
> -		 * Downstream Port), but we can't assume one exists.
> +		 * If pdev claims to be downstream port but the parent
> +		 * device is also downstream port assume pdev is actually
> +		 * upstream port.
>  		 */
> -		if (parent && !parent->has_secondary_link)
> -			pdev->has_secondary_link = 1;
> +		if (pcie_downstream_port(parent)) {
> +			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> +			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +		}
> +	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
> +		/*
> +		 * If pdev claims to be upstream port but the parent
> +		 * device is also upstream port assume pdev is actually
> +		 * downstream port.
> +		 */
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> +			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +		}
>  	}
>  }
>  
> @@ -2764,12 +2776,8 @@ static int only_one_child(struct pci_bus *bus)
>  	 * A PCIe Downstream Port normally leads to a Link with only Device
>  	 * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
>  	 * only for Device 0 in that situation.
> -	 *
> -	 * Checking has_secondary_link is a hack to identify Downstream
> -	 * Ports because sometimes Switches are configured such that the
> -	 * PCIe Port Type labels are backwards.
>  	 */
> -	if (bridge && pci_is_pcie(bridge) && bridge->has_secondary_link)
> +	if (bridge && pci_is_pcie(bridge) && pcie_downstream_port(bridge))
>  		return 1;
>  
>  	return 0;
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index 5acd9c02683a..9ae9fb9339e8 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -13,6 +13,8 @@
>  #include <linux/pci_regs.h>
>  #include <linux/types.h>
>  
> +#include "pci.h"
> +
>  /**
>   * pci_vc_save_restore_dwords - Save or restore a series of dwords
>   * @dev: device
> @@ -105,7 +107,7 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
>  	struct pci_dev *link = NULL;
>  
>  	/* Enable VCs from the downstream device */
> -	if (!dev->has_secondary_link)
> +	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev))
>  		return;
>  
>  	ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82e4cd1b7ac3..2f8990246316 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -418,7 +418,6 @@ struct pci_dev {
>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
>  	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
> -	unsigned int	has_secondary_link:1;
>  	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
>  	unsigned int	is_probed:1;		/* Device probing in progress */
>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
> -- 
> 2.23.0.rc1
> 
