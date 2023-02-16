Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBE69A258
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 00:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBPX1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 18:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBPX1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 18:27:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9954D0B;
        Thu, 16 Feb 2023 15:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85990CE2DA9;
        Thu, 16 Feb 2023 23:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DBC433D2;
        Thu, 16 Feb 2023 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676589943;
        bh=ApGyak3N0lX5AvA8LbtVHhCvbMUZiJnNae82WU6+9s4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qmmg2KrmN2wEvaeIda03zIm4rGcSiRalcDN+z0oJx0nO0xC5/ScEGVsTb+W2cSomO
         buA59QQhkpofkBdWC6Z/SHUHxNsRJBy3ChdGh0nDbXH8j6Dhe/MHhiNQWyS/MqzJwx
         7efhujHtVD8v+Vp1+PIZW3QMVJ50be33F/5hDNj5qvKKgmxyvsFHRS/YxNUSC0uSHI
         hhwkXx/abPSbrLNJJus8PKufiWd9GzMYFmaMkd4FFXyXaKNrn9S5qFcq36Og34jQcr
         V82X+VGU8QmAwgcXe96mZz2Wl7MSPxwm3CWf//6Jw7dSNJlRHZqHM0HqMj1qOsJWnY
         Z/5iGBwtkTRfA==
Date:   Thu, 16 Feb 2023 17:25:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: clean up duplicate dependency in config
 PCI_HYPERV_INTERFACE
Message-ID: <20230216232541.GA3354637@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215101310.9135-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 15, 2022 at 11:13:10AM +0100, Lukas Bulwahn wrote:
> Commit a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN") removes the
> config PCI_MSI_IRQ_DOMAIN and makes all previous references to that config
> then refer to PCI_MSI instead.
> 
> In the refactoring of config PCI_HYPERV_INTERFACE, it creates a duplicate
> dependency on PCI_MSI. Remove this needless duplicate dependency.
> 
> No functional change. Just a stylistic clean-up.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied to pci/misc for v6.3, thanks, Lukas!

> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 1569d9a3ada0..c2261da85f7b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -285,7 +285,7 @@ config PCIE_BRCMSTB
>  
>  config PCI_HYPERV_INTERFACE
>  	tristate "Hyper-V PCI Interface"
> -	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI
> +	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
>  	help
>  	  The Hyper-V PCI Interface is a helper driver allows other drivers to
>  	  have a common interface with the Hyper-V PCI frontend driver.
> -- 
> 2.17.1
> 
