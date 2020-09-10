Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F295D264F68
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIJTln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgIJTlj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 15:41:39 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442A721556;
        Thu, 10 Sep 2020 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766899;
        bh=xVKQeh6vK/bSUtAb8QmMQzYllSypqGLdxdvE0zPLxSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cv+Tr1pNNaxP2eOUGtBsg7HrYjYKSN2v7JvR6yNY5z7cMXtbl9CCyZJKDi6BZl4eb
         jKIfC7kah7XB2mcYTWUlU7AXuxJzQaxUgP+gmvu7KW9x0vBn8Xg01KQnA+5QkY+8L4
         B1pH9L/kzJQUVLSeqKTyzh3q3g7hhGfqaUNaQ8vE=
Date:   Thu, 10 Sep 2020 14:41:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [RFC PATCH] PCI/portdrv: No need to call pci_disable_device()
 during shutdown
Message-ID: <20200910194138.GA808043@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599294806-13889-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 05, 2020 at 04:33:26PM +0800, Tiezhu Yang wrote:
> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
> services during shutdown"), it also calls pci_disable_device() during
> shutdown, this seems unnecessary, so just remove it.

I would like to get rid of the portdrv completely by folding its
functionality into the PCI core itself, so there would be no portdrv
probe or remove.

Does this solve a problem?  If not, I'm inclined to just leave it
as-is for now.  But if it fixes something, we should do the fix, of
course.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv_core.c |  1 -
>  drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522..1991aca 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3a3ce40..cab37a8 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	}
>  
>  	pcie_port_device_remove(dev);
> +	pci_disable_device(dev);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +	if (pci_bridge_d3_possible(dev)) {
> +		pm_runtime_forbid(&dev->dev);
> +		pm_runtime_get_noresume(&dev->dev);
> +		pm_runtime_dont_use_autosuspend(&dev->dev);
> +	}
> +
> +	pcie_port_device_remove(dev);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 2.1.0
> 
