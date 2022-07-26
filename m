Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF075811A5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGZLKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiGZLKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 07:10:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB02A0;
        Tue, 26 Jul 2022 04:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D7BB8154D;
        Tue, 26 Jul 2022 11:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05C8C341C0;
        Tue, 26 Jul 2022 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658833804;
        bh=WbKliBFXTxrgN6Cv+1JYUylkWk7EhU/4UIHhcTfvc+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6sUQ7AkRhrj3O9TXl462M8zzz/Jmn+VdLMYNCYl1Kb+8MAqQRzJXP7KkkU6Y5Z+F
         tyF223QpdJ80Dc4iKMaHoOySOkNMhJupURDnuUc4+qJOPIKQ/GcBo9e0b19zvVC5Ng
         s6owfbQPjXGwLS3x/8IVqw30UF8zdCcdzzyabB5bvanssQBBekLR38YZWN2SvPnObo
         hccladLLxbFOw0cgXwEeNHDwKjzCKbAl+uR1uHUzQznaJpIgAHGu08UkyMZGeWfhKO
         EfCXPCz2a/9yMhv0hei+69+0jh1g1HnyeQ6FLIn71BbyMxQglQMmqntQIRn1RQ4gut
         BVzexJu46i3PQ==
Received: by pali.im (Postfix)
        id 3281782D; Tue, 26 Jul 2022 13:10:01 +0200 (CEST)
Date:   Tue, 26 Jul 2022 13:10:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] powerpc/pci: Add config option for using all 256 PCI
 buses
Message-ID: <20220726111001.a2upqf5m5welcla6@pali>
References: <20220706104308.5390-1-pali@kernel.org>
 <20220706104308.5390-6-pali@kernel.org>
 <20220721222145.rzgthbwoselx2l43@pali>
 <875yjkb0ht.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yjkb0ht.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 26 July 2022 21:02:22 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Wednesday 06 July 2022 12:43:08 Pali Rohár wrote:
> >> By default on PPC32 are PCI bus numbers unique across all PCI domains.
> >> So system could have only 256 PCI buses independently of available
> >> PCI domains.
> >>
> >> This is due to filling DT property pci-OF-bus-map which does not reflect
> >> multi-domain setup.
> >>
> >> On all powerpc platforms except chrp and powermac there is no DT property
> >> pci-OF-bus-map anymore and therefore it is possible on non-chrp/powermac
> >> platforms to avoid this limitation of maximal number of 256 PCI buses in
> >> system even on multi-domain setup.
> >>
> >> But avoiding this limitation would mean that all PCI and PCIe devices would
> >> be present on completely different BDF addresses as every PCI domain starts
> >> numbering PCI bueses from zero (instead of the last bus number of previous
> >> enumerated PCI domain). Such change could break existing software which
> >> expects fixed PCI bus numbers.
> >>
> >> So add a new config option CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT which
> >> enables this change. By default it is disabled. It cause that initial value
> >> of hose->first_busno is zero.
> >>
> >> Signed-off-by: Pali Rohár <pali@kernel.org>
> >> ---
> >>  arch/powerpc/Kconfig         | 11 +++++++++++
> >>  arch/powerpc/kernel/pci_32.c |  6 ++++++
> >>  2 files changed, 17 insertions(+)
> >>
> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> index be68c1f02b79..f66084bc1dfe 100644
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -370,6 +370,17 @@ config PPC_DCR
> >>  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> >>  	default y
> >>
> >> +config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >> +	depends on PPC32
> >> +	depends on !PPC_PMAC && !PPC_CHRP
> >> +	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> >> +	help
> >> +	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> >> +	  So system could have only 256 PCI buses independently of available
> >> +	  PCI domains. When this option is enabled then PCI bus numbers are
> >> +	  PCI domain dependent and each PCI controller on own domain can have
> >> +	  256 PCI buses, like it is on other Linux architectures.
> >> +
> >
> > What do you think, would it be possible to set default value of this
> > option to enabled?
> 
> My preference would be to not have the option at all, just make it the
> default behaviour. Every new CONFIG option adds more combinations that
> need testing, or more likely don't get well tested.
> 
> But I don't have a good feel for what could break if we turn it on, so
> honestly I don't really know.
> 
> Also I do most of my 32-bit testing on pmacs, which are not affected by
> the change.

It is because this change is incompatible with deprecated pci-OF-bus-map
which pmac uses. I do not have any pmac box for testing or development,
so I let this part as is.

If one day pci-OF-bus-map would be possible to disable on pmac then this
pci bus number change can be enabled also for pmac.

> So I'll probably take the series as-is, and then we can do some more
> widespread testing and possibly flip the default to enabled, and then
> maybe remove the option entirely in future.
> 
> cheers

I have tested it on P2020 board with 3 PCIe devices, each on own bus
where each bus is connected to different PCIe controller / domain and it
works correctly. Every PCIe device is on bus 1 bus but on different
domains.
