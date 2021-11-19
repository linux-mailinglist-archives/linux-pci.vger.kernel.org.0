Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1A457877
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhKSWLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhKSWLG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F7C061574;
        Fri, 19 Nov 2021 14:08:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y7so9221724plp.0;
        Fri, 19 Nov 2021 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zcuXFbqK8H0xdNFwVNSeclVkixsgVOiV/M+oI0ZGTY=;
        b=mdTN4XDtNAPQv/72+dhoCFCoxzdfJEdUOuV2E6IjFSHGq7ARXOXM+gVCLtD878WAuV
         8eZDGyOkFVOSVG7IYqhgBthLvaYyx4aSunqvokXa4wkp2D3+GlqpQbFbg6x0n+PEiDMK
         c8xwjWMlUDSQQhbtB76wwk/nEQWLomvM5ckraA06dkwlqDXtkx28Z1YK8hh+IH9EMUao
         3zoLQja652aZw8RwZh3EWaA/X3ld6CnyLl6xEGslq3PxWWPVtJrP9KmnwQ4b4/+J6ufo
         erpvIXtkld22/LCru4axk98shP1D0qxNpTqq+eiFjF55UJ9VmfeTEB8RikE8a/cUWEGI
         ltdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zcuXFbqK8H0xdNFwVNSeclVkixsgVOiV/M+oI0ZGTY=;
        b=uLOUEr9As3FXWoNmWUeqQjmELpATu5SU0GH/0ggC8C60GN+lNmgg7DxUZnSvubSZp5
         pklxM4S7p33eMyT17OymRYQKiEIfu7eHCtRcojZD7GTfwqzTDMhYYgx4mxlNeCT1OCaL
         BnI7pOCkDCvvoP32VdP3m1dlafsz0PJqtfy2fzC7vjsOR6aBKG6vmJ1R/m4WuMWtLCBu
         H9uRq+F2OD3hsC/5Y1bCjxBtH25EjcmE1qeLwuh7D6VcjDBVeKmWqpW0k+tdgpCp+eml
         wqko10S6aXwZDTNX55P/bsQPtMFv7bBnqSynT5LgpT6FSZAYuerA/dUJUH1hXn4ViXKd
         3dVA==
X-Gm-Message-State: AOAM532iEicuLooFMpHDxt8h21zYfDnoBXluP4jeC9A9+DqKLtBpaaod
        dFyHCblHjee/7tYVbO6Kpsye+6HsDPc8yA==
X-Google-Smtp-Source: ABdhPJzyF20Xa2xvnCY+FSmR4kmroEp3K2+l/gI1fE9Qa5W3WAlNK5vIJABvOyqRzIDhyXuv1sQvog==
X-Received: by 2002:a17:902:7fc5:b0:143:6d84:88eb with SMTP id t5-20020a1709027fc500b001436d8488ebmr81623886plb.61.1637359683454;
        Fri, 19 Nov 2021 14:08:03 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:03 -0800 (PST)
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
Subject: [PATCH v9 1/7] PCI: brcmstb: Fix function return value handling
Date:   Fri, 19 Nov 2021 17:07:48 -0500
Message-Id: <20211119220756.18628-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
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

