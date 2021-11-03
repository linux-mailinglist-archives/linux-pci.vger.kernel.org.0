Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D244489C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKCSwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhKCSwh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB82C06120B;
        Wed,  3 Nov 2021 11:50:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so2066402pji.5;
        Wed, 03 Nov 2021 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wB1XTHRrUvGXuzH1iZwj1J6GyNltpPCGAayAWSa5LmQ=;
        b=Jj8wZVtWZX2avHtT6K3bSj2bMG40lbof6al+upIjE7v3prKL0Gs3UxNJozzt8u1SVn
         qiB3GwgJpsqaYVkk7UAyEGZ5cTHZQwl1Pa2eeY8LKW3uMnVIduLtjV9BsxcaC2Y5xA+N
         ohXJ0QybXPPWQg4ct6FDvRGTAqwl90ycMiPDNEUqZ4x5zo96VNRGlAVMnpkrdbHLHVmS
         PrtQiTySChOB2IYY9Eq/7sKmUm9+7mEmLtXjgFHbh4oorXVkDtTnp855HOh3rbg0TMsC
         OHaVuERpAmLFCLVliDJjGCkRQMM5ZJEWKmTUH9rYGdmuAOVbcSl9q8CPLiJEohehV8/K
         IPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wB1XTHRrUvGXuzH1iZwj1J6GyNltpPCGAayAWSa5LmQ=;
        b=Vv1v3og+oLXa/F+Ad7vSVA2Di/xlovd7AUMaWDNywp/W5+qA8PqR9KQjV8KIx6gyA4
         9HbA1J7WleU4TPzobB8lFyz+dxSpvTY900rN3FFLdPtRHXSZ67ED4tQHh4wUhK2haSyF
         GcKTpkJAzPfgfoqQ96WF+9BOezkWOlOMrK0fGPbsAs5Io5DQfHzn1ZCOYe6+XYUV+ZOn
         xkNKtzno+BdZFzmD1mU0KkbUBEt9RUrB1ZZp6xDcKDeWX+6c7T/vXVP9i9W5YSyAHvxC
         /bVh5lVwvd4FU+6vXKBLa/OErnc5r3oI37gayANJPnutibYBEUfAgc1GIeOuWWB22Gw1
         jfcw==
X-Gm-Message-State: AOAM531McXqOzSuGooUbxyR6vCpxrXEzh7P3y5m315bHC4T6Ey0tW/Fm
        3on+dL7Zr0rZV41usJLdNVSQbK11b+npmA==
X-Google-Smtp-Source: ABdhPJxysJWpo64eRsY6+bwdO1TrGhnH5TPuJXNlA8jir9+FpIYzLpJNg28HsV1AQ62Z5m6fK2zglA==
X-Received: by 2002:a17:902:778a:b0:13f:672c:103a with SMTP id o10-20020a170902778a00b0013f672c103amr40891628pll.55.1635965399774;
        Wed, 03 Nov 2021 11:49:59 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:59 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 6/7] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Wed,  3 Nov 2021 14:49:36 -0400
Message-Id: <20211103184939.45263-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 43 +++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index aaf6a4cbeb78..9aadb0eccfff 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -307,8 +307,20 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
 	unsigned int		num_supplies;
+	bool			ep_wakeup_capable;
 };
 
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
 static int brcm_regulators_on(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -316,6 +328,18 @@ static int brcm_regulators_on(struct brcm_pcie *pcie)
 
 	if (!pcie->num_supplies)
 		return 0;
+
+	if (pcie->ep_wakeup_capable) {
+		/*
+		 * We are resuming from a suspend.  In the previous suspend
+		 * we did not disable the power supplies, so there is no
+		 * need to enable them (and falsely increase their usage
+		 * count).
+		 */
+		pcie->ep_wakeup_capable = false;
+		return 0;
+	}
+
 	ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to enable EP regulators\n");
@@ -323,13 +347,28 @@ static int brcm_regulators_on(struct brcm_pcie *pcie)
 	return ret;
 }
 
-static int brcm_regulators_off(struct brcm_pcie *pcie)
+static int brcm_regulators_off(struct brcm_pcie *pcie, bool force)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
 	if (!pcie->num_supplies)
 		return 0;
+
+	pcie->ep_wakeup_capable = false;
+
+	if (!force && bridge->bus && brcm_pcie_link_up(pcie)) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
+			     &pcie->ep_wakeup_capable);
+		if (pcie->ep_wakeup_capable)
+			return 0;
+	}
+
 	ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to disable EP regulators\n");
@@ -1241,7 +1280,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return brcm_regulators_off(pcie);
+	return brcm_regulators_off(pcie, false);
 }
 
 static int brcm_pcie_resume(struct device *dev)
-- 
2.17.1

