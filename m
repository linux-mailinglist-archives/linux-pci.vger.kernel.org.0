Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8918B79F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgCSNMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 09:12:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgCSNMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 09:12:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so2925693wrv.5;
        Thu, 19 Mar 2020 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qge0IJmCZuOR+vC+5Nwap5o8+OSunHMNr9ySqL9oA2g=;
        b=msxtTDGE4I6QUzvrhuxdwJpsib+p+en0PvEsNalGqxbSOY0H66MVlEAHucfdoX78DW
         EYT9R/nA3SICZ2SP7oncTtTi9s9eO2RqYsC+HIS1xVHbw04+mWrlFRc4o08xF/aOGauF
         TBhey34ywpLtYOuFNK179if7Rweq2OfhXPEnExv1YBA+knbT5kZzXkw7LSQNoRUwTM98
         GTQxhmagQnJYj0wRxIu25fsh5l+eDWD9ykpWsPl96um6lJn2FVtMyeXXrVcFDtVRRhgQ
         DxytxBU9eQqSeUHKNleshj8+zvkMGq42zK9x879TydhsaHb7nm2P5MifExyjpwJjDT7b
         iN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qge0IJmCZuOR+vC+5Nwap5o8+OSunHMNr9ySqL9oA2g=;
        b=mHuzKO4fv5bU/U8nm/lKLtj1YKP6eBNH/17igRvCbm8DD0nJFqp2dkTb8SdcuNN9Y6
         Xfr0TKJhXqT0h9NAwdXgnpSfhaj/g8dd9fyuBegFYG9TjWjLaSttQ3/ifwOPHId0wwmv
         uB9RwLpp0g5wlw9o8DFusFquYSFfLO1IpW5Tpg1WZHhWTsKQNBdPIPCA/a4lSEsp53LN
         V2RlimgSCyCdabaOsNyggC8cwHnn5VesoJ+GOlrwvT9FHpkSpVXIGTDp6Gdlu/vgmU4D
         ahIFdcsm3racyl7hYArgqXfU+o+jpiHUn1m79ID90WwI+uPlm1B2PgsmVWJxkBdqRnCH
         R1FQ==
X-Gm-Message-State: ANhLgQ1fHzuUA7EzOcQuxbAlXXv+Il37x25uaTXZaHAV1UajjfcfuQq4
        TEhrblhA9fGs4qR0f9jxiK842raU
X-Google-Smtp-Source: ADFU+vv+XcYW8fX3e6mDdU4JDt+hMQnyy2Myx3Iv8I4OyT90umvocqWrIMIO/RWN8VMCNPuHjv/OzQ==
X-Received: by 2002:a5d:51c4:: with SMTP id n4mr4355983wrv.203.1584623558293;
        Thu, 19 Mar 2020 06:12:38 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id e1sm3541561wrx.90.2020.03.19.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 06:12:36 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra: Print -EPROBE_DEFER error message at debug level
Date:   Thu, 19 Mar 2020 14:12:30 +0100
Message-Id: <20200319131230.3216305-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Probe deferral is an expected error condition that will usually be
recovered from. Print such error messages at debug level to make them
available for diagnostic purposes when building with debugging enabled
and hide them otherwise to not spam the kernel log with them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 42 ++++++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 97d3f3db1020..e4870fa6ce9c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1159,17 +1159,31 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	/* Endpoint mode specific DT entries */
 	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
 	if (IS_ERR(pcie->pex_rst_gpiod)) {
-		dev_err(pcie->dev, "Failed to get PERST GPIO: %ld\n",
-			PTR_ERR(pcie->pex_rst_gpiod));
-		return PTR_ERR(pcie->pex_rst_gpiod);
+		int err = PTR_ERR(pcie->pex_rst_gpiod);
+		const char *level = KERN_ERR;
+
+		if (err == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, pcie->dev,
+			   dev_fmt("Failed to get PERST GPIO: %d\n"),
+			   err);
+		return err;
 	}
 
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
 						    "nvidia,refclk-select",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
-		dev_info(pcie->dev, "Failed to get REFCLK select GPIOs: %ld\n",
-			 PTR_ERR(pcie->pex_refclk_sel_gpiod));
+		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
+		const char *level = KERN_ERR;
+
+		if (err == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, pcie->dev,
+			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
+			   err);
 		pcie->pex_refclk_sel_gpiod = NULL;
 	}
 
@@ -2058,13 +2072,27 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
-		dev_err(dev, "Failed to parse device tree: %d\n", ret);
+		const char *level = KERN_ERR;
+
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, dev,
+			   dev_fmt("Failed to parse device tree: %d\n"),
+			   ret);
 		return ret;
 	}
 
 	ret = tegra_pcie_get_slot_regulators(pcie);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get slot regulators: %d\n", ret);
+		const char *level = KERN_ERR;
+
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, dev,
+			   dev_fmt("Failed to get slot regulators: %d\n"),
+			   ret);
 		return ret;
 	}
 
-- 
2.24.1

