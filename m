Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD99E736DAC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjFTNqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjFTNqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 09:46:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AB170F;
        Tue, 20 Jun 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687268796; x=1718804796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ylPye6jciyJjtMMCu96/PJn40ZJb9WI9dBE1nm/Ef0A=;
  b=kaXrJgwfmWNf69ZmREJh+/gbQzv8e5qzNC2jo5j2vAw4o59/umef2WCD
   wGiJXpzYCeqq1sjLYhC/SOABblvRxoBsAK5Vw7oO+3yrAJJxLkNlAFhrL
   H09MvXekToev0el/eMG2cyA4T9tFu4gdjsZLY2b0yQyjcmPcKk0Ondcqs
   qV5cwm7KihICZ9Em8FsiVwfhBzuFIwp8vPXtKU2xRBSl/ZON/44PGXKTd
   jcMMLuSNEE1OfG1YlFtpSL9gA4OosUnAIfKxInJ6yvZT5Rz+rbl7qt/k5
   sDztcAazJ+pFLFJXkZQvTbD9/fA6gfa65qEkjcCoQUwUMiMJy28mUbltW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362401245"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="362401245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827006532"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827006532"
Received: from eshaanan-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.61.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:46:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/10] PCI: Improve PCIe Capability RMW concurrency control
Date:   Tue, 20 Jun 2023 16:46:14 +0300
Message-Id: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Express Capability RMW accessors don't properly protect against
concurrent access. Link Control Register is written by a number of
things in the kernel in a RMW fashion without any concurrency control.
This could in the unlucky case lead to losing one of the updates. One
of the most obvious path which can race with most of the other LNKCTL
RMW operations seems to be ASPM policy sysfs write which triggers
LNKCTL update. Similarly, Root Control Register can be concurrently
accessed by AER and PME.

Make pcie_capability_clear_and_set_word() (and other RMW accessors that
call it) to use a per device spinlock to protect the RMW operations to
the Capability Registers that require locking. Convert open-coded
LNKCTL RMW operations to use pcie_capability_clear_and_set_word() to
benefit from the locking.

There's also a related series which improves ASPM service driver and
device driver coordination by removing out-of-band ASPM state
management from device drivers (which will remove some of the code
fragments changed by this series but it has higher regression
potential which is why it seems prudent to do these changes in two
steps):
  https://lore.kernel.org/linux-pci/20230602114751.19671-1-ilpo.jarvinen@linux.intel.com/T/#t

v3:
- Split link retraining change off from ASPM patch & reorder it earlier
- Adjust changelog to take into account the move of link retraining
  code into PCI core and no longer refer to ASPM (currently in
  pci/enumeration branch)
- based on top of pci/main

v2:
- Keep the RMW ops caller API the same
- Make pcie_capability_clear_and_set_word() a wrapper that uses
  locked/unlocked variant based on the capability reg
- Extracted LNKCTL2 changes out from this series to keep this purely
  a series which fixes something (LNKCTL2 RMW lock is necessary only
  when PCIe BW control is introduced).
- Added Fixes tags (it's a bit rathole but yeah, they're there now).
- Renamed cap_lock to pcie_cap_lock
- Changed ath1* to clear the ASPMC field before setting it


Ilpo Järvinen (10):
  PCI: Add locking to RMW PCI Express Capability Register accessors
  PCI: Make link retraining use RMW accessors for changing LNKCTL
  PCI: pciehp: Use RMW accessors for changing LNKCTL
  PCI/ASPM: Use RMW accessors for changing LNKCTL
  drm/amdgpu: Use RMW accessors for changing LNKCTL
  drm/radeon: Use RMW accessors for changing LNKCTL
  net/mlx5: Use RMW accessors for changing LNKCTL
  wifi: ath11k: Use RMW accessors for changing LNKCTL
  wifi: ath12k: Use RMW accessors for changing LNKCTL
  wifi: ath10k: Use RMW accessors for changing LNKCTL

 drivers/gpu/drm/amd/amdgpu/cik.c              | 36 +++++-------------
 drivers/gpu/drm/amd/amdgpu/si.c               | 36 +++++-------------
 drivers/gpu/drm/radeon/cik.c                  | 36 +++++-------------
 drivers/gpu/drm/radeon/si.c                   | 37 +++++-------------
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  9 +----
 drivers/net/wireless/ath/ath10k/pci.c         |  9 +++--
 drivers/net/wireless/ath/ath11k/pci.c         | 10 +++--
 drivers/net/wireless/ath/ath12k/pci.c         | 10 +++--
 drivers/pci/access.c                          | 20 ++++++++--
 drivers/pci/hotplug/pciehp_hpc.c              | 12 ++----
 drivers/pci/pcie/aspm.c                       | 38 ++++++++-----------
 drivers/pci/probe.c                           |  1 +
 include/linux/pci.h                           | 34 ++++++++++++++++-
 13 files changed, 128 insertions(+), 160 deletions(-)

-- 
2.30.2

