Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84277DF1A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjHPKn7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbjHPKnb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 06:43:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBA5211E
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=JT/ceu3tRi/TtP6bujmqfafQ7JcoYnXeX4PGLaTdLSE=; b=ZE4bWY
        xzImjPSE/fGTZArxDGKK/We1LyxUywLQ0RHkLRfA8V86IN11mT6uCdr9OBdHqnrn
        iP6l8i9nSizrUfV4Rqud/S+uZLEi9+Gyd1mz3oJFKN2iA7/RmNiFE0YXZp63UrVm
        bxCAiSU/fjtTT1y7NjJbB8JitoC5i0Hy0WFWaYJgAuI2inCrwqm2j2Qz5p+o2Res
        8j1QazF/rq1tMtSBEScX6vpdnzFGHcbTRgj+5zN1QPsuMONR/znfd8jLpAVapMDh
        y4cS9ZImugHHyeRAbbMY6I1hVDWhh1twGur3KNIi6gJMIlnBsmRgUhRRZFPpm8PX
        PmHGQOCFoHioaf3A==
Received: (qmail 102039 invoked from network); 16 Aug 2023 12:43:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 12:43:10 +0200
X-UD-Smtp-Session: l3s3148p1@PlM19gcDUr0gAwDPXy5qAJ1huuy56R1W
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: rcar-host: add support for optional regulators
Date:   Wed, 16 Aug 2023 12:42:50 +0200
Message-Id: <20230816104251.19744-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
References: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The KingFisher board has regulators for miniPCIe, so enable these
optional regulators using devm. devm will automatically disable them
when the driver releases the device. Order variables in reverse-xmas
while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/pcie-rcar-host.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 88975e40ee2f..7aecc114af4f 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -29,6 +29,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-rcar.h"
 
@@ -953,14 +954,20 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{},
 };
 
+/* Design note 346 from Linear Technology says order is not important */
+static const char * const rcar_pcie_supplies[] = {
+	"vpcie12v", "vpcie3v3", "vpcie1v5"
+};
+
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
 	struct rcar_pcie_host *host;
 	struct rcar_pcie *pcie;
+	unsigned int i;
 	u32 data;
 	int err;
-	struct pci_host_bridge *bridge;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
 	if (!bridge)
@@ -971,6 +978,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, host);
 
+	for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
+		err = devm_regulator_get_enable_optional(dev, rcar_pcie_supplies[i]);
+		if (err < 0 && err != -ENODEV)
+			return dev_err_probe(dev, err, "can't enable regulator %s\n",
+					     rcar_pcie_supplies[i]);
+	}
+
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
-- 
2.35.1

