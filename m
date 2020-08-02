Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95DC235790
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHBO0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36759 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgHBO0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id c15so1838480lfi.3;
        Sun, 02 Aug 2020 07:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/S75/rZPVtT/la0J520uvq4mcrCeNFGU2um+3tul+rI=;
        b=eGYxKagEb+QN5Q7HCeGhnyhJKXIWmSd8RBVimVWipR+irMxje/N7qFbEo9bJg1Wjfr
         /73rkoJLOwd6N5dnh3ZampC3gj12TE0GCc70OOJocJCMMdtceSvoWa2clFkVtfz42tfc
         NVTbE3gDGn7bsADcEQq84BzSGxMRIHt9HfI+r2PzD42AqbYnIjjZfJbcHwXQnHr2aqu1
         nV218QolJDfI8X1OyUZ1XhjebAyle3QGdgOg4XslQkNGxWl7gSMjpGEVoWy61YEdBC7i
         e2/D2KSAFJiWtMIQqnOqpX6L3lLESHhiZ0Qjf+B9NExEmrDzEU/1KuhGueyXTVODCXmW
         FQtw==
X-Gm-Message-State: AOAM531OOYSQb6OEx2x8ckJJvP4MZ5XEzBRGm3PyMlBahdSl5ewxwwXr
        XEM3Bp1fOAkrCKSRINjS+H4=
X-Google-Smtp-Source: ABdhPJzNpdAF9CCzGfP8sG9ncd25/FPuC6g6AByGverT5oAgx7TlVWh8xE/g3DI5YXBMEkYyIP2c8Q==
X-Received: by 2002:a19:189:: with SMTP id 131mr6399805lfb.128.1596378377807;
        Sun, 02 Aug 2020 07:26:17 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:17 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: [PATCH 09/10] PCI: rockchip: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:26:01 +0000
Message-Id: <20200802142601.1635926-10-kw@linux.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200802142601.1635926-1-kw@linux.com>
References: <20200802142601.1635926-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

This change is as per suggestion from Coccinelle:

  drivers/pci/controller/pcie-rockchip-host.c:553:2-9: line 553 is
  redundant because platform_get_irq() already prints an error

  drivers/pci/controller/pcie-rockchip-host.c:566:2-9: line 566 is
  redundant because platform_get_irq() already prints an error

  drivers/pci/controller/pcie-rockchip-host.c:576:2-9: line 576 is
  redundant because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 94af6f5828a3..eebe05ab354f 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -549,10 +549,8 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	struct platform_device *pdev = to_platform_device(dev);
 
 	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
 			       IRQF_SHARED, "pcie-sys", rockchip);
@@ -562,20 +560,16 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	}
 
 	irq = platform_get_irq_byname(pdev, "legacy");
-	if (irq < 0) {
-		dev_err(dev, "missing legacy IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_set_chained_handler_and_data(irq,
 					 rockchip_pcie_legacy_int_handler,
 					 rockchip);
 
 	irq = platform_get_irq_byname(pdev, "client");
-	if (irq < 0) {
-		dev_err(dev, "missing client IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
 			       IRQF_SHARED, "pcie-client", rockchip);
-- 
2.27.0

