Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29672009A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFBLsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFBLsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:48:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F71A8;
        Fri,  2 Jun 2023 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706485; x=1717242485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XsRTg2IPZD0lC7HOFGddKJ8iZPHCHHWK5jmT4ycr6tM=;
  b=LE4UhVO1qUdaAaCXU6e58AS2iNPnvZy4KahCDFhamIYxbwG8HVX6P3ME
   Tq8QL7cA2D6BrciW8xIqr2VPsEabViB6KPZUTg0Wpy9L3Fl7XfAHGhg/r
   eaOACEjqozWXDzkzATIg9LTTe5wOzob5zO1mjSBi63wyW9P6GwZOPaHzC
   8ce5B5BOBpCZXh2/qpmkpwQ85cVMHaCG/j7dv+9VUx/gYA4n8JW7SQPit
   LJfpff8VUmtqjGDneIDBivf9qQGH31n8sRzFVznNA6u21C06LvYBRLcnn
   MPYbSm3B9dQHo/f1fabe+coswCYfRQU/C/8ZawTIge2kcR7KqYn/LjZcz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279586"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819397"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819397"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:47:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 00/13] PCI/ASPM: Make ASPM in core robust and remove driver workarounds
Date:   Fri,  2 Jun 2023 14:47:37 +0300
Message-Id: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously, ASPM service driver has ignored link state management
requests when OS is not authorized to touch LNKCTL (or ASPM is not
configured at all). Because the core interface has not been reliable,
drivers have create workarounds to force ASPM state by directly
writing into LNKCTL themselves.

A second problem is lack of symmetric pair for
pci_disable_link_state(). Any link state disable is permanent (NOTE:
pci_enable_link_state() despite its name is not a symmetric pair for
pci_disable_link_state()). The lack of way to re-enable ASPM prevents
drivers from using pci_disable_link_state() to disabling ASPM for
certain phases of driver operation and re-enabling it later.

Both cases are problematic because when ASPM is working normally
through the service driver, it is not aware of the extra link state
changes drivers perform directly causing the service driver to have
incorrect view about the ASPM state.

Address these problems by making pci_disable_link_state() reliable and
by providing proper pci_enable_link_state() pair for it (the function
currently on the way is renamed first to a more descriptive name).
After core improvements, convert drivers to use the new interface and
drop the workarounds.

This series is based on top of the RMW improvements series:
  https://lore.kernel.org/linux-pci/20230517105235.29176-1-ilpo.jarvinen@linux.intel.com/T/#t

Ilpo Järvinen (13):
  PCI/ASPM: Disable ASPM when driver requests it
  PCI/ASPM: Rename pci_enable_link_state() to
    pci_set_default_link_state()
  PCI/ASPM: Improve pci_set_default_link_state() kerneldoc
  PCI/ASPM: Move L0S/L1/sub states mask calculation into a helper
  PCI/ASPM: Add pci_enable_link_state()
  Bluetooth: hci_bcm4377: Convert aspm disable to quirk
  mt76: Remove unreliable pci_disable_link_state() workaround
  e1000e: Remove unreliable pci_disable_link_state{,_locked}()
    workaround
  wifi: ath10k: Use pci_disable/enable_link_state()
  wifi: ath11k: Use pci_disable/enable_link_state()
  wifi: ath12k: Use pci_disable/enable_link_state()
  IB/hfi1: Use pci_disable/enable_link_state()
  misc: rtsx: Use pci_disable/enable_link_state()

 drivers/bluetooth/hci_bcm4377.c               |  20 ---
 drivers/infiniband/hw/hfi1/aspm.c             |  38 +----
 drivers/infiniband/hw/hfi1/pcie.c             |   2 +-
 drivers/misc/cardreader/rts5228.c             |   6 +-
 drivers/misc/cardreader/rts5261.c             |   6 +-
 drivers/misc/cardreader/rtsx_pcr.c            |   8 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  77 +---------
 drivers/net/wireless/ath/ath10k/pci.c         |   8 +-
 drivers/net/wireless/ath/ath11k/pci.c         |  10 +-
 drivers/net/wireless/ath/ath12k/pci.c         |  10 +-
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 -
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/pci.c      |  47 ------
 drivers/pci/controller/vmd.c                  |   2 +-
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/aspm.c                       | 145 ++++++++++++------
 drivers/pci/pcie/aspm_minimal.c               |  66 ++++++++
 drivers/pci/quirks.c                          |   3 +
 include/linux/pci.h                           |  10 +-
 25 files changed, 203 insertions(+), 270 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/pci.c
 create mode 100644 drivers/pci/pcie/aspm_minimal.c

-- 
2.30.2

