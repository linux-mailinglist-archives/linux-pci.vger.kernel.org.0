Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962B254A222
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 00:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiFMWfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiFMWfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 18:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C215205C9;
        Mon, 13 Jun 2022 15:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39E60B80D19;
        Mon, 13 Jun 2022 22:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB934C34114;
        Mon, 13 Jun 2022 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655159722;
        bh=93/0s24Rk9qIM/vFqUauCUwcbv2MlKEpirZjcE6H/e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f96UB1iBnsCXl1Y4RqeS3j2hvgyXNo0rfE09pHQWobnpj5ePka7GichUC4tIfAXvC
         Ivz0oVhuNfP71u/kkx2jq0uEYK3KEtr9xKc0JNkbLb7BXA4tjR75LNT06iivQJAxT/
         Qn/W035eqJUICmPFeGSKx+yWld0pr9uE65B4z2qK97qJPPEF8VoH8T0Ez0KmPFWiRu
         cBAM3SYUx9QPRBgzEFnJud64jLuINl6k7B8z1xfMeKarnTCGr9CTQdQCx8/JBJPoL+
         nyQT+A9AsJ9DgfvjciiFqVMk6zzrrBpEP0OCAwUzO50JhHz6fQP3znfoWw8o4Et7F5
         aiZBbChF3Z5Fw==
Date:   Mon, 13 Jun 2022 17:35:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource
 allocation
Message-ID: <20220613223520.GA721969@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 11:16:41PM +0300, Andy Shevchenko wrote:
> The resource management improve for PCI on x86 broke booting of Intel MID
> platforms. It seems that the current code removes all available resources
> from the list and none of the PCI device may be initialized. Restore the
> old behaviour by force disabling the e820 usage for the resource allocation.
> 
> Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yeah, I blew it with 4c5e242d3e93.  Can you provide more details on
how the MID platforms broke?  Since you set "pci_use_e820 = false" for
MID below, I assume MID doesn't depend on the e820 clipping and thus
should not break if we turn off clipping by default in 2023 as in
0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting
in 2023").  But it'd be nice to see the dmesg log and make sure.

> ---
>  arch/x86/include/asm/pci_x86.h | 1 +
>  arch/x86/pci/acpi.c            | 2 +-
>  arch/x86/pci/intel_mid_pci.c   | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index f52a886d35cf..503f83fbc686 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -126,6 +126,7 @@ extern const struct pci_raw_ops *raw_pci_ext_ops;
>  extern const struct pci_raw_ops pci_mmcfg;
>  extern const struct pci_raw_ops pci_direct_conf1;
>  extern bool port_cf9_safe;
> +extern bool pci_use_e820;
>  
>  /* arch_initcall level */
>  #ifdef CONFIG_PCI_DIRECT
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index a4f43054bc79..ac2f220d50fc 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -20,7 +20,7 @@ struct pci_root_info {
>  #endif
>  };
>  
> -static bool pci_use_e820 = true;
> +bool pci_use_e820 = true;
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg;
>  
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 8edd62206604..7869b86bff04 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -313,6 +313,7 @@ int __init intel_mid_pci_init(void)
>  	pcibios_enable_irq = intel_mid_pci_irq_enable;
>  	pcibios_disable_irq = intel_mid_pci_irq_disable;
>  	pci_root_ops = intel_mid_pci_ops;
> +	pci_use_e820 = false;
>  	pci_soc_mode = 1;
>  	/* Continue with standard init */
>  	acpi_noirq_set();
> -- 
> 2.35.1
> 
