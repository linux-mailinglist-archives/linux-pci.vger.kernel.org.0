Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0261469F3BA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBVLy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBVLyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 06:54:37 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D86B92822E
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 03:54:35 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EFBE292009C; Wed, 22 Feb 2023 12:54:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E88A892009B;
        Wed, 22 Feb 2023 11:54:32 +0000 (GMT)
Date:   Wed, 22 Feb 2023 11:54:32 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PING][PATCH v6 0/7] pci: Work around ASMedia ASM2824 PCIe link
 training failures
In-Reply-To: <20230219194619.GA25088@wunner.de>
Message-ID: <alpine.DEB.2.21.2302220459100.48569@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk> <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk> <20230219194619.GA25088@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 19 Feb 2023, Lukas Wunner wrote:

> > >  This is v6 of the change to work around a PCIe link training phenomenon 
> > > where a pair of devices both capable of operating at a link speed above 
> > > 2.5GT/s seems unable to negotiate the link speed and continues training 
> > > indefinitely with the Link Training bit switching on and off repeatedly 
> > > and the data link layer never reaching the active state.
> > 
> >  Ping for: 
> > <https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk/>.
> 
> Philipp is witnessing similar issues with a Pericom PI7C9X2G404EL
> switch below a Broadcom STB host controller:  On some rare occasions,
> when booting the system the link trains correctly at 5 GT/s and the
> switch is accessible without any issues.  But most of the time,
> the switch is inaccessible on boot.  The Broadcom STB host controller
> claims not to support Link Active Reporting, but in reality has a
> link status indicator in a custom register.  It indicates that the
> link is up, the link trains to 2.5 GT/s but the switch is inaccessible.

 Thank you for chiming in.

 Note that the U-Boot variant of this workaround referred to by the link 
in the change description does not rely on Link Active Reporting, but 
busy-loops polling on Link Training status instead and verifies training 
remains stable off long enough.  We can't do this in Linux of course, but 
I guess a variant using link status reported in a vendor-specific register 
could be made.

> The switch is the same as yours, only with 4 instead of 3 ports.
> Perhaps the issue you're seeing isn't specific to the ASMedia switch,
> but is due to an oddity of the Pericom switch, that happens to be
> triggered by the Broadcom STB host controller as well?

 I have seen two reports from people claiming their devices to be absent 
from `lspci' output, an Intel and a Realtek NIC respectively, when plugged 
into a slot behing the ASMedia switch, while working just fine in another 
system.  Neither replied to my request for further information, so it's 
not clear to me if it's the same issue, but it may or may not be limited 
to Pericom hardware.

 As I mentioned in previous iterations of the change there is an option 
card available with the ASM2824 switch onboard and dual M.2 slots behind, 
which could be used for experimenting.  Sold under the StarTech brand as 
PEX8M2E2 and under the Ableconn brand as PEXM2-130.  And M.2 M-Key to PCIe 
slot adapters are widely available.  I just can't be persuaded to buy such 
an option card, especially as ASMedia have been unhelpful and ignored my 
enquiry.

> I've cooked up a modified version of patch 7 in your series which
> performs the link retraining in the pci-brcmstb.c driver before
> performing the first access to the switch.  Unfortunately it
> didn't result in any kind of improvement.  Next step is to hook up
> a Teledyne T28 analyzer to see what's going on.

 That would be most helpful, although given your lack of success with my
workaround it might be a different issue here after all.

 Let me know if I could help anyhow.  I have a few of these Pericom-based 
riser card adapters as spares, though I'm short on high-speed (5GT/s+) 
PCIe slots to try them with.  Delock has claimed, back in Jul 2021, I'm 
the only one to report them the device not to work.

  Maciej
