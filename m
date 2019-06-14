Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58746459B4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFNJ5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 05:57:49 -0400
Received: from foss.arm.com ([217.140.110.172]:58416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJ5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 05:57:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 507BC2B;
        Fri, 14 Jun 2019 02:57:48 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E46C3F718;
        Fri, 14 Jun 2019 02:59:31 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:57:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
 <20190613190248.GH13533@google.com>
 <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
 <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
 <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 06:36:32PM +1000, Benjamin Herrenschmidt wrote:

[...]

> The biggest issue for me right now is that the spec says pretty much at
> _DSM #5 = 0 is equivalent to _DSM #5 absent, and Bjorn seems keen on
> having it this way, but for arm64, we specifically want to distinguish
> those 2 cases.
> 
> We want to honor _DSM #5 = 0, and at least initially, leave the rest
> alone.
> 
> Now, we *also* want to look at switching the rest to the "normal" (for
> ACPI platforms at least) mechanism of using what FW setup and fixing up
> if necessary, but that's not what the code does today, we know just
> switching to pci_bus_claim_resources() will break some platforms, and
> we need more testing and possibly quirks to get there, so it's material
> for a separate patch.
> 
> But in the meantime, I need to differenciate.
> 
> Also using "probe_only" for _DSM #5 = 0 isn't a good idea, at least as
> implemented today in the rest of the kernel, probe_only also means we
> shouldn't assign what was left unassigned. However _DSM #5 allows this.

I am not sure about this. PCI_PROBE_ONLY cannot stop an OS from
reassigning BARs that are clearly misconfigured, it does not make
any sense. It can't stop an OS from writing those BARs anyway,
since they must be sized, why firmware would prevent an OS from
reassigning BARs that are programmed with values that can be
deemed 100% bogus ? Or put it differently, why must an OS preserve
those values willy-nilly ?

For me, PCI_PROBE_ONLY and _DSM == 0 on a host bridge must be considered
equivalent.

I agree with Bjorn on his reading of _DSM #5 and I think that
the original patch that claims on _DSM #5 == 0 is a good
starting point. I would like to make it a default even without
_DSM #5 == 0 so that claim and reassign on claim failure works
irrespective of _DSM #5, it is now or never, I think we can give
it a shot, with an incremental patch.

Lorenzo

> So we'll need to find some more subtle way to convey these.
> 
> Bjorn: At this point, because of all the above, I'm keen on going back
> to my original patch (slightly modified Ard's patch), possibly
> rewording a thing or two and addressing Lorenzo comment.
> 
> We can look at a better and more generic implementation of _DSM #5
> including for child nodes after I have consolidated more of the
> resource management code.
> 
> Looking at the spec (and followup discussions for specs updates), I'm
> quite keen on treating _DSM #5 = 1 as "wipe out the resource for that
> endpoint/bridge and realloc something better. There are reasons for
> that, but we can probably discuss that later.
> 
> Cheers,
> Ben.
> 
> 
