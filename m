Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26F54928A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357368AbiFMNL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359251AbiFMNJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 09:09:44 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122128E03
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 04:19:42 -0700 (PDT)
X-QQ-mid: bizesmtp79t1655119156t8v5z557
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 13 Jun 2022 19:19:09 +0800 (CST)
X-QQ-SSF: 01400000002000G0Q000B00A0000000
X-QQ-FEAT: JRmPfD6HWhzxxqXoKc4lDmEGgd/42n5znbX7pLGemLE3r5lVrjvC2ONwBaySs
        /HuRfbQD393oA3em2mY77GLsVsnkiePKD5SadgPjLo1d13QXsIMi0BBoqV4FR251RVPdAAs
        3t/1R1R8pTObL98w6dYSHSzn4JYEpq8Rr5OjkUICeUm80FPrex1f/2BM2RWJ6fMW4sGubQx
        CjqSv/kzt7T+KbtAbE+gElb/ABHEYlBRJhZlbMc+SzeBUWOWUi4Vwve+MsCeFvueQUpIlD7
        p1dYJbRoy1fNE56Qu+Cvc7iB64jitvBFbq6E7fWNsF1H91xV9Jhja84L9IWckKPCix1uJTO
        Hpx1Ugp4Hr0w4quf70Pi9YlK4FRrdgreGz7M7jN
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, bhelgaas@google.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH 5.10 1/2] commit 1d71eb53e451 ("Revert "PCI: Make pci_enable_ptm() private"")
Date:   Mon, 13 Jun 2022 19:19:06 +0800
Message-Id: <20220613111907.25490-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Make pci_enable_ptm() accessible from the drivers.

Exposing this to the driver enables the driver to use the
'ptm_enabled' field of 'pci_dev' to check if PTM is enabled or not.

This reverts commit ac6c26da29c1 ("PCI: Make pci_enable_ptm() private").

In the 5.10 kernel version, even to the latest confirmed version,
the following error will still be reported when I225-V network card
is used.

kernel: [    1.031581] igc: probe of 0000:01:00.0 failed with error -2
kernel: [    1.066574] igc: probe of 0000:02:00.0 failed with error -2
kernel: [    1.096152] igc: probe of 0000:03:00.0 failed with error -2
kernel: [    1.127251] igc: probe of 0000:04:00.0 failed with error -2

Even though I confirmed that 7c496de538eebd8212dc2a3c9a468386b2640d4
and 47bca7de6a4fb8dcb564c7ca4d885c91ed19e03 have been merged into the
kernel 5.10, the bug is still occurred, and the
"commit 1b5d73fb8624 ("igc: Enable PCIe PTM")" can fixes it.

And this patch is the pre-patch of
1b5d73fb862414106cf270a1a7300ce8ae77de83.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/pci/pci.h   | 3 ---
 include/linux/pci.h | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a96dc6f53076..4084764bf0b1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -585,11 +585,8 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 #else
 static inline void pci_ptm_init(struct pci_dev *dev) { }
-static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
-{ return -EINVAL; }
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bc5a1150f072..692ce678c5f1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1599,6 +1599,13 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 
+#ifdef CONFIG_PCIE_PTM
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
+#else
+static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{ return -EINVAL; }
+#endif
+
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
-- 
2.20.1



