Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816466318BC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 03:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKUC4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 21:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKUC4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 21:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052E2F641
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 18:56:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82C02B80B1C
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 02:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2F1C433C1;
        Mon, 21 Nov 2022 02:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668999370;
        bh=I+JmnkVGqs/v/wO89pQXdJt18O9mPGg+N5o83PsNpQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pyad5OsfXvvqdcgGbK4HyRrGW6i/6UNwiiuIV7ZLI5VNUXebJYEOstbdxjm0wnmDR
         Syz/IEwtLjazVve6SSNIYdS1/1KTvGFS7RaFkp/QeFnrVU2PfPVym7t4FJPGUlg/3r
         0zHIzKumN1HaVFqAsSPrnrJmxguSsp/nOaRbe/IONOzE61690k6FNJNi4oOYEdQyLa
         4FAVu/dIkGhP1J4hNbECdQcW64oaMHlCOrJCUMsQ9JQZNS9LDBgCGbO+MzfUOAHFTp
         AFkMTPVkgVecCsG+bHkuz9hr7XLuX7ryDFcTeJDeX8ohuH62onUjTLadqnPhcCWVfS
         A7CKy+Nj217OQ==
Date:   Sun, 20 Nov 2022 20:56:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     tglx@linutronix.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
        liwei391@huawei.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: fix possible null-pointer dereference about devname
Message-ID: <20221121025608.GA72419@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121020029.3759444-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, 704e8953d3e9 author]

On Mon, Nov 21, 2022 at 10:00:29AM +0800, Zeng Heng wrote:
> When kvasprintf() fails to allocate memory, it would return
> null-pointer. In case of null pointer dereferencing, fix it
> by returning error number directly from the function.
> 
> Fixes: 704e8953d3e9 ("PCI/irq: Add pci_request_irq() and pci_free_irq() helpers")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/pci/irq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 12ecd0aaa28d..0050e8f6814e 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -44,6 +44,8 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>  	va_start(ap, fmt);
>  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
>  	va_end(ap);
> +	if (!devname)
> +		return -ENOMEM;
>  
>  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
>  				   irqflags, devname, dev_id);
> -- 
> 2.25.1
> 
