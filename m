Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A56D16CA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 07:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCaFaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 01:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 01:30:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F811EAD
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 22:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3952562343
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 05:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D56C433D2;
        Fri, 31 Mar 2023 05:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680240608;
        bh=BVBI4GlzUWsIkFxE+4K1Xnc49/4dhg5ZvPO/f0A0a5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMvWmNOnnpLUst0LKnNrm+Rn0zxqmYJRbRqxeAIbvcX2xp+jU8o6MEaHCkRAl2Eg4
         NqLMp8zbTT+36Gf6edhlI6e3p1mSTI6zhmfsJgmOYFyPDflukZr3O7oYG2bmBTozK0
         qiszshOvq466HZisJC6BBglnaeDEgpCApC4UFyhDv0XhsjcUsjSc8C5rqtQ/DKsifi
         IRa9rQz6kcLPpDywcR2LGxQeFUa4MiBq5HxybeiLCKEIgiu5DXEDc4VP0rhm8TPv1U
         +xTmwULxATFuRtQXNHKUXBHV+WfmLNhr/94GtcjD43oTJdPLs+GSQQ+cWSvopKKWoU
         MDdV3yF+2kItw==
Date:   Fri, 31 Mar 2023 10:59:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 15/17] misc: pci_endpoint_test: Re-init completion for
 every test
Message-ID: <20230331052954.GD4973@thinkpad>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-16-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330085357.2653599-16-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:55PM +0900, Damien Le Moal wrote:
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

- Mani

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
