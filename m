Return-Path: <linux-pci+bounces-7241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC68BFF5A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE69228CC83
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BADA84DED;
	Wed,  8 May 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVmfRhZi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0047F5B;
	Wed,  8 May 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176089; cv=none; b=XMY8BD6zYnIE9z1lKnM+4r34I8uq/47mGAP8L/05cTF90Cl7ufMZGep/PrTNoQCUzA9I5OnFXAda2MgyRIhON696i20BXJXR894yMI0NlhidsGkMCd+wtwMB6apvJBDqg9wEXUggIz6wQqCyYaQrr62XCPSdgsrtS5ARDQGJ4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176089; c=relaxed/simple;
	bh=o8MlCnJP8bgcB/yWFMkAmnuntNXYkbwNsmq2xn17rNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fALN+9+tlQ2p+dNZvVBTcfmHdac6MP8fc7faCNYjTHE0PVPfXUvXmHi2shq1safJMPVDH12QXgI1zeeYi/MgTMIn5V7b1UUgkKQo9ykl5P7ctEGcAsjfGO7UdHyNQZ7Mh/tgZ4S/+Vs8SbQAw/fIP7pc5CAJqShPlglap+4+IHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVmfRhZi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176088; x=1746712088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o8MlCnJP8bgcB/yWFMkAmnuntNXYkbwNsmq2xn17rNk=;
  b=PVmfRhZi71vszTabbXVMnGqpxn6DzYp1UlQvJD/UDq4KKhOozRIn/W4c
   hwJdHIykaOlbJQeuaanhCfugp1aiW3OgM890vsjWTKhoRqJEQ91u0hkfP
   uG/P6WAHyy+zIQ3hE601HlAdL4tFxqIlmoy0MvElu+9/hy+OATojZXTvK
   zmmtbwxvj22kNw/SN8bPQ1MZpiFO+SyEXwEjkPB7JNqTYjM5HLRKWwpBw
   YK6yQg5KN5pASrgG6UYfzdXJTB+cwhFLwFqi1dQ/6CfAa+ZUv+ZZDawdf
   8pcsUKEM71DYLkVUiOqk28Z7J8af+Dw2aZRP65Vv5lZZ9NlDo03bdlRTU
   A==;
X-CSE-ConnectionGUID: Yj5JbxaETNGc/QKGQpY2Mw==
X-CSE-MsgGUID: VV5mUQ7pSpGWT5sz5lABIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10906373"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10906373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:48:07 -0700
X-CSE-ConnectionGUID: 778/91ZOTzSFUe1Tk5HqIg==
X-CSE-MsgGUID: YsJcJliKTz2LSrYMxqmCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28855104"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:48:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: [PATCH v5 0/8] PCI: Add PCIe bandwidth controller
Date: Wed,  8 May 2024 16:47:36 +0300
Message-Id: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/pci.h                             |  31 +-
 drivers/pci/pcie/Kconfig                      |  12 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/bwctrl.c                     | 340 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |   9 +-
 drivers/pci/pcie/portdrv.h                    |  10 +-
 drivers/pci/probe.c                           |  20 +-
 drivers/pci/quirks.c                          |  25 +-
 drivers/pci/remove.c                          |   3 +
 drivers/thermal/Kconfig                       |  10 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pcie_cooling.c                |  84 +++++
 include/linux/pci-bwctrl.h                    |  28 ++
 include/linux/pci.h                           |  18 +
 include/uapi/linux/pci_regs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 +++++++
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


