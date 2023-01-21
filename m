Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB1676591
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAUKEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Jan 2023 05:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUKEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 05:04:42 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAF65EDC;
        Sat, 21 Jan 2023 02:04:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id az20so19669927ejc.1;
        Sat, 21 Jan 2023 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFsFRg5RfveDHrVd5rP7zwnXWjQK+oYVFSSoe+tPeXw=;
        b=Jj7Dy3+LLiPdBvAlYJp3+zJIodOkOFiksEI2pP/I6babOKOr+gv4y5L7N3VJqmBEoi
         vQoeZvtPojAtqhRc2JTn1Iz6wHkDzUmGlW97AA9D69aCDJC0cei67YUL9wOm3abggcmS
         zipZFdO6v3962PvVf01trernDsiGneXNgOYOfW19I04BCEZVE+GJeDRIq8U9S0DH5UyW
         acjUBGuooGgvTfp26uPTLf699XJfVTat8x9AvCODtjgezfU9wazkWXX9zKQbOrGf0lIe
         BYzOQsXbS1yyOFz5zx3pxqTg86tKdF0K4ff/KtDYaCZdKP8zL6aii8wI9mGvjEwYKvks
         OwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFsFRg5RfveDHrVd5rP7zwnXWjQK+oYVFSSoe+tPeXw=;
        b=QvBg4MBwljsx7b4mcSQ0C5/2pMZoqF9WN3lMrwJSqTtEm1tPDf5pZ8ZpBPCycVbP/m
         fPQ7Ozl+gG3vqlfb+QBs93lvLNF0WhUO+MT+pX6IJqz8jSEc2PsmY/3F4iWVnucQzfSz
         037bDqztl/VVTWtVOqOO9HOSvXXw/roa3V++ferVdHVij92s5W3NnD2riJH4YrFrhbBq
         ldgJoY9fqYtHoMBh2UvtOU7HZ+pgzsdv5SRxTuQw54IcVWIKJaeWwOvoQGDSLpqtl7C5
         If3SFDDLh4x1v8CyfDOdEGwWRE/42wH8OmYWCzbbTShPwWx+ZrKXuQhftdc+SHiJIE2U
         zlsA==
X-Gm-Message-State: AFqh2kofyCs/tnLwuQOTSLEBrZp74Bs+qZbRKrvuCQut9NmxRv+ozIxg
        aveMaK/3X7RHPJCfjUmc+UM=
X-Google-Smtp-Source: AMrXdXsBi+GE/siU9cL+3WOKY7qtamXDMRh7RT8xax/vg8C7zX2vxKrmKrcKgL4RFLvccYLYvHKi9w==
X-Received: by 2002:a17:906:ddb:b0:7b2:757a:1411 with SMTP id p27-20020a1709060ddb00b007b2757a1411mr28388788eji.9.1674295478807;
        Sat, 21 Jan 2023 02:04:38 -0800 (PST)
Received: from [0.0.0.0] (tor-exit-46.for-privacy.net. [2a0b:f4c2:2::46])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00857c2c29553sm14854715ejn.197.2023.01.21.02.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 02:04:38 -0800 (PST)
From:   persmule@gmail.com
X-Google-Original-From: equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc
Subject: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
Date:   Sat, 21 Jan 2023 18:00:43 +0800
Message-Id: <20230121100043.1497633-1-equu@openmail.cc>
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

As reported in https://github.com/openwrt/openwrt/pull/11345 , ath9k
would load calibration data from a device tree node declared
incompatible.

Now, ath9k will first check whether the device tree node is compatible
with it, using the functionality introduced with the first patch of
this series, ("PCI: of: Match pci devices or drivers against OF DT
nodes") and only proceed loading calibration data from compatible node.

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

