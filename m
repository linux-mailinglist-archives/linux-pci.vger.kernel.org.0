Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325A792FAD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjIEUOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjIEUOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 16:14:04 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:13:41 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065719AA
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 13:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4597C43391;
        Tue,  5 Sep 2023 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937612;
        bh=JZ89/z9Ht6rDA/XSMnZOdqIrwGbncflIYGN6is8GLGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AgicTTkon2sgYiY1BmJKdYNXN2Jo83G2WX7aZBT80rQZiIwxH6CiuUxNLPZ+MuWVy
         yvHuhR+wwaA49xmJWX8Llr4MUXUw7zlZz6v08RXwOQRC6a+ECt3jE2FiHE/DbqR2tG
         F4e83LrM9BaxV8l8sW/5H+AuuTEfrGQyfhWju5+i3Mmoy8cvwavbSBErwI2ieRmPwF
         oIKXvPt7/Zb1Jy7EWP9fo4Yax8oNj94hobS7Zr8GPRsQY+fAn+x2mMA7Q+lSvr49Dm
         E++sDVbhMfwOsCyw1lrgD14UcjJF3x/3M/KJgDos85T7725dVFkOh9Bsnkc9q2sTiA
         3LsIUFSNI/Bvg==
Date:   Tue, 5 Sep 2023 13:13:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     groeck7@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix CONFIG_PCI_DYNAMIC_OF_NODES kconfig dependencies
Message-ID: <20230905181329.GA177410@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693505947-29786-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 31, 2023 at 11:19:07AM -0700, Lizhi Hou wrote:
> Generating interrupt-map property depends on of_irq_parse_raw() which
> is enabled by CONFIG_OF_IRQ. Change CONFIG_PCI_DYNAMIC_OF_NODES
> dependency from CONFIG_OF to CONFIG_OF_IRQ.

Most of include/linux/of_irq.h is under #ifdef CONFIG_OF_IRQ, with
stubs for the non-CONFIG_OF_IRQ case, with of_irq_parse_raw() being
one of a few exceptions.

In the PCI_DYNAMIC_OF_NODES case, I think we probably want the Kconfig
change in this patch because adding a stub would avoid the build error
but the PCI_DYNAMIC_OF_NODES functionality wouldn't work.

I dunno about the other uses of of_irq_parse_raw().
arch/powerpc/platforms/fsl_uli1575.c also uses it but has no obvious
CONFIG_OF dependency.

drivers/bcma/main.c uses it, but the call is under a CONFIG_OF_IRQ
guard, and I guess the dead code gets eliminated when building without
CONFIG_OF.

> Reported-by: Guenter Roeck <groeck7@gmail.com>
> Closes: https://lore.kernel.org/linux-devicetree/2187619d-55bc-41bb-bbb4-6059399db997@roeck-us.net/
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Applied to for-linus for v6.6-rc1.  Rob, let me know if you want it.

> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 49bd09c7dd0a..e9ae66cc4189 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -196,7 +196,7 @@ config PCI_HYPERV
>  
>  config PCI_DYNAMIC_OF_NODES
>  	bool "Create Device tree nodes for PCI devices"
> -	depends on OF
> +	depends on OF_IRQ
>  	select OF_DYNAMIC
>  	help
>  	  This option enables support for generating device tree nodes for some
> -- 
> 2.34.1
> 
