Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292177001CB
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbjELHxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbjELHxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 03:53:06 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D03100CE
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Siu7J+QIWnH3jb
        OtQH7v418EQGQGCXvEZXiv8ysslcg=; b=HZJMbqDCJsFH1iG6l6wns8XtGgYzGD
        Ix7hfQE9afCjFtqYFLU4JFNjlHE+SxKWJ8S6MMobWpmSLorNPPAn9tPTGMlpsM+Y
        57/tvUPlvz8S6fy5i9vq8Rarka7v+OiIK58aXphaUKcAEAR/mo/vSOzxlOsR+usy
        llnbXVeGXhTWU=
Received: (qmail 3101884 invoked from network); 12 May 2023 09:52:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 May 2023 09:52:46 +0200
X-UD-Smtp-Session: l3s3148p1@HnMHZHr7CLYujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: rcar-host: add support for optional regulators
Date:   Fri, 12 May 2023 09:52:41 +0200
Message-Id: <20230512075241.2770-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230512075241.2770-1-wsa+renesas@sang-engineering.com>
References: <20230512075241.2770-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The KingFisher board has regulators. They just need to be en-/disabled,
so we can leave the handling to devm. Order variables in reverse-xmas
while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since v2:

* return directly with dev_err_probe
* reworded the error message to avoid repeating 'error'

 drivers/pci/controller/pcie-rcar-host.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e80e56b2a842..f4b31d206634 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -29,6 +29,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-rcar.h"
 
@@ -974,14 +975,20 @@ static const struct of_device_id rcar_pcie_of_match[] = {
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
@@ -992,6 +999,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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
2.30.2

