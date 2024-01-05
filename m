Return-Path: <linux-pci+bounces-1708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E287B8252BE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D54285EF2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4828E3B;
	Fri,  5 Jan 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kvt8mVVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE728E17;
	Fri,  5 Jan 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704453962; x=1735989962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6uJDkcI/k+9njrwFa0eJ0S2DhlFTVliRLHGjulV7UQ=;
  b=Kvt8mVVW8G5YbXJh00++7jiLs6bkLjT6d6vdK9fFhDsBzbZE4unJl4v7
   BFgtwf0YW9n6ceLTmuYnREmLiBar5GnxbxZvZxLm2pH6guZs90Vd/SRMY
   tF5IdmAjRLMOX2q5IM+0fzRGp444rakfNFn0+c2O4x2E3Svl7oIi2Bneg
   kOx9aB1npvrZ5SDcli3lIHSLHDT7+yHZ/nI6tJojNq+CKZfffrXuU67Rt
   hHs41af4oxjg8WNFacwjlZq/4BV/QjqzPAtBmaP1UssZywjl98sEta2Dv
   RJ06sxXGJNOeSHL01jdEgPn3GsIGz0DSpdk42h7Goscr5ZnaD1wm6w18S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483662296"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="483662296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730447440"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="730447440"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.38])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:25:55 -0800
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
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/8] Add PCIe bandwidth controller
Date: Fri,  5 Jan 2024 13:25:39 +0200
Message-Id: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
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

bwctrl is built on top of BW notifications revert.

It tried to look into using cached link speed values more in code
unrelated to what bwctrl needs but every case I looked non-trivial so I
left such attempts as further work.

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
  drm/radeon: Use RMW accessors for changing LNKCTL2
  drm/amdgpu: Use RMW accessors for changing LNKCTL2
  RDMA/hfi1: Use RMW accessors for changing LNKCTL2
  PCI: Store all PCIe Supported Link Speeds
  PCI/link: Re-add BW notification portdrv as PCIe BW controller
  thermal: Add PCIe cooling driver
  selftests/pcie_bwctrl: Create selftests

 Documentation/PCI/pciebus-howto.rst           |  14 +-
 MAINTAINERS                                   |   9 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |  41 +--
 drivers/gpu/drm/amd/amdgpu/si.c               |  41 +--
 drivers/gpu/drm/radeon/cik.c                  |  40 +--
 drivers/gpu/drm/radeon/si.c                   |  40 +--
 drivers/infiniband/hw/hfi1/pcie.c             |  30 +-
 drivers/pci/pci.c                             |  59 ++--
 drivers/pci/pcie/Kconfig                      |  12 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/bwctrl.c                     | 269 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |   9 +-
 drivers/pci/pcie/portdrv.h                    |  10 +-
 drivers/pci/probe.c                           |   8 +
 drivers/pci/remove.c                          |   3 +
 drivers/thermal/Kconfig                       |  10 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pcie_cooling.c                | 107 +++++++
 include/linux/pci-bwctrl.h                    |  33 +++
 include/linux/pci.h                           |  11 +
 include/uapi/linux/pci_regs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 +++++
 25 files changed, 789 insertions(+), 153 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.39.2


