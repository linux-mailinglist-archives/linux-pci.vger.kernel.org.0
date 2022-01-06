Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2748673A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiAFQDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAFQDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1324C061245;
        Thu,  6 Jan 2022 08:03:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso3667195pjb.1;
        Thu, 06 Jan 2022 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ny451XICFZwmv/3fN6tVd1MtvFhizeu82dbPq5GZyWM=;
        b=B/bJAL+9WSowS7PoK06mmDrVzgt02eyDNMsOWEOFLOz29VKdblVemN9wxL2Ccjd95k
         EAIK7FXwe8LOSzGZwiPhVH+P4sFunR8RsBApeS62FyHromHaN5VBGkMdkGuks/1RbBWB
         md2Z0Q/otAyw2fW31yMaY4NE5wkXrgPE7cLxV9PmbhumzUzbhz5sOlJKIz3G+93dr0g7
         1xWVLRyy8kCXpTCrueZEUpklpuzpEIjVXARZ5rUNbhT14JVnann1dvfVOcNqyFHI8FpP
         uFFfRSgE89MaJ018xedf63DocBR1C+/enZpDOa09Y5jKPChPe/wzRkUeinHhUGYZuRCq
         d/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ny451XICFZwmv/3fN6tVd1MtvFhizeu82dbPq5GZyWM=;
        b=To9LjY+wPga3p6egTkT36mhBhQVu1YkIudGsZBcS9lESgH07LavIV67LfYF/wBrpD+
         /BAEzjJ/4LkqqAsAixax8Z4in6sRRKTaJYgH8thNyCrexp4fAx0ZpiTMOkduWjzJ3v/j
         1J7b+GOA350dd42k8ZQXF0cekgLnEkacWDK0QB3hUGjSjvJy5FRppZJ+j7WmoVFWA1Pu
         LXAIfLK45MNMX8vn0smWBQRBDGymVEz/KTKxJwVKDH0ilWyPwcDvcrNnesnOaK40ys+i
         zX0GHsxm4dznFxBDhqv7suFDU6x7F+FXp529d/ZbtDLu2wtCmvP8atvhXpZ37YIn3MwM
         AvNg==
X-Gm-Message-State: AOAM532Is5PPr7yRdvcZO2+dm3ibZl8RAqg7SwfNoTDH8c6INu3SOHU2
        jjrrsMbcLa66lDPUv8KzruRdD9djCYo=
X-Google-Smtp-Source: ABdhPJwVNSM8XJAXkqDKNJQgq2zUYGKTki3fMD3qLUZ5nTowM5+y0ryglm3I1q3luY/LPCHnXG++bg==
X-Received: by 2002:a17:903:244f:b0:149:873:e17c with SMTP id l15-20020a170903244f00b001490873e17cmr58362526pls.133.1641485021987;
        Thu, 06 Jan 2022 08:03:41 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:40 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 1/7] PCI: brcmstb: Fix function return value handling
Date:   Thu,  6 Jan 2022 11:03:24 -0500
Message-Id: <20220106160332.2143-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do at least a dev_err() on some calls to reset_control_rearm() and
brcm_phy_stop().  In some cases it may not make sense to return this error
value "above" as doing so will cause more trouble than is warranted.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 28 +++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..9ed79ddb6a83 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1146,11 +1146,23 @@ static int brcm_pcie_suspend(struct device *dev)
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
-	ret = brcm_phy_stop(pcie);
-	reset_control_rearm(pcie->rescal);
+	/*
+	 * If brcm_phy_stop() returns an error, just dev_err(). If we
+	 * return the error it will cause the suspend to fail and this is a
+	 * forgivable offense that will probably be erased on resume.
+	 */
+	if (brcm_phy_stop(pcie))
+		dev_err(dev, "Could not stop phy for suspend\n");
+
+	ret = reset_control_rearm(pcie->rescal);
+	if (ret) {
+		dev_err(dev, "Could not rearm rescal reset\n");
+		return ret;
+	}
+
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return 0;
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1161,7 +1173,9 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
@@ -1202,8 +1216,10 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
-	brcm_phy_stop(pcie);
-	reset_control_rearm(pcie->rescal);
+	if (brcm_phy_stop(pcie))
+		dev_err(pcie->dev, "Could not stop phy\n");
+	if (reset_control_rearm(pcie->rescal))
+		dev_err(pcie->dev, "Could not rearm rescal reset\n");
 	clk_disable_unprepare(pcie->clk);
 }
 
-- 
2.17.1

