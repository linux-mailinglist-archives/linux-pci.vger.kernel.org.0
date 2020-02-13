Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8938315B76A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 03:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgBMC7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 21:59:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgBMC7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 21:59:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so2258543pgl.9;
        Wed, 12 Feb 2020 18:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1ACxcpxWUpfzA7rugNOMv+lfet19/IxHVNmDiRm8Aw=;
        b=daxpuG2mhvKGy6M+bSiOIwXjqRUVAN/lbjca+U36wYkrCCZX2EKevydXjk2r45oCpf
         vpkx5vstvROVHer+RuxLdwhIpYKjcvbwuwzTGzvg1xGRkPmItTiKij9A0UZHMCBvQCHq
         Xf4+FdrE9h2r9bx9Eu6Vxie/UfNPcQrcoNxBi8m2vNUZHZG1/hmsdm5mAhqhhgbpbYzr
         JPkmknGHuTRViDawI41aenAiSQpSweWVwounqIVc4+06YXSoMkYUQ8veXkCkxn3gMT19
         OgVtOBuju6iHCFv6Y3XQmrWnrzN5OWVFobvYJEy720vHiib4d/1r+mE9d9DAFjag+9ib
         O3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1ACxcpxWUpfzA7rugNOMv+lfet19/IxHVNmDiRm8Aw=;
        b=ewIgtv939Z2FR+7JsI96H02XVmTDEOpgvf8jVJEudnDqExefpQ+RW5ZHGFh0tG2c5k
         /5a5Z+HLgZP+gnKrM+Z5BHFc57LBLxEmcADkOfoy4E08sJBJPmOcpcWNYoognTe8JxEj
         aCB7bebHPmabeJPY6xT7JXLdkv9DLm+BzW6nQmIa0I+M+01NNx7c0Q87q6wv1Pnzw7mp
         mRHDehD1Hi97o168IPJkiTdf7KSxzVknFU9jkRgfylmrMPlBVYfbL3/OxJNp9pRr/7T6
         gddB23rAovUpoiCa0qItjseyZB1tBEewK2DPZhGz9JUwaKWoUaeuzFRw/myNpJZhN/Nh
         EmEw==
X-Gm-Message-State: APjAAAW9gD/EuD1qowreJudVDCdQSAcoRaSAJ4ZTmCiBogbkKNuWWLWv
        Uuheun1rMeItMfFqrbgFHYY=
X-Google-Smtp-Source: APXvYqxWHZU6f5pO82paK++ztXzf5iJMlD9SeitS31R2oQJvZ/P1yqFU3xfce65klYAvkb3EDr0Huw==
X-Received: by 2002:a05:6a00:2b7:: with SMTP id q23mr11460797pfs.43.1581562787459;
        Wed, 12 Feb 2020 18:59:47 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 64sm602643pfd.48.2020.02.12.18.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 18:59:47 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/3] PCI: brcmstb: Enable ARCH_BRCMSTB
Date:   Thu, 13 Feb 2020 11:59:28 +0900
Message-Id: <20200213025930.27943-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200213025930.27943-1-jaedon.shin@gmail.com>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe support for ARM-based Broadcom STB SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 8 +++++++-
 drivers/pci/controller/Kconfig                           | 2 +-
 drivers/pci/controller/pcie-brcmstb.c                    | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 77d3e81a437b..fb1a78606f78 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,7 +14,13 @@ allOf:
 
 properties:
   compatible:
-    const: brcm,bcm2711-pcie # The Raspberry Pi 4
+    oneOf:
+      - description:
+          BCM2711 based Boards
+        const: brcm,bcm2711-pcie
+      - description:
+          ARM-based BCM7XXX Broadcom STB Boards
+        const: brcm,bcm7445-pcie
 
   reg:
     maxItems: 1
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 20bf00f587bd..c60a27cff81a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -254,7 +254,7 @@ config VMD
 
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d20aabc26273..34581a6a7313 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -996,6 +996,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie" },
+	{ .compatible = "brcm,bcm7445-pcie" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
-- 
2.21.0

