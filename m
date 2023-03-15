Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36896BB7BC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCOP2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCOP2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F36EA4
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DCEB81E57
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC2C433EF;
        Wed, 15 Mar 2023 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678894077;
        bh=HecdkH+hr/MWzP6p8KlcYi6+qqHeWM7qcbSY48FZ6OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRkcTlIvzZvqnOhC466HuvBQL0/rYs7yXQ1sy6JqqyQGg+suoooYhc75XsQMSCe12
         tKLdMi97zdp6lXYmwvqEpE+ObbBxZ2GhI3btBQ7y9bqDzxCewXINyWoIpC7HaOrkwO
         zbJWTv9mGbBXFi+zC1Ndxkn0ecVqt/kx0ZkVi5Myz6n0roP8a51PKHylh/5uff6n3z
         caN8NWnappv0l51Dr2eatwxX472niC6BrzhqN+iDO7LUBd8pV5l08zS3Mk4XwHelWW
         0FGcIMg1ITyHxedZLxltSG1YY9jL9N8BCSprOruqpLKr3X7U2e+rCr0Cw9LEpiEUaA
         +axqMPF3zXzEA==
Date:   Wed, 15 Mar 2023 20:57:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 07/16] PCI: epf-test: Simply pci_epf_test_raise_irq()
Message-ID: <20230315152744.GI98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-8-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-8-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:04PM +0900, Damien Le Moal wrote:
> Change the interface of the function pci_epf_test_raise_irq() to
> directly pass a pointer to the struct pci_epf_test_reg defining the test
> being executed. This avoids the need for grabbing this pointer with a
> cast of the register bar and simplifies the call sites as the irq type
> and irq numbers do not have to be passed as arguments.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1fc245d79a8e..6f4ef5251452 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -609,29 +609,27 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
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
> @@ -677,8 +675,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
>  			reg->status |= STATUS_WRITE_SUCCESS;
> -		pci_epf_test_raise_irq(epf_test, reg->irq_type,
> -				       reg->irq_number);
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> @@ -688,8 +685,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
>  			reg->status |= STATUS_READ_FAIL;
> -		pci_epf_test_raise_irq(epf_test, reg->irq_type,
> -				       reg->irq_number);
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> @@ -699,8 +695,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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

-- 
மணிவண்ணன் சதாசிவம்
