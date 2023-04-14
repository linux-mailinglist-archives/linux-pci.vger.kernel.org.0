Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ADF6E2837
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjDNQT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDNQTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99783F7
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C086490A
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD471C433EF;
        Fri, 14 Apr 2023 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681489177;
        bh=J4TIF5LyBNsj/rxMibJ7SwAH7SMzP48ulNmtTq4Kln0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s2+a/QBzEqcGZnKiObsLK4kWvC7cX89DFN8TV3+x+U0q5UDcVsCuf33hY22vgFmCF
         X64eLr0iQPR2BFW1nALn8vzciJ5fEeaSlaOM+yQKeedvVTphF6wfv1LbIC56oiy8Cf
         b+xDNBWpvKl6ftuKHha+1m5TSZurC6VqkmfqBxQZAy26lxP466rf17gFux1TSpWR2I
         t1kGVBYf0oIvk+AW6lQKuW/SsjgRXaNxpx+Hv90hiLBn7LkbWIX1FDcXNeeMOHXDek
         11lWBCnw1XqPJds3x5XY1Xr2rfRc6lawVe0rOxdr98Fy94SO7ap0lkZlPbbNLo0K+S
         wj7FgVHiXlOrA==
Date:   Fri, 14 Apr 2023 11:19:35 -0500
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
Subject: Re: [PATCH v4 17/17] misc: pci_endpoint_test: Simplify
 pci_endpoint_test_msi_irq()
Message-ID: <20230414161935.GA198833@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-18-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:57PM +0900, Damien Le Moal wrote:
> Simplify the code of pci_endpoint_test_msi_irq() by correctly using
> booleans: remove the msix comparison to false as that variable is
> already a boolean, and directly return the result of the comparison of
> the raised interrupt number.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index afd2577261f8..ed4d0ef5e5c3 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -313,21 +313,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	struct pci_dev *pdev = test->pdev;
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> -				 msix == false ? IRQ_TYPE_MSI :
> -				 IRQ_TYPE_MSIX);
> +				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);

Nice, much better :)
