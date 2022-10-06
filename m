Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5485F70EB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJFWEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiJFWDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0AD14298C;
        Thu,  6 Oct 2022 15:03:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so7446592ejb.13;
        Thu, 06 Oct 2022 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WVgi7cf2nCE6FtjgZdFym8h242QTEgsOcOWpCYFthvU=;
        b=i8nPaM07aW4cMqaMDWT75pSBMzwZRPp1grWHmnpf6JyHfmUyVET6ufw21LcCDff05L
         CrN2uZhUoyuEE+tn9hX5KHQlJ/ugeZvxNrXuPoX93juF8DSn1okUYV6ZNQ4Dfpy9wX5s
         eylSiTE05hB3tAPXWHDBF45EVs/A6mF273B4GshO1jDGMtEbprs9Une7tcHF070HXCSC
         PoUfLyz8CD9Z9foxK6lY2IkDslbStcy23Zm57u/iAOn3RO/OuWgDoQotpK/Gtzbnq2DH
         LacJHThC+ndnfOi7XBJEwdjNpqWUMkRKxYyZdXN+xVkWY2ToYACmzyH4G3K8TyRMQPcs
         cIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVgi7cf2nCE6FtjgZdFym8h242QTEgsOcOWpCYFthvU=;
        b=B3GapZc0lUXqoC6SYs5URRxDLJeyXiB9vAkGfot2Rj8r5QIlC+s5dm+sgwBarKZGPr
         I2wynkaBwau8uJ4Oj86ymJi6NZ8wH/QTYC5uodRE503O8TT34Nz/B+dx4VkQR1VgUXxA
         R7dj1wVZqs5IhEcEdFVTp/VIHDjKTar3FJXftRPnLQml/mMJrZrzGlZ+GxEWtkZlPwNR
         UuzA5g0JR/rWXvzURZ90J4EvwkpEE8WPOtw4eRn6kaWRPubJaYHfUfXFgSRrkGQd4lO2
         hIs26msU1eykJQvwAg0fjDUvVMs+SjF3li/3rpU05Xz7RLm96GTc3pXDmpOb+NKE0R+4
         PECQ==
X-Gm-Message-State: ACrzQf1xIPfHEgaKhs+VOEqNBfVGIwzeRq81ImYlYZHsIB3pdmG7HVQg
        KOeR3wcwDRo0KNo1u4S8WMb5IrNeb20=
X-Google-Smtp-Source: AMsMyM4Q4/D5aTPTEHm/+pjWR/xFQs5R+gr+q/KnW2RoaEJtIaSqwoApES+cSI8EAe6Hf+m+MM8Dqg==
X-Received: by 2002:a17:907:9816:b0:787:4350:3a19 with SMTP id ji22-20020a170907981600b0078743503a19mr1521283ejc.627.1665093825886;
        Thu, 06 Oct 2022 15:03:45 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:44 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Date:   Thu,  6 Oct 2022 18:03:21 -0400
Message-Id: <20221006220322.33000-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006220322.33000-1-jim2101024@gmail.com>
References: <20221006220322.33000-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
the Maximum Payload Size (MPS) are returned in one completion, and data for
PCIe read requests greater than the MPS are split at the specified Read
Completion Boundary setting.

Set RCB_64B so that read compeletion boudnary is 64B.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e3045f1eadbc..edf283e2b5dd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -53,6 +53,8 @@
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
 #define PCIE_MISC_MISC_CTRL				0x4008
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
@@ -900,11 +902,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	else
 		burst = 0x2; /* 512 bytes */
 
-	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
+	/*
+	 * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
+	 * RCB_MPS_MODE, RCB_64B_MODE
+	 */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
 	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-- 
2.17.1

