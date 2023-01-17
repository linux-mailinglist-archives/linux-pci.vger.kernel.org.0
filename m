Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B466DA82
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjAQKCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjAQKCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 05:02:17 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345182CC42
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 02:02:11 -0800 (PST)
Received: (qmail 4848 invoked from network); 17 Jan 2023 10:02:09 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 17 Jan 2023 10:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=message-id
        :date:mime-version:from:subject:to:cc:references:in-reply-to
        :content-type:content-transfer-encoding; s=2018; bh=L+rMzQSSkhYD
        hyenFOgvbcK2x6CTqryk2Wq/QyYjE4A=; b=Ou81syCpMR3Tj79IREn/gD5KRpfg
        Fv0at5o0gUhOEDChV0+cK+6sK6n64ePwSA6HgrtpmH0DiDOGV7/rmXDfluDtHZiB
        pz2bC3tWDF0/6uyaCsCwz4f6DNkuYd4bBXeJ2DlLrECNluZKnkDBBJFd+wuQQrIM
        k4d7jpjDtmtm1Dg=
Received: (qmail 67038 invoked from network); 17 Jan 2023 10:02:09 -0000
Received: by simscan 1.4.0 ppid: 66860, pid: 67030, t: 0.4029s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 17 Jan 2023 10:02:08 -0000
Message-ID: <1455ecdd-e954-29ae-2d64-fa3695987d8a@openmail.cc>
Date:   Tue, 17 Jan 2023 18:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Mad Horse <equu@openmail.cc>
Subject: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Edward Chow <equu@openmail.cc>
References: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
Content-Language: en-US
In-Reply-To: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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
drivers/net/wireless/ath/ath9k/ath9k.h | 1 +
drivers/net/wireless/ath/ath9k/init.c | 26 ++++++++++++++++++++++++++
drivers/net/wireless/ath/ath9k/pci.c | 2 +-
3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h 
b/drivers/net/wireless/ath/ath9k/ath9k.h
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
diff --git a/drivers/net/wireless/ath/ath9k/init.c 
b/drivers/net/wireless/ath/ath9k/init.c
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
@@ -577,6 +578,31 @@ static int ath9k_nvmem_request_eeprom(struct 
ath_softc *sc)
size_t len;
int err;
+ /* devm_nvmem_cell_get() will get a cell first from the OF
+ * DT node representing the given device with nvmem-cell-name
+ * "calibration", and from the global lookup table as a fallback,
+ * and an ath9k device could be either a pci one or a platform one.
+ *
+ * If the OF DT node is not compatible with the real device, the
+ * calibration data got from the node should not be applied.
+ *
+ * dev_is_pci(sc->dev) && ( no OF node || caldata not from node
+ * || not compatible ) -> do not use caldata .
+ *
+ * !dev_is_pci(sc->dev) -> always use caldata .
+ */
+ if (dev_is_pci(sc->dev) &&
+ (!sc->dev->of_node ||
+ !of_property_match_string(sc->dev->of_node,
+ "nvmem-cell-names",
+ "calibration") ||
+ !of_pci_node_match_driver(sc->dev->of_node,
+ &ath_pci_driver)))
+ /* follow the "just return 0;" convention as
+ * noted below.
+ */
+ return 0;
+
cell = devm_nvmem_cell_get(sc->dev, "calibration");
if (IS_ERR(cell)) {
err = PTR_ERR(cell);
diff --git a/drivers/net/wireless/ath/ath9k/pci.c 
b/drivers/net/wireless/ath/ath9k/pci.c
index a074e23013c5..fcb19761e60d 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -1074,7 +1074,7 @@ static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, 
ath_pci_suspend, ath_pci_resume);
MODULE_DEVICE_TABLE(pci, ath_pci_id_table);
-static struct pci_driver ath_pci_driver = {
+struct pci_driver ath_pci_driver = {
.name = "ath9k",
.id_table = ath_pci_id_table,
.probe = ath_pci_probe,

-- 
2.39.0

