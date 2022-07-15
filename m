Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510EF5765E4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGORLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiGORLk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 13:11:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7F61B05;
        Fri, 15 Jul 2022 10:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5512BCE30C2;
        Fri, 15 Jul 2022 17:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D36AC34115;
        Fri, 15 Jul 2022 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657905095;
        bh=p0+be8P4mJSpNS9w7xRI+Uug5MZvY14f4VbucNXXoio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfN0uPKEoJHsjrZ16wMRE+U8mUy79Engm2H+j29wl7llvEOh0cZoHz50aSsAi/JSB
         Ghd3O1BP3YOdN+7THMTOItFNjrsmlFIUq2zZFUgSdxBmwtYe88iEAVr6OqgwprbKy3
         2zG8Z1r/o/9kCxQyDeLjrBIvcmaf9rGihLckb297CFMCQq8Qg97sH3gEgFNzEz51e7
         qLWmPKypPxqv9ULkzkU4SN2rCIMjW+5fayPDFCxdqzXgHMZ6+BjhMT/VRgvpLnXWyj
         HhJB3IUEjCrvqroaoyaKHsWq8LF+h/s+rZ31KzFsc5I5cr3xor44C4dv8M05Ufwcee
         I7dj5LUYfWYaA==
Received: by pali.im (Postfix)
        id 47F2DA32; Fri, 15 Jul 2022 19:11:32 +0200 (CEST)
Date:   Fri, 15 Jul 2022 19:11:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: Add config option for using OF 'reg'
 for PCI domain
Message-ID: <20220715171132.ujaexzm4ipad7o4f@pali>
References: <20220706102148.5060-1-pali@kernel.org>
 <17fb8d12-60f9-09d5-91fa-09d5a5a9a4fd@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17fb8d12-60f9-09d5-91fa-09d5a5a9a4fd@igalia.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 15 July 2022 11:55:04 Guilherme G. Piccoli wrote:
> On 06/07/2022 07:21, Pali Rohár wrote:
> > [...] 
> > Fix this issue and introduce a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG.
> > When this option is disabled then powerpc kernel would assign PCI domains
> > in the similar way like it is doing kernel for other architectures,
> > starting from zero and also how it was done prior that commit.
> 
> I found this sentence a bit weird, "in the similar way like it is doing
> kernel for other architectures", but other than that:

If you have some idea how to improve commit description, let me know and
I can change it.

> Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Thanks for the improvement!
> Cheers,
> 
> 
> Guilherme
> 
> 
> > 
> > This option is by default enabled for powernv and pseries platform for which
> > was that commit originally intended.
> > 
> > With this change upgrading kernels from LTS 4.4 version does not change PCI
> > domain on smaller embedded platforms with fixed number of PCIe controllers.
> > And also ensure that PCI domain zero is present as before that commit.
> > 
> > Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > Changes in v2:
> > * Enable CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG by default on powernv and pseries
> > ---
> >  arch/powerpc/Kconfig             | 11 +++++++++++
> >  arch/powerpc/kernel/pci-common.c |  4 ++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index f66084bc1dfe..053a88e84049 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -386,6 +386,17 @@ config PPC_OF_PLATFORM_PCI
> >  	depends on PCI
> >  	depends on PPC64 # not supported on 32 bits yet
> >  
> > +config PPC_PCI_DOMAIN_FROM_OF_REG
> > +	bool "Use OF reg property for PCI domain"
> > +	depends on PCI
> > +	default y if PPC_PSERIES || PPC_POWERNV
> > +	help
> > +	  By default PCI domain for host bridge during its registration is
> > +	  chosen as the lowest unused PCI domain number.
> > +
> > +	  When this option is enabled then PCI domain can be determined
> > +	  also from lower bits of the OF / Device Tree 'reg' property.
> > +
> >  config ARCH_SUPPORTS_UPROBES
> >  	def_bool y
> >  
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 068410cd54a3..7f959df34833 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -74,7 +74,6 @@ void __init set_pci_dma_ops(const struct dma_map_ops *dma_ops)
> >  static int get_phb_number(struct device_node *dn)
> >  {
> >  	int ret, phb_id = -1;
> > -	u32 prop_32;
> >  	u64 prop;
> >  
> >  	/*
> > @@ -83,7 +82,8 @@ static int get_phb_number(struct device_node *dn)
> >  	 * reading "ibm,opal-phbid", only present in OPAL environment.
> >  	 */
> >  	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
> > -	if (ret) {
> > +	if (ret && IS_ENABLED(CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG)) {
> > +		u32 prop_32;
> >  		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
> >  		prop = prop_32;
> >  	}
