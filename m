Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A466BB797
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOPYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjCOPY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39319F18
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 865706195F
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186D8C433D2;
        Wed, 15 Mar 2023 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678893865;
        bh=TbXNpkLDyvfstM57As6UUaWSkvqMRGcclpDsHzO/n6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=di3t2ol7bDkZM1J78YGhla7wj89o8FqaSZCOxj2TEUSJBpyEeZQyF1HpQhO7mBCK2
         R4RDJTGycB2xi5IDUWIRXCrhchqRoQQe1nAO32H9oDt/lDEkGPdhJTx4LC8BXRRx/8
         +wZJpV4eU8vS2kdz33QA0oVP1UUTqEgcD3szZrD179UOfuRn8q4yb56ycpSd6miAC6
         NYV4DXQV7LZ4+XBzoBe/9ttxF7Oxd39XmwBaU2epwQuuoaV777YBkyKJDeEXT9KDtj
         uwBen24Bn1U+HXTH5GWDZFQbaMrWlaS0DEcNTN4hjfl5piQgnIIwtB+81+dbpwuiWP
         ZfwfBhEfWt43g==
Date:   Wed, 15 Mar 2023 20:54:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 06/16] PCI: epf-test: Simplify read/write/copy test
 functions
Message-ID: <20230315152410.GH98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-7-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-7-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:03PM +0900, Damien Le Moal wrote:
> The function pci_epf_test_cmd_handler() casts the register bar to a
> struct pci_epf_test_reg to determine the command sent by the host and
> execute the test function accordingly. So there is no need for doing
> this cast again in each of the read, write and copy test functions. We
> can simply pass the reg pointer as an argument to the functions
> pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++++++-----------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3dce9827bd2a..1fc245d79a8e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -327,7 +327,8 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
>  		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
>  }
>  
> -static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> +static int pci_epf_test_copy(struct pci_epf_test *epf_test,
> +			     struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	bool use_dma;
> @@ -339,8 +340,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -426,7 +425,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_read(struct pci_epf_test *epf_test)
> +static int pci_epf_test_read(struct pci_epf_test *epf_test,
> +			     struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *src_addr;
> @@ -440,8 +440,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -516,7 +514,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_write(struct pci_epf_test *epf_test)
> +static int pci_epf_test_write(struct pci_epf_test *epf_test,
> +			      struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *dst_addr;
> @@ -529,8 +528,6 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!dst_addr) {
> @@ -675,7 +672,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_WRITE) {
> -		ret = pci_epf_test_write(epf_test);
> +		ret = pci_epf_test_write(epf_test, reg);
>  		if (ret)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
> @@ -686,7 +683,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_READ) {
> -		ret = pci_epf_test_read(epf_test);
> +		ret = pci_epf_test_read(epf_test, reg);
>  		if (!ret)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
> @@ -697,7 +694,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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

-- 
மணிவண்ணன் சதாசிவம்
