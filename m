Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0777A1DD8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjIOMCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 08:02:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164E1FF1;
        Fri, 15 Sep 2023 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694779315; x=1726315315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ge0rc2WPYKSx8MYcdUbDDS1gOtJoE56w9sC9a+IVtOI=;
  b=cKo8F8WfnP++cJzvCn4A6YMhijkQjv9zpog32B/S5QzXAkaPi40yNfsY
   N8i9Be0MSdKrXQ8MZN6ntXIhXJmGmEYM3k4sUnXL7soqgE+dTdkkeoajk
   bZ+cf7JG83Tz6MHA/6bhOb6ps9clzfQeocYs7AlSEyIk90rH39t5ZgPcj
   ZrLpRVEDtlFPf44Qt6VhnYv/j6o+WMqjvWNCuoKZYfotaWRx4eUO8eHJD
   2mJNMHdlxp4sh8FlW+i6iQetZxhSfmrdls1pLRGNTzgdmaCELXBkN19Kq
   jv4/7fr/OPm2sPma6XYAgvVwQ7J0Tdh053Vigr+zm7+5gjb/zj7NYV6Q2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378145904"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378145904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774292728"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774292728"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:01:50 -0700
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
Subject: [PATCH v2 00/10] Add PCIe Bandwidth Controller
Date:   Fri, 15 Sep 2023 15:01:32 +0300
Message-Id: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
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
  drm/IB/hfi1: Use RMW accessors for changing LNKCTL2
  PCI: Store all PCIe Supported Link Speeds
  PCI: Cache PCIe device's Supported Speed Vector
  PCI/LINK: Re-add BW notification portdrv as PCIe BW controller
  PCI/bwctrl: Add "controller" part into PCIe bwctrl
  thermal: Add PCIe cooling driver
  selftests/pcie_bwctrl: Create selftests

 Documentation/PCI/pciebus-howto.rst           |   8 +-
 MAINTAINERS                                   |   8 +
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
 24 files changed, 799 insertions(+), 135 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.30.2

