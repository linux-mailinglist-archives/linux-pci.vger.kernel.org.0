Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432B5A0BA5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiHYIh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiHYIhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 04:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04316A7217;
        Thu, 25 Aug 2022 01:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC820B82773;
        Thu, 25 Aug 2022 08:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6245BC433D6;
        Thu, 25 Aug 2022 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661416636;
        bh=DQkeUSNAM7a0Ct6liI0HLA9bV98qJ/CZ/IG4vaOqxsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeUdWJUS3tnCZQdfBBXxvqxoDm+LX48nLuOD51qoa96w3LHQAFxU5gI/83osG5nY7
         r0spjYhNDQh5jqZPHpG94ihNUVABK7OLJkCF2SmNjsx0fMPZiGRnJ7gHXfbNdqk/9S
         ANCDy1eEnRTJxO2SHp6SGveStRURh5mFZ+njbQD8+kVkFdPU5gw3aP+u88svhy1phz
         f4m+eZVDiB325dbsLCiFY8giD0eC2No9CuP0YyyK22/y+jVpkUYMTniNnLxt4usMyY
         0QHHlU+lHa4+wtGCf3mEl51tkCRRseZsoe9+TBK1enKKptYAEnoOecBlwPyUTOGDY6
         YR2Bw+GEiUm8w==
Received: by pali.im (Postfix)
        id 1CCC4742; Thu, 25 Aug 2022 10:37:13 +0200 (CEST)
Date:   Thu, 25 Aug 2022 10:37:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Enable PCI domains in /proc when PCI bus
 numbers are not unique
Message-ID: <20220825083713.4glfivegmodluiun@pali>
References: <20220820115113.30581-1-pali@kernel.org>
 <878rnclq47.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878rnclq47.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 25 August 2022 17:49:28 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On 32-bit powerpc systems with more PCIe controllers and more PCI domains,
> > where on more PCI domains are same PCI numbers, when kernel is compiled
> > with CONFIG_PROC_FS=y and CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT=y
> > options, kernel prints "proc_dir_entry 'pci/01' already registered" error
> > message.
> 
> Thanks, I'll pick this up.
> 
> > This regression started appearing after commit 566356813082 ("powerpc/pci:
> > Add config option for using all 256 PCI buses") in case in each mPCIe slot
> > is connected PCIe card and therefore PCI bus 1 is populated in for every
> > PCIe controller / PCI domain.
> >
> > The reason is that PCI procfs code expects that when PCI bus numbers are
> > not unique across all PCI domains, function pci_proc_domain() returns true
> > for domain dependent buses.
> >
> > Fix this issue by setting PCI_ENABLE_PROC_DOMAINS and PCI_COMPAT_DOMAIN_0
> > flags for 32-bit powerpc code when CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> > is enabled. Same approach is already implemented for 64-bit powerpc code
> > (where PCI bus numbers are always domain dependent).
> 
> We also have the same in ppc4xx_pci_find_bridges().
> 
> And if we can eventually make CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> the standard behaviour on 32-bit then everything would behave the same
> and we could simplify pci_proc_domain() to match what other arches do.

I sent two patches which do another steps to achieve it:
https://lore.kernel.org/linuxppc-dev/20220817163927.24453-1-pali@kernel.org/t/#u

Main blocker is pci-OF-bus-map which is in direct conflict with
CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT and which used on chrp and pmac.
And I have no idea if pci-OF-bus-map is still needed or not.

> cheers
> 
> 
> > Fixes: 566356813082 ("powerpc/pci: Add config option for using all 256 PCI buses")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/powerpc/kernel/pci_32.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> > index ffc4e1928c80..8acbc9592ebb 100644
> > --- a/arch/powerpc/kernel/pci_32.c
> > +++ b/arch/powerpc/kernel/pci_32.c
> > @@ -249,6 +249,15 @@ static int __init pcibios_init(void)
> >  
> >  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
> >  
> > +#ifdef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> > +	/*
> > +	 * Enable PCI domains in /proc when PCI bus numbers are not unique
> > +	 * across all PCI domains to prevent conflicts. And keep PCI domain 0
> > +	 * backward compatible in /proc for video cards.
> > +	 */
> > +	pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
> > +#endif
> > +
> >  	if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> >  		pci_assign_all_buses = 1;
> >  
> > -- 
> > 2.20.1
