Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BC4A8AA9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353069AbiBCRuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 12:50:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55568 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiBCRuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 12:50:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A759F617A1;
        Thu,  3 Feb 2022 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D89C340E8;
        Thu,  3 Feb 2022 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643910624;
        bh=izoWiGyh8XnBsfb1ecNvm9atycnzhhjoNIrDnYGzsSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NEpCL124PAd8kMvKewlQOMwBnNT/KzBx4XxEzyNr0MFyqqE7eHBI23LyHGAZIll/D
         3suqK6ZinE5qpFVW+LOIPRBk9xhd20djeZD62TSbPKV4ZmSMikFkC9K2QZN3Tf9Xtk
         DYOEC/rHtZNoe/Ql6TIEbB5lfNdP0qfBpF2LRo3LTsnFTfjxuTQJeA021h9kthyIBD
         fM+15PgLb3juU9OsQGc1gh6YoA+NmI6qJuzHPIHEMkc8YlFAuMtk30fP5nOpTC00Qu
         YI56RFy4MEDhfBbBkzKex6JOWjJnVWgmCWHfhAVEbE0TMvJc6UEM7ZKgOsxqW/IHvd
         j3r+G+i00ps8w==
Date:   Thu, 3 Feb 2022 11:50:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [Bug 215560] New: _PRS/_SRS methods should be optional
Message-ID: <20220203175022.GA106219@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ae06ba-de8f-2cae-60fa-fe9a215d779b@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 06:12:10PM +0100, Pierre Gondois wrote:
> On 2/3/22 5:32 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 03, 2022 at 10:10:19AM +0100, Pierre Gondois wrote:
> > > On 2/2/22 6:42 PM, Bjorn Helgaas wrote:
> > > > On Wed, Feb 02, 2022 at 10:20:44AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=215560
> > > > > 
> > > > > The PCI legacy interrupts can be described with link devices, cf ACPI 6.4,
> > > > > s6.2.13 "_PRT (PCI Routing Table)".
> > > > > Link devices can have optional _SRS/_PRS methods to set the interrupt.
> > > > > ...
> > 
> > > > > However, _PRS/_SRS methods are checked in drivers/acpi/pci_link.c, and the
> > > > > driver aborts if they are absent.
> > > > > E.g.: When _PRS is missing:
> > > > > ACPI: \_SB_.PCI0.LNKA: _CRS 36 not found in _PRS
> > > > > ACPI: \_SB_.PCI0.LNKA: No IRQ available. Try pci=noacpi or acpi=off
> > > > 
> > > > I assume this bug report is because something isn't working.  Can
> > > > you update the bugzilla with a note about what specifically isn't
> > > > working and also attach a complete dmesg log and acpidump?
> > > 
> > > The question arose while writing link devices code, so there is no
> > > platform with missing _PRS/_SRS methods that I know.
> > > 
> > > The question was more about spec compliance and the necessity to
> > > have these methods when legacy interrupts are not configurable.  The
> > > message above (_CRS XXX not found in _PRS) can be generated for a
> > > Juno for instance, and the ACPI tables are at:
> > > https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/JunoPkg/AcpiTables/AcpiSsdtRootPci.asl
> > > The ACPI table need to be modified (remove _PRS and set _CRS
> > > correctly).
> > > 
> > > If the conclusion is that _PRS/_SRS are mandatory, even for
> > > hard-wired interrupts, then the bugzilla can be closed.
> > 
> > OK, so if I understand correctly, you're using Interrupt Link devices
> > not because it's possible to connect a PCI interrupt to one of several
> > inputs on the interrupt controller, but because the PCI default of
> > "level triggered, active low" is not compatible with GICv2.
> > 
> > The Interrupt Link device gives you a chance to specify "level
> > triggered, active *high*".  If you used a Source of 0 (where there
> > is no Interrupt Link), there would be no way to specify that.
> > 
> > Since this use of Interrupt Links only conveys triggering information
> > and nothing is configurable, I think the OS should get that info from
> > _CRS, and _PRS and _SRS should not be required.
> > 
> > Alex made a change [1] along that line a while ago, but maybe there's
> > more we should do.
> > 
> > Bjorn
> > 
> > [1] https://git.kernel.org/linus/92d1b381f677
> 
> Yes, this is exactly the situation.
> 
> The interrupt advertised in _CRS is checked to be in _PRS at:
> https://github.com/torvalds/linux/blob/26291c54e111ff6ba87a164d85d4a4e134b7315c/drivers/acpi/pci_link.c#L549
> and the _SRS method is also evaluated.
> 
> I can submit a patch if necessary,

That would be awesome.  Thanks for pushing on this!

Bjorn
