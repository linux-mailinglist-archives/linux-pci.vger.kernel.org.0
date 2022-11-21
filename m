Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAED633018
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKUW6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiKUW6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 17:58:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8EABB8F
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 14:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BFAB614CA
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D1C433D6;
        Mon, 21 Nov 2022 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669071492;
        bh=B1fzQmxT70olsm3Wdy2V6HfG7XpuAOfEQr1Eb04NppY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I3ynTbIZLqC2r/8J7LTbAqyNnZCsKGgiV1Y01fim+XRw+NVgV0DnCZO8jxNuqpoS2
         nZQXSc9hkei5HOR9CScK4pHRyT0XyUwyDbMyHpVZ00V7yOjkxAfnh8sQDyEHhKUj9s
         QaeHJPWAYIwYS54d1tG5jOwh/5u6E6djt8WEY8XXCQ/xihaZdZ0hIqzRQPtzxyHOEz
         wr/xCOFKYOoc40tAb1o3GhxazrXJafJM2G88wvTP3FYgkCigO3C4EOabqUaCTofFTe
         vCGVOk2MZzicQE/CYg69AeejyU/6zltXj6oHMYm167Ucfgo87IqSKCQ5LQrrTiokwF
         jjezdqZiB14Bg==
Date:   Mon, 21 Nov 2022 16:58:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     tglx@linutronix.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
        liwei391@huawei.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: fix possible null-pointer dereference about devname
Message-ID: <20221121225810.GA141075@bhelgaas>
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

On Mon, Nov 21, 2022 at 10:00:29AM +0800, Zeng Heng wrote:
> When kvasprintf() fails to allocate memory, it would return
> null-pointer. In case of null pointer dereferencing, fix it
> by returning error number directly from the function.
> 
> Fixes: 704e8953d3e9 ("PCI/irq: Add pci_request_irq() and pci_free_irq() helpers")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Applied with Christoph's ack to pci/enumeration for v6.2, thanks!

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
