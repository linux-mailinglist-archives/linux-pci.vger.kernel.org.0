Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20716DC6CE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 14:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDJMeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJMeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 08:34:20 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A77330FA;
        Mon, 10 Apr 2023 05:34:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VfnWdpg_1681130050;
Received: from L-PF27918B-1352.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VfnWdpg_1681130050)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 20:34:15 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     lukas@wunner.de, sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Date:   Mon, 10 Apr 2023 20:34:11 +0800
Message-Id: <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
References: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
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

NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
card is direct attached to a Root Port only. So avoid bus reset by
marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.

Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
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

