Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39B3D60D6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfJNLBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 07:01:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbfJNLBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 07:01:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44151337;
        Mon, 14 Oct 2019 04:01:51 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10133F718;
        Mon, 14 Oct 2019 04:01:50 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:01:49 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: msi: remove pci_irq_get_node() as no one is using it
Message-ID: <20191014110148.GS42880@e119886-lin.cambridge.arm.com>
References: <20191014100452.GA6699@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014100452.GA6699@kroah.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 12:04:52PM +0200, Greg Kroah-Hartman wrote:
> The function pci_irq_get_node() is not used by anyone in the tree, so
> just delete it.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0884bedcfc7a..f95fe23830f0 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1315,22 +1315,6 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  }
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
> -/**
> - * pci_irq_get_node - return the NUMA node of a particular MSI vector
> - * @pdev:	PCI device to operate on
> - * @vec:	device-relative interrupt vector index (0-based).
> - */
> -int pci_irq_get_node(struct pci_dev *pdev, int vec)
> -{
> -	const struct cpumask *mask;
> -
> -	mask = pci_irq_get_affinity(pdev, vec);
> -	if (mask)
> -		return local_memory_node(cpu_to_node(cpumask_first(mask)));
> -	return dev_to_node(&pdev->dev);
> -}
> -EXPORT_SYMBOL(pci_irq_get_node);
> -
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
>  {
>  	return to_pci_dev(desc->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f9088c89a534..755d8c0176b9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1454,7 +1454,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  void pci_free_irq_vectors(struct pci_dev *dev);
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
> -int pci_irq_get_node(struct pci_dev *pdev, int vec);
>  
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> @@ -1497,11 +1496,6 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
>  {
>  	return cpu_possible_mask;
>  }
> -
> -static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
> -{
> -	return first_online_node;
> -}
>  #endif
>  
>  /**
