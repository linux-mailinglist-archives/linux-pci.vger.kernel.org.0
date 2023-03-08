Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA66B1153
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 19:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCHSt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCHStZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 13:49:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B1B7D9F;
        Wed,  8 Mar 2023 10:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749396190F;
        Wed,  8 Mar 2023 18:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999C3C433D2;
        Wed,  8 Mar 2023 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678301363;
        bh=hjqn5JVWJwWwnk2YIxMMq8dT+5sWwomaupQDfPrK2R4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tQRMEAoBGTJJH0VOZd7LunGNwgg1NH/ZDCaZvTDRvRUfhDaFu7SW1LAd5BC1tDzrJ
         m/oCYcNn2ny4evrU2DK1pJqKxX25/pSp4+mcLVBFOmNv2QeUTlZkP6sTi52Xx/9ftU
         DM9mPVuz6B7TAUNR+I0fv4Sl2bJYnAoxFw15MWli2IfwuIEO7V3O9rC0CGwJDqQpe1
         LuzkQSfJjsKgq/098vkeFpOlORZPTldzi2A5sgDWOiV5rdm4uxeBvf1si56NcUk2gc
         /FImIfHa2Ys5wCkXCrjcIqfINSM/oRPDnoAZRHLxeqKs6SLKESFeBqj3kC8sWSyXYD
         fqx9WA9WLWv6w==
Date:   Wed, 8 Mar 2023 12:49:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH] PCI: imx6: install the fault handler only if we are
 really running on a compatible device
Message-ID: <20230308184922.GA1029723@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1c18c70bea1d6f99c88027dc72c700e8c309a2.1677573834.git.hns@goldelico.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 09:43:54AM +0100, H. Nikolaus Schaller wrote:
> commit bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
> added a fault hook to this driver in the probe function. So it was only
> installed if needed.
> 
> commit bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
> moved it from probe to driver init which installs the hook unconditionally
> as soon as the driver is compiled into a kernel.
> 
> When this driver is compiled as a module, the hook is not registered
> until after the driver has been matched with a .compatible and
> loaded.
> 
> commit 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
> extended the fault handling code.
> 
> commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> added some protection for non-ARM architectures, but this does not
> protect non-i.MX ARM architectures.

Are *all* these commits relevant?  Question also applies to Fixes:
below.

> Since fault handlers can be triggered on any architecture for different
> reasons, there is no guarantee that they will be triggered only for the
> assumed situation, leading to improper error handling (i.MX6-specific
> imx6q_pcie_abort_handler) on foreign systems.
> 
> I had seen strange L3 imprecise external abort messages several times on
> OMAP4 and OMAP5 devices and couldn't make sense of them until I realized
> they were related to this unused imx6q driver because I had
> CONFIG_PCI_IMX6=y.

Apparently imx6q_pcie_abort_handler() assumes it is always called
because of a PCI abort?  If so, that sounds problematic.

If non-PCI imprecise aborts happen on OMAP4 and OMAP5 where imx6q is
unused and imx6q_pcie_abort_handler() is not appropriate, I assume
similar non-PCI aborts can also happen on systems where imx6q *is*
used.

So imx6q_pcie_abort_handler() may be trying to fixup non-PCI aborts
when it shouldn't?

> Note that CONFIG_PCI_IMX6=y is useful for kernel binaries that are designed
> to run on different ARM SoC and be differentiated only by device tree
> binaries. So turning off CONFIG_PCI_IMX6 is not a solution.
> 
> Therefore we check the compatible in the init function before registering
> the fault handler.
> 
> Fixes: bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
> Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
> Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1dde5c579edc8..89774aa187ae8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1402,6 +1402,15 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
>  static int __init imx6_pcie_init(void)
>  {
>  #ifdef CONFIG_ARM
> +	const struct of_device_id *reboot_id;
> +	struct device_node *np;
> +
> +	np = of_find_matching_node_and_match(NULL, imx6_pcie_of_match,
> +					     &reboot_id);

Since you don't need reboot_id, I think you should use
of_find_matching_node() instead.

> +	if (!np)
> +		return -ENODEV;
> +	of_node_put(np);
> +
>  	/*
>  	 * Since probe() can be deferred we need to make sure that
>  	 * hook_fault_code is not called after __init memory is freed
> -- 
> 2.38.1
> 
