Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BA756251
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGQMFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 08:05:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86EE8F;
        Mon, 17 Jul 2023 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595517; x=1721131517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MTAcx2EIK+KDUM9wm9QmcxJn6O3dI+zOMLpiJ0PiZII=;
  b=JZv4AUY0NqUTnEKxU+wMNBHrMUiR3pqxcZRbnD6Rj6qS5VJhu/DWKzCI
   8Wn5/AulYJ0exYZDjxxYmBDXT9DGU8f5EQFfU9Mniw6gf9p7ftBNbW24s
   GJAGC/Cs6zOHf5ZuXpD4vsSpDfXz0MwMsM4Yh3GrBONBv0FM1j0eu1ljd
   ljKWOZsYvZw0KMj+Z3TPns5A6SitlQKPUhWzcnD60sZrhLrWfl2FRtVA6
   GPjFeoCjUHYRGUHEmMpXTSk7m1sWl8Z7Nqf2JxKq+kCv6G5qBVbjmEsIz
   PDIUzK3dC+rcyQZ41OowuQBQTBljUqsyvOEccUOfWS4RrSequCLUCuP2+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432081399"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432081399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752875752"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752875752"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 00/11] PCI: Improve PCIe Capability RMW concurrency control
Date:   Mon, 17 Jul 2023 15:04:52 +0300
Message-Id: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

v5:
- Remove reversed logic from a conditional
- Use a variable for CCC setup

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
 drivers/pci/pcie/aspm.c                       | 30 +++++++--------
 drivers/pci/probe.c                           |  1 +
 include/linux/pci.h                           | 34 ++++++++++++++++-
 15 files changed, 136 insertions(+), 166 deletions(-)

-- 
2.30.2

