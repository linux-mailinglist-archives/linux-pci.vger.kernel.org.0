Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8D69926D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBPK6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBPK6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:58:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8762D176
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:57:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8724CB826BF
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E59C433EF;
        Thu, 16 Feb 2023 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676545050;
        bh=H2pfX2zEwGBrFwIDkVDczWHt2iWioQU9IBCRkSAmZr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2Z2OkHDgjtoq/0cY6b+P/MMqNC/jGxS2LKt2denh+125rkp1+I23+MHKAazNi6uX
         08GFX5rNKbBiKbLnUAOj7D1b+Pz0ipPQBEiRpuP4od5cfdgI7A7xgdCblex062XqAw
         G8Z2cuay7QqL02A+gsFIp1eBCZ/NEMHmHjeUtlq7E3utFUtGWbQweOMtuK9LbkID5b
         eABqMGjC/iPTKtOoF9PDrB7cbwFiC5P/c3bSyxWcng1ZF6YE/17WxFI5A+uZfI3Wpt
         v3jpUf+Y32tLr7/FqyjiHVLlI/FBv0i0ACIVVL/E513bv74yCI8MeBi0nF0ao93C3l
         XI9860gQaku5w==
Date:   Thu, 16 Feb 2023 16:27:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/12] misc: pci_endpoint_test: Simplify
 pci_endpoint_test_msi_irq()
Message-ID: <20230216105716.GL2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-12-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-12-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:54PM +0900, Damien Le Moal wrote:
> Simplify the code of pci_endpoint_test_msi_irq() by correctly using
> booleans: remove the msix comparison to false as that variable is
> already a boolean, and directly return the result of the comparison of
> the raised interrupt number.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index baab08f983a2..b05d3db85da8 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -312,21 +312,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	struct pci_dev *pdev = test->pdev;
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 msix == false ? IRQ_TYPE_MSI :
> -				 IRQ_TYPE_MSIX);
> +				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 msix == false ? COMMAND_RAISE_MSI_IRQ :
> -				 COMMAND_RAISE_MSIX_IRQ);
> +				 msix ? COMMAND_RAISE_MSIX_IRQ :
> +				 COMMAND_RAISE_MSI_IRQ);
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
>  		return false;
>  
> -	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
> -		return true;
> -
> -	return false;
> +	return pci_irq_vector(pdev, msi_num - 1) == test->last_irq;
>  }
>  
>  static int pci_endpoint_test_validate_xfer_params(struct device *dev,
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
