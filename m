Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8975527497C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVTth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 15:49:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40487 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVTth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 15:49:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id m5so19388989lfp.7
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 12:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KBEumJQMXXdLGLIkpzZmhtm8YLY//YYDJTWXBzqB8g=;
        b=GbznRoGSsovxsMD4YLbyQIZTN4g8lrN+PyuYEmK8b8XfalwLb3HNi+iZz+q5+Ks8p8
         7dJllXM1uKBAL8MFPCK5dahNBBNuFgqcNVbj1799UM817MQSqzyGkNbDW+wmBlrPM8qi
         Ja3Nya5bnoA6YdHkXXmGKLZ5nxQhA/2rKFqPcwLLO4euUXKqa1Zn+XBHHAO52ef0EJb0
         ohEXaW+qCuLxY+EOckOZAfI5EzV4yUvjZNXArT6C/25BwYtIBfOnT7t1quF8vWowexoi
         Lg269Cd8H8ZqU048dBV3tR9S0kHSaWe2hOYbaEXah0n6E/wJdaZyRbGhw7BGHuSCZ48I
         cvJA==
X-Gm-Message-State: AOAM5325ccLrr9MW8t4tmbWxXH5OxfK0oE25saFhueTfRBS8PvSX47Yg
        WdeVFdMYxy/vhP+KguT3M+g=
X-Google-Smtp-Source: ABdhPJxEnzql5UoLh19rKN8blX0/7PUzGlRQecaxPYKH8r9g1qE/6Q6Wi269fEMtfJsrdbQcRfKppA==
X-Received: by 2002:a05:6512:302:: with SMTP id t2mr2136381lfp.432.1600804175026;
        Tue, 22 Sep 2020 12:49:35 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u20sm3784438lfo.156.2020.09.22.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:49:34 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Ray Jui <rjui@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] PCI: iproc: Fix using plain integer as NULL pointer in iproc_pcie_pltfm_probe
Date:   Tue, 22 Sep 2020 19:49:32 +0000
Message-Id: <20200922194932.465925-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix sparse build warning:

  drivers/pci/controller/pcie-iproc-platform.c:102:33: warning: Using plain integer as NULL pointer

The map_irq member of the struct iproc_pcie takes a function pointer
serving as a callback to map interrupts, therefore we should pass a NULL
pointer to it rather than a integer in the iproc_pcie_pltfm_probe()
function.

Related:
  commit b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to
  default functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-iproc-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index a956b0c18bd1..b93e7bda101b 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -99,7 +99,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	switch (pcie->type) {
 	case IPROC_PCIE_PAXC:
 	case IPROC_PCIE_PAXC_V2:
-		pcie->map_irq = 0;
+		pcie->map_irq = NULL;
 		break;
 	default:
 		break;
-- 
2.28.0

