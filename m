Return-Path: <linux-pci+bounces-36223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58419B58F6E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74A2188B045
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFDE2EA74D;
	Tue, 16 Sep 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suKfwmjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9A2EA49E;
	Tue, 16 Sep 2025 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008715; cv=none; b=Q3IzgWtoOiQkeIYtcWEjwuVHXF5BcuDWXNZXtmfV9GVkDrCnukeBRBxx78G2ZeNrbY0CXd0H7ErpcDPcoUxBZLTcT4aCNnwQSiPkLgheoKOlDw19WRAly9AftTIJToRpzYfvWaDNtslW3jPao9As1VH0RMRPMKcudtNTvxY9cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008715; c=relaxed/simple;
	bh=pwEjBt1jf9S+XANK+UxpbBSM7ql6iH30zzsxmtEL7nQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tBCHhkCDEVd7uhycvr7AGSLgYxptrlAoLSzdZnxyXChWEahL3iaI4ZKwQbgqeUvVnesXHZ59rxwdjT2on2QVu4mzW1/JD4AqbeKcT7I3EyhCIMbP1+3YD9vtmkYwRkDDh0OCiUG83fxiHrsNwqIvfv1gA76Tjs+i/UyrVYXV4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suKfwmjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4D4C4CEEB;
	Tue, 16 Sep 2025 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008714;
	bh=pwEjBt1jf9S+XANK+UxpbBSM7ql6iH30zzsxmtEL7nQ=;
	h=From:Subject:Date:To:Cc:From;
	b=suKfwmjYOnyYNB36B2UwoQYbqoZ9295Iakl0/9kn6eQdBhDgP7JIZHusVpY+bzM71
	 FAr6oA+ediMEJPgjIsacfAJlzoxx5l7Y6XwDkfzB1Cto4cl2PN9DdwhyPVUkv7CdOf
	 Vs7x7+2CiOxDdMyxAqL8Wo+gUxowbCQPMB/podtv4nQ+cgQ/Tgfvs3v1otcaAs6Zi2
	 tElxQuBiiootAzIpncEKmRGpTPScGUCn/KSQIGNcidiGr9wc1hzKHHHGawbUVtb9i0
	 OKJtC8s3je7LJ0Cm8PmHtr4undwLkck18K2/eK8BAXXHxHBUEbWkcUe99b6jE6RmpA
	 RuwpRsKQxLqqA==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
Date: Tue, 16 Sep 2025 00:45:08 -0700
Message-Id: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQVyWgC/z3MQQ7CIBCF4as0sxYDKAKuvIfpwpZpO7GBBpRoG
 u4uNtHl//LyrZAwEiY4NytEzJQo+Bpy10A/3fyIjFxtkFwqruWRzc/Alp6YkFYYyzst+AD1vUQ
 c6LVJ17b2ROkR4nuDs/iuP8P8jSwYZ1apjmvj3EkdLneMHud9iCO0pZQPHS/zup8AAAA=
X-Change-ID: 20250724-luo-pci-1291890b710f
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

This is phase I of the LUO PCI series. It does the minimal set of PCI
device liveupdate which is preserving a bus master bit in the PCI command
register.

The LUO PCI subsystem is based on the LUO V2 series.
https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@soleen.com/

It registers the PCI as a LUO subsystem and forwards the liveupdate
callback to the device. The struct dev_liveupdate has been add to struct
device to keep track of the liveupdate related context.

A device can be marked as requested for liveupdate during the normal
state.

In the prepare() callback. The PCI core will build a list of the PCI device
for liveupdate based on the PCI device dependency:
1) The requested device is dependent on the PCI bridge it is on to preserve
   the bridge bus master. All the way to the root bridge. If the bus master
   has been disabled on the bridge, the DMA on the children devices will
   get impacted.

The list of liveupdate devices is used for prepare(), cancel(), freeze()
and finalized() callback.

The PCI subsystem will preserve the driver name for each liveupdate PCI
device and only probe that driver after kexec boot up.

Disclaimer:
The data preservation format is not final. It currently uses C struct
directly. It does not deal with version change on the data format yet. I
do have some idea how to address the versioning of data layout. Those
will be outside the scope of this series.

Testing:
Testing was done with Intel diorite NVMe VF device 8086:1457. Bind the
test device with pci-lu-stub driver.

0000:05:00.1 current driver is
0000:05:00.1 bind new driver pci-lu-stub
[  557.006998] pci-lu-stub 0000:05:00.1: Marking device liveupdate busmaster

Now perform luo prepare, the PCI subsystem builds the liveupdate device
list from the PCI root bridge. The test device will have LU_BUSMASTER
and the PCI bridge will have LU_BUSMASTER_BRIDGE.

[  701.573423] pci-lu-stub 0000:05:00.1: PCI liveupdate: collect liveupdate device: flags 1
[  701.582430] pcieport 0000:04:01.0: PCI liveupdate: collect liveupdate device: flags 2
[  701.590297] pci-lu-stub 0000:05:00.1: pci_lu_stub_prepare(): data: 0x1ac6f4000
[  701.598916] PCI liveupdate: prepare data[1f1d28000]
[  701.603832] luo_core: Switched from [normal] to [prepared] state

After kexec reboot. The liveupdate devices are probed and restores the live
update context.
[    3.622083] pci 0000:04:01.0: PCI liveupdate: liveupdate restore flags 2 driver: pcieport data: [0]
[    4.768060] pci 0000:05:00.1: PCI liveupdate: liveupdate restore flags 1 driver: pci-lu-stub data: [1ac6f4000]

Perform luo finish to convert from update state to normal state. The
reserved folio will be freed.

[  310.359830] PCI liveupdate: finish data[1f1d28000]
[  310.364664] pci-lu-stub 0000:05:00.1: pci_lu_stub_finish(): data: 0x1ac6f4000
[  310.371824] luo_core: Switched from [updated] to [normal] state

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v2:
- reduce the scope of the series to phase I. Only preserve the bus
  master bit.
- Use finer grain flags to specify which liveupdate feature gets
  preserved.
- Modify the pci-lu-stub driver to set the bus master bit before
  requesting preserving the bus master.
- Add WARN_ON() for the PCI device has LU_BUSMASTER but the bus master
  bit is not set.
- Link to v1: https://lore.kernel.org/r/20250728-luo-pci-v1-0-955b078dd653@kernel.org

---
Chris Li (10):
      PCI/LUO: Register with Liveupdate Orchestrator
      PCI/LUO: Create requested liveupdate device list
      PCI/LUO: Forward prepare()/freeze()/cancel() callbacks to driver
      PCI/LUO: Restore state at PCI enumeration
      PCI/LUO: Forward finish callbacks to drivers
      PCI/LUO: Save and restore driver name
      PCI/LUO: Add liveupdate to pcieport driver
      PCI/LUO: Add pci_liveupdate_get_driver_data()
      PCI/LUO: Avoid write to bus master at boot
      PCI: pci-lu-stub: Add a stub driver for Live Update testing

 MAINTAINERS                    |   4 +
 drivers/pci/Kconfig            |  10 +
 drivers/pci/Makefile           |   2 +
 drivers/pci/liveupdate.c       | 450 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-lu-stub.c      | 140 +++++++++++++
 drivers/pci/pci.c              |   7 +-
 drivers/pci/pci.h              |   8 +
 drivers/pci/pcie/portdrv.c     |  13 ++
 drivers/pci/probe.c            |   8 +-
 include/linux/dev_liveupdate.h |  69 +++++++
 include/linux/device.h         |  15 ++
 include/linux/device/driver.h  |   6 +
 include/linux/pci.h            |   9 +
 13 files changed, 738 insertions(+), 3 deletions(-)
---
base-commit: 9ab803064e3d1be9673d2829785a69fd0578b24e
change-id: 20250724-luo-pci-1291890b710f

Best regards,
-- 
Chris Li <chrisl@kernel.org>


