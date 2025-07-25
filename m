Return-Path: <linux-pci+bounces-32954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99205B124B9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 21:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAD51CC3B29
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2613D994;
	Fri, 25 Jul 2025 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDgtndPt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AA2D052
	for <linux-pci@vger.kernel.org>; Fri, 25 Jul 2025 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472002; cv=none; b=O1D3BIU0+iF9IRiezfy7jqDp73qewfbdC3XqX/4In3MiK618sGYiR98jtYqRfh93KpIhkuq57LCp/dM3APbQNPTG2sVnvn8UfKvB5FCJ6rYm+OO/9p8TM0JvDFZIKdH8JC3zE4HdKsOipnhIPkTMhUk01UeePSwA2nL6S89DocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472002; c=relaxed/simple;
	bh=9Prp8cX0nlbbBFjCdqlppyvkDksiwgZqDhn5fgnFSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ciA04oCrK1+nDiEtYKFag+b1nDG77aO9KFWchILPcVmyHi9E4mb8VZSS+C7CwkAvzDpm3cfdMGD4NxMcTnlWhqRlV+j/J+CyCdIeXIU/PwWVi+p2Ojf+bBpsLqB0B2/1CoKiKakVd6YKeuczoYa8NJCf5XkPN8pIbJ0arsBHCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDgtndPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A24C4CEE7;
	Fri, 25 Jul 2025 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472001;
	bh=9Prp8cX0nlbbBFjCdqlppyvkDksiwgZqDhn5fgnFSi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FDgtndPt0jzKWejT87k3jKzfnDxsS56wLJ1sAf1OxEeJDFY6Z5iCRmnCdDIiMBb9r
	 OV08HvxN2uyNu6UchcJ+Xj1oAr/YX3KPCI3QB1FsxeQPA4Mv0gY/Qux3InXzBtD/BC
	 tWRyHSZHn/YXfe5COzcNcVwK1psche/340s/l3bJc7oK7C3jJZgbfqn/hPuJ+sKi+X
	 FJO+WN9niifgqd+qeDL+babpbBmVbOWMiakn25+KCMJh4PnUqI6AHHPOg/AD6NqWDt
	 ep1jFpOfdbScFGwpwR42+IuCtbPjF8cdZecIF+ZX5qjB5kRjvgXDw0HWQM0IDeNkbf
	 UlxlCKmmep3CQ==
Date: Fri, 25 Jul 2025 14:33:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Gil Fine <gil.fine@linux.intel.com>,
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: Clean up and fix is_hotplug_bridge usage
Message-ID: <20250725193319.GA3104836@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIM99vImO6kwAkO2@wunner.de>

[-> to: Rafael for possible ack]

On Fri, Jul 25, 2025 at 10:19:02AM +0200, Lukas Wunner wrote:
> On Tue, Jul 22, 2025 at 05:35:22PM -0500, Bjorn Helgaas wrote:
> > On Sun, Jul 13, 2025 at 04:31:00PM +0200, Lukas Wunner wrote:
> > >   PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
> > >   PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
> > >   PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
> > >   PCI: Move is_pciehp check out of pciehp_is_native()
> > >   PCI: Set native_pcie_hotplug up front based on pcie_ports_native
> > 
> > Thanks!  I applied these to pci/hotplug, hoping to put them in v6.17.
> > 
> > I moved the previous pci/hotplug branch to pci/hotplug-pnv_php.
> 
> Just a heads-up in case it's unintentional, pci/next as of 10 hours ago
> does not include the following pci.git branches:
> 
> - hotplug

Thanks for the reminder, I did miss it.  Rafael, would be glad for
your ack on this one if you have time:

  PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

Re this one:

  PCI: Set native_pcie_hotplug up front based on pcie_ports_native

I do see your concern about leaking pcie_ports_native into ACPI code.
Currently all uses are in drivers/pci/, so it would be nice to move
the declaration to drivers/pci/pci.h.

Here's the call path:

  acpi_pci_root_add
    negotiate_os_control                   # _OSC platform negotiation
    pci_acpi_scan_root
      acpi_pci_root_create
        pci_create_root_bus
          pci_init_host_bridge
            host_bridge->native_aer = 1    # Linux owns by default
        if (!OSC_PCI_EXPRESS_AER_CONTROL)
          host_bridge->native_aer = 0      # override, platform owns
        pci_scan_child_bus
          pci_scan_child_bus_extend

We could add some kind of "bridge->force_linux_ownership" bit in
struct pci_host_bridge (and we should probably mention this in dmesg
and maybe taint the kernel (is that still a thing?) because it's
definitely a potential conflict with platform firmware.

Then acpi_pci_root_create() could ignore the _OSC results if set.

Maybe I'll just defer this patch for now since it's a cleanup that
doesn't fix anything?  We can come back later and see if it makes
sense to extend this idea to bits other than native_pcie_hotplug.

Bjorn

