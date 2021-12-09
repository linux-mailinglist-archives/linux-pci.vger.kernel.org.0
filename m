Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7146F5B7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhLIVRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhLIVRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:17:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866AC061746;
        Thu,  9 Dec 2021 13:14:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so7916111pju.3;
        Thu, 09 Dec 2021 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zcuXFbqK8H0xdNFwVNSeclVkixsgVOiV/M+oI0ZGTY=;
        b=jSJTycM1LHfsqch9Tn+iEzckPdBUoUSwsZSLvvFvx9HL1d+3H2meXR8c2PgUIVDIbm
         +2sOF0dBLdEyARpv2FiufUTh9W62UGUm1FzD6U+JkKBt7WViSRUz1Q+IdZyl1pUurE4Q
         uceVQ2eDN/K4tY6dUKa3NL+Ke4WoeRwPmUHDc7dp0SOszJ9kbtl0uoS8tmx9JXHyiUoa
         PyoeYc2RvC+w4SLaB3JjGkiUb2jV0kFLwElzvvl8RxdaP9JwOw9RufhCQmhmr1105+//
         IqYatHMACCNAWcYJXkaPbv6lkxYfqlDB8gymqQoM6hBvWaK8KNDd8QmrFGMm8BCuUC8y
         UIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zcuXFbqK8H0xdNFwVNSeclVkixsgVOiV/M+oI0ZGTY=;
        b=qRr34315xaQn1qn8glghwWMEnzCRRmyOF2WC6I+Lv+gzfh31PWnPG9EF+H1lLzdPW7
         UMYbwcE7l+V7lsNTsql660lvocOnXFfuaisaXebXukL4S77xolkbXmiC/fZOayZj7e1j
         n0KTh18cUWUeQEDa84Vrt3lRTyQSl0TFIt00Ne0lPAscJcoYRarl6/Wnlw/GITCDsS4q
         lIJfG0dWxica6afrimyhKn500eZwO0L6E21bZ9pB7nGf2cqhs6SV3uHe/CdpkhidOGoD
         q1ARuj1Ez0pJAOxJOjxy3yATUbbYhF0Ke2z5iAKNGC///QKgV5g/7wk32NPTUKxvqxSn
         0QVQ==
X-Gm-Message-State: AOAM5316gN2WiwjpEFnzLI11QdtQh5uM1D19w7SMExY5RqcN64Cj6ZVf
        fydSE1kV+8ftGptCD5XSBMGLrbn3CuQ=
X-Google-Smtp-Source: ABdhPJyX/WNjlHXzEOS9kK07DY0dM2ycqsaHaQnGFsuHE4Oc6LPhdzvaWvbMeLDlO1h0yNCKdee+5A==
X-Received: by 2002:a17:90a:5d8b:: with SMTP id t11mr18548215pji.8.1639084456602;
        Thu, 09 Dec 2021 13:14:16 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:16 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 1/7] PCI: brcmstb: Fix function return value handling
Date:   Thu,  9 Dec 2021 16:13:59 -0500
Message-Id: <20211209211407.8102-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do at least a dev_err() on some calls to reset_control_rearm() and
brcm_phy_stop().  In some cases it may not make sense to return this error
value "above" as doing so will cause more trouble than is warranted.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
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

