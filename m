Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581166BB880
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjCOPwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjCOPwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:52:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999C7D088
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3ACB81E69
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20ECC433D2;
        Wed, 15 Mar 2023 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895492;
        bh=sAw2z6oGv1CXNQQ1aoXtd/uOFABAp92esZ2NH81zh+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7FrBedrkqDMER1Re0xdz2mI8dO4qx2uqaAL15v2QnKXQDZM8IqF30revFL+18wE1
         LdpxIwDFE1b3GGGrAyPncGBEFnijv07ad8nkVrve+GQgfIZ7dyZ7XXz+EmVfhie5yf
         3ifl8BiqJR0beZjvX1SfFr2iB+8Y3NB6LjaldzGg88GmgTiu+AZMEnbsWppL5xSDIQ
         pkmCY/ouwGuwPFwfLee6OVrXOZ/L3Ugfp9EwenUiZYUwbNHa0D4dxmX4miEGC0Hdvy
         tX+LHQfVYZqv6148yF95vEbg6BvWzTtvoxvkv4XcaLniSiHB6cvrkvNKKnoZQ5YcFH
         74tAe1fkjLw8w==
Date:   Wed, 15 Mar 2023 21:21:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 09/16] PCI: epf-test: Improve handling of command and
 status registers
Message-ID: <20230315155119.GK98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:06PM +0900, Damien Le Moal wrote:
> The pci-epf-test driver uses the test register bar memory directly
> to get and execute a test registers set by the RC side and defined
> using a struct pci_epf_test_reg. This direct use relies on a casts of
> the register bar to get a pointer to a struct pci_epf_test_reg to
> execute the test case and sending back the test result through the
> status field of struct pci_epf_test_reg. In practice, the status field
> is always updated before an interrupt is raised in
> pci_epf_test_raise_irq(), to ensure that the RC side sees the updated
> status when receiving the interrupts.
> 
> However, such cast-based direct access does not ensure that changes to
> the status register make it to memory, and so visible to the host,
> before an interrupt is raised, thus potentially resulting in the RC host
> not seeing the correct status result for a test.
> 
> Avoid this potential problem by using READ_ONCE()/WRITE_ONCE() when
> accessing the command and status fields of a pci_epf_test_reg structure.
> This ensure that a test start (pci_epf_test_cmd_handler() function) and
> completion (with the function pci_epf_test_raise_irq()) achive a correct
> synchronization with the host side mmio register accesses.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 43d623682850..e0cf8c2bf6db 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -615,9 +615,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	u32 status = reg->status | STATUS_IRQ_RAISED;
>  	int count;
>  
> -	reg->status |= STATUS_IRQ_RAISED;
> +	/*
> +	 * Set the status before raising the IRQ to ensure that the host sees
> +	 * the updated value when it gets the IRQ.
> +	 */
> +	WRITE_ONCE(reg->status, status);

For MMIO, it is not sufficient to use WRITE_ONCE() and expect that the write
has reached the memory (it could be stored in a write buffer). If you really
care about synchronization, then you should do a read back of the variable.

Thanks,
Mani

>  
>  	switch (reg->irq_type) {
>  	case IRQ_TYPE_LEGACY:
> @@ -661,12 +666,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
> -	command = reg->command;
> +	command = READ_ONCE(reg->command);
>  	if (!command)
>  		goto reset_handler;
>  
> -	reg->command = 0;
> -	reg->status = 0;
> +	WRITE_ONCE(reg->command, 0);
> +	WRITE_ONCE(reg->status, 0);
>  
>  	if (reg->irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
