Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4031462B51
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 00:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfGHWEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 18:04:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55338 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbfGHWEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 18:04:36 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a1f60be56eca3016; Tue, 9 Jul 2019 00:04:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos and whitespace errors
Date:   Tue, 09 Jul 2019 00:04:30 +0200
Message-ID: <2474543.6s6K6uHSRW@kreacher>
In-Reply-To: <20190708212630.117465-1-helgaas@kernel.org>
References: <20190708212630.117465-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, July 8, 2019 11:26:30 PM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in drivers/pci.  Comment and whitespace changes only.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/ats.c                            |  2 +-
>  drivers/pci/controller/dwc/pcie-armada8k.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c      |  2 +-
>  drivers/pci/controller/pci-aardvark.c        |  2 +-
>  drivers/pci/controller/pcie-iproc-platform.c |  2 +-
>  drivers/pci/controller/pcie-iproc.c          |  2 +-
>  drivers/pci/controller/vmd.c                 |  2 +-
>  drivers/pci/mmap.c                           |  2 +-
>  drivers/pci/msi.c                            | 43 ++++++++++----------
>  drivers/pci/p2pdma.c                         |  6 +--
>  drivers/pci/pci-bridge-emul.c                |  2 +-
>  drivers/pci/pci-pf-stub.c                    |  2 +-
>  drivers/pci/pci.c                            |  2 +-
>  drivers/pci/pcie/aer_inject.c                |  2 +-
>  include/linux/pci.h                          |  2 +-
>  include/linux/pci_ids.h                      |  6 +--
>  16 files changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 97c08146534a..e18499243f84 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -432,7 +432,7 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>   * @pdev: PCI device structure
>   *
>   * Returns negative value when PASID capability is not present.
> - * Otherwise it returns the numer of supported PASIDs.
> + * Otherwise it returns the number of supported PASIDs.
>   */
>  int pci_max_pasids(struct pci_dev *pdev)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 0c389a30ef5d..9012d5f60be9 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -55,7 +55,7 @@ struct armada8k_pcie {
>  #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
>  #define PCIE_AWUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x60)
>  /*
> - * AR/AW Cache defauls: Normal memory, Write-Back, Read / Write
> + * AR/AW Cache defaults: Normal memory, Write-Back, Read / Write
>   * allocate
>   */
>  #define ARCACHE_DEFAULT_VALUE		0x3511
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 9b599296205d..8df1914226be 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -2,7 +2,7 @@
>  /*
>   * PCIe host controller driver for Kirin Phone SoCs
>   *
> - * Copyright (C) 2017 Hilisicon Electronics Co., Ltd.
> + * Copyright (C) 2017 HiSilicon Electronics Co., Ltd.
>   *		http://www.huawei.com
>   *
>   * Author: Xiaowei Song <songxiaowei@huawei.com>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e0306ff00..fc0fe4d4de49 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -308,7 +308,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
>  
> -	/* Unmask all MSI's */
> +	/* Unmask all MSIs */
>  	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
>  
>  	/* Enable summary interrupt for GIC SPI source */
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index f30f5f3fb5c1..5a3550b6bb29 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -87,7 +87,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * DT nodes are not used by all platforms that use the iProc PCIe
> -	 * core driver. For platforms that require explict inbound mapping
> +	 * core driver. For platforms that require explicit inbound mapping
>  	 * configuration, "dma-ranges" would have been present in DT
>  	 */
>  	pcie->need_ib_cfg = of_property_read_bool(np, "dma-ranges");
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index e3ca46497470..2d457bfdaf66 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -163,7 +163,7 @@ enum iproc_pcie_ib_map_type {
>   * @size_unit: inbound mapping region size unit, could be SZ_1K, SZ_1M, or
>   * SZ_1G
>   * @region_sizes: list of supported inbound mapping region sizes in KB, MB, or
> - * GB, depedning on the size unit
> + * GB, depending on the size unit
>   * @nr_sizes: number of supported inbound mapping region sizes
>   * @nr_windows: number of supported inbound mapping windows for the region
>   * @imap_addr_offset: register offset between the upper and lower 32-bit
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 999a5509e57e..4575e0c6dc4b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -627,7 +627,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * 32-bit resources.  __pci_assign_resource() enforces that
>  	 * artificial restriction to make sure everything will fit.
>  	 *
> -	 * The only way we could use a 64-bit non-prefechable MEMBAR is
> +	 * The only way we could use a 64-bit non-prefetchable MEMBAR is
>  	 * if its address is <4GB so that we can convert it to a 32-bit
>  	 * resource.  To be visible to the host OS, all VMD endpoints must
>  	 * be initially configured by platform BIOS, which includes setting
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index 24505b08de40..b8c9011987f4 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -73,7 +73,7 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
>  #elif defined(HAVE_PCI_MMAP) /* && !ARCH_GENERIC_PCI_MMAP_RESOURCE */
>  
>  /*
> - * Legacy setup: Impement pci_mmap_resource_range() as a wrapper around
> + * Legacy setup: Implement pci_mmap_resource_range() as a wrapper around
>   * the architecture's pci_mmap_page_range(), converting to "user visible"
>   * addresses as necessary.
>   */
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index e039b740fe74..59a6d232f77a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -237,7 +237,7 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>  }
>  
>  /**
> - * pci_msi_mask_irq - Generic irq chip callback to mask PCI/MSI interrupts
> + * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
>   * @data:	pointer to irqdata associated to that interrupt
>   */
>  void pci_msi_mask_irq(struct irq_data *data)
> @@ -247,7 +247,7 @@ void pci_msi_mask_irq(struct irq_data *data)
>  EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
>  
>  /**
> - * pci_msi_unmask_irq - Generic irq chip callback to unmask PCI/MSI interrupts
> + * pci_msi_unmask_irq - Generic IRQ chip callback to unmask PCI/MSI interrupts
>   * @data:	pointer to irqdata associated to that interrupt
>   */
>  void pci_msi_unmask_irq(struct irq_data *data)
> @@ -588,11 +588,11 @@ static int msi_verify_entries(struct pci_dev *dev)
>   * msi_capability_init - configure device's MSI capability structure
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   * @nvec: number of interrupts to allocate
> - * @affd: description of automatic irq affinity assignments (may be %NULL)
> + * @affd: description of automatic IRQ affinity assignments (may be %NULL)
>   *
>   * Setup the MSI capability structure of the device with the requested
>   * number of interrupts.  A return value of zero indicates the successful
> - * setup of an entry with the new MSI irq.  A negative return value indicates
> + * setup of an entry with the new MSI IRQ.  A negative return value indicates
>   * an error, and a positive return value indicates the number of interrupts
>   * which could have been allocated.
>   */
> @@ -609,7 +609,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  	if (!entry)
>  		return -ENOMEM;
>  
> -	/* All MSIs are unmasked by default, Mask them all */
> +	/* All MSIs are unmasked by default; mask them all */
>  	mask = msi_mask(entry->msi_attrib.multi_cap);
>  	msi_mask_irq(entry, mask, mask);
>  
> @@ -637,7 +637,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  		return ret;
>  	}
>  
> -	/* Set MSI enabled bits	 */
> +	/* Set MSI enabled bits	*/
>  	pci_intx_for_msi(dev, 0);
>  	pci_msi_set_enable(dev, 1);
>  	dev->msi_enabled = 1;
> @@ -729,11 +729,11 @@ static void msix_program_entries(struct pci_dev *dev,
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
>   * @entries: pointer to an array of struct msix_entry entries
>   * @nvec: number of @entries
> - * @affd: Optional pointer to enable automatic affinity assignement
> + * @affd: Optional pointer to enable automatic affinity assignment
>   *
>   * Setup the MSI-X capability structure of device function with a
> - * single MSI-X irq. A return of zero indicates the successful setup of
> - * requested MSI-X entries with allocated irqs or non-zero for otherwise.
> + * single MSI-X IRQ. A return of zero indicates the successful setup of
> + * requested MSI-X entries with allocated IRQs or non-zero for otherwise.
>   **/
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  				int nvec, struct irq_affinity *affd)
> @@ -789,7 +789,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  out_avail:
>  	if (ret < 0) {
>  		/*
> -		 * If we had some success, report the number of irqs
> +		 * If we had some success, report the number of IRQs
>  		 * we succeeded in setting up.
>  		 */
>  		struct msi_desc *entry;
> @@ -812,7 +812,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  /**
>   * pci_msi_supported - check whether MSI may be enabled on a device
>   * @dev: pointer to the pci_dev data structure of MSI device function
> - * @nvec: how many MSIs have been requested ?
> + * @nvec: how many MSIs have been requested?
>   *
>   * Look at global flags, the device itself, and its parent buses
>   * to determine if MSI/-X are supported for the device. If MSI/-X is
> @@ -896,7 +896,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
>  	/* Keep cached state to be restored */
>  	__pci_msi_desc_mask_irq(desc, mask, ~mask);
>  
> -	/* Restore dev->irq to its default pin-assertion irq */
> +	/* Restore dev->irq to its default pin-assertion IRQ */
>  	dev->irq = desc->msi_attrib.default_irq;
>  	pcibios_alloc_irq(dev);
>  }
> @@ -958,7 +958,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  		}
>  	}
>  
> -	/* Check whether driver already requested for MSI irq */
> +	/* Check whether driver already requested for MSI IRQ */
>  	if (dev->msi_enabled) {
>  		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
>  		return -EINVAL;
> @@ -1026,7 +1026,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (!pci_msi_supported(dev, minvec))
>  		return -EINVAL;
>  
> -	/* Check whether driver already requested MSI-X irqs */
> +	/* Check whether driver already requested MSI-X IRQs */
>  	if (dev->msix_enabled) {
>  		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
>  		return -EINVAL;
> @@ -1113,8 +1113,8 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>   * pci_enable_msix_range - configure device's MSI-X capability structure
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
>   * @entries: pointer to an array of MSI-X entries
> - * @minvec: minimum number of MSI-X irqs requested
> - * @maxvec: maximum number of MSI-X irqs requested
> + * @minvec: minimum number of MSI-X IRQs requested
> + * @maxvec: maximum number of MSI-X IRQs requested
>   *
>   * Setup the MSI-X capability structure of device function with a maximum
>   * possible number of interrupts in the range between @minvec and @maxvec
> @@ -1179,7 +1179,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			return msi_vecs;
>  	}
>  
> -	/* use legacy irq if allowed */
> +	/* use legacy IRQ if allowed */
>  	if (flags & PCI_IRQ_LEGACY) {
>  		if (min_vecs == 1 && dev->irq) {
>  			/*
> @@ -1248,7 +1248,7 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  EXPORT_SYMBOL(pci_irq_vector);
>  
>  /**
> - * pci_irq_get_affinity - return the affinity of a particular msi vector
> + * pci_irq_get_affinity - return the affinity of a particular MSI vector
>   * @dev:	PCI device to operate on
>   * @nr:		device-relative interrupt vector index (0-based).
>   */
> @@ -1280,7 +1280,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
>  /**
> - * pci_irq_get_node - return the numa node of a particular msi vector
> + * pci_irq_get_node - return the NUMA node of a particular MSI vector
>   * @pdev:	PCI device to operate on
>   * @vec:	device-relative interrupt vector index (0-based).
>   */
> @@ -1330,7 +1330,7 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
>  /**
>   * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
>   * @dev:	Pointer to the PCI device
> - * @desc:	Pointer to the msi descriptor
> + * @desc:	Pointer to the MSI descriptor
>   *
>   * The ID number is only used within the irqdomain.
>   */
> @@ -1348,7 +1348,8 @@ static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
>  }
>  
>  /**
> - * pci_msi_domain_check_cap - Verify that @domain supports the capabilities for @dev
> + * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
> + * 			      for @dev
>   * @domain:	The interrupt domain to check
>   * @info:	The domain info for verification
>   * @dev:	The device to check
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 742928d0053e..d953cc7d9a54 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -223,7 +223,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
>  
>  /*
>   * Note this function returns the parent PCI device with a
> - * reference taken. It is the caller's responsibily to drop
> + * reference taken. It is the caller's responsibility to drop
>   * the reference.
>   */
>  static struct pci_dev *find_parent_pci_dev(struct device *dev)
> @@ -380,7 +380,7 @@ static int upstream_bridge_distance(struct pci_dev *provider,
>  
>  	/*
>  	 * Allow the connection if both devices are on a whitelisted root
> -	 * complex, but add an arbitary large value to the distance.
> +	 * complex, but add an arbitrary large value to the distance.
>  	 */
>  	if (root_complex_whitelist(provider) &&
>  	    root_complex_whitelist(client))
> @@ -439,7 +439,7 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
>  }
>  
>  /**
> - * pci_p2pdma_distance_many - Determive the cumulative distance between
> + * pci_p2pdma_distance_many - Determine the cumulative distance between
>   *	a p2pdma provider and the clients in use.
>   * @provider: p2pdma provider to check against the client list
>   * @clients: array of devices to check (NULL-terminated)
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index 83fb077d0b41..06083b86d4f4 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -305,7 +305,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
>  }
>  
>  /*
> - * Cleanup a pci_bridge_emul structure that was previously initilized
> + * Cleanup a pci_bridge_emul structure that was previously initialized
>   * using pci_bridge_emul_init().
>   */
>  void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge)
> diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
> index 9795649fc6f9..ef293e735c55 100644
> --- a/drivers/pci/pci-pf-stub.c
> +++ b/drivers/pci/pci-pf-stub.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* pci-pf-stub - simple stub driver for PCI SR-IOV PF device
>   *
> - * This driver is meant to act as a "whitelist" for devices that provde
> + * This driver is meant to act as a "whitelist" for devices that provide
>   * SR-IOV functionality while at the same time not actually needing a
>   * driver of their own.
>   */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843b1615..3fd4eaa32b21 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4501,7 +4501,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  
>  	/*
>  	 * Wait for Transaction Pending bit to clear.  A word-aligned test
> -	 * is used, so we use the conrol offset rather than status and shift
> +	 * is used, so we use the control offset rather than status and shift
>  	 * the test bit to match.
>  	 */
>  	if (!pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 043b8b0cfcc5..6988fe7389b9 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -2,7 +2,7 @@
>  /*
>   * PCIe AER software error injection support.
>   *
> - * Debuging PCIe AER code is quite difficult because it is hard to
> + * Debugging PCIe AER code is quite difficult because it is hard to
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4a5a84d7bdd4..fb207a22d686 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -382,7 +382,7 @@ struct pci_dev {
>  
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
>  	unsigned int	no_msi:1;		/* May not use MSI */
> -	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
> +	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
>  	unsigned int	block_cfg_access:1;	/* Config space access blocked */
>  	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
>  	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..0dd239f11e91 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1112,7 +1112,7 @@
>  
>  #define PCI_VENDOR_ID_AL		0x10b9
>  #define PCI_DEVICE_ID_AL_M1533		0x1533
> -#define PCI_DEVICE_ID_AL_M1535 		0x1535
> +#define PCI_DEVICE_ID_AL_M1535		0x1535
>  #define PCI_DEVICE_ID_AL_M1541		0x1541
>  #define PCI_DEVICE_ID_AL_M1563		0x1563
>  #define PCI_DEVICE_ID_AL_M1621		0x1621
> @@ -1752,7 +1752,7 @@
>  #define PCI_VENDOR_ID_STALLION		0x124d
>  
>  /* Allied Telesyn */
> -#define PCI_VENDOR_ID_AT    		0x1259
> +#define PCI_VENDOR_ID_AT		0x1259
>  #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
>  #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
>  
> @@ -2550,7 +2550,7 @@
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>  
> -#define PCI_VENDOR_ID_HUAWEI         	0x19e5
> +#define PCI_VENDOR_ID_HUAWEI		0x19e5
>  
>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
> 




