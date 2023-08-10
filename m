Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532DD777AEA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjHJOil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjHJOil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 10:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8626A8;
        Thu, 10 Aug 2023 07:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A215665E46;
        Thu, 10 Aug 2023 14:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA752C433CD;
        Thu, 10 Aug 2023 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678317;
        bh=6aZdlG0TFjmXA9MTJdarW9ykuWmFLg+ezFHrHCAQUFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=laTmVQiB5UMAERREp8XOd8fnZfQJvcWru0BfS09a8TVtSLStx72PrB8yu1LjtxbsT
         HNdmQXR2UbueO4Frz4mPbMIBTCUU+WHAoyeOwWQxLhcxYblCihm2P8Wj8CaspiXl9B
         cj2VXaSGrJtb4bM3TmCsImOBnpzazRXMAV5Q+/kSEdO/7xCmk8fR++d+xXWXSP1Lfh
         c0yty67HD4DNxWnqkVOmvliq6XphZCpqpLyIrjo1xSF7CMGcTRSbCSWtOJJk9qkXCc
         eDcgH4Xk6dgO/F4ANTHVgoe41mYEgexj791kDUPK2TMlsVx7f8uetjVEIj/jEPX8pu
         cIqrXChQ7kaGA==
Date:   Thu, 10 Aug 2023 09:38:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-alpha@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 04/17] pci: sysfs: move declarations to linux/pci.h
Message-ID: <20230810143834.GA29233@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810141947.1236730-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 04:19:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A couple of architectures build the __weak versions of
> pci_create_resource_files() and pci_remove_resource_files() but don't
> have prototypes for these, which causes warnings:
> 
> drivers/pci/pci-sysfs.c:1253:12: error: no previous prototype for 'pci_create_resource_files' [-Werror=missing-prototypes]
>  1253 | int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
> drivers/pci/pci-sysfs.c:1254:13: error: no previous prototype for 'pci_remove_resource_files' [-Werror=missing-prototypes]
>  1254 | void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> 
> Move the prototypes from alpha architecture into the global header to
> avoid these warnings for all of them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to pci/misc for v6.6, thanks!

> ---
>  arch/alpha/include/asm/pci.h | 3 ---
>  include/linux/pci.h          | 5 +++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
> index 6312656279d79..6c04fcbdc8ed2 100644
> --- a/arch/alpha/include/asm/pci.h
> +++ b/arch/alpha/include/asm/pci.h
> @@ -88,7 +88,4 @@ extern void pci_adjust_legacy_attr(struct pci_bus *bus,
>  				   enum pci_mmap_state mmap_type);
>  #define HAVE_PCI_LEGACY	1
>  
> -extern int pci_create_resource_files(struct pci_dev *dev);
> -extern void pci_remove_resource_files(struct pci_dev *dev);
> -
>  #endif /* __ALPHA_PCI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eeb2e6f6130f4..198a399c4b792 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2260,6 +2260,11 @@ int pcibios_alloc_irq(struct pci_dev *dev);
>  void pcibios_free_irq(struct pci_dev *dev);
>  resource_size_t pcibios_default_alignment(void);
>  
> +#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> +extern int pci_create_resource_files(struct pci_dev *dev);
> +extern void pci_remove_resource_files(struct pci_dev *dev);
> +#endif
> +
>  #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
>  void __init pci_mmcfg_early_init(void);
>  void __init pci_mmcfg_late_init(void);
> -- 
> 2.39.2
> 
