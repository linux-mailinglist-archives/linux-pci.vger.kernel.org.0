Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2E59746C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHQQmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiHQQmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 12:42:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BBD88DFB;
        Wed, 17 Aug 2022 09:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F944B81E25;
        Wed, 17 Aug 2022 16:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9BBC433D6;
        Wed, 17 Aug 2022 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660754568;
        bh=+wEnZVI2aj40wim23BMsG+ci2KQg9to47RsgHXVHy10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpvpIKT4XzsirkSD5uvjCpB+/1pIK+WsuRzW1OyY4JFHJM/UPgkTU0Dyof3gdxlD+
         N9UeWOT6DqR/F02nr8dTesCV9NATI2TGSUYB/R9tBGzxXPSg7QngOCs5ui5IBs+gJK
         rLwzJXJaLD1zhLxBAV94ZgMrFc9tma23ROcaLTcjfUc11WtX2f8GtAX3UuppT+RZ9D
         D/K4io2T2RJfGjy4B2YcPEiR8BzL+YTRRIVdYftQPQGNTKD9lAaaBVMtxJbptx87kx
         xeTN8Ihpf1nOpMTw7H4aCfYwqI9wj9ciPuFbzK99E0x0QcrXw5JhOlTMGBiJ4wrrEc
         osemWEeY22khw==
Received: by pali.im (Postfix)
        id AAA9C739; Wed, 17 Aug 2022 18:42:45 +0200 (CEST)
Date:   Wed, 17 Aug 2022 18:42:45 +0200
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
Message-ID: <20220817164245.qanxklpavge3shcm@pali>
References: <20220706104308.5390-1-pali@kernel.org>
 <20220706104308.5390-6-pali@kernel.org>
 <20220721222145.rzgthbwoselx2l43@pali>
 <875yjkb0ht.fsf@mpe.ellerman.id.au>
 <20220726111001.a2upqf5m5welcla6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726111001.a2upqf5m5welcla6@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 26 July 2022 13:10:01 Pali Rohár wrote:
> On Tuesday 26 July 2022 21:02:22 Michael Ellerman wrote:
> > Pali Rohár <pali@kernel.org> writes:
> > > On Wednesday 06 July 2022 12:43:08 Pali Rohár wrote:
> > >> By default on PPC32 are PCI bus numbers unique across all PCI domains.
> > >> So system could have only 256 PCI buses independently of available
> > >> PCI domains.
> > >>
> > >> This is due to filling DT property pci-OF-bus-map which does not reflect
> > >> multi-domain setup.
> > >>
> > >> On all powerpc platforms except chrp and powermac there is no DT property
> > >> pci-OF-bus-map anymore and therefore it is possible on non-chrp/powermac
> > >> platforms to avoid this limitation of maximal number of 256 PCI buses in
> > >> system even on multi-domain setup.
> > >>
> > >> But avoiding this limitation would mean that all PCI and PCIe devices would
> > >> be present on completely different BDF addresses as every PCI domain starts
> > >> numbering PCI bueses from zero (instead of the last bus number of previous
> > >> enumerated PCI domain). Such change could break existing software which
> > >> expects fixed PCI bus numbers.
> > >>
> > >> So add a new config option CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT which
> > >> enables this change. By default it is disabled. It cause that initial value
> > >> of hose->first_busno is zero.
> > >>
> > >> Signed-off-by: Pali Rohár <pali@kernel.org>
> > >> ---
> > >>  arch/powerpc/Kconfig         | 11 +++++++++++
> > >>  arch/powerpc/kernel/pci_32.c |  6 ++++++
> > >>  2 files changed, 17 insertions(+)
> > >>
> > >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > >> index be68c1f02b79..f66084bc1dfe 100644
> > >> --- a/arch/powerpc/Kconfig
> > >> +++ b/arch/powerpc/Kconfig
> > >> @@ -370,6 +370,17 @@ config PPC_DCR
> > >>  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> > >>  	default y
> > >>
> > >> +config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> > >> +	depends on PPC32
> > >> +	depends on !PPC_PMAC && !PPC_CHRP
> > >> +	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> > >> +	help
> > >> +	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> > >> +	  So system could have only 256 PCI buses independently of available
> > >> +	  PCI domains. When this option is enabled then PCI bus numbers are
> > >> +	  PCI domain dependent and each PCI controller on own domain can have
> > >> +	  256 PCI buses, like it is on other Linux architectures.
> > >> +
> > >
> > > What do you think, would it be possible to set default value of this
> > > option to enabled?
> > 
> > My preference would be to not have the option at all, just make it the
> > default behaviour. Every new CONFIG option adds more combinations that
> > need testing, or more likely don't get well tested.
> > 
> > But I don't have a good feel for what could break if we turn it on, so
> > honestly I don't really know.
> > 
> > Also I do most of my 32-bit testing on pmacs, which are not affected by
> > the change.
> 
> It is because this change is incompatible with deprecated pci-OF-bus-map
> which pmac uses. I do not have any pmac box for testing or development,
> so I let this part as is.
> 
> If one day pci-OF-bus-map would be possible to disable on pmac then this
> pci bus number change can be enabled also for pmac.

Hello! I have created this patch which allows to disable deprecated
pci-OF-bus-map on powermac and allow to enable this new config option
PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also on powermac.

So you can test this option too on your powermac boxes.

I'm really not sure if that pci-OF-bus-map is required and for which
platforms or software...

Patch for allowing to disable pci-OF-bus-map is here:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220817163927.24453-1-pali@kernel.org/

> > So I'll probably take the series as-is, and then we can do some more
> > widespread testing and possibly flip the default to enabled, and then
> > maybe remove the option entirely in future.
> > 
> > cheers
> 
> I have tested it on P2020 board with 3 PCIe devices, each on own bus
> where each bus is connected to different PCIe controller / domain and it
> works correctly. Every PCIe device is on bus 1 bus but on different
> domains.
