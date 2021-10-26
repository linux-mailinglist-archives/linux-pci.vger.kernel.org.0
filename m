Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42543BBD0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 22:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhJZUts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 16:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhJZUts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 16:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA23860296;
        Tue, 26 Oct 2021 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635281244;
        bh=hZut5nm2pKDxCAJpJ+gN/iH1oUKj9aOLGboxGFVJ5YI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=olXKZbS4UT5e405M23mZjkauGYD3HC0pijTZ9JfGB85dm7/+Z6cjvMsAexbv6QabS
         R4DiczunAOaGB5dG9uqMRBkOl2CsKwA0WEDMSjr88MIYYxS4NQ8LlLjjfc5Y224Vol
         mU06RB6CXLdgk8QoKjczkeFwWQ2yH8CV/7rJxqVHW3TC1QUMXf40CnVabGu+cIgOqC
         xrRc/XC85baK33Dtmt6OP2dS0xP+YLBwUsnYgN8q+jg/Ixw7JOBQ0sckmuxqxJRl9U
         VeTwHiJq+FB3YWx6UCGZePvE20G6irMcDY1/ooBaVJl43GhbA4hdxYBhTVcYkrMuha
         ES5QdyUDrAtOw==
Date:   Tue, 26 Oct 2021 15:47:22 -0500
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
Message-ID: <20211026204722.GA158130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e186336-aa68-d845-307e-aa6e1133322f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 05:16:47PM +0800, Xuesong Chen wrote:
> On 26/10/2021 07:37, Bjorn Helgaas wrote:

> > My point was that when ECAM is implemented correctly, a CPU does a
> > single MMIO load to do a PCI config read and a single MMIO store to do
> > a PCI config write.  In that case there no need for any locking, so
> > there's no need for APEI to reserve those resources.
> 
> Ah, got it. That means the PCI ECAM has a implicit mutual exclusion with EINJ
> if the hardware implemention is correct, so we can remove the MCFG from
> the APEI's safely.

Well, not quite.  ECAM doesn't *need* mutual exclusion.  Single loads
and stores are atomic by definition.

> > I think apei_resources_request() should continue to reserve MCFG areas
> > on tegra194 and xgene, but it does not need to reserve them on other
> > ARM64 platforms.
> 
> As a summary: we need to reserve the MCFG areas on those platforms with a
> quirk ECAM implementation since there's no lockless method to access the
> configuration space, on other platforms we don't need to reserve the MCFG
> resources (so can remove it safely).
> 
> So we need to add another patch to handle the case of tegra194 and xgene...
> I will try to figure it out. 

I looked through these again and found another problem case (thunder).
Here are my notes from my research.

Normal ECAM users require no device-specific support.  The platform
supplies an MCFG table, the generic code works, no mutual exclusion is
required, and APEI doesn't need to reserve the MCFG areas.

The problem cases are platforms that supply an MCFG table but require
some device-specific workarounds.  We can identify these because they
have quirks in pci-mcfg.c.  Here are the existing quirks and the
pci_ecam_ops structs they supply:

  AL_ECAM             al_pcie_ops                 # OK
  QCOM_ECAM32         pci_32b_ops                 # OK
  HISI_QUAD_DOM       hisi_pcie_ops               # OK
  THUNDER_PEM_QUIRK   thunder_pem_ecam_ops        # problem
  THUNDER_PEM_QUIRK   thunder_pem_ecam_ops        # problem
  THUNDER_ECAM_QUIRK  pci_thunder_ecam_ops        # OK
  tegra               tegra194_pcie_ops           # problem
  XGENE_V1_ECAM_MCFG  xgene_v1_pcie_ecam_ops      # problem
  XGENE_V2_ECAM_MCFG  xgene_v2_pcie_ecam_ops      # problem
  ALTRA_ECAM_QUIRK    pci_32b_read_ops            # OK

The ones marked "OK" have .map_bus(), .read(), and .write() methods
that need no mutual exclusion because they boil down to just a single
MMIO load or store.  These are fine and there shouldn't be a problem
if an EINJ action accesses the ECAM space.

The others do require mutual exclusion:

  - thunder_pem_ecam_ops: thunder_pem_config_read() calls
    thunder_pem_bridge_read(), which does a writeq() to PEM_CFG_RD
    followed by a readq().  The writeq() and readq() must be atomic to
    avoid corruption.

  - tegra194_pcie_ops: tegra194_map_bus() programs the ATU.  This and
    the subsequent ECAM read/write must be atomic.

  - xgene_v1_pcie_ecam_ops and xgene_v2_pcie_ecam_ops:
    xgene_pcie_map_bus() sets the RTID.  This and the subsequent ECAM
    read/write must be atomic.

I had to look at all these ops individually to find them, so I don't
see an easy way to identify these problem cases at run-time.

I personally would not have an issue with having APEI try to reserve
the MCFG regions for any platform that has an MCFG quirk.  That would
prevent the al, qcom, hisi, thunder-ecam, and altra drivers from using
EINJ even though it would probably be safe for them.  But we already
know those platforms are not really ACPI-compliant, so ...

Bjorn
