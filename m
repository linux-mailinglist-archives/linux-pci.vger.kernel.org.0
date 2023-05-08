Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416E66FBABC
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjEHWCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjEHWBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9731A86B4;
        Mon,  8 May 2023 15:01:33 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7576ecfa4e7so240632285a.3;
        Mon, 08 May 2023 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583292; x=1686175292;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kcpsE+wXJIHOwOwJebkaqKb6ksrC76geutECDHqWm0M=;
        b=nQZCsAkpKbZH+NBSmthHZ4XSxFw4l7H/EfLchf9T90RXuolhnNuzAV2fQ8rScXRq91
         Ip/j5Zd0ka3ezfaM739EkextCL6k5czlmge55HVclKTdiCO3S3TQzVp+j8zeq/9bsxw3
         d5qafuY9OaskMjGQiz3XodwF4Q/XklCV4dWKrUAvt13CefnxU3NQ8kbrEKziMdN1xbHm
         7FTDQ6ppzxM5v2DcIyOsICQaHnF1fbqDYyVVb9lSckFAESuJURCX+AjooJc0VQUu/ncq
         f7o5F9rrYVmLmgQMUFIg+bUr1rP26spKPqmc1lb+QMcmBcz+H4ix7paA7xyDaeKcbJAP
         5orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583292; x=1686175292;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcpsE+wXJIHOwOwJebkaqKb6ksrC76geutECDHqWm0M=;
        b=CD7XxRIVtWlkQK3vBuBBMLxGPYsuZMC31Xo4XyJ5ubx99Jrm4n3x7+orV3LEmEM+ia
         L0k7aPCuVP19oII9lBZrGmv8it2cdGKXldYSwJoSQVFolBhYKPkxNsNTeGYbCmGA2aOV
         VzOvNRcGbshiBFyN0wxTM6+oTQbyjvisEZ+g+VnLj332LAskAKH4vFl5OEIdyYRAZyMq
         6e+wIwKEyMeUJ6m2ETk2RrUaQw5W2ed85J4kAJwG8NMScEgkQD0iUfriIxNmbZvzVTb7
         Bf4O7Xg9DXqpMOWveeFcWuSD+9FF9fVkvfIV0qvQCKfj/VPdbVHh7blk/2PoLpbsb/qR
         JhUg==
X-Gm-Message-State: AC+VfDwiBBYnir4NrbTOAq25Sw6FzfbOC22/DXXQO42b2QweWR/0kq0v
        3o9Y3VfMrPF9RpbTteC0ZG4AI5QS1Mg=
X-Google-Smtp-Source: ACHHUZ4Wz75x9v6n2Zda1aQQbZCKWO4yU29ClORYfdWR/7zwukW4VnTCowYWV5YO9m0VFBayAYREug==
X-Received: by 2002:a05:622a:4cf:b0:3ef:344b:2099 with SMTP id q15-20020a05622a04cf00b003ef344b2099mr17431319qtx.4.1683583292550;
        Mon, 08 May 2023 15:01:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:32 -0700 (PDT)
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
Subject: [PATCH v5 3/5] PCI: brcmstb: Set higher value for internal bus timeout
Date:   Mon,  8 May 2023 18:01:23 -0400
Message-Id: <20230508220126.16241-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
References: <20230508220126.16241-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During long periods of the PCIe RC HW being in an L1SS sleep state, there
may be a timeout on an internal bus access, even though there may not be
any PCIe access involved.  Such a timeout will cause a subsequent CPU
abort.

So, when "brcm,enable-l1ss" is observed, we increase the timeout value to
four seconds instead of using its HW default.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d30636a725d7..fe0415a98c63 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1034,6 +1034,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	return 0;
 }
 
+/*
+ * This extends the timeout period for an access to an internal bus.  This
+ * access timeout may occur during L1SS sleep periods even without the
+ * presence of a PCIe access.
+ */
+static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
+{
+	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
+	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
+	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
+
+	/* Each unit in timeout register is 1/216,000,000 seconds */
+	writel(216 * timeout_us, pcie->base + REG_OFFSET);
+}
+
 static void brcm_config_clkreq(struct brcm_pcie *pcie)
 {
 	bool l1ss = of_property_read_bool(pcie->np, "brcm,enable-l1ss");
@@ -1059,6 +1074,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 		 * of 400ns, as specified in 3.2.5.2.2 of the PCI Express
 		 * Mini CEM 2.0 specification.
 		 */
+		brcm_extend_rbus_timeout(pcie);
 		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
 		dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power savings");
 	} else {
-- 
2.17.1

