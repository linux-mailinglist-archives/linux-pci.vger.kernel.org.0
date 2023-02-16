Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A19699237
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBPKvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBPKvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA710EB
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE69B826AA
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF3C4339B;
        Thu, 16 Feb 2023 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676544698;
        bh=ERkjXqRrmIrXvsizwatqtVkflTE/PI7z+KOvJN42oqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCoWAxHj+SP800co0Xy0coQfju3U43wyWorFk22okVd6m71F1pmaMCs/WvvbM8RdB
         ROO1lBj2yGXtNiwHVTjqfzfTPiVYUCNdZyp9e4wnef9Sy/wxo4e1wu3DwgBKPfSJXb
         EwMspihfE2hVWgSMPOeySgk3YIL7lfDVHx5nTTdIXzP9M4WLcezDlOJRwfdaYvIirx
         J95xXvYWy17urkwKJoqf5LwgzkA8CvrSDir/W+yXCv3bSYl5YdlgbskO1H1fq9nIfj
         RFpazoRLqqi2/6KOQYVb4J3F3DkdQci5AqZUrVj2vsAPUJJg2w5twk7O+tVTBT6rKu
         rKxK9zfgFXC0Q==
Date:   Thu, 16 Feb 2023 16:21:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/12] misc: pci_endpoint_test: Do not write status in
 IRQ handler
Message-ID: <20230216105124.GJ2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-10-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-10-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:52PM +0900, Damien Le Moal wrote:
> pci_endpoint_test_irqhandler() always rewrites the status register when
> an IRQ is raised, either as-is if STATUS_IRQ_RAISED is not set, or with
> STATUS_IRQ_RAISED cleared if that flag is set. The first case creates a
> race window with the endpoint side, meaning that the host side test
> driver may end up reading what it just wrote, thus loosing the real
> status as set by the endpoint side before raising the next interrupt.
> This can prevent detecting that the STATUS_IRQ_RAISED flag was set by
> the endpoint.
> 
> Remove this race window by not clearing the STATUS_IRQ_RAISED status
> flag and not rewriting that register for every IRQ received.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index e27d471cc847..c1370950c79d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -158,10 +158,7 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>  	if (reg & STATUS_IRQ_RAISED) {
>  		test->last_irq = irq;
>  		complete(&test->irq_raised);
> -		reg &= ~STATUS_IRQ_RAISED;
>  	}
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
> -				 reg);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
