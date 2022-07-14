Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E0575624
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiGNUEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiGNUEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 16:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE05B794;
        Thu, 14 Jul 2022 13:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997366221C;
        Thu, 14 Jul 2022 20:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF069C34114;
        Thu, 14 Jul 2022 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657829086;
        bh=dJZgDK6qkBq1IwGZe1zOEzp1bWX9huz0JVAX615cico=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TFjIUwbs/oPqF3/CccRpHfjuHEbv1cpunaNRfTFlK/a/jf53P7ZY4Q/FQi29P5l2E
         2ZTs+syenSEL6qljRTsj95VSFmS1NqMXMneeDvN3dImBJzRe4wvZNyeR8O2EBt2VSU
         UR/x21x7VMO6duebUmSfvLakZakb8uKNKbZBtoBRPxMQbaG1tA/o0jQy7nEjwr7Pul
         fOuQbe4KstDRjEuCnoy0w1FgRcOVNyXRfiO0ABHv9aSpJvzPMNkgEMQd5hQve+hf/U
         R7nuFhAmqPnKEftixFTpCNRM0wFu25rgYSq01rv1WT/oigRtX74RGHGzZApzc9XOmj
         KlLfMgEf2CYQQ==
Date:   Thu, 14 Jul 2022 15:04:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220714200443.GA1036464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714185700.6137-1-pali@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, update Lorenzo's email addr]

Hi Pali,

Thanks for cc'ing me.  I think your previous notes didn't include
linux-pci or me, so I missed them.

It looks like bc02973a06a6 was merged via the PCI tree for v5.17 [1],
so we should probably merge the fix the same way.

Russell, let me know if you object.  Otherwise, I put it on pci/misc
for v5.20.

[1] https://lore.kernel.org/r/20220114155608.GA557997@bhelgaas

On Thu, Jul 14, 2022 at 08:57:00PM +0200, Pali Rohár wrote:
> Custom ARM version of pci_remap_iospace() is implemented only for MMU
> kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
>
> See compilation failures:
> https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
> 
> Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> 
> PING!!!! Is somebody interested in fixing these compile errors? As nobody
> answered to my emails where I proposed this fix more than half year ago and
> asked for opinion...
> 
> https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
> 
> If nobody is interested then please STOP sending me these Intel "0-DAY CI
> Kernel Test Service" emails. Thanks!
> ---
>  arch/arm/include/asm/io.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index eba7cbc93b86..47cf79229b7c 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -180,10 +180,12 @@ void pci_ioremap_set_mem_type(int mem_type);
>  static inline void pci_ioremap_set_mem_type(int mem_type) {}
>  #endif
>  
> +#ifdef CONFIG_MMU
>  struct resource;
>  
>  #define pci_remap_iospace pci_remap_iospace
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> +#endif
>  
>  /*
>   * PCI configuration space mapping function.
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
