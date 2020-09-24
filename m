Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB3276F3E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIXLDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:03:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37266 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXLDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 07:03:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id a3so3234671oib.4;
        Thu, 24 Sep 2020 04:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pn+i27Dx8fEtrGXxMazmn/X4tGbmkIv7rNYd8W3GRss=;
        b=ZQksqPbsOH5r5tthy8DtuUBuyGjBlwdntxObW9ZoDTW5IyrOf1lLyF65tMQOCiwo++
         dE8CJeRrH2e3RfXn9kMAi6v4s/cKBGaSj0mh01+LsWY9zwxtxmJwr+34LbTVJQtWw5pj
         2Lx0ht1UsRnSUw1cfUh6dXk4DOm4TyTtW7PtSXXT3wBlMAulMU48NaVocr6MYSyi2c76
         nx0J7UzFPk96FmxvZ336w0jZA0Kw89C1wGT5R2h6+9ufy4HwF3jFsNpuGO7GATRU4Bty
         8bTLRctseXcDj2XdHP8wC93TWb7/+QZqnD1YJYQBCZt6XcH7xdhswuBQsC0g4+J99qB4
         57+Q==
X-Gm-Message-State: AOAM533jbZW/VelROv/obcar38pD3AoIbOK/5KBwNylZfQ0kZPsDaDq/
        9m6H1638WVUUfl2CW356Ys5sIvqokDeHEBZN2hI=
X-Google-Smtp-Source: ABdhPJzDlpEJUA+Oq7l4adHVs9utovmT1K6AS39uuXbGtk7ZnfPxF0dnzHWkg5WoiVh0kzqj9RfrHNDZVceiVU+YuOc=
X-Received: by 2002:aca:df84:: with SMTP id w126mr2207061oig.103.1600945428210;
 Thu, 24 Sep 2020 04:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200818142430.1156547-1-Jonathan.Cameron@huawei.com>
 <20200903133318.000017f5@Huawei.com> <20200918131427.0000080f@Huawei.com>
In-Reply-To: <20200918131427.0000080f@Huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Sep 2020 13:03:37 +0200
Message-ID: <CAJZ5v0h_X-zhTJ-9d9cTLTe6yaneqLV7FsLv90NA5UL8eg1ovw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ACPI: Only create NUMA nodes from entries in SRAT
 or SRAT emulation.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        martin@geanix.com, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 2:16 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 3 Sep 2020 13:33:18 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 18 Aug 2020 22:24:24 +0800
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >
> > > This is a trivial rebase and resend of V2 now the merge window has closed.
> > >
> > > Here, I will use the term Proximity Domains for the ACPI description and
> > > NUMA Nodes for the in kernel representation.
> > >
> > > ACPI 6.3 included a clarification that only Static Resource Allocation
> > > Structures in SRAT may define the existence of proximity domains
> > > (sec 5.2.16). This clarification closed a possible interpretation that
> > > other parts of ACPI (e.g. DSDT _PXM, NFIT etc) could define new proximity
> > > domains that were not also mentioned in SRAT structures.
> > >
> > > In practice the kernel has never allowed this alternative interpretation as
> > > such nodes are only partially initialized. This is architecture specific
> > > but to take an example, on x86 alloc_node_data has not been called.
> > > Any use of them for node specific allocation, will result in a crash as the
> > > infrastructure to fallback to a node with memory is not setup.
> > >
> > > We ran into a problem when enabling _PXM handling for PCI devices and found
> > > there were boards out there advertising devices in proximity domains that
> > > didn't exist [2].
> > >
> > > The fix suggested in this series is to replace instances that should not
> > > 'create' new nodes with pxm_to_node.  This function needs a some additional
> > > hardening against invalid inputs to make sure it is safe for use in these
> > > new callers.
> > >
> > > Patch 1 Hardens pxm_to_node() against numa_off, and pxm entry being too large.
> > >
> > > Patch 2-4 change the various callers not related to SRAT entries so that they
> > > set this parameter to false, so do not attempt to initialize a new NUMA node
> > > if the relevant one does not already exist.
> > >
> > > Patch 5 is a function rename to reflect change in functionality of
> > > acpi_map_pxm_to_online_node() as it no longer creates a new map, but just does a
> > > lookup of existing maps.
> > >
> > > Patch 6 covers the one place we do not allow the full flexibility defined
> > > in the ACPI spec.  For SRAT GIC Interrupt Translation Service (ITS) Affinity
> > > Structures, on ARM64, the driver currently makes an additional pass of SRAT
> > > later in the boot than the one used to identify NUMA domains.
> > > Note, this currently means that an ITS placed in a proximity domain that is
> > > not defined by another SRAT structure will result in the a crash.
> > >
> > > To avoid this crash with minimal changes we do not create new NUMA nodes based
> > > on this particular entry type.  Any current platform trying to do this will not
> > > boot, so this is an improvement, if perhaps not a perfect solution.
> > >
> > > [1] Note in ACPI Specification 6.3 5.2.16 System Resource Affinity Table (SRAT)
> > > [2] https://patchwork.kernel.org/patch/10597777/
> >
> > Looking for input from ARM (Lorenzo?), X86(not sure) and ACPI(Rafael?) people
> > on this set. As it also touches NFIT handling perhaps someone who focuses on
> > that as well. Please feel free to CC additional people who might be interested.
> >
> > I'm fairly confident that it should be uncontroversial (famous last words)
> > and it closes down a problem that lead to issues with seemingly obvious
> > changes in the past. (The whole PCI _PXM issue on some threadripper platforms).
> >
> > Thanks to Bjorn, Hanjun and Barry for feedback on earlier revisions.
> >
>
> Hi All,
>
> Still after reviews on this set. If anyone one would like me to resend please
> let me know.  Also any corrections to my suggested set of people to review would
> be welcome.
>
> +CC Rafael who I've managed to drop from this version which won't have helped.

Thanks!

I've just applied the series for 5.10 (with some minor edits in patch
changelogs and subjects), so if anyone has any reservations regarding
it, please let me know ASAP.

In particular, I took the Hanjun's R-by on the last patch to be
sufficient from the ARM64 perspective.

Cheers!


> > > Thanks to Bjorn Helgaas for review of v1 and Barry Song for internal reviews that
> > > lead to a slightly different approach for this v2.
> > >
> > > Changes since v2.
> > > * Trivial rebase to v5.9-rc1
> > > * Collect up tags.
> > >
> > > Changes since v1.
> > > * Use pxm_to_node for what was previously the path using acpi_map_pxm_to_node
> > >   with create==false. (Barry)
> > > * Broke patch up into an initial noop stage followed by patches (Bjorn)
> > >   to update each type of case in which partial creation of NUMA nodes is prevented.
> > > * Added patch 5 to rename function to reflect change of functionality.
> > > * Updated descriptions (now mostly in individual patches) inline with Bjorn's comments.
> > >
> > > Jonathan Cameron (6):
> > >   ACPI: Add out of bounds and numa_off protections to pxm_to_node
> > >   ACPI: Do not create new NUMA domains from ACPI static tables that are
> > >     not SRAT
> > >   ACPI: Remove side effect of partly creating a node in
> > >     acpi_map_pxm_to_online_node
> > >   ACPI: Rename acpi_map_pxm_to_online_node to pxm_to_online_node
> > >   ACPI: Remove side effect of partly creating a node in acpi_get_node
> > >   irq-chip/gic-v3-its: Fix crash if ITS is in a proximity domain without
> > >     processor or memory
> > >
> > >  drivers/acpi/arm64/iort.c        |  2 +-
> > >  drivers/acpi/nfit/core.c         |  6 ++----
> > >  drivers/acpi/numa/hmat.c         |  4 ++--
> > >  drivers/acpi/numa/srat.c         |  4 ++--
> > >  drivers/iommu/intel/dmar.c       |  2 +-
> > >  drivers/irqchip/irq-gic-v3-its.c |  7 ++++++-
> > >  include/linux/acpi.h             | 15 +++++++--------
> > >  7 files changed, 21 insertions(+), 19 deletions(-)
> > >
> >
> >
> > _______________________________________________
> > Linuxarm mailing list
> > Linuxarm@huawei.com
> > http://hulk.huawei.com/mailman/listinfo/linuxarm
>
>
