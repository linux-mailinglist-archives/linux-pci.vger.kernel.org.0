Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB35594ED0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 04:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiHPCos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiHPCog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 22:44:36 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8EB22A607C
        for <linux-pci@vger.kernel.org>; Mon, 15 Aug 2022 16:08:49 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27FN28MK014575;
        Mon, 15 Aug 2022 18:02:09 -0500
Message-ID: <1c83e5b3894a7e5ddb0024e5aa6d29e9f872812d.camel@kernel.crashing.org>
Subject: Re: arm64 PCI resource allocation issue
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Tue, 16 Aug 2022 09:02:08 +1000
In-Reply-To: <e7d035519b2d921cc4f6cfa3b6f64b27fd11f078.camel@kernel.crashing.org>
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
         <YuuhOdV09R+K5ui/@lpieralisi>
         <e7d035519b2d921cc4f6cfa3b6f64b27fd11f078.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Still hoping for opinions on this ... I'll probably have time to hack
on it next week...

On Fri, 2022-08-05 at 09:51 +1000, Benjamin Herrenschmidt wrote:

> That leaves us with 3 overall routes I can think of (we can figure out
> the details next):
> 
>  1) We can try to detect early those devices (easy with SPCR, are
> there more on aarch64 ? on x86 there is) and hammer them into place,
> flagging them somewhat and forcing them (and all their parents) to keep their
> resources.
> 
> Pros: It's rather easy to implement, we can "register" the addresses
> early and have the PCI probe code match detected devices againt that
> list & flag them (for example IORESOURCE_PCI_FIXES :-) and their
> parents.
> 
> Cons: It will force entire bus hierarchies to be fixed, which might
> not really help on firmwares that are known to setup sub-optimal
> apertures (or even completely b0rked ones). But we don't know who those are
> except maybe one or two if we dig down into the previous version of
> that discussion from a couple of years ago.
> 
>  2) We can try to "keep track" of them as they move. Variant A.
> 
> We do it the way efifb does it and wrap that in something a bit nicer
> as follow:
> 
>  - We add a helper to "record" a pci_dev/BAR#/offset combination and
> an
> other one to do the lookup & fixup of a FW originated address.
> 
>  - We make efifb quirk use that instead of its existing global
> "bar_resource".
> 
>  - We add a similar quirk to the ACPI code that parses SPCR and
> (maybe) another one for earlycon (hint they may be the same device, some
> deduplication would be useful).
>  
>  - We update 8250_pci (I assume pl01x are never PCI ?) to call this
> to "fixup" addresses obtained from earlycon. That's the easy bit. SPRC
> is trickier, we'd need to fixup addressed parsed from
> add_preferred_console() .. I'm not 100% sure there's a case where
> such an address would be added post-PCI-remap and we might incorrectly fix
> it up.  I don't think so but ...
> 
> Pros: It should (hopefully) not be overly complicated and reasonably
> self contained, low risk.
> 
> Cons: 
> 
>  - It's a bit more complicated than other solutions, though not
> insanely
> 
>  - This doesn't solve the problem of a driver such as earlycon being
> "live" accross the remapping (and thus means we'll probably still
> have verbose PCI probing with earlycon dying horribly). This is already
> partially broken since we temporarily disable decoding during probing
> but that's a small window ... We can look at solving that separately
> by adding on top of this registration mechanism: We *could* optionally
> register in our above helper a pair of callbacks that the PCI code
> would call for each registered "early device" before and after
> remapping to "suspend access" and "fixup address". Those would be
> ideally called around the remapping of the entire host bridge the
> device is on.
> 
> 3) Keeping track, Variant B
> 
> (note: the more I think about it, the more I prefer variant A but
> let's see what others think)
> 
> We generalize pcibios_save_fw_addr() and for the sake of it, we move
> that into pci_dev which simplifies everything and gets rid of that
> separate list.
> 
> Then, things like efifb, 8250_pci etc... do a lookup in there for
> addresses they obtain from screen_info, earlycon,
> add_preferred_console.. and on match, perform the necessary fixup.
> Assuming we are confident those addresses originate from before the
> PCI remapping that is.
> 
> Pros: It *seems* even simpler than the above other options and maybe
> even faster.
> 
> Cons: It's more resource intensive as we now backup original BARs for
> everything under the sun. It also doesn't provide a great path to
> address the case I mentioned earlier for dealing with "live" devices.
> 
> That's all I came up with ... Any better ideas and any preferences ?
> At this point I'm reasonably keen on (2) (tracking variant A).


