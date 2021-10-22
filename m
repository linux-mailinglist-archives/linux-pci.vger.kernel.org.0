Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF14378B6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhJVOJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhJVOJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A64AC061228;
        Fri, 22 Oct 2021 07:07:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e65so3418348pgc.5;
        Fri, 22 Oct 2021 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OFqIrT+18a19n7objTdvw3Haq7UJKXHt+0jk9CGrew=;
        b=NhSB2bAHDpM6mMF01d5U0eL/0XiFzhOfpiCYIEyHu+ctod2WCJ9m/yRZ4wVCwUmO08
         0xqarR1YZzFPtvT3Xk7EkOJ4TEvsgOfcFuyWHiyVucvPmSkiL5ZHihtqLjmF+Yr7hWhf
         R5YSYZt28A6h6iiu+QvFR2wrIZfspQX+msQbm7JQUB2C29zyCtJSb+fPTMdwZbI5OIXd
         leWMTdvIUbW7+kWg7KVNEtpKewqWRh+NciaP8z5psOfS0h5/C5yOaU4ab7jlA8p6POqQ
         LJdFPtmYSFbUaIcq6gATySfTseWlujhUPLBxNKRDHt8d51FgyDPb1d8c+4DaeJU5y67o
         rIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OFqIrT+18a19n7objTdvw3Haq7UJKXHt+0jk9CGrew=;
        b=oPywuVl6+jNVsWSOH+FOfFFakmsyVqtAEpqmks6YByorlL+h6RIIPluuyemezCZpDa
         DGDFfcKXRrLD5svZvxlzOZw+qUWGv+7N3M5N/ZhzGAA0NaMVoFgV96v2jzqtQkCFA8Jk
         dJajmjkKU/krWxLJudBpEZspLglcTY4pbB+BvTqzwLTZRa87u3peAcs7q88OLKiNO5bb
         ba671QKT5vWH/py8tZKgxd1NrcY3yhLFAU8B90ZVJp9cmIr5sdcluXFyt3ZzO6gUXJsH
         rO7g4tvP3mYMIOengmXqKjLUq4Y4Tnwu3OcCClhufwfly2y1RTyAfci68wBWz8iMd0eN
         LL4w==
X-Gm-Message-State: AOAM532e1xeeuwG0ykq0x7qvEm30KtXXKLpeuCqr5V/Cpo0InOUeOGPK
        hnFPFHDd63Mcsi4ArBH0n9+4hrmC/26zJw==
X-Google-Smtp-Source: ABdhPJxGxUjF1hom1kgQ2Wlvy0rCVgLkb5Yatk+nFFmu0vYBaqDoZMn4pg6f+ZsIfDDNpcsrdMSL2g==
X-Received: by 2002:a05:6a00:2484:b0:44d:ce87:3627 with SMTP id c4-20020a056a00248400b0044dce873627mr258943pfv.48.1634911654640;
        Fri, 22 Oct 2021 07:07:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:34 -0700 (PDT)
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
Subject: [PATCH v5 5/6] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Fri, 22 Oct 2021 10:06:58 -0400
Message-Id: <20211022140714.28767-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 59 +++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 35924af1c3aa..505f74bd1a51 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -192,6 +192,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
 
 static const char * const supplies[] = {
 	"vpcie3v3-supply",
@@ -305,22 +306,65 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
 	unsigned int		num_supplies;
+	bool			ep_wakeup_capable;
 };
 
-static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
 {
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
+enum {
+	TURN_OFF,		/* Turn regulators off, unless an EP is wakeup-capable */
+	TURN_OFF_ALWAYS,	/* Turn regulators off, no exceptions */
+	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */
+};
+
+static int brcm_set_regulators(struct brcm_pcie *pcie, int how)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
 	if (!pcie->num_supplies)
 		return 0;
-	if (on)
+	if (how == TURN_ON) {
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the
+			 * previous suspend we did not disable the power
+			 * supplies, so there is no need to enable them
+			 * (and falsely increase their usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+			return 0;
+		}
+	} else if (how == TURN_OFF) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		if (bridge->bus && brcm_pcie_link_up(pcie)) {
+			pci_walk_bus(bridge->bus, pci_dev_may_wakeup, &pcie->ep_wakeup_capable);
+			if (pcie->ep_wakeup_capable)
+				return 0;
+		}
+	}
+
+	if (how == TURN_ON)
 		ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	else
 		ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to %s EP regulators\n",
-			on ? "enable" : "disable");
+			how == TURN_ON ? "enable" : "disable");
 	return ret;
 }
 
@@ -1234,7 +1278,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return brcm_set_regulators(pcie, false);
+	return brcm_set_regulators(pcie, TURN_OFF);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1250,7 +1294,8 @@ static int brcm_pcie_resume(struct device *dev)
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		goto err_disable_clk;
-	ret = brcm_set_regulators(pcie, true);
+
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		goto err_reset;
 
@@ -1297,7 +1342,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 	if (pcie->num_supplies) {
-		(void)brcm_set_regulators(pcie, false);
+		(void)brcm_set_regulators(pcie, TURN_OFF_ALWAYS);
 		regulator_bulk_free(pcie->num_supplies, pcie->supplies);
 	}
 }
@@ -1348,7 +1393,7 @@ static int brcm_pcie_pci_subdev_prepare(bool query, struct pci_bus *bus, int dev
 		return ret;
 	}
 
-	ret = brcm_set_regulators(pcie, true);
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		goto err_out0;
 
-- 
2.17.1

