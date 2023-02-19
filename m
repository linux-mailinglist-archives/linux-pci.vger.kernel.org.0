Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F69C22F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Feb 2023 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBSTqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Feb 2023 14:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBSTqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2023 14:46:24 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F1DBBB1
        for <linux-pci@vger.kernel.org>; Sun, 19 Feb 2023 11:46:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 95E8F102E4DB9;
        Sun, 19 Feb 2023 20:46:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6D74836473; Sun, 19 Feb 2023 20:46:19 +0100 (CET)
Date:   Sun, 19 Feb 2023 20:46:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PING][PATCH v6 0/7] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20230219194619.GA25088@wunner.de>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Philipp]

On Sun, Feb 19, 2023 at 06:52:21PM +0000, Maciej W. Rozycki wrote:
> On Sun, 5 Feb 2023, Maciej W. Rozycki wrote:
> >  This is v6 of the change to work around a PCIe link training phenomenon 
> > where a pair of devices both capable of operating at a link speed above 
> > 2.5GT/s seems unable to negotiate the link speed and continues training 
> > indefinitely with the Link Training bit switching on and off repeatedly 
> > and the data link layer never reaching the active state.
> 
>  Ping for: 
> <https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk/>.

Philipp is witnessing similar issues with a Pericom PI7C9X2G404EL
switch below a Broadcom STB host controller:  On some rare occasions,
when booting the system the link trains correctly at 5 GT/s and the
switch is accessible without any issues.  But most of the time,
the switch is inaccessible on boot.  The Broadcom STB host controller
claims not to support Link Active Reporting, but in reality has a
link status indicator in a custom register.  It indicates that the
link is up, the link trains to 2.5 GT/s but the switch is inaccessible.
Due to a quirk of the Broadcom STB host controller, ECAM access to
the inaccessible switch raises an unhandled CPU exception and thus
causes a kernel panic, making the issue difficult to debug.

The switch works fine 100% when plugged into a TI Sitara AM64 board
(contains a DesignWare-derived PCIe host controller).

The switch is the same as yours, only with 4 instead of 3 ports.
Perhaps the issue you're seeing isn't specific to the ASMedia switch,
but is due to an oddity of the Pericom switch, that happens to be
triggered by the Broadcom STB host controller as well?

I've cooked up a modified version of patch 7 in your series which
performs the link retraining in the pci-brcmstb.c driver before
performing the first access to the switch.  Unfortunately it
didn't result in any kind of improvement.  Next step is to hook up
a Teledyne T28 analyzer to see what's going on.

Thanks,

Lukas
