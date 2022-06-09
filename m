Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8E5451C7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiFIQXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiFIQXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 12:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60143B1F;
        Thu,  9 Jun 2022 09:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD5D8B82E31;
        Thu,  9 Jun 2022 16:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B939C34114;
        Thu,  9 Jun 2022 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654791777;
        bh=pc3xBNaUgiX7uakkgh6/3I1zWKm6CQOql1Om/7UzyPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lyjc0US4qcfH+214BEnfZCSfXXxvrpAtldkerP1SPhvmMlaHyBHfyJ+Qoap7T5s0w
         Bbv2IoOtThEENiFkeNhlsEyk0/OwonEI6e7cAz7Ys35H8bRYGJoWjFwyvLn5Tjc8h2
         WbPfPQ8BrdFvM6bgrbbCgREyvDaCmIvL490o3ATvmcQd4WOlkOi0OCpg2OoXGwg+ho
         e44j5fslhcMKcrq0ywqBshFIfQRC/jLk/5AMFIJO+2FYBFQ3k3kuFjyMitQcv22q5G
         ZeeTX9pmFX46jBnBPd0anxVvi46wdREX7z4SeFVh4NW/JyIwBIMfgztsLqd00/WmqX
         cubkb/MEZ6eag==
Date:   Thu, 9 Jun 2022 11:22:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Add config option for using OF 'reg' for
 PCI domain
Message-ID: <20220609162255.GA483511@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505223302.2ydcssvdgoyqv7e5@pali>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Guilherme, Michael, Ben (author of 63a72284b159 and PPC folks), thread:
https://lore.kernel.org/r/20220504175718.29011-1-pali@kernel.org]

On Fri, May 06, 2022 at 12:33:02AM +0200, Pali Roh�r wrote:
> On Thursday 05 May 2022 15:10:01 Tyrel Datwyler wrote:
> > On 5/5/22 02:31, Pali Roh�r wrote:
> > > On Thursday 05 May 2022 07:16:40 Christophe Leroy wrote:
> > >> Le 04/05/2022 � 19:57, Pali Roh�r a �crit�:
> > >>> Since commit 63a72284b159 ("powerpc/pci: Assign fixed PHB
> > >>> number based on device-tree properties"), powerpc kernel
> > >>> always fallback to PCI domain assignment from OF / Device Tree
> > >>> 'reg' property of the PCI controller.
> > >>>
> > >>> PCI code for other Linux architectures use increasing
> > >>> assignment of the PCI domain for individual controllers
> > >>> (assign the first free number), like it was also for powerpc
> > >>> prior mentioned commit.
> > >>>
> > >>> Upgrading powerpc kernels from LTS 4.4 version (which does not
> > >>> contain mentioned commit) to new LTS versions brings a
> > >>> regression in domain assignment.
> > >>
> > >> Can you elaborate why it is a regression ?
> > >> 63a72284b159 That commit says 'no functionnal changes', I'm
> > >> having hard time understanding how a nochange can be a
> > >> regression.
> > > 
> > > It is not 'no functional change'. That commit completely changed
> > > PCI domain assignment in a way that is incompatible with other
> > > architectures and also incompatible with the way how it was done
> > > prior that commit.
> > 
> > I agree that the "no functional change" statement is incorrect.
> > However, for most powerpc platforms it ended up being simply a
> > cosmetic behavior change. As far as I can tell there is nothing
> > requiring domain ids to increase montonically from zero or that
> > each architecture is required to use the same domain numbering
> > scheme.
> 
> That is truth. But it looks really suspicious why domains are not
> assigned monotonically. Some scripts / applications are using PCI
> location (domain:bus:dev:func) for remembering PCI device and domain
> change can cause issue for config files. And some (older) applications
> expects existence of domain zero. In systems without hot plug support
> with small number of domains (e.g. 3) it means that there are always
> domains 0, 1 and 2.
> 
> > Its hard to call this a true regression unless it actually broke
> > something. The commit in question has been in the kernel since 4.8
> > which was released over 5 1/2 years ago.
> 
> I agree, it really depends on how you look at it.
> 
> The important is that lot of people are using LTS versions and are
> doing upgrades when LTS support is dropped. Which for 4.4 now
> happened. So not all smaller or "cosmetic" changes could be detected
> until longer LTS period pass.
> 
> > With all that said looking closer at the code in question I think
> > it is fair to assume that the author only intended this change for
> > powernv and pseries platforms and not every powerpc platform. That
> > change was done to make persistent naming easier to manage in
> > userspace.
> 
> I agree that this behavior change may be useful in some situations
> and I do not object this need.
> 
> > Your change defaults back to the old behavior which will now break
> > both powernv and pseries platforms with regard to hotplugging and
> > persistent naming.
> 
> I was aware of it, that change could cause issues. And that is why I
> added config option for choosing behavior. So users would be able to
> choose what they need.
> 
> > We could properly limit it to powernv and pseries by using
> > ibm,fw-phb-id instead of reg property in the look up that follows
> > a failed ibm,opal-phbid lookup. I think this is acceptable as long
> > as no other powerpc platforms have started using this behavior for
> > persistent naming.
> 
> And what about setting that new config option to enabled by default
> for those series?
> 
> Or is there issue with introduction of the new config option?
> 
> One of the point is that it is really a good idea to have
> similar/same behavior for all linux platforms. And if it cannot be
> enabled by default (for backward compatibility) add at least some
> option, so new platforms can start using it or users can decide to
> switch behavior.

This is a powerpc thing so I'm just kibbitzing a little.

This basically looks like a new config option to selectively revert
63a72284b159.  That seems hard to maintain and doesn't seem like
something that needs to be baked into the kernel at compile-time.

The 63a72284b159 commit log says persistent NIC names are tied to PCI
domain/bus/dev/fn addresses, which seems like something we should
discourage because we can't predict PCI addresses in general.  I
assume other platforms typically use udev with MAC addresses or
something?

> > > For example, prior that commit on P2020 RDB board were PCI
> > > domains 0, 1 and 2.
> > > 
> > > $ lspci
> > > 0000:00:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > 0000:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
> > > 0001:02:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > 0001:03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)
> > > 0002:04:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > 0002:05:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter
> > > 
> > > After that commit on P2020 RDB board are PCI domains 0x8000,
> > > 0x9000 and 0xa000.
> > > 
> > > $ lspci
> > > 8000:00:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > 8000:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
> > > 9000:02:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > 9000:03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)
> > > a000:04:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21)
> > > a000:05:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter
> > > 
> > > It is somehow strange that PCI domains are not indexed one by one and
> > > also that there is no domain 0
> > > 
> > > With my patch when CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG is not set, then
> > > previous behavior used and PCI domains are again 0, 1 and 2.
> > > 
> > >> Usually we don't commit regressions to mainline ...
> > >>
> > >>> Fix this issue by introducing a new option
> > >>> CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG When this options is
> > >>> disabled then powerpc kernel would assign PCI domains in the
> > >>> similar way like it is doing kernel for other architectures
> > >>> and also how it was done prior that commit.
> > >>
> > >> You don't define CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG on by
> > >> default, it means this commit will change the behaviour. Is
> > >> that expected ?
> > >>
> > >> Is that really worth a user selectable option ? Is the user
> > >> able to decide what he needs ?
> > > 
> > > Well, I hope that maintainers of that code answer to these
> > > questions.
> > > 
> > > In any case, I think that it could be a user selectable option
> > > as in that commit is explained that in some situation is makes
> > > sense to do PCI domain numbering based on DT reg.
> > > 
> > > But as I pointed above, upgrading from 4.4 TLS kernel to some
> > > new TLS kernel brings above regression, so I think that there
> > > should be a way to disable this behavior.
> > > 
> > > In my opinion, for people who are upgrading from 4.4 TLS kernel,
> > > this option should be turned off by default (= do not change
> > > behavior). For people who want same behaviour on powerpc as on
> > > other platforms, also it should be turned off by default.
> > > 
> > >>>
> > >>> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
> > >>
> > >> Is that really a fix ? What is the problem really ?
> > > 
> > > Problem is that PCI domains were changed in a way that is not
> > > compatible neither with version prior that commit and neither
> > > with how other linux platforms assign PCI domains for
> > > controllers.
> > > 
> > >>> Signed-off-by: Pali Roh�r <pali@kernel.org>
> > >>> ---
> > >>>   arch/powerpc/Kconfig             | 10 ++++++++++
> > >>>   arch/powerpc/kernel/pci-common.c |  4 ++--
> > >>>   2 files changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > >>> index 174edabb74fa..4dd3e3acddda 100644
> > >>> --- a/arch/powerpc/Kconfig
> > >>> +++ b/arch/powerpc/Kconfig
> > >>> @@ -375,6 +375,16 @@ config PPC_OF_PLATFORM_PCI
> > >>>   	depends on PCI
> > >>>   	depends on PPC64 # not supported on 32 bits yet
> > >>>   
> > >>> +config PPC_PCI_DOMAIN_FROM_OF_REG
> > >>> +	bool "Use OF reg property for PCI domain"
> > >>> +	depends on PCI
> > >>
> > >> Should it depend on PPC_OF_PLATFORM_PCI instead ?
> > > 
> > > No, PPC_OF_PLATFORM_PCI has line "depends on PPC64 # not supported on 32
> > > bits yet". But it is already used also for e.g. P2020 which is 32-bit
> > > platform.
> > > 
> > >>> +	help
> > >>> +	  By default PCI domain for host bridge during its registration is
> > >>> +	  chosen as the lowest unused PCI domain number.
> > >>> +
> > >>> +	  When this option is enabled then PCI domain is determined from
> > >>> +	  the OF / Device Tree 'reg' property.
> > >>> +
> > >>>   config ARCH_SUPPORTS_UPROBES
> > >>>   	def_bool y
> > >>>   
> > >>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > >>> index 8bc9cf62cd93..8cb6fc5302ae 100644
> > >>> --- a/arch/powerpc/kernel/pci-common.c
> > >>> +++ b/arch/powerpc/kernel/pci-common.c
> > >>> @@ -74,7 +74,6 @@ void __init set_pci_dma_ops(const struct dma_map_ops *dma_ops)
> > >>>   static int get_phb_number(struct device_node *dn)
> > >>>   {
> > >>>   	int ret, phb_id = -1;
> > >>> -	u32 prop_32;
> > >>>   	u64 prop;
> > >>>   
> > >>>   	/*
> > >>> @@ -83,7 +82,8 @@ static int get_phb_number(struct device_node *dn)
> > >>>   	 * reading "ibm,opal-phbid", only present in OPAL environment.
> > >>>   	 */
> > >>>   	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
> > >>
> > >> This looks like very specific, it is not reflected in the commit log.
> > > 
> > > I have not changed nor touched this "ibm,opal-phbid" setting. And it was
> > > not also touched in that mentioned patch. I see that no DTS file in
> > > kernel use this option (so probably only DTS files supplied by
> > > bootloader use it). So I thought that there is not reason to mention in
> > > commit message.
> > > 
> > > But if you think so, I can add some info to commit message about it.
> > > 
> > >>> -	if (ret) {
> > >>> +	if (ret && IS_ENABLED(CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG)) {
> > >>> +		u32 prop_32;
> > >>>   		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
> > >>>   		prop = prop_32;
> > >>>   	}
> > 
