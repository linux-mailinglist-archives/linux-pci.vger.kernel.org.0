Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B66BB80B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjCOPiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjCOPiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:38:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B26189C
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A6C3B81DFA
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F197C433D2;
        Wed, 15 Mar 2023 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678894653;
        bh=i4eYuuUmcAMc23uUTyPzwPS33s94ovxQn8dVYe0Wti4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7ajDhV9GvHw/BOBzAWImSzpjtZNe6/vQnjaVnRDouB8ti0y2tZISOOhI/GTll6bd
         N1Fs3JkKWokpB351GcG47fn20EL/eq+12ABzpCG1ALK6yyoDO284lSaCiLjQ+2PJLK
         ApPqmsg9Mk7AjIkR9Aagn80lSlV0Cl7E2+xOg6Jb5lR2G9gfzOH8utIlyr4hhVLk5y
         R4MYkBNxEs1GoCH5juszxkTlahE0PWORrogT5QBD2lnz5dkL+D8x3xEhar7Anh9GL2
         C91G5ihNqKt3ZshI6HtAAVEg0h7pFAVhzdDSUqJj2Gw794Ui3HVtGDtaG3K0Bd2Omu
         6LJqMMnAnTk6A==
Date:   Wed, 15 Mar 2023 21:07:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 08/16] PCI: epf-test: Simplify IRQ test commands
 execution
Message-ID: <20230315153520.GJ98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-9-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-9-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:05PM +0900, Damien Le Moal wrote:
> For the commands COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ and
> COMMAND_RAISE_MSIX_IRQ, the function pci_epf_test_cmd_handler()
> sets the STATUS_IRQ_RAISED status flag and calls the epc function
> pci_epc_raise_irq() directly. However, this is also exactly what the
> pci_epf_test_raise_irq() function does. Avoid duplicating these
> operations by directly using pci_epf_test_raise_irq() for the IRQ test
> commands. It is OK to do so as the host side endpoint test driver always
> set the correct irq type for the IRQ test commands.
> 
> At the same time, the irq number check done for the
> COMMAND_RAISE_MSI_IRQ and COMMAND_RAISE_MSIX_IRQ commands can also be
> moved to pci_epf_test_raise_irq() to also check the IRQ number requested
> by the host for other test commands.
> 
> Overall, this significantly simplifies the pci_epf_test_cmd_handler()
> function.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++++-----------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6f4ef5251452..43d623682850 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -615,6 +615,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	int count;
>  
>  	reg->status |= STATUS_IRQ_RAISED;
>  
> @@ -624,10 +625,22 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  				  PCI_EPC_IRQ_LEGACY, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
> +		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> +		if (reg->irq_number > count || count <= 0) {
> +			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
> +				reg->irq_number, count);
> +			return;
> +		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
>  				  PCI_EPC_IRQ_MSI, reg->irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
> +		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> +		if (reg->irq_number > count || count <= 0) {
> +			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
> +				reg->irq_number, count);
> +			return;
> +		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
>  				  PCI_EPC_IRQ_MSIX, reg->irq_number);
>  		break;
> @@ -640,13 +653,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  static void pci_epf_test_cmd_handler(struct work_struct *work)
>  {
>  	int ret;
> -	int count;
>  	u32 command;
>  	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
>  						     cmd_handler.work);
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
> -	struct pci_epc *epc = epf->epc;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
> @@ -662,10 +673,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		goto reset_handler;
>  	}
>  
> -	if (command & COMMAND_RAISE_LEGACY_IRQ) {
> -		reg->status = STATUS_IRQ_RAISED;
> -		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
> +	    (command & COMMAND_RAISE_MSI_IRQ) ||
> +	    (command & COMMAND_RAISE_MSIX_IRQ)) {
> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  
> @@ -699,26 +710,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		goto reset_handler;
>  	}
>  
> -	if (command & COMMAND_RAISE_MSI_IRQ) {
> -		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0)
> -			goto reset_handler;
> -		reg->status = STATUS_IRQ_RAISED;
> -		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSI, reg->irq_number);
> -		goto reset_handler;
> -	}
> -
> -	if (command & COMMAND_RAISE_MSIX_IRQ) {
> -		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0)
> -			goto reset_handler;
> -		reg->status = STATUS_IRQ_RAISED;
> -		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSIX, reg->irq_number);
> -		goto reset_handler;
> -	}
> -
>  reset_handler:
>  	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>  			   msecs_to_jiffies(1));
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
