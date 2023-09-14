Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56D07A03E8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjINMcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 08:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE71FC8;
        Thu, 14 Sep 2023 05:32:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E30C433C8;
        Thu, 14 Sep 2023 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694694722;
        bh=CTjVxEOmb9/avVAmKzfes/nYuDn39qximLrhdUqj2Cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ifQstyEOJn6D8AC7SkOULZ/nSJw25eKBJnxTAfVvMyWXPxrqr8KVucPrKV3qE3koW
         54ML4xqdXKhcTJRz5wdJgHPaSorxCyxI0CPvWdwVvbOnYiW/nNl/e09OqZFpoAyFy2
         1HO3Q01RSZgnSdEEcIn0Byf3V1UH3q312Mi0nHzCyYGuuzUcTYEskYHi4YcrOAbGVK
         LHddJZQJzI+omi7DBv6GEugcGXKkOMDr09b+mLPUptMwoXGtdVfqIz8AD+3IUvCS2Z
         Ih1XcY+vLUBWPohgNfRn4+kB1Dt88SzuqEHlJ4VeTtJEXou6xOLn7UZwOUItgxn/QV
         I7lnoBhfeSxBw==
Date:   Thu, 14 Sep 2023 07:32:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230914123200.GA25154@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75e5175e-406e-41dd-90c7-3dc30741897e@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 11:59:00PM -0500, Mario Limonciello wrote:
> On 9/13/2023 16:16, Mario Limonciello wrote:
> > On 9/13/2023 16:05, Bjorn Helgaas wrote:
> > [cut]
> > > > > I expect it to be an ongoing issue.  I also expect unless we use
> > > > > constraints or convince the firmware team to add a _S0W object with a
> > > > > value of "0" for the sake of Linux that we will be adding
> > > > > IDs every year
> > > > > to wherever this lands as we reproduce it on newer SoCs.
> > > > 
> > > > So maybe the way to go is to make the AMD PMC driver set a flag for
> > > > Root Ports on suspend or similar.
> > > 
> > > I like the quirk approach.  When PMC is involved, the device behavior
> > > doesn't conform to what it advertised via PME_Support.
> > > 
> > > The v18 quirk isn't connected to PMC at all, so IIUC it avoids
> > > D3hot/D3cold unnecessarily when amd/pmc is not loaded.
> > 
> > Technically someone could; but realistically no one will be using these
> > machines without amd-pmc.
> > 
> > The battery life over suspend would be abhorrent.
> > 
> > > I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
> > > we *could* save a little power by using them when amd/pci isn't
> > > loaded, but amd/pci would have to iterate through all PCI devices when
> > > it loads, save previous state, do the quirk, and then restore the
> > > previous state on module unload.  And it would have to use notifiers
> > > or assume no Root Port hotplug.  All sounds kind of complicated.
> > 
> > Yeah this does sound needlessly complicated.
> > 
> > > Maybe it would even be enough to just clear dev->pme_support so we
> > > know wakeups don't work.  It would be a pretty big benefit if we
> > > didn't have to add another bit and complicate pci_prepare_to_sleep()
> > > or pci_target_state().
> > 
> > I don't think clearing PME support entirely is going to help.  The
> > reason is that pci_target_state() will fall back to PCI_D3hot when
> > dev->pme_support is fully cleared.
> > 
> > I think that clearing *just the bits* for D3hot and D3cold in PME
> > support should work though.  I'll test this.
> 
> I did confirm this works properly.
> 
> > Assuming it works how about if we put the quirk to clear the
> > D3hot/D3cold PME support bit in
> > drivers/platform/x86/amd/pmc/pmc-quirks.c?
> > 
> > It's still a quirk file and it makes it very clear that this behavior is
> > caused by what amd-pmc does.
> 
> I've got it coded up like this and working, so please let me know if this
> approach is amenable and I'll drop an updated version.
> 
> If you would prefer it to be in pci/quirks.c I believe I can do either.

If the quirk is in a loadable module, as opposed to being built-in,
does it get applied to the relevant Root Ports when the module is
loaded?  I didn't look exhaustively, but I don't see a reference to
pci_fixup_device() in the module load path.

Bjorn
