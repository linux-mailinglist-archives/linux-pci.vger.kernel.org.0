Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F46E281B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDNQMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDNQMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14622B77E
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61328648F3
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76315C433D2;
        Fri, 14 Apr 2023 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488707;
        bh=ZBtLs4Np3CH7NZ/7M84lrRatqZTSU3GjckUJAkB26yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fPywn9OgwcH+oZdzeOuoNeo/ww5lHwtDcHSP9LvOS917zUnv+VD5xGalrjStSCvtT
         ln0EhY72dzDrrOBYVJj+SGjKRHXh7DUv4bMrtbiVnWTtsb+jlZ3wdxb/g9Q93yo6ol
         MPVSnOSLY950Ew7sf7yAquUVmoBkmk2DN8Fi7M8orpsnpK6QDzoI8dwxU9VmAklHu4
         phiwewdy7xZrxC9aufpHVIiV8G5BWh5PZW9Jrt1cyHv3M0zDSEhIo5mjRDdOQ8rqmm
         a8IWATw5tXKFwqWjEk8hZ5mafiWUM1c3v5Z+YCTHndu47IwFvNHhR0dIrAa+vSZPJ4
         X8AFfnDCK9DUA==
Date:   Fri, 14 Apr 2023 11:11:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 09/17] PCI: epf-test: Improve handling of command and
 status registers
Message-ID: <20230414161145.GA197986@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-10-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:49PM +0900, Damien Le Moal wrote:
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

s/bar/BAR/
s/a casts/a cast/ (I suspect this is still a lookup, not a cast)
s/achive/achieve/
s/mmio/MMIO/

I don't think "cast" is the right way to describe what's going on
here.

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ee90ba3a957b..fa48e9b3c393 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -613,9 +613,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
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
>  
>  	switch (reg->irq_type) {
>  	case IRQ_TYPE_LEGACY:
> @@ -659,12 +664,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
