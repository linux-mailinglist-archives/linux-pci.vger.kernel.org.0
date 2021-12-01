Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E886465881
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbhLAVrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhLAVrJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:47:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87421C061574;
        Wed,  1 Dec 2021 13:43:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q3so32455532wru.5;
        Wed, 01 Dec 2021 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iLKxVbRfL5D52F5eGuNpLejbWDw/vMnqPr79ZUp9yU=;
        b=YsAYzw+m6+B+cYH3o+Rqa3nniwXd+yA5RydGd59iFw1ET/f+NxSSqql9y5J2m77nHm
         IneaggZPxg0GBz/b71RAj/KXVLUzb6p9xtp6Hwc22wEGOt73cg9wrRXqLX/arfv1/Z8t
         Dtm1MxD+z43C6RO3bXQmmujxCCJXk21P26QJcJADpxCX6mOI6Xo3IVNbEoV6OxU2X9To
         9zZBH3XbTHXYf+O9MiPcInxUF36bGXibcPNWwCP9EnfMQsuelF/x+QU0NuMPR7fX4xJx
         cFbLYGCAQeiFVBeDsvQMoO4FT8CfghHudajFhAP36maUusAfWV0/6PxU6gG7jM1K++Hj
         fL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iLKxVbRfL5D52F5eGuNpLejbWDw/vMnqPr79ZUp9yU=;
        b=sg7bOUdvfQ0rBm4/tVPtAtjItmlZuWI1qsV6vzk7+bB60bNmJ4Xp5/taJ0eu8PRc4n
         5z1hd+spw8h9dZB2YwsMmgBOl2t8bPG0/WQLht490bHLeTRNOl4i56Vi5dA7sKPillWT
         8/jmMLOBmAlajdDqjU6RfbPgdb+3mbe4ftjlBHVVXWYN3pq+VLEMhTgO17Vv41ujnNNr
         o3gUf1sm4mm+SmanA6OEmVfXjba33l/IUcQsVg8DZ2Z6EB67jPqpXR42tSTO8pFvpKse
         KDdjefMGNj+cCg0RXMw/ZR0i8GzNhNhNZE7a86lmAQB50sv0cx94zpsxroHLs9Ke/ef6
         V5pA==
X-Gm-Message-State: AOAM530H8lWWqy3AIRru4cstASuc9zwHSf/T6088zouVCmOwkFYS8nlS
        b5JJT3YcePhNgzxvj0kshQjnnezOrYs=
X-Google-Smtp-Source: ABdhPJzvu9ij0yYIJC0BOInjKWXo9FSmiXQKA5O5AhTopu/50YJCKMezG5qPgmBbLqEMwBv8y3itdA==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr9819167wri.425.1638395025949;
        Wed, 01 Dec 2021 13:43:45 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id j17sm491644wmq.41.2021.12.01.13.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:43:45 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, arnd@arndb.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: mt7621: Kconfig: Convert driver into 'bool'
Date:   Wed,  1 Dec 2021 22:43:43 +0100
Message-Id: <20211201214343.23307-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver is not ready yet to be compiled as a module since it depends on some
MIPS not exported symbols. We have the following current problems:

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Temporarily move from 'tristate' to 'bool' until a better solution is ready.

Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
simplify condition.

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..7fc5135ffbbf 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -332,8 +332,8 @@ config PCIE_APPLE
 	  If unsure, say Y if you have an Apple Silicon system.
 
 config PCIE_MT7621
-	tristate "MediaTek MT7621 PCIe Controller"
-	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
+	bool "MediaTek MT7621 PCIe Controller"
+	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help
-- 
2.33.0

