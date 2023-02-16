Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041A69925C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBPK4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPK4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:56:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB426848
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:55:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0078861F71
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C43C433D2;
        Thu, 16 Feb 2023 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676544953;
        bh=/Y46kutUSztPxLMUupQh6yW65SICTyE5p8AiVI1Wx7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StyAXTH0nmGtSrUhHLHGk152G2tugD5gKZhh+WqJkQdzlHjILfKNj5oX2xdBDvBz5
         0jo0SapZm5PSj3AkLZ5EgSOw8LejlkO3tuuh2a0Hpx2ni3MspiPBKMQ82WPvCyEQvP
         X9W1Kf/u+khcIq0gtDRSmzTQVMvGyWP1SF5mmZR9LdXZeS/rBugChKAnos8ZKnYMsL
         Oj9J4Nf/i6L4SE4IgjA3Syj4Z32JBxOFm8EmY9KbLhnGEUkv8v2vj3eS4J4fKUdCeO
         aRtl7mLui7g629Motc/uaxOm4ff4TRogAbhsTz3sVwxgoh94KC0KpXbe2Q+zQXQOhd
         /mMqjMGMXkCuQ==
Date:   Thu, 16 Feb 2023 16:25:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/12] misc: pci_endpoint_test: Re-init completion for
 every test
Message-ID: <20230216105540.GK2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-11-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-11-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:53PM +0900, Damien Le Moal wrote:
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
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Fixes tag? CC stable?

> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c1370950c79d..baab08f983a2 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -725,6 +725,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	struct pci_dev *pdev = test->pdev;
>  
>  	mutex_lock(&test->mutex);
> +
> +	reinit_completion(&test->irq_raised);
> +	test->last_irq = -1;

-ENODATA?

Thanks,
Mani

> +
>  	switch (cmd) {
>  	case PCITEST_BAR:
>  		bar = arg;
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
