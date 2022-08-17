Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C897B597617
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiHQSwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbiHQSwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 14:52:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB52A345E
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 11:52:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v65-20020a626144000000b0052f89472f54so5386827pfb.11
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=RLpinC4qkrZbZI+4KlQ1QZE5JL6xeEEFzKOVknzZL9M=;
        b=MO8FrME72TKekDQwq5U8pWml0kG+qG0t6xWFuFMtN1tsjLhhjS2GmjMx/vCfGlycK1
         9Lv47vxOBmwWQC78T6PEck0Qi5PKVDQxk1yVEOJUcxUrSZ18K4ciAVY9F9GI1WEIebvn
         FVmxeaTE7+ms+Z7PNbr3j05vWr3dJ83ruVDAg3Y6xGJ8ik8i10ySGAnb9T0Bkvx0Fpm7
         XuPfCcb+SLagF61j66ne4NA3Wj4oKNvhHqZn0Howu4BSomThi5Blbjqmj+TNukFVYadY
         T/WqUwr6/Mg4gzucbHh3EYsN8YjCrIVz9gdMzt9rPTDS9cqZRszYstEFrTbJ1bgD0ska
         K8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=RLpinC4qkrZbZI+4KlQ1QZE5JL6xeEEFzKOVknzZL9M=;
        b=gZY83qvQRaAzhMQX/3f3iuTwujlw+St35n+10iIBpiKpGsZVvAjqwrnkXdxzPNW5e0
         vs/Hz07m7U6q/3jfITF6Yzl4DiNhMvspmsfpDRwhTKZOrbPPg++3kmpBBGk2bjIA0e43
         ahbAWCI/0/SDIwhjzwBtBtwWCkwYFi9em5VXXECdHg+GEUbScr22aBd1y31UuaFXj9Ac
         nwgoEKsi1e6/5j9bRfqz5XE2LmKqURoPGeOI1Pv/4yb8qTSEZBmPylZiPQhPGWTpOKfQ
         7RFOwn33a8DqZueVqieKMe7OoY5J7Kqd2pgYGx0bJ4rYyiTLkMA8rgFVTlFJC6uOeESc
         s2cw==
X-Gm-Message-State: ACgBeo3BQVygGbz+800Nv834HyNY8OsyyyBiSjtZcANUon/2nvFXxNJI
        bwsy16KyWaBNhU4R5/H8dVKoCCDFOtRI6abJHLY=
X-Google-Smtp-Source: AA6agR4wMuz1uiglo86S5niRHbcNnydClo48r92AkKFaNl/ZAKmF/orxRQKdbzAsAmA1k0oejIx/WWnEQX2GSJTxPEs=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with
 SMTP id h4-20020a056a001a4400b0052aecd5bbefmr26461836pfv.28.1660762325512;
 Wed, 17 Aug 2022 11:52:05 -0700 (PDT)
Date:   Wed, 17 Aug 2022 18:52:02 +0000
Message-Id: <20220817185202.1689955-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] PCI/PM: Switch D3Hot delay to also use usleep_range
From:   Will McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Will McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sajid Dalvi <sdalvi@google.com>

Since the PCI spec requires a 10ms D3Hot delay (defined by
PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
to 120ms, let's add support for both usleep_range and msleep based on
the delay time to improve the delay accuracy.

This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
10ms delay for the Exynos PCIe device was on average delaying for 19ms
when the spec requires 10ms. Switching from msleep to uslseep_range
therefore decreases the resume time on a Pixel 6 on average by 9ms.

[1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/pci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..97a042ca9032 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -63,16 +63,26 @@ struct pci_pme_device {
 };
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
+#define MAX(a, b) ((a) >= (b) ? (a) : (b))
 
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
-	unsigned int delay = dev->d3hot_delay;
+	unsigned int delay_ms = dev->d3hot_delay;
 
-	if (delay < pci_pm_d3hot_delay)
-		delay = pci_pm_d3hot_delay;
+	if (delay_ms < pci_pm_d3hot_delay)
+		delay_ms = pci_pm_d3hot_delay;
 
-	if (delay)
-		msleep(delay);
+	if (delay_ms) {
+		if (delay_ms <= 20) {
+			/* Use a 20-25% upper bound with 1ms minimum */
+			unsigned int upper = MAX((delay_ms >> 3) << 1, 1);
+
+			usleep_range(delay_ms * USEC_PER_MSEC,
+				     (delay_ms + upper) * USEC_PER_MSEC);
+		} else {
+			msleep(delay_ms);
+		}
+	}
 }
 
 bool pci_reset_supported(struct pci_dev *dev)

base-commit: 274a2eebf80c60246f9edd6ef8e9a095ad121264
-- 
2.37.1.595.g718a3a8f04-goog

