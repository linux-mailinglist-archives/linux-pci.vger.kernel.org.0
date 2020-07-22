Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C5228E20
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgGVC0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:26:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45993 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbgGVC0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:07 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so837105iof.12;
        Tue, 21 Jul 2020 19:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx6GVOI+dfrOqGHWvn9QoM3JtOMYpq/JE8Tqqq/XESo=;
        b=hRecjmbwTW6e625du/eX6WV5/gikkYApXhpuoa294ySum3AElHkQrl4nRzIh6/uC4Q
         QAL7xJR08aAvOzGODJzE2RXhRYBbLQv8B9cl7d3W2QxWhR0bVDiKsvgiNRukNLG0nFuZ
         HxRS19LAWxhtxp4ns+14O41cz/20XC6SQ1ppd/hkgRZbiRuE3OShqbraXIhPSc5QBM3E
         F73y1fBpt58qwouT0Cbyatgs9Skyoe8DMnuy61D9yFTEsJoGTztxHKSiKP6mqBkcRZ7k
         I/NYgFxJLo86ECN0jWhl3EtSs0BjigdWw+KD5Su9brF/Ni1aQsFmicUbVM4S07xsDcwV
         wdGQ==
X-Gm-Message-State: AOAM530zqg0sNLjQpTdhwbMmMy4oI7IvTqPl45g6ufR1wyeIclkolcro
        HTo3GHo88YmsuhdcdaM3tA==
X-Google-Smtp-Source: ABdhPJze1eEfXQhm3Te+g4pDNDpupsU66DO3G9MUAMxA5XH1jcrIjVL0er8s/IRb3RapW1a/bMPdhw==
X-Received: by 2002:a05:6e02:e05:: with SMTP id a5mr28941292ilk.92.1595384766206;
        Tue, 21 Jul 2020 19:26:06 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 14/19] PCI: rcar: Use devm_pci_alloc_host_bridge()
Date:   Tue, 21 Jul 2020 20:25:09 -0600
Message-Id: <20200722022514.1283916-15-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move to the resource managed devm_pci_alloc_host_bridge() and simplify
the error path.

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 58f4d339eb0c..c470bff5af0f 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -940,7 +940,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	int err;
 	struct pci_host_bridge *bridge;
 
-	bridge = pci_alloc_host_bridge(sizeof(*host));
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
 	if (!bridge)
 		return -ENOMEM;
 
@@ -952,7 +952,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = pci_parse_request_of_pci_ranges(dev, &host->resources,
 					      &bridge->dma_ranges, NULL);
 	if (err)
-		goto err_free_bridge;
+		return err;
 
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
@@ -1034,9 +1034,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pci_free_resource_list(&host->resources);
 
-err_free_bridge:
-	pci_free_host_bridge(bridge);
-
 	return err;
 }
 
-- 
2.25.1

