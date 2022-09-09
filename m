Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFC5B3360
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIIJRD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiIIJRB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DB132045;
        Fri,  9 Sep 2022 02:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48A861F5A;
        Fri,  9 Sep 2022 09:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B48C433C1;
        Fri,  9 Sep 2022 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662715012;
        bh=4O6h/xQZqIuBQzPhhOTTiqKNTW0qd6wBALjJqR5vKlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpMZIx+1qekDRo2fKtkWKz3sU73bOosnrh+umgZbwf2rnsCA+O4S+LXdDAkL4JxyI
         ZGCJNUn4wpRC9F0xnt/3173SDv2drRPFuTSo0yA0VQd8IP9vSjofWOD9zyO9KBgwpQ
         hye0kJepevwp90OUWtEEyAcCYr46Vt2rBn4hE3SZP1WeTKIffUPN6eOutwFsKya9EF
         7p2/vhLLelh/7PDAihWfeUhJgRHo2N6QxBE8XFDn50WvmIyNT714k1ByMUuGiR1f1+
         FwvUIr7m7bNCEDG6jNd4jX9iT5oh+bpYsDBTQ+JJrT+sHXRbLkuziWzb8776gKIZ2f
         hswS2Vle/Azgg==
Date:   Fri, 9 Sep 2022 11:16:45 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: do not leak reset GPIO on unbind/unload/error
Message-ID: <YxsEfcTAw0v/JFes@lpieralisi>
References: <YxatO5OaI2RpxQ2M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxatO5OaI2RpxQ2M@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nit: please capitalize beginning of the sentence in the subject - that's
what we do for PCI controllers commits.

"PCI: apple: Do not leak reset GPIO on unbind/unload/error"

On Mon, Sep 05, 2022 at 07:15:23PM -0700, Dmitry Torokhov wrote:
> The driver allocates reset GPIO in apple_pcie_setup_port() but neither
> releases the resource, nor uses devm API to have it released
> automatically.
> 
> Let's fix this by switching to devm API. While at it let's use generic
> devm_fwnode_gpiod_get() instead of OF-specific gpiod_get_from_of_node()
> - this will allow us top stop exporting the latter down the road.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")

Should I take it via the PCI tree ? Usually we send fixes through -rcX
only if the fix applies to code merged last merge window, which is not
the case here, so I would queue if for v6.1.

Lorenzo

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This patch has been pulled out of the series
> https://lore.kernel.org/all/20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com/
> with updated justification (leak fix vs pure API deprecation).
> 
>  drivers/pci/controller/pcie-apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index a2c3c207a04b..66f37e403a09 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	u32 stat, idx;
>  	int ret, i;
>  
> -	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
> -				       GPIOD_OUT_LOW, "PERST#");
> +	reset = devm_fwnode_gpiod_get(pcie->dev, of_fwnode_handle(np), "reset",
> +				      GPIOD_OUT_LOW, "PERST#");
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> -- 
> 2.37.2.789.g6183377224-goog
> 
> 
> -- 
> Dmitry
