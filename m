Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB80B6BB8B2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOP4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjCOP40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:56:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642F856BF
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C33E3B81E6A
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF1CC433EF;
        Wed, 15 Mar 2023 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895736;
        bh=Umtv1W0bLoS7h2/BBamcI4s20PZnrJbjFzPaU5Umg1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkUYKqDioVtso3AuAE4K3bHgJrwQoLOdEMrX2hI4T8Vnzg6scgirEkQ4u81ngLEz9
         dh2549zai3VEc35BmkPO94b1ohCePPYaGjYrrOXVlpCfSGJHDqfv3UG8jT+jryVd1Q
         aczyAWlIfGXyYSAWUMQGDufsr+drkYP2VaKJI/KKdcoFF/YUkVNwf43BhY+S/8tAdU
         d1qb+9LW2x7x4ycpLHG4FCrJI4rWOSxIzSNis9HR5I4F2TpIo3XfXowqYlruplsZsh
         E79Vb2SkEEjSpBNiBvALSri853fxAil5St1SiJDWSyP4KzPfg5J2kGvkN7YoGRYz8n
         C+zHnoJu6Yoog==
Date:   Wed, 15 Mar 2023 21:25:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 14/16] misc: pci_endpoint_test: Re-init completion for
 every test
Message-ID: <20230315155523.GM98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-15-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-15-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:11PM +0900, Damien Le Moal wrote:
> The irq_raised completion used to detect the end of a test case is
> initialized when the test device is probed, but never reinitialized
> again before a test case. As a result, the irq_raised completion
> synchronization is effective only for the first ioctl test case
> executed. Any subsequent call to wait_for_completion() by another
> ioctl() call will immediately return, potentially too early, leading to
> false positive failures.
> 
> Fix this by reinitializing the irq_raised completion before starting a
> new ioctl() test command.
> 
> Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 01235236e9bc..24efe3b88a1f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -729,6 +729,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	struct pci_dev *pdev = test->pdev;
>  
>  	mutex_lock(&test->mutex);
> +
> +	reinit_completion(&test->irq_raised);
> +	test->last_irq = -ENODATA;
> +
>  	switch (cmd) {
>  	case PCITEST_BAR:
>  		bar = arg;
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
