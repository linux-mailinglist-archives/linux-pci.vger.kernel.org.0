Return-Path: <linux-pci+bounces-18829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B149F8AB6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B774E1889FF0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3010282F1;
	Fri, 20 Dec 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBtPJhX5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8352594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666859; cv=none; b=iChPj+KqyaYdooTjuXwFlaQrl0IPLmlJVYdxjtg6LCVy4XoDWmi8brTTy5M02l9kxXbkXPwGVCSRiVvN8lRRm+xK6QTTCbkqnkHZZEhoigVbHZRZv9cva8NkXbgo6rueRmpnUw8bL4blqZSjv2UWJKUMRugBix+4cPjEUXwvZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666859; c=relaxed/simple;
	bh=3XfOdXb9purAB669Cs/TKcEgvnXcnYTaYY5I683QHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLuXjChCQw68YPoWx0U491yvP3hw6gs53XLIQL1V/sJbG/44yKd5DY9hlhX7UrBNGzj+yVbia/mBqWIhdmK08L6u+FRSTukBW4+xG0L9WCrV78yu+n+ucByb6rbPbAio5NoJOVmbZAivWB51Z+0WaSqaXbbaYmyFyBr+bZD+oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBtPJhX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF22C4CECD;
	Fri, 20 Dec 2024 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666857;
	bh=3XfOdXb9purAB669Cs/TKcEgvnXcnYTaYY5I683QHWs=;
	h=From:To:Cc:Subject:Date:From;
	b=ZBtPJhX5o7B0D/YlklBOYSK8gAiXLUSHMh7K1ZJvaUDWETRVk2MDJTQlk+zwLDxYD
	 JQBQr+5SyOb/K4cATw0iIk9080gln2A++OIfu3AdjCqaz8W/Pj5GqI6wpPTGMhhCAo
	 uyCEmgC2fEkKoSQlT3fnA2cqC3L1SIRsu8p4n5KWlULNS4yTYnbMganFKeHiX40yIy
	 CJQ1BqA8n+8Nb6UHMbRmbOYY1sgKXnSsU5oYwL6UhrkpZeAOkr+iMhraZJsVVcH3S/
	 fWok1P8HOaUkHShChnumHikWBCuX/RXBqG43qSWgHSrajE2bjIYbDkGEg7TswrTd9N
	 +9rT09zDr+whA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 00/18] NVMe PCI endpoint target driver
Date: Fri, 20 Dec 2024 12:54:23 +0900
Message-ID: <20241220035441.600193-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements an NVMe target driver for the PCI transport
using the PCI endpoint framework.

The first 5 patches of this series move and cleanup some nvme code that
will be reused in following patches.

Patch 6 introduces the PCI transport type to allow setting up ports for
the new PCI target controller driver. Patch 7 to 10 are improvements of
the target core code to allow creating the PCI controller and processing
its nvme commands without the need to rely on fabrics commands like the
connect command to create the admin and I/O queues.

Patch 11 relaxes the SGL check in nvmet_req_init() to allow for PCI
admin commands (which must use PRPs).

Patches 12 to 16 improve the set/get feature support of the target code
to get closer to achieving NVMe specification compliance. These patches
though do not implement support for some mandatory features.

Patch 17 is the main patch which introduces the NVMe PCI endpoint target
driver. This patch commit message provides and overview of the driver
design and operation.

Finally, patch 18 documents the NVMe PCI endpoint target driver and
provides a user guide explaning how to setup an NVMe PCI endpoint
device.

The patches are base on Linus 6.13-rc3 tree.

This driver has been extensively tested using a Radxa Rock5B board
(RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
board. However, this board does not support DMA channels for the PCI
endpoint controller, leading to very poor performance.

Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
with a null-blk block device loop target, performance was measured using
fio as follows:

 +----------------------------------+------------------------+
 | Workload                         | IOPS (BW)              |
 +----------------------------------+------------------------+
 | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
 | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
 | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
 | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
 | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
 | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
 | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
 | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
 | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
 +----------------------------------+------------------------+

These results use the default MDTS of the NVMe enpoint driver of 512 KB.

This driver is not intended for production use but rather to be a
playground for learning NVMe and exploring/testing new NVMe features
while providing reasonably good performance.

Changes from v5:
 - Rebased on 6.13-rc3
 - Addressed most of Mani's comment on patch 17:
   - Renaming of functions and data structures
   - Error messages format
   - Removed dma_enable configfs knob and simplified DMA initialization
     and cleanup.
   - Simplified some error path
   - Fixed up handling of icontrollers with a fixed bar 0 size
   Of note is that I did not define macros for the bits of the CAP
   register as that would be too much for now since we want to do this
   correctly in include/linux/nvme.h by defining all of them, and by
   using these definitions in the nvme host and target code. This can be
   done in a followup patch series once this is applied.
 - Fixed the command examples in patch 18

Changes from v4:
 - Fixed typos in patch 13 and 17 commit message
 - Addressed Bjorn's comments (typos and text clarity) in patch 18.
 - Added Bjorn's Acked-by tag to patch 18

Changes from v3:
 - Added patch 1 which was missing from v3 and caused the 0day build
   failure
 - Corrected a few typos in the documentation (patch 18)
 - Added Christoph's review tag and Rick's tested tag

Changes from v2:
 - Changed all preparatory patches before patch 16 to move more NVMe
   generic code out of the PCI endpoint target driver and into the
   target core.
 - Changed patch 16 to use directly a target controller instead of a
   host controller. Many aspects of the command management and DMA
   transfer management have also been simplified, leading to higher
   performance.
 - Change the documentation patch to match the above changes

Changes from v1:
 - Added review tag to patch 1
 - Modified patch 4 to:
   - Add Rick's copyright notice
   - Improve admin command handling (set_features command) to handle the
     number of queues feature (among others) to enable Windows host
   - Improved SQ and CQ work items handling

Damien Le Moal (18):
  nvme: Move opcode string helper functions declarations
  nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
  nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
  nvmet: Introduce nvmet_get_cmd_effects_admin()
  nvmet: Add drvdata field to struct nvmet_ctrl
  nvme: Add PCI transport type
  nvmet: Improve nvmet_alloc_ctrl() interface and implementation
  nvmet: Introduce nvmet_req_transfer_len()
  nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
  nvmet: Add support for I/O queue management admin commands
  nvmet: Do not require SGL for PCI target controller commands
  nvmet: Introduce get/set_feature controller operations
  nvmet: Implement host identifier set feature support
  nvmet: Implement interrupt coalescing feature support
  nvmet: Implement interrupt config feature support
  nvmet: Implement arbitration feature support
  nvmet: New NVMe PCI endpoint function target driver
  Documentation: Document the NVMe PCI endpoint target driver

 Documentation/PCI/endpoint/index.rst          |    1 +
 .../PCI/endpoint/pci-nvme-function.rst        |   13 +
 Documentation/nvme/index.rst                  |   12 +
 .../nvme/nvme-pci-endpoint-target.rst         |  368 +++
 Documentation/subsystem-apis.rst              |    1 +
 drivers/nvme/host/nvme.h                      |   39 -
 drivers/nvme/target/Kconfig                   |   10 +
 drivers/nvme/target/Makefile                  |    2 +
 drivers/nvme/target/admin-cmd.c               |  388 ++-
 drivers/nvme/target/configfs.c                |   49 +
 drivers/nvme/target/core.c                    |  266 +-
 drivers/nvme/target/discovery.c               |   17 +
 drivers/nvme/target/fabrics-cmd-auth.c        |   14 +-
 drivers/nvme/target/fabrics-cmd.c             |  101 +-
 drivers/nvme/target/nvmet.h                   |  110 +-
 drivers/nvme/target/pci-epf.c                 | 2598 +++++++++++++++++
 include/linux/nvme.h                          |   42 +
 17 files changed, 3871 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 create mode 100644 drivers/nvme/target/pci-epf.c

base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.1


