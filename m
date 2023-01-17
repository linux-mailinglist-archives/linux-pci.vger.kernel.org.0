Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEF66E866
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjAQV2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 16:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAQV0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 16:26:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F43303F8;
        Tue, 17 Jan 2023 11:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88ADB6127C;
        Tue, 17 Jan 2023 19:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3EAC433D2;
        Tue, 17 Jan 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673984775;
        bh=xnGXOoNgDFnCfGFqkYWtMg89FKyKMFlSJejrent0z50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=itmvIkkVnXQD3R7IotNEycsLmC3O4tBaQYU5mOCcXZqCOMI7i9dA0geFJippxBuCK
         /aBw2JY3GAwurtKKME1uROUPqbpNjCmCzq1L5+G7uRfkOB+BYO02iVCR9oTp8qP4I3
         V9CkPwOEPS6E7i+oygkth6Eb9ynfobPtAIzEe3ExtTIxSTzs1pCrz3uycYQXEVywoW
         ptJNobblHKki+s3DSFOrtSw4sFyb5xy1SOSUtzyrKTRpKj2fdDPAI2qSz1lBb0M2hV
         se8QXiRH5Cc2WqjoHsheaHMf7gy12LBFc+kB4M/OPAigSFuPHHWjc1eytqydHO16hc
         ZRopnLwgpukPQ==
Date:   Tue, 17 Jan 2023 13:46:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Edward Chow <persmule@gmail.com>
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Edward Chow <equu@openmail.cc>
Subject: Re: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
Message-ID: <20230117194614.GA135447@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117092746.1149155-1-equu@openmail.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 17, 2023 at 05:27:46PM +0800, Edward Chow wrote:
> Loading calibration data from an OF device tree node not declared
> compatible with the device (e.g. a PCI device with calibration data
> from corresponding DT node gets replaced, so the newly installed
> device become incompatible with the node) or driver may lead to fatal
> result, e.g. kernel panic.

Please include a link to a bug report and include a few lines of the
oops or panic directly in the commit log so when users see this
problem, they can search for the text and possibly find this fix.

> The driver should check whether the DT node corresponding to the
> device compatible with it, and load calibration data only from
> compatible node.

If you read this commit log carefully, it doesn't actually say what
this patch *does*.  It has some background and this assertion about
what drivers *should* do, but it doesn't say what this patch does.

Suggest structure like this (flesh out with the relevant DT property
names, etc):

  For PCI ath9k devices, load calibration data only if there is a DT
  node corresponding to the device with XXX ...

More details: https://chris.beams.io/posts/git-commit/

> Signed-off-by: Edward Chow <equu@openmail.cc>
> ---
>  drivers/net/wireless/ath/ath9k/ath9k.h |  1 +
>  drivers/net/wireless/ath/ath9k/init.c  | 26 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath9k/pci.c   |  2 +-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
> index 2cc23605c9fc..4f6f0383a5f8 100644
> --- a/drivers/net/wireless/ath/ath9k/ath9k.h
> +++ b/drivers/net/wireless/ath/ath9k/ath9k.h
> @@ -35,6 +35,7 @@ struct ath_node;
>  struct ath_vif;
>  
>  extern struct ieee80211_ops ath9k_ops;
> +extern struct pci_driver ath_pci_driver;
>  extern int ath9k_modparam_nohwcrypt;
>  extern int ath9k_led_blink;
>  extern bool is_ath9k_unloaded;
> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
> index 4f00400c7ffb..f88a48e8456b 100644
> --- a/drivers/net/wireless/ath/ath9k/init.c
> +++ b/drivers/net/wireless/ath/ath9k/init.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_net.h>
> +#include <linux/pci.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/relay.h>
>  #include <linux/dmi.h>
> @@ -577,6 +578,31 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
>  	size_t len;
>  	int err;
>  
> +	/* devm_nvmem_cell_get() will get a cell first from the OF
> +	 * DT node representing the given device with nvmem-cell-name
> +	 * "calibration", and from the global lookup table as a fallback,
> +	 * and an ath9k device could be either a pci one or a platform one.
> +	 *
> +	 * If the OF DT node is not compatible with the real device, the
> +	 * calibration data got from the node should not be applied.
> +	 *
> +	 * dev_is_pci(sc->dev) && ( no OF node || caldata not from node
> +	 * || not compatible ) -> do not use caldata .
> +	 *
> +	 * !dev_is_pci(sc->dev) -> always use caldata .
> +	 */
> +	if (dev_is_pci(sc->dev) &&
> +	    (!sc->dev->of_node ||
> +	     !of_property_match_string(sc->dev->of_node,
> +				       "nvmem-cell-names",
> +				       "calibration") ||
> +	     !of_pci_node_match_driver(sc->dev->of_node,
> +				       &ath_pci_driver)))
> +		/* follow the "just return 0;" convention as
> +		 * noted below.
> +		 */
> +		return 0;
> +
>  	cell = devm_nvmem_cell_get(sc->dev, "calibration");
>  	if (IS_ERR(cell)) {
>  		err = PTR_ERR(cell);
> diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
> index a074e23013c5..fcb19761e60d 100644
> --- a/drivers/net/wireless/ath/ath9k/pci.c
> +++ b/drivers/net/wireless/ath/ath9k/pci.c
> @@ -1074,7 +1074,7 @@ static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
>  
>  MODULE_DEVICE_TABLE(pci, ath_pci_id_table);
>  
> -static struct pci_driver ath_pci_driver = {
> +struct pci_driver ath_pci_driver = {
>  	.name       = "ath9k",
>  	.id_table   = ath_pci_id_table,
>  	.probe      = ath_pci_probe,
> -- 
> 2.39.0
> 
