Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF181EEFD1
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 05:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEDTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 23:19:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629D3C08C5C0;
        Thu,  4 Jun 2020 20:19:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u13so2534704iol.10;
        Thu, 04 Jun 2020 20:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ylwAjWlfQX7Ys6bdlykQN32LK5oaEYcVBjgpUdc+/vA=;
        b=KK7ot4ZFYdD12OBdHD2GsBClTx8K2XN7pjcrX+ddjRtEIKjnZ31JFQ7DWyru7gsPJj
         4aFUdXfUFdJJjYDQBxpnCisN8JdWiYpgWyNPnJDGW+26SbJ7AIFParIJ8QDaESRG5lnQ
         1032Cv87obeHTCAz13sAC4hjgm8uTdXXrgq75L3RtXkGtfGZwFkLTzV6xYvHY7XjXN/9
         8BNLQWmDADmrnIPFCpwIfzM/dz/wD+mxumBYknvjRUGy7W71O5J+lsS32yT6FEpptYXY
         KzVu6xW/T7dGAg7T0HOA/vtzQ8IOMmQqyYVG4sYvN+zMdXRkBB08BBxcFBMjRvGJTdYV
         /vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ylwAjWlfQX7Ys6bdlykQN32LK5oaEYcVBjgpUdc+/vA=;
        b=kzpJOOpk3rbDr2c9cHd8bVC8tXQpECNrvkoyys8DWvzKASndNTCjBta6hg4Zm008Jh
         rxMWsYVEmNKDS7a+9MYtrH5vrUDysZK2qi3/HNmZiXqeZ7qOjRZFA2o4cdGO7APb/3Ow
         LR/LCrqcSMUNUrHUmFYWjA19Sce/Mi0h9PM9KnWWW1jf4Mg9EYms9NbQZT0Iz/r2bU6e
         PL79lCpz2PHgLXU3m6WL1IXkT5vo5nM4aPig+LZAuk1triHGsYicmkAze509ILUIZ/1S
         sCY8jiV0zSH/hh1lBneK77WbSb1n/ulWQcFYEAKPtUTkJzISGV8LkGVo5eeA9DV8a65K
         V0gA==
X-Gm-Message-State: AOAM5310c2CabxAueMBLs1mK10sijsZLjutXczBFeYjjD9rxOr6I5G2f
        fnC7uuL2+8PcDUAc3rYShoA=
X-Google-Smtp-Source: ABdhPJzLs8qIoBTbIt3TB55cLL2yH9uHS++YiThxgv1FN+Hf0kF/axU36oWmvgm9ybtr1c0xQGYPxA==
X-Received: by 2002:a05:6602:1204:: with SMTP id y4mr6825745iot.44.1591327187717;
        Thu, 04 Jun 2020 20:19:47 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id w78sm2403655ilk.14.2020.06.04.20.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:19:47 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] PCI: dwc: pci-dra7xx: handle failure case of pm_runtime_get_sync
Date:   Thu,  4 Jun 2020 22:19:40 -0500
Message-Id: <20200605031940.27911-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 3b0e58f2de58..83986f5f2be7 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -932,7 +932,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_get_sync;
+		goto err_gpio;
 	}
 
 	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
@@ -1001,8 +1001,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 err_gpio:
 	pm_runtime_put(dev);
-
-err_get_sync:
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-- 
2.17.1

