Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7E1AD9BC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgDQJXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 05:23:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:27950 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbgDQJXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Apr 2020 05:23:15 -0400
IronPort-SDR: LmM/tlq+BB4EmGXrxJTtbfkLVOE7K1muJm6dy57vhsCy6l/zHFoZSOKb28onejY3+96d20SEzM
 jdL4BfuZIhkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 02:23:13 -0700
IronPort-SDR: umiQRcYagMECbGRCnBOmL5p3r1zsMbXNuQ3hpzvk5zK/fFgOGoaD8oyI+8Z7NhIon5/OBlXNLK
 McsAQXk+Ax9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="364278378"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2020 02:23:10 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Apr 2020 12:23:10 +0300
Date:   Fri, 17 Apr 2020 12:23:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        kvalo@codeaurora.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH] PCI: Use pci_pcie_find_root_port() to get root port
Message-ID: <20200417092310.GR2586@lahna.fi.intel.com>
References: <1586262717-23566-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586262717-23566-1-git-send-email-yangyicong@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 07, 2020 at 08:31:57PM +0800, Yicong Yang wrote:
> Previously we use pcie_find_root_port() to get root port from a pcie
> device, use pci_find_pcie_root_port() to get root port from a pci
> device, which increase the complexity.
> 
> Unify the two functions and use pci_pcie_find_root_port() to get root
> port from both pci device and pcie device. Then there is no need to
> distinguish the type of the device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  2 +-
>  drivers/pci/pci-acpi.c                          |  4 ++--
>  drivers/pci/pci.c                               | 24 ------------------------
>  drivers/pci/pcie/aer_inject.c                   |  2 +-
>  drivers/pci/probe.c                             |  2 +-
>  drivers/pci/quirks.c                            |  2 +-
>  drivers/thunderbolt/switch.c                    |  4 ++--
>  include/linux/pci.h                             | 14 +++++++-------
>  8 files changed, 15 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 38d8fe2..556cb8c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -158,7 +158,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
> 
>  	/* Print root port AER registers */
>  	pos = 0;
> -	pdev = pcie_find_root_port(pdev);
> +	pdev = pci_pcie_find_root_port(pdev);
>  	if (pdev)
>  		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
>  	if (pos) {
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0c02d50..9316533 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -246,7 +246,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
> 
>  static bool pcie_root_rcb_set(struct pci_dev *dev)
>  {
> -	struct pci_dev *rp = pcie_find_root_port(dev);
> +	struct pci_dev *rp = pci_pcie_find_root_port(dev);
>  	u16 lnkctl;
> 
>  	if (!rp)
> @@ -948,7 +948,7 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	 * Look for a special _DSD property for the root port and if it
>  	 * is set we know the hierarchy behind it supports D3 just fine.
>  	 */
> -	root = pci_find_pcie_root_port(dev);
> +	root = pci_pcie_find_root_port(dev);
>  	if (!root)
>  		return false;
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d828ca8..fc5e7b6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -695,30 +695,6 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
>  EXPORT_SYMBOL(pci_find_resource);
> 
>  /**
> - * pci_find_pcie_root_port - return PCIe Root Port
> - * @dev: PCI device to query
> - *
> - * Traverse up the parent chain and return the PCIe Root Port PCI Device
> - * for a given PCI Device.
> - */
> -struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
> -{
> -	struct pci_dev *bridge, *highest_pcie_bridge = dev;
> -
> -	bridge = pci_upstream_bridge(dev);
> -	while (bridge && pci_is_pcie(bridge)) {
> -		highest_pcie_bridge = bridge;
> -		bridge = pci_upstream_bridge(bridge);
> -	}
> -
> -	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> -		return NULL;
> -
> -	return highest_pcie_bridge;
> -}
> -EXPORT_SYMBOL(pci_find_pcie_root_port);
> -
> -/**
>   * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
>   * @dev: the PCI device to operate on
>   * @pos: config space offset of status word
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 6988fe7..c3bfc1b5 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -332,7 +332,7 @@ static int aer_inject(struct aer_error_inj *einj)
>  	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
>  	if (!dev)
>  		return -ENODEV;
> -	rpdev = pcie_find_root_port(dev);
> +	rpdev = pci_pcie_find_root_port(dev);
>  	if (!rpdev) {
>  		pci_err(dev, "Root port not found\n");
>  		ret = -ENODEV;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb43..50f7733 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2015,7 +2015,7 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>  	 * For now, we only deal with Relaxed Ordering issues with Root
>  	 * Ports. Peer-to-Peer DMA is another can of worms.
>  	 */
> -	root = pci_find_pcie_root_port(dev);
> +	root = pci_pcie_find_root_port(dev);
>  	if (!root)
>  		return;
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 29f473e..ac62675 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4253,7 +4253,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMD, 0x1a02, PCI_CLASS_NOT_DEFINED,
>   */
>  static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
>  {
> -	struct pci_dev *root_port = pci_find_pcie_root_port(pdev);
> +	struct pci_dev *root_port = pci_pcie_find_root_port(pdev);
> 
>  	if (!root_port) {
>  		pci_warn(pdev, "PCIe Completion erratum may cause device errors\n");
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index a2ce990..90844c1 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -263,7 +263,7 @@ static void nvm_authenticate_start_dma_port(struct tb_switch *sw)
>  	 * itself. To be on the safe side keep the root port in D0 during
>  	 * the whole upgrade process.
>  	 */
> -	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
> +	root_port = pci_pcie_find_root_port(sw->tb->nhi->pdev);
>  	if (root_port)
>  		pm_runtime_get_noresume(&root_port->dev);
>  }
> @@ -272,7 +272,7 @@ static void nvm_authenticate_complete_dma_port(struct tb_switch *sw)
>  {
>  	struct pci_dev *root_port;
> 
> -	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
> +	root_port = pci_pcie_find_root_port(sw->tb->nhi->pdev);
>  	if (root_port)
>  		pm_runtime_put(&root_port->dev);
>  }

For thunderbolt change,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Below is a minor comment that you may want to consider.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a54..b341ca30 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1011,7 +1011,6 @@ void pci_bus_add_device(struct pci_dev *dev);
>  void pci_read_bridge_bases(struct pci_bus *child);
>  struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  					  struct resource *res);
> -struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev);
>  u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
>  int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> @@ -2124,15 +2123,16 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
>  	return (pcie_caps_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
>  }
> 
> -static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
> +/**
> + * pci_pcie_find_root_port - Get the PCIe root port device
> + * @dev: PCI device
> + */

I think it may be good to add a bit more description here for example you
can take the pci_find_pcie_root_port() kernel-doc and use it here.

> +static inline struct pci_dev *pci_pcie_find_root_port(struct pci_dev *dev)
>  {
> -	while (1) {
> -		if (!pci_is_pcie(dev))
> -			break;
> +	dev = pci_physfn(dev);
> +	while (dev) {
>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>  			return dev;
> -		if (!dev->bus->self)
> -			break;
>  		dev = dev->bus->self;
>  	}
>  	return NULL;
> --
> 2.8.1
