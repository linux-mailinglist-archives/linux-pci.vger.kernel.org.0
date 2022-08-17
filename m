Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF4597115
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiHQOad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 10:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiHQOaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 10:30:18 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F5201A6;
        Wed, 17 Aug 2022 07:30:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VMVnktW_1660746612;
Received: from localhost(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VMVnktW_1660746612)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 22:30:13 +0800
From:   Yang Su <yang.su@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: Use pci_bridge_wait_for_secondary_bus after SBR instead of ssleep(1)
Date:   Wed, 17 Aug 2022 22:30:11 +0800
Message-Id: <4315990a165dd019d970633713cf8e06e9b4c282.1660746147.git.yang.su@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1660746147.git.yang.su@linux.alibaba.com>
References: <cover.1660746147.git.yang.su@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far, pci_bridge_wait_for_secondary_bus() was only invoked by PM code
after (runtime) resume of devices, but it naturally makes sense for
handling post-SBR waiting as well.

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
pci_bridge_wait_for_secondary_bus() also can cover PCI and PCI-X after
device reset waiting Tpvrh + Trhfa (that is 1000ms + 100ms).

Currently, the only callchain that lands in the function modified by
this patch starts at pci_bridge_secondary_bus_reset which invokes
one out of two versions of pcibios_reset_secondary_bus that both end
with a call to pci_reset_secondary_bus.
Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait
which wait for the device to return a non-CRS completion.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
Signed-off-by: Yang Su <yang.su@linux.alibaba.com>
---
 drivers/pci/pci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..7c044d6e87e2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5074,14 +5074,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
-	/*
-	 * Trhfa for conventional PCI is 2^25 clock cycles.
-	 * Assuming a minimum 33MHz clock this results in a 1s
-	 * delay before we can consider subordinate devices to
-	 * be re-initialized.  PCIe has some ways to shorten this,
-	 * but we don't make use of them yet.
-	 */
-	ssleep(1);
+	pci_bridge_wait_for_secondary_bus(dev);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
2.19.1.6.gb485710b

