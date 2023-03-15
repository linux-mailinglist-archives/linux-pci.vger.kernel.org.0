Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98276BB8A3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjCOPyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjCOPxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74D1E2A2
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98734B81E69
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED4CC433EF;
        Wed, 15 Mar 2023 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895588;
        bh=mlMUN7OdiSXVRyDWZKmjvVBVo7kur1ub1+cILjmYiJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW4zsZdIbrgjR1bw7yaSFSJVXjAcW1nSmt8oH50MUv8iEgmebr+L1A7ZWov89byHQ
         i9C5iIDBBKvXysnE3t/065ymht1txT2a/dfhQnDpq7X57tNRkid8EZM2RLFeY+uler
         Xb/tHVlrGDHHBs1Q0rsIjlMZkokVmzlaKKICHfykrfd+Ha22jtF6e1qAEkJbm37WMc
         ILeqzPkhqMGm/75ie3iZY8zW27Ur5nCluAkTr6D8NB6GX3czFA74L5T5TQkHbaSS6M
         eUnoGeT44pQBtzv88z/mrtwU5mcgOo+aZc6JgxQJ9hNX/uJPfvWObFFiOnm9TQO1VA
         HKrS+WYuoHF1g==
Date:   Wed, 15 Mar 2023 21:22:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] PCI: epf-test: Cleanup
 pci_epf_test_cmd_handler()
Message-ID: <20230315155257.GL98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-11-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-11-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:07PM +0900, Damien Le Moal wrote:
> Command codes are never combined together as flags into a single value.
> Thus we can replace the series of "if" tests in
> pci_epf_test_cmd_handler() with a cleaner switch-case statement.
> This also allows checking that we got a valid command and print an error
> message if we did not.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e0cf8c2bf6db..d1b5441391fb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -678,41 +678,39 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		goto reset_handler;
>  	}
>  
> -	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
> -	    (command & COMMAND_RAISE_MSI_IRQ) ||
> -	    (command & COMMAND_RAISE_MSIX_IRQ)) {
> +	switch (command) {
> +	case COMMAND_RAISE_LEGACY_IRQ:
> +	case COMMAND_RAISE_MSI_IRQ:
> +	case COMMAND_RAISE_MSIX_IRQ:
>  		pci_epf_test_raise_irq(epf_test, reg);
> -		goto reset_handler;
> -	}
> -
> -	if (command & COMMAND_WRITE) {
> +		break;
> +	case COMMAND_WRITE:
>  		ret = pci_epf_test_write(epf_test, reg);
>  		if (ret)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
>  			reg->status |= STATUS_WRITE_SUCCESS;
>  		pci_epf_test_raise_irq(epf_test, reg);
> -		goto reset_handler;
> -	}
> -
> -	if (command & COMMAND_READ) {
> +		break;
> +	case COMMAND_READ:
>  		ret = pci_epf_test_read(epf_test, reg);
>  		if (!ret)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
>  			reg->status |= STATUS_READ_FAIL;
>  		pci_epf_test_raise_irq(epf_test, reg);
> -		goto reset_handler;
> -	}
> -
> -	if (command & COMMAND_COPY) {
> +		break;
> +	case COMMAND_COPY:
>  		ret = pci_epf_test_copy(epf_test, reg);
>  		if (!ret)
>  			reg->status |= STATUS_COPY_SUCCESS;
>  		else
>  			reg->status |= STATUS_COPY_FAIL;
>  		pci_epf_test_raise_irq(epf_test, reg);
> -		goto reset_handler;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid command\n");
> +		break;
>  	}
>  
>  reset_handler:
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
