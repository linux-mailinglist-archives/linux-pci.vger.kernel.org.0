Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1443A844
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhJYXkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 19:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhJYXkB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 19:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89FF260187;
        Mon, 25 Oct 2021 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635205058;
        bh=xZuKP0UCTTapRVjN9lDtmo7bL5KlII2WBEwLuNEyNp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X294QY26/tHF2bGr/FF+NcS7TQJWsGxCzYVHQHrYygTawrmUqlGO8mmtHYRyZkJef
         5rnJCBX6j98l1Pj6gLN7t4ZlAqaEuJuSMLReKkwwt3oBWVzxM8vV0CvZ8Me9FdZsz/
         oI7Rq3zbHHq+cqm/MJZwYXmWyn5wgONJM7Ohj9F7K397SSizkhje71uKksH621ImbQ
         VOTPcvtIJThOgQyZwImt7kqJWE8UKbsXgQJAGLDt/fks6MrxPO1ogL2exfuub4i2ew
         lH90U9ROt1HL/Su36R6vAeuEP3C02XdEZ5+jnFcMvu/3n77+mBmIwvUB6/WGiW6rEm
         TkpJMnC5VmgQA==
Date:   Mon, 25 Oct 2021 18:37:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
Message-ID: <20211025233737.GA50860@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36685ccd-f1d6-5db4-f282-878d29515f8b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 05:52:15PM +0800, Xuesong Chen wrote:
> On 22/10/2021 00:57, Bjorn Helgaas wrote:
> > On Thu, Oct 21, 2021 at 11:46:40PM +0800, Xuesong Chen wrote:
> >> On 21/10/2021 02:50, Bjorn Helgaas wrote:
> >>> On Wed, Oct 20, 2021 at 11:16:38AM +0800, Xuesong Chen wrote:
> >>>> On 20/10/2021 03:23, Bjorn Helgaas wrote:
> >>>>> On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
> > 
> >>>>>> This patch will try to handle this case in a more common way
> >>>>>> instead of the original 'arch' specific solution, which will be
> >>>>>> beneficial to all the APEI-dependent platforms after that.
> >>>>>
> >>>>> This actually doesn't say anything about what the patch does or
> >>>>> how it works.  It says "handles this case in a more common way"
> >>>>> but with no details.
> >>>>
> >>>> Good suggestion, I'll give more details about that...
> >>>>
> >>>>> The EINJ table contains "injection instructions" that can read
> >>>>> or write "register regions" described by generic address
> >>>>> structures (see ACPI v6.3, sec 18.6.2 and 18.6.3), and
> >>>>> __einj_error_trigger() requests those register regions with
> >>>>> request_mem_region() or request_region() before executing the
> >>>>> injections instructions.
> >>>>>
> >>>>> IIUC, this patch basically says "if this region is part of the
> >>>>> MCFG area, we don't need to reserve it." That leads to the
> >>>>> questions of why we need to reserve *any* of the areas
> >>>>
> >>>> AFAIK, the MCFG area is reserved since the ECAM module will
> >>>> provide a generic Kernel Programming Interfaces(KPI), e.g,
> >>>> pci_generic_config_read(...), so all the drivers are allowed to
> >>>> access the pci config space only by those KPIs in a consistent
> >>>> and safe way, direct raw access will break the rule.  Correct me
> >>>> if I am missing sth.
> >>>>
> >>>>> and why it's safe to simply skip reserving regions that are part
> >>>>> of the MCFG area.
> >>>>
> >>>> Actual there is a commit d91525eb8ee6("ACPI, EINJ: Enhance error
> >>>> injection tolerance level") before to address this issue, the
> >>>> entire commit log as below:
> >>>>
> >>>>     Some BIOSes utilize PCI MMCFG space read/write opertion to trigger
> >>>>     specific errors. EINJ will report errors as below when hitting such
> >>>>     cases:
> >>>>     
> >>>>     APEI: Can not request [mem 0x83f990a0-0x83f990a3] for APEI EINJ Trigger registers
> >>>>     
> >>>>     It is because on x86 platform ACPI based PCI MMCFG logic has
> >>>>     reserved all MMCFG spaces so that EINJ can't reserve it again.
> >>>>     We already trust the ACPI/APEI code when using the EINJ interface
> >>>>     so it is not a big leap to also trust it to access the right
> >>>>     MMCFG addresses. Skip address checking to allow the access.
> >>>
> >>> I'm not really convinced by that justification because I don't
> >>> think the issue here is *trust*.  If all we care about is trust,
> >>> and we trust the ACPI/APEI code, why do we need to reserve
> >>> anything at all when executing EINJ actions?
> >>>
> >>> I think the resource reservation issue is about coordinating
> >>> multiple users of the address space.  A driver reserves the MMIO
> >>> address space of a device it controls so no other driver can
> >>> reserve it at the same time and cause conflicts.
> >>>
> >>> I'm not really convinced by this mutual exclusion argument either,
> >>> because I haven't yet seen a situation where we say "EINJ needs a
> >>> resource that's already in use by somebody else, so we can't use
> >>> EINJ."  When conflicts arise, the response is always "we'll just
> >>> stop reserving this conflicting resource but use it anyway."
> >>>
> >>> I think the only real value in apei_resources_request() is a
> >>> little bit of documentation in /proc/iomem.  For ERST and EINJ,
> >>> even that only lasts for the tiny period when we're actually
> >>> executing an action.
> >>>
> >>> So convince me there's a reason why we shouldn't just remove
> >>> apei_resources_request() completely :)
> >>
> >> I have to confess that currently I have no strong evidence/reason to
> >> convince you that it's absolute safe to remove
> >> apei_resources_request(),  probably in some conditions it *does*
> >> require to follow the mutual exclusion usage model.  The ECAM/MCFG
> >> maybe a special case not like other normal device driver, since all
> >> its MCFG space has been reserved during the initialization. Anyway,
> >> it's another topic and good point well worth discussing in the
> >> future.
> > 
> > This is missing the point.  It's not the MCFG reservation during
> > initialization that would make this safe.  What would make it safe is
> > the fact that ECAM does not require mutual exclusion.
> > 
> > When the hardware implements ECAM correctly, PCI config accesses do
> > not require locking because a config access requires a single MMIO
> > load or store.
>
> I don't quite understand here, we're talking about
> apei_resources_request() which is a mechanism to void resource
> conflict,"request_mem_region() tells the kernel that your driver is
> going to use this range of I/O addresses, which will prevent other
> drivers to make any overlapping call to the same region through
> request_mem_region()", but according to the context of 'a single
> MMIO load or store', are you talking about something like the mutex
> lock primitive?

My point was that when ECAM is implemented correctly, a CPU does a
single MMIO load to do a PCI config read and a single MMIO store to do
a PCI config write.  In that case there no need for any locking, so
there's no need for APEI to reserve those resources.

This is what d91525eb8ee6 ("ACPI, EINJ: Enhance error injection
tolerance level") does.  That code change makes sense, but the commit
log does not -- it has nothing to do with trusting the ACPI/APEI code;
it's just that no matter what the EINJ actions do with the MCFG
regions, they cannot interfere with other drivers.

> > Many non-ECAM config accessors *do* require locking because they use
> > several register accesses, e.g., the 0xCF8/0xCFC address/data pairs
> > used by pci_conf1_read().  If EINJ actions used these, we would have
> > to enforce mutual exclusion between EINJ config accesses and those
> > done by other drivers.
> 
> I take a look at the pci_conf1_read() function, there's only a pair of
> raw_spin_lock_irqsave() and raw_spin_unlock_irqrestore(), if that's the
> mutual exclusion you mentioned, seems it's not related to the
> apei_resources_request() we're talking about... 

This was an example of a case where EINJ mutual exclusion *would* be
required.  I do not expect EINJ actions to use the 0xCF8/0xCFC
registers because there is no mechanism to coordinate that with the OS
use of the same registers.

> > Some ARM64 platforms do not implement ECAM correctly, e.g.,
> > tegra194_map_bus() programs an outbound ATU and xgene_pcie_map_bus()
> > sets an RTDID register before the MMIO load/store.  Platforms like
> > this *do* require mutual exclusion between an EINJ config access and
> > other config accesses.
> 
> What's the mutual exclusion for those quirk functions (tegra194 and
> xgene)?  *mutual* is not applied for single side. I can see neither
> locking nor request_mem_region() in those bus map functions. 

These currently depend on the pci_lock.  See PCI_OP_READ() in
drivers/pci/access.c.

EINJ actions cannot acquire the pci_lock, so EINJ actions cannot
safely use ECAM space on those platforms.

> > These platforms are supported via quirks in pci_mcfg.c, so they will
> > have resources in the pci_mcfg_list, and if we just ignore all the
> > MCFG resources in apei_resources_request(), there will be nothing to
> > prevent ordinary driver config accesses from being corrupted by EINJ
> > accesses.
> > 
> > I think in general, is probably *is* safe to remove MCFG resources
> > from the APEI reservations, but it would be better if we had some way
> > to prevent EINJ from using MCFG on platforms like tegra194 and xgene.
> 
> Just as I mentioned, since there's no mutual exclusion applied for
> the tegra194 and xgene (correct me if I am wrong), putting their MCFG
> resources into the APEI reservation (so the apei_resources_request()
> applied) does nothing 

I think apei_resources_request() should continue to reserve MCFG areas
on tegra194 and xgene, but it does not need to reserve them on other
ARM64 platforms.

Bjorn
