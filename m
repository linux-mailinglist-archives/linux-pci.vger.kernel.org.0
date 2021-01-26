Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5F305B52
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhA0M0y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 07:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S314044AbhAZWzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5DDE2065D;
        Tue, 26 Jan 2021 22:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611701699;
        bh=7/yqTNqWIqQ7XCIx1WSLqU/snxBtDCQ23qUfG8HlO5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxfU/IRuv3TUSul3I/evOCCOqIPlij7Fp31pMB/khCbDtR9z8LV26+bh8BQ6A4D5H
         Uq6Ao6JNAEzjMpilMG6xm7GxiAKvj/FOBV4T5u++joQDdfLKG1YcevdvOPMchYnQL5
         dR64tGX8kKpzZdmaGAYt7JHF65SsvAsX4aF6OOzy2vG/uyXamFVONJlj7Iaz6Adbu/
         LEY2tk3cW4TpsdZlqoPVTZiSzGNkH2fDVm+iqF0C/113G8xoke/nSmDYfRYddMEIAw
         3l6N9G7bZ6O7HocoxzYRRF0iUibB5D5RzXhmA+I1JFNpag/Q5v+LNgqQRm4egUMNf/
         yrOTMJv1AnUmg==
Date:   Tue, 26 Jan 2021 22:54:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Masters <jcm@jonmasters.org>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210126225454.GB30941@willie-the-truck>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 10:46:04AM -0600, Jeremy Linton wrote:
> On 1/22/21 1:48 PM, Will Deacon wrote:
> > This isn't like the usual fragmentation problems, where firmware swoops in
> > to save the day; CPU onlining, spectre mitigations, early entropy etc. All
> > of these problems exist because there isn't a standard method to implement
> > them outside of firmware, and so adding a layer of abstraction there makes
> > sense.
> 
> There are a lot of parallels with PSCI here because there were existing
> standards for cpu online.

I don't recall anything that I would consider a standard at the time.

> > But PCIe is already a standard!
> 
> And it says that ECAM is optional, particularly if there are
> firmware/platform standardized ways of accessing the config space.

Nice loophole; I haven't checked.

> > We shouldn't paper over hardware designers' inability to follow a ~20 year
> > old standard by hiding it behind another standard that is hot off the press.
> > Seriously.
> 
> No disagreement, but its been more than half a decade and there are some
> high (millions!) volume parts, that still don't have kernel support.

Ok.

> > There is not a scrap of evidence to suggest that the firmware
> > implementations will be any better, but they will certainly be harder to
> > debug and maintain.  I have significant reservations about Arm's interest in
> > maintaining the spec as both more errata appear and the PCIe spec evolves
> > (after all, this is outside of SBSA, no?). The whole thing stinks of "if all
> > you have is a hammer, then everything looks like a nail". But this isn't the
> > sort of problem that is solved with yet another spec -- instead, how about
> > encouraging vendors to read the specs that already exist?
> 
> PSCI, isn't a good example of a firmware interface that works?

Not sure what you're getting at here.

> > > The SMC is an olive branch and just to make sure it is crystal clear
> > > there won't be room for adding quirks if the implementation turns out
> > > to be broken, if a line in the sand is what we want here it is.
> > 
> > I appreciate the sentiment, but you're not solving the problem here. You're
> > moving it somewhere else. Somewhere where you don't have to deal with it
> > (and I honestly can't blame you for that), but also somewhere where you
> > _can't_ necessarily deal with it. The inevitable outcome is an endless
> > succession of crappy, non-compliant machines which only appear to operate
> > correctly with particularly kernel/firmware combinations. Imagine trying to
> > use something like that?
> > 
> > The approach championed here actively discourages vendors from building
> > spec-compliant hardware and reduces our ability to work around problems
> > on such hardware at the same time.
> > 
> > So I won't be applying these patches, sorry.
> 
> Does that mean its open season for ECAM quirks, and we can expect them to
> start being merged now?

That's not for me to say.

Will
