Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40464B3AA7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbfIPMu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:50:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbfIPMu2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:50:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id q14so38713482wrm.9
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlGUHvg+PE8gs96DiXpNJ8Kfd/rHrkqDzag5ZPnKd5Q=;
        b=uRznrPwppxChi5DbFjBeAieVJnJpLht0j9pPELbSwp1vv3rhF+D0lrlX1Yetseyedi
         EHQmRJ5hu9fp3801FOKkw5+yX1bloZAVLZpMjuj5WAstQXZsNTcqZ4lZjSik4IAsiXLx
         b/LxLStKZvrpsV8yX4Nn/uWNoyG/XqctVhaLSa3X5/hPIRwYJgo4E8g62aiuq5qlKmfM
         Q3Hf0vxXjlFjvi+6EWQJUtlnn7+zGxpduDjbl9FGcdjotSN1JnykahEWQ301TkYIfUTy
         KHFQk+UDLG4QjGgEuFk0jHuMgn9vAFrpXGQMhcqIm8hIzQJOw/0KvmNvX+n+nUiS96vz
         SZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlGUHvg+PE8gs96DiXpNJ8Kfd/rHrkqDzag5ZPnKd5Q=;
        b=DXDcMTwKUpO97HhOhnrCY7IYfe2B6ZZoIIXTPdy/qBtzrmK28xD6Qq+etQBdXjDkxe
         z7F92xjpmMo49R5ZwoGJhgrtmaJtHuSc/c477DTgzbLWMGgPPLXhIk59Qd6uqozWk41L
         m/FV9VmLfxinYE571iDCVsB07MxNN5SDl3E9pt8Z7ag0fsbJrf/tK+9K4iPLbxyTjSgq
         Bh8AofPUPlympI8BoWyRDRzBSuz/5ToE7MBl4BJeWauNcQs4tBBOhdveQoLk+cjVVbgv
         wA56+r3KliEenj+88RAf1yrDeESde4rQWF+mzyXL83rAFLJkrSkXBy3iwE2/j86uL1Pw
         LY/Q==
X-Gm-Message-State: APjAAAXICgb3K8EP/O/NCp/o6RigSrEUeioSkqGj6VFwtjTVq5Cqq0+X
        dcxiss42/2qKFwTWgJ346+Ecyg==
X-Google-Smtp-Source: APXvYqy7RU2IS8RX/3f7CyUGB28iNocAeDt1Nen58ZP9x40CfxUXWROzTKwkmKdqC1wR0VqTF3GNSw==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr17384767wru.282.1568638226669;
        Mon, 16 Sep 2019 05:50:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 2/6] PCI: amlogic: Fix probed clock names
Date:   Mon, 16 Sep 2019 14:50:18 +0200
Message-Id: <20190916125022.10754-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the clock names used in the probe function according
to the bindings.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 541f37a6f6a5..ab79990798f8 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -250,15 +250,15 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	if (IS_ERR(res->port_clk))
 		return PTR_ERR(res->port_clk);
 
-	res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
+	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
 	if (IS_ERR(res->mipi_gate))
 		return PTR_ERR(res->mipi_gate);
 
-	res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
+	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
 	if (IS_ERR(res->general_clk))
 		return PTR_ERR(res->general_clk);
 
-	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
+	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
 	if (IS_ERR(res->clk))
 		return PTR_ERR(res->clk);
 
-- 
2.22.0

