Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11176667E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjG1ILK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjG1IKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 04:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0B3A94
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 01:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685EF62038
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 08:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B80C433C7;
        Fri, 28 Jul 2023 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690531845;
        bh=bTWBozpUeMN0xK9mfMqRhIFLjxi5qzgqcDypMZO9+zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIEg8EnFrcVOr0XXiraDUA7xn5PF42pldmoWB4V0stQ/2nY4QQ78raNL27SDGPqv0
         5bUh1DTL4XZm+tJ9yUZ2ftdZnoYKpGELrEwkKF4Ijsf/1P+UpBTSUP2gSXiCB9YWWN
         RvOtiqrUB/40PR7SpVj9kb8jmZYjouhK6bwYQYOVdXLUbcAt7Zl0w7mM8CnINKjAE2
         0g/o9L+b9XCIent7VOK0sho8fVHvV8GyA4IzfWYUNId8VQF2pLtPl8az7z0czUhsqM
         uFXsQzb39cVdyhUfL5XKkYq+r/vsKNjLZK0Aqj8JCHA8N0oKklBwFWRJv88mJBns9L
         7tFWZKZrXqDOg==
Date:   Fri, 28 Jul 2023 10:10:42 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Disable bridge window for domain reset
Message-ID: <ZMN4AnYddVjO/JG1@lpieralisi>
References: <20230719205610.922324-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719205610.922324-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 04:56:10PM -0400, Nirmal Patel wrote:
> During domain reset process we are accidentally enabling
> the prefetchable memory by writing 0x0 to Prefetchable Memory
> Base and Prefetchable Memory Limit registers. As a result certain
> platforms failed to boot up.
> 
> When clearing Prefetchable Memory Base, Prefetchable Memory
> Limit and Prefetchable Base Upper 32 bits, the prefetchable
> memory range becomes 0x0-0x575000fffff.

I asked before, I am asking again. I assume you are describing
what happens while the code is executing memset_io() and the
Prefetchable Base Upper 32 bits have not been written yet.

That's a problem but most likely the issue is the end result,
with the prefetchable window set to 0x0-0x000fffff.

Please explain and reword the commit log accordingly.

> As a result the
> prefetchable memory is enabled accidentally. There is a gap
> between implementation and the PCI Express spec.

Define the gap and how it affects this commit or remove this sentence.

[...]

> Write proper values to required Memory Base registers and follow
> same the style as  pci_disable_bridge_window.

Replace this sentence with:

"Disable the bridge window by executing a sequence of operations
borrowed from pci_disable_bridge_window(), that comply with the
PCI specifications".

Thanks,
Lorenzo

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v1->v2: Follow same chain of operation as pci_disable_bridge_window
>         and update commit log.
> ---
>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..ca9081be917d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -526,8 +526,16 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>  				     PCI_CLASS_BRIDGE_PCI))
>  					continue;
>  
> -				memset_io(base + PCI_IO_BASE, 0,
> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +				writel(0, base + PCI_IO_BASE);
> +				/* MMIO Base/Limit */
> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
> +
> +				/* Prefetchable MMIO Base/Limit */
> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
> +				writel(0, base + PCI_IO_BASE_UPPER16);
> +				writeb(0, base + PCI_CAPABILITY_LIST);
>  			}
>  		}
>  	}
> -- 
> 2.31.1
> 
