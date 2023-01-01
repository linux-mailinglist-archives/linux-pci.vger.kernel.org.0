Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8813765A97A
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jan 2023 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAAJWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Jan 2023 04:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAAJWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jan 2023 04:22:41 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A786250;
        Sun,  1 Jan 2023 01:22:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VYU0kJC_1672564955;
Received: from localhost(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VYU0kJC_1672564955)
          by smtp.aliyun-inc.com;
          Sun, 01 Jan 2023 17:22:36 +0800
From:   Yang Su <yang.su@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        matthew@wil.cx, jbarnes@virtuousgeek.org, rjw@sisk.pl,
        greg@kroah.com, patchwork-bot@kernel.org, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: Tune secondary bus reset time for PCIe
Date:   Sun,  1 Jan 2023 17:22:33 +0800
Message-Id: <03c5388700f8b0db95ede6084eaa6e59b84a23bf.1672563632.git.yang.su@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1672563632.git.yang.su@linux.alibaba.com>
References: <cover.1672563632.git.yang.su@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On PCI Express, there will be cases where the new code sleeps far less
than the 1s being replaced by this patch. This should be okay, because
PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019)
in Section 6.6.1 "Conventional Reset" only notes 100ms as the minimum
waiting time. After this time, the OS is permitted to issue
Configuration Requests, but it is possible that the device responds
with Configuration Request Retry Status (CRS) Completions, rather than
Successful Completion. Returning CRS can go on for up to 1 second after
a Conventional Reset (such as SBR) before the OS can consider the device
broken. This additional wait is handled by pci_dev_wait. Besides,
this patch also cover PCI and PCI-X after device reset waiting Tpvrh 1000ms.

Currently, the only callchain that lands in the function modified by
this patch which invokes one out of two versions of pcibios_reset_secondary_bus
that both end with a call to pci_reset_secondary_bus.

Afterwards, pci_reset_secondary_bus always invokes pci_dev_wait
which wait for the device to return a non-CRS completion.

Signed-off-by: Yang Su <yang.su@linux.alibaba.com>
---
 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..8e4899755718 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5063,10 +5063,40 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	 * Trhfa for conventional PCI is 2^25 clock cycles.
 	 * Assuming a minimum 33MHz clock this results in a 1s
 	 * delay before we can consider subordinate devices to
-	 * be re-initialized.  PCIe has some ways to shorten this,
-	 * but we don't make use of them yet.
+	 * be re-initialized.
+	 *
+	 * For conventional PCI needing 1s delay after bus reset.
+	 * Using pci_is_pcie to judge the bus is pci or pcie.
+	 * If the bus is pci, sleeping 1s to wait device is ready.
+	 *
+	 * And if the bus is pcie, PCI Express Base Specification Revision 2.0
+	 * (December 20, 2006) in Section 6.6.1 "Conventional Reset" only notes
+	 * 100ms as the minimum waiting time, the same as the newer PCIe spec
+	 * PCI Express Base Specification Revision 3.0 Version 1.a (December 7, 2015)
+	 * and PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019).
+	 * With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
+	 * software must wait a minimum of 100 ms after Link training completes before
+	 * sending a Configuration Request to the device immediately below that Port.
+	 * After this time, the OS is permitted to issue Configuration Requests,
+	 * but it is possible that the device responds with Configuration Request
+	 * Retry Status (CRS) Completions, rather than Successful Completion.
+	 * Returning CRS can go on for up to 1 second after a Conventional Reset
+	 * (such as SBR) before the OS can consider the device. This additional
+	 * wait is handled by pci_dev_wait.
+	 *
+	 * Currently, the only callchain that lands in the function modified by
+	 * this patch starts at pci_bridge_secondary_bus_reset which invokes
+	 * one out of two versions of pcibios_reset_secondary_bus that both end
+	 * with a call to pci_reset_secondary_bus.
+	 * Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait.
 	 */
-	ssleep(1);
+	if (pci_is_pcie(dev))
+		if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)
+			msleep(100);
+		else
+			pcie_wait_for_link(dev, true);
+	else
+		ssleep(1);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
2.19.1.6.gb485710b

