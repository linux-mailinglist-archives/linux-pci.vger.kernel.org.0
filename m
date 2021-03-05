Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E206132E7DB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 13:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCEMXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 07:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCEMXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 07:23:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C3C061574
        for <linux-pci@vger.kernel.org>; Fri,  5 Mar 2021 04:23:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 192so2079430pfv.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Mar 2021 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLEgE3KLEJBq4GjswhlTmPclj40rgJ4aU4TdrpasfvY=;
        b=HcGig8wh4FuqeqC5JagtzG3Tlq0AzchonA+4qTGaJYAumSn705D2UO0xVnU05s2exw
         JRMAP5mm7eapsHRW2ttoCkrgdUQVYHHH4pU4zxQMcXQI4RkIKS8yDgFOP4W+xJ4+a8F0
         4+qtlV0rPo2X1fyTAmBEzXpR9LFFN1S6yTE6ktPWwBo0jfVtN+d7KfmwW+Q/LonQoF2o
         6mWgaQc9FGfxUZgm+pJC2WYaFfNYw/wg5Dz6fLIabuyLtl/EdsB33SyMPm8bHC6fOW+v
         XzPHEnUUuanl+r8M0q+yab6PJZFbDWdhqlkyA4bcBxM5ayuK3mjCMtwhZqX3lZMNBnbJ
         d5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLEgE3KLEJBq4GjswhlTmPclj40rgJ4aU4TdrpasfvY=;
        b=K6R4pDf+KQMlbKXCnTjuR/9AP8JFu0TEhr0OB1iKtasBg3NwIUGjSwyO5wG3yTGNG1
         uaAJqFhzDKphLrGalPonmji1FBGpcKsm51dgivlDE8/cr24UE8oAuj/6oqK5wQ0+a561
         x4pBgsIPakgL7qqyL4GR5Wzlprmw14+OJqLdDaBd1LUhwE5LkLVR8mo1w0HqloGmRaIz
         V/c5xTvWUilD0/HggKbV3nkVPQyUSKkrBxuVh6s/YGW+NgCdMARoVE+jp+DZyY92Vuvj
         YMs8hx7KhmYgQ0AnegHzvLhUSCRNHxaXaN5Rc7sLKrliEI8xrpoHwMI+uXTkXA/Tffj9
         lavA==
X-Gm-Message-State: AOAM532NRA/y00ysTF2Lc2CN2wrVjzTmsqxoH5lPfbCXuauGM4LfsWSg
        48qZN8yyumRtmcX5Fvhs331/UzW7ujFYOQ==
X-Google-Smtp-Source: ABdhPJzG5046nlmJ0u+Dtd1NFLEs4EOoEcaC1pqJqXoNVYSNMuXewn8sp+CjkmHKCtpK/nYCyCBPWQ==
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr8332681pgk.201.1614946987521;
        Fri, 05 Mar 2021 04:23:07 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id 184sm2363069pgj.93.2021.03.05.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 04:23:07 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V2] PCI: Use __pci_set_master from do_pci_disable_device
Date:   Fri,  5 Mar 2021 21:22:56 +0900
Message-Id: <20210305122256.133779-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

__pci_set_master is there to enable or disable the Bus Master Enable
bit in the COMMAND register.  This function also has debug log which is
useful to users.

do_pci_disable_device is also disabling the BME bitfield where some of
the codes are duplicated with __pci_set_master.  The only difference
between the two is whether to set flag `dev->is_busmaster` or not.

This patch removed that duplications by adding one more parameter to
__pci_set_master `update_bm` to decide whether to update the flag or
not.  It also will have the debug log from __pci_set_master which is
good for debug from logs.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
Since V1:
  - Update commit description to indicate why this patch is needed.
    (Krzysztof)
  - Take dev->is_busmaster into account by adding a new argument to
    __pci_set_master.  (Krzysztof)

 drivers/pci/pci.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..374b555b59c0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -48,6 +48,8 @@ EXPORT_SYMBOL(pci_pci_problems);
 
 unsigned int pci_pm_d3hot_delay;
 
+static void __pci_set_master(struct pci_dev *dev, bool enable,
+			     bool update_bme);
 static void pci_pme_list_scan(struct work_struct *work);
 
 static LIST_HEAD(pci_pme_list);
@@ -2101,13 +2103,7 @@ void __weak pcibios_penalize_isa_irq(int irq, int active) {}
 
 static void do_pci_disable_device(struct pci_dev *dev)
 {
-	u16 pci_command;
-
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
-	}
+	__pci_set_master(dev, false, false);
 
 	pcibios_disable_device(dev);
 }
@@ -4244,7 +4240,7 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
-static void __pci_set_master(struct pci_dev *dev, bool enable)
+static void __pci_set_master(struct pci_dev *dev, bool enable, bool update_bme)
 {
 	u16 old_cmd, cmd;
 
@@ -4258,7 +4254,9 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 			enable ? "enabling" : "disabling");
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
-	dev->is_busmaster = enable;
+
+	if (update_bme)
+		dev->is_busmaster = enable;
 }
 
 /**
@@ -4309,7 +4307,7 @@ void __weak pcibios_set_master(struct pci_dev *dev)
  */
 void pci_set_master(struct pci_dev *dev)
 {
-	__pci_set_master(dev, true);
+	__pci_set_master(dev, true, true);
 	pcibios_set_master(dev);
 }
 EXPORT_SYMBOL(pci_set_master);
@@ -4320,7 +4318,7 @@ EXPORT_SYMBOL(pci_set_master);
  */
 void pci_clear_master(struct pci_dev *dev)
 {
-	__pci_set_master(dev, false);
+	__pci_set_master(dev, false, true);
 }
 EXPORT_SYMBOL(pci_clear_master);
 
-- 
2.27.0

