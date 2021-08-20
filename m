Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3D3F3601
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhHTV3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231761AbhHTV3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85F0261102;
        Fri, 20 Aug 2021 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629494924;
        bh=R50voVYXZmpGD90W00TuPBOn2Mv0DYhdqgh/nkdHNUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lc/cMTjn35gKO8m8KW7IobhELi3FVTmfK/7QkZhKqQ5pEkUdW+cadazBQ/3x82jZw
         xpkVF4OL2c4WFj1r+swvl/wpAknPqKk+EWvmCl5EApIq1ANx5qlk6HUHDCMZtMwykA
         nkBqBBYRG4PIRGHoICbcJ+soPINTe/pytH91hvzg0a0PR/yTCKMPStp9UC+Olcdi0v
         j87v+Vg7d8yfy6v2gqltuxdQ+sG/vtripHP1qoBfu9X2OL4evnv1TDvwiEdkNzuTat
         IAs3IuacKCrmKi88z8vkpvJlIVdrCQ/Wf5mOwvCQ36f76HAHGOtmfHo5891dguBVUg
         9SLKyDO27+pIA==
Date:   Fri, 20 Aug 2021 16:28:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: Make saved capability state private to core
Message-ID: <20210820212843.GA3361474@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221728.1469304-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 02, 2021 at 05:17:28PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Interfaces and structs for saving and restoring PCI Capability state were
> declared in include/linux/pci.h, but aren't needed outside drivers/pci/.
> 
> Move these to drivers/pci/pci.h:
> 
>   struct pci_cap_saved_data
>   struct pci_cap_saved_state
>   void pci_allocate_cap_save_buffers()
>   void pci_free_cap_save_buffers()
>   int pci_add_cap_save_buffer()
>   int pci_add_ext_cap_save_buffer()
>   struct pci_cap_saved_state *pci_find_saved_cap()
>   struct pci_cap_saved_state *pci_find_saved_ext_cap()
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Alex's Reviewed-by to pci/misc for v5.15.

> ---
>  drivers/pci/pci.h   | 23 +++++++++++++++++++++--
>  include/linux/pci.h | 18 ------------------
>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 93dcdd431072..288126062a38 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -37,6 +37,27 @@ int pci_probe_reset_function(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> +struct pci_cap_saved_data {
> +	u16		cap_nr;
> +	bool		cap_extended;
> +	unsigned int	size;
> +	u32		data[];
> +};
> +
> +struct pci_cap_saved_state {
> +	struct hlist_node		next;
> +	struct pci_cap_saved_data	cap;
> +};
> +
> +void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> +void pci_free_cap_save_buffers(struct pci_dev *dev);
> +int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
> +int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
> +				u16 cap, unsigned int size);
> +struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
> +struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
> +						   u16 cap);
> +
>  #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
> @@ -100,8 +121,6 @@ void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
>  void pci_msix_init(struct pci_dev *dev);
> -void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> -void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..fd35327812af 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -288,18 +288,6 @@ enum pci_bus_speed {
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  
> -struct pci_cap_saved_data {
> -	u16		cap_nr;
> -	bool		cap_extended;
> -	unsigned int	size;
> -	u32		data[];
> -};
> -
> -struct pci_cap_saved_state {
> -	struct hlist_node		next;
> -	struct pci_cap_saved_data	cap;
> -};
> -
>  struct irq_affinity;
>  struct pcie_link_state;
>  struct pci_vpd;
> @@ -1278,12 +1266,6 @@ int pci_load_saved_state(struct pci_dev *dev,
>  			 struct pci_saved_state *state);
>  int pci_load_and_free_saved_state(struct pci_dev *dev,
>  				  struct pci_saved_state **state);
> -struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
> -struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
> -						   u16 cap);
> -int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
> -int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
> -				u16 cap, unsigned int size);
>  int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
>  int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
>  pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
> -- 
> 2.25.1
> 
