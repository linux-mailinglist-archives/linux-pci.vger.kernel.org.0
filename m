Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C8699114
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBPKX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjBPKX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9610A9F
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15043B826AB
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F33C4339C;
        Thu, 16 Feb 2023 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676543030;
        bh=AHT6gjVy7FhjggQ0enVys6MXDIxbGM2QE+3M2Y66h2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu9SmNv0rgN3H92txePQAiBnA5rcvALAndXf96DlgplDFdVIvu7Fzh5cCdZWyKgmw
         pmcuJdy2SLq+A0e20mGqFqoWHkYAIFgidE301CKXobqe5V8XOUD+NxPS/sYA8JvcBU
         8lxujkw7h900kdDBRVBLnkTYcurVXY0erLXe6T4HYgZQT7/l89pe6QtqLgLO64ydny
         vOTLUkJOk+/EiloInfDKPIS+LB8gF710NaWGIMLz8KedsQpgke38TegXa/tcehEHj5
         HGoINqAGcYjGf2e+6grRqXIZDRU3iD1Es6RkeJtWUXfdsGQ8gLBiFXT99aMhMB6p99
         cqBywxw3SLxMQ==
Date:   Thu, 16 Feb 2023 15:53:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] pci: epf-test: Use driver registers as volatile
Message-ID: <20230216102338.GF2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-5-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-5-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:47PM +0900, Damien Le Moal wrote:
> The pci-epf-test driver uses struct pci_epf_test_reg directly from the
> test register bar memory to execute tests cases sent by the RC side.
> Make sure to declare pci_epf_test_reg use as volatile to ensure that
> modifications to the fields of that structure make it to memory to be
> seen by the RC side on completion.
> 
> Also initialize the test register bar to 0 when it is allocated.
> 

Again, please split this into a separate commit.

Rest LGTM!

Thanks,
Mani

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 030769893efb..df3074667bbc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -340,7 +340,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -441,7 +441,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -530,7 +530,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!dst_addr) {
> @@ -619,7 +619,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	reg->status |= STATUS_IRQ_RAISED;
>  
> @@ -653,7 +653,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	command = reg->command;
>  	if (!command)
> @@ -911,6 +911,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		dev_err(dev, "Failed to allocated register space\n");
>  		return -ENOMEM;
>  	}
> +	memset(base, 0, test_reg_size);
>  	epf_test->reg[test_reg_bar] = base;
>  
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
