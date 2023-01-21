Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5C676595
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 11:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAUKJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Jan 2023 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUKJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 05:09:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DEF35AF;
        Sat, 21 Jan 2023 02:09:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g11so3894210eda.12;
        Sat, 21 Jan 2023 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1uxvyAz6hoj3r1mdWr5bT2Vf+LqQaGKNfTdf9kLhLE=;
        b=J9dl2JU/P5A3sfB1dLu2Y+ujPg/SQg7vbptE945nrWrnmQ6xeCrXJPIG9CG2/5yBFJ
         iw4rEPmoDQvzgufBuP+MiJ4GZjlp1A5up1NqVVRp+CPbGmYDCqudGcyBlwZDN2fXtrKZ
         DThSmev4gLnFPUyzb3kiVHo/3K/X5CZOH53KR4teoNbrvjkcDtBKffwhy0p0AQipjUXL
         GHGGFE5/MmuJ+xggedsOMRGVL1TVZ4xU0o+TlTKzy9txTnDS3/2E8ZzSjru7EfkF0obU
         XTss7GpTlg9j1kf38GBT7+uif80M9amD+Ww/AeND7OiGo0nQm7c3e8BA2BPp/Ff+wkbE
         kuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1uxvyAz6hoj3r1mdWr5bT2Vf+LqQaGKNfTdf9kLhLE=;
        b=SHwqiURTvTORDmRYX5PxO56CdwVTXcvPnT6OUKsjOQQO59Zpflon6mdqwwD2zKMOvA
         7ZE/1IPFMc17KtI9HxMdSeS9aB7yeGEyWd3IFOXWH/U/BBnuf2/8/j7ghWHW9VSOtFX/
         +ftZUIL1L+6perR2LjxQUOx7AVzSoccYWGPHfSjBvliTUlnQfWeJm4UeZAhjnIeCzmhA
         NBWdILlEcMrWo2UEjApKgeenNaEYySoaxCfy94hnH2QnORtDfgBfBNNLNNYBvLjXPRSu
         MyL98dQLOLfsc9xtwajafDIpM8VadYqkz4btDueYpiLENt+UDS6W4Ys6gY2HKpx+w/Y+
         Y9vw==
X-Gm-Message-State: AFqh2kogvk9sNwKHzNKqFCBrgLyzlXqt2YQXa+7ydaKjyRXlXOkjMpEP
        72/P7K3G7hzp4LKE0kjIXDo=
X-Google-Smtp-Source: AMrXdXvL2WzeSiI/Wcc2ptSUO0E1YL+7yetmmSnzDt1hMj9sTIJX1jU2FHycX4QPW3XBdvjubOfC7Q==
X-Received: by 2002:aa7:dd48:0:b0:497:233d:3ef7 with SMTP id o8-20020aa7dd48000000b00497233d3ef7mr18912856edw.7.1674295759684;
        Sat, 21 Jan 2023 02:09:19 -0800 (PST)
Received: from [0.0.0.0] (tor-exit-9.zbau.f3netze.de. [2a0b:f4c0:16c:9::1])
        by smtp.gmail.com with ESMTPSA id v19-20020a509553000000b0046cbcc86bdesm18788515eda.7.2023.01.21.02.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 02:09:19 -0800 (PST)
From:   persmule@gmail.com
X-Google-Original-From: equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc
Subject: [PATCH 3/3] wifi: ath10k: only load compatible DT cal data
Date:   Sat, 21 Jan 2023 18:06:09 +0800
Message-Id: <20230121100609.1502170-1-equu@openmail.cc>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
References: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Edward Chow <equu@openmail.cc>

ath10k might also be sensitive to the issue reported on
https://github.com/openwrt/openwrt/pull/11345 , loading calibration
data from a device tree node declared incompatible.

ath10k will first check whether the device tree node is compatible
with it, using the functionality introduced with the first patch of
this series, ("PCI: of: Match pci devices or drivers against OF DT
nodes") and only proceed loading calibration data from compatible node.

Signed-off-by: Edward Chow <equu@openmail.cc>
---
 drivers/net/wireless/ath/ath10k/core.c | 28 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/pci.c  |  2 +-
 drivers/net/wireless/ath/ath10k/pci.h  |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916f..e4d7ec7f3b59 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -26,6 +26,7 @@
 #include "testmode.h"
 #include "wmi-ops.h"
 #include "coredump.h"
+#include "pci.h"
 
 unsigned int ath10k_debug_mask;
 EXPORT_SYMBOL(ath10k_debug_mask);
@@ -1958,6 +1959,33 @@ static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
 	size_t len;
 	int ret;
 
+	/* devm_nvmem_cell_get() will get a cell first from the OF
+	 * DT node representing the given device with nvmem-cell-name
+	 * "calibration", and from the global lookup table as a fallback,
+	 * and an ath9k device could be either a pci one or a platform one.
+	 *
+	 * If the OF DT node is not compatible with the real device, the
+	 * calibration data got from the node should not be applied.
+	 *
+	 * dev_is_pci(ar->dev) && ( no OF node || caldata not from node
+	 * || not compatible ) -> do not use caldata .
+	 *
+	 * !dev_is_pci(ar->dev) -> always use caldata .
+	 *
+	 * The judgement for compatibility differs with ath9k for many
+	 * DT using "qcom,ath10k" as compatibility string.
+	 */
+	if (dev_is_pci(ar->dev) &&
+	    (!ar->dev->of_node ||
+	     (of_property_match_string(ar->dev->of_node,
+				       "nvmem-cell-names",
+				       cell_name) < 0) ||
+	     !of_device_is_compatible(ar->dev->of_node,
+				      "qcom,ath10k") ||
+	     !of_pci_node_match_device(ar->dev->of_node,
+				       &ath10k_pci_driver)))
+		return ERR_PTR(-ENOENT);
+
 	cell = devm_nvmem_cell_get(ar->dev, cell_name);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 728d607289c3..5d9f6046f8cf 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3780,7 +3780,7 @@ static SIMPLE_DEV_PM_OPS(ath10k_pci_pm_ops,
 			 ath10k_pci_pm_suspend,
 			 ath10k_pci_pm_resume);
 
-static struct pci_driver ath10k_pci_driver = {
+struct pci_driver ath10k_pci_driver = {
 	.name = "ath10k_pci",
 	.id_table = ath10k_pci_id_table,
 	.probe = ath10k_pci_probe,
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 480cd97ab739..de676797b736 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -209,6 +209,8 @@ static inline struct ath10k_pci *ath10k_pci_priv(struct ath10k *ar)
 #define DIAG_ACCESS_CE_TIMEOUT_US 10000 /* 10 ms */
 #define DIAG_ACCESS_CE_WAIT_US	50
 
+extern struct pci_driver ath10k_pci_driver;
+
 void ath10k_pci_write32(struct ath10k *ar, u32 offset, u32 value);
 void ath10k_pci_soc_write32(struct ath10k *ar, u32 addr, u32 val);
 void ath10k_pci_reg_write32(struct ath10k *ar, u32 addr, u32 val);
-- 
2.39.0

