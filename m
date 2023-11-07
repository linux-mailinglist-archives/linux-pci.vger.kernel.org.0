Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70527E4BB9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjKGWap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 17:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjKGWan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 17:30:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12610CF
        for <linux-pci@vger.kernel.org>; Tue,  7 Nov 2023 14:30:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9238C433C8;
        Tue,  7 Nov 2023 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699396240;
        bh=zO04+G345zN9/cizf6fLcH3TgOzXuILq9uepaUlB1aM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nIeWLxA0DlonXeBJ9chFJK1IYhQ86uipzSCtVmKC3zjeKl2vVyjPO8Ki11SMe2IWe
         rm8mEVlrXuordPU4goVTHtCpfzCv3W0rrke7PByI2wUuQw/CQgORPrtAgXuPtDIY0w
         bEWcLQgwqebkG5ns32AQuf2EPMOc1ORIz5jeVb+KPdzvh+TL52NxD9fsauygt+0/xa
         udowoHMObM5rGkg0LefpzGfyRqtAbS+y71rzJ2MPD38YgyXVC2hotSvGDpXlUZouLa
         8SIAgjNqOnO5SzqUWNP1YA8krBxml0zYl218iNC7nikLohWTzobReinPTKN9BAjRj1
         SgN50IpdB9H7g==
Date:   Tue, 7 Nov 2023 16:30:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        orden.e.smith@intel.com, samruddh.dhope@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231107223037.GA303668@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a623e811037972c7cdf1fe05fcb7ace2b445a323.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, just FYI re 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")]

On Tue, Nov 07, 2023 at 02:50:57PM -0700, Nirmal Patel wrote:
> On Thu, 2023-11-02 at 16:49 -0700, Nirmal Patel wrote:
> > On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> > > On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > > > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > > > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel
> > > > > > > wrote:
> > > > > > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > > > > > rootports' Hotplug configuration in BIOS.
> > > > > > > > is_hotplug_bridge
> > > > > > > > is set on each VMD rootport based on Hotplug capable bit
> > > > > > > > in
> > > > > > > > SltCap in probe.c.  Check is_hotplug_bridge and enable or
> > > > > > > > disable native_pcie_hotplug based on that value.
> > > > > > > > 
> > > > > > > > Currently VMD driver copies ACPI settings or platform
> > > > > > > > configurations for Hotplug, AER, DPC, PM, etc and enables
> > > > > > > > or
> > > > > > > > disables these features on VMD bridge which is not
> > > > > > > > correct
> > > > > > > > in case of Hotplug.
> > > > > > > 
> > > > > > > This needs some background about why it's correct to copy
> > > > > > > the
> > > > > > > ACPI settings in the case of AER, DPC, PM, etc, but
> > > > > > > incorrect
> > > > > > > for hotplug.
> > > > > > > 
> > > > > > > > Also during the Guest boot up, ACPI settings along with
> > > > > > > > VMD
> > > > > > > > UEFI driver are not present in Guest BIOS which results
> > > > > > > > in
> > > > > > > > assigning default values to Hotplug, AER, DPC, etc. As a
> > > > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > > > 
> > > > > > > > This patch will make sure that Hotplug is enabled
> > > > > > > > properly
> > > > > > > > in Host as well as in VM.
> > > > > > > 
> > > > > > > Did we come to some consensus about how or whether _OSC for
> > > > > > > the host bridge above the VMD device should apply to
> > > > > > > devices
> > > > > > > in the separate domain below the VMD?
> > > > > > 
> > > > > > We are not able to come to any consensus. Someone suggested
> > > > > > to
> > > > > > copy either all _OSC flags or none. But logic behind that
> > > > > > assumption is that the VMD is a bridge device which is not
> > > > > > completely true. VMD is an endpoint device and it owns its
> > > > > > domain.
> > > > > 
> > > > > Do you want to facilitate a discussion in the PCI firmware SIG
> > > > > about this?  It seems like we may want a little text in the
> > > > > spec
> > > > > about how to handle this situation so platforms and OSes have
> > > > > the
> > > > > same expectations.
> > > > 
> > > > The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
> > > > author did not test in VM environment impact.
> > > > We can resolve the issue easily by 
> > > > 
> > > > #1 Revert the patch which means restoring VMD's original
> > > > functionality
> > > > and author provide better fix.
> > > > 
> > > > or
> > > > 
> > > > #2 Allow the current change to re-enable VMD hotplug inside VMD
> > > > driver.
> > > > 
> > > > There is a significant impact for our customers hotplug use cases
> > > > which
> > > > forces us to apply the fix in out-of-box drivers for different
> > > > OSs.
> > > 
> > > I agree 100% that there's a serious problem here and we need to fix
> > > it, there's no argument there.
> > > 
> > > I guess you're saying it's obvious that an _OSC above VMD does not
> > > apply to devices below VMD, and therefore, no PCI Firmware SIG
> > > discussion or spec clarification is needed?
> >
> > Yes. By design VMD is an endpoint device to OS and its domain is
> > privately owned by VMD only. I believe we should revert back to
> > original design and not impose _OSC settings on VMD domain which is
> > also a maintainable solution.
>
> I will send out revert patch. The _OSC settings shouldn't apply
> to private VMD domain. 

I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC
on PCIe features").  That appeared in v5.17, and it fixed (or at least
prevented) an AER message flood.  We can't simply revert 04b12ef163d1
unless we first prevent that AER message flood in another way.

Bjorn

> Even the patch 04b12ef163d1 needs more changes to make sure _OSC
> settings are passed on from Host BIOS to Guest BIOS which means
> involvement of ESXi, Windows HyperV, KVM.
