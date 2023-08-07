Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6169F7732EA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHGWXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 18:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjHGWXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 18:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F48F
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 15:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D63A622CB
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 22:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2ECC433C7;
        Mon,  7 Aug 2023 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691446997;
        bh=vMiK86v7c5s4nHJ8/ScLKcOdng1O8WyXat90G79Osew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nYzIwWAtbQEAZUPfNxdtr28dgRCd+5gHSXTcbn7c7WrQFFCkI/le/1Ejm4x4j4v6l
         xghf8xg5a+UI53IB6fMWZ+nhHIGmKPwvQ6ilns5aBlcKDduBVj1nOeWHixNs6H87ro
         bZr7UlZoH5+9bQrrvjSkmA1WpivCH+ugDVX3bHMBtLK+G2YwNi7Ptv6dWoDnNzt/II
         Be91CJgTVowMPEsAiw5YyJQUnf/rinf56aAQgpd2dNJkpjNgJMrTTvTLkrnHozkaD+
         DZZKRM3UB8u0aO3PQUh8pf+6NLhy/K1SSTEr6WCsvJ3iJBRvMiXQw9068vHK4npFm2
         DAOXxSgzf+W2g==
Date:   Mon, 7 Aug 2023 17:23:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Disable bridge window for domain reset
Message-ID: <20230807222315.GA272397@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807204520.1088801-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 04:45:20PM -0400, Nirmal Patel wrote:
> During domain reset process vmd_domain_reset() clears PCI
> configuration space of VMD root ports. But certain platform
> has observed following errors and failed to boot.
>   ...
>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: Invalidation Time-out Error (ITE) cleared
> 
> The root cause is that memset_io() clears prefetchable memory base/limit
> registers and prefetchable base/limit 32 bits registers sequentially.
> This seems to be enabling prefetchable memory if the device disabled
> prefetchable memory originally.
> Here is an example (before memset_io()):

Paragraph separation or wrapping error.

>   PCI configuration space for 10000:00:00.0:
>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>   ...
> 
> So, prefetchable memory is ffffffff00000000-575000fffff, which is
> disabled. When memset_io() clears prefetchable base 32 bits register,
> the prefetchable memory becomes 0000000000000000-575000fffff, which is
> enabled.
> 
> This is believed to be the reason for the failure and in addition the
> sequence of operation in vmd_domain_reset() is not following the PCIe
> specs.
> 
> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
> 
>   The Prefetchable Memory Limit register must be programmed to a smaller
>   value than the Prefetchable Memory Base register if there is no
>   prefetchable memory on the secondary side of the bridg

s/bridg/bridge/

The [mem 0x0-0x575000fffff] state is transient, right?  After the
memset_io() completes, the window is [mem 0x0-0x000fffff], which still
not what you want, since it's enabled, while you want to *disable* the
window.

I don't know what the connection between this and the DMAR
invalidation queue errors is.  Maybe those can happen with either the
transient [mem 0x0-0x575000fffff] state or the [mem 0x0-0x000fffff]
end state?

IIUC there are two problems with the memset_io():

  1) The memset_io() writes 0 to all the base and limit registers.
     For address decoding purposes, the low bits of the base are
     implicitly clear while the low bits of the limit are implicitly
     set, so setting the base to zero always makes the windows
     *enabled*, e.g., [io 0x0000-0x0fff].

  2) The I/O and prefetchable base/limit can't be configured with a
     single config write, so we have to write them in a specific order
     to avoid transient enabled windows that could cause conflicts.

> Disable the bridge window by executing a sequence of operations
> borrowed from pci_disable_bridge_window(), that comply with the
> PCI specifications.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v3->v3: Add more information to commit description.
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

This is a 32-bit write, so it writes zero to PCI_IO_BASE,
PCI_IO_LIMIT, and PCI_SEC_STATUS.  Writing zero to PCI_SEC_STATUS is
probably harmless since everything there is RO or RW1C, but is
unnecessary and seems a little sloppy.

Writing zero to PCI_IO_BASE and PCI_IO_LIMIT enables it as
[io 0x0000-0x0fff].  I think the code in pci_setup_bridge_io() is more
like what you want.

> +				/* MMIO Base/Limit */
> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
> +
> +				/* Prefetchable MMIO Base/Limit */
> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
> +				writel(0, base + PCI_IO_BASE_UPPER16);
kkkk
> +				writeb(0, base + PCI_CAPABILITY_LIST);
>  			}
>  		}
>  	}
> -- 
> 2.31.1
> 
