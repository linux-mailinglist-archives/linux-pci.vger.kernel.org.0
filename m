Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690137B31CB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjI2L5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2L5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 07:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A830193;
        Fri, 29 Sep 2023 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988661; x=1727524661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9aEWMt/4svyxRYZ/LYDGVClZj5FenXgVAAtjploJC8=;
  b=mAaTDsqR9Vd1YgUXYrqv8GzYHjxJnn3Ft89F4ebzvLbAV/1vf4kPVIhz
   e9Lbh3dVnhsdn8HXoi3LhXpyy4vN95YsyxAbEnJNJrlHJmCQihZMdijTu
   7afZrCavWuqh3fwQiPW6kr82k4LwdbfZUgT8rGkbK/Z2uX0WmB55kxREI
   awj66U9N/rkpr7eDHU+SdHQQDkqjkoSeXP3M8Owj+zT2fE0RttwhWoYR/
   REYsQ8dA0tbMN4KK1n7tl7tmGmfqIpsLOn+MGSA5SoseVFdPiAYpWBB/3
   1svPJxGK1MDJS4q3rhPt9dk/xLK+HhbvUyAreiTAMNwDBGOSv6N4L2L5S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361658664"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361658664"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873668379"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="873668379"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:57:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/10] Add PCIe Bandwidth Controller
Date:   Fri, 29 Sep 2023 14:57:13 +0300
Message-Id: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
cooling driver to the thermal core side for limiting PCIe Link Speed
due to thermal reasons. PCIe bandwidth controller is a PCI express bus
port service driver. A cooling device is created for each port the
service driver finds if they support changing speeds.

This series only adds support for controlling PCIe Link Speed.
Controlling PCIe Link Width might also be useful but AFAIK, there is no
mechanism for that until PCIe 6.0 (L0p). Based on feedback for v1, the
thermal/cooling device side prefers Link Speed and Link Width to be
separate cooling devices [1] which is taken into account in naming the
cooling device for Link Speed but the Link Width one is not added yet
as it would not be able to control anything at the moment.

bwctrl is built on top of BW notifications revert. I'm just not sure
what is the best practice when re-adding some old functionality in a
modified form so please let me know if I need to somehow alter that
patch.

[1] https://lore.kernel.org/linux-pci/f35db90cd67adf4b0f48cd6f2a6ad8fbd0c1a679.camel@linux.intel.com/


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

Ilpo Järvinen (10):
  PCI: Protect Link Control 2 Register with RMW locking
  drm/radeon: Use RMW accessors for changing LNKCTL2
  drm/amdgpu: Use RMW accessors for changing LNKCTL2
  RDMA/hfi1: Use RMW accessors for changing LNKCTL2
  PCI: Store all PCIe Supported Link Speeds
  PCI: Cache PCIe device's Supported Speed Vector
  PCI/LINK: Re-add BW notification portdrv as PCIe BW controller
  PCI/bwctrl: Add "controller" part into PCIe bwctrl
  thermal: Add PCIe cooling driver
  selftests/pcie_bwctrl: Create selftests

 Documentation/PCI/pciebus-howto.rst           |   8 +-
 MAINTAINERS                                   |   9 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |  41 +--
 drivers/gpu/drm/amd/amdgpu/si.c               |  41 +--
 drivers/gpu/drm/radeon/cik.c                  |  40 +--
 drivers/gpu/drm/radeon/si.c                   |  40 +--
 drivers/infiniband/hw/hfi1/pcie.c             |  30 +-
 drivers/pci/pcie/Kconfig                      |   9 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/bwctrl.c                     | 309 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |   9 +-
 drivers/pci/pcie/portdrv.h                    |  10 +-
 drivers/pci/probe.c                           |  38 ++-
 drivers/pci/remove.c                          |   2 +
 drivers/thermal/Kconfig                       |  10 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pcie_cooling.c                | 107 ++++++
 include/linux/pci-bwctrl.h                    |  33 ++
 include/linux/pci.h                           |   3 +
 include/uapi/linux/pci_regs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 +++++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
 24 files changed, 800 insertions(+), 135 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.30.2

