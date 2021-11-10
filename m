Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE544CC66
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhKJWUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhKJWUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC4C0797BE;
        Wed, 10 Nov 2021 14:15:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so4127687plr.11;
        Wed, 10 Nov 2021 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gmJaKhK11nXMnfZy6D3iJ9fmoD5F9ICuC/zbPbZo8Q=;
        b=CyFcKDsRCa5KYV8P7aoQ8YPt6+N0dvzf0k5pBp/yR+OkQiQKbu6PUP3igdHtA/1Vwg
         rq/qiFYLcKcxRkjvVZsclFy8P1eaBIeIc5WD5mOFlMSTJ6KvKludpemuZsKwflpXIYRw
         7zzgxJMXZuzUrhG0PdpiLoswDKQSYon4lyL1I9btrskMt8Tw32G2x+QfaePgb1PXeXrP
         gzk2MUqJ34v4ImuJAOJwj9kw2Ehv/v2cifrHCFsUP7Yv87JHopfGX/wQuijEuRGiKG7K
         W6hANVTrrAdyQn7jz192fbPeQP4RBdOUtreuSt3ivBVkTCVUUmKTxBj8RmMxImZ0yh+d
         mdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gmJaKhK11nXMnfZy6D3iJ9fmoD5F9ICuC/zbPbZo8Q=;
        b=SoPFVNgeJvtPd89zXu+q4pIH4cf0M3j7GXSeRnl7qyBoL38hLgTT0FnlzXWaI/68F2
         ivGL9CwDoooDRaFJH5K4fSBNs1Q4qAbp9nQGWfYK4v8YUX821OawjzF8BiKotf2lOTgv
         1BZPwwN98RDNEkR6Zox1ZL/wiEwXWdbgsrOnXGdln+7MaaI59fIoUe6g6WT9bXHyeGxQ
         namHFmNJObfCngf/DE5qh3XP6cdC+LzpJd6np/ELOehefFUWRH5o7tFgusjTSKDjeJou
         Gy7h6M+8YzY4hAi9PqxA3lhXrq5qnRInU4rvdsdK5d5hKujPKe3wGnIhEzBGcfjv+JzF
         4ROg==
X-Gm-Message-State: AOAM5331sIKfl7829vA7vPs3w7cbWhb+RWOsBCoWLsrrC+8oXmx4MRzN
        zUnxzlTNNpvsu3qjwHWvBXwBXHG9y8RM3w==
X-Google-Smtp-Source: ABdhPJzk+FzS5BpdWjqyeNXvbZIVEND/jsGBCPxnTd+iUyvwATjClj2jClYHrqmlG5iHfJsVtwcurg==
X-Received: by 2002:a17:902:c145:b0:142:50c3:c2a with SMTP id 5-20020a170902c14500b0014250c30c2amr2786039plj.32.1636582522083;
        Wed, 10 Nov 2021 14:15:22 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:21 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 6/8] PCI/portdrv: Do not turn off subdev regulators if EP can wake up
Date:   Wed, 10 Nov 2021 17:14:46 -0500
Message-Id: <20211110221456.11977-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/pci.h              |  1 +
 drivers/pci/pcie/portdrv_pci.c | 43 +++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6cf75b91cc..27abb977d0ec 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -746,6 +746,7 @@ extern const struct attribute_group aspm_ctrl_attr_group;
 extern const struct attribute_group pci_dev_reset_method_attr_group;
 
 struct subdev_regulators {
+	bool ep_wakeup_capable;
 	unsigned int num_supplies;
 	struct regulator_bulk_data supplies[];
 };
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 9330cfbebdc1..717e816d0fc8 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -111,24 +111,55 @@ bool pcie_is_port_dev(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pcie_is_port_dev);
 
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
 static int subdev_regulator_resume(struct pci_dev *dev)
 {
 	struct subdev_regulators *sr = dev->dev.driver_data;
 
-	if (sr)
-		return regulator_bulk_enable(sr->num_supplies, sr->supplies);
+	if (!sr)
+		return 0;
 
-	return 0;
+	if (sr->ep_wakeup_capable) {
+		/*
+		 * We are resuming from a suspend.  In the previous suspend
+		 * we did not disable the power supplies, so there is no
+		 * need to enable them (and falsely increase their usage
+		 * count).
+		 */
+		sr->ep_wakeup_capable = false;
+		return 0;
+	}
+
+	return regulator_bulk_enable(sr->num_supplies, sr->supplies);
 }
 
 static int subdev_regulator_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct subdev_regulators *sr = dev->dev.driver_data;
 
-	if (sr)
-		return regulator_bulk_disable(sr->num_supplies, sr->supplies);
+	if (!sr)
+		return 0;
+	/*
+	 * If at least one device on this bus is enabled as a
+	 * wake-up source, do not turn off regulators.
+	 */
+	sr->ep_wakeup_capable = false;
+	pci_walk_bus(dev->bus, pci_dev_may_wakeup,
+		     &sr->ep_wakeup_capable);
+	if (sr->ep_wakeup_capable)
+		return 0;
 
-	return 0;
+	return regulator_bulk_disable(sr->num_supplies, sr->supplies);
 }
 
 /*
-- 
2.17.1

