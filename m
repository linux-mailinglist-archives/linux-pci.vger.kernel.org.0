Return-Path: <linux-pci+bounces-7554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53558C73CC
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3692CB224EA
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5514374A;
	Thu, 16 May 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goFwxHSE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0D182AF;
	Thu, 16 May 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851977; cv=none; b=UOcfCfqXnh2G+zSfs9sYPMIkd4inOG4U+wIKyx+fMnHINvPFE4zjMkEG3k9tDODcUvuzYHLTo9BEkcgQ6SK2MkJ5AiTNLZziNTctcjf6I2gtMztzV3QRCmlCzTwWpuCanmm768BTgDrl12ELGMhxUqKb2CWATh9e75MNPzDOVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851977; c=relaxed/simple;
	bh=d5PGVl/4+7COvjJ+kTfGHKzfNeCWoSFOzK3iWfPyVnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WFSHwrQXtce6WgIxdKMJXqwVgfysI5zBPw1qiZGlOWFm1ksUK3AlY/6sHWESifvuNN8puAE2fMVIuTtuNy1IrivE4TitN5DWzFZVip3NnrylKQivzuWdZlQevxRSGJTuRRGaobxgglwgg1jL4HLDYheBdhN7LWmWw2TDhja2MQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goFwxHSE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715851976; x=1747387976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d5PGVl/4+7COvjJ+kTfGHKzfNeCWoSFOzK3iWfPyVnI=;
  b=goFwxHSE37YfGhYHYdyxjD7D/TIiHjnbIYiy/qS7dmyMoxvlIYgcAt5G
   YqTcs74BFg1HMk68qEutHyvs4NGHmme6zyZEAOzqFKJa0GUW45kpUVScj
   wsz7cSu7tvMk3EqJhSFumagvy4GTjmgRs4Z3VpQZ6lEHJRnH1rKQn6hzC
   Pf5aVs9lv4kHBU1+F/PHyNX8nPRKN88Hg5ihEx+0MYhs3y5oXNZ8L7ovP
   qs9tXUOiiQPGN8LxBsPaKOPTuWZEN2OlN8PCmJsHIr0TJHXQmLaTT5yIE
   IX/VV2aeR0ah6Ej2qim5r/3qszpjlzgNrVprTPTY1aONGnbsHNRkCIALa
   A==;
X-CSE-ConnectionGUID: dxdUr94HSHGbH6rsloAM0w==
X-CSE-MsgGUID: pBF/j1jWTdS9//6YWrKnDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12113815"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12113815"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:32:55 -0700
X-CSE-ConnectionGUID: vNnF7sP0TbS+8pwe0hgnOg==
X-CSE-MsgGUID: YcpdELeARZav5i9jI4Kr7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31490993"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:32:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 0/8] PCI: Add PCIe bandwidth controller
Date: Thu, 16 May 2024 12:32:14 +0300
Message-Id: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
cooling driver to the thermal core side for limiting PCIe Link Speed
due to thermal reasons. PCIe bandwidth controller is a PCI express bus
port service driver. A cooling device is created for each port the
service driver finds if they support changing speeds.

This series only adds support for controlling PCIe Link Speed.
Controlling PCIe Link Width might also be useful but AFAIK, there is no
mechanism for that until PCIe 6.0 (L0p) so Link Width throttling is not
added by this series.

bwctrl is built on top of BW notifications revert. The changes are
based on top of target quirk fixes [1].

[1] https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/

v6:
- Removed unnecessary PCI_EXP_LNKCAP_SLS mask from PCIE_LNKCAP_SLS2SPEED()
- Split error handling in pcie_bwnotif_irq_thread()
- pci_info() -> pci_dbg() on bwctrl probe success path
- Handle cooling device pointer -Exx codes in bwctrl probe
- Reorder port->link_bwctrl setup / bwnotif enable for symmetry
- Handle LBMS count == 0 in PCIe quirk by checking LBMS (avoids a race
  between quirk and bwctrl)
- Use cleanup.h in PCIe cooling device's register

v5:
- Removed patches: LNKCTL2 RMW driver patches went in separately
- Refactor pcie_update_link_speed() to read LNKSTA + add __ variant
  for hotplug that has LNKSTA value at hand
- Make series fully compatible with the Target Speed quirk
        - LBMS counter added, quirk falls back to LBMS bit when bwctrl =n
        - Separate LBMS patch from set target speed patches
- Always provide pcie_bwctrl_change_speed() even if bwctrl =n so drivers
  don't need to come up their own version (also required by the Target
  Speed quirk)
- Remove devm_* (based on Lukas' comment on some other service
  driver patch)
- Convert to use cleanup.h
- Renamed functions/struct to have shorter names

v4:
- Merge Port's and Endpoint's Supported Link Speeds Vectors into
  supported_speeds in the struct pci_bus
- Reuse pcie_get_speed_cap()'s code for pcie_get_supported_speeds()
- Setup supported_speeds with PCI_EXP_LNKCAP2_SLS_2_5GB when no
  Endpoint exists
- Squash revert + add bwctrl patches into one
- Change to use threaded IRQ + IRQF_ONESHOT
- Enable also LABIE / LABS
- Convert Link Speed selection to use bit logic instead of loop
- Allocate before requesting IRQ during probe
- Use devm_*()
- Use u8 for speed_conv array instead of u16
- Removed READ_ONCE()
- Improve changelogs, comments, and Kconfig
- Name functions slightly more consistently
- Use bullet list for RMW protected registers in docs

v3:
- Correct hfi1 shortlog prefix
- Improve error prints in hfi1
- Add L: linux-pci to the MAINTAINERS entry

v2:
- Adds LNKCTL2 to RMW safe list in Documentation/PCI/pciebus-howto.rst
- Renamed cooling devices from PCIe_Port_* to PCIe_Port_Link_Speed_* in
  order to plan for possibility of adding Link Width cooling devices
  later on
- Moved struct thermal_cooling_device declaration to the correct patch
- Small tweaks to Kconfig texts
- Series rebased to resolve conflict (in the selftest list)

Ilpo Järvinen (8):
  PCI: Protect Link Control 2 Register with RMW locking
  PCI: Store all PCIe Supported Link Speeds
  PCI: Refactor pcie_update_link_speed()
  PCI/quirks: Abstract LBMS seen check into own function
  PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
  PCI/bwctrl: Add API to set PCIe Link Speed
  thermal: Add PCIe cooling driver
  selftests/pcie_bwctrl: Create selftests

 Documentation/PCI/pciebus-howto.rst           |  14 +-
 MAINTAINERS                                   |   9 +
 drivers/pci/hotplug/pciehp_hpc.c              |   2 +-
 drivers/pci/hotplug/pciehp_pci.c              |   2 +
 drivers/pci/pci.c                             |  59 ++-
 drivers/pci/pci.h                             |  29 +-
 drivers/pci/pcie/Kconfig                      |  12 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/bwctrl.c                     | 346 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |   9 +-
 drivers/pci/pcie/portdrv.h                    |  10 +-
 drivers/pci/probe.c                           |  20 +-
 drivers/pci/quirks.c                          |  25 +-
 drivers/pci/remove.c                          |   3 +
 drivers/thermal/Kconfig                       |  10 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pcie_cooling.c                |  80 ++++
 include/linux/pci-bwctrl.h                    |  28 ++
 include/linux/pci.h                           |  18 +
 include/uapi/linux/pci_regs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
 24 files changed, 824 insertions(+), 48 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.39.2


