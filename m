Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7507A33CDE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 03:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFDBtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 21:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfFDBtt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 21:49:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE49263B6;
        Tue,  4 Jun 2019 01:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559612988;
        bh=ZFLaYphn424cz90ooZBwJiNuxs3UlGcvbszrva1KAHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEL1fVyEl5TIg9HXRLdNCn9lCO4e/kDQvwNRyON7CVcC+j+V5qVZRvRn2JFyXMtCP
         YlN+SPaL09Q44nMRu/oyHqByOvaVAU+rLHmLTN6jfWb1LAuLTaSVEgAem/KkcugYbR
         lUaLhqbRoPIJGpZ4LNHEbSvu5bA+7RgGaJSDmj2A=
Date:   Mon, 3 Jun 2019 20:49:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [RFC] ARM64 PCI resource survey issue(s)
Message-ID: <20190604014945.GE189360@google.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 09:41:16AM +1000, Benjamin Herrenschmidt wrote:
> Hi Folks !
> 
> I'd like to revive the discussion around Ard's old patch:
> 
> https://patchwork.kernel.org/patch/9675707/
> 
> We (Amazon) need that sorted one way or another ASAP since we have
> setups coming where we must not let Linux change the FW assignments
> under some host bridges.
> 
> In fact it's a reasonable thing to require for other reasons. The EFI
> framebuffer is an example, there can be others where FW/ACPI/EL3 etc...
> might have assumptions based on where some system devices were located
> by the boot FW and will break if we move them (such things are common
> on x86 and powerpc).

I would like to handle these individual devices that cannot be moved
the same way we handle legacy (IDE, VGA) devices, i.e., mark the BARs
with IORESOURCE_IO_FIXED.

This could be done with either Enhanced Allocation capabilities or via
ACPI _DSM function #5.  My preference would be to do this at the
lowest possible level of the PCI hierarchy.  IIRC, EA can do it for
individual BARs, and _DSM can be supplied for any individual device
(or bridge, but I'd prefer to do it on the device because that gives
us more information about exactly what needs to be preserved).

Of course, _DSM *can* be higher, e.g., at the host bridge, but then we
lose the information about what specifically must be immutable, and
that means the OS cannot ever move *anything*, even if it becomes
capable of moving things around to accommodate hot-added devices.

I'm not aware of anything in DT that would correspond to DSM #5, but
it could be added.

> Taking a step back I think (and I suspect we generally agree based on
> followup discussions I've seen) that the "right" thing to do is to have
> our default behaviour be:
> 
>    - Claim what the FW established if it's not obviously broken
> 
>    - Call pci_assign_unassigned_resources() to assign what the FW
> didn't assign
> 
> Which is more or less what powerpc and x86 do today, but using a
> different mechanism than what's in pci_bus_claim_resources() (they are
> similar to each other, I wrote the current powerpc one loosely based on
> the x86 one at the time). That leads to a side question (which we
> should probably discuss in a separate thread) of whether we want to
> consolidate all that.
> 
> That said, we also know this is going to break *some* existing
> platforms that have known broken FW assignment. The question is then
> can we sufficiently detect the breakage and re-assign in those cases
> (like x86 does fairly successfully in a number of cases), or do we need
> to add some board/platform quirks to force the full re-assigment on
> known broken platforms ?

I don't know how to parse this.  What does "known broken FW
assignment" mean?  Are you saying the assignment from FW *looks* valid
(all BARs contain valid addresses and are inside windows of upstream
bridges), but it doesn't work for some reason?  If that's the case,
how would full reassignment by Linux fix anything?  Linux has no idea
how to change a valid-looking assignment to make an actually-valid
assignment.

> Even if all arm64 platforms are found to be broken today, I would still
> like to have our default be to use the FW setup, if anything as an
> incentive for newer platforms to get it right. At the very least on
> ACPI.

I agree that Linux should not change anything unless it needs to.  Of
course, reasons it "needs to" might include allocating more space for
hot-added devices, either because Linux discovered an open slot or
because a user requested more space with a kernel parameter.

> We can use DSM#5 when it exists to force one way or another (ideally on
> a per bus basis but that's harder, so let's start with host bridges
> maybe ?)

I'd prefer starting with endpoints, but I think it will all work out
the same in the end.  When enumerating X, we look for a local _DSM #5
and mark X's BARs/windows accordingly and set a pdev->fixed_resources
bit.  If there's no local _DSM #5, act based on X's parent's
fixed_resources bit.

Bjorn
