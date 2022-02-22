Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B154BFE7F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiBVQ0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiBVQ0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:26:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F5166E04;
        Tue, 22 Feb 2022 08:26:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c6so35359503edk.12;
        Tue, 22 Feb 2022 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKklY/AvcPbu9qLUHQJPDKkDJ99GlN7DxWaF2JXSG7Q=;
        b=dg41zbDo7Mw/8L1HB44QHqsyKU9y1rhyANV7R5/y1oWP/3Dbg1eNKa+G36u2DOKVbI
         UtBK+wN17WK6M4ZCYyTgQ4gZnNrzeZ/BLRR29AcFNpQinKFCGTruTs6LLWdloVDbeffp
         0uKcZNaGFlcQBbP0AD3qv5gtNEoFhNGnBa8F2U/Upgcq+V8HACA+W93T0UfOpKaovICu
         bPOhW0Mx19qeMGuUMeE3otWQwnD11RoYzPBczTtlVtjEFnqA0hl4p9tOeFFAoETK3THZ
         iioJq45p0bD1vGAU7yE7QLnK2X7+CpgacNwvCcr+nOxGAGd86PW1QxLmMKc8OscFpFic
         oSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKklY/AvcPbu9qLUHQJPDKkDJ99GlN7DxWaF2JXSG7Q=;
        b=oV/LCM3fMibUF6Uwb+5SaekZg3+BHZKwgn2HSenCCkddnXcuspnbfsUg94K6QTQwO6
         C6jNCNAioebHqRUH9ZbnX/I4HS2LxsQxiUK4Po29Mte3Xhnn9BjVBpmUApNyggEbOHEq
         0igYtEUV43pRa0Mx/zEvobc/nNTh60S1hRm0WIcPz9KiM9jjWys0SKoOtGA0nIJkAeAv
         fLcQe/2mmIMCQcTHbf8BDAWEEHHnFu4FQl2XEmkwX8SHY3NY3lsF9VEomyl05Besjs9S
         gL3xGv13kwUud1jc/NhnTBhQjoBLpwEJy2jU3F9E3fi/2tZoE5Gl96Hn6cgeMOMjr/Wu
         rn0A==
X-Gm-Message-State: AOAM53270OfZsG80rnkz2NtqCbFZpCkBjNaA5LqXMYQ5IS8LZwItzlwW
        ej9fwDCxQ2RGRS1yD8adasZxlvT5yLQ=
X-Google-Smtp-Source: ABdhPJwzZ4KnVDlKMeSdCh+TOSR1HUo1tRsSPGilAD4NFf8d9Fb5ElIsCzOwzqK9jc31oEncafDvyg==
X-Received: by 2002:a50:ef0b:0:b0:413:2c17:d967 with SMTP id m11-20020a50ef0b000000b004132c17d967mr1846353eds.307.1645547182763;
        Tue, 22 Feb 2022 08:26:22 -0800 (PST)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id q7sm10005356edv.93.2022.02.22.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:26:22 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: cadence: Enable Controller to respond to received PTM Requests
Date:   Tue, 22 Feb 2022 17:26:05 +0100
Message-Id: <20220222162619.14645-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This enables the Controller [RP] to automatically respond with
Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
and PCI_PTM_CTRL_ENABLE bits are both set.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fb96d37a135c..940c7dd701d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 	return ret;
 }
 
+static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (rc->quirk_detect_quiet_flag)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
+	cdns_pcie_host_enable_ptm_response(pcie);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index c8a27b6290ce..1ffa8fa77a8a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -116,6 +116,10 @@
 #define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
 					(((aperture) - 2) << ((bar) * 8))
 
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
+
 /*
  * Endpoint Function Registers (PCI configuration space for endpoint functions)
  */
-- 
2.35.1

