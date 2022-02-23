Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4EB4C1D58
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 21:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiBWUwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiBWUwB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 15:52:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB71175;
        Wed, 23 Feb 2022 12:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E14F36184A;
        Wed, 23 Feb 2022 20:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06108C340E7;
        Wed, 23 Feb 2022 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645649491;
        bh=fuBbEnwtDxq+kiQXx8gxSj7IRCfE9GArt5C1WdOxPbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k600/LqrVOgUpVAQTlIMr5ar7Gb1FMGwtEL7yplP6HRlmTtueupWshev9F4nYEhUA
         YLLAMQLykHFJP60Ur1b2gxqkYtsCgRtS6cx9zhxQUfLlpHwgRzvm6ScAqmySiAl0aK
         uWDHI/ivvvl3hcjJHz57Ly/2Q+uCI0mKtMLdNeWdqbtGNQEQlRV2zX8LCh5P2gJDC1
         Zfo3EK1E0MV15ni2U5x53DKNoc+dnDyQuYcYIUgNSJmu24f+R8YVDcdMzOSXSDUX31
         VLXXTI9bp7sXld5FfnvXLS4XTTPl6+3xYH6FvQMEza2diqj4RD9UxhiRO4bQgbxf8U
         ivug1SmqHD64Q==
Date:   Wed, 23 Feb 2022 14:51:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCHv4 1/2] PCI: fu740: fix finding GPIOs
Message-ID: <20220223205129.GA148800@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221210347.1335004-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 21, 2022 at 09:03:46PM +0000, Ben Dooks wrote:
> The calls to devm_gpiod_get_optional() have the -gpios at the end of
> the name but the GPIO core code is already adding the suffix during
> the lookup. This means the PCIe driver is not finding the necessary
> reset or power lines to allow initialisation of the PCIe.
> 
> This bug has not been noticed as if U-Boot has setup the GPIO lines
> for the hardware when it does the PCIe initialisation (either by
> booting from PCIe or user command to access PCIe) then the PCIe
> will work in Linux. The U-Boot as supplied by SiFive does not by
> default initialise any PCIe component.

Lorenzo, if you apply this, would you mind s/fix/Fix/ in the subject?
Or maybe even update to "Drop redundant '-gpios' from DT GPIO lookup"?

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 00cde9a248b5..842b7202b96e 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(afp->mgmt_base);
>  
>  	/* Fetch GPIOs */
> -	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
> +	afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(afp->reset))
>  		return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get reset-gpios\n");
>  
> -	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
> +	afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
>  	if (IS_ERR(afp->pwren))
>  		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
>  
> -- 
> 2.34.1
> 
