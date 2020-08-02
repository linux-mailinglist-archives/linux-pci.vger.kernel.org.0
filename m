Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC0235770
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHBO0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43315 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHBO0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id v12so6687549ljc.10;
        Sun, 02 Aug 2020 07:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gfkhr1q1ggPu0YMrYNRyEFtEoT09pWjfvzSHRK7KszI=;
        b=DuJffJ9ee4zvMf8FIlVtxmQSnsxYm68zV0jjw4z8GytRWLMexhfpKC1JjSV7P9Gpkj
         dOUxILW6MK6M57WFaeybUg/7JQLflaToy/V/EAZJIQixeOggk2CgW7i5rRGHlnmpgIeH
         2pqWpSyb9L4LGqpYjRi9zHiSQMu2GEA3w9CuC+1FIp084Ym9JQZfTHIjWilCRxsXqKLV
         cHrep+FRPTqOXVMg9Jf5s6wWNh6rcrzR9kXLafIhe7/bfa1pmP6uNGIzT1F90eGMWKxP
         E9JPVV7Y8RC7AuedD7NvyIeQGGt1MX8qzyGLCD9U+H4tpYcjn8sUK5RC3kAz2AhJDlMO
         Bg5w==
X-Gm-Message-State: AOAM530BKeVdjKYX2MKLoi1Ydt1s1uWG4BHHPzA5v/83kSGUsZSop+//
        YI61nhTkJe1VoNskjTtqnic=
X-Google-Smtp-Source: ABdhPJwj8NNsaKX276AKW3jAXsmsgaGQgCsO/u2y94Zh7oXKJWpdLXn5GIGobnMNMMKuZhl66j8/uw==
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr5607399lji.184.1596378366828;
        Sun, 02 Aug 2020 07:26:06 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:06 -0700 (PDT)
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
Subject: [PATCH 02/10] PCI: mobiveil: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:54 +0000
Message-Id: <20200802142601.1635926-3-kw@linux.com>
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

  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c:174:2-9: line
  174 is redundant because platform_get_irq() already prints an error

  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c:526:2-9: line 526
  is redundant because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 5 ++---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c   | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index a6d2190a6753..ee0156921ebc 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -170,10 +170,9 @@ static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
 	int ret;
 
 	pcie->irq = platform_get_irq_byname(pdev, "intr");
-	if (pcie->irq < 0) {
-		dev_err(dev, "Can't get 'intr' IRQ, errno = %d\n", pcie->irq);
+	if (pcie->irq < 0)
 		return pcie->irq;
-	}
+
 	ret = devm_request_irq(dev, pcie->irq, ls_pcie_g4_isr,
 			       IRQF_SHARED, pdev->name, pcie);
 	if (ret) {
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 5907baa9b1f2..fa321fcdd4bc 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -522,10 +522,8 @@ static int mobiveil_pcie_integrated_interrupt_init(struct mobiveil_pcie *pcie)
 	mobiveil_pcie_enable_msi(pcie);
 
 	rp->irq = platform_get_irq(pdev, 0);
-	if (rp->irq < 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
+	if (rp->irq < 0)
 		return rp->irq;
-	}
 
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
-- 
2.27.0

