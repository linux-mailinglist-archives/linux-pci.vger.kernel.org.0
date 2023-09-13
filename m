Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801679F371
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjIMVF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjIMVFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 17:05:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3A91BD4;
        Wed, 13 Sep 2023 14:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3BDC433CB;
        Wed, 13 Sep 2023 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694639145;
        bh=LL5FYKc5sc5mqMIzOACAM0sCDQLeDKF/HFS3zAkNTeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mqsgIeRcqpFlcKt2tajdTe/FOO+M4p5u/mu4wUmnCceWx04TwBwnN+DSRIrL5NhoE
         Ph6kxd6IL2d8D7CFgPjFvmIt54H5L/D1zZF8eaAoG4ps3gcc00NlemmzIxhtLwZb74
         HT6i+mloliVYnscUFfbDW0KlAs1709tjGzzjTIBhlPFCCKYN0x6QGHn2ral7iCdLDP
         TxpIdE764wJBr6U0Vc4aSDQItvJe2MwKdPql4/s9m+T5ZUH2FvFmpjY2/WqVGmzJ3b
         f2FSPq/CMyxAatDcpGJOdUN8ilEd2jzYn/o0RddLVy1obmEj568tGRWHvDB61qn7Xl
         DPfL0Jp7X/AVA==
Date:   Wed, 13 Sep 2023 16:05:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
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
Message-ID: <20230913210543.GA440503@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hzdNYOLeOoM-4PZMQtr5J93kGA6Gidn_DVbFweMLb8vw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 07:42:05PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 13, 2023 at 6:35 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 9/13/2023 10:40, Bjorn Helgaas wrote:
> > > On Wed, Sep 13, 2023 at 12:20:14PM +0200, Rafael J. Wysocki wrote:
> > >> On Wed, Sep 13, 2023 at 6:11 AM Mario Limonciello
> > >> <mario.limonciello@amd.com> wrote:
> 
> [cut]
> 
> > >
> > > Also, do we have some indication that this is specific to Ryzen?  If
> > > not, I assume this is an ongoing issue, and matching on Device IDs
> > > just means we'll have to debug the same problem again and add more
> > > IDs.
> >
> > This is why my earlier attempts (v16 and v17) tried to tie it to
> > constraints.  These are what the uPEP driver in Windows uses to make the
> > decision of what power state to put integrated devices like the root
> > port into.
> >
> > In Windows if no uPEP driver is installed "Windows internal policy"
> > dictates what happens.  If the uPEP driver is installed then it
> > influences the policy based upon the constraints.
> >
> > Rafael had feedback against constraints in v17, which is why I'm back to
> > a quirk for v18.
> >
> > This issue as I've described it is specific to AMD Ryzen.
> 
> OK, so a quirk is the way to go IMO, because starting to rely on LPI
> constraints in general retroactively is almost guaranteed to regress
> things this way or another.
> 
> Whatever is done, it needs to be Ryzen-specific, unless there is
> evidence that other (and in particular non-AMD) platforms are
> affected.
> 
> > I expect it to be an ongoing issue.  I also expect unless we use
> > constraints or convince the firmware team to add a _S0W object with a
> > value of "0" for the sake of Linux that we will be adding IDs every year
> > to wherever this lands as we reproduce it on newer SoCs.
> 
> So maybe the way to go is to make the AMD PMC driver set a flag for
> Root Ports on suspend or similar.

I like the quirk approach.  When PMC is involved, the device behavior
doesn't conform to what it advertised via PME_Support.

The v18 quirk isn't connected to PMC at all, so IIUC it avoids
D3hot/D3cold unnecessarily when amd/pmc is not loaded.

I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
we *could* save a little power by using them when amd/pci isn't
loaded, but amd/pci would have to iterate through all PCI devices when
it loads, save previous state, do the quirk, and then restore the
previous state on module unload.  And it would have to use notifiers
or assume no Root Port hotplug.  All sounds kind of complicated.

Maybe it would even be enough to just clear dev->pme_support so we
know wakeups don't work.  It would be a pretty big benefit if we
didn't have to add another bit and complicate pci_prepare_to_sleep()
or pci_target_state().

Bjorn
