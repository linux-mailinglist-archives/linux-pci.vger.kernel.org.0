Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A769E9B1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 22:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBUVqT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 16:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBUVqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 16:46:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFC2BECA
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 13:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53772B810DD
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 21:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F657C433EF;
        Tue, 21 Feb 2023 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677015974;
        bh=/s5RH7aWG1ji8SvDZn5/EiuDP/e8OYFCuTciQJiSuYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0PnoF9FBjti++mtPpvvLYKurCCs4PxFU/wFWBlcE9Dl4j/ov/2MqmVmwkQXgyyX1
         2mXbopxSljX898V7jYSd+n/oTOjJE53Xe3X1fCtBcqnCtAEF6JXQQLQxZin7ICS82U
         JMiIscyAtnneqBYM3RVp+7wTGIri2xHnzJTiL8TWD/TrrX4KWxfU97ypdIO2POc0KR
         9x+gI5pT0zDcxc5ApaxnDR0W0P277dYFQIvxNfdjEm+kZdG4HW0RwJm/LU0B/T140o
         raz7rtgeXKYgMThU5hEZRL+/Y4uZ/a2On630GFsduQ1S/+596TZeubSJquz0sCziOD
         8ZBzwWkqROhRQ==
Received: by pali.im (Postfix)
        id AE7FF708; Tue, 21 Feb 2023 22:46:11 +0100 (CET)
Date:   Tue, 21 Feb 2023 22:46:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20230221214611.yfpsrzuupatzz2g5@pali>
References: <alpine.DEB.2.21.2302022022230.45310@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302191849230.25434@angie.orcam.me.uk>
 <20230219194619.GA25088@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219194619.GA25088@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Sunday 19 February 2023 20:46:19 Lukas Wunner wrote:
> [+cc Philipp]
> 
> On Sun, Feb 19, 2023 at 06:52:21PM +0000, Maciej W. Rozycki wrote:
> > On Sun, 5 Feb 2023, Maciej W. Rozycki wrote:
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

This is interesting. Do you know which layer it indicates that is up?
I can image that PCIe physical layer or data link layer is up but
PCIe transaction layer not yet up and so sending config requests fail.
Existence of custom register may explain that it indicates different
"link up" meaning.

> Due to a quirk of the Broadcom STB host controller, ECAM access to
> the inaccessible switch raises an unhandled CPU exception and thus
> causes a kernel panic, making the issue difficult to debug.

Is this ARM Cortex A53 core and unhandled exception is asynchronous one
with syndrome 0xbf000002?

> The switch works fine 100% when plugged into a TI Sitara AM64 board
> (contains a DesignWare-derived PCIe host controller).

It is really DesignWare? I had an impression that TI uses PCIe IPs from
Cadence, not from DesignWare. And Cadence controllers behave in some
cases different from Designware controllers.

> The switch is the same as yours, only with 4 instead of 3 ports.
> Perhaps the issue you're seeing isn't specific to the ASMedia switch,
> but is due to an oddity of the Pericom switch, that happens to be
> triggered by the Broadcom STB host controller as well?
> 
> I've cooked up a modified version of patch 7 in your series which
> performs the link retraining in the pci-brcmstb.c driver before
> performing the first access to the switch.  Unfortunately it
> didn't result in any kind of improvement.  Next step is to hook up
> a Teledyne T28 analyzer to see what's going on.

Can you use Teledyne T28 for debugging this issue? Because this is
something which can finally show what is happing there.

I would really like to see what switch and controller are sending that
they can result in such buggy and incredible state.

> Thanks,
> 
> Lukas
