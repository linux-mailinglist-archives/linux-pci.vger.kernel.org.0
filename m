Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADF7B70D9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbjJCSb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbjJCSb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 14:31:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B38183;
        Tue,  3 Oct 2023 11:31:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BF1C433C7;
        Tue,  3 Oct 2023 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696357885;
        bh=drJeUPJlsiP0kVlxBw6iKTksA5yzpZM5RKmyPah7smA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s0cwOHLWg7wLWbvoWInM6J60cDoeAvlmxZB18zEm0GijK+iQcoP2p0HnX3ZMsqLxI
         52p7Lti6CaFCnbZIzZ0dNJIasqFJQFSj+CBn1dDz/0i/q0/qmYcvrTQIWo2mRrfR8j
         /TiqdF17z0+ep3w/kB/jYWdCUzTqIYvc5NIFjrcvZ4H/6nyn1m9dC+UpZt5tp0kvTQ
         hpcVy4i35+tohPw+s1KyqCDnO3xjGPQuMcF9FhkbaxNZCX0L7I9p0yMV7o/VKOoXgA
         +Jwg2x5JCoy5v18oqQ/uGaqm5hUIrfrvDbbDo+UJWeyhdpoSO5gRRl2dgTGmCscoBn
         ZbAALLIQlEjIA==
Date:   Tue, 3 Oct 2023 13:31:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003183123.GA680474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7c5ecb-12be-4b2e-8f36-7d65dc171482@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 01:06:48PM -0500, Mario Limonciello wrote:
> On 10/3/2023 12:24, Bjorn Helgaas wrote:
> > On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
> > > Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> > > suspend.  This occurs because on some AMD platforms, even though the Root
> > > Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> > > messages and generate wakeup interrupts from those states when amd-pmc has
> > > put the platform in a hardware sleep state.
> > ...

> > Two questions:
> > 
> >    - PME also doesn't work in D3hot, right?
> 
> Right.
> 
> IMO pci_d3cold_*() is poorly named.
> It's going to prevent D3 on the bridge.

I agree, that name is super irritating.  I don't even know how to
figure out or verify that pci_d3cold_disable() also disables D3hot.

> >    - Is it OK to use D3hot and D3cold if we don't have a wakeup device
> >      below the Root Port?  I assume that scenario is possible?
> 
> Yes; it's "fine to do that" if there is no wakeup device below the
> root port.
> 
> If a user intentionally turns off power/wakeup for the child devices
> (which as said before was USB4 and XHCI PCIe devices) then wakeup
> won't be set.
> 
> So in this case as the quirk is implemented I expect the root port
> will be left in D0 even if a user intentionally turns off
> power/wakeup for the USB4 and XHCI devices.

Even if users don't intentionally turn off wakeup, there are devices
like mass storage and NICs without wake-on-LAN that don't require
wakeup.

I assume that if there's no downstream device that needs wakeup, this
quirk means we will keep the Root Port in D0 even though we could
safely put it in D3hot or D3cold.

That's one thing I liked about the v20 iteration -- instead of
pci_d3cold_disable(), we changed dev->pme_support, which should mean
that we only avoid D3hot/D3cold if we need PMEs while in those states,
so I assumed that we *could* use D3 when we don't need the wakeups.

Bjorn
