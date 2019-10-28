Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6CE79FE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfJ1UVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 16:21:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33821 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732924AbfJ1UVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 16:21:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id e4so3401693pgs.1;
        Mon, 28 Oct 2019 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o3RYmNY37sf+6DZhfgwoRw3pPEWurA9fTDFSIhMeWeU=;
        b=Oked80GciIxQk1i/LR2xCPTKwGdtHhZxyUq2WWOVcfXgw0QLfGwTKSya0fFMyXHtjs
         3AbRxlvW0j09zV7fmaXlpfIS1dMK7mr8MuFY2WEFdBy6HJ1RYD0hiloMysUpzCljhzrI
         ZKK/t6YfTEPwojUcpk4fuRj4+cfm641mdi3Wzs0y/OhMQkeolPTdwh2ClmdFDdAqMlX4
         Bj3PZiqDHS9HORzfHhTa2ekYwbrQt805VoctgMyx6pb73lLWoHNXPPL+2RybnV7fwz/2
         TlIfAphcosj9xIuxhpNKOsCqccOcPpzAqkkcCg5+5pBT4FV60WobxJZa4glF1yuLJF/w
         EzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o3RYmNY37sf+6DZhfgwoRw3pPEWurA9fTDFSIhMeWeU=;
        b=m2oUMBxzBeFs1A0o+ZuB3bNc14j/eWiA+gh/a1fXYoq+oiT1C8eEu+5arlS+6I5lN7
         mI8eS4iUWXOV2RbU0cBUna+BQHYiWSVWzDsBm0EPAkyh6p2sUbiqvzZGcRLGTCfm7HY7
         J75HSwI4qxWVgXm2cGFFiKuPCPMFKFPiIwxMAkfyGG4vryUsOUueEGmvI9FgFBHFey1h
         xLVEDLJWa5DYacQuioG+DRDKe/VclT3ozf984tLzfbzYp864nEwfjhinIVaZAore9242
         QO4bvPVwouYufvPVKRLi4XrMlNOtofKK+4iHc/rb9Dp8uOTAeB+kgguPr31Dtb8lDTzB
         fAIQ==
X-Gm-Message-State: APjAAAXCO5GiKn36HrVxcWNMBGBvc0xUJUvXL+JQ+ztMpr6WoJRy5Nfp
        h7r3Ut/jNwiDvXfgXcSZPnk=
X-Google-Smtp-Source: APXvYqwgMOgg9DoyjQ+QwjBbA0L2tFTAq78jMqvQKpUC2a2zoXo/IV6DRJzV2kNa8UPQGMxgPJo3JQ==
X-Received: by 2002:a17:90a:a00e:: with SMTP id q14mr1489905pjp.132.1572294114235;
        Mon, 28 Oct 2019 13:21:54 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id e198sm11908096pfh.83.2019.10.28.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:21:53 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:51:44 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kgene@kernel.org,
        krzk@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] pci: controller: dwc: Remove dev_err use after
 platform_get_irq
Message-ID: <20191028202144.GA29158@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 14a6ba4067fb..2293b346d96a 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -403,7 +403,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return pp->irq;
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
@@ -416,7 +415,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get msi irq\n");
 			return pp->msi_irq;
 		}
 	}
-- 
2.20.1

