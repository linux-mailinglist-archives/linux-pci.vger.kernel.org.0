Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0D614313
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 03:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKACMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 22:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKACMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 22:12:08 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D12B31741A;
        Mon, 31 Oct 2022 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7JpQD
        TRO14UjkY6Gjl6llkqWx+hpMjtf/mA9QfbxVYo=; b=NEYZvPs+lnWZj6E/h2SOM
        jjrc0sT35QhVLoYtD4SzoekZsYv+QWsV/1SIHFxMHp5du2U8iE+OXO75LMhr3EE+
        ON8H3bkahsaNIwo8heXSR+BTRB/oM0lzwFCVLLXutG8taR+0cFX5X5wEgmKokDDr
        QAnkS8hOaXom5q05pkah9k=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.68.52])
        by smtp13 (Coremail) with SMTP id EcCowABHzI85gGBjaxd2mw--.40980S2;
        Tue, 01 Nov 2022 10:11:07 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org
Cc:     dnlplm@gmail.com, yonglin.tan@outlook.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v3] PCI: Add vendor ID for QUECTEL
Date:   Tue,  1 Nov 2022 10:10:52 +0800
Message-Id: <20221101021052.7532-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABHzI85gGBjaxd2mw--.40980S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDWr1xCw1kZw47WF1rZwb_yoW8trWrpF
        s09ryvvF4qqrWUtw1kK3ykXF98ZanxCF9FkFyagw4FgFsFya1Fqr9FvrWYyryagFWvqF4a
        qF1DurZ8G3WqyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEZXOZUUUUU=
X-Originating-IP: [223.104.68.52]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxusZFc7ZI139AAAsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

n MHI driver, there are some companies' product still do not have their
own PCI vendor macro. So we add it here to make the code neat. Ref ID
could be found in link https://pcisig.com/membership/member-companies.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v3: Separate different vendors into different patch.

v2: Update vendor ID to the right location sorted by numeric value.
---
 drivers/bus/mhi/host/pci_generic.c | 6 +++---
 include/linux/pci_ids.h            | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index caa4ce28cf9e..81ae9c49ce2a 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -555,11 +555,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
-	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..3c91461bcfe4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2585,6 +2585,8 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_QUECTEL		0x1eac
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.34.1

