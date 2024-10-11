Return-Path: <linux-pci+bounces-14307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F418699A3BA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EB1C22700
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3441BDAA1;
	Fri, 11 Oct 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1I0FREg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9D802
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649195; cv=none; b=Yu9dYuVpkhu7ZucjdVaqwqsp5a0kPLcUqT1dFQN46ERazQSu7VsvzcNYkoUpwMG0gbDbcLv1ot6xaAt06MsaQWSWIegVZe9YTYQu3xMd7g9Tlq+kaZWskS3F01Shz3UW6LN0jpZQNm/l/LhzpG1M+pQdmFEJs5YJnf4+bW/XMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649195; c=relaxed/simple;
	bh=tiGAxM+Issad/Urtbnk+tdJ6+VWqn04wmRMnT8WzUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMPvcZg0Bd9awnfaNO08jKqC1u2WsyI9v+5wFqVTfFFXbTxUC21OK30+W+aEoDk/URgDDZ6RoVFav7bhtO/AWlbRUgLQfKIXcySQMwml3/4An8SPenxSe9CB6SszuGPlRhrL83G8l8z/5I3IQ8n68IKU53DMwVwb0CPOBSo9vN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1I0FREg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03645C4CEC3;
	Fri, 11 Oct 2024 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649194;
	bh=tiGAxM+Issad/Urtbnk+tdJ6+VWqn04wmRMnT8WzUvw=;
	h=From:To:Cc:Subject:Date:From;
	b=A1I0FREgoJbJAQgSiY7dT7v6om4XFd0k+7qmcyAHgzMrPa8uZG63sXqK71yv23AUY
	 PtE0YiaD1t57Pt244lRx5oIUyS7yfY34dFm9i2AgGSWEZSyPPLkZPBChqrPUvFy3Ir
	 n4q7hE7sLHpMTpu8fYk/T5nh2lZASTC4AlticzfEgaxujtSVlOUis+SX7C/Tdii/ab
	 7VqjS5RHSag7pMUt3pCo5mt4+J9uWD4A2NY9Oaqnkei1oLxqyawveAqq4RInl7oOL9
	 CGFZheGtQXw0CsUvyd+V8dh9XPaV0rrkfYe8IRkIOA6RJza8y1lg/eKQAJkhFaLHa1
	 PdmOuciFlCo6Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/5] NVMe PCI endpoint function driver
Date: Fri, 11 Oct 2024 21:19:46 +0900
Message-ID: <20241011121951.90019-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements an NVMe PCI endpoint driver that implements
a PCIe NVMe controller for a local NVMe fabrics host controller.
This series is based on the improved PCI endpoint API patches "Improve
PCI memory mapping API" (see [1]).

The first 3 patches of this series are changes to the NVMe target and
fabrics code to facilitate reusing the NVMe code and an NVMe host
controller from other (non NVMe) drivers.

Patch 4 is the main patch which introduces the NVMe PCI endpoint driver.
This patch commit message provides and overview of the driver design and
operation.

Finally, patch 5 adds documentation files to document the NVMe PCI
endpoint function driver internals, provide a user guide explaning how
to setup an NVMe PCI endpoint device and describe the NVMe endpoint
function driver binding attributes.

This driver has been extensively tested using a Radxa Rock5B board
(rk3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
board (however, this board does not support PCI DMA, leading to very
poor performance).

Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
with a null-blk block device loop target, performance was measured
using fio as follows:                                      

 +----------------------------------+------------------------+
 | Workload                         | IOPS (BW)              |
 +----------------------------------+------------------------+
 | Rand read, 4KB, QD=1, 1 job      | 7382 IOPS              |
 | Rand read, 4KB, QD=32, 1 job     | 45.5k IOPS             |
 | Rand read, 4KB, QD=32, 4 jobs    | 49.7k IOPS             |
 | Rand read, 128KB, QD=32, 1 job   | 10.0k IOPS (1.31 GB/s) |
 | Rand read, 128KB, QD=32, 4 jobs  | 10.2k IOPS (1.33 GB/s) |
 | Seq read, 128KB, QD=32, 1 job    | 1.28 GB/s              |
 | Seq read, 512KB, QD=32, 1 job    | 1.28 GB/s              |
 | Rand write, 128KB, QD=32, 1 job  | 8713 IOPS (1.14 GB/s)  |
 | Rand write, 128KB, QD=32, 4 jobs | 8103 IOPS (1.06 GB/s)  |
 | Seq write, 128KB, QD=32, 1 job   | 8557 IOPS (1.12 GB/s)  |
 | Seq write, 512KB, QD=32, 1 job   | 2069 IOPS (1.08 GB/s)  |
 +----------------------------------+------------------------+

These results use the default MDTS of the NVMe enpoint driver of 128 KB.
Setting the NVMe endpoint device with a larger MDTS of 512 KB leads to
improved maximum throughput of up to 2.4 GB/s (e.g. for the 512K random
read workloads and sequential read workloads). The maximum IOPS achieved
with this larger MDTS does not change significantly.

This driver is not intended for production use but rather to be a
playground for learning NVMe and NVMe over fabrics and exploring/testing
new NVMe features while providing reasonably good performance.

[1] https://lore.kernel.org/linux-pci/20241007040319.157412-1-dlemoal@kernel.org/T/#t

Changes from v1:
 - Added review tag to patch 1
 - Modified patch 4 to:
   - Add Rick's copyright notice
   - Improve admin command handling (set_features command) to handle the
     number of queues feature (among others) to enable Windows host
   - Improved SQ and CQ work items handling

Damien Le Moal (5):
  nvmet: rename and move nvmet_get_log_page_len()
  nvmef: export nvmef_create_ctrl()
  nvmef: Introduce the NVME_OPT_HIDDEN_NS option
  PCI: endpoint: Add NVMe endpoint function driver
  PCI: endpoint: Document the NVMe endpoint function driver

 .../endpoint/function/binding/pci-nvme.rst    |   34 +
 Documentation/PCI/endpoint/index.rst          |    3 +
 .../PCI/endpoint/pci-nvme-function.rst        |  151 +
 Documentation/PCI/endpoint/pci-nvme-howto.rst |  189 ++
 MAINTAINERS                                   |    9 +
 drivers/nvme/host/core.c                      |   17 +-
 drivers/nvme/host/fabrics.c                   |   11 +-
 drivers/nvme/host/fabrics.h                   |    5 +
 drivers/nvme/target/admin-cmd.c               |   20 +-
 drivers/nvme/target/discovery.c               |    4 +-
 drivers/nvme/target/nvmet.h                   |    3 -
 drivers/pci/endpoint/functions/Kconfig        |    9 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-nvme.c | 2591 +++++++++++++++++
 include/linux/nvme.h                          |   19 +
 15 files changed, 3036 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-nvme.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c

-- 
2.47.0


