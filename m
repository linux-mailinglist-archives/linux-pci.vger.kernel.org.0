Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5678B54C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjH1QYL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjH1QXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 12:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180AD9;
        Mon, 28 Aug 2023 09:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C90639B1;
        Mon, 28 Aug 2023 16:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4153C433C7;
        Mon, 28 Aug 2023 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239821;
        bh=K7533O2wMnAWID8cRz1Ud0yuXheJ3p6SvrbrA4sMl80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lvKl6WVZQwLS0054oeFCiCxJNxsyuh9RpWpTC8w0YpxrtwtXcb+UlOTbBz8GQ1JaI
         WYPgW4iJuk1G470a+kVBz0ia1jsnWSBtyT497gl4GXJhkeuAAavXdQHXsqp7Ff/hVE
         Wu9j8QIWtA/90ZiaWEz3lIiLkoeD737TgwBfsIIZt49bqPBOT6ztGiCVJrVHixGf76
         mdLox/hMBorEW7NIP7Y47GKbl1TqvhNERPNlwi+9ygXpk0F+MN3KVTse10/maiYpOv
         s1gm1+XADsU3llaVvN22x/NXUj6gLanm9DBqfmV5dZxgf3ReMlTx7DrTngncy3Ar5w
         X8z9FJOYvaJgg==
Date:   Mon, 28 Aug 2023 11:23:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
Message-ID: <20230828162338.GA753715@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6qOetGL8VrN8k42tkDksVRvNYAOirX0xbXoaUrJDPp+A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 28, 2023 at 03:29:08PM +0800, Kai-Heng Feng wrote:
> On Sat, Aug 26, 2023 at 9:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Aug 25, 2023 at 09:39:48AM +0300, Mika Westerberg wrote:
> > > On Fri, Aug 25, 2023 at 01:43:08PM +0800, Kai-Heng Feng wrote:
> > > > On Fri, Aug 25, 2023 at 1:29 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > > > > > On Thu, Aug 24, 2023 at 7:57 PM Mika Westerberg
> > > > > > <mika.westerberg@linux.intel.com> wrote:
> >
> > > > I think what Bjorn suggested is to keep AER enabled for D3hot, and
> > > > only disable it for D3cold and S3.
> > > >
> > > > > > Unless there are cases when device firmware behave differently to
> > > > > > D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> > > > > > and system S3.
> > > > >
> > > > > Yes, this makes sense.
> > > >
> > > > I agree that differentiate between D3hot and D3cold unnecessarily make
> > > > things more complicated, but Bjorn suggested errors reported by AER
> > > > under D3hot should still be recorded.
> > > > Do you have more compelling data to persuade Bjorn that AER should be
> > > > disabled for both D3 states?
> > >
> > > Is there even an AER error that can happen when a device is in D3hot
> > > (link is in L1) or D3cold (link is in L2/3)? I'm not an expert in AER
> > > but AFAICT these errors are reported when the device is in active state
> > > not when it is in low power state.
> >
> > I don't think a device in D3cold can signal its own errors.  But the
> > link transition to L2/L3 as a device goes to D3cold may cause the
> > bridge above to log an error.  And of course a config access to a
> > device in D3cold will probably result in an Unsupported Request being
> > logged by the bridge above it.  I think these are the sorts of errors
> > we do need to avoid or ignore somehow.
> 
> In addition to that, we can't really control what device behaves
> during the D3hot (L2) transition.

I don't think a link in L2 (main power off) can lead to a device in
D3hot, can it?  I assume that a device in D3hot can be returned to D0
by a config write to the PM CSR, and the link must be usable for that.

> The kernel can't control what the firmware on the device may
> respond.

The kernel can't directly control the internal behavior of the device,
but the behavior that's observable on the PCIe link should always
conform to the spec.

Do you see devices where a transition to D3hot may cause some kind of
non-compliant behavior on the link?  If so, then I guess we have to
consider whether to quirk them avoid D3hot completely or to work
around it somehow.

> > But Configuration and Message requests definitely happen in D3hot, and
> > they can cause errors reported via AER.  The spec (r6.0, sec 2.2.8)
> > recommends that Messages be handled the same in D0-D3hot.
> >
> > PTM is an example of where we had errors being reported at suspend/
> > resume because we had it configured incorrectly.  If we disabled AER
> > in D3hot we might not learn about that kind of configuration problem.
> > That's what makes me think there's some value in keeping AER enabled
> > in D3hot.
> 
> In this particular case, the firmware of the device gets power cycled
> and starts sending PTM because of that.
> For this case, we want to know the error happens, but in the meantime
> there's nothing much can be done.

So simply putting the device in D3hot restarts firmware on the device?
And it starts sending PTM requests after the restart?  I *assume* that
at least it only sends the PTM requests if the PTM Enable bit is set,
right?  That shouldn't cause us trouble unless we configured something
wrong.

Bjorn
