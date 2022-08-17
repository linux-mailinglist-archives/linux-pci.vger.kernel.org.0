Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6735979FF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 01:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiHQXIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 19:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbiHQXIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 19:08:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D9A50EA
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 16:08:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-324966c28e5so175450247b3.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=9DARCZGG6a+xR62bg4gT93kWvqUmu453nrgolGUXZfY=;
        b=KBg7JhiU7xZDTZHQzSpt8Co3R/MpdjzBaPHqgYVxIYReT1D0DTPRXb5nu4N8KoUSoh
         /JncsymfofPZemnrcGGomP2Y5KMIUXNg6gzxbHIcJvP3TOhspVIhG1fgfrOBZTwEnnSl
         Of3hBEwwojWPL1m++GjfNE+G4IzDL+YN3tn8B700Kk9aydR9V55NBfO43zt7XDPUgrKU
         aqeMZwbaD/6SmPMqZNnDsa0Wm1fUseobpjZtRftlFtLzRXcjKYMLauHvsBK+6/hbbANC
         PPNsyKXUOTU73viCgVCMgbGqKAZah2d1xCJHCrMOuA2L9UlgHVjv0Oh/tEebLHy/7V/v
         p5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=9DARCZGG6a+xR62bg4gT93kWvqUmu453nrgolGUXZfY=;
        b=hwjAPvtpQepLH7hUOrg3vsO1og6H+lnZvtqzxobnb1Vfsi7IXKdzNMcJq66rhycGwJ
         XDQ8dxDyIWp5CrUVgCD8A95mkhYGSwbQNsavmx2iipX32xEET2klv54k03dM3U7Y3r1G
         UaqpaZXSyqY09z/8USI8i44WUeCyM/PbpnF7d6/qXBA5vdOBTaPbRUdiiiqTXXi3lQ50
         eLCoACjnVFHAt3eUFE8RZ0f4Jvkvlk3+VWi9qKMNx6HIVkiz22sYIn4eImgTPGhViCqb
         JkvWw5nGCaP1IuxFz0aCtamFlCLOCNaxS7Nl62Q5YM5nSpt/e3qgkep3VJY8MXslnMHP
         Q2DQ==
X-Gm-Message-State: ACgBeo2la2ogpSEJ2a4C5kmnJnajWmLIHjEexhZlPOyknsN80PtxnAGL
        yf9iXfe9xcIpNun8CUcKhknZIrXzRi7aatkOoxg=
X-Google-Smtp-Source: AA6agR5ds+31MlCuOBrld+jBfFyVqJFj0IzRoC4mZzFsEAXEocqGIR5ei2Wg+4bAbMB+QmKiWjwmrV9IRX2ykPd/a84=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a81:578b:0:b0:324:82ff:12c1 with SMTP
 id l133-20020a81578b000000b0032482ff12c1mr420172ywb.174.1660777719736; Wed,
 17 Aug 2022 16:08:39 -0700 (PDT)
Date:   Wed, 17 Aug 2022 23:08:21 +0000
Message-Id: <20220817230821.47048-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
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
 drivers/pci/pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

v3:
 * Use DIV_ROUND_CLOSEST instead of bit manipulation.
 * Minor refactor to use max() where relavant.

v2:
 * Update to use 20-25% upper bound
 * Update to use usleep_range() for <=20ms, else use msleep()

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..cfa8386314f2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -66,13 +66,19 @@ struct pci_pme_device {
 
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
-	unsigned int delay = dev->d3hot_delay;
+	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
 
-	if (delay < pci_pm_d3hot_delay)
-		delay = pci_pm_d3hot_delay;
+	if (delay_ms) {
+		if (delay_ms <= 20) {
+			/* Use a 20% upper bound with 1ms minimum */
+			unsigned int upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U);
 
-	if (delay)
-		msleep(delay);
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

