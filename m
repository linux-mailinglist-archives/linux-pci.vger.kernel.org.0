Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237054FE4D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiFQU1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQU1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E722DEF8;
        Fri, 17 Jun 2022 13:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 069B362020;
        Fri, 17 Jun 2022 20:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E9C3411B;
        Fri, 17 Jun 2022 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497664;
        bh=1h7MPvCH+0ac659Y59O+LN7H9yf7FDL7AzRyBezl7Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAdK1iR7a1WmLfVx5wRu4og+zBfk6P1uN39+gS6uvwC1k/3eefV6ILqmVxxWnZygQ
         bBBOoIxihb0QmMQWOSV4VTF/L2bWEchyx/e//N/c6pYQvi8xU2lKBgwnYRqy701IKG
         ssin1X/FApCNiJh7UqRMIBdBF9N8dHd9ROFutNCfyAobYjQv5VoAedCEVbGiDMcB6b
         oU7ul27EaaCoZMvopX6aBu27/m86c8BzFJVWs6TSb4O8xF5Q/pWYL/CNBCGDGXrx4S
         rgd2ceX8FSUrsv+DobF4lumuhsMka6+CtL70oaOV8GR5nfOmNwERtvTdMDNEnMURGm
         v2a45NA/RU2YA==
Date:   Fri, 17 Jun 2022 14:27:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <YqzjvO34ebaRpraz@kbusch-mbp.dhcp.thefacebook.com>
References: <YqkeF2uqAyyxiZrQ@kbusch-mbp.dhcp.thefacebook.com>
 <20220615151100.GA937185@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151100.GA937185@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 10:11:00AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 04:47:35PM -0700, Keith Busch wrote:
> > On Tue, Jun 14, 2022 at 06:01:28PM -0500, Bjorn Helgaas wrote:
> > > [+cc NVMe folks]
> > > 
> > > On Tue, Jun 14, 2022 at 07:49:27PM -0300, Guilherme G. Piccoli wrote:
> > > > On 14/06/2022 12:47, Hans de Goede wrote:
> > > > > [...]
> > > > > 
> > > > > Have you looked at the log of the failed boot in the Steam Deck kernel
> > > > > bugzilla? Everything there seems to work just fine and then the system
> > > > > just hangs. I think that maybe it cannot find its root disk, so maybe
> > > > > an NVME issue ?
> > > > 
> > > > *Exactly* that - NVMe device is the root disk, it cannot boot since the
> > > > device doesn't work, hence no rootfs =)
> > > 
> > > Beginning of thread: https://lore.kernel.org/r/20220612144325.85366-1-hdegoede@redhat.com
> > > 
> > > Steam Deck broke because we erroneously trimmed out the PCI host
> > > bridge window where BIOS had placed most devices, successfully
> > > reassigned all the PCI bridge windows and BARs, but some devices,
> > > apparently including NVMe, didn't work at the new addresses.
> > > 
> > > Do you NVMe folks know of gotchas in this area?  I want to know
> > > because we'd like to be able to move devices around someday to
> > > make room for hot-added devices.
> > > 
> > > This reassignment happened before drivers claimed the devices, so
> > > from a PCI point of view, I don't know why the NVMe device
> > > wouldn't work at the new address.
> > 
> > The probe status quickly returns ENODEV. Based on the output (we
> > don't log much, so this is just an educated guesss), I think that
> > means the driver read all F's from the status register, which
> > indicates we can't read it when using the reassigned memory window.
> > 
> > Why changing memory windows may not work tends to be platform or
> > device specific. Considering the renumbered windows didn't cause a
> > problem for other devices, it sounds like this nvme device may be
> > broken.
> 
> It sounds like you've seen this sort of problem before, so we
> shouldn't assume that it's safe to reassign BARs.

I haven't seen this type of problem in years, but as I recall, it was always
low-end consumer crap that couldn't deal with changing BARs; you're stuck with
whatever was set after it was initially powered on. The PCI topology will
reflect the expected renumbering, but whatever is happening on the other side
of the PCI function seems to be unaware of the change.
