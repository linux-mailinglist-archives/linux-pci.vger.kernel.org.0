Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB35E6F20DF
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbjD1Wfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbjD1Wfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:35:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FAE5BAC;
        Fri, 28 Apr 2023 15:35:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso3892695ad.2;
        Fri, 28 Apr 2023 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682721322; x=1685313322;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyCMutM3XR7UqQNXvyE3UlGy3eP0WxqAenzYZpxmAUk=;
        b=ZqOHNSSwc1p+SXnbXXR8VyjHYjV1nHxeFEw8EYt7f/hreRJrimkKUvP/Skpxkud6sv
         9ZqvzOBRZAVFccK69sJC93Ej3w3Oj/RBgClqub2cC110RUnOe1S/XyRuHDfV7DnlzEQc
         rC6a5pJcZwB4PiWGqgkqaS74FMkojE4742aCw6ZoOIpfsoo0L9/kzyA1nZTt/OCg79nc
         HH3wwnXEfzpZMwaOvU2Qnx75IXcHd/8/25W/6dclbpZegPKfZuPkeVBJWSx07sW+oE47
         KdMzdFCyD3t//70b2A7rYFhpvVaI2UukR7VQCeqSVVXGtvfroX125wpM9QR8bvZzixK0
         qSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721322; x=1685313322;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyCMutM3XR7UqQNXvyE3UlGy3eP0WxqAenzYZpxmAUk=;
        b=RcjDU8H3fTcRCgDXQP8Ga5zFqgEHo5G0U374DOU+mHioDpYePJl1R48j+Z7z20C81v
         g50fa1zRq1CWBSDejBGuFpzgW7iPJFu3HD3I2mNUrfX8gkdxIn2LUKziI6ko/rzJfLVq
         FZijW5BijHwiSdvA/ASHbEbnL5hm/dHuKre7Z5UFqyztB8bZgBPbjMD9z1MNFnLeFCLx
         My7jeh/6uICyoqoAk3ex//y4FFLCPt+AVBzU5drzEL7ncwP8AxIugT1G+5wzALQ1wGgG
         mGOBzWBl20g9bl8FPEGd5E0a6P3hBcdsFBwG15Rxxsy/aUJzdDBaBEDbFF5gSRlJhY8W
         0ikQ==
X-Gm-Message-State: AC+VfDwMhdSLdtM9DuSUKDnEnbNr3kajFTY60tsB5QH8Uu/gngi97iWb
        GZr/Nhf934QnyA7XOo/hCfT4mKO2HFw=
X-Google-Smtp-Source: ACHHUZ7+91atWxFkw5CuAQIQHCd0j3x7oUzOTb3fUr+/wDoDCx5E0tjtJeTEjJJqUKsUEOdUqHe/4Q==
X-Received: by 2002:a17:903:2451:b0:1a9:baaf:7ed with SMTP id l17-20020a170903245100b001a9baaf07edmr6753096pls.66.1682721322215;
        Fri, 28 Apr 2023 15:35:22 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm13657847plk.62.2023.04.28.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:35:21 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/5] PCI: brcmstb: Remove stale comment
Date:   Fri, 28 Apr 2023 18:34:59 -0400
Message-Id: <20230428223500.23337-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230428223500.23337-1-jim2101024@gmail.com>
References: <20230428223500.23337-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A comment says that Multi-MSI is not supported by the driver.
A past commit [1] added this feature, so the comment is
incorrect and is removed.

[1] commit 198acab1772f22f2 ("PCI: brcmstb: Enable Multi-MSI")

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c486f4b979cc..25f11f03fa09 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -449,7 +449,6 @@ static struct irq_chip brcm_msi_irq_chip = {
 };
 
 static struct msi_domain_info brcm_msi_domain_info = {
-	/* Multi MSI is supported by the controller, but not by this driver */
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		   MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &brcm_msi_irq_chip,
-- 
2.17.1

