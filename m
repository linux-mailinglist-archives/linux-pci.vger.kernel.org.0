Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE38E6CD8F9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjC2L7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjC2L64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 07:58:56 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288A4219;
        Wed, 29 Mar 2023 04:58:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VewkHe8_1680091126;
Received: from L-PF27918B-1352.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VewkHe8_1680091126)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 19:58:51 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: [RFC PATCH] PCI: avoid SBR for NVIDIA T4
Date:   Wed, 29 Mar 2023 19:58:45 +0800
Message-Id: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Secondary bus reset will fail if NVIDIA T4 card is direct attached to a
root port.
So avoid to do bus reset,  pci_parent_bus_reset() works nomarlly.

Maybe NVIDIA guys can do some detailed explanation abount the SBR
behaviour of GPUs.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..be86b93b9e38 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340)
+	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-- 
2.34.3

