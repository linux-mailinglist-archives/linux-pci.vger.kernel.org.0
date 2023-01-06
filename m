Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8A65F82C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjAFAcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 19:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjAFAcq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 19:32:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD251304;
        Thu,  5 Jan 2023 16:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E9561BC8;
        Fri,  6 Jan 2023 00:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8025DC433F0;
        Fri,  6 Jan 2023 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672965164;
        bh=c0ecRMbUF6rl3SYarCW/FhvoXm6cemNd5r6GhYd+FYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XCdhcjEKbYRZDLEjDkx7gkh7OO4bF4Bis1P0gcAukKDmXQSWn/DsPQDRYlr9iEjOL
         oCcFi30aIZ8kawIAbR0JrzdI830c9ZRlQ9qRZbecc8jeGtWjBAgB6BneCLOzVfTjgh
         zEukt0z/Rky+9moufXUOEMxwBOM1sKXndlzVOeXzWYcF+YcIP0K1gQmkaFEJhWAF34
         72zZCI6pQfnjKWkcblGD7xddcai2NG8IuQvY4ZB+qolPotCkdM51fDP+MjziCA/yJx
         eTL2NrBPLyuayYUMSN9lAbR1+VSGKBe+6Im7UhDoRwzAzCN22r1f3Hh/RDs5Wa5Dj+
         HgXrQsv1NY3sg==
Date:   Thu, 5 Jan 2023 18:32:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, bhelgaas@google.com,
        hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        2lprbe78@duck.com, nicholas.johnson-opensource@outlook.com.au,
        benoitg@coeus.ca, mika.westerberg@linux.intel.com,
        wse@tuxedocomputers.com, mumblingdrunkard@protonmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.e.box@intel.com, yunying.sun@intel.com,
        Tony Luck <tony.luck@intel.com>, dave.jiang@intel.com
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230106003242.GA1184026@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b75f8083b79_c81f02949b@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 03:38:40PM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
> > > Hi Bjorn,
> > > 
> > > Happy new year!
> > > 
> > > We found some PCI issues with the latest 6.2-rc2.
> > > 
> > > - Using the lspci -xxxx, the extended PCI config space of all PCI
> > > devices are missed with the latest 6.2-rc2. The system we used had 932
> > > PCI devices, at least 800 which have extended space as seen when booted
> > > into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> > > - The drivers which rely on the information in the extended PCI config
> > > space don't work anymore. We have confirmed that the perf uncore driver
> > > (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> > > work in 6.2-rc2. There could be more drivers which are impacted.
> > > 
> > > After a bisect, we found the regression is caused by the below commit
> > > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> > > After reverting the commit, the issues are gone.
> > 
> > Can you try this patch (based on v6.2-rc1):
> 
> Looks good to me, one question below, but either way:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...and Dave, who reported that CXL enumeration was busted in -rc2, says
> this patch fixes that. So you can also add:
> 
> Tested-by: Dave Jiang <dave.jiang@intel.com>

Thanks for all this!

> > +static bool is_efi_reserved(u64 start, u64 end, enum e820_type not_used)
> > +{
> > +	efi_memory_desc_t *md;
> > +	u64 size, mmio_start, mmio_end;
> > +
> > +	for_each_efi_memory_desc(md) {
> > +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> 
> Should this also consider EFI_RESERVED_TYPE? Not that any known BIOS
> needs that accommodation. This is more a question than a suggestion.

I don't think GetMemoryMap() is intended as a way to tell the OS about
device memory.  The OS needs to know what address space goes with what
device and what kind of device it is.  The ACPI namespace supplies all
that kind of information, so it doesn't make sense to me that we'd get
some from ACPI and some from EFI.

Also, the EFI spec says EfiReservedMemoryType is "Not usable."  But if
ECAM space were described that way, obviously the OS *does* need to
use it, so it doesn't really seem to fit.

I do think the EFI spec is pretty poorly worded.  EfiMemoryMappedIO is
"not used by the OS" -- misleading, since the OS *has* to use ECAM and
host bridge apertures.  And "all system memory-mapped IO information
should come from ACPI tables" -- well, the EfiMemoryMappedIO region is
itself certainly some kind of information about memory-mapped IO
space!  I think it should really refer to the ACPI *namespace*
specifically, not just tables that might include MCFG, etc.  IMHO the
static tables like MCFG are basically just a crutch for use before we
know how to parse the namespace.

Anyway, I am inclined to do nothing with EFI_RESERVED_TYPE unless we
come across a system that needs it.

Bjorn
