Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F7570D6E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGKWgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGKWgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C4F31230;
        Mon, 11 Jul 2022 15:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED31B815FB;
        Mon, 11 Jul 2022 22:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E016BC3411C;
        Mon, 11 Jul 2022 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578957;
        bh=7G6pKX09/F97v2cQQOGAgqFzqkQnDmYMUvTgW5etn68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pjlkaOk7gXsJfMHGs2uR127IsIiny3oS5RupRJ+cnoJubzAyUNhCn5ktZYt+bkkLP
         ZbDtX8n7xLsb/Br8Mv1I2wz4XulKqiAEcblcVYQnZpDR2Bp6Maf71Fs6eMaIOIztNp
         Ex51UBpuF1hijYOOwxJXM1cqULQdAFk+/v7KxUmgZQ183V7UkdKwISf2LEig3t/bcP
         vocLQjmt1VTrQXzg5usCbUQTFHRWOqs7iMETGyzXyCnTzT7wZlsgL51BKRD+3E167Y
         oD3SYrSVN9/Lz5z2xJj2RNHPyrHh9LS84MX3Q5NixXad+uW+5T5NxNQJIxJyI0r+6o
         /k9ndLEaU+MOQ==
Date:   Mon, 11 Jul 2022 17:35:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/pci: Hide pci_device_from_OF_node() for
 non-powermac code
Message-ID: <20220711223555.GA702011@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706104308.5390-2-pali@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 12:43:04PM +0200, Pali Rohár wrote:
> Function pci_device_from_OF_node() is used only in powermac code.
> So hide it from all other platforms as it is unsed.

s/unsed/unused/ (same typo in 3/5 patch)

These are for the powerpc folks, so I'm just kibbitzing here.

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/include/asm/pci-bridge.h | 2 ++
>  arch/powerpc/kernel/pci_32.c          | 2 ++
>  arch/powerpc/kernel/pci_64.c          | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index c85f901227c9..98156932a1f5 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -170,8 +170,10 @@ static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
>  	return bus->sysdata;
>  }
>  
> +#ifdef CONFIG_PPC_PMAC
>  extern int pci_device_from_OF_node(struct device_node *node,
>  				   u8 *bus, u8 *devfn);
> +#endif
>  #ifndef CONFIG_PPC64
>  
>  extern void pci_create_OF_bus_map(void);
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 5a174936c9a0..c3b91fb62a71 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -154,6 +154,7 @@ pcibios_make_OF_bus_map(void)
>  }
>  
>  
> +#ifdef CONFIG_PPC_PMAC
>  /*
>   * Returns the PCI device matching a given OF node
>   */
> @@ -193,6 +194,7 @@ int pci_device_from_OF_node(struct device_node *node, u8 *bus, u8 *devfn)
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL(pci_device_from_OF_node);
> +#endif
>  
>  /* We create the "pci-OF-bus-map" property now so it appears in the
>   * /proc device tree
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 19b03ddf5631..0c7cfb9fab04 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -286,6 +286,7 @@ int pcibus_to_node(struct pci_bus *bus)
>  EXPORT_SYMBOL(pcibus_to_node);
>  #endif
>  
> +#ifdef CONFIG_PPC_PMAC
>  int pci_device_from_OF_node(struct device_node *np, u8 *bus, u8 *devfn)
>  {
>  	if (!PCI_DN(np))
> @@ -294,3 +295,4 @@ int pci_device_from_OF_node(struct device_node *np, u8 *bus, u8 *devfn)
>  	*devfn = PCI_DN(np)->devfn;
>  	return 0;
>  }
> +#endif
> -- 
> 2.20.1
> 
