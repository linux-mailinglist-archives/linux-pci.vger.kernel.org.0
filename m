Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA816C6CE8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCWQGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCWQF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 12:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6262BF03;
        Thu, 23 Mar 2023 09:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1700762582;
        Thu, 23 Mar 2023 16:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8F0C433D2;
        Thu, 23 Mar 2023 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679587557;
        bh=erq5KugyEyInp+1CXdRbEcUBGVhHqPMfmw0xk7LsNFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L0xXih9gDDEX0ABuzTzfOtjKtRBsimvi1+/TLswHlPpI2e3BPFW8PBg4ruainuAZP
         P9YfO90YDzM8G1u4DtHoc3XGWG2xoBjRYfffHzwDQz3qISxnsoDXSOgBIodSY+E1oK
         FgEXH/WMzwO5hXBg/eA8TwkFD4ajo+kk3BJBrFek++mVQ6gP6VBfj00XbHRHheRGSo
         92uKYNuVnMliRoW5gS/WYBS9hO93mkApa4vvXWAR9nNZj5XX1ZlWdfGZ6FlspdQFY5
         F2rD4ArgZPN9iJLvFVjg45+BV4GPSYp5FVQ9b672vsE0EQ3ERWxTNf+/C9YGaQd5zv
         jXDf1PLw2lDoQ==
Date:   Thu, 23 Mar 2023 11:05:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: apple: Set only available ports up
Message-ID: <20230323160555.GA2555502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-apple_pcie_disabled_ports-v3-1-0dfb908f5976@jannau.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Janne, thanks for the patch!

On Thu, Mar 23, 2023 at 09:10:12AM +0100, Janne Grunau wrote:
> The Apple SoC devicetrees used to delete unused PCIe ports.

Maybe "used to *omit* unused PCIe ports"?  I assume the DT previously
did not mention PCIe ports at all, but now the ports are included but
marked "disabled"?

> Avoid to set
> up disabled PCIe ports to keep the previous behaviour. MacOS initialized
> also only ports with a known device.

The patch is fine with me, but the commit log doesn't tell us why we
want this patch in addition to 6fffbc7ae137 ("PCI: Honor firmware's
device disabled status"), since your previous response [1] says
6fffbc7ae137 already does all the above.

I don't have any Apple specs, but from looking at the code, the
additional benefits of this patch over 6fffbc7ae137 might be:

  - We won't trip over DT issues, like "reset" or "reg" not being
    defined.

  - We won't allocate needless apple_pcie_port structs.

  - We won't ioremap register space, assert PERST#, setup clocks and
    IRQs.

  - We won't sleep waiting for things to come up, potentially saving
    150ms or more for each disabled port.

  - Maybe there's some power savings; I can't tell.

It's probably more detail than necessary to mention *all* of that, but
the commit log should say *something* about why we want this in
addition to 6fffbc7ae137.

> Use for_each_available_child_of_node instead of for_each_child_of_node
> which takes the "status" property into account.

Would you mind adding "()" after the function names, too?  Just my own
idiosyncrasy to help distinguish them from regular English text.

Bjorn

[1] https://lore.kernel.org/r/20230316212217.GI24656@jannau.net

> Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
> Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v3:
> - dropped Cc: stable
> - rewritten commit message since the warning is fixed by 6fffbc7ae137 ("PCI: Honor firmware's
> device disabled status")
> - Link to v2: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v2-1-c3bd1fd278a4@jannau.net
> 
> Changes in v2:
> - rewritten commit message with more details and corrections
> - collected Marc's "Reviewed-by:"
> - Link to v1: https://lore.kernel.org/r/20230307-apple_pcie_disabled_ports-v1-1-b32ef91faf19@jannau.net
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 66f37e403a09..f8670a032f7a 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -783,7 +783,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  	cfg->priv = pcie;
>  	INIT_LIST_HEAD(&pcie->ports);
>  
> -	for_each_child_of_node(dev->of_node, of_port) {
> +	for_each_available_child_of_node(dev->of_node, of_port) {
>  		ret = apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
>  			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
> 
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230307-apple_pcie_disabled_ports-0c17fb7a4738
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
