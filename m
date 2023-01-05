Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EC65F631
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 22:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjAEVui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 16:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjAEVuE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 16:50:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CCD6B19E;
        Thu,  5 Jan 2023 13:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3447B81C00;
        Thu,  5 Jan 2023 21:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C859C433F0;
        Thu,  5 Jan 2023 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672955327;
        bh=sSgZkpSSFeg7zF0fRltIEJtmUsyv/4eyDBWDrROqlI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gf2MG4EJlbiel0n4TeLgxm4XoOlPwFnEKKwbGG5++OwRVeZI25FYaYtRPUl2TaMNT
         oC2WnzugCT7gLjx7HfrKvCskoP4N/EAy7T7FoYVMzSedyKULA+hHuTGpMTnjd9TEcw
         h6vUdZ3kaooOqGIx7ldbY6JftMKWXSyz8lApHDw6JuEP2PH+2QL1tD54fa8CGCdVyv
         VJv4cLAxIniPG9SeyBQQZlRXLyiBqekef7bZzRCffzSye8dxtv4sKrjnw1AC4fbm38
         WtKIeHux1OuQTEzmzcOJuDFMn3Z2MkdWU2q1IlDtvUhDWr2L2ozI99mloi/uWEsqV5
         9xGT4b5IXHeOw==
Date:   Thu, 5 Jan 2023 15:48:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105214845.GA1172859@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b7447883c75_51741294e5@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 01:43:20PM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Thu, Jan 05, 2023 at 01:20:36PM -0800, Dan Williams wrote:
> > > Bjorn Helgaas wrote:
> > > > On Thu, Jan 05, 2023 at 11:44:28AM -0800, Dan Williams wrote:

> > > > > Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> > > > > Memory Type Usage after ExitBootServices()"?
> > > > > 
> > > > > s/This memory is not used by the OS./This memory is not used by the OS,
> > > > > unless ACPI declares it for another purpose./
> > > > 
> > > > I guess the idea is that MCFG is a form of "ACPI declaring it"?  I
> > > > don't have an explicit citation for it, but I infer at [1] that ACPI
> > > > static tables are second-class citizens and not intended as a way of
> > > > reserving address space because that would lead to problems booting
> > > > old OSes on firmware that provides new tables unknown to the OS.
> > > 
> > > Ah, true, certainly for new stuff, but what about MCFG specifically?
> > > What harm is there an assuming that MMCONFIG intersecting with
> > > EfiMemoryMappedIO shall be treated as reserved for MMCONFIG usage.
> > 
> > Probably none, and I think that's what we'll have to do.  Ugh.
> > Another random special-case rule.
> > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.1#n32
> 
> I am still holding out that a BIOS developer can either say "whoops,
> populating MMCONFIG in _CRS was overlooked", or point out "if you take
> the derivative of the PCI spec, multiply it be the inverse of the EFI
> spec and then take the cross-product with the ACPI spec then the memory
> type comes out as implicitly reserved".

Hahaha :)  Yep, but even if they change it, apparently there are lots
of machines in the field that won't get updated, so we're stuck
working around it.

Or, I guess the best-case scenario would be that it's not actually a
firmware bug, and there's some clean fix we can make to Linux.  But
I'm not holding my breath.
