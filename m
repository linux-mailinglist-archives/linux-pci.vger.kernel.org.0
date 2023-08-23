Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AB784FC6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHWFFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHWFFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 01:05:02 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E07E4A;
        Tue, 22 Aug 2023 22:04:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7A49B30000D25;
        Wed, 23 Aug 2023 07:04:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6C9A6316BE2; Wed, 23 Aug 2023 07:04:53 +0200 (CEST)
Date:   Wed, 23 Aug 2023 07:04:53 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20230823050453.GA9103@wunner.de>
References: <CAJZ5v0hU3mWFaaujWozHnPw8+A=bf2OwzcendXjpP35wCv_B6g@mail.gmail.com>
 <20230823000243.GA391238@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823000243.GA391238@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 07:02:43PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 22, 2023 at 12:11:10PM +0200, Rafael J. Wysocki wrote:
> > What we need to deal with here is basically non-compliant systems and
> > so we have to catch the various forms of non-compliance.
> 
> Thanks for this, that helps.  If pci_bridge_d3_possible() is a list of
> quirks for systems that are known to be broken (or at least not known
> to work correctly and avoiding D3 is acceptable), then we should
> document and use it that way.
> 
> The current documentation ("checks if it is possible to move to D3")
> frames it as "does the bridge have the required features?" instead of
> "do we know about something broken in this bridge or this platform?"
> 
> If something is broken, I would expect tests based on the device or
> DMI check.  But several some are not obvious defects.  E.g.,
> "bridge->is_hotplug_bridge && !pciehp_is_native(bridge)" -- what
> defect are we finding there?  What does the spec require that isn't
> happening?

This particular check doesn't pertain to a defect, but indeed
follows from the spec:

If hotplug control wasn't granted to the OS, the OS shall not put
the hotplug port in D3 behind firmware's back because the power state
affects accessibility of devices downstream of the hotplug port.

Put another way, the firmware expects to have control of hotplug
and hotplug may break if the OS fiddles with the power state of the
hotplug port.

Here's a bugzilla where this caused issues:
https://bugzilla.kernel.org/show_bug.cgi?id=53811

On the other hand Thunderbolt hotplug ports are required to runtime
suspend to D3 in order to save power.  On Macs they're always handled
natively by the OS.  Hence the code comment.

A somewhat longer explanation I gave in 2016:
https://lore.kernel.org/all/20160617213209.GA1927@wunner.de/

Perhaps the code comment preceding that check can be rephrased to
convey its meaning more clearly...

Thanks,

Lukas
