Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3F701CD6
	for <lists+linux-pci@lfdr.de>; Sun, 14 May 2023 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjENKKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 May 2023 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENKKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 May 2023 06:10:48 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858E171B;
        Sun, 14 May 2023 03:10:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E87BB2800C972;
        Sun, 14 May 2023 12:10:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DBA204A8C1; Sun, 14 May 2023 12:10:41 +0200 (CEST)
Date:   Sun, 14 May 2023 12:10:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <20230514101041.GA1881@wunner.de>
References: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com>
 <ZF0P2hedTFXPv8IK@bhelgaas>
 <20230511202332.GD31598@wunner.de>
 <51577aaa-dc96-d588-2ecf-5bac4b59284@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51577aaa-dc96-d588-2ecf-5bac4b59284@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 11:25:32AM +0300, Ilpo Järvinen wrote:
> On Thu, 11 May 2023, Lukas Wunner wrote:
> > On Thu, May 11, 2023 at 10:55:06AM -0500, Bjorn Helgaas wrote:
> > > I didn't see the prior discussion with Lukas, so maybe this was
> > > answered there, but is there any reason not to add locking to
> > > pcie_capability_clear_and_set_word() and friends directly?
> > > 
> > > It would be nice to avoid having to decide whether to use the locked
> > > or unlocked versions.
> > 
> > I think we definitely want to also offer lockless accessors which
> > can be used in hotpaths such as interrupt handlers if the accessed
> > registers don't need any locking (e.g. because there are no concurrent
> > accesses).
> > 
> > So the relatively lean approach chosen here which limits locking to
> > Link Control and Link Control 2, but allows future expansion to other
> > registers as well, seemed reasonable to me.
> 
> I went through every single use of these functions in the mainline tree 
> excluding LNKCTL/LNKCTL2 ones which will be having the lock anyway:
> 
> - pcie_capability_clear_and_set_*
> - pcie_capability_set_*
> - pcie_capability_clear_*

We're also performing RMW through pcie_capability_read_word() +
pcie_capability_write_word() combos, see drivers/pci/hotplug/pciehp_hpc.c
for examples.


> Do you still feel there's a need to differentiate this per capability 
> given all the information above?

What I think is unnecessary and counterproductive is to add wholesale
locking of any access to the PCI Express Capability Structure.

It's fine to have a single spinlock, but I'd suggest only using it
for registers which are actually accessed concurrently by multiple
places in the kernel.


> spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_set_word(dev, PCI_EXP_RTCTL,
> spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_clear_word(dev, PCI_EXP_RTCTL,
[...]
> What's more important though, isn't it possible that AER and PME RMW
> PCI_EXP_RTCTL at the same time so it would need this RMW locking too 
> despite the pme internal spinlock?

Yes that looks broken, so RTCTL would be another register besides
LNKCTL and LNKCTL2 that needs protection, good catch.

Thanks,

Lukas
