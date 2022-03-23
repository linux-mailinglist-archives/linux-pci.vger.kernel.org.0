Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764CB4E5314
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 14:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiCWNZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbiCWNZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 09:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7A2DD67;
        Wed, 23 Mar 2022 06:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5479615E2;
        Wed, 23 Mar 2022 13:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4097C340E8;
        Wed, 23 Mar 2022 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648041825;
        bh=8Xwrt+yAp5wzjaRWkS8R/tdZf2ywTiZm3wtOn2sTi5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bqbzj3WIZX0chTD/7XcSnjg1sEm38Y1Kh1C9TybT7Q+LCWigyybpsEWKiVHnHVldf
         9CWv9MvkPOPnp/hEXIfOETJpikchS8g7lWQopuYkq1RO6KEjGR8gnGSrW61+Bb3hdo
         XZ81la4UP5nuo95cTZ/XUTytITQOcydf6Wox1Q1wdxqy9GBAZTzPiqvx2Qv6oPmwme
         2NLoJ8OByQ8JZjp0uA614FpjHL9XwM72XrAYViPzVZOKq0tlx0AirEWiqvkyh9GB3G
         BLHGpquDlwhX9+sbWgJ/3xtkq76MC/wfTn+BUmEArNyVggkl3IHtXmn8PhJVwN+PVt
         vzWCjVTaGDBzw==
Date:   Wed, 23 Mar 2022 08:23:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
Message-ID: <20220323132343.GA1282700@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bf31d6a8957b837b999c02875456b805efdff1.camel@infradead.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 12:43:48PM +0000, David Woodhouse wrote:
> On Wed, 2022-03-23 at 10:03 +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 4:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> > > > setting PCI_COMMAND_INTX_DISABLE,
> > 
> > > > MSI doesn't work either.
> > 
> > I think this is not correct.
> 
> I think it was perfectly correct until you added a couple of newlines
> in the middle of the sentence, then took it out of context. :)
> 
> "If INTX is disabled, MSI doesn't work either".
> 
> But really, in that case surely the solution is *not* to disable INTX
> for this device. Then MSI will work, right?

That's what Andy's original patch [1] does, and MSI *does* work if we
skip disabling INTx.

I'm hesitant [2] about that approach because it creates two classes of
devices using MSI (most have INTx disabled but a few do not), which
makes it harder to reason about them.  For example, there are non-MSI
paths that read or set the "disable INTx" bit, so we have to consider:

  - will readers be surprised if a device using MSI has INTx enabled?

  - will writers care disabling INTx disables *all* interrupts, not
    just INTx?

So skipping the INTx disable certainly works most of the time and
*likely* works all the time, but there are cases that could be
problems and we don't have a compelling reason to use MSI on these
devices.

[1] https://lore.kernel.org/r/20220314101448.90074-1-andriy.shevchenko@linux.intel.com
[2] https://lore.kernel.org/r/20220318210947.GA845994@bhelgaas
