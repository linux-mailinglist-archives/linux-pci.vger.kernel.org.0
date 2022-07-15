Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992EC575CF1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiGOIER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGOIEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E961D65;
        Fri, 15 Jul 2022 01:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A019F61F35;
        Fri, 15 Jul 2022 08:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD348C34115;
        Fri, 15 Jul 2022 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872255;
        bh=4eoGergpOqcE4ttRkFKv9ntlQ2YzgMrnZ25BFzNcBqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0dK6sy/O9Dk8HVk3XO7fvxqQU6LlwDlISzOnkl4kuVK7gqEfKT6ZidxklB+TTNOQ
         b7eJmZFltqKmYrC6wegXx6K7ZD7TvPfcapE0HTT+XYcLHq563j9iPfKBrISIbLNQQx
         uRTT0xJPqEl8XWbdC9yFXZCeSSdWzeESB4wUiT2Zkx1uV3N+uCMbZa28ozT4T7tWLC
         KX88ycWSAZwuHKmY1xt7eH931uNbbzFb2ZztQeqmoSa+nOAwRo2rORAqfeAmpKjmKj
         z0835q1QJo+c9ZiWErMhAb6dP7W+BMq0SwOXT06fAGxSO7ok/ue+mkkpOYaUxNleKg
         v9FiOyj7X0VLg==
Received: by pali.im (Postfix)
        id 35632A32; Fri, 15 Jul 2022 10:04:12 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:04:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220715080412.j3wgvzlv5evp5zbb@pali>
References: <20220714185700.6137-1-pali@kernel.org>
 <20220714200443.GA1036464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714200443.GA1036464@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 14 July 2022 15:04:43 Bjorn Helgaas wrote:
> [+cc linux-pci, update Lorenzo's email addr]
> 
> Hi Pali,
> 
> Thanks for cc'ing me.  I think your previous notes didn't include
> linux-pci or me, so I missed them.

https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/

> It looks like bc02973a06a6 was merged via the PCI tree for v5.17 [1],
> so we should probably merge the fix the same way.
> 
> Russell, let me know if you object.  Otherwise, I put it on pci/misc
> for v5.20.
> 
> [1] https://lore.kernel.org/r/20220114155608.GA557997@bhelgaas
> 
> On Thu, Jul 14, 2022 at 08:57:00PM +0200, Pali Rohár wrote:
> > Custom ARM version of pci_remap_iospace() is implemented only for MMU
> > kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
> >
> > See compilation failures:
> > https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> > https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> > https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> > https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
> > 
> > Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > 
> > PING!!!! Is somebody interested in fixing these compile errors? As nobody
> > answered to my emails where I proposed this fix more than half year ago and
> > asked for opinion...
> > 
> > https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> > https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> > https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> > https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> > https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
> > 
> > If nobody is interested then please STOP sending me these Intel "0-DAY CI
> > Kernel Test Service" emails. Thanks!
> > ---
> >  arch/arm/include/asm/io.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index eba7cbc93b86..47cf79229b7c 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> > @@ -180,10 +180,12 @@ void pci_ioremap_set_mem_type(int mem_type);
> >  static inline void pci_ioremap_set_mem_type(int mem_type) {}
> >  #endif
> >  
> > +#ifdef CONFIG_MMU
> >  struct resource;
> >  
> >  #define pci_remap_iospace pci_remap_iospace
> >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> > +#endif
> >  
> >  /*
> >   * PCI configuration space mapping function.
> > -- 
> > 2.20.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
