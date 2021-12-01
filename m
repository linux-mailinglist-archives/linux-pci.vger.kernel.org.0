Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA45465865
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbhLAVha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbhLAVh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:37:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A9C061574;
        Wed,  1 Dec 2021 13:34:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s13so55323480wrb.3;
        Wed, 01 Dec 2021 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5oF5k0nKxo54X/zrS1oK20SH/iu2DnBcjY5vFqaY9A=;
        b=lR10Aa1NS8ulVXu8d2FQ8QJKWk0RrmlrVcfyvd1PG1W5kwCkuZYyKpN+5lpon4FqRT
         aa90NFtcb3e61tzhTajo4tB2hhDTYQfqVcefOqx9BAo+WRftsfXqFPJRNSHLrL3WPfy0
         EC3vc8VENJhSNb0wDjNogsUslQFaY1nEUx8yYnudZe5kjGZFslUyF0a10eoF0tRxFbsg
         lS/OL9wYOZ4Q7pYrE7nEIPeq0hqLicdgR5T8MgO4gi444z3ZGrj0oyx31aLXUvjARWjg
         U5URM4d+0YuNB5IPaXyjbZ0xG7g31o7RPuPSiJXkAUh/dCVtqQ/TgoU287y5gvjcaFqJ
         5Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5oF5k0nKxo54X/zrS1oK20SH/iu2DnBcjY5vFqaY9A=;
        b=fVQLWAFXAhX7/UcnzGbSZwZXtqthqrmSNBXbiaBXg3NfwGvwwy5RLK7X69u2d2iFTE
         lSDS3BDnk/s6OGj4Y6RbCIKQS5zogDB65vdJMXUkwH6cM6+I1jGn7H52+gDlYQi0PSl9
         ab+o56KK24bAh3nHgVdkjKs42S/j7oNpVGiSb8lYaLMmXQZ56r9fOo8RUs26Vi4FQ9pm
         8704P0qvDJVKj1/BHTum/Oq48A+c1mIfLwVWeux7MfGx0/+k0facTjOygIEC7L1wxqlV
         ZrB20+JxPAWSaaX5AprJTYiXuXiO/zKHUoP1GThzb5LWGXZ+CJtNtNLGXzq07Bp99571
         Izpw==
X-Gm-Message-State: AOAM533cpDfyUhmLRV7+Qfzx4xJgjgHwfOtpPsTtwPRdG+HoaeIcU9Ie
        uYGlyvEivx1h1G5hyDEPYiD2vbAjrHU=
X-Google-Smtp-Source: ABdhPJwyeltcXb5cv+ko2tPJq3NgGowQET/d/bplOxrgc29PGMXPrX74S6h0o4ytp+hHpsfNe152vw==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr9729336wrf.197.1638394444193;
        Wed, 01 Dec 2021 13:34:04 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id 38sm878844wrc.1.2021.12.01.13.34.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:34:03 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, arnd@arndb.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mt7621: Kconfig: Convert driver into 'bool'
Date:   Wed,  1 Dec 2021 22:34:02 +0100
Message-Id: <20211201213402.22802-1-sergio.paracuellos@gmail.com>
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

Temporarily move from 'tristate' to 'bool' after a better solution is ready.

Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
simplify condition.

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
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

