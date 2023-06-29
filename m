Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA4743032
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF2WLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjF2WLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 18:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD71BDB;
        Thu, 29 Jun 2023 15:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7485761637;
        Thu, 29 Jun 2023 22:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9584DC433C8;
        Thu, 29 Jun 2023 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688076665;
        bh=ZWQkNkiGCVg99RkFXg1VfNciOthfYzs8GMI8psWykUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s+zSYGf57WMSskkLvL5Ezxqbcs3M/EpFOqlEPfhqv8jN5ztfMaR6HtWidCsi4nTha
         iQkzHaJ8PB7X98sYtYOieu+0sYWuT3fesQ5bNz7vO55zTNh3ruxszJ6ioOekW2+Qwj
         G80fB1G1XpawN3xqE7YAdBAgeVLBysmV2GG/b1i9g7EDWC8FJFe7Yn4F2ud81sot9E
         QhnszuJUkYYgbdyanijHlbAx6FBHW1ys48RApFperOQg27LfGAkSh2I4qpG7U0hE9b
         JHVQ5WbKombzR82Fd6GZDIfXNF82hhaD/IG+LPETOE36Qm64jpzgjnlrfFEpBq87cr
         +zF0+Y0TJm+NQ==
Date:   Thu, 29 Jun 2023 17:11:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
Message-ID: <20230629221103.GA449329@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a6ce0da4d37ed2ba9673a60062e109503adca78.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali]

On Thu, Jun 29, 2023 at 05:27:54PM -0400, Radu Rendec wrote:
> On Thu, 2023-06-29 at 15:58 -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 29, 2023 at 04:42:07PM -0400, Radu Rendec wrote:
> > > On Thu, 2023-06-29 at 14:57 -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 29, 2023 at 02:30:19PM -0400, Radu Rendec wrote:
> > > > > The DesignWare PCIe host driver uses a chained interrupt to demultiplex
> > > > > the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabling both
> > > > > pcie2a and pcie3a at the same time can create an interrupt storm where
> > > > > the parent interrupt fires continuously, even though reading the PCIe
> > > > > host registers doesn't identify any child MSI interrupt source. This
> > > > > effectively locks up CPU0, which spends all the time servicing these
> > > > > interrupts.
> > > > > 
> > > > > This is a clear example of how bypassing the interrupt core by using
> > > > > chained interrupts can be very dangerous if the hardware misbehaves.
> > > > > 
> > > > > Convert the driver to use a regular interrupt for the demultiplex
> > > > > handler. This allows the interrupt storm detector to detect the faulty
> > > > > interrupt and disable it, allowing the system to run normally.

> ...
> > But you do imply that there's some DesignWare hardware issue involved,
> > too, so I guess it's possible the other drivers don't have an issue
> > and/or actually require the chained IRQs.  That's why I asked how we
> > should decide.
> 
> That makes sense. I don't know if it's a DesignWare hardware issue or
> something else down the PCIe bus. Other folks in my team are
> investigating the root cause. This thread has the details:
> https://lore.kernel.org/all/pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse/
> 
> I want to point out that this patch doesn't *fix* the root problem (the
> interrupt storm). It just makes the kernel handle it (much) better if
> it occurs.
> 
> I can't see why any driver would _require_ chained IRQs. As I see it,
> chained interrupts are just a "shortcut" that circumvents the IRQ core
> for (debatable) performance reasons. Other than that, they should work
> the same as regular interrupts.
> 
> There are other benefits associated with using regular interrupts. One
> of them is the ability to control the SMP affinity of the parent
> interrupt. But that's a different topic.

Thanks for mentioning IRQ affinity because that reminds me of a
long-standing related issue.  Pali posted a similar patch for mvebu
[1], but it's been stalled for a long time because apparently there's
some potential breakage of the userspace ABI [2].

Unfortunately I'm not an IRQ expert and haven't followed all the
arguments there.  BUT it does seem like Marc's objection to Pali's
patch would also apply to your patch, so maybe this is an opportune
time to re-evaluate the situation.

If converting from chained to normal handlers can be done safely, I
would definitely be in favor if doing it across all of drivers/pci/ at
once so they're all consistent.  Otherwise that code just gets copied
to new drivers, so the issue persists and spreads.

Bjorn

[1] https://lore.kernel.org/r/20220524122817.7199-1-pali@kernel.org
[2] https://lore.kernel.org/r/874k0bf7f7.wl-maz@kernel.org
