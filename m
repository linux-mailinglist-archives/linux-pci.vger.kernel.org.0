Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19A73737E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFTSHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFTSHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 14:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01CF1
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 11:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2640761358
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 18:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512EEC433C8;
        Tue, 20 Jun 2023 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687284467;
        bh=EEF4ttuvBGXjGzz77jIfkPrqbDnqSgMouRd5PvGhjgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q5qaaBNWk+s4f1+mc1OoR1C4nPvSYrJSqIwTTh8pnN7TvyNFfWNaFaY6qf1ub9Cjy
         4wNnj1ESSw3tAjcqsdfR6DQdNnyZUdZbEpsxnN++wlFWd+BW//mkZl+C39zy0U0gT6
         Gh81obXBOSp1Q0Jhb+SIs76bdX96tr1MRklf139pA7/caEzXbt1pocemvTfEYa9fl7
         nJfi4tt8sU5qrUo1vrMU2IvOyGvWx79zWfOsdhdpH16xaepE6SV0DRdwJy8sy7vn5l
         ayIAAjeXVYrM5XFgVlyt7Wd+oTfH9wPcmSpXaB4RitMdVfM/CRwrH5mOpkIBzML8CZ
         ji7HVEvtDwgzw==
Date:   Tue, 20 Jun 2023 13:07:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Fix domain reset operation
Message-ID: <20230620180745.GA52323@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 02:47:06PM -0700, Nirmal Patel wrote:
> During domain reset process we are accidentally enabling
> the prefetchable memory by writing 0x0 to Prefetchable Memory
> Base and Prefetchable Memory Limit registers. As a result certain
> platforms failed to boot up.
> 
> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
> 
>   The Prefetchable Memory Limit register must be programmed to a smaller
>   value than the Prefetchable Memory Base register if there is no
>   prefetchable memory on the secondary side of the bridge.
> 
> When clearing Prefetchable Memory Base, Prefetchable Memory
> Limit and Prefetchable Base Upper 32 bits, the prefetchable
> memory range becomes 0x0-0x575000fffff. As a result the
> prefetchable memory is enabled accidentally.
> 
> Implementing correct operation by writing a value to Prefetchable
> Base Memory larger than the value of Prefetchable Memory Limit.

Oh, I forgot: better to use imperative mood here instead of present
participle ("-ing" form), e.g., "Write ... so that ..."

This should probably use the same form as pci_disable_bridge_window(),
since I think it's doing the same thing.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..f3eb740e3028 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -526,8 +526,18 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>  				     PCI_CLASS_BRIDGE_PCI))
>  					continue;
>  
> -				memset_io(base + PCI_IO_BASE, 0,
> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +				writel(0, base + PCI_IO_BASE);
> +				writew(0xFFF0, base + PCI_MEMORY_BASE);
> +				writew(0, base + PCI_MEMORY_LIMIT);
> +
> +				writew(0xFFF1, base + PCI_PREF_MEMORY_BASE);
> +				writew(0, base + PCI_PREF_MEMORY_LIMIT);
> +
> +				writel(0xFFFFFFFF, base + PCI_PREF_BASE_UPPER32);
> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> +
> +				writel(0, base + PCI_IO_BASE_UPPER16);
> +				writeb(0, base + PCI_CAPABILITY_LIST);
>  			}
>  		}
>  	}
> -- 
> 2.27.0
> 
