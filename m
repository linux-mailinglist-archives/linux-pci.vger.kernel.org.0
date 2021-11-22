Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B81459548
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhKVTIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 14:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhKVTIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 14:08:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B0CC061574;
        Mon, 22 Nov 2021 11:05:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso86702pji.0;
        Mon, 22 Nov 2021 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsUPjYRSa+cVuPmeOccQvohC2mlPhYpnjuTt833pevA=;
        b=Bnfiah7sQM+j87SrG5I0wv4eVF/apTdvxarka+1o/gH06RgU1VCS5bsrY9Q/3Zz7W9
         8mxflCCb7v9jxD1WFro+THrRF1kGecSk2OSFh/C1SlAGIQLSYKU+cEswL935s2gT9lmR
         2INaE/xUBS36dh7UjWUmqW96bdr2qL4l1xQ6OhC1E0V2oczo1vTFXny0YFbowiLHmfmv
         GzDATb7Q2/UbAyo+8bfsgWGbe4kd2YtRXU4Hhe8/ppZcIrhI/5FsIGls7iUmLiQPgJEf
         pA+oNflZP1OpMvg8r0c3wzEDkZtYiQ6eGDusiHYh+5K7gnfPFO5ewyhsTSk5+vHlH3UQ
         3q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsUPjYRSa+cVuPmeOccQvohC2mlPhYpnjuTt833pevA=;
        b=79qdiQBMWZEfmi1DbIedwWozCf9PUqBB4ahaJdRcr+1ZUn5F6PxlL6ZdOP2dxb0mbL
         makZrqzqvf3mCdX0GMwTjc8CNvjrwRKhOR0WUFOBg4sbWtf2x6N9CwAf8GZuaWljGVUG
         ihIAkxXHEjgLWFUL8t9GIHcbOkIpCtyaEqd4rahmuO0UumdJ2iYJh6TLrTUKgKWoYTEV
         +O3EJPuV8NTeBWUsj12Y52Ovr6VYoc/eQ4dtq7rzHSlGdIWxC0mk+2afXEixPQxH3Ghe
         cpmwDY4VFDSXRU3jXCBJ23rayndEKuryFfi0OAbbtw02Gpm+2znNVQWXlPIHLqbzHGJT
         4ulQ==
X-Gm-Message-State: AOAM531uvu4MLiaOoK2V3K7Dyrsw8QWy598VcTGlIUiadQMg0nzmYcNR
        6lmsIJZ82sNHkiRbqs46Ak+kVBlsPwI=
X-Google-Smtp-Source: ABdhPJwQrX5J8WhPnfYU+bmzPaJ4iDA3831y0oX5B3bNlEZ5LDf0g4YYefDfo8BqsuVItfG4Ijjxiw==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr33223962pjb.163.1637607910934;
        Mon, 22 Nov 2021 11:05:10 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q32sm8127059pja.4.2021.11.22.11.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:05:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB PCIE
        DRIVER), Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:BROADCOM STB PCIE DRIVER)
Subject: [PATCH] PCI: brcmstb: Do not use __GENMASK
Date:   Mon, 22 Nov 2021 11:04:58 -0800
Message-Id: <20211122190459.3189616-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the legacy MSI intterupt bitmask as well as the non-legacy
interrupt bitmask using GENMASK and then use them in brcm_msi_set_regs()
in place of __GENMASK().

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..3391b4135b65 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -144,6 +144,9 @@
 #define BRCM_INT_PCI_MSI_NR		32
 #define BRCM_INT_PCI_MSI_LEGACY_NR	8
 #define BRCM_INT_PCI_MSI_SHIFT		0
+#define BRCM_INT_PCI_MSI_MASK		GENMASK(BRCM_INT_PCI_MSI_NR - 1, 0)
+#define BRCM_INT_PCI_MSI_LEGACY_MASK	GENMASK(31, \
+						32 - BRCM_INT_PCI_MSI_LEGACY_NR)
 
 /* MSI target addresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
@@ -619,7 +622,8 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	u32 val = __GENMASK(31, msi->legacy_shift);
+	u32 val = msi->legacy ? BRCM_INT_PCI_MSI_LEGACY_MASK :
+				BRCM_INT_PCI_MSI_MASK;
 
 	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
 	writel(val, msi->intr_base + MSI_INT_CLR);
-- 
2.25.1

