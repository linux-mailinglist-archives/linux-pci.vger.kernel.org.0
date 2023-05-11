Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74666FF24F
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjEKNPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbjEKNPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:15:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48614B4;
        Thu, 11 May 2023 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810892; x=1715346892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G+5HyfbacWCARVulfMfPWuWB6RG+cA594cVFDya9HqM=;
  b=SlcLMRjoANXgSMyAUUfl7H8J+kCh6wNXpPV7nfpYCs7bBLmeu0u8++kH
   QxRYjV6KaALk8XexE2F6MPw7uxd7ISSCtW8weVrZWzljnZR19Y1gUFnLD
   Nj2MhdLMS6UgjOr+lYBQg0hhu7CVrKRREA/YlPSO9+9QKMM32/mHzoKl0
   sh2TDy5jhsHD9ehDxuly6FshOv9wxtrjCvgwp+uKYlUWFW4XRfYwCCeVb
   PPgt5ueZZzTu6hpF12W5aXP/qRU9ngQUm/2IX4mTz82rqTg+QZbsMLNul
   2OWGndFtTJOIhJqCiYIetF1WaFdMFoQxuDNRHy2rngGkQPurJw85Up6bI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619298"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619298"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169373"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169373"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/17] PCI: Improve LNKCTL & LNKCTL2 concurrency control
Date:   Thu, 11 May 2023 16:14:24 +0300
Message-Id: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LNKCTL register is written by a number of things in the kernel as RMW
operations without any concurrency control. This could in the unlucky
case lead to losing one of the updates. One of the most obvious path
which can race with most of the other LNKCTL RMW operations seems to be
ASPM policy sysfs write which triggers LNKCTL update.

Add pcie_capability_clear_and_set_word_locked() that uses a per device
spinlock to protect the RMW operations. Introduce helpers for updating
LNKCTL and LNKCTL2 that internally do
pcie_capability_clear_and_set_word_locked(). Convert RMW to use the new
helpers.

These could be mostly marked with Fixes tags but I've not spent the
effort to find those out for each and every patch until this series has
seen some discussion. I certainly will try to find the Fixes tags if
asked to.

There could be a few LNKCTL RMW that are so early into the init that
they would be safe but I was not able to convince myself so I've
included them (namely, some ASPM init paths and hp link enable). Even
if that is the case, it seems safer to use an access pattern with these
registers that is safe even if there would be a few cases where locking
would not be stricly necessary.

As for LNKCTL2, I think all current users are safe but these came up as
a part of PCIe bandwidth control work (for thermal reasons) that will
be adding a writer for LNKCTL2. I'll send PCI BW ctrl patches
separately later as there's plenty of patches in this series already.
If most of this series is deemed worthy of Fixes tags, I could separate
those few LNKCTL2 changes into own patches.

The series is based on top of the "PCI/ASPM: Handle link retraining
race" patch I sent earlier but is not yet applied.

Ilpo Järvinen (17):
  PCI: Add concurrency safe clear_and_set variants for LNKCTL{,2}
  PCI: pciehp: Protect LNKCTL changes
  PCI/ASPM: Use pcie_lnkctl_clear_and_set()
  drm/amdgpu: Use pcie_lnkctl{,2}_clear_and_set() for changing
    LNKCTL{,2}
  drm/radeon: Use pcie_lnkctl{,2}_clear_and_set() for changing
    LNKCTL{,2}
  IB/hfi1: Use pcie_lnkctl{,2}_clear_and_set() for changing LNKCTL{,2}
  e1000e: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  net/mlx5: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  wifi: ath9k: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  mt76: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  Bluetooth: hci_bcm4377: Use pcie_lnkctl_clear_and_set() for changing
    LNKCTL
  misc: rtsx: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  net/tg3: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  r8169: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  wifi: ath11k: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  wifi: ath12k: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
  wifi: ath10k: Use pcie_lnkctl_clear_and_set() for changing LNKCTL

 drivers/bluetooth/hci_bcm4377.c               |  3 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              | 72 +++++-------------
 drivers/gpu/drm/amd/amdgpu/si.c               | 74 ++++++-------------
 drivers/gpu/drm/radeon/cik.c                  | 71 +++++-------------
 drivers/gpu/drm/radeon/si.c                   | 72 +++++-------------
 drivers/infiniband/hw/hfi1/aspm.c             | 16 ++--
 drivers/infiniband/hw/hfi1/pcie.c             | 28 ++-----
 drivers/misc/cardreader/rts5228.c             |  6 +-
 drivers/misc/cardreader/rts5261.c             |  6 +-
 drivers/misc/cardreader/rtsx_pcr.c            |  8 +-
 drivers/net/ethernet/broadcom/tg3.c           | 14 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c    |  6 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  9 +--
 drivers/net/ethernet/realtek/r8169_main.c     |  6 +-
 drivers/net/wireless/ath/ath10k/pci.c         |  8 +-
 drivers/net/wireless/ath/ath11k/pci.c         |  8 +-
 drivers/net/wireless/ath/ath12k/pci.c         |  8 +-
 drivers/net/wireless/ath/ath9k/pci.c          |  9 ++-
 drivers/net/wireless/mediatek/mt76/pci.c      |  5 +-
 drivers/pci/access.c                          | 14 ++++
 drivers/pci/hotplug/pciehp_hpc.c              | 11 +--
 drivers/pci/pcie/aspm.c                       | 48 ++++--------
 drivers/pci/probe.c                           |  1 +
 include/linux/pci.h                           | 17 +++++
 24 files changed, 183 insertions(+), 337 deletions(-)

-- 
2.30.2

