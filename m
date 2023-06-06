Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07FC724D9C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjFFT65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbjFFT6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 15:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C721715;
        Tue,  6 Jun 2023 12:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65CC5637C6;
        Tue,  6 Jun 2023 19:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792F3C433D2;
        Tue,  6 Jun 2023 19:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686081529;
        bh=/t6PMs1ae1Hb/cw1vXCpNAE0c2/e78MXFIPoLtaur5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C15aBS/oHLFLtGBs/1r7ELULfaMLrV6M6TG0zdECTZrK7EmrYn6+pPz0h+SUnjk/v
         N7PkbV3Q/CN+YV5kRR2FK5Xm8FtFdWUz370xckU1VX9rgdg3aHUdne0htPOyCJpvT9
         /MqpDpY3jZ4TLxkY6vLrC38FwaMBgp4ZiEXxQjrtLY+a2qgMGVz1yB114qSPv8uY9k
         MaDaje/OZyIyHymB9l2D/fkgwYgG5+uX6FWUe1VrSDke7MwV7gnaDOiDibP8FFWMT7
         IkA2pp0gFx1CnGW+9OkwXJAUksDRSrX2qp7lpW8G0q6Snp8SGphZ9vGmlf7S38jez6
         JSPPVa+9ED3tg==
Date:   Tue, 6 Jun 2023 14:58:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Message-ID: <20230606195847.GA1142401@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48a843d5-ed4f-e4c5-782c-b246b81142e0@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 06, 2023 at 02:40:45PM -0500, Limonciello, Mario wrote:
> On 6/6/2023 2:23 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 06, 2023 at 11:23:21AM -0500, Mario Limonciello wrote:
> > > ASMedia PCIe GPIO controllers fail functional tests after returning from
> > > suspend (S3 or s2idle). This is because the BIOS checks whether the
> > > OSPM has called the `_REG` method to determine whether it can interact with
> > > the OperationRegion assigned to the device.
> > > 
> > > As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
> > > code on the availability of an operation region.
> > > 
> > > To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> > > state of PCI devices.
> > > 
> > > Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v1->v2:
> > >   * Handle case of no CONFIG_ACPI
> > >   * Rename function
> > >   * Update commit message
> > >   * Move ACPI calling code into pci-acpi.c instead
> > >   * Cite the ACPI spec
> >
> > Thanks for the spec reference (s/APCI/ACPI/ and add the revision if
> > you rev this (r6.5 is the latest, AFAIK) if you rev this).
> > 
> > I don't see text in that section that connects S3 with _REG.  If it's
> > there, you might have to quote the relevant sentence or two in the
> > commit log.
>
> I don't think there is anything the spec connecting this
> with S3.  At least from my perspective S3 is the reason
> this was exposed but there is a deficiency that exists
> that _REG is not being called by Linux.
> 
> I intend to re-word the commit message something to the
> effect of explaining what _REG does and why _REG should be
> called, along with citations.
> 
> Then in another paragraph "Fixing this resolves an issue ...".
> 
> > You mentioned _REG being sort of a mutex to synchronize OSPM vs
> > platform access; if there's spec language to that effect, let's cite
> > it.
>
> That sentence I included was cited from the spec.

If it's necessary to justify the commit, include the citation in the
commit log.

> > Ideally we should have been able to read the PCI and ACPI specs and
> > implement this without tripping over problem on this particular
> > hardware.  I'm looking for the text that enables that "clean-room"
> > implementation.  If the spec doesn't have that text, it's either a
> > hole in the spec or a BIOS defect that depends on something the spec
> > doesn't require.
> 
> IMO both the spec and BIOS are correct, it's a Linux
> issue that _REG wasn't used.

What tells Linux that _REG needs to be used here?  If there's nothing
that tells Linux to use _REG here, I claim it's a BIOS defect.  I'm
happy to be convinced otherwise; the way to convince me is to point to
the spec.

If it's a BIOS defect, it's fine to work around it, but we need to
understand that, own up to it, and make the exact requirements very
clear.  Otherwise we're likely to break this in the future because
future developers and maintainers will rely on the specs.

> > Doing this in pci_save_state() still seems wrong to me.  For example,
> > e1000_probe() calls pci_save_state(), but this is not part of suspend.
> > IIUC, this patch will disconnect the opregion when we probe an e1000
> > NIC.  Is that what you intend?
>
> Thanks for pointing this one out.  I was narrowly focused
> on callers in PCI core.  This was a caller I wasn't
> aware of; I agree it doesn't make sense.
> 
> I think pci_set_power_state() might be another good
> candidate to use.  What do you think of this?

I can't suggest a call site because (1) I'm not a power management
person, and (2) I don't think we have a clear statement of when it is
required.  This must be expressed in terms of PCI power state
transitions, or at least something discoverable from a pci_dev, not
"s2idle" or even "S3" because those are meaningless in the PCI
context.

Bjorn
