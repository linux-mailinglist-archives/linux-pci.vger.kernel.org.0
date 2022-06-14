Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE254B46E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiFNPRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356491AbiFNPRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 11:17:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394341FB9;
        Tue, 14 Jun 2022 08:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC8DB81987;
        Tue, 14 Jun 2022 15:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78FC3411B;
        Tue, 14 Jun 2022 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655219830;
        bh=tOKMnDVcGbmkiYtHnRO9aHSEjSOYMVD7OrdfeipetM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k8bBMldp0GKxt9sZnxnQktZkrgQoZ2BYG51SRa4ewnZymD/2pKa250sieVYYABlDl
         1/T0LrIQ9jlqMwyHnG7K8ZoQOfgmRywMyvaRg/rT1QtpUxJEKLVWb4le0Jq1jrc0LY
         JsBSbRk9B8BIx3YFzrDSPZOmBoKZg5OFYXkZQBU4ufUY5zp+/LZZ5YhibRMszgg0/R
         QBaPH8x7/VE0HwpArPRH1Hr+yTYW1jnEWFarQHOMJTK70raqgRv0pmyFtciDj4EChd
         vQYhtFxu0+lBwwpLhbbaUX+gZJTm23v+6GSF84u/hD7eGAPSgyVmaMTJSCuDuDXTdQ
         Jhcj+WCOYksEw==
Date:   Tue, 14 Jun 2022 10:17:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <20220614151708.GA756100@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1753ef-0bfb-f937-cab1-ad960bdf6772@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 10:15:29AM +0200, Hans de Goede wrote:
> On 6/14/22 01:15, Bjorn Helgaas wrote:
> > On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
> >> Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
> >> instead of clipping from arch_remove_reservations(), has a number of
> >> unforseen consequences.
> >>
> >> If there is an e820 reservation in the middle of a bridge window, then
> >> the smallest of the 2 remaining parts of the window will be also clipped
> >> off. Where as the previous code would clip regions requested by devices,
> >> rather then the entire window, leaving regions which were either entirely
> >> above or below a reservation in the middle of the window alone.
> >>
> >> E.g. on the Steam Deck this leads to this log message:
> >>
> >> acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
> >>
> >> which then gets followed by these log messages:
> >>
> >> pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
> >> pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
> >>
> >> and many more of these. Ultimately this leads to the Steam Deck
> >> no longer booting properly, so revert the change.
> >>
> >> Note this is not a clean revert, this revert keeps the later change
> >> to make the clipping dependent on a new pci_use_e820 bool, moving
> >> the checking of this bool to arch_remove_reservations().
> > 
> > 4c5e242d3e93 was definitely a mistake (my fault).  My intent was to
> > mainly to improve logging of the clipping, but I didn't implement it
> > well.
> > 
> > That said, I'd like to understand the connection between the messages
> > you mention and the failure.  There are four bridges whose MMIO
> > windows were in the [mem 0x80000000-0x9fffffff] area that we clipped
> > out.  The log shows that we moved all those windows and the devices in
> > them to the [mem 0xa0100000-0xf7ffffff] area that remained after
> > clipping.
> > 
> > So I think this *should* have worked even though we moved things
> > around unnecessarily.  What am I missing?
> 
> I don't know? My guess is that maybe the ACPI table do MMIO accesses
> somewhere to hardcoded addresses and moving things breaks the ACPI
> tables.

This would be a firmware defect, IMHO.  There is a mechanism (_DSM for
preserving PCI Boot Configurations) for the firmware to tell us about
things that can't be moved.

> > The E820 map reports [mem 0xa0000000-0xa00fffff] in the middle of the
> > _CRS, and we currently trim that out.  We think this is a firmware
> > defect, so it's likely to break in 2023 if we stop clipping by
> > default.  I'm concerned that there may be other things in _CRS that we
> > need to avoid, but firmware isn't telling us about them.
> > 
> > Or there's some dependency in the devices that we moved on their
> > original addresses, e.g., firmware on the device latched the address
> > and didn't notice the reassignment.
> 
> Right this is the most likely cause I believe.

This would be another defect, in the device this time.  If we can
identify the device, possibly we could quirk around it.

Either one will be back to bite us in the future if we support
rebalancing resources to make room for hot-added devices.  I *think*
Windows already supports this kind of rebalancing.  Anyway, this is
why we need to dig a little deeper to figure out exactly what's going
wrong here.

Bjorn
