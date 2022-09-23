Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF55E7CA4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiIWOPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiIWOPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 10:15:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD134109638;
        Fri, 23 Sep 2022 07:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689A9B8360F;
        Fri, 23 Sep 2022 14:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1778C433D6;
        Fri, 23 Sep 2022 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663942528;
        bh=1AEcv2sMJqybL3a/melDfwWejdXEdqsvn6UZFqQXk0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KO/FydUZ6XN6vBhLT7QRnwB5Xe/lkshw7359t/XGWUVY3nZ6Brhtd/b4mj51hk5Ya
         teE0g2+L/r9SpFkcVnl9ISTxozo4Ew6R6BpfAd9LsOETTzQj/jZQKis2PH3fMjV266
         QcJwIELCFD9UNnWUnlmMUWV7qNNk97IsP7CHEwppi2meC3pMzKQwOUx6KKV0IjcnOl
         dms4TAusM5nqHJk8tPVe03Z0yfOUZMocomBgW1lNMyAT6jKUmzMsFKapsS4AXPKBmk
         86g55mvkOHVPvxjNW79d8LFrtmT0T6fVf9Kq8y4BbVvr1sryoDbx43j8LXgutChbIB
         We6XJ/zOy1iBw==
Date:   Fri, 23 Sep 2022 09:15:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 04/14] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
Message-ID: <20220923141526.GA1388290@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663913220-9523-5-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 02:06:50PM +0800, Richard Zhu wrote:
> Since i.MX PCIe is one dual mode PCIe controller.

This is not a sentence.

> Add i.MX PCIe EP mode support, and split the PCIe modes to the Root
> Complex mode and Endpoint mode.

Add blank lines between paragraphs or rewrap into a single paragraph
that fills 75 columns.

I think you should split "[12/14] PCI: imx6: Add iMX8MM PCIe EP mode"
into:

  - A patch that adds the generic endpoint infrastructure, e.g.,
    imx6_pcie_ep_init(), imx6_pcie_ep_raise_irq(), imx6_add_pcie_ep().

  - A second patch that adds the i.MX8MM identifiers.

That way the i.MX8MM patch will be analogous to the i.MX8MQ and
i.MX8MP patches.

Then you could squash this Kconfig patch into the generic endpoint
infrastructure patch because this patch is what selects PCIE_DW_EP,
which is what ensures that dw_pcie_ep_reset_bar(),
dw_pcie_ep_raise_legacy_irq(), etc., are available.

> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -92,10 +92,33 @@ config PCI_EXYNOS
>  	  functions to implement the driver.
>  
>  config PCI_IMX6
> -	bool "Freescale i.MX6/7/8 PCIe controller"
> +	bool
> +
> +config PCI_IMX6_HOST
> +	bool "Freescale i.MX6/7/8 PCIe controller host mode"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
> +	select PCI_IMX6
> +	help
> +	  Enables support for the PCIe controller Root Complex mode in the
> +	  iMX6/7/8 SoCs.

> +	  This controller can work either as EP or RC. In order to enable
> +	  host-specific features PCIE_DW_HOST must be selected and in order
> +	  to enable device-specific features PCIE_DW_EP must be selected.

I don't think these three lines are useful to the user.  They only
describe what Kconfig does when PCI_IMX6_HOST is enabled, which is
really an internal implementation detail.

> +config PCI_IMX6_EP
> +	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCI_IMX6
> +	help
> +	  Enables support for the PCIe controller endpoint mode in the
> +	  iMX6/7/8 SoCs.
> +	  This controller can work either as EP or RC. In order to enable
> +	  host-specific features PCIE_DW_HOST must be selected and in order
> +	  to enable device-specific features PCIE_DW_EP must be selected.

Ditto.

>  config PCIE_SPEAR13XX
>  	bool "STMicroelectronics SPEAr PCIe controller"
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
