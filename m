Return-Path: <linux-pci+bounces-18420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09449F1CE5
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311D9188E1C0
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7A78C6D;
	Sat, 14 Dec 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfCnergt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0D27450
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156436; cv=none; b=KpTMu8i/WGtz3supkCWZ1RJKXJbFNXIqfKmwVcqI9T84XBd8o7KEUTDXVhpP90MtMWc2PIhj0L0/0+47lKJvmuDM7ZvpdrcZqtD2KWKF4ysKzoEsw/i5CTRDvcd2ph5n3CbhwnLuDo74I5QOS1dDx+1nDHK7lCTbZPuv7o34Iv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156436; c=relaxed/simple;
	bh=49CwzSNu6sFXO2IVYjDE+NCOhiCSdtNYFnzSt9W0yg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WS3HmmfdV8bYIqf8fQPzqceO6cnCOZZy9TQepYPD90IBM1q30CyB4eGbjkoSVH5IQT8JkFCUq1DVWCuff34VzVONsqTZY45RUwzooxjU5ZX5gIEOXcNmyBCUtYI+7YGcsmHmJ7cFEvs9wS32zetSEhzlEU12Qg+93HtHI0kyLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfCnergt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F19CC4CED1;
	Sat, 14 Dec 2024 06:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156436;
	bh=49CwzSNu6sFXO2IVYjDE+NCOhiCSdtNYFnzSt9W0yg4=;
	h=From:To:Cc:Subject:Date:From;
	b=WfCnergtp/DJMjTUUjaX29JV1KAjpLFsQ5KL9tKj3rHvgo3TN8hONzZXtbIHAYS83
	 fbZEr1OVuXGedrMIUHqJeVbL9FVmKvsRxfFDBzE5ffW6d2G2ORt4qmzjTAFKCn4lpb
	 XqfQsKtX1foxXiYHBm+xCwQNePFuadmYNPQx+VfKM6wxjnegEU8fqIaHBN3c4kwD4M
	 lYiGqwYmnJKF7PIbaZ0EYzK6xcmkLMX+yGmrmPX+ZJSC3rnIDNlBEbgz/TmMsrdxOR
	 gLfo4Y9KnnzZql7mjrQwhlz/1Qk9OZ23R9188DxEq88+TTPeYZYXbPerROQ+CNopeQ
	 2842ttbMkBMFQ==
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
Subject: [PATCH v5 00/18] NVMe PCI endpoint target driver
Date: Sat, 14 Dec 2024 15:06:37 +0900
Message-ID: <20241214060655.166325-1-dlemoal@kernel.org>
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

The first 4 patches of this series move and cleanup some nvme code that
will be reused in following patches.

Patch 5 introduces the PCI transport type to allow setting up ports for
the new PCI target controller driver. Patch 6 to 9 are improvements of
the target core code to allow creating the PCI controller and processing
its nvme commands without the need to rely on fabrics commands like the
connect command to create the admin and I/O queues.

Patch 10 relaxes the SGL check in nvmet_req_init() to allow for PCI
admin commands (which must use PRPs).

Patches 11 to 15 improve the set/get feature support of the target code
to get closer to achieving NVMe specification compliance. These patches
though do not implement support for some mandatory features.

Patch 16 is the main patch which introduces the NVMe PCI endpoint target
driver. This patch commit message provides and overview of the driver
design and operation.

Finally, patch 17 documents the NVMe PCI endpoint target driver and
provides a user guide explaning how to setup an NVMe PCI endpoint
device.

The patches are base on Linus 6.13-rc2 tree.

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
  nvmet: New NVMe PCI endpoint target driver
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
 drivers/nvme/target/pci-ep.c                  | 2626 +++++++++++++++++
 include/linux/nvme.h                          |   42 +
 17 files changed, 3899 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 create mode 100644 drivers/nvme/target/pci-ep.c


base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
-- 
2.47.1


