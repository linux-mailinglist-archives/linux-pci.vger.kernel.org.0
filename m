Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB877F639
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbjHQMRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350725AbjHQMRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:17:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A902213F;
        Thu, 17 Aug 2023 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274640; x=1723810640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JawHZC3vAEtY9CACT0MmR2cqpaQhxO/Iz1UNU6K7/Yw=;
  b=FhiZyahZkvefu1AkSMtB2j6bcEoCrOva4VrvjIudd1p/mFhFUCzBttNZ
   S7D3E8G9suJB+63nyUJnEBo1nks41r7BQIBGrT/XK+XWfsBNZG2+322zG
   eZH03qmbC9SWY+gju/oJNgZQw2o/B64y7W5XDZOFfPiNInulqAlD86vMb
   osE613yAhmlHfuLJoJ6DDXWq0P25xPzK2PD9/gxhms3fkTMQufB+GGJgE
   sOPa9atVT9KJ+kcATIcrN7ufKmVnGRoxifIuGG9kDq23XLk6E67HgHNY6
   A4j36y22SPjuQOPume+FYfIrcasm40+PlQlPfZLGDSzBfunoRxgH2pIKR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696591"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848872880"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848872880"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/10] Add PCIe Bandwidth Controller
Date:   Thu, 17 Aug 2023 15:16:58 +0300
Message-Id: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
cooling driver to the thermal core side for limiting PCIe link speed
due to thermal reasons. PCIe bandwidth controller is a PCI express bus
port service driver. A cooling device is created for each port the
service driver finds if they support changing speeds.

bwctrl now is built on top of BW notifications revert. I'm just not
sure what is the best practice when re-adding some old functionality in
a modified form so please let me know if I need to somehow alter that
patch.

The series is based on top of the RMW changes in pci/pcie-rmw.

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
 23 files changed, 795 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pci/pcie/bwctrl.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

-- 
2.30.2

