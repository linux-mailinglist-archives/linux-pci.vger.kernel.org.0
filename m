Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EEE703C9D
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjEOS2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEOS2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 14:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3046B2;
        Mon, 15 May 2023 11:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E3F620BA;
        Mon, 15 May 2023 18:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6196AC433D2;
        Mon, 15 May 2023 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684175304;
        bh=uA+SpOMqprPZ3lP47QFJp0wllKNyr/Crd+3iBg3DRj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F8mE4AroG+Zip9N6xZ6c/6RNitCRem8ymrWbwyV9piGLFz5lazdPX+jHZCxBas5oT
         HeJgXb6jtJFPk7eEQP3bLyBhs7cEFEwa0ou38WkbeXhq/iit1Tyu9gc0c0OZ4h+7ey
         OSJiWhQ2fbR9SOLqYnIEJZ+9bZEeavO6Vt4no6B9c7TVEmxH6/ctwhdfnzDcm0HLj+
         y84MEcgEeLWu8Ute/XsPdZuNhGnmRJ2BG0Vco24pXIrMUEDycbK0uTSG4Gcb0E0Dfy
         bAWaLbdXDsXtyoN/LUgaLiUZuACnagbEGkkjLAHBfKDDINziuQ0550KmP76UBG1dAU
         yf9fz4qOUSekQ==
Date:   Mon, 15 May 2023 13:28:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <ZGJ5xhWqxOc7vHjZ@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2832e4a-8ef5-8695-3ca2-2b2f287a44d@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 02:59:42PM +0300, Ilpo Järvinen wrote:
> On Sun, 14 May 2023, Lukas Wunner wrote:
> > On Fri, May 12, 2023 at 11:25:32AM +0300, Ilpo Järvinen wrote:
> > > On Thu, 11 May 2023, Lukas Wunner wrote:
> > > > On Thu, May 11, 2023 at 10:55:06AM -0500, Bjorn Helgaas wrote:
> > > > > I didn't see the prior discussion with Lukas, so maybe this was
> > > > > answered there, but is there any reason not to add locking to
> > > > > pcie_capability_clear_and_set_word() and friends directly?
> > > > > 
> > > > > It would be nice to avoid having to decide whether to use the locked
> > > > > or unlocked versions.
> > > > 
> > > > I think we definitely want to also offer lockless accessors which
> > > > can be used in hotpaths such as interrupt handlers if the accessed
> > > > registers don't need any locking (e.g. because there are no concurrent
> > > > accesses).
> > > > ...

> All PCI_EXP_SLTSTA ones looked not real RMW but ACK bits type of writes

PCI_EXP_SLTSTA, PCI_EXP_LNKSTA, etc are typically RW1C and do not need
the usual RMW locking (which I think is what you were saying).

> > ...
> > What I think is unnecessary and counterproductive is to add wholesale
> > locking of any access to the PCI Express Capability Structure.
> > 
> > It's fine to have a single spinlock, but I'd suggest only using it
> > for registers which are actually accessed concurrently by multiple
> > places in the kernel.
> 
> While it does feel entirely unnecessary layer of complexity to me, it would 
> be possible to rename the original pcie_capability_clear_and_set_word() to 
> pcie_capability_clear_and_set_word_unlocked() and add this into 
> include/linux/pci.h:
> 
> static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
> 					int pos, u16 clear, u16 set)
> {
> 	if (pos == PCI_EXP_LNKCTL || pos == PCI_EXP_LNKCTL2 ||
> 	    pos == PCI_EXP_RTCTL)
> 		pcie_capability_clear_and_set_word_locked(...);
> 	else
> 		pcie_capability_clear_and_set_word_unlocked(...);
> }
> 
> It would keep the interface exactly the same but protect only a selectable 
> set of registers. As pos is always a constant, the compiler should be able 
> to optimize all the dead code away.
> 
> Would that be ok then?

Sounds like you have a pretty strong opinion, Lukas, but I guess I
don't really understand the value of having locked and unlocked
variants of RMW accessors.  Config accesses are relatively slow and I
don't think they're used in performance-sensitive paths.  I would
expect the lock to be uncontended and cheap relative to the config
access itself, but I have no actual numbers to back up my speculation.
Is the performance win worth the extra complexity in callers?

Bjorn
