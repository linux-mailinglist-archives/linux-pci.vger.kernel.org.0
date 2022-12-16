Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5864EE3B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiLPPxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiLPPxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 10:53:23 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD652713;
        Fri, 16 Dec 2022 07:53:06 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 85465E0EFC;
        Fri, 16 Dec 2022 18:53:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=BlqsW160MZlI49NjTuF7
        XmYKlcUm5mfF+05TJoJvOtE=; b=Mf2TwvIAUTPwFXIqnarhHdLi83phpmii33vN
        LdSKqw6W4fVa3yhCiy5d9Sw5KEHMi4O4zqfVXFSojn8Qj3LJWJQeu4LbpWK/nAmx
        +THbHjjM8sb+b9VX7TElEiCRM8USXOyWlT1PpcGrtSwsriNoZ4MukLCyl/9hR/vi
        Qhuj0bQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 648FEE0ED4;
        Fri, 16 Dec 2022 18:53:05 +0300 (MSK)
Received: from mobilestation (10.8.30.14) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 16 Dec 2022 18:53:05 +0300
Date:   Fri, 16 Dec 2022 18:53:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
Message-ID: <20221216155304.uckgqbcgotqj6bha@mobilestation>
References: <20221215103452.23131-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221215103452.23131-1-lukas.bulwahn@gmail.com>
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 15, 2022 at 11:34:52AM +0100, Lukas Bulwahn wrote:
> Commit a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN") removes the
> config PCI_MSI_IRQ_DOMAIN and makes all previous references to that config
> then refer to PCI_MSI instead.
> 
> Commit ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
> adds the config PCIE_BT1, which following the previous default pattern
> depends on the config PCI_MSI_IRQ_DOMAIN.
> 
> As these two commits were submitted roughly at the same time, the
> refactoring did not take of this occurrence and the addition did not yet
> notice the refactoring.
> 
> Take care of the PCI_MSI config refactoring on this latest addition.

Indeed. I just didn't know about the refactoring. Thanks for submitting
a fixup patch.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index a0d2713f0e88..99ec91e2a5cf 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -225,7 +225,7 @@ config PCIE_ARTPEC6_EP
>  config PCIE_BT1
>  	tristate "Baikal-T1 PCIe controller"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> -	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	help
>  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> -- 
> 2.17.1
> 
> 

