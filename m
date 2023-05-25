Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52321711948
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 23:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEYVk4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjEYVkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 17:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7FE1A8;
        Thu, 25 May 2023 14:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BAF64B6A;
        Thu, 25 May 2023 21:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7906C4339B;
        Thu, 25 May 2023 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685050850;
        bh=1uqUk6bD9K92o66z+OLfJTef++cVjRmb/LhsCFinS0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T8ILF/OALc4ipAqevwNHm2c9oon066GWZxBSUf/3nTTMrtAwf3lOiC+b7MH1z/QmO
         MN2OviW/Q/T/ga4W3koqQbWBvFn2PBstNGBTsJrJrnskdtEmZsP1mxOPh5T93nIUyr
         cV1h73AniJ1msYUFj17IWeeb1OFmqCb3pMMluvGfHeNX/mVWpcscRxqD+TYwn/4LoC
         eRPgS6GFKCYSoA7E4snPhdiMDehPe0LChhqNZe7l0Mz3v1iZEaqaHV/yDMRsk79kZP
         Qkh/cmNZV3pybWkVXaBcVHScVcJ6t2/Pyc0Eb9caJzku9g/LqyhXTBnVxYwaAjeD6k
         xcTXWeG/sB9Cw==
Date:   Thu, 25 May 2023 16:40:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
Message-ID: <ZG/V4C0zlXaFv/1b@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> On Wed, May 24, 2023 at 11:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > Some platforms (such as LoongArch) cannot provide enough irq numbers as
> > > many as logical cpu numbers. So we should limit pci irq numbers when
> > > allocate msi/msix vectors, otherwise some device drivers may fail at
> > > initialization. This patch add a cmdline parameter "pci_irq_limit=xxxx"
> > > to control the limit.
> > >
> > > The default pci msi/msix number limit is defined 32 for LoongArch and
> > > NR_IRQS for other platforms.
> >
> > The IRQ experts can chime in on this, but this doesn't feel right to
> > me.  I assume arch code should set things up so only valid IRQ numbers
> > can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> > command-line parameter that users have to discover and supply.
>
> The problem we meet: LoongArch machines can have as many as 256
> logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
> machine, 192 irqs can be easily exhausted if there are several NICs
> (NIC usually allocates msi irqs depending on the number of online
> cpus). So we want to limit the msi allocation.
> 
> This is not a LoongArch-specific problem, because I think other
> platforms can also meet if they have many NICs. But of course,
> LoongArch can meet it more easily because the available msi vectors
> are very few. So, adding a cmdline parameter is somewhat reasonable.

The patch contains "#ifdef CONFIG_LOONGARCH", which makes this
solution LoongArch-specific.  I'm not willing for that yet.

It sounds like the LoongArch MSI limit is known at compile-time, or at
least at boot-time, so the kernel ought to be able to figure out what
to do without a command-line parameter.

> After some investigation, I think it may be possible to modify
> drivers/irqchip/irq-loongson-pch-msi.c and override
> msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
> doing that need to remove the "static" before
> __msi_domain_alloc_irqs(), which means revert
> 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> __msi_domain_alloc_irqs() static"), I don't know whether that is
> acceptable.

I guess you mean msi_domain_ops::domain_alloc_irqs() (not
msi_domain_info).  If this is really a generic problem, I'm surprised
that no other arch has needed to override .domain_alloc_irqs().

I think you'll have better luck getting feedback if you can post the
complete working patch.  At the very least, you'll learn more about
the problem by doing that.

Bjorn
