Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE223578D
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHBO0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43493 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgHBO0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so19158041lfe.10;
        Sun, 02 Aug 2020 07:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHFVVkyvJ26w5l6BjSHc4G0RPe7rT9aQTvdBpCkShCw=;
        b=DpSdxJDKQDA4zhZpCwNktRNQDpVBxFKgUXYmeOGwytCiXqND4+iD0xE0r3yA3pnBY/
         b4xfo1os9LlUvFb6HXBqYsVNdhk+h1BA4rDRuO0xDS3+FF8U85vvPHv+yqcRYxYRcEZX
         VXeQuRZXsPjfIh3bFyjVFtRpZoEa4YM8BPlLsl99ppPK9aHwivjJZxuEKh0FoYN9KNf/
         g5p9xTLQuhgAHYoqZCYw545G1OI6Co9YYk6ia4SGCaTgCgMYO0x84XGjIaH+2d78RR0J
         nHB0QA+spRIxrrDLxxS5IhJQNx1I3RjhkEKIf/Yj4KU6fdAqHI8nZmTYSicg+9amfxbg
         00UQ==
X-Gm-Message-State: AOAM531yiCa8D6oCEgxkP/Ks1naaPvIxvm2vqv2XDnBy7WnhAE9QNOy1
        ApYBaBfvQzpb5ET4Kif1uoo=
X-Google-Smtp-Source: ABdhPJxe9uClF4yn8tZcunRWtxDlWuh9tR86znz+TOBPok/VIIe5Df/vBtq17m7kMyjbPjEFliar6Q==
X-Received: by 2002:ac2:5933:: with SMTP id v19mr6202139lfi.94.1596378374688;
        Sun, 02 Aug 2020 07:26:14 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:14 -0700 (PDT)
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
Subject: [PATCH 07/10] PCI: altera-msi: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:59 +0000
Message-Id: <20200802142601.1635926-8-kw@linux.com>
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

  drivers/pci/controller/pcie-altera-msi.c:259:2-9: line 259 is
  redundant because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-altera-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 16d938920ca5..bec666eda1eb 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -256,7 +256,6 @@ static int altera_msi_probe(struct platform_device *pdev)
 
 	msi->irq = platform_get_irq(pdev, 0);
 	if (msi->irq < 0) {
-		dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
 		ret = msi->irq;
 		goto err;
 	}
-- 
2.27.0

