Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B816752172
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjGMMpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjGMMpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 08:45:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E83212E;
        Thu, 13 Jul 2023 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252317; x=1720788317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AXOgPYaPuOxYmPDMtFL2ISnKlxaaq+TWYj4SLMdIzoo=;
  b=NcujlginmKqUgpaEbKCBs/lyWxh2MX5fTf0X/dr8qmfYfzelj2cRSwQ3
   ROrcNx50Od8AgmWxzmZ0pSl1fyeAjYr2++F0teu9LmkvQGB6F8HY8MDvQ
   U3BTSL2qZoDiNGVeElxtFNvGZNS9iZVVjK/Kmdtcmy9iS7DMtnua9mxL2
   tgeEZU/UaNUR4QAityE+aNRtPOp9mzMWzCjzgueyhlmBReU+VvtZalc1s
   9arJKqQER7yTwnBn77JQLXQYeYGHTvs4UtJqKv4w8x7noMHAi4AWqlFC6
   PN4nDsWnHcn3M0zbXtkn1josMWhk//oqj+RlPgFz+90OrtmpB3dtKqemo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367796715"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367796715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757144353"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757144353"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:45:12 -0700
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
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 00/11] PCI: Improve PCIe Capability RMW concurrency control
Date:   Thu, 13 Jul 2023 15:44:54 +0300
Message-Id: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
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

v4:
- Rebased on top of pci/main
- Added patch to update documentation

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

Ilpo Järvinen (11):
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
  PCI: Document the Capability accessor RMW improvements

 Documentation/PCI/pciebus-howto.rst           | 14 ++++---
 drivers/gpu/drm/amd/amdgpu/cik.c              | 36 +++++-------------
 drivers/gpu/drm/amd/amdgpu/si.c               | 36 +++++-------------
 drivers/gpu/drm/radeon/cik.c                  | 36 +++++-------------
 drivers/gpu/drm/radeon/si.c                   | 37 +++++--------------
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  9 +----
 drivers/net/wireless/ath/ath10k/pci.c         |  9 +++--
 drivers/net/wireless/ath/ath11k/pci.c         | 10 +++--
 drivers/net/wireless/ath/ath12k/pci.c         | 10 +++--
 drivers/pci/access.c                          | 20 ++++++++--
 drivers/pci/hotplug/pciehp_hpc.c              | 12 ++----
 drivers/pci/pci.c                             |  8 +---
 drivers/pci/pcie/aspm.c                       | 31 +++++++---------
 drivers/pci/probe.c                           |  1 +
 include/linux/pci.h                           | 34 ++++++++++++++++-
 15 files changed, 137 insertions(+), 166 deletions(-)

-- 
2.30.2

