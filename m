Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE70129679
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390535AbfEXK6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 06:58:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46028 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbfEXK6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 06:58:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id j1so6777025qkk.12
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2019 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WAz8gevkLqNKQxTraUrqCX16agROdoxMG7UavHDKglc=;
        b=e5paL58ZqaH6aWcMFMU26/btzzRgQ9SG39Wi/1JUuKTujpqPkpXH/g21QhD6f1OoaQ
         dVVgpkJ6/M8epjPOgEqrDfsZdoOMqCSROKfTSk8oLVJ4wdnoKcbIyXHwxRQ9V9Ami51I
         W1Cau3OzwG2VNB/Qbn0tY5Se96SEp743S28kkrYetgqmKsFGvdjmj39/2OvclxB2wNnz
         q5OwVarK9yqzH847tD19lthOw5x2dPEuaabloaIwR89BJSpNoUsM+DAqBUkTDLvLM5pV
         5x7B0CHX8+yfbeS/Arn4cstnVyc9fX0x1SycNYqpfmYND09rde8BQaOpddxSS9Mixjad
         7Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WAz8gevkLqNKQxTraUrqCX16agROdoxMG7UavHDKglc=;
        b=An1ZfCPkx4VV2AW7eXXNMXWCn/F08nyI2lySfTVLE9HQeXOd1ujqeFO4CD4NoRlbMv
         yDYlmMgIMYu8hxugiWlWmXo6T/4JV9iBGaclrKxNYPAM1sWbq5kArD+FbI3y3jRup+KD
         nS60qumCYzBi9P2rRku3tEz7uloaW90VNPkn6NvprWQ7cYpsWSJ84KKNXLdMdFi8M3wC
         gMMcjhwfuVLE0+/3rUJTFtUAXWctSRAr7ClHpUj+uN4c7j+Lu7UJZcqUAAF1ThGggJAO
         mjiH2ag1ryhoQO2CLoNN4EHs9ePx1bm7ulQaXzpP5vRV1CrBHRlBQzQEYYAgS6hhSxSc
         70Tw==
X-Gm-Message-State: APjAAAVPGXp1uXCJiorvYGQ3Q2unKNyl+oS5x5jGqO+HPx9XMNlvnyiE
        VIesV6RhJs8D6DhJ3+cfxzE=
X-Google-Smtp-Source: APXvYqw+/+E06pWQhoCbw307B5F90ZuJT6h15wHU9Mwhw1WVxSrx+sBjdnNj2rEgw/aozPQQ6RH6cw==
X-Received: by 2002:a0c:9507:: with SMTP id l7mr82875975qvl.118.1558695497713;
        Fri, 24 May 2019 03:58:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id l12sm1453071qta.82.2019.05.24.03.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:58:17 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     lorenzo.pieralisi@arm.com
Cc:     bhelgaas@google.com, l.stach@pengutronix.de,
        linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] PCI: dwc: Broaden the selection of PCI_IMX6
Date:   Fri, 24 May 2019 07:58:20 -0300
Message-Id: <20190524105820.17059-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IMX6 PCI host driver also supports the i.MX6SX SoC.

However, it is currently not possible to select this driver
when only the i.MX6SX SoC is enabled.

To avoid keep expanding the SoC logic selection, make it broader
by using the more generic ARCH_MXC symbol instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index a6ce1ee51b4c..6ea778ae4877 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,7 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
-	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
-- 
2.17.1

