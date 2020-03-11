Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF17018220E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgCKTTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 15:19:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38851 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so1718084pgh.5;
        Wed, 11 Mar 2020 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r42oaftrh5pHz14qU1GYkB0RQE5bj151KUZhP6WCLUU=;
        b=G2+txh85XP+S2jm9NSogjxqBUikS9Ngp6DtlfWcrAd9ufiH47Xb0eN1WLqYPThF/21
         1CiU/fLxTDxovvO+tstyelBWaQNE54Cd9MaVw5sUNbbJll0t9oy6RoVBciTb1yx+p3n8
         SYMIbkSRuqEWGJPp9+ILBaLuPRjrhgatYgkP4uCMx2DpqGuBtdGqDm9bz7yvAOkct02H
         ymKsFcr0TFGylW3wkp6TPDnM7XYWoZVV1aaNU6yHrcziFZvZIJAKRJCwXzanVr0JxFdT
         eOoxecolqmumlXalOmw6vTiAKijvk0SgCuOyhL3gDgTTbUUoHdPR+r5SudaD3n/8pHnx
         JSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r42oaftrh5pHz14qU1GYkB0RQE5bj151KUZhP6WCLUU=;
        b=UFqMRfRVbZSurBAXuDM99VAZHjYk6UKia3S/an2cQjvV1YfIs+jdWcPlDLijRPlJbG
         /SSzbA7icVFURqm8BC7q6tvQb3SVD1gJZ0GOXVWt8KdpUKUUYd4A8v2tpdzT8EzWvVbS
         JXTAvFVZaqfZLEOOQv/cshIpf79ry/1UMV96sLCw1hazwpeugFjx9ysx4CveS8GWb2Eb
         xHHn+YvjRlnyYNo8DuIWo+zBCXtG9eRk+tGoEcm6lHOX6izo7lGl6Nzx1+Txgvy8QEF0
         0+9G2C6dH6vf2AXjJMKAwa1Fda/NjHYlFjcDsCynuFjAAD5yk4LaTRssj63CGNSBlHeM
         4rDA==
X-Gm-Message-State: ANhLgQ1F78/TcJ0fN3gHSRlC7WXjMdihGxl5pHXnrcTEqh8UBuoP3N8R
        elHH20ePgWDeF4O3sScz8oo+qURm/qr3pg==
X-Google-Smtp-Source: ADFU+vtbPme6BTAJZmyevs7rgWm3h1iPQrP+b1siICnoXHB1UQz+utoRSjjlAt3zopkF2PlmJnFY3w==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr4249326pfg.178.1583954359553;
        Wed, 11 Mar 2020 12:19:19 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:19 -0700 (PDT)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     amanharitsh123@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/5] pci: handled return value of platform_get_irq correctly
Date:   Thu, 12 Mar 2020 00:49:02 +0530
Message-Id: <d12a15f496ca472e100798ac2cd256fbfc1de15d.1583952276.git.amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583952275.git.amanharitsh123@gmail.com>
References: <cover.1583952275.git.amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 drivers/pci/controller/pci-v3-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index bd05221f5a22..a5bf945d2eda 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -777,9 +777,9 @@ static int v3_pci_probe(struct platform_device *pdev)
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
-		return -ENODEV;
+		return irq;
 	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
-- 
2.20.1

