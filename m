Return-Path: <linux-pci+bounces-33000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B9B13651
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509323B9C78
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60922ACE3;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPbqGVUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB41D130E;
	Mon, 28 Jul 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691088; cv=none; b=HHcXgfUS5wYgMJwB75KSNM0qc0J/RslN9SBzTwlrJgbrhqNC9lFgIVMsEEHb/jpvFUVTwrGE6T394cfcFeBTYJamzTiuQv21IRhHQ1bSV+98x0t4ZAeAzsD+eISb3Ecl/EuKNHRADfQwzfIJyIlMl8/po2xu7lX/TlaRlaf5I/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691088; c=relaxed/simple;
	bh=70KOGQM7rvBCszhKf4LriShWhg0ckNYsP3a+tYWRZHI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IiJZU1kVIY8IDfqWGu069/R0dz4bOt9cZt70iIhRiDKUhiV4+2eqPUwoSYyOjuso+/yTsdjEnrrtvt9J+RKGfUx99PBa1/0HzrS1a/xTz0fG3hTc6vfjp97IfBSF0VreRce5diy+E7rTkPCdlr0up4b4QGDMI7dX1BJKqd7XVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPbqGVUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E72C4CEE7;
	Mon, 28 Jul 2025 08:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691087;
	bh=70KOGQM7rvBCszhKf4LriShWhg0ckNYsP3a+tYWRZHI=;
	h=From:Subject:Date:To:Cc:From;
	b=CPbqGVUgUqNX7BMWMqJWrMFokkkUqJJMn6QATUDUiE8XH334LQp8p+eP0Msl8U31z
	 0VSCfIQP+ZyvDXv7Ca/87qm3eMBldq69kd3OaigPEKGZrZSp0/YSLFPCwuiq7qYq6y
	 7JYtWPw+e8MZ6Z+yGRSlkkurJaqVeGpHlvFbpvejYBldVBPFmbTa2UjkkXryd8u8w/
	 pPtc1mIKmFpoNI6kXH4BEEWNDBWgBRSstwwwIQn0UTbueSeRkscp+Op4j39VfMLlPm
	 tmlSkBAF0FaAtrROuDki+vukZ7ofpZvYEBRiGP6izosPbHWlOrsVUWwHMPWEvdRCLD
	 0gfC8QzmJvF5A==
From: Chris Li <chrisl@kernel.org>
Subject: [RFC PATCH 00/25] Live Update Orchestrator: PCI subsystem
Date: Mon, 28 Jul 2025 01:24:30 -0700
Message-Id: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8zh2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyMT3ZzSfN2C5ExdQyNLQwtLgyRzQ4M0JaDqgqLUtMwKsEnRsbW1AN/
 zXS9ZAAAA
X-Change-ID: 20250724-luo-pci-1291890b710f
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

The LUO PCI subsystem is based on the LUO V2 series.
https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@soleen.com/

It registers the PCI as a LUO subsystem and forwards the liveupdate
callback to the device. The struct dev_liveupdate has been add to struct
device to keep track of the liveupdate related context.

A device can be marked as requested for liveupdate during the normal
state.

In the prepare() callback. The PCI core will build a list of the PCI device
for liveupdate based on the PCI device dependency:
1) The VF device is dependent on the PF device for SR-IOV function.
   The PF device needs to restore the number of VF.
2) The requested device is dependent on the PCI bridge it is on to preserve
   the bridge bus master. All the way to the root bridge. If the bus master
   has been disabled on the bridge, the DMA on the children devices will
   get impacted.

The list of liveupdate devices is used for prepare(), cancel(), freeze()
and finalized() callback.

The PCI subsystem will preserve the driver name for each liveupdate PCI
device and only probe that driver after kexec boot up.

It also saves the number of VF for the live updated PF device. The PF
driver will be responsible for restoring the number of VF.

Preserving the PCI device state during kexec boot up will need to change
the device probing logic significantly. After liveupdate kexec, the device
can't just be initialized as a fresh start any more. It needs to adopt the
already initialized state from the previous kernel.

Currently it is using pci_lu_adopt() function to detect if the device is
under liveupdate, then skip the device initialization write if needed.
That part of the code is pretty invasive and spread into many PCI device
initialization code paths. I am open to suggestion how it can be done
cleaner.

After kexec boot up, the PF device will probe before VF. Inside the PF
driver probe(), the PF driver will restore the number of VF and create the
VF device. Then the VF driver's probing will be called.

Disclaimer:
The data preservation format is not final. It currently uses C struct
directly. It does not deal with version change on the data format yet. I
do have some idea how to address the versioning of data layout. Those
will be outside the scope of this series.

Testing:
Testing was done with Intel diorite NVMe VF device 8086:1457. Bind the PF
with pci-lu-stub-pf driver and VF with pci-lu-stub driver.  The VF is mark
mark as requested
[  317.393914] pci-lu-stub 0000:09:00.0: Marking device as live update requested

Now perform luo prepare, the PCI subsystem builds the liveupdate device
list from the PCI root bridge. The PF device and PCI bridge will be mark
depended.
[  330.870750] pci-lu-stub 0000:09:00.0: PCI liveupdate: collect liveupdate device: [requested]
[  330.879214] pci_bus 0000:09: PCI liveupdate: collect liveupdate bus 0000:09
[  330.886219] pci-lu-stub-pf 0000:05:00.1: PCI liveupdate: collect liveupdate device: [depended]
[  330.894845] pci_bus 0000:05: PCI liveupdate: collect liveupdate bus 0000:05
[  330.901829] pcieport 0000:04:01.0: PCI liveupdate: collect liveupdate device: [depended]
[  330.909944] pci_bus 0000:04: PCI liveupdate: collect liveupdate bus 0000:04
[  330.916933] pci-lu-stub 0000:09:00.0: pci_lu_stub_prepare(): data: 0x1eaf1c000
[  330.924174] pci-lu-stub-pf 0000:05:00.1: pci_lu_stub_prepare(): data: 0x1a2abe000
[  330.931678] PCI liveupdate: prepare data[23654a000]
[  330.936587] luo_core: Switched from [normal] to [prepared] state

After kexec reboot. The liveupdate devices are probed and restores the live
update context.
[    3.628261] pci 0000:04:01.0: PCI liveupdate: liveupdate restore [depended] driver: pcieport data: [0] num_vfs: 0
[    4.769292] pci 0000:05:00.1: PCI liveupdate: liveupdate restore [depended] driver: pci-lu-stub-pf data: [1a2abe000] num_vfs: 4
[   16.811848] pci 0000:09:00.0: PCI liveupdate: liveupdate restore [requested] driver: pci-lu-stub data: [1eaf1c000] num_vfs: 0

Perform luo finish to convert from update state to normal state. The
reserved folio will be freed.
[  287.836486] PCI liveupdate: finish data[23654a000]
[  287.841309] pci-lu-stub-pf 0000:05:00.1: pci_lu_stub_finish(): data: 0x1a2abe000
[  287.848733] pci-lu-stub 0000:09:00.0: pci_lu_stub_finish(): data: 0x1eaf1c000
[  287.855897] luo_core: Switched from [updated] to [normal] state

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Chris Li (14):
      PCI/LUO: Register with Liveupdate Orchestrator
      PCI/LUO: Add struct dev_liveupdate
      PCI/LUO: Create requested liveupdate device list
      PCI/LUO: Forward prepare()/freeze()/cancel() callbacks to driver
      PCI/LUO: Restore state at PCI enumeration
      PCI/LUO: Forward finish callbacks to drivers
      PCI/LUO: Save and restore driver name
      PCI/LUO: Add liveupdate to pcieport driver
      PCI/LUO: Save SR-IOV number of VF
      PCI/LUO: Add pci_liveupdate_get_driver_data()
      PCI: pci-lu-stub: Add a stub driver for Live Update testing
      PCI/LUO: Track liveupdate buses
      PCI/LUO: Avoid write to liveupdate devices at boot
      PCI: pci-lu-pf-stub: Add a PF stub driver for Live Update testing

David Matlack (1):
      PCI/LUO: Clean up PCI_SER_GET()

Jason Miu (10):
      PCI/LUO: Save struct pci_dev info during prepare phase
      PCI/LUO: Check the device function numbers in restoration
      PCI/LUO: Restore power state of a PCI device
      PCI/LUO: Restore PM related fields
      PCI/LUO: Restore the pme_poll flag
      PCI/LUO: Restore the no_d3cold flag
      PCI/LUO: Restore pci_dev fields during probe
      PCI/LUO: Save and restore the PCI resource
      PCI/LUO: Save PCI bus and host bridge states
      PCI/LUO: Check the PCI bus state after restoration

 drivers/pci/Kconfig            |  10 +
 drivers/pci/Makefile           |   2 +
 drivers/pci/ats.c              |   7 +-
 drivers/pci/bus.c              |   5 +
 drivers/pci/iov.c              |  58 ++--
 drivers/pci/liveupdate.c       | 707 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c          |  32 +-
 drivers/pci/msi/pcidev_msi.c   |   4 +-
 drivers/pci/pci-acpi.c         |   3 +
 drivers/pci/pci-lu-stub.c      | 216 +++++++++++++
 drivers/pci/pci.c              | 105 ++++--
 drivers/pci/pci.h              |  70 ++++
 drivers/pci/pcie/aspm.c        |   7 +-
 drivers/pci/pcie/pme.c         |  11 +-
 drivers/pci/pcie/portdrv.c     |  13 +
 drivers/pci/probe.c            |  92 ++++--
 drivers/pci/setup-bus.c        |  10 +-
 include/linux/dev_liveupdate.h |  64 ++++
 include/linux/device.h         |  15 +
 include/linux/device/driver.h  |   6 +
 include/linux/pci.h            |   9 +
 21 files changed, 1352 insertions(+), 94 deletions(-)
---
base-commit: 57fb5d5e70ca837e0cf3e38c59112cce460b643d
change-id: 20250724-luo-pci-1291890b710f

Best regards,
-- 
Chris Li <chrisl@kernel.org>


