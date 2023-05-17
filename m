Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737F7065B9
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEQK4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQK4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 06:56:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FC61AD;
        Wed, 17 May 2023 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684320946; x=1715856946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GwP0EBEDbG45Z2SltddVm37Yre0XLhXksBVbeUJhz4=;
  b=UlfRVvA4qojoAyO8WYg5SBTEPrcxCZOa1UajckSLYJihTLF4K70Xnw24
   o+lVvmcB+LLxFxdnmZMHSNY35saP8ukBHsN3WiiB34eri2CVaJuOg5nTC
   icHnWczxtfMaIHZNs36mXA5//6azurrjCFaPMTo/xrRlTrsUvTiMdXs11
   z9T23rm5A6MDebIgvLfijxqjwzJ/hiX7tFS05+zsOmnfICCnF7WiRzJQC
   aYsYrPazRfjyY8jpiRLzEEQU/Vx9SKgN3AA/ezPw+HmuHZSbTln4Hmt3c
   w0navcZYnqdJwZRf1JgIJUDUpUAewIc1QDUKNC+cXV7qVRDqCItS4OVs0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438071545"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="438071545"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="734650831"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="734650831"
Received: from lnstern-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.221.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:52:42 -0700
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
Subject: [PATCH v2 0/9] PCI: Improve PCIe Capability RMW concurrency control
Date:   Wed, 17 May 2023 13:52:26 +0300
Message-Id: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

As for LNKCTL2, all current users are safe so I left those changes to
be part of PCIe bandwidth control work I'll send separately later. It
will add LNKCTL2 RMW ops that require locking.

I went with the wrapper approach I suggested to Lukas even if I
personally feel it's over-engineering for a case that doesn't current
exist in the kernel code. That, however, is contained in the first
patch so it can be easily changed without affecting the other patches.

I felt better to do these as fixes first before altering code related
to duplicated ASPM code in drivers. Replacing the custom ASPM code in
drivers with calls to core will not necessarily yield the same states
as previously even if disabling ASPM becomes always possible because
re-enabling ASPM would still be prohibited (some drivers do disable and
enable ASPM back later). Thus, the ASPM "cleanups" would have higher
regression potential.

The series is based on top of the "PCI/ASPM: Handle link retraining
race" patch I sent earlier but is not yet applied.

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


Ilpo Järvinen (9):
  PCI: Add locking to RMW PCI Express Capability Register accessors
  PCI: pciehp: Use RMW accessors for changing LNKCTL
  PCI/ASPM: Use RMW accessors for changing LNKCTL
  drm/amdgpu: Use RMW accessors for changing LNKCTL
  drm/radeon: Use RMW accessors for changing LNKCTL
  net/mlx5: Use RMW accessors for changing LNKCTL
  wifi: ath11k: Use RMW accessors for changing LNKCTL
  wifi: ath12k: Use RMW accessors for changing LNKCTL
  wifi: ath10k: Use RMW accessors for changing LNKCTL

 drivers/gpu/drm/amd/amdgpu/cik.c              | 36 +++++------------
 drivers/gpu/drm/amd/amdgpu/si.c               | 36 +++++------------
 drivers/gpu/drm/radeon/cik.c                  | 36 +++++------------
 drivers/gpu/drm/radeon/si.c                   | 37 +++++-------------
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  9 +----
 drivers/net/wireless/ath/ath10k/pci.c         |  9 +++--
 drivers/net/wireless/ath/ath11k/pci.c         | 10 +++--
 drivers/net/wireless/ath/ath12k/pci.c         | 10 +++--
 drivers/pci/access.c                          | 20 ++++++++--
 drivers/pci/hotplug/pciehp_hpc.c              | 12 ++----
 drivers/pci/pcie/aspm.c                       | 39 ++++++++-----------
 drivers/pci/probe.c                           |  1 +
 include/linux/pci.h                           | 34 +++++++++++++++-
 13 files changed, 128 insertions(+), 161 deletions(-)

-- 
2.30.2

