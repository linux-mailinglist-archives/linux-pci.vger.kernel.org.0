Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D86F9754
	for <lists+linux-pci@lfdr.de>; Sun,  7 May 2023 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEGHgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGHgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 03:36:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD4132BD
        for <linux-pci@vger.kernel.org>; Sun,  7 May 2023 00:36:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f389c519e5so3130901cf.2
        for <linux-pci@vger.kernel.org>; Sun, 07 May 2023 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oobak.org; s=ghs; t=1683444965; x=1686036965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKDZorWA8bxcpIoWQc9u4DPSLdhcXPQtyOtwgtWCV8Y=;
        b=fpswxqYKS06GeJF40Y+9wmbWBDNjJleXBOao7KIB1qsgb+mDki6UhRxMC02379B48E
         JY7QQieo2pRKVxyiYknA8lLOv9MKEbwsmEIPbarDj2j7ybkxU3qt2tSnQu49aGh65hVe
         buFG0fXwnlSYJWMzmiVhcnWi0skkwA1zixS6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683444965; x=1686036965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKDZorWA8bxcpIoWQc9u4DPSLdhcXPQtyOtwgtWCV8Y=;
        b=GMQoXPVhZydUrMPljFZOJN/of8TKtXtLHk40FcQKqaOZvOP+92Cr4N5aotJhdpQDTD
         Cy5IC7Rb1Lj/kELzglLL3r3zmmhVR9cuhpFnEL+1E65P9SeEvP6dBnmDNb+DkCIclWsR
         oWRns83FIzDEbyEoxPZLkYa26lCKTfgSquFrep+qTM3gIDNBJ37sizmSSTqbaBO5vVLv
         o3ocSfWkPjGpq6BpHEvBkw4CfDRhPqrlJJHlv7iYD1vBE+vxJZOzrxdnl4XT4oHGciRY
         2S88Is1XfnneV29Glz108bsbTmv325lvI/uSefElFn20AkIRP1FsCvi1v4JuL0AbH8Id
         bZfQ==
X-Gm-Message-State: AC+VfDxXor4RX01QeFT26xI2lAo08dWtr1BmR7rD13C2PCTptqJROx1y
        3j095vZBU7Mc0dTBI6+R2ycmSpCOU10/KCBoCmwRsg==
X-Google-Smtp-Source: ACHHUZ7T761G0qiKBvd4ajbLCaJG4BNMMfeDv76kQsbTeb9CuVGEKOejYwnhMaReiUmo3QCgfh+Wmw==
X-Received: by 2002:ac8:7c4d:0:b0:3f1:a6d:d976 with SMTP id o13-20020ac87c4d000000b003f10a6dd976mr10073290qtv.48.1683444964631;
        Sun, 07 May 2023 00:36:04 -0700 (PDT)
Received: from hyperion.jumbo (162-198-119-188.lightspeed.cicril.sbcglobal.net. [162.198.119.188])
        by smtp.gmail.com with ESMTPSA id x18-20020ac87012000000b003ef3df76ec7sm2035108qtm.93.2023.05.07.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 00:36:04 -0700 (PDT)
From:   Mike Pastore <mike@oobak.org>
To:     linux-pci@vger.kernel.org
Cc:     Mike Pastore <mike@oobak.org>
Subject: [PATCH] PCI: Apply Intel NVMe quirk to Solidigm P44 Pro
Date:   Sun,  7 May 2023 02:35:19 -0500
Message-Id: <20230507073519.9737-1-mike@oobak.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prevent KVM hang when a Solidgm P44 Pro NVMe is passed through to a
guest via IOMMU and the guest is subsequently rebooted.

A similar issue was identified and patched in commit 51ba09452d11b
("PCI: Delay after FLR of Intel DC P3700 NVMe") and the same fix can be
aplied for this case. (Intel spun off their NAND and SSD business as
Solidigm and sold it to SK Hynix in late 2021.)

Signed-off-by: Mike Pastore <mike@oobak.org>
---
 drivers/pci/quirks.c    | 10 ++++++----
 include/linux/pci_ids.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..b47844d0e574 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3980,10 +3980,11 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 }
 
 /*
- * Intel DC P3700 NVMe controller will timeout waiting for ready status
- * to change after NVMe enable if the driver starts interacting with the
- * device too soon after FLR.  A 250ms delay after FLR has heuristically
- * proven to produce reliably working results for device assignment cases.
+ * Some NVMe controllers such as Intel DC P3700 and Solidigm P44 Pro will
+ * timeout waiting for ready status to change after NVMe enable if the driver
+ * starts interacting with the device too soon after FLR.  A 250ms delay after
+ * FLR has heuristically proven to produce reliably working results for device
+ * assignment cases.
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
@@ -4070,6 +4071,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0a54, delay_250ms_after_flr },
+	{ PCI_VENDOR_ID_SOLIDIGM, 0xf1ac, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..6105eddf41bf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3119,4 +3119,6 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_SOLIDIGM		0x025e
+
 #endif /* _LINUX_PCI_IDS_H */

base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
-- 
2.39.2

