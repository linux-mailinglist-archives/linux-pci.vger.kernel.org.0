Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031562D25D1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgLHI0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 03:26:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34652 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgLHI0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 03:26:36 -0500
Received: from 36-229-231-79.dynamic-ip.hinet.net ([36.229.231.79] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kmYJb-0007bo-CD; Tue, 08 Dec 2020 08:25:44 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] PCI/ASPM: Store disabled ASPM states
Date:   Tue,  8 Dec 2020 16:25:33 +0800
Message-Id: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we use sysfs to disable L1 ASPM, then enable one L1 ASPM substate
again, all other substates will also be enabled too:

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:1
l1_1_pcipm:1
l1_2_aspm:1
l1_2_pcipm:1
l1_aspm:1

link# echo 0 > l1_aspm

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:0
l1_1_pcipm:0
l1_2_aspm:0
l1_2_pcipm:0
l1_aspm:0

link# echo 1 > l1_2_aspm

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:1
l1_1_pcipm:1
l1_2_aspm:1
l1_2_pcipm:1
l1_aspm:1

This is because disabled ASPM states weren't saved, so enable any of the
substate will also enable others.

So store the disabled ASPM states for consistency.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..2ea9fddadfad 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -658,6 +658,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
+	link->aspm_disable = link->aspm_capable & ~link->aspm_default;
+
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		u32 reg32, encoding;
@@ -1226,11 +1228,15 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	mutex_lock(&aspm_lock);
 
 	if (state_enable) {
-		link->aspm_disable &= ~state;
 		/* need to enable L1 for substates */
 		if (state & ASPM_STATE_L1SS)
-			link->aspm_disable &= ~ASPM_STATE_L1;
+			state |= ASPM_STATE_L1;
+
+		link->aspm_disable &= ~state;
 	} else {
+		if (state == ASPM_STATE_L1)
+			state |= ASPM_STATE_L1SS;
+
 		link->aspm_disable |= state;
 	}
 
-- 
2.29.2

