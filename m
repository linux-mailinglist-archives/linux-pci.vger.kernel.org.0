Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721097A0951
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbjINPdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjINPdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 11:33:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A5CE;
        Thu, 14 Sep 2023 08:33:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6658C433C8;
        Thu, 14 Sep 2023 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694705586;
        bh=8FABy4QEHgIh/D0+D8dBsiY5dWtOqxQIKA/BQugluDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lx6a4XE5GVqm8ZNhPC/4n/oIWpFVOS0nu2r1Y+KfrdcJXi0bM9FPb+ta7f11LCZ7E
         EEj9Tgz8D0SbR0WYDrmo/fEumU7wRuwD0qObs/ZFztLMh1JWmIWpjgt/HMK0mYUi93
         pzx6p1fsAlJ8fYxLGMNEj/H8J7nJJn/NmaC5vtvHMfh2Q+KJdV+Z0ynW4mKiSkd73g
         pZqbEDI9E98Idx5YrvtMrirWx38pNP6Y7txya1+m/jresTlkprw9cw3eTffLLQB8qY
         aa2R1gknGNsoX7jSflDVKiQVtoW8a7oqGQtGe9df9pnd6oHD15OXGWCJNCuMiWX6KY
         NY7F9aNFFzCqA==
Date:   Thu, 14 Sep 2023 10:33:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230914153303.GA30424@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914145332.GA5261@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 04:53:32PM +0200, Lukas Wunner wrote:
> On Thu, Sep 14, 2023 at 09:31:38AM -0500, Mario Limonciello wrote:
> > On 9/14/2023 09:17, Lukas Wunner wrote:
> > > On Wed, Sep 13, 2023 at 11:36:49AM -0500, Mario Limonciello wrote:
> > > > On 9/13/2023 09:31, Lukas Wunner wrote:
> > > > > If this only affects system sleep, not runtime PM, what you can do is
> > > > > define a DECLARE_PCI_FIXUP_SUSPEND_LATE() which calls pci_d3cold_disable()
> > > > > and also define a DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY() which calls
> > > > > pci_d3cold_enable().
> > > > > 
> > > > > And I think you can make those calls conditional on pm_suspend_no_platform()
> > > > > to constrain to s2idle.
> > > > > 
> > > > > User space should still be able to influence runtime PM via the
> > > > > d3cold_allowed flag (unless I'm missing something).
> > > > 
> > > > The part you're missing is that D3hot is affected by this issue too,
> > > > otherwise it would be a good proposal.
> > > 
> > > I recall that in an earlier version of the patch, you solved the issue
> > > by amending pci_bridge_d3_possible().
> > > 
> > > Changing the dev->no_d3cold flag indirectly influences the bridge_d3
> > > flag (through pci_dev_check_d3cold() and pci_bridge_d3_update()).
> > > 
> > > If dev->no_d3cold is set on a device below a port, that port is
> > > prevented from entring D3hot because it would result in the
> > > device effectively being in D3cold.
> > > 
> > > So you might want to take a closer look at this approach despite
> > > the flag suggesting that it only influences D3cold.
> > 
> > Ah; I hadn't considered setting it on a device below the port. In this
> > particular situation the only devices below the root port are USB
> > controllers.
> > 
> > If those devices don't go into D3 the system can't enter hardware sleep.
> 
> If you set dev->no_d3cold on the USB controllers, they should still
> be able to go to D3hot, but not D3cold, which perhaps might be sufficient.
> It should prevent D3cold *and* D3hot on the Root Port above.  And if you
> set that on system sleep in a quirk and clear it on resume, runtime PM
> shouldn't be affected.

dev->no_d3cold appears to be mainly an administrative policy knob
twidded via sysfs.

There *are* a few cases where drivers (i915, nouveau, xhci) update it
via pci_d3cold_enable() or pci_d3cold_disable(), but they all look
vulnerable to issues if people use the sysfs knob, and I'm a little
dubious that they're legit in the first place.

This AMD Root Port issue is not an administrative choice; it's purely
a functional problem of the device advertising that it supports PME#
but not actually being able to do it.  So if we can do this by fixing
dev->pme_support (i.e., the copy of what it advertised), I'd rather do
that.

Bjorn
