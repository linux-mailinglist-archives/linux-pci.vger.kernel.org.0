Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E76E2806
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDNQGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDNQGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDE903A
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CEC4648D9
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241CCC433EF;
        Fri, 14 Apr 2023 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488401;
        bh=AWM7jkvg00atL6EPbf7L25S5kgb9NeeqshtUAFpyw2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FsJelgsQxsTKYhNWjfpqobMokG0GzegupAIgGMlV0Pshfb4KthXUQ2zZzsLVNWnSA
         4ZXn21EEHabU3iQLcu3DEOK+lj4JnnklIqjb8JJ7Tk9MLPZg2hpDGLPiof3CrsANyL
         ONHYSATnimoJlayNIqeWdhkHCLCSTDh6SDBz+CJwkIK0QJiGRRNblByTFg8D1feyoZ
         WAjrkeqz+zPZCKw33fEikKJNpM4w8FXNsbP4PP0bcbhR7Mk66Id+ZSRPYIMtkfz1q6
         lRMIwF1vP2Io7Dbe5nHbFsb9QHxRq9gta2gy1jBfeRoLX/qI8ms6GJENRJHQnL0RdJ
         9sThGwUzPaZRw==
Date:   Fri, 14 Apr 2023 11:06:39 -0500
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
Subject: Re: [PATCH v4 06/17] PCI: epf-test: Simplify read/write/copy test
 functions
Message-ID: <20230414160639.GA197390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-7-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:46PM +0900, Damien Le Moal wrote:
> The function pci_epf_test_cmd_handler() casts the register bar to a
> struct pci_epf_test_reg to determine the command sent by the host and
> execute the test function accordingly. So there is no need for doing
> this cast again in each of the read, write and copy test functions. We
> can simply pass the reg pointer as an argument to the functions
> pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy().

s/bar/BAR/ in English text (as opposed to C code).

"Casting a register BAR" doesn't read quite right though, and I don't
see any casts below.

It looks like pci_epf_test_cmd_handler() looks up the pci_epf_test_reg
corresponding to epf_test->test_reg_bar, and this patch passes that
"struct pci_epf_test_reg *" around instead of having each function
look it up again?

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++++++-----------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7cdc6c915ef5..b8b178ac7cda 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -325,7 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
>  		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
>  }
>  
> -static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> +static int pci_epf_test_copy(struct pci_epf_test *epf_test,
> +			     struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	bool use_dma;
> @@ -337,8 +338,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -424,7 +423,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_read(struct pci_epf_test *epf_test)
> +static int pci_epf_test_read(struct pci_epf_test *epf_test,
> +			     struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *src_addr;
> @@ -438,8 +438,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -514,7 +512,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_write(struct pci_epf_test *epf_test)
> +static int pci_epf_test_write(struct pci_epf_test *epf_test,
> +			      struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *dst_addr;
> @@ -527,8 +526,6 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!dst_addr) {
> @@ -673,7 +670,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_WRITE) {
> -		ret = pci_epf_test_write(epf_test);
> +		ret = pci_epf_test_write(epf_test, reg);
>  		if (ret)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
> @@ -684,7 +681,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_READ) {
> -		ret = pci_epf_test_read(epf_test);
> +		ret = pci_epf_test_read(epf_test, reg);
>  		if (!ret)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
> @@ -695,7 +692,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_COPY) {
> -		ret = pci_epf_test_copy(epf_test);
> +		ret = pci_epf_test_copy(epf_test, reg);
>  		if (!ret)
>  			reg->status |= STATUS_COPY_SUCCESS;
>  		else
> -- 
> 2.39.2
> 
