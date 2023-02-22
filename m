Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933FC69F084
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBVIkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 03:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBVIki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 03:40:38 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883F367C4
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 00:40:35 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C921E100DE9FB;
        Wed, 22 Feb 2023 09:40:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9F7FD137EF; Wed, 22 Feb 2023 09:40:33 +0100 (CET)
Date:   Wed, 22 Feb 2023 09:40:33 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PING][PATCH v6 0/7] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20230222084033.GA31047@wunner.de>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk>
 <20230219194619.GA25088@wunner.de>
 <20230221214611.yfpsrzuupatzz2g5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221214611.yfpsrzuupatzz2g5@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 21, 2023 at 10:46:11PM +0100, Pali Rohár wrote:
> On Sunday 19 February 2023 20:46:19 Lukas Wunner wrote:
> > > On Sun, 5 Feb 2023, Maciej W. Rozycki wrote:
> > > >  This is v6 of the change to work around a PCIe link training phenomenon
> > > > where a pair of devices both capable of operating at a link speed above
> > > > 2.5GT/s seems unable to negotiate the link speed and continues training
> > > > indefinitely with the Link Training bit switching on and off repeatedly
> > > > and the data link layer never reaching the active state.
> > 
> > Philipp is witnessing similar issues with a Pericom PI7C9X2G404EL
> > switch below a Broadcom STB host controller:  On some rare occasions,
> > when booting the system the link trains correctly at 5 GT/s and the
> > switch is accessible without any issues.  But most of the time,
> > the switch is inaccessible on boot.  The Broadcom STB host controller
> > claims not to support Link Active Reporting, but in reality has a
> > link status indicator in a custom register.  It indicates that the
> > link is up, the link trains to 2.5 GT/s but the switch is inaccessible.
> 
> This is interesting. Do you know which layer it indicates that is up?
> I can image that PCIe physical layer or data link layer is up but
> PCIe transaction layer not yet up and so sending config requests fail.
> Existence of custom register may explain that it indicates different
> "link up" meaning.

drivers/pci/controller/pcie-brcmstb.c defines the following bits:

#define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK           0x80
#define  PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK      0x20
#define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK      0x10
#define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK    0x40

And brcm_pcie_link_up() checks that both DL_ACTIVE and PHYLINKUP are set.

A public spec for the Broadcom STB PCIe controller does not seem to exist,
so I do not know what the register bits mean exactly.


> > Due to a quirk of the Broadcom STB host controller, ECAM access to
> > the inaccessible switch raises an unhandled CPU exception and thus
> > causes a kernel panic, making the issue difficult to debug.
> 
> Is this ARM Cortex A53 core and unhandled exception is asynchronous one
> with syndrome 0xbf000002?

It's a Cortex A72 and yes the exception looks like this:

SError Interrupt on CPU1, code 0x00000000bf000002 -- SError

I was wondering why we're not checking in the exception handler whether
the accessed address is in ECAM space, and just return from the handler
since such exceptions could be handled by returning "all ones" in
software from the PCI core.

Then again, perhaps there's a method to stop the controller from
raising an exception on ECAM access to an inaccessible device.
If such a method exists (e.g. some register bit), that would
obviously be preferred.


> > The switch works fine 100% when plugged into a TI Sitara AM64 board
> > (contains a DesignWare-derived PCIe host controller).
> 
> It is really DesignWare? I had an impression that TI uses PCIe IPs from
> Cadence, not from DesignWare. And Cadence controllers behave in some
> cases different from Designware controllers.

You're right, I was mistaken, it's indeed a Cadence.


> > Next step is to hook up
> > a Teledyne T28 analyzer to see what's going on.
> 
> Can you use Teledyne T28 for debugging this issue? Because this is
> something which can finally show what is happing there.

Yes it should be possible to debug this, the analyzer is capable of
logging the link training sequence and present it in a Wireshark-esque
interface.

Thanks,

Lukas
