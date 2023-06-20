Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB61D73735E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFTR65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFTR65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758A186
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 10:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F88861346
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 17:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC0FC433C0;
        Tue, 20 Jun 2023 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687283935;
        bh=WkK/lt+zi4JQICrHPU++ExYjBt7rrO9FYJSRtXsb7Mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XfuU9fCrrVcCBW1sW6wN1HWF3ahfbUwkyj0AG43IBxY3htQVS6s1l+kjZwWTYsa/+
         OcwRQ1PlxTUHPOrfnRwxoaCYFYkMHXdZ5Gqa1E2fsrhOoZSIJ1LRnuYtMLL0biadFb
         LcsRVyWFK5QdtcZOKfhqE+Bwz2n6eQFT4Bo/1TYl3rjX0Or7qx7MH2IYkNBsXCaW1J
         eXV3D4FO38/NhTmUhPhBsCDxsdachuhtmaWpm/5TpInI0jC1lTKHU0Qf2F+8OuUzro
         RWms/itsfGg34ZSiMTmwJ50VjXlRwkgBiehfwHJOJpNdTIP11ziw61s47ljh8CrE3q
         MMzOGEWn7g14A==
Date:   Tue, 20 Jun 2023 12:58:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Fix domain reset operation
Message-ID: <20230620175852.GA51832@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Can you make the subject line more descriptive than "Fix X"?

There are a zillion ways X might be broken, so it's useful to have a
hint about which one it is.

Actually, vmd_domain_reset() is sort of weirdly named, because I don't
see any *reset* there.  It looks like it's actually disabling all
bridge windows (not just the prefetchable one, as the log suggests).

The fact that this makes a difference suggests that the bridges had
PCI_COMMAND_MEMORY set, which sounds like something you may not have
wanted.

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
