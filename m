Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59703317C5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCHTvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhCHTvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 14:51:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74BC06174A;
        Mon,  8 Mar 2021 11:51:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id w34so6041670pga.8;
        Mon, 08 Mar 2021 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+NBgR0Z5yrS58Bggiyd+j9wPJr74kCoUvf/RIiAgNk=;
        b=VM+pM5Dcl/Ls/N16ob7UqRP/K3ZdK0Gz1OCS3pfu8zz+1tggjbucQBuzhb34V9vLQ2
         ZUnATgMwO54XP714nNsBW3TaCZL5jOvO85yYLfvXGy4LXzshDuSnsso1PLS0NUGErNg+
         ZWSocLsViJ+AsSS8NtfXOr1+eAbehhHNRzUzOtU9NQD3T7v5CX7/X6waDQcCmFJRG9hF
         9uuX7PAaCHiEpBsmsxCCt6nnLyS4fPqr+4u86Fdlijf5rFx/dPw4Ig0HXLenk0NeVRYr
         mRg2VrfLLszbhgYQuSj17EJMlnUwgemW4KF2xXJM+D2BN+hc4iGYIG2kqQKmr9CwMaiu
         A0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+NBgR0Z5yrS58Bggiyd+j9wPJr74kCoUvf/RIiAgNk=;
        b=PlQ9x3RpFrYxDabkK93LZvphgpEW1v4tnrQ0hSA0F863eTe0kvkHW0l087dy/8AGXY
         r4MKWH0aJm1uX+0x+mAmXVY7l44D7i7HH/KQNI7rIVxT/h+lETGCBPDFzSFItKIQE25n
         X9XvdatEGPj5b4H5NNHYGec1NVAAD6ytQhAymRv1zQqQftZy347hf5Qb7xrnsfaSmJPh
         gyrnioI3FXVYgPfvHMTibUSilUrIyaKmgNU9/hLnE+WLWJxmnok6XmVqvQ39TJ5MaHiF
         UpYs7+iaYPyI1XWXYQcolYcM5aZYBIwVOpkAxbBOqUgk7wmdZMpR84MhBw+F1A3/ieih
         hQUQ==
X-Gm-Message-State: AOAM530rBxJ2ksoH4HJVEUjgrg7eQgRBS+jFmXxxkg1e6+lSNyh5ysAG
        qYQk3RjDWVdbHKK8/S7+AL8=
X-Google-Smtp-Source: ABdhPJzmKRDABDycNrQRPTO6rfvDsYszgYqz5VbgomS4l3y3yE9pGPvE7GSmZF/hJU3ZtQZQF0JA4A==
X-Received: by 2002:a63:225f:: with SMTP id t31mr13774607pgm.371.1615233068431;
        Mon, 08 Mar 2021 11:51:08 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y1sm64685pjr.3.2021.03.08.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:51:07 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] nPCI: brcmstb: Use reset/rearm instead of deassert/assert
Date:   Mon,  8 Mar 2021 14:50:37 -0500
Message-Id: <20210308195037.1503-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308195037.1503-1-jim2101024@gmail.com>
References: <20210308195037.1503-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Brcmstb PCIe RC uses a reset control "rescal" for certain chips.  This
reset implements a "pulse reset" so it matches more the reset/rearm
calls instead of the deassert/assert calls.

Also, add reset_control calls in suspend/resume functions.

Fixes: 740d6c3708a9 ("PCI: brcmstb: Add control of rescal reset")
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e330e6811f0b..18f23cba7e3a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1148,6 +1148,7 @@ static int brcm_pcie_suspend(struct device *dev)
 
 	brcm_pcie_turn_off(pcie);
 	ret = brcm_phy_stop(pcie);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
 	return ret;
@@ -1163,9 +1164,13 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
+	ret = reset_control_reset(pcie->rescal);
+	if (ret)
+		goto err0;
+
 	ret = brcm_phy_start(pcie);
 	if (ret)
-		goto err;
+		goto err1;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
 	pcie->bridge_sw_init_set(pcie, 0);
@@ -1180,14 +1185,16 @@ static int brcm_pcie_resume(struct device *dev)
 
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
-		goto err;
+		goto err1;
 
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
 	return 0;
 
-err:
+err1:
+	reset_control_rearm(pcie->rescal);
+err0:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
 }
@@ -1197,7 +1204,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
 	brcm_phy_stop(pcie);
-	reset_control_assert(pcie->rescal);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 }
 
@@ -1278,13 +1285,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->perst_reset);
 	}
 
-	ret = reset_control_deassert(pcie->rescal);
+	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
-		reset_control_assert(pcie->rescal);
+		reset_control_rearm(pcie->rescal);
 		clk_disable_unprepare(pcie->clk);
 		return ret;
 	}
-- 
2.17.1

