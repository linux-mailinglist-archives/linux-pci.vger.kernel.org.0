Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6EC756255
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGQMFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGQMFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 08:05:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9C10CA;
        Mon, 17 Jul 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595532; x=1721131532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jZAmi7i2DsRxp8XcsCtYleiHASBL2jOVHHwz4RQm2Wc=;
  b=ETq18yfybherjseLZyU0Q+WoEVA0nniLnVdxmx8cv5IWFioLOEr6l8vY
   abV2XeOBLKgdJEHEP+3U1fuDb3C3U6Uazz9eubM+7G3p6LnfHl/HbwywA
   JLkef0WuMre8igDfsRi2gcHJenihMfVbkUbCMQ3fmmKMnsmnL0OJhIUI7
   GkDT4NSDVM4hv9MlwD4DhIW9iZyTNkbbZRbfEE2/Et1uHI7nAZutZC/dT
   cSqE7XaDZx+9SzzKIljbTXkXuA0pcoSknwCU5GIpBmIcQn2Fih1m9NIbk
   63kqtrfeF0yKjKYnypqKIzbvyyd47/++549RCxA+YHstdXTpx258Zpsv+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432081468"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432081468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752875843"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752875843"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Jiang Liu <jiang.liu@huawei.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dean Luick <dean.luick@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ricky Wu <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>, Lee Jones <lee@kernel.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael Chan <mchan@broadcom.com>,
        Matt Carlson <mcarlson@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Sven Peter <sven@svenpeter.dev>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Auke Kok <auke-jan.h.kok@intel.com>,
        Jeff Garzik <jeff@garzik.org>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 01/11] PCI: Add locking to RMW PCI Express Capability Register accessors
Date:   Mon, 17 Jul 2023 15:04:53 +0300
Message-Id: <20230717120503.15276-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
References: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
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

Many places in the kernel write the Link Control and Root Control PCI
Express Capability Registers without proper concurrency control and
this could result in losing the changes one of the writers intended to
make.

Add pcie_cap_lock spinlock into the struct pci_dev and use it to
protect bit changes made in the RMW capability accessors. Protect only
a selected set of registers by differentiating the RMW accessor
internally to locked/unlocked variants using a wrapper which has the
same signature as pcie_capability_clear_and_set_word(). As the
Capability Register (pos) given to the wrapper is always a constant,
the compiler should be able to simplify all the dead-code away.

So far only the Link Control Register (ASPM, hotplug, link retraining,
various drivers) and the Root Control Register (AER & PME) seem to
require RMW locking.

Fixes: c7f486567c1d ("PCI PM: PCIe PME root port service driver")
Fixes: f12eb72a268b ("PCI/ASPM: Use PCI Express Capability accessors")
Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Fixes: affa48de8417 ("staging/rdma/hfi1: Add support for enabling/disabling PCIe ASPM")
Fixes: 849a9366cba9 ("misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add support MMC_CAP2_NO_MMC")
Fixes: 3d1e7aa80d1c ("misc: rtsx: Use pcie_capability_clear_and_set_word() for PCI_EXP_LNKCTL")
Fixes: c0e5f4e73a71 ("misc: rtsx: Add support for RTS5261")
Fixes: 3df4fce739e2 ("misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG")
Fixes: 121e9c6b5c4c ("misc: rtsx: modify and fix init_hw function")
Fixes: 19f3bd548f27 ("mfd: rtsx: Remove LCTLR defination")
Fixes: 773ccdfd9cc6 ("mfd: rtsx: Read vendor setting from config space")
Fixes: 8275b77a1513 ("mfd: rts5249: Add support for RTS5250S power saving")
Fixes: 5da4e04ae480 ("misc: rtsx: Add support for RTS5260")
Fixes: 0f49bfbd0f2e ("tg3: Use PCI Express Capability accessors")
Fixes: 5e7dfd0fb94a ("tg3: Prevent corruption at 10 / 100Mbps w CLKREQ")
Fixes: b726e493e8dc ("r8169: sync existing 8168 device hardware start sequences with vendor driver")
Fixes: e6de30d63eb1 ("r8169: more 8168dp support.")
Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Fixes: 6f461f6c7c96 ("e1000e: enable/disable ASPM L0s and L1 and ERT according to hardware errata")
Fixes: 1eae4eb2a1c7 ("e1000e: Disable L1 ASPM power savings for 82573 mobile variants")
Fixes: 8060e169e02f ("ath9k: Enable extended synch for AR9485 to fix L0s recovery issue")
Fixes: 69ce674bfa69 ("ath9k: do btcoex ASPM disabling at initialization time")
Fixes: f37f05503575 ("mt76: mt76x2e: disable pcie_aspm by default")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/access.c | 20 +++++++++++++++++---
 drivers/pci/probe.c  |  1 +
 include/linux/pci.h  | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 3c230ca3de58..0b2e90d2f04f 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -497,8 +497,8 @@ int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
 }
 EXPORT_SYMBOL(pcie_capability_write_dword);
 
-int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
-				       u16 clear, u16 set)
+int pcie_capability_clear_and_set_word_unlocked(struct pci_dev *dev, int pos,
+						u16 clear, u16 set)
 {
 	int ret;
 	u16 val;
@@ -512,7 +512,21 @@ int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
 
 	return ret;
 }
-EXPORT_SYMBOL(pcie_capability_clear_and_set_word);
+EXPORT_SYMBOL(pcie_capability_clear_and_set_word_unlocked);
+
+int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
+					      u16 clear, u16 set)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&dev->pcie_cap_lock, flags);
+	ret = pcie_capability_clear_and_set_word_unlocked(dev, pos, clear, set);
+	spin_unlock_irqrestore(&dev->pcie_cap_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
 
 int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 					u32 clear, u32 set)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609..f1587fb0ba71 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2324,6 +2324,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 		.end = -1,
 	};
 
+	spin_lock_init(&dev->pcie_cap_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c69a2cc1f412..7ee498cd1f37 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -467,6 +467,7 @@ struct pci_dev {
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
+	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
@@ -1217,11 +1218,40 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
 int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);
-int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
-				       u16 clear, u16 set);
+int pcie_capability_clear_and_set_word_unlocked(struct pci_dev *dev, int pos,
+						u16 clear, u16 set);
+int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
+					      u16 clear, u16 set);
 int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 					u32 clear, u32 set);
 
+/**
+ * pcie_capability_clear_and_set_word - RMW accessor for PCI Express Capability Registers
+ * @dev:	PCI device structure of the PCI Express device
+ * @pos:	PCI Express Capability Register
+ * @clear:	Clear bitmask
+ * @set:	Set bitmask
+ *
+ * Perform a Read-Modify-Write (RMW) operation using @clear and @set
+ * bitmasks on PCI Express Capability Register at @pos. Certain PCI Express
+ * Capability Registers are accessed concurrently in RMW fashion, hence
+ * require locking which is handled transparently to the caller.
+ */
+static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
+						     int pos,
+						     u16 clear, u16 set)
+{
+	switch (pos) {
+	case PCI_EXP_LNKCTL:
+	case PCI_EXP_RTCTL:
+		return pcie_capability_clear_and_set_word_locked(dev, pos,
+								 clear, set);
+	default:
+		return pcie_capability_clear_and_set_word_unlocked(dev, pos,
+								   clear, set);
+	}
+}
+
 static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
 					   u16 set)
 {
-- 
2.30.2

