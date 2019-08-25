Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95A09C674
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 00:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfHYWqV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Aug 2019 18:46:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36232 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfHYWqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Aug 2019 18:46:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so13501248wrt.3;
        Sun, 25 Aug 2019 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7qd1X6rg/vrKrkBZiOoTeJ3D1xlptLFe6fvd/kCGec=;
        b=fKRnKukp1uCf6vgXgkNw8dVyMaqYPm5WdW26pJ/3u6tXAh/Y9Wj2noRzyJY/m7TuG7
         8PsrPmUHqi5/s6YVq1WzHkdsLjD5M5aJmhXDBjbLRgVTc62j7yzdprrCgaHogCW7I9kg
         ExWZdKtp5hDH/mtfBtS+byAwnJ4xMf2qeEGPSpSn4SJB2z/sst8zTx20GW5GytQORRIX
         TXjuAz9ZWHJsyEkQwaUR0aqg6u7jVljD3GE8IrBL9drMI3BRMVcZ1wDYlchKewnY6LGD
         VzA0MDBn/Aww5Gs3RpbemdHBuIKalU+BEpE1v4FaT9w1HxIihNiax55PEONhEVsiuiMX
         wtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+7qd1X6rg/vrKrkBZiOoTeJ3D1xlptLFe6fvd/kCGec=;
        b=f/y0DwHBTu3kVj6KzU3R5S2xVNJYinHsBjVXuYYk00tas2g8sCKXzoavr3RCUUerze
         gL0xMHS1cLKpdAmXUOoU9VPdDri6ElzJVg2i3+dMgDh9RXBlz7ur4echne6iDGXohjpl
         2Ye4E4jD1Mn/HVMMbVP60AYTR/upm0VK6g6LwC36ThpH7NLdT5g46BqJCx38J0RWQ4+r
         RTbjnugw1bEV7LICUozT6FaN8QSoR1L2ILu0NilpZGam/HkT3La7hULRMquLY/ZhZOHB
         4yWtk+R5bs283MoAQEtBZxPrC879yMSxW1u1y+78t/c84YPJAUlkVveupcju68d/mg/C
         +mjg==
X-Gm-Message-State: APjAAAXqEBM8ydNhiAqKSZjt8DyqK1ZKfocbKqWaH5b2xuJSpSI4Pn6i
        g2EQPooai3WAMbNOlE7IZwo=
X-Google-Smtp-Source: APXvYqyT1PuPmpvkvGvANX5g0+7WO1DxuKEAwhPENnCuKxVLLxj2mkeyJFQwPN58pmLBQhbeuDNMHg==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr18628640wrq.110.1566773178888;
        Sun, 25 Aug 2019 15:46:18 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id o11sm8578922wmh.46.2019.08.25.15.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 15:46:17 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Remove the use of printk_ratelimit() in pci.c
Date:   Mon, 26 Aug 2019 00:46:16 +0200
Message-Id: <20190825224616.8021-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do not use printk_ratelimit() in drivers/pci/pci.c as it shares the
rate limiting state with all other callers to the printk_ratelimit().

Add pci_info_ratelimited macro similar to pci_notice_ratelimited
added in the commit a88a7b3eb076 ("vfio: Use dev_printk() when
possible") and use it instead of pr_info inside the if-statement.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f20a3de57d21..e3d190d003c5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -890,8 +890,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
-	if (dev->current_state != state && printk_ratelimit())
-		pci_info(dev, "Refused to change power state, currently in D%d\n",
+	if (dev->current_state != state)
+		pci_info_ratelimited(dev, "Refused to change power state, currently in D%d\n",
 			 dev->current_state);
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 463486016290..73ce8d908322 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2367,4 +2367,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_notice_ratelimited(pdev, fmt, arg...) \
 	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
 
+#define pci_info_ratelimited(pdev, fmt, arg...) \
+	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.22.1

