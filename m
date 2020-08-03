Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A492723A015
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgHCHKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 03:10:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38595 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCHKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 03:10:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id 140so19913827lfi.5;
        Mon, 03 Aug 2020 00:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ay3Bi+IiWilbDlJUPitXEI+RuPwMq9ZiJzLYPsaopL8=;
        b=VmEv7ht3tbzEjR43gO6kF/kKJefoGqpzYt2q/qWhKwQa9LjPBePoWAjwyDiQfjJAWL
         6PoHp+toQ+tT2XT8kzPQoFyfx3/5KhMzCipUimY7uREgdOehqoc6uCRmaoC6a6q+255f
         bU7vb/AJbkpbP1uxXYnOiFF6DlG6FFOM+p1qQDyPp96/YBBo6/HP0Zv/YESp23rE8Q2B
         H6XnxmIZkhzx43Y9P06IAwsiXbbGSpILnKrnpkxfgQQIdPqvNTIlQmkacaTztkBxO39B
         LQiFUVgIpI13D7By1fTGf9AAriz5C4t4L7L+zv9h3xVjf+jXGYoftv9qUg4ieLDYcWaD
         diSg==
X-Gm-Message-State: AOAM531UJGEfwo9xhUFqqUzIDalaeujpl0VQHXoYXaOy8rdNfX67fgIV
        +IE21ruZHMWwALIKGDzcwrI=
X-Google-Smtp-Source: ABdhPJzYw7yZDvJbTJfDGxm7OY2EE10qIOitHhsEhQ9czxB+hKmQdhCqIuug22Bs0Z17tX3e9sBetw==
X-Received: by 2002:a19:a07:: with SMTP id 7mr7780618lfk.65.1596438642541;
        Mon, 03 Aug 2020 00:10:42 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r11sm3877560lji.104.2020.08.03.00.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 00:10:41 -0700 (PDT)
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
Subject: [PATCH 10/10] PCI: xilinx-nwl: Remove dev_err() when handing an error from platform_get_irq()
Date:   Mon,  3 Aug 2020 07:10:40 +0000
Message-Id: <20200803071040.1663662-1-kw@linux.com>
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

  drivers/pci/controller/pcie-xilinx-nwl.c:732:2-9: line 732 is
  redundant because platform_get_irq() already prints an error

  drivers/pci/controller/pcie-xilinx-nwl.c:589:2-9: line 589 is
  redundant because platform_get_irq() already prints an error

  drivers/pci/controller/pcie-xilinx-nwl.c:600:2-9: line 600 is
  redundant because platform_get_irq() already prints an error

  drivers/pci/controller/pcie-xilinx-nwl.c:801:2-9: line 801 is
  redundant because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 9bd1427f2fd6..55489b728484 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -586,7 +586,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	/* Get msi_1 IRQ number */
 	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
 	if (msi->irq_msi1 < 0) {
-		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -597,7 +596,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (msi->irq_msi0 < 0) {
-		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -728,11 +726,8 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 
 	/* Get misc IRQ number */
 	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
-	if (pcie->irq_misc < 0) {
-		dev_err(dev, "failed to get misc IRQ %d\n",
-			pcie->irq_misc);
+	if (pcie->irq_misc < 0)
 		return -EINVAL;
-	}
 
 	err = devm_request_irq(dev, pcie->irq_misc,
 			       nwl_pcie_misc_handler, IRQF_SHARED,
@@ -797,10 +792,8 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 
 	/* Get intx IRQ number */
 	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
-	if (pcie->irq_intx < 0) {
-		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
+	if (pcie->irq_intx < 0)
 		return pcie->irq_intx;
-	}
 
 	irq_set_chained_handler_and_data(pcie->irq_intx,
 					 nwl_pcie_leg_handler, pcie);
-- 
2.27.0

