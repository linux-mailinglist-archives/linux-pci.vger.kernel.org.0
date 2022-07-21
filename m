Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9355F57D6D1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 00:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiGUWVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiGUWVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 18:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7A90DB6;
        Thu, 21 Jul 2022 15:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C0CB82585;
        Thu, 21 Jul 2022 22:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D62C3411E;
        Thu, 21 Jul 2022 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658442108;
        bh=vIfiBaGEG7obwDQ4LLJAIFN/Wy9b/LZ6SQl8EVd2Y2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8iGvj5LFkICYjgl/XImEosmB5fHbTwsN4w48yTQOcPLE3o1VfZYtHxLfnBxsMLnj
         URR/9BmR4YC5R2uL0tnx2XGP3lM4RJEr140+VlaEj4YqFvOQaWDhP2tnWwHagwV10U
         9W9hbfHlVA2UpHC023O0vbjgKFQ+lRGJd5R2mPsfaye7EPnOomcYz7lFECdQaLo1H8
         FBEkolEPCMUKbIzq6LZFJXHv8svJ4a+i4UfnYDcIOGZod6Cr75krRrX99kwG3MV5sQ
         3BEI1NtxI27uyz0ZddwIjf4RQ0LKofHMLXTOuNvpdMMU+Js9edAw5gViZ/3ZrkgEQk
         8z9SJEeeVM1Gw==
Received: by pali.im (Postfix)
        id 9FE5122EF; Fri, 22 Jul 2022 00:21:45 +0200 (CEST)
Date:   Fri, 22 Jul 2022 00:21:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] powerpc/pci: Add config option for using all 256 PCI
 buses
Message-ID: <20220721222145.rzgthbwoselx2l43@pali>
References: <20220706104308.5390-1-pali@kernel.org>
 <20220706104308.5390-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706104308.5390-6-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 06 July 2022 12:43:08 Pali Rohár wrote:
> By default on PPC32 are PCI bus numbers unique across all PCI domains.
> So system could have only 256 PCI buses independently of available
> PCI domains.
> 
> This is due to filling DT property pci-OF-bus-map which does not reflect
> multi-domain setup.
> 
> On all powerpc platforms except chrp and powermac there is no DT property
> pci-OF-bus-map anymore and therefore it is possible on non-chrp/powermac
> platforms to avoid this limitation of maximal number of 256 PCI buses in
> system even on multi-domain setup.
> 
> But avoiding this limitation would mean that all PCI and PCIe devices would
> be present on completely different BDF addresses as every PCI domain starts
> numbering PCI bueses from zero (instead of the last bus number of previous
> enumerated PCI domain). Such change could break existing software which
> expects fixed PCI bus numbers.
> 
> So add a new config option CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT which
> enables this change. By default it is disabled. It cause that initial value
> of hose->first_busno is zero.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/Kconfig         | 11 +++++++++++
>  arch/powerpc/kernel/pci_32.c |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index be68c1f02b79..f66084bc1dfe 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -370,6 +370,17 @@ config PPC_DCR
>  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
>  	default y
>  
> +config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> +	depends on PPC32
> +	depends on !PPC_PMAC && !PPC_CHRP
> +	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> +	help
> +	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> +	  So system could have only 256 PCI buses independently of available
> +	  PCI domains. When this option is enabled then PCI bus numbers are
> +	  PCI domain dependent and each PCI controller on own domain can have
> +	  256 PCI buses, like it is on other Linux architectures.
> +

What do you think, would it be possible to set default value of this
option to enabled?

>  config PPC_OF_PLATFORM_PCI
>  	bool
>  	depends on PCI
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 2f7284b68f06..433965bf37b4 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -239,7 +239,9 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
>  static int __init pcibios_init(void)
>  {
>  	struct pci_controller *hose, *tmp;
> +#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
>  	int next_busno = 0;
> +#endif
>  
>  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
>  
> @@ -248,13 +250,17 @@ static int __init pcibios_init(void)
>  
>  	/* Scan all of the recorded PCI controllers.  */
>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
>  		if (pci_assign_all_buses)
>  			hose->first_busno = next_busno;
> +#endif
>  		hose->last_busno = 0xff;
>  		pcibios_scan_phb(hose);
>  		pci_bus_add_devices(hose->bus);
> +#ifndef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
>  		if (pci_assign_all_buses || next_busno <= hose->last_busno)
>  			next_busno = hose->last_busno + pcibios_assign_bus_offset;
> +#endif
>  	}
>  
>  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> -- 
> 2.20.1
> 
