Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6D14CC72
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2O30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 09:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgA2O30 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 09:29:26 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FCA20716;
        Wed, 29 Jan 2020 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580308165;
        bh=fEGQZ48QlJCD6MibZ9l5dvpLo0BF2+qHxM0Jy18ruYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zHfeOMflY7LplBT7C6R09E37xB2WkIIQ5vUW1X7My7NLsPjn+ZJj2D8VObjdnPGTA
         1DfSzeFhpr7Nrjlp0nCPbaB+8jGCPxBI7DvFqMYx2JnawRyUPVaN15DT3XAouK9ZCX
         ANWRhptcHviFancg39ctmXYvqllNVwbo8pxCgr6s=
Date:   Wed, 29 Jan 2020 08:29:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     keith.busch@intel.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] PCI/AER: Fix the uninitialized aer_fifo
Message-ID: <20200129142923.GA106498@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579767991-103898-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 23, 2020 at 04:26:31PM +0800, Dongdong Liu wrote:
> Current code do not call INIT_KFIFO() to init aer_fifo. This will lead to
> kfifo_put() sometimes return 0. This means the fifo was full. In fact, it
> is not. It is easy to reproduce the problem by using aer_inject.
> aer_inject -s :82:00.0 multiple-corr-nonfatal
> The content of multiple-corr-nonfatal file is as below.
> AER
> COR RCVR
> HL 0 1 2 3
> AER
> UNCOR POISON_TLP
> HL 4 5 6 7
> 
> Fixes: 27c1ce8bbed7 ("PCI/AER: Use kfifo for tracking events instead of reimplementing it")
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to pci/aer for v5.6, thanks!

I tweaked the commit log for s/aer_inject/aer-inject/

> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1ca86f2..4a818b0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1445,6 +1445,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return -ENOMEM;
>  
>  	rpc->rpd = port;
> +	INIT_KFIFO(rpc->aer_fifo);
>  	set_service_data(dev, rpc);
>  
>  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> -- 
> 1.9.1
> 
