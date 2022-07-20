Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04F57B1A6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiGTHWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 03:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiGTHWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 03:22:40 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF938675A0;
        Wed, 20 Jul 2022 00:22:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJvpBsw_1658301723;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VJvpBsw_1658301723)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 15:22:36 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: eliminate abnormal characters when reads help information of "PCI_P2PDMA" under menuconfig
Date:   Wed, 20 Jul 2022 15:22:03 +0800
Message-Id: <1658301723-111283-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Read the help information of PCI_P2PDMA through make menuconfig,
"Enables" is partially displayed as garbled characters, so fix it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 133c732..8102b78 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -166,7 +166,7 @@ config PCI_P2PDMA
 	depends on ZONE_DEVICE
 	select GENERIC_ALLOCATOR
 	help
-	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
+	  Enables drivers to do PCI peer-to-peer transactions to and from
 	  BARs that are exposed in other devices that are the part of
 	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
 	  specification to work (ie. anything below a single PCI bridge).
-- 
1.8.3.1

