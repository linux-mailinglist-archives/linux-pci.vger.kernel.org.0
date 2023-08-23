Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40C78570D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjHWLqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjHWLqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 07:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE8E6F;
        Wed, 23 Aug 2023 04:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02ECB61440;
        Wed, 23 Aug 2023 11:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFEAC433C8;
        Wed, 23 Aug 2023 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791181;
        bh=jTWkIBPlkZDuvv58mCc64rD2EEiyM2COyuLVATArL6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WM9EN99kxxWcAXwdC/R76C4d7qAZplzMxsNTsxj8FKt9/bSDZpiG9eFn/NXNXbCMW
         jWJeK5lBukC8T0JiymVJ0NilMUY7ki72aPWC/7UTvAE7YvM5U9ob3gFuF32v+RHoHs
         1NmDAxt8kUl5Gie1TlBXMlNVMntjtrls1GeEUww7CUGlJBTG3y25uTXv7WUxqjKJl5
         WLLz8sP3HFmpplO95/WgaFQOMVLiRxbi8tepxxaFu7UBzOEebfVmZJox6R+mGdz5Q0
         mnmTZLY3dh5asACvr9Zlk6u147MDPQDelF8nR/X+gLMdXQASt3qRfmaAqhsoITG/Yu
         z0tXJ7IqhIsXg==
Date:   Wed, 23 Aug 2023 06:46:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Message-ID: <20230823114619.GA414059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823050453.GA9103@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 07:04:53AM +0200, Lukas Wunner wrote:
> On Tue, Aug 22, 2023 at 07:02:43PM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 22, 2023 at 12:11:10PM +0200, Rafael J. Wysocki wrote:
> > > What we need to deal with here is basically non-compliant systems and
> > > so we have to catch the various forms of non-compliance.
> > 
> > Thanks for this, that helps.  If pci_bridge_d3_possible() is a list of
> > quirks for systems that are known to be broken (or at least not known
> > to work correctly and avoiding D3 is acceptable), then we should
> > document and use it that way.
> > 
> > The current documentation ("checks if it is possible to move to D3")
> > frames it as "does the bridge have the required features?" instead of
> > "do we know about something broken in this bridge or this platform?"
> > 
> > If something is broken, I would expect tests based on the device or
> > DMI check.  But several some are not obvious defects.  E.g.,
> > "bridge->is_hotplug_bridge && !pciehp_is_native(bridge)" -- what
> > defect are we finding there?  What does the spec require that isn't
> > happening?
> 
> This particular check doesn't pertain to a defect, but indeed
> follows from the spec:
> 
> If hotplug control wasn't granted to the OS, the OS shall not put
> the hotplug port in D3 behind firmware's back because the power state
> affects accessibility of devices downstream of the hotplug port.
> 
> Put another way, the firmware expects to have control of hotplug
> and hotplug may break if the OS fiddles with the power state of the
> hotplug port.
> 
> Here's a bugzilla where this caused issues:
> https://bugzilla.kernel.org/show_bug.cgi?id=53811
> 
> On the other hand Thunderbolt hotplug ports are required to runtime
> suspend to D3 in order to save power.  

Sounds like there may be a requirement in a Thunderbolt spec about
this, so maybe we could add that citation?  I guess this goes with the
"bridge->is_thunderbolt" check?

> On Macs they're always handled
> natively by the OS.  Hence the code comment.

And I guess this goes with the "System Management Mode" and
"Thunderbolt on non-Macs" comments?  A citation to the source behind
"OS shall not put the hotplug port in D3 behind firmware's back" would
be super helpful here.

> A somewhat longer explanation I gave in 2016:
> https://lore.kernel.org/all/20160617213209.GA1927@wunner.de/
> 
> Perhaps the code comment preceding that check can be rephrased to
> convey its meaning more clearly...

Thanks!  I think it would be worth trying to separate out the "normal"
things that correspond to the spec from the "quirk" things that work
around defects.  That's not material for *this* patch, though.

It's also a little weird that pci_bridge_d3_possible() itself looks
like it's invariant for the life of the system, but we call it several
times (pci_pm_init(), pci_bridge_d3_update(), pcie_portdrv_probe(),
etc).  I guess this is because we save the result in dev->bridge_d3,
but then pci_bridge_d3_update() updates dev->bridge_d3 based on other
things, so the original value is lost.  Maybe another bit or two could
avoid those extra calls.

Bjorn
