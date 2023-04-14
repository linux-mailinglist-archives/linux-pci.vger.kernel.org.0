Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3C6E2810
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNQIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDNQIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100981BDF
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF8761697
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A80C433D2;
        Fri, 14 Apr 2023 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488512;
        bh=dDMamS49XkSHKHUY2uLDO40UBYuAJkA24fDQLofuJng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eIsXvKAp5eFzhjrTpQe/9lsXokTENdm9ONi1TRSR6EwQHQHKbrZzaM6ONouO+uMns
         7hgjImlbClUtPRg1j6nP0zW1MyqykuQiQsxwPg6GwDvykCIFm+e7IJTfhEezMyJYeq
         GLTM0JfXKRq2x7JZB7ZyRY+oEKES7VQ/nfKQz9d9z18p3m0awY7bnxaDQH0BLinxz/
         2xI48UhXS5vIgn+SK5bm48umRIuxZvA5hUtmjrbg87UkjmFED8N92k8/7boBgziOmd
         AWgvBZ45x53K1OQhhI8ROH9s+MOqkys+4z4xZfGYdDWeuyg2GVbDx8RsrREkkymGIi
         VVM1FCw85/oTA==
Date:   Fri, 14 Apr 2023 11:08:30 -0500
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
Subject: Re: [PATCH v4 07/17] PCI: epf-test: Simplify pci_epf_test_raise_irq()
Message-ID: <20230414160830.GA197687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-8-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:47PM +0900, Damien Le Moal wrote:
> Change the interface of the function pci_epf_test_raise_irq() to
> directly pass a pointer to the struct pci_epf_test_reg defining the test
> being executed. This avoids the need for grabbing this pointer with a
> cast of the register bar and simplifies the call sites as the irq type
> and irq numbers do not have to be passed as arguments.

s/bar/BAR/
s/irq/IRQ/

Looks conceptually the same as the previous patch, where we're doing a
lookup and passing around the result instead of having the callee redo
the lookup.

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index b8b178ac7cda..3835e558937a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -607,29 +607,27 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
>  	return ret;
>  }
>  
> -static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
> -				   u16 irq)
> +static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> +				   struct pci_epf_test_reg *reg)
>  {
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	reg->status |= STATUS_IRQ_RAISED;
>  
> -	switch (irq_type) {
> +	switch (reg->irq_type) {
>  	case IRQ_TYPE_LEGACY:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
>  				  PCI_EPC_IRQ_LEGACY, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSI, irq);
> +				  PCI_EPC_IRQ_MSI, reg->irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSIX, irq);
> +				  PCI_EPC_IRQ_MSIX, reg->irq_number);
>  		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
> @@ -675,8 +673,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
>  			reg->status |= STATUS_WRITE_SUCCESS;
> -		pci_epf_test_raise_irq(epf_test, reg->irq_type,
> -				       reg->irq_number);
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> @@ -686,8 +683,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
>  			reg->status |= STATUS_READ_FAIL;
> -		pci_epf_test_raise_irq(epf_test, reg->irq_type,
> -				       reg->irq_number);
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> @@ -697,8 +693,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_COPY_SUCCESS;
>  		else
>  			reg->status |= STATUS_COPY_FAIL;
> -		pci_epf_test_raise_irq(epf_test, reg->irq_type,
> -				       reg->irq_number);
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> -- 
> 2.39.2
> 
