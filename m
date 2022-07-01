Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373095637E3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGAQ1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGAQ1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:27:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEE419B3;
        Fri,  1 Jul 2022 09:27:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b125so2167614qkg.11;
        Fri, 01 Jul 2022 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiHXGREwuuDLvK36dxnLy6Fvpbb/WnJ2uvPA0Bhu+OY=;
        b=hrwRgul3paFV+aPBBOjirsiOpDpNDtOkTcPKnmbmbBubKKYjZiNFEcpOT/FN3zT/GX
         tAvFKbxOPpDmyK7MvGZF+Yew0R1jiFZp7OFdwCzw9/+8ad1hMnhS7rFQcRWE7Cv8YFo9
         BhxfmP/BxZMgVGOtk8ReRxJT9MrKQmoZUEti12muZNIpf87iDhhU8A3OgJndqquHgAav
         54ly58dF2MyxD4Es2mTKEnDD/cduvc/0WlPGmcjgBB0jKy0KkKCKQ8eCZsLDycrKMZdf
         KBOqMHEoQjCvO11moMiLChjkpIUmzKit3ly7t5CJcA8N5TBtZ9humOCfO6/CjD9Kw/8W
         +Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qiHXGREwuuDLvK36dxnLy6Fvpbb/WnJ2uvPA0Bhu+OY=;
        b=FghLvBo2D8gKsL16ruaejLGQpifEyl3iHekzSqUxylmmM9W3Bw8G7sEzUEOr8GuPTI
         kVd4MGyu6V5T9To6onQY9vgh7wp0g0Pymj5LctK10i5pSq2G8enJVg5zumlqShlBSqly
         WGsfyEYL0cUrndz7pLHa9rUhYo4rOTOaPAmLIWcpSDeedtybKFo3xibUxvFiCz5tbvQA
         6iD1lua3wWR6CtKeeKKb1pMdyF7p6IiR3jDnL9V08P8dGDxKIS8iYTDgn9HpIQwlhmKN
         eh5rAN/TuK0YV+c6KAGvhvGCjeWL+D2xkrD3DKQ9eGULfhAqgIhUTQCn7XwS/Kjp5sFz
         sZGg==
X-Gm-Message-State: AJIora+7PFc2wTJeEMq5Ke0mik01KAHrKAfQYjKr839SS7Q7UyCi9onA
        UNsXwwhlWoiZu7QN278vVNMcwwfPVfQ=
X-Google-Smtp-Source: AGRyM1s+zwZYRfl9g6C362Ge0wZQLJ2sfPhyquuKbBZNxqNWybgBTk5909rCXeLl0GYE9UAqcRgWXg==
X-Received: by 2002:a05:620a:29d0:b0:6af:1bc9:38cc with SMTP id s16-20020a05620a29d000b006af1bc938ccmr10966614qkp.136.1656692853804;
        Fri, 01 Jul 2022 09:27:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006af08c26774sm17316175qko.47.2022.07.01.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:27:33 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 4/4] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Fri,  1 Jul 2022 12:27:25 -0400
Message-Id: <20220701162726.31346-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220701162726.31346-1-jim2101024@gmail.com>
References: <20220701162726.31346-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device can be a wakeup device, do not turn off the
regulators as the device will need them on.

Link: https://lore.kernel.org/r/20220106160332.2143-8-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 53 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index a86bf502a265..d417dd366490 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -333,6 +333,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1350,9 +1351,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_info(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1371,11 +1384,22 @@ static int brcm_pcie_suspend(struct device *dev)
 	}
 
 	if (pcie->sr) {
-		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn off regulators\n");
-			reset_control_reset(pcie->rescal);
-			return ret;
+		/*
+		 * Now turn off the regulators, but if at least one
+		 * downstream device is enabled as a wake-up source, do not
+		 * turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
+			     &pcie->ep_wakeup_capable);
+		if (!pcie->ep_wakeup_capable) {
+			ret = regulator_bulk_disable(pcie->sr->num_supplies,
+						     pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn off regulators\n");
+				reset_control_reset(pcie->rescal);
+				return ret;
+			}
 		}
 	}
 	clk_disable_unprepare(pcie->clk);
@@ -1396,10 +1420,21 @@ static int brcm_pcie_resume(struct device *dev)
 		return ret;
 
 	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_disable_clk;
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the suspend we
+			 * did not disable the power supplies, so there is
+			 * no need to enable them (and falsely increase their
+			 * usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+		} else {
+			ret = regulator_bulk_enable(pcie->sr->num_supplies,
+						    pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn on regulators\n");
+				goto err_disable_clk;
+			}
 		}
 	}
 
-- 
2.17.1

