Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097FD58762F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 06:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiHBENZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 00:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiHBENY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 00:13:24 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB1A519000
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 21:13:22 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 272470J0003344;
        Mon, 1 Aug 2022 23:07:01 -0500
Message-ID: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
Subject: arm64 PCI resource allocation issue
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Tue, 02 Aug 2022 14:07:00 +1000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks !

It's been a while ... (please extend the CC list as needed)

I'd like to re-open an ancient issue because it's still biting us
(AWS).

A few years back, I updated the PCIe resource allocation code to be a
bit more in line with what other architectures do. That said, once
thing we couldn't agree on was to do like x86 and default to preserving
the firmware provided resources by default.

On x86, the kernel "allocates" (claims) the resources (unless it finds
something obviously wrong), then allocates anything left unallocated.

On arm64, we use to just re-allocate everything. I changed this to
first use some more common code for doing all that, but also to have
the option to claim existing resources if _DSM tells us to preserve
them for a given host brigde.

I still think this is the wrong way to go and that we should preserve
the UEFI resources by default unless told not to :-)

The case back then was that there existed some (how many ? there was
one real example if I remember correctly) bogus firwmares that came out
of UEFI with too small windows. We could just quirk those ....

The reason I'm bringing this back is that re-allocating resources for
system devices cause problems.

The most obvious one today that is affecting EC2 instances is that the
UART address specified in SPCR is no longer valid, causing issues
ranging from the console not working to MMIO to what becomes "random
addresses". Typically today this is "worked around" by using
console=ttyS0 to force selection of the first detected PCI UART,
because the match against SPCR is based on address and it won't match,
but there's always the underlying risk that things like earlycon starts
poking at now-incorrect addresses until 8250 takes over.

This is the most obvious problem. Any other "system" device that
happens to be PCIe based (anything detected early, via device-tree,
ACPI or otherwise) is at risk of a similar issue. On x86 that could be
catastrophic because near everything looks like a PCI device, on arm64
we seem to have been getting away with it a bit more easily ... so far.

The alternative here would be to use ad-hock kludges for such system
devices, to "register" the addresses early, and have some kind of hook
in the PCI code that keeps track of them as they get remapped.

If we want this, I would propose (happy to provide the implementation
but let's discuss the design first) something along the line of a
generic mechanism to "register" such a system device, which would add
it to a list. That list would be scanned on PCI device discovery for
BAR address matches, and the pci_dev/BAR# added to the entry (that or
put a pointer to the entry into pci_dev for speed/efficiency).

The difficulty is how is that update propagated:

This is of course fiddly. For example, the serial info is passed via
two different ways, one being earlycon (and probably the easiest to
track), the other one an ASCII string passed to
add_preferred_console(), which would require more significant hackery
(the code dealing with console mathing is a gothic horror).

Also if such a system device is in continuous use during the boot
process (UART ?) it needs to be "updated" as soon as possible after the
BARs (and parent BARs) have been also updated (in fact this is
generally why PCI debug dies horribly when using PCI based UARTs).
Maybe an (optional) callback that earlycon can add ?

Additionally, this would only work if such system devices are
"registered" before they get remapped... 

Another approach would be to have pci_dev keep a copy of the original
resources (at least for the primary BARs) and provide an accessor for
use by things like earlycon or 8250 to compare against these, though
that doesn't solve the problem of promptly "updating" drivers for
system devices.

Opinions ?

Cheers,
Ben.


