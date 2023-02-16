Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19E8699217
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBPKrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBPKrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:47:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC254576
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3877661F73
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AC5C433EF;
        Thu, 16 Feb 2023 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676544375;
        bh=66GXk2DBnieQriFjBtU732YSsPPxCQq9KT8Y5ZCUYoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDfSOHuD1gQl2Cv5Q5q7AWq3XLdjx3cnlE97fVI4+gtzmKhXfGXlPuhe2aLVDXlY2
         DAbTidnaY433auyh7F+Ruhu4dA3I7v3j9dCO/Kxy7dOgbgdPHNeirEuY8D6YpsKsYz
         3x07xK1I7ChDGOweZOpH5v/p5VmID5v6zWkiZx/Q2677jypvkJWMvWBLuUoUi41bXq
         x30ooa9zP1GweCr6pKs4IIVOqRNjWC6oWZohIwHPnyFCYYsiO3hb/PjwOhSfq2Gd5U
         JHn00I1QeRGxIVQiwKGSwNZECQ/rHeVCjAwXGVtjqcBHy4RxRrZbMt0apmp12tQpMI
         bmYAH4OE4gH5g==
Date:   Thu, 16 Feb 2023 16:16:02 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/12] misc: pci_endpoint_test: Free IRQs before removing
 the device
Message-ID: <20230216104602.GI2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-9-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-9-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:51PM +0900, Damien Le Moal wrote:
> In pci_endpoint_test_remove(), freeing the IRQs after removing the
> device creates a small race window for IRQs to be received with the test
> device memory already released, causing the IRQ handler to access
> invalid memory, resulting in an oops.
> 
> Free the device IRQs before removing the device to avoid this issue.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

This looks like a bug. So there should be Fixes tag and stable list has to be
CCed for backporting.

With that,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 11530b4ec389..e27d471cc847 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -937,6 +937,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  	if (id < 0)
>  		return;
>  
> +	pci_endpoint_test_release_irq(test);
> +	pci_endpoint_test_free_irq_vectors(test);
> +
>  	misc_deregister(&test->miscdev);
>  	kfree(misc_device->name);
>  	kfree(test->name);
> @@ -946,9 +949,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  			pci_iounmap(pdev, test->bar[bar]);
>  	}
>  
> -	pci_endpoint_test_release_irq(test);
> -	pci_endpoint_test_free_irq_vectors(test);
> -
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
>  }
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
