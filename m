Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE326142FD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 02:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKAB7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 21:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAB7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 21:59:34 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA417C0D;
        Mon, 31 Oct 2022 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=N0hM1
        nAyAcqMRYO7veUovn/zmY6ZVwxa+Voc4ePVpJI=; b=IYAMurcCVuXtOuUl63xR5
        kHW1ymWFPAyu2WW1rHRe4sznEJAGjEV18jCrgVqI4Fz4nWpePH3QsrqvuycjlHRc
        P1azNnpe3w7hYH+yXSxDLvX22eBaSULt+De6bDjccVFWGoJPyYlTRacFSK9HwqYo
        Vc5qJwGN99zEyrT+NkHNwo=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.68.52])
        by smtp7 (Coremail) with SMTP id C8CowABnLfJlfWBjwnq9PA--.32038S2;
        Tue, 01 Nov 2022 09:59:02 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com, bhelgaas@google.com,
        loic.poulain@linaro.org
Cc:     dnlplm@gmail.com, yonglin.tan@outlook.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v3] PCI: Add vendor ID for THALES
Date:   Tue,  1 Nov 2022 09:58:58 +0800
Message-Id: <20221101015858.6777-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABnLfJlfWBjwnq9PA--.32038S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDWr45uFyDWF1rAw4DXFb_yoW5Jr4xpF
        s0krW0yF4kJF4Ut3yvyF9ruF95Aa1DCFy5Kwn3Kw1F9F4Dta1Fgrn7ur4YvFyakayvqrWa
        qF1Du3yqgayqyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEuc_UUUUUU=
X-Originating-IP: [223.104.68.52]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQ+sZGBbF-yaewAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In MHI driver, there are some companies' product still do not have their
own PCI vendor macro. So we add it here to make the code neat. Ref ID
could be found in link https://pcisig.com/membership/member-companies.
We must clear that CINTERION belongs to THALES in case confusing user.
There are some descriptions about that in below link:
https://www.thalesgroup.com/en/markets/digital-identity-and-security/iot/iot-connectivity/products

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v3: Separate different vendors into different patch, and change macro
from CINTERION to THALES.

v2: Update vendor ID to the right location sorted by numeric value.
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++----
 include/linux/pci_ids.h            | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index caa4ce28cf9e..3ad39f5ac63b 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -583,16 +583,16 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
 	/* MV31-W (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00b3),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
 	/* MV31-W (Cinterion), based on new baseline */
-	{ PCI_DEVICE(0x1269, 0x00b4),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b4),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
 	/* MV32-WA (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00ba),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00ba),
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	/* MV32-WB (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00bb),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00bb),
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	{  }
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..298c8cae66ff 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1765,6 +1765,8 @@
 #define PCI_VENDOR_ID_SATSAGEM		0x1267
 #define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
 
+#define PCI_VENDOR_ID_THALES		0x1269
+
 #define PCI_VENDOR_ID_ENSONIQ		0x1274
 #define PCI_DEVICE_ID_ENSONIQ_CT5880	0x5880
 #define PCI_DEVICE_ID_ENSONIQ_ES1370	0x5000
-- 
2.34.1

