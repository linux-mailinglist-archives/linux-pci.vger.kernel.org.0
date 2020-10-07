Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB14428601F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgJGNaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 09:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbgJGNaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 09:30:04 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9728E206DD;
        Wed,  7 Oct 2020 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602077403;
        bh=q4lBboz9+2Jdbs23HhsUEpPeiSxMVRRPKA+8fz22/5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n0i91Y7KSGk9H4YqGtspkK34HWYGn/Cu7Z6px5LB5sM4VckZF+5SyZq4xRpnJjNGO
         QBvKmgmQPefo6EebtlT2cEhjHtOgqvufP+3SqXM1SfE0dDncs9EZDq5DMiJB5B+k94
         L7p93wsgFZZHhHEVMV4g0j7TJf8mN7Tuy3S8a1x0=
Date:   Wed, 7 Oct 2020 08:30:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kumlien <ian.kumlien@gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
Message-ID: <20201007133002.GA3236436@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902912C5-FEE0-488A-8017-9A59B0398BD1@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 12:26:19PM +0800, Kai-Heng Feng wrote:
> > On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
> >>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:

...
> >> I wonder whether other devices that add PCIe domain have the same
> >> behavior?  Maybe it's not a special case at all...
> > 
> > What other devices are these?
> 
> Controllers which add PCIe domain.

I was looking for specific examples, not just a restatement of what
you said before.  I'm just curious because there are a lot of
controllers I'm not familiar with, and I can't think of an example.

> >> I understand the end goal is to keep consistency for the entire ASPM
> >> logic. However I can't think of any possible solution right now.
> >> 
> >>> - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
> >>>   SoC power state problem?
> >> 
> >> Yes.
> >> 
> >>> - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?
> >> 
> >> This will break many systems, at least for the 1st Gen Ryzen
> >> desktops and laptops.
> >> 
> >> All PCIe ASPM are not enabled by BIOS, and those systems immediately
> >> freeze once ASPM is enabled.
> > 
> > That indicates a defect in the Linux ASPM code.  We should fix that.
> > It should be safe to use CONFIG_PCIEASPM_POWERSAVE=y on every system.
> 
> On those systems ASPM are also not enabled on Windows. So I think
> ASPM are disabled for a reason.

If the platform knows ASPM needs to be disabled, it should be using
ACPI_FADT_NO_ASPM or _OSC to prevent the OS from using it.  And if
CONFIG_PCIEASPM_POWERSAVE=y means Linux enables ASPM when it
shouldn't, that's a Linux bug that we need to fix.

> > Are there bug reports for these? The info we would need to start with
> > includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=y).
> > If a console log with CONFIG_PCIEASPM_POWERSAVE=y is available, that
> > might be interesting, too.  We'll likely need to add some
> > instrumentation and do some experimentation, but in principle, this
> > should be fixable.
> 
> Doing this is asking users to use hardware settings that ODM/OEM
> never tested, and I think the risk is really high.

What?  That's not what I said at all.  I'm asking for information
about these hangs so we can fix them.  I'm not suggesting that you
should switch to CONFIG_PCIEASPM_POWERSAVE=y for the distro.

Let's back up.  You said:

  CONFIG_PCIEASPM_POWERSAVE=y ... will break many systems, at least
  for the 1st Gen Ryzen desktops and laptops.

  All PCIe ASPM are not enabled by BIOS, and those systems immediately
  freeze once ASPM is enabled.

These system hangs might be caused by (1) some hardware issue that
causes a hang when ASPM is enabled even if it is configured correctly
or (2) Linux configuring ASPM incorrectly.

For case (1), the platform should be using ACPI_FADT_NO_ASPM or _OSC
to prevent the OS from enabling ASPM.  Linux should pay attention to
that even when CONFIG_PCIEASPM_POWERSAVE=y.

If the platform *should* use these mechanisms but doesn't, the
solution is a quirk, not the folklore that "we can't use
CONFIG_PCIEASPM_POWERSAVE=y because it breaks some systems."

For case (2), we should fix Linux so it configures ASPM correctly.

We cannot use the build-time CONFIG_PCIEASPM settings to avoid these
hangs.  We need to fix the Linux run-time code so the system operates
correctly no matter what CONFIG_PCIEASPM setting is used.

We have sysfs knobs to control ASPM (see 72ea91afbfb0 ("PCI/ASPM: Add
sysfs attributes for controlling ASPM link states")).  They can do the
same thing at run-time as CONFIG_PCIEASPM_POWERSAVE=y does at
build-time.  If those knobs cause hangs on 1st Gen Ryzen systems, we
need to fix that.

Bjorn
