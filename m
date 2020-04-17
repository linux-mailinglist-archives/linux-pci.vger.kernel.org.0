Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F001AD6C4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgDQHCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 03:02:41 -0400
Received: from verein.lst.de ([213.95.11.211]:55986 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgDQHCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Apr 2020 03:02:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4989968BEB; Fri, 17 Apr 2020 09:02:38 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:02:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-pci@vger.kernel.org, hch@lst.de, fbarrat@linux.ibm.com,
        clsoto@us.ibm.com, idanw@mellanox.com, aneela@mellanox.com,
        shlomin@mellanox.com
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable and setup PCI P2P
Message-ID: <20200417070238.GC18880@lst.de>
References: <20200416165725.206741-1-maxg@mellanox.com> <20200416165725.206741-2-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416165725.206741-2-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +#ifdef CONFIG_PCI_P2PDMA
> +int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
> +			 uint64_t desc, uint16_t pe_number);
> +#endif

There should be no need for the ifdef here.

> +	/*
> +	 * Configuring the initiator's PHB requires to adjust its
> +	 * TVE#1 setting. Since the same device can be an initiator
> +	 * several times for different target devices, we need to keep
> +	 * a reference count to know when we can restore the default
> +	 * bypass setting on its TVE#1 when disabling. Opal is not
> +	 * tracking PE states, so we add a reference count on the PE
> +	 * in linux.
> +	 *
> +	 * For the target, the configuration is per PHB, so we keep a
> +	 * target reference count on the PHB.
> +	 */

This could be shortened a bit by using up the whole 80 lines available
in source files.

> +	mutex_lock(&p2p_mutex);
> +
> +	if (desc & OPAL_PCI_P2P_ENABLE) {
> +		/* always go to opal to validate the configuration */
> +		rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
> +				      desc, pe_init->pe_number);
> +
> +		if (rc != OPAL_SUCCESS) {
> +			rc = -EIO;
> +			goto out;
> +		}
> +
> +		pe_init->p2p_initiator_count++;
> +		phb_target->p2p_target_count++;
> +	} else {
> +		if (!pe_init->p2p_initiator_count ||
> +		    !phb_target->p2p_target_count) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (--pe_init->p2p_initiator_count == 0)
> +			pnv_pci_ioda2_set_bypass(pe_init, true);
> +
> +		if (--phb_target->p2p_target_count == 0) {
> +			rc = opal_pci_set_p2p(phb_init->opal_id,
> +					      phb_target->opal_id, desc,
> +					      pe_init->pe_number);
> +			if (rc != OPAL_SUCCESS) {
> +				rc = -EIO;
> +				goto out;
> +			}
> +		}
> +	}
> +	rc = 0;
> +out:
> +	mutex_unlock(&p2p_mutex);
> +	return rc;
> +}

The enable and disable path shares almost no code, why not split it into
two functions?

> +static bool pnv_pci_controller_owns_addr(struct pci_controller *hose,
> +					 phys_addr_t addr, size_t size)
> +{
> +	struct resource *r;
> +	int i;
> +
> +	/*
> +	 * it seems safe to assume the full range is under the same
> +	 * PHB, so we can ignore the size

Capitalize the first character in a multi-line comment, and use up the
whole 80 chars.

> +	 */
> +	for (i = 0; i < 3; i++) {

Replace the magic 3 with ARRAY_SIZE(hose->mem_resources) ?


> +		r = &hose->mem_resources[i];

Move the r declaration here and initialize it on the same line.

> +		if (r->flags && (addr >= r->start) && (addr < r->end))

No need for the inner braces.

> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * find the phb owning a mmio address if not owned locally
> + */
> +static struct pnv_phb *pnv_pci_find_owning_phb(struct pci_dev *pdev,
> +					       phys_addr_t addr, size_t size)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb;
> +
> +	/* fast path */
> +	if (pnv_pci_controller_owns_addr(hose, addr, size))
> +		return NULL;

Maybe open code the pci_bus_to_host(pdev->bus) call here, as we just
overwrite host in the list iteration?

> +
> +	list_for_each_entry(hose, &hose_list, list_node) {
> +		phb = hose->private_data;

Move the ohb declaration here and initialize it on the same line.

> +		if (phb->type != PNV_PHB_NPU_NVLINK &&
> +		    phb->type != PNV_PHB_NPU_OCAPI) {
> +			if (pnv_pci_controller_owns_addr(hose, addr, size))
> +				return phb;
> +		}
> +	}


> +	return NULL;
> +}
> +
> +static int pnv_pci_dma_map_resource(struct pci_dev *pdev,
> +				    phys_addr_t phys_addr, size_t size,
> +				    enum dma_data_direction dir)
> +{
> +	struct pnv_phb *target_phb;
> +	int rc;
> +	u64 desc;
> +
> +	target_phb = pnv_pci_find_owning_phb(pdev, phys_addr, size);
> +	if (target_phb) {

Return early here for the !target_phb case?

> +		desc = OPAL_PCI_P2P_ENABLE;
> +		if (dir == DMA_TO_DEVICE)
> +			desc |= OPAL_PCI_P2P_STORE;
> +		else if (dir == DMA_FROM_DEVICE)
> +			desc |= OPAL_PCI_P2P_LOAD;
> +		else if (dir == DMA_BIDIRECTIONAL)
> +			desc |= OPAL_PCI_P2P_LOAD | OPAL_PCI_P2P_STORE;

Seems like this could be split into a little helper.

> +		rc = pnv_pci_ioda_set_p2p(pdev, target_phb, desc);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Failed to setup PCI peer-to-peer for address %llx: %d\n",
> +				phys_addr, rc);
> +			return rc;
> +		}

No need for this printk, the callers should already deal with mapping
failures.

