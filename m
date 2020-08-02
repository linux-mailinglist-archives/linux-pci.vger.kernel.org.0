Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852B7235776
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHBO0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39814 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHBO0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9so2518336ljk.6;
        Sun, 02 Aug 2020 07:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMzZQXjK0WMetVDGn0tUCy2JU8NUEkR2xnKheZa8ZWc=;
        b=pUvPnOP5fijAN41HPU/ZrVy7uOrR7hf7TWoHvH45/obxkm1cnfTYKErV5EYfggTJza
         J2ypQ5H0cZOR82bgTH0PdCEHecoeqH5mFjQi1o42lUSFxUuYZibLLcfuBsGZgRRxpixe
         2hSyFSeXgiCdlvRuxJtrZLjJ9DuR5yRzT0ktubj3FA4A+WfiyJJ8Pm6E2J8OPFu/9HOP
         rwruXnK3f3MNnVMfdJ2539L6UdD5DZuaHomz3HqBVvpmspmazZ356D5O+VE88HTY4xPH
         F5B8dsRkDPXNktA6V0XudwkdVGCXVa4tO82Bg3oLUF6Q78r4GO07J1xSU5QHMjv0FlVc
         xKaA==
X-Gm-Message-State: AOAM533XbWNVoUbg1bAUtU8fDU4poQZhdiJnjr6S6I3/EjKJFbyODpeQ
        TBXGBTSgnEeqmD4Wy54MbG8=
X-Google-Smtp-Source: ABdhPJyjgrQc0FDjQcMFVZPpVkua7bA294ZwM5k/dH6lFvq8PdcJNGDDSetrLxIi93uNdb0Ai2zdVg==
X-Received: by 2002:a2e:752:: with SMTP id i18mr6183911ljd.428.1596378368431;
        Sun, 02 Aug 2020 07:26:08 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:07 -0700 (PDT)
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
Subject: [PATCH 03/10] PCI: tegra: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:55 +0000
Message-Id: <20200802142601.1635926-4-kw@linux.com>
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

  drivers/pci/controller/pci-tegra.c:1524:2-9: line 1524 is redundant
  because platform_get_irq() already prints an error

  drivers/pci/controller/pci-tegra.c:1742:2-9: line 1742 is redundant
  because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-tegra.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 235b456698fc..b11397475a4d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1520,10 +1520,8 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
-	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto phys_put;
-	}
 
 	pcie->irq = err;
 
@@ -1738,10 +1736,8 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 	}
 
 	err = platform_get_irq_byname(pdev, "msi");
-	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto free_irq_domain;
-	}
 
 	msi->irq = err;
 
-- 
2.27.0

