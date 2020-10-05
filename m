Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989BB283F79
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJETTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 15:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgJETTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 15:19:32 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86285207BC;
        Mon,  5 Oct 2020 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601925571;
        bh=LBhvy7kJ4S713PKlYZa9W+tCoXq7DrrCS8SmHd9VfYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sGfeyeiHlHqXKAEKw1kO1wSDicUupy5xZfMmmJYAoIlrdcLJNgg8Q/9FY3lPn8GxT
         1Ic5qm/f7Xe4M/fLdy0nFnXrnR8X5sCVWcudMnDP7yJq6NH4BkrYgMOeJQolcgwKBW
         wijyg9pQwXO73DIIKYYUTvwLEFawc/NNCkqxHHhM=
Date:   Mon, 5 Oct 2020 14:19:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, jonathan.derrick@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kumlien <ian.kumlien@gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
Message-ID: <20201005191930.GA3031652@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98360545-DC08-44A9-B096-ACF6823EF85D@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ian, who's also working on an ASPM issue]

On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
> > On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
> >> BIOS may not be able to program ASPM for links behind VMD, prevent Intel
> >> SoC from entering deeper power saving state.
> > 
> > It's not a question of BIOS not being *able* to configure ASPM.  I
> > think BIOS could do it, at least in principle, if it had a driver for
> > VMD.  Actually, it probably *does* include some sort of VMD code
> > because it sounds like BIOS can assign some Root Ports to appear
> > either as regular Root Ports or behind the VMD.
> > 
> > Since this issue is directly related to the unusual VMD topology, I
> > think it would be worth a quick recap here.  Maybe something like:
> > 
> >  VMD is a Root Complex Integrated Endpoint that acts as a host bridge
> >  to a secondary PCIe domain.  BIOS can reassign one or more Root
> >  Ports to appear within a VMD domain instead of the primary domain.
> > 
> >  However, BIOS may not enable ASPM for the hierarchies behind a VMD,
> >  ...
> > 
> > (This is based on the commit log from 185a383ada2e ("x86/PCI: Add
> > driver for Intel Volume Management Device (VMD)")).
> 
> Ok, will just copy the portion as-is if there's patch v2 :)
> 
> > But we still have the problem that CONFIG_PCIEASPM_DEFAULT=y means
> > "use the BIOS defaults", and this patch would make it so we use the
> > BIOS defaults *except* for things behind VMD.
> > 
> >  - Why should VMD be a special case?
> 
> Because BIOS doesn't handle ASPM for it so it's up to software to do
> the job.  In the meantime we want other devices still use the BIOS
> defaults to not introduce any regression.
> 
> >  - How would we document such a special case?
> 
> I wonder whether other devices that add PCIe domain have the same
> behavior?  Maybe it's not a special case at all...

What other devices are these?

> I understand the end goal is to keep consistency for the entire ASPM
> logic. However I can't think of any possible solution right now.
> 
> >  - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
> >    SoC power state problem?
> 
> Yes.
> 
> >  - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?
> 
> This will break many systems, at least for the 1st Gen Ryzen
> desktops and laptops.
>
> All PCIe ASPM are not enabled by BIOS, and those systems immediately
> freeze once ASPM is enabled.

That indicates a defect in the Linux ASPM code.  We should fix that.
It should be safe to use CONFIG_PCIEASPM_POWERSAVE=y on every system.

Are there bug reports for these?  The info we would need to start with
includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=y).
If a console log with CONFIG_PCIEASPM_POWERSAVE=y is available, that
might be interesting, too.  We'll likely need to add some
instrumentation and do some experimentation, but in principle, this
should be fixable.

Bjorn
