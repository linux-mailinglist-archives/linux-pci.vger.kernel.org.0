Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7898C41B5B0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhI1SL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 14:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239306AbhI1SLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 14:11:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FE4061352;
        Tue, 28 Sep 2021 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632852615;
        bh=cT8cQ5HY5tOYrLBIoP7JCa0vC1JePSFeWXunFeRb30U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nG8lgqF5GIuVvbIdVUn94n/g0w4MbsgK4azBFTrnPmt2+QCIpE3Cm0URumB0fXGT9
         1x2VOnrG1M3AkBpFK3G0P1uq2WP4qOpp22jnxpXjcgg14/OxA8heum5Ij9reQRnW/o
         O5IkJkgCteYHCy7h5zZNu23QlZQOtHvYQVGEA8MxJ7BQQwfoKoP2AdpfBwxL25KhWG
         D2vPV+LE51LxW5kGR65Gm202oDAHKlXLtTqVVc2+45CnZ/N2AGaGvC0bVRMgrUtOVT
         uFjQpQepfCZwSgNMBE6RXEvRJYkg1SOMqY3iVotcQFwLdHsIk0MsOHxWHeVftH65y+
         9j3UJaTZbYLbw==
Date:   Tue, 28 Sep 2021 13:10:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linas Vepstas <linasvepstas@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] PCI: Export pci_dev_lock()
Message-ID: <20210928181014.GA713179@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916093336.2895602-4-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 11:33:35AM +0200, Niklas Schnelle wrote:
> Commit e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()")
> already exported pci_dev_trylock()/pci_dev_unlock() however in some
> circumstances such as during error recovery it makes sense to block
> waiting to get full access to the device so also export pci_dev_lock().
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c   | 3 ++-
>  include/linux/pci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..6fe810fdb796 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5059,12 +5059,13 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
>  
> -static void pci_dev_lock(struct pci_dev *dev)
> +void pci_dev_lock(struct pci_dev *dev)
>  {
>  	pci_cfg_access_lock(dev);
>  	/* block PM suspend, driver probe, etc. */
>  	device_lock(&dev->dev);
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_lock);
>  
>  /* Return 1 on successful lock, 0 on contention */
>  int pci_dev_trylock(struct pci_dev *dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..c27c8fd1d30c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1671,6 +1671,7 @@ void pci_cfg_access_lock(struct pci_dev *dev);
>  bool pci_cfg_access_trylock(struct pci_dev *dev);
>  void pci_cfg_access_unlock(struct pci_dev *dev);
>  
> +void pci_dev_lock(struct pci_dev *dev);
>  int pci_dev_trylock(struct pci_dev *dev);
>  void pci_dev_unlock(struct pci_dev *dev);
>  
> -- 
> 2.25.1
> 
