Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF01473CD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAWWZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 17:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgAWWZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 17:25:58 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBB421569;
        Thu, 23 Jan 2020 22:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579818358;
        bh=LpYPT2p3EzPLIgDHUXsIyOM5Yx2HubUkTJfa982jVdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p1GgAvrClknGWFrr/ONizGu5Hz49PZ5zadLpy91/NN4A+6pLvQ10TVCcauE1UlzNN
         Ejo9b1XF7sZ3hhQK7sDCpVgjsjxy46YeatAFA8qW1FL1Uxt+7XqD59nfGfyb0m2nUm
         vNUg8gfoim+KQvENc9ndfoP7IIoIinOXFNL3iMU0=
Date:   Thu, 23 Jan 2020 16:25:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     keith.busch@intel.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] PCI/AER: Fix the uninitialized aer_fifo
Message-ID: <20200123222555.GA151102@google.com>
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
> is not. 

It's definitely a problem that we don't call INIT_KFIFO().  But I'm
curious about why this would only be a problem "sometimes".  The kfifo
is allocated with devm_kzalloc(), so it should be zero-filled and I
would think it would fail consistently, every time.  But I guess not?

> It is easy to reproduce the problem by using aer_inject.

I assume maybe you mean "aer-inject" (not "aer_inject"), from
https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/ ?
At least, that's what's mentioned in Documentation/PCI/pcieaer-howto.rst.

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
