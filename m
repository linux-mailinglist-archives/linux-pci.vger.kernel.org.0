Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3875856F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGRTY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGRTY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 15:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADAF198D;
        Tue, 18 Jul 2023 12:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDB0616B9;
        Tue, 18 Jul 2023 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E60C433C7;
        Tue, 18 Jul 2023 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689708293;
        bh=qdAhpK1XWeLAN71lc0Y9kyyM+NLhNWrfXG4CFOZK0OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n6TT8nZLi9Pu6qYPkbR79iGdZf/xTelKI4ID1ZvYs+ryvcky461erRgFpveupe0bW
         vQlmqTc2yT6Wv5QvPjbNK6zf6FKtcfgdb1cnVzLFFqhaakQe/2YIlYuhSlmDktNMU5
         D9jLWi+YFgLffoeWTZiOlduz+2+zJIz9TR6A8GLxl6CIqv1GdV9Wf0pwGhYDNMpckK
         6ffhu3AN24Jo1+5iUtdo2a81G01f6QOx/E8hdQhHwIeBWoTOXNZFPheEvoeDedkEgT
         i8eLcdxr2B//lGlpmdc9D++BTG1+NbR7HM0530JhdzFOabGgVfNfZTIRiphDD1VOOR
         V/79lOQ+fkd2g==
Date:   Tue, 18 Jul 2023 14:24:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe
 devices
Message-ID: <20230718192450.GA489825@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc44cb41-b306-f18a-c9fc-3d956777f722@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 11:51:32AM -0500, Limonciello, Mario wrote:
> On 7/16/2023 10:34 PM, Kai-Heng Feng wrote:
> > On Sat, Jul 15, 2023 at 12:37 AM Mario Limonciello <mario.limonciello@amd.com> wrote:
> > > On 7/14/23 03:17, Kai-Heng Feng wrote:

> > > > The main point is OS should stick to the BIOS default, which is the
> > > > only ASPM setting tested before putting hardware to the market.
> > > 
> > > Unfortunately; I don't think you can jump to this conclusion.

I think using the BIOS default as a limit is problematic.  I think it
would be perfectly reasonable for a BIOS to (a) configure only devices
it needs for console and boot, leaving others at power-on defaults,
and (b) configure devices in the safest configuration possible on the
assumption that an OS can decide the runtime policy itself.

Obviously I'm not a BIOS writer (though I sure wish I could talk to
some!), so maybe these are bad assumptions.

> > > A big difference in the Windows world to Linux world is that OEMs ship
> > > with a factory Windows image that may set policies like this.  OEM
> > > "platform" drivers can set registry keys too.

I suppose this means that the OEM image contains drivers that aren't
in the Microsoft media, and those drivers may set constraints on ASPM
usage?

If you boot the Microsoft media that lacks those drivers, maybe it
doesn't bother to configure ASPM for those devices?  Linux currently
configures ASPM for everything at enumeration-time, so we do it even
if there's no driver.

> > I wonder if there's any particular modification should be improved for
> > this patch?
> 
> Knowing this information I personally think the original patch that started
> this thread makes a lot of sense.

I'm still opposed to using dev_is_removable() as a predicate because I
don't think it has any technical connection to ASPM configuration.

Bjorn
