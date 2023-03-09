Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593716B309E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 23:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCIWa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 17:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCIWaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 17:30:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432CFA8C5
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 14:30:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A8F6144D
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 22:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1736AC433EF;
        Thu,  9 Mar 2023 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678401053;
        bh=7/YxUtGP+j4DOBEMNFflmWIb5BDOsvA1oQfB1iTRikA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ik6jKVCS0/3cafafqxQFyunlBpwMFHAMEIdJe76dyLzuvW/arWk/wWdxR7f0RYy3a
         RWP+jKxeChM8UpCKfaAzycd1g+zUNRu9ntV7Ce2y+0dsuHrY4+QYdpD5sc+Cdaj7Kx
         FRZnhAnTM+VubNv4YC1jC9bVVnMKONaVT9jU5OIyBBNJwd6GiQ6Hgm6/X6DG+qz+EI
         /JdPtD3Z+euVrD2nBhUYe9djj/WV+sZGk24XgRIw+T0xtshRIhEXbEW7VD9NxlmvBC
         JuMgD95OvhDNN/PULercK+Tm/g1erT14HzMijRSKgBywqIFBdBGEvfny5cQOwgehXD
         AuP2pv40WdrCQ==
Date:   Thu, 9 Mar 2023 16:30:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <bnatikar@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230309223051.GA1178661@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edd370c-e9e2-733c-2d79-51a08dd10e9d@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> On 3/9/2023 12:25, Bjorn Helgaas wrote:
> ...

> > > > https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
> > 
> > That nbio_v7.2.c patch and this patch don't look anything alike.  It
> > looks like the nbio_v7.2.c patch might run once?  Could *this* be done
> > once at enumeration-time, too?
> 
> They don't look anything alike because they're attacking the problem from
> different angles.

Why do we need different angles?

> The NBIO patch fixes the initialization value for the internal registers.
> This is what the BIOS "should" have done.  When the internal registers are
> configured properly then the behavior the kernel expects works as well.
> 
> The NBIO patch will run both at amdgpu startup as well as when resuming from
> suspend.

If initializing something as BIOS should have done makes the hardware
work correctly, isn't once enough?  Why does the NBIO patch need to
run at resume-time?

> This patch we're discussing treats the symptoms of the deficiency and avoids
> the impact.
> This patch runs any time the controller is runtime resumed.  So, yes it will
> run more frequently.  Because this patch is treating the symptoms it needs
> to be applied every single time the controller exits D3.

This patch runs at *suspend*-time (DECLARE_PCI_FIXUP_SUSPEND), not
resume-time.

The difference is important because with this broken BIOS, MSI-X is
disabled between the suspend quirk and some distant point in resume.
With non-broken BIOS, MSI-X remains *enabled* for at least part of
that period, and I don't want to have to figure out whether that
difference is important.

We have fragments of a coherent commit log, but it's not quite a
complete story yet.  I think so far we have:

  - Issue affects only the 1022:15b8 USB controller (well, I guess it
    also affects some GPU device?)
  - Only a problem when BIOS doesn't initialize controller correctly
  - Controller claims to preserve internal state on D3hot->D0
    transition, but it doesn't
  - D0->D3hot->D0 transitions do preserve external PCI_MSIX_FLAGS
    state; only internal state is lost
  - When MSI-X is enabled and controller transitions D0->D3hot->D0,
    MSI-X appears enabled per PCI_MSIX_FLAGS, but is actually
    *disabled* because the internal state was lost
  - MSI-X being disabled leads to xhci_hcd command timeouts because
    interrupts are missed
  - Not possible for an enumeration-time quirk to fix the controller
    initialization problem (why not?)
  - Writing PCI_MSIX_FLAGS with a *different* value fixes the internal
    state; writing the same value does nothing
  - A suspend- or resume-time quirk can work around this, and this is
    safe on *all* 1022:15b8 devices regardless of whether the BIOS is
    broken
  - The same approach can't be used for both 1022:15b8 and the GPU
    device because ...?

Bjorn
