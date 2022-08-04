Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3430958A405
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 01:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiHDXzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 19:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHDXzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 19:55:51 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D85BE0C9
        for <linux-pci@vger.kernel.org>; Thu,  4 Aug 2022 16:55:49 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 274NpEqu007425;
        Thu, 4 Aug 2022 18:51:15 -0500
Message-ID: <e7d035519b2d921cc4f6cfa3b6f64b27fd11f078.camel@kernel.crashing.org>
Subject: Re: arm64 PCI resource allocation issue
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Fri, 05 Aug 2022 09:51:14 +1000
In-Reply-To: <YuuhOdV09R+K5ui/@lpieralisi>
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
         <YuuhOdV09R+K5ui/@lpieralisi>
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

On Thu, 2022-08-04 at 12:36 +0200, Lorenzo Pieralisi wrote:
> On Tue, Aug 02, 2022 at 02:07:00PM +1000, Benjamin Herrenschmidt wrote:
> 
> [...]
> 
> > The case back then was that there existed some (how many ? there was
> > one real example if I remember correctly) bogus firwmares that came out
> > of UEFI with too small windows. We could just quirk those ....
> 
> There is just one way to discover "how many" unfortunately, quirking
> those can be more problematic than it seems.

Yes it can be but I'm still keen to try, if anything to keep all
UEFI+ACPI platforms on the same basic mechanism.

> [...]
> 
> > The alternative here would be to use ad-hock kludges for such system
> > devices, to "register" the addresses early, and have some kind of hook
> > in the PCI code that keeps track of them as they get remapped.
> 
> That's what x86 does AFAICS (pcibios_save_fw_addr()), even though
> it is used in a different scope (ie revert to FW address if the
> resource allocation fails).

Right. Another kludge... It won't work much better than
IORESOURCE_PCI_FIXED the minute the device is below any amount of
bridges that have themselves be re-assigned. Worst, we might have moved
something else over to where the FW left that device.

It's ugly as heck :-) Oh well... I also really don't like how it
maintains that separate list, would be much nicer to have something
hanging off pci_dev.

../...

> > Opinions ?
> 
> You may also want to look into IORESOURCE_PCI_FIXED even though the
> last time I looked into I found some broken logic (basically the
> immutable/"fixed" BAR resources should obviously take into account the
> PCI tree hierarchy - upstream bridges, etc., which I don't think
> IORESOURCE_PCI_FIXED does - how it works remains a bit of
> a mystery for me).

It doesn't really work for the reasons you cited ... or rather it works
in limited cases. I did look into it as well ages ago, and unless
things changed, it was broken and not easily fixable. Our resource
allocation code is.... intricated.

That leaves us with 3 overall routes I can think of (we can figure out
the details next):

 1) We can try to detect early those devices (easy with SPCR, are there
more on aarch64 ? on x86 there is) and hammer them into place, flagging
them somewhat and forcing them (and all their parents) to keep their
resources.

Pros: It's rather easy to implement, we can "register" the addresses
early and have the PCI probe code match detected devices againt that
list & flag them (for example IORESOURCE_PCI_FIXES :-) and their
parents.

Cons: It will force entire bus hierarchies to be fixed, which might not
really help on firmwares that are known to setup sub-optimal apertures
(or even completely b0rked ones). But we don't know who those are
except maybe one or two if we dig down into the previous version of
that discussion from a couple of years ago.

 2) We can try to "keep track" of them as they move. Variant A.

We do it the way efifb does it and wrap that in something a bit nicer
as follow:

 - We add a helper to "record" a pci_dev/BAR#/offset combination and an
other one to do the lookup & fixup of a FW originated address.

 - We make efifb quirk use that instead of its existing global
"bar_resource".

 - We add a similar quirk to the ACPI code that parses SPCR and (maybe)
another one for earlycon (hint they may be the same device, some
deduplication would be useful).
 
 - We update 8250_pci (I assume pl01x are never PCI ?) to call this to
"fixup" addresses obtained from earlycon. That's the easy bit. SPRC is
trickier, we'd need to fixup addressed parsed from
add_preferred_console() .. I'm not 100% sure there's a case where such
an address would be added post-PCI-remap and we might incorrectly fix
it up.  I don't think so but ...

Pros: It should (hopefully) not be overly complicated and reasonably
self contained, low risk.

Cons: 

 - It's a bit more complicated than other solutions, though not
insanely

 - This doesn't solve the problem of a driver such as earlycon being
"live" accross the remapping (and thus means we'll probably still have
verybose PCI probing with earlycon dying horribly). This is already
partially broken since we temporarily disable decoding during probing
but that's a small window ... We can look at solving that separately by
adding on top of this registration mechanism: We *could* optionally
register in our above helper a pair of callbacks that the PCI code
would call for each registered "early device" before and after
remapping to "suspend access" and "fixup address". Those would be
ideally called around the remapping of the entire host bridge the
device is on.

3) Keeping track, Variant B

(note: the more I think about it, the more I prefer variant A but let's
see what others think)

We generalize pcibios_save_fw_addr() and for the sake of it, we move
that into pci_dev which simplifies everything and gets rid of that
separate list.

Then, things like efifb, 8250_pci etc... do a lookup in there for
addresses they obtain from screen_info, earlycon,
add_preferred_console.. and on match, perform the necessary fixup.
Assuming we are confident those addresses originate from before the PCI
remapping that is.

Pros: It *seems* even simpler than the above other options and maybe
even faster.

Cons: It's more resource intensive as we now backup original BARs for
everything under the sun. It also doesn't provide a great path to
address the case I mentioned earlier for dealing with "live" devices.

That's all I came up with ... Any better ideas and any preferences ? At
this point I'm reasonably keen on (2) (tracking variant A).

I'll be travelling this weekend and next week, so probably won't have
time to produce much code but this has been broken forever so I don't
see a huge emergency. So unless somebody beats me to it or strongly
objects, I'll start hacking at it in the next few weeks.

Cheers,
Ben.



