Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA0C1819
	for <lists+linux-pci@lfdr.de>; Sun, 29 Sep 2019 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfI2Rld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Sep 2019 13:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbfI2Rdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Sep 2019 13:33:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF98A21A4C;
        Sun, 29 Sep 2019 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778414;
        bh=hkctlvyNTnBfIMJFghBmAj+o0d3mrZHtRkI+IrQdr+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Q8uY+6o8VguyrbJ6JIMG3iqjnQI9Yr654JhCIxz7dFz5lWefHxcP/TFoFxm3WpPb
         W6mw3w/4ZsJgRoPxIT1fRlxM8vN6dgWRa6a87GmDqPA52sUvHKeO2DFFtyxIdoigfF
         M2Ay8ARzoWBzY1ewS+R6aan08dpA+LOuYx84gkwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 22/42] PCI: Add pci_info_ratelimited() to ratelimit PCI separately
Date:   Sun, 29 Sep 2019 13:32:21 -0400
Message-Id: <20190929173244.8918-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173244.8918-1-sashal@kernel.org>
References: <20190929173244.8918-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Krzysztof Wilczynski <kw@linux.com>

[ Upstream commit 7f1c62c443a453deb6eb3515e3c05650ffe0dcf0 ]

Do not use printk_ratelimit() in drivers/pci/pci.c as it shares the rate
limiting state with all other callers to the printk_ratelimit().

Add pci_info_ratelimited() (similar to pci_notice_ratelimited() added in
the commit a88a7b3eb076 ("vfio: Use dev_printk() when possible")) and use
it instead of printk_ratelimit() + pci_info().

Link: https://lore.kernel.org/r/20190825224616.8021-1-kw@linux.com
Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 088fcdc8d2b4d..f2ab112c0a71f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -884,8 +884,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
-	if (dev->current_state != state && printk_ratelimit())
-		pci_info(dev, "Refused to change power state, currently in D%d\n",
+	if (dev->current_state != state)
+		pci_info_ratelimited(dev, "Refused to change power state, currently in D%d\n",
 			 dev->current_state);
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc1..9feb59ac85507 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2375,4 +2375,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_notice_ratelimited(pdev, fmt, arg...) \
 	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
 
+#define pci_info_ratelimited(pdev, fmt, arg...) \
+	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.20.1

