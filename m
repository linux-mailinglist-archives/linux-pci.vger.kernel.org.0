Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D241EBFD3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgFBQSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 12:18:32 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:39080 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFBQSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 12:18:31 -0400
X-Greylist: delayed 2300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2020 12:18:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7+V7p4s3f6AWLp39DcPw+D9QhL9GyRAq9RMEYMU9Bdc=; b=YoNfbI0HMnhh4lD0on7Bqyiq1G
        VivHONsWqzBQga3TOAUl0Mj/7iORu5FA6q3vXMPolS6srxYXOdbN83IodyaApG6N6oo9DllHBkb4F
        kh9lQssfwv4yCHURvb3bknkz009ZK6y3hYCSwIxuCwnNhrSEiq/QhIRx/9+g6VfBcGO+OVajcYOea
        BRDtIAGxPlQjElh8VgbtHiaR9j/B8xMctAIIY7ZjAwOuVzRAagFLNSAfGByz+kewuH17m0h7LuEEP
        /s8I0j1huwKsfUC2P7a/yPe4oEP6lBFJ1UtSO0zEnXf2ZwFKb8YqpgaAgo5UTmHDU3Z7MSKZDjg7Q
        dFvehvCg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jg91L-0003tl-JQ; Tue, 02 Jun 2020 09:40:10 -0600
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200602092002.31787-1-piotr.stankiewicz@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b13285b7-4803-5242-e180-75e4d514f1ab@deltatee.com>
Date:   Tue, 2 Jun 2020 09:40:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602092002.31787-1-piotr.stankiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, bhelgaas@google.com, piotr.stankiewicz@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 03/15] PCI: use PCI_IRQ_MSI_TYPES where appropriate
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-06-02 3:20 a.m., Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Seems fine to me, for the switchtec portions:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/pcie/portdrv_core.c | 4 ++--
>  drivers/pci/switch/switchtec.c  | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..2a38a918ba12 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -105,7 +105,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  
>  	/* Allocate the maximum possible number of MSI/MSI-X vectors */
>  	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
> -			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +			PCI_IRQ_MSI_TYPES);
>  	if (nr_entries < 0)
>  		return nr_entries;
>  
> @@ -131,7 +131,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		pci_free_irq_vectors(dev);
>  
>  		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> -				PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +				PCI_IRQ_MSI_TYPES);
>  		if (nr_entries < 0)
>  			return nr_entries;
>  	}
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..11fbe9c6b201 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1442,8 +1442,7 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
>  		nirqs = 4;
>  
>  	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
> -				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
> -				      PCI_IRQ_VIRTUAL);
> +				      PCI_IRQ_MSI_TYPES | PCI_IRQ_VIRTUAL);
>  	if (nvecs < 0)
>  		return nvecs;
>  
> 
