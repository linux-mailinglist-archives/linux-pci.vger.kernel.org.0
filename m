Return-Path: <linux-pci+bounces-29570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75AAD7879
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E4188B63B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972EC4690;
	Thu, 12 Jun 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYnZYbBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C210E5
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746903; cv=none; b=uUye4+eRXiNImJ6Sz1+/0wJ9GdlrsLBfjGWl1H9O64rqkvfP8Dej7tq1lpliX4rhDRo4+xYFK7q7V+h5l9zo30ctGHChjnsyAy6sIGyclDvOIxom4/amgYZiIWbBHP10ErSlN2ZQ/+0C0oOXkfpwVw/PbxMUP2TzLcbbIVEUWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746903; c=relaxed/simple;
	bh=MKFtlH+DNj7Mt4xdBU9hVZyLVXYpS47EakHUm67hZVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b/i60SjYDl1vlMrD7WzCTNjSX2tsMK/kE5KKv9BkRUek0qlZekzh/mB4x8Dmmqq7aOcCyG2hW3Fg//e+uK19LToABZfvYpa1LQO+RESqvbhZ2EU9yLw1AFgjX0wK6K+h8ejPAtiBp98siR0E6yfZtf+6qDDNvSceSfTyxWHGs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYnZYbBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A98C4CEEA;
	Thu, 12 Jun 2025 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749746902;
	bh=MKFtlH+DNj7Mt4xdBU9hVZyLVXYpS47EakHUm67hZVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aYnZYbBr0udYvD4rf1rktl27wkbIbveswII8sA8nbZ+9A7b7e/CALHqaenQK0wCNN
	 H1r2DRIB87Q04rTROTMH7mSIh8fTb4HvIh6aGlVspYL/dhUVXXv0xq/3DKeYvsOKwd
	 3jaCYhJ5FyrHZl01fGXhQod6pYtPPfsZODhVONfjIvTb7URl0dOm1RBzH96xzL8xPL
	 UiQXcSQCQRyQoBh8x32wRw9avX5675jWTwz1yX3ZZ0j92GM9mJXujXqgUv1yqwpURi
	 KgzbWUZZrBEbO8Hs9i2vVeTBTn4hkgt6FbdyBlXft5qApxg+EP1mxOfyDNHfih9Btu
	 ginZ5Y3i7lbIw==
Date: Thu, 12 Jun 2025 11:48:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250612164821.GA870964@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611101442.387378-1-hui.wang@canonical.com>

[+cc VMD folks]

On Wed, Jun 11, 2025 at 06:14:42PM +0800, Hui Wang wrote:
> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
> Configuration RRS"), this Intel nvme [8086:0a54] works well. Since
> that patch is merged to the kernel, this nvme stops working.
> 
> Through debugging, we found that commit introduces the RRS polling in
> the pci_dev_wait(), for this nvme, when polling the PCI_VENDOR_ID, it
> will return ~0 if the config access is not ready yet, but the polling
> expects a return value of 0x0001 or a valid vendor_id, so the RRS
> polling doesn't work for this nvme.

Sorry for breaking this, and thanks for all your work in debugging
this!  Issues like this are really hard to track down.

I would think we would have heard about this earlier if the NVMe
device were broken on all systems.  Maybe there's some connection with
VMD?  From the non-working dmesg log in your bug report
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/+attachment/5879970/+files/dmesg-60.txt):

  DMI: ASUSTeK COMPUTER INC. ESC8000 G4/Z11PG-D24 Series, BIOS 5501 04/17/2019
  vmd 0000:d7:05.5: PCI host bridge to bus 10000:00
  pci 10000:00:02.0: [8086:2032] type 01 class 0x060400 PCIe Root Port
  pci 10000:00:02.0: PCI bridge to [bus 01]
  pci 10000:00:02.0: bridge window [mem 0xf8000000-0xf81fffff]: assigned
  pci 10000:01:00.0: [8086:0a54] type 00 class 0x010802 PCIe Endpoint
  pci 10000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]

  <I think vmd_enable_domain() calls pci_reset_bus() here>

  pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
  pci 10000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
  pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
  pci 10000:01:00.0: BAR 0: error updating (0xf8010004 != 0xffffffff)
  nvme nvme0: pci function 10000:01:00.0
  nvme 10000:01:00.0: enabling device (0000 -> 0002)

Things I notice:

  - The 10000:01:00.0 NVMe device is behind a VMD bridge

  - We successfully read the Vendor & Device IDs (8086:0a54)

  - The NVMe device is uninitialized.  We successfully sized the BAR,
    which included successful config reads and writes.  The BAR
    wasn't assigned by BIOS, which is normal since it's behind VMD.

  - We allocated space for BAR 0 but the config writes to program the
    BAR failed.  The read back from the BAR was 0xffffffff; probably a
    PCIe error, e.g., the NVMe device didn't respond.

  - The device *did* respond when nvme_probe() enabled it: the
    "enabling device (0000 -> 0002)" means pci_enable_resources() read
    PCI_COMMAND and got 0x0000.

  - The dmesg from the working config doesn't include the "enabling
    device" line, which suggests that pci_enable_resources() saw
    PCI_COMMAND_MEMORY (0x0002) already set and didn't bother setting
    it again.  I don't know why it would already be set.
   
d591f6804e7e really only changes pci_dev_wait(), which is used after
device resets.  I think vmd_enable_domain() resets the VMD Root Ports
after pci_scan_child_bus(), and maybe we're not waiting long enough
afterwards.

My guess is that we got the ~0 because we did a config read too soon
after reset and the device didn't respond.  The Root Port would time
out, log an error, and synthesize ~0 data to complete the CPU read
(see PCIe r6.0, sec 2.3.2 implementation note).

It's *possible* that we waited long enough but the NVMe device is
broken and didn't respond when it should have, but my money is on a
software defect.

There are a few pci_dbg() calls about these delays; can you set
CONFIG_DYNAMIC_DEBUG=y and boot with dyndbg="file drivers/pci/* +p" to
collect that output?  Please also collect the "sudo lspci -vv" output
from a working system.

Bjorn

