Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1536DE1B4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDKQ7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDKQ7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:59:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A564489;
        Tue, 11 Apr 2023 09:59:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c3so9564766pjg.1;
        Tue, 11 Apr 2023 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681232373; x=1683824373;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LU4fDGYnSqojPlNTpXEuI7OFxxokivytfp/gN0CUpGU=;
        b=eCFQ+5CbxIUbqO9fjDVXP24ENvhLMQJsJzLcNLVyJ5eKPZKNjDendq5Q4g8mAEDpaK
         vk4eksJe7J09lpCgdiC9Mtt/AeYUTI+NCnc+3QBGQbNG1gUcVYTRX6iF4uWBTkaSR57e
         MAtfOJfNNqLnsaNMaOYvDcmBPIt6i4A+fANzue3LkMtwFZ3lrmYiOsMQ8sr/vzgtIO/v
         S2U0BiySmimUl64DJb5IQ24Iw+hBqAbuFb+PZ4G4AzOln0fb5rJrPLHq3RO/HmwyWrtW
         jEW1Rg65zx53lZjQvvD7SP1MwIIEjKxepNZSBhc6djgR8nbgnSx6XbhTnzQeNDf3vQiO
         FM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232373; x=1683824373;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU4fDGYnSqojPlNTpXEuI7OFxxokivytfp/gN0CUpGU=;
        b=iBQNAyj1wkk02OefZ5h7Auh9Xys1IIuaW3Y7sW3S8jpPSdIjNDvKe/W076dfWPdghN
         UxQq/XsDutp9+WQuyff1JFSgn/h18NW8fHJuHNc7KSz3Ek2llhQ4Kj0opTPxECH4Vozb
         7hsQppjRAgT5V7Eqfs8EFPyT2RqvU1M6uBmbc+ZBHB8PtsS//Ry1lbw8URImee8IsvQc
         kg5DKZW3i4RT3Q4aUJYSODZDwyCE5FYLLeG+liUUL38YFKcTtigE7o12nDLAMmXzEDoJ
         yo9yAS8rautiBpql+J+VmJY9TQ8fxHRlUzJ8v6J5nGfCtXrRyJGPyXdgqcu5MP8oPvhx
         GBtQ==
X-Gm-Message-State: AAQBX9ddHxfND1Xks8mYp9iVWsM0KBVejh6X7FLd4OX0xM1nZaAnAmj6
        DQoFdW+8/G4xsVgv92cCCMaBRHBtu1o=
X-Google-Smtp-Source: AKy350akxZlDkkyabSOqZId6p8YpUJ6BgqqQxQ8HpAYPLDESNBj6AnA2efYes/J53xPvbNJjeMuC7A==
X-Received: by 2002:a05:6a20:4a22:b0:d9:8b07:eb08 with SMTP id fr34-20020a056a204a2200b000d98b07eb08mr2603608pzb.21.1681232373452;
        Tue, 11 Apr 2023 09:59:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b0063989aab89fsm3484519pfo.23.2023.04.11.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:59:33 -0700 (PDT)
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
Subject: [PATCH v2 3/3] PCI: brcmstb: Set PCIe transaction completion timeout
Date:   Tue, 11 Apr 2023 12:59:18 -0400
Message-Id: <20230411165919.23955-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411165919.23955-1-jim2101024@gmail.com>
References: <20230411165919.23955-1-jim2101024@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
completion timeout abort, we might as well extend the default timeout
limit.  Further, different devices and systems may requires a larger or
smaller amount commensurate with their L1SS exit time, so the property
"brcm,completion-abort-us" may be used to set a custom timeout value.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 56b96aa02221..9610066f8c80 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1080,6 +1080,35 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 }
 
+static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
+{
+	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
+	const char *fmt = "brcm,completion-timeout-us clamped to region [%u..%u]\n";
+	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
+	const u32 timeout_us_min = 16;
+	const u32 timeout_us_max = 19884107;
+	u32 timeout_us = 1000000; /* Our default, 1 second */
+	int rval, ret;
+
+	ret = of_property_read_u32(pcie->np, "brcm,completion-timeout-us",
+				   &timeout_us);
+	if (ret && ret != -EINVAL)
+		dev_err(pcie->dev, "malformed/invalid 'brcm,completion-timeout-us'\n");
+
+	/* If needed, clamp the requested timeout value and issue a warning */
+	if (timeout_us < timeout_us_min) {
+		timeout_us = timeout_us_min;
+		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
+	} else if (timeout_us > timeout_us_max) {
+		timeout_us = timeout_us_max;
+		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
+	}
+
+	/* Each unit in timeout register is 1/216,000,000 seconds */
+	rval = 216 * timeout_us;
+	writel(rval, pcie->base + REG_OFFSET);
+}
+
 static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1110,6 +1139,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
+	brcm_config_completion_timeout(pcie);
 	brcm_config_clkreq(pcie);
 
 	if (pcie->gen)
-- 
2.17.1

