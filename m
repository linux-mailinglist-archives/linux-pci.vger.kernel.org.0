Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDC580182
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiGYPQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiGYPQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23911EEE8;
        Mon, 25 Jul 2022 08:13:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so10757826pfy.0;
        Mon, 25 Jul 2022 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWqt3A+kTTr3GuQ/QKtvOTNiaH7+FtME/Jys/x5W9Qg=;
        b=RnHVXJ7QzoxC/Sb4hfqcVvvu5DQpUvhCBmwM3ZfgRwfuFoTwxujBXVmTDApsn5EFw9
         JL9cAxz6gNHdtxWfy195R63xeEHToGNb3wCwYSSuCipWefhsDN54obbf36XGugonATR6
         pkZSuaMmGyX6bXjcdWRhFVkvvc9CHgeafUcE+ow2bRHr3Cg8vTLwUGP/wAg3j69csvj1
         /iOtfyxFG3WltjRMO0gdDJj4RvkUxx1bIlhaCQirgSYjvl7eFKG3wztVR5EVt8Cpxh37
         P7zJWc6cYo64Vr5zPZ1sejbk3ohHiGia6ceCSqh7QQslmVn/dhdfx+ydUN8i4WjPnehU
         l+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWqt3A+kTTr3GuQ/QKtvOTNiaH7+FtME/Jys/x5W9Qg=;
        b=Wsxi/pnVajP7lpcfqOb9xDaw3BWNMxULJkgjjy+fHn8OQZ1yiaCBEuk49v1KLmoTRP
         RksydYGnifdMoUvrlavG9O0Tvqam13SXq/BfIXzb4qU4CuX/PGVKS8OtFqxbi3XoQmzz
         A1qFFxknn6LHK9iI3Er42LfUEC9pOqxfk+ArldZpdJTf72CnmqYCiZr5fIa5Ham8C/k7
         84GEPQe97Aj1hT0ppTOiFaDgR/1zg8kWLTnLLfojHTG8oBNj8i0/kpCt9ujQ3YLrBEd1
         /IGyZx3fK5YNosRTKN17VOH0lHSV/eJ5WXYqod2wmvnYBrpqf6taQDUwXLZCk3aU7ypl
         HBiA==
X-Gm-Message-State: AJIora/7Hi+KM0qCHVu2McwhlITK9tqy6GiQe9ROKCIrSN+sdnWdsrpA
        Gf/8G7Z9+2PSg1I7lx16TsAkSyWgGE4=
X-Google-Smtp-Source: AGRyM1uRxc0dreTIHkxKj089Ou1wxbKhCJI9jsthW/cnZ/UAr2TLk2D+Hk9H+Qdjneaasbc5pXkq3A==
X-Received: by 2002:a63:fb01:0:b0:419:699f:a0bb with SMTP id o1-20020a63fb01000000b00419699fa0bbmr11334115pgh.4.1658762019875;
        Mon, 25 Jul 2022 08:13:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:39 -0700 (PDT)
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
Subject: [PATCH v3 6/7] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Mon, 25 Jul 2022 11:12:55 -0400
Message-Id: <20220725151258.42574-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/controller/pcie-brcmstb.c | 54 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index aa199b0a39e2..fc1d36f6094e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -263,6 +263,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			regulator_oops;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1283,9 +1284,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
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
 static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1304,11 +1317,22 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
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
@@ -1352,11 +1376,21 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies,
-					    pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_reset;
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
+				goto err_reset;
+			}
 		}
 	}
 
-- 
2.17.1

