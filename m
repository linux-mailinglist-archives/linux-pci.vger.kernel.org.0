Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11157697AE1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjBOLe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 06:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBOLe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 06:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6238022
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:34:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C5B61B6B
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 11:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CDAC433EF;
        Wed, 15 Feb 2023 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676460844;
        bh=1cgH50/BOpwTa5iyaYN6FbGn54/RATCHpdFyrYFPwms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlrK09zKDk9jkqGE3yIC/veoWYA8wBHb8H4icETPmX2xWHoa2jInNo/teqMC9SPif
         lyF62yNGagKaC0TtPJraFu1kz2tT1uSrn2gdwwOPFQIog2UWWfr97GnYI2jS31St5e
         8YdJgLYRg4ElnaaBoeYyYxDgxcPrQmtgmT3xJ7yc=
Date:   Wed, 15 Feb 2023 12:34:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/12] misc: pci_endpoint_test: Add debug and error
 messages
Message-ID: <Y+zDKTVjmE3zRIOO@kroah.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-13-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215032155.74993-13-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:55PM +0900, Damien Le Moal wrote:
> Add dynamic debug messages with dev_dbg() to help troubleshoot issues
> when running the endpoint tests. The debug messages for errors detected
> in pci_endpoint_test_validate_xfer_params() are changed to error
> messages.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index b05d3db85da8..c47f6e708ea2 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -267,12 +267,15 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	u32 val;
>  	int size;
>  	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
>  
>  	if (!test->bar[barno])
>  		return false;
>  
>  	size = pci_resource_len(pdev, barno);
>  
> +	dev_dbg(dev, "Test BAR %d, %d B\n", (int)barno, size);
> +
>  	if (barno == test->test_reg_bar)
>  		size = 0x4;
>  
> @@ -291,6 +294,10 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  {
>  	u32 val;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	dev_dbg(dev, "Test legacy IRQ\n");

Please don't do this, it's one of the things that we remove from
drivers before merging.

If you need to follow the driver flow, then use ftrace, that's what it
is there for, don't add this type of "now in this function!" debug
lines, as that is redundant.

thanks,

greg k-h
