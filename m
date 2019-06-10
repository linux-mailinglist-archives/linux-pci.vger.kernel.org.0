Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB263B2C4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfFJKLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 06:11:33 -0400
Received: from foss.arm.com ([217.140.110.172]:39608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388489AbfFJKLd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 06:11:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762CE344;
        Mon, 10 Jun 2019 03:11:32 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A7A3F557;
        Mon, 10 Jun 2019 03:13:13 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:11:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [RFC] ARM64 PCI resource survey issue(s)
Message-ID: <20190610101129.GC25976@redmoon>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com>
 <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com>
 <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 05, 2019 at 06:41:16AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-04 at 07:49 -0500, Bjorn Helgaas wrote:
> > > Yes... I am not personally aware of such a case but I was led to
> > > believe based on prior conversations that such setups do exist,
> > > especially in the non-ACPI ARM64 world. Which is why I would suggest
> > > initially changing the default only on ACPI, at least until we have a
> > > bit better visibility.
> > 
> > If a resource assignment that is valid in terms of all the PCI rules
> > (BARs are valid, BARs are inside upstream bridge windows, etc) doesn't
> > work, we would need more information in order to fix anything.  We'd
> > need to know exactly *what* doesn't work and *why* so we can avoid it.
> > The current blanket statement of "reassign everything and hope it
> > works better" is useless.
> 
> I agree and I assume the problem stems from BIOSes creating either
> invalid or incomplete assignments but as I said, I don't know for sure
> as our platforms dont have that problem.

The first thing that I would like to agree on is what mechanism the
kernel has to ensure a BAR resource is not changed by the
PCI resource assignment mechanism.

(1) IORESOURCE_PCI_FIXED flag: I have *very* strong feelings that this
    flag works because x86 kernel code claims all resources on probe
    (which effectively makes them immutable). It does not work for
    PCI bridges apertures and I am not sure it works for arches (eg
    ARM64) that reassign everything, even for *devices*
(2) Claiming resources: this basically means assigning a parent to
    a resource.

Kernel PCI resource assignment code is full of code I do not understand
and that in my opinion works because of (1). I *tried*, while posting
ACPI PCI code for ARM64, to do what x86 does:

- Claim all resources
- Reassign the resources that could not be claimed

This led to:

a) Spurious dmesg logs (Eg Resources that could not be claimed)
b) If FW set-up bridge windows, it may lead to reassignment failures
   if the bridge windows were sized *wrongly* but the kernel still
   manage to claim them (because they fit in the parent window).

Hence, we reassign everything on ARM64 on ACPI (except for bus numbers
and that was, indeed, a mistake).

In short, this is a mess and one that I do not have much leeway to fix
because the PCI resource assignment code is as it is owing to legacy
that we can't touch unless we want to fix regressions for the next
year.

And then there is _DSM #5.

The problem we have is that there is *no* specific way to tell what's
right or wrong and that's what _DSM #5 is supposed to fix. To implement
it to the letter it will take lots of work.

First thing is to answer and agree (1) vs (2) above, aka define what
an immutable resource is from a kernel point of view, one with a
parent != NULL OR one with IORESOURCE_PCI_FIXED flag.

Lorenzo
