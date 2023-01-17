Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626266DB7F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 11:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjAQKtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjAQKtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 05:49:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A94302BF;
        Tue, 17 Jan 2023 02:49:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mp20so27778842ejc.7;
        Tue, 17 Jan 2023 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuaI7HnIZyG0fRa/jgz3CE2/4ZxeGjEPtxv49RcTc3c=;
        b=BulVPYSG/zGDhw+AdNH2RQMc/BdqfZwU0TOqLpIX/pTvsgd97KpkpF2maR8OEQuB7z
         xT5atGxwfIHBEPrnhWiIAveMxT2rRlkoyO/sEke9V2Uit6E0jR8/4n0pn0M5QK8yUzRu
         IZiB/XrGboUcBD8IVbcHHYh4JXzSXadNY3NnnB5fqgSHN7qw5e2G8PxKgYX9wjb9sDT9
         wm+U+JOsO4RF0VqU0hJZk5f2ZbOfkA2eoS+jLRxd0++7u+65IuUzR5LPQyOF1AWsA/nl
         +8mGn7BKKVUY6tnsvjfuSs0IKDSe8oVb2vYuqB6aDLVBxJ4pJOuRGl/dSCImMWBSneAJ
         vGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuaI7HnIZyG0fRa/jgz3CE2/4ZxeGjEPtxv49RcTc3c=;
        b=g5Sam6JGCR1lsppWsn/bO7qrFxqGHhJPBukVwdsqeRfNuFEvAxhzkIoU3cGccJ6/5V
         ZcF9d5BjI290R3RcU+oVlvJ47LXhj2ecSp7ZpFNiRjLYXFGVia0+LeowSJSoPOYJUtei
         nqMBIxnFf8GzcvwHlM2GOmLmKJTArPG+amvYymdjmzHyoYcmyaSdabDSYncP1mdduxrX
         ctPsTxQkDmhx8iuNHTQqHtJl3G03Y4EUsiBf1JV8Bk3oLBPr83T32opWBxpnm9vSUqUJ
         fbCs4UXh3jYNoBTlnVIlkkJ7BWvgCp6Jwn8txVpGGD7J+NcTMRu1PSIydwYA70/J6w33
         ve9Q==
X-Gm-Message-State: AFqh2kog7lJNSrc+ftCktxoeRRzFOzHBIEMpE8mroAQGtwXG8FsHeeDQ
        r5CMd59bOiuSjd+6Q8MWrb2tAe1SApACWA==
X-Google-Smtp-Source: AMrXdXuMjOXZPp0x4cT+w3EpgnBoxWwZ8qUrmVfris5ntiId9iczztwI96C0i7ABZPvkXhSzoxVMgw==
X-Received: by 2002:a17:906:1c81:b0:86f:d1c4:ed08 with SMTP id g1-20020a1709061c8100b0086fd1c4ed08mr2267497ejh.69.1673952578503;
        Tue, 17 Jan 2023 02:49:38 -0800 (PST)
Received: from [0.0.0.0] (tor-exit-13.zbau.f3netze.de. [2a0b:f4c0:16c:13::1])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b0049ac6f53e6asm1877329edt.80.2023.01.17.02.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:49:38 -0800 (PST)
From:   Edward Chow <persmule@gmail.com>
X-Google-Original-From: Edward Chow <equu@openmail.cc>
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Edward Chow <equu@openmail.cc>
Subject: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
Date:   Tue, 17 Jan 2023 17:27:46 +0800
Message-Id: <20230117092746.1149155-1-equu@openmail.cc>
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

Loading calibration data from an OF device tree node not declared
compatible with the device (e.g. a PCI device with calibration data
from corresponding DT node gets replaced, so the newly installed
device become incompatible with the node) or driver may lead to fatal
result, e.g. kernel panic.

The driver should check whether the DT node corresponding to the
device compatible with it, and load calibration data only from
compatible node.

Signed-off-by: Edward Chow <equu@openmail.cc>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  1 +
 drivers/net/wireless/ath/ath9k/init.c  | 26 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath9k/pci.c   |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 2cc23605c9fc..4f6f0383a5f8 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -35,6 +35,7 @@ struct ath_node;
 struct ath_vif;
 
 extern struct ieee80211_ops ath9k_ops;
+extern struct pci_driver ath_pci_driver;
 extern int ath9k_modparam_nohwcrypt;
 extern int ath9k_led_blink;
 extern bool is_ath9k_unloaded;
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 4f00400c7ffb..f88a48e8456b 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/pci.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/relay.h>
 #include <linux/dmi.h>
@@ -577,6 +578,31 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	size_t len;
 	int err;
 
+	/* devm_nvmem_cell_get() will get a cell first from the OF
+	 * DT node representing the given device with nvmem-cell-name
+	 * "calibration", and from the global lookup table as a fallback,
+	 * and an ath9k device could be either a pci one or a platform one.
+	 *
+	 * If the OF DT node is not compatible with the real device, the
+	 * calibration data got from the node should not be applied.
+	 *
+	 * dev_is_pci(sc->dev) && ( no OF node || caldata not from node
+	 * || not compatible ) -> do not use caldata .
+	 *
+	 * !dev_is_pci(sc->dev) -> always use caldata .
+	 */
+	if (dev_is_pci(sc->dev) &&
+	    (!sc->dev->of_node ||
+	     !of_property_match_string(sc->dev->of_node,
+				       "nvmem-cell-names",
+				       "calibration") ||
+	     !of_pci_node_match_driver(sc->dev->of_node,
+				       &ath_pci_driver)))
+		/* follow the "just return 0;" convention as
+		 * noted below.
+		 */
+		return 0;
+
 	cell = devm_nvmem_cell_get(sc->dev, "calibration");
 	if (IS_ERR(cell)) {
 		err = PTR_ERR(cell);
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index a074e23013c5..fcb19761e60d 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -1074,7 +1074,7 @@ static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
 
 MODULE_DEVICE_TABLE(pci, ath_pci_id_table);
 
-static struct pci_driver ath_pci_driver = {
+struct pci_driver ath_pci_driver = {
 	.name       = "ath9k",
 	.id_table   = ath_pci_id_table,
 	.probe      = ath_pci_probe,
-- 
2.39.0

