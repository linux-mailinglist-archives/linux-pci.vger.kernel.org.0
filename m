Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C7728E00
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 04:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFICax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFICax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 22:30:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938312D52
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 19:30:46 -0700 (PDT)
X-UUID: a09c998e066d11eeb20a276fd37b9834-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TA3zU20zwqayeH/sPZUXbavbSPV3c+f7g4YJ/okb4XE=;
        b=TQKgrgmuMg3Zxa4vLqA9BsE0Du5ZWFB6jp8sBsDt8g+BmrWBvLAapokL/gWVuHOCRvGqOCwoG0dVg7pEQxaZtrD9Ikck1PqMd5CZAh+LHuVjQiu73OShojWLIrlL71cIz0+11BdyfzcR568aP7kMi+xTMBs81UWqT+yY5evotZQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:a23f37fc-7b2a-4468-87e8-1f4c2c2ea5a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:100e836e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a09c998e066d11eeb20a276fd37b9834-20230609
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <zhiren.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 843883899; Fri, 09 Jun 2023 10:30:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 10:30:40 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 10:30:40 +0800
From:   Zhiren Chen <zhiren.chen@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-pci@vger.kernel.org>, Zhiren Chen <Zhiren.Chen@mediatek.com>
Subject: [PATCH] PCI:PM: Support platforms that do not implement ACPI
Date:   Fri, 9 Jun 2023 10:30:38 +0800
Message-ID: <20230609023038.61388-1-zhiren.chen@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Zhiren Chen <Zhiren.Chen@mediatek.com>

The platform_pci_choose_state function and other low-level platform
interfaces used by PCI power management processing did not take into
account non-ACPI-supported platforms. This shortcoming can result in
limitations and issues.

For example, in embedded systems like smartphones, a PCI device can be
shared by multiple processors for different purposes. The PCI device and
some of the processors are controlled by Linux, while the rest of the
processors runs its own operating system.
When Linux initiates system-level sleep, if it does not consider the
working state of the shared PCI device and forcefully sets the PCI device
state to D3, it will affect the functionality of other processors that
are currently using the PCI device.

To address this problem, an interface should be created for PCI devices
that don't support ACPI to enable accurate reporting of the power state
during the PCI PM handling process.

Signed-off-by: Zhiren Chen <Zhiren.Chen@mediatek.com>
---
 drivers/pci/pci.c   | 24 ++++++++++++++++++++++++
 drivers/pci/pci.h   | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..9f03406f3081 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1014,6 +1014,9 @@ static void pci_restore_bars(struct pci_dev *dev)
 
 static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->is_manageable)
+		return dev->platform_pm_ops->is_manageable(dev);
+
 	if (pci_use_mid_pm())
 		return true;
 
@@ -1023,6 +1026,9 @@ static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
 					       pci_power_t t)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->set_state)
+		return dev->platform_pm_ops->set_state(dev, t);
+
 	if (pci_use_mid_pm())
 		return mid_pci_set_power_state(dev, t);
 
@@ -1031,6 +1037,9 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
 
 static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->get_state)
+		return dev->platform_pm_ops->get_state(dev);
+
 	if (pci_use_mid_pm())
 		return mid_pci_get_power_state(dev);
 
@@ -1039,12 +1048,18 @@ static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
 
 static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->refresh_state)
+		dev->platform_pm_ops->refresh_state(dev);
+
 	if (!pci_use_mid_pm())
 		acpi_pci_refresh_power_state(dev);
 }
 
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->choose_state)
+		return dev->platform_pm_ops->choose_state(dev);
+
 	if (pci_use_mid_pm())
 		return PCI_POWER_ERROR;
 
@@ -1053,6 +1068,9 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 
 static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->set_wakeup)
+		return dev->platform_pm_ops->set_wakeup(dev, enable);
+
 	if (pci_use_mid_pm())
 		return PCI_POWER_ERROR;
 
@@ -1061,6 +1079,9 @@ static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->need_resume)
+		return dev->platform_pm_ops->need_resume(dev);
+
 	if (pci_use_mid_pm())
 		return false;
 
@@ -1069,6 +1090,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
+	if (dev->platform_pm_ops && dev->platform_pm_ops->bridge_d3)
+		return dev->platform_pm_ops->bridge_d3(dev);
+
 	if (pci_use_mid_pm())
 		return false;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..85154470c083 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -71,6 +71,42 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
  */
 #define PCI_RESET_WAIT		1000	/* msec */
 
+/**
+ * struct pci_platform_pm_ops - Firmware PM callbacks
+ *
+ * @is_manageable: returns 'true' if given device is power manageable by the
+ *                 platform firmware
+ *
+ * @set_state: invokes the platform firmware to set the device's power state
+ *
+ * @get_state: queries the platform firmware for a device's current power state
+ *
+ * @choose_state: returns PCI power state of given device preferred by the
+ *                platform; to be used during system-wide transitions from a
+ *                sleeping state to the working state and vice versa
+ *
+ * @set_wakeup: enables/disables wakeup capability for the device
+ *
+ * @need_resume: returns 'true' if the given device (which is currently
+ *		suspended) needs to be resumed to be configured for system
+ *		wakeup.
+ *
+ * @bridge_d3: return 'true' if given device supoorts D3 when it is a bridge
+ *
+ * @refresh_state: refresh the given device's power state
+ *
+ */
+struct pci_platform_pm_ops {
+	bool (*is_manageable)(struct pci_dev *dev);
+	int (*set_state)(struct pci_dev *dev, pci_power_t state);
+	pci_power_t (*get_state)(struct pci_dev *dev);
+	pci_power_t (*choose_state)(struct pci_dev *dev);
+	int (*set_wakeup)(struct pci_dev *dev, bool enable);
+	bool (*need_resume)(struct pci_dev *dev);
+	bool (*bridge_d3)(struct pci_dev *dev);
+	void (*refresh_state)(struct pci_dev *dev);
+};
+
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
@@ -96,6 +132,10 @@ void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
+static inline void pci_set_platform_pm(struct pci_dev *dev, struct pci_platform_pm_ops *ops)
+{
+	dev->platform_pm_ops = ops;
+}
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
 	/* Wait 100 ms before the system can be put into a sleep state. */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60b8772b5bd4..a0171f1abf2f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -327,6 +327,7 @@ struct pci_dev {
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
 	struct pci_slot	*slot;		/* Physical slot this device is in */
+	struct pci_platform_pm_ops *platform_pm_ops;
 
 	unsigned int	devfn;		/* Encoded device & function index */
 	unsigned short	vendor;
-- 
2.17.0

