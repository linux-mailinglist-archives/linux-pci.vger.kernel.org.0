Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8E7E0FAB
	for <lists+linux-pci@lfdr.de>; Sat,  4 Nov 2023 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKDNck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Nov 2023 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjKDNci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Nov 2023 09:32:38 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6ED42;
        Sat,  4 Nov 2023 06:32:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VvcM-OX_1699104747;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VvcM-OX_1699104747)
          by smtp.aliyun-inc.com;
          Sat, 04 Nov 2023 21:32:28 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: [PATCH v10 3/5] PCI: move pci_clear_and_set_dword helper to pci header
Date:   Sat,  4 Nov 2023 21:32:14 +0800
Message-Id: <20231104133216.42056-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clear and set pattern is commonly used for accessing pci config,
move the helper pci_clear_and_set_dword from aspm.c into pci header.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/access.c    | 12 ++++++++++++
 drivers/pci/pcie/aspm.c | 11 -----------
 include/linux/pci.h     |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6554a2e89d36..526360481d99 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
 EXPORT_SYMBOL(pci_write_config_dword);
+
+void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
+				    u32 clear, u32 set)
+{
+	u32 val;
+
+	pci_read_config_dword(dev, pos, &val);
+	val &= ~clear;
+	val |= set;
+	pci_write_config_dword(dev, pos, val);
+}
+EXPORT_SYMBOL(pci_clear_and_set_dword);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..f4e64fedc048 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -423,17 +423,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
-				    u32 clear, u32 set)
-{
-	u32 val;
-
-	pci_read_config_dword(pdev, pos, &val);
-	val &= ~clear;
-	val |= set;
-	pci_write_config_dword(pdev, pos, val);
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..271f30fd7ca4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1213,6 +1213,8 @@ int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val);
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
+void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
+				    u32 clear, u32 set);
 
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-- 
2.39.3

