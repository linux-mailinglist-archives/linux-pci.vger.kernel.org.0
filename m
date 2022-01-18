Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266A492A79
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbiARQKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 11:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiARQJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 11:09:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B96CC061786;
        Tue, 18 Jan 2022 08:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BCF22CE1A32;
        Tue, 18 Jan 2022 16:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC9CC00446;
        Tue, 18 Jan 2022 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642522146;
        bh=zqHxrI6XCvlCuGzwuY4wNXvA6Ofm2gVDus5YeZSMlAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vKk9pbUgvJd/y4uNAFNvjlvkSjd60jvbAemMlJVvrcnp6d/o6pJ/250/s4+a/PAwi
         493zDNnonibHl+XAFCJ7TIkUmVbTEn2OiXQbTAktv4TUSVmiwJMpotYl+zA9qDFRTY
         KIifZnabPb7mvKSZIvmvYQw05Fb+MhCcAb9ten0D1gcrQw6oWZN8vcrlnKRSnmHPYG
         kjcm/5XYE3MqdE0UucGZ++mHK5dBiWvBM40KmtcjKVW2QMOiAcpO7DDzJOCgb1zSyA
         7xwDZVAMf2b+MyYUbhKIaiOgczXhSmDKBBmvZX3QfpRa7ViZ7BiQBPeIt517NiTp8Q
         bQSr6LE6ZuKwA==
Date:   Tue, 18 Jan 2022 10:09:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
Message-ID: <20220118160904.GA870716@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf0416b-196e-de5b-d858-22767edc604c@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 09:06:12AM +0100, Heiner Kallweit wrote:
> On 18.01.2022 00:35, Bjorn Helgaas wrote:
> > [+cc Kai-Heng, Lukas, Mika, since they were cc'd or commented on [0] below]
> > 
> > On Mon, Jan 17, 2022 at 11:51:54AM +0100, Heiner Kallweit wrote:
> >> Currently PCI core forbids RPM and requires opt-in from userspace,
> >> apart from few drivers calling pm_runtime_allow(). Reason is that some
> >> early ACPI PM implementations conflict with RPM, see [0].
> >> Note that as of today pm_runtime_forbid() is also called for non-ACPI
> >> systems. Maybe it's time to allow RPM per default for non-ACPI systems
> >> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
> >> was published in 2011.
> > 
> > Let's reword this to use the positive sense, e.g., something like
> > "enable runtime power management for non-ACPI and ACPI 5.0 and newer."
> > 
> > This feels like a potentially significant change that could cause
> > breakage.  
> > 
> >   - How would a user recognize that we're doing something different?
> >     Maybe we need a note in dmesg?
> > 
> >   - If a system broke because of this, what would it look like?  How
> >     would a user notice a problem, and how would he or she connect the
> >     problem to this change?
> 
> Don't know what the exact symptoms of the original problem are.
> I'd more see a certain risk that this change reveals bugs in RPM usage
> of PCI device drivers. There's not a fixed list of potential symptoms.
> 
> One example: igb driver caused a hang on system shutdown when RPM was
> enabled due to a RTNL deadlock in RPM resume path.
> 
> >   - Is there a kernel parameter that will get the previous behavior of
> >     disabling runtime PM as a workaround until a quirk can be added?
> >     If so, we should probably mention it here.  If not, should there
> >     be?
> 
> For each device in sysfs: power/control: "auto" -> "on"

Thanks.  In case it wasn't clear, this is information that I would
like to have in the commit log so that if anybody *does* see a
problem, there's a hint about how to debug it and work around it.

> >> [0] https://lkml.org/lkml/2020/11/17/1548
> > 
> > Please use an https://lore.kernel.org/r/... link instead.
> > 
> > Let's mention bb910a7040e9 ("PCI/PM Runtime: Make runtime PM of PCI
> > devices inactive by default") as well to help connect the dots here.
> > 
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/pci/pci.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 428afd459..26e3a500c 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
> >>  	u16 status;
> >>  	u16 pmc;
> >>  
> >> -	pm_runtime_forbid(&dev->dev);
> >> +#ifdef CONFIG_ACPI
> >> +	/* Some early ACPI PM implementations conflict with RPM. */
> >> +	if (acpi_gbl_FADT.header.revision > 0 &&
> >> +	    acpi_gbl_FADT.header.revision < 5)
> >> +		pm_runtime_forbid(&dev->dev);
> >> +#endif
> >>  	pm_runtime_set_active(&dev->dev);
> >>  	pm_runtime_enable(&dev->dev);
> >>  	device_enable_async_suspend(&dev->dev);
> >> -- 
> >> 2.34.1
> >>
> 
