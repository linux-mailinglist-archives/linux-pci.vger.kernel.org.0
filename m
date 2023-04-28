Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424E6F20DA
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbjD1WfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346810AbjD1WfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:35:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58C4ED2;
        Fri, 28 Apr 2023 15:35:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so457635a91.1;
        Fri, 28 Apr 2023 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682721316; x=1685313316;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlHfoAK9yIIL7Skn5B+cEJbm8dBEJYFGzxR8exxzgXQ=;
        b=Kb+u4fJA7dD3ma7mh7ur3/WOGuTpaYWQFbTJ15nPcFDNiF+ONXnzW8oq6ZHX1Vup+0
         seIwnPvE87ivhg8uQliuz2f5wPrcotvoo2mge2XTb8+v/rh7BX4DbPsX3Ntin7c+h/ax
         rYjnbirkxtlMiXz8s4dV/dmhUNqFbDTx19EsQ6LDuSEHNn0qNQhhY+7i1KdWRjD/e6wC
         x+yFh30Qrk17VtQmIeqQIsHJayPMxkkXNya5vvQmc5OPTvW77dMwYGo5UoW8xoDF/i8x
         /OeK7BaMftDsattR2p3RpxgnYorlwGLUbLnwNxdrN428PAPyHXqA4LsKc5Mg+82N1XdV
         iLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721316; x=1685313316;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlHfoAK9yIIL7Skn5B+cEJbm8dBEJYFGzxR8exxzgXQ=;
        b=lfGz87+RmfV6CiBtH4/D1G2xzBarWV0skayM8IW8/NBtd8pBXfDRNFLOh9PDaJcYor
         /AH544+CUgYZt1/AGnlcF3jBIheB4i1ylu7eR0tLm2b9fWAmxE4lTnIb4NtWPk9sziCR
         aHI30PfE0Zmmr4XEbK7uI477mxbtshXxaExyYKOWGXnv+A/rA0PYCOKvf2etxksYR7eh
         dq+nbzCQozRNyLdP4Arienk5lBAoH2WJrd0w1H9r2Jgz9mk9UP0Vz59h4oAuXtOHhsfx
         5bReHLMrWWC8oU3vLdRGlSP6mPVeLvPxmYQQ17nj3pOvG1NlZWWcuMJXXc8+K/IHh6x1
         UrOA==
X-Gm-Message-State: AC+VfDwelaZFOBrQPbadVq/0oIHLNKlWkkHBcBJAMKws3u8FAd5EZsoV
        vWFrHFcsIGzSyJhEboi+9Loyzyy6rCE=
X-Google-Smtp-Source: ACHHUZ68ybGXSJgG5K8t8W9riO0/4ScMAw2d8sx0MAvypN9nDxB1x2uEHSKe4GewhEAxoXQFTg1YHA==
X-Received: by 2002:a17:90b:1a81:b0:247:7def:236a with SMTP id ng1-20020a17090b1a8100b002477def236amr7109657pjb.34.1682721315980;
        Fri, 28 Apr 2023 15:35:15 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm13657847plk.62.2023.04.28.15.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:35:15 -0700 (PDT)
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
Subject: [PATCH v4 3/5] PCI: brcmstb: Set PCIe transaction completion timeout
Date:   Fri, 28 Apr 2023 18:34:57 -0400
Message-Id: <20230428223500.23337-4-jim2101024@gmail.com>
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

Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
completion timeout abort, we might as well extend the default timeout
limit.  Further, different devices and systems may requires a larger or
smaller amount commensurate with their L1SS exit time, so the property
"brcm,completion-timeout-us" may be used to set a custom timeout value.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c4b076ea5180..c2cb683447ac 100644
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

