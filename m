Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295BF6FA902
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjEHKqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjEHKqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:46:30 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4427F24
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Su+LIM099dBNN5
        I/2zqemLMlE9HMV3Yah2C6jRkZbDk=; b=iyP8TDXVUIrCjCS5ppDQZq5VQ7viSa
        g5ULeT4CgvfOXRExfuT4YfkL4WkKrTXJbLcPTJON2Hjf1g0bNpNrJjcJQs1oC3+Y
        g029BS/M/mZNlBbIk6mM5zxFjMhXq4pKUU0zMZn0IHM2H6e30roEoANk8/JTucTW
        iAwBgNzjjAeHk=
Received: (qmail 1693319 invoked from network); 8 May 2023 12:46:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 May 2023 12:46:10 +0200
X-UD-Smtp-Session: l3s3148p1@5w7EWCz7tsMujnsI
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
Subject: [RFC PATCH 2/3] PCI: rcar-host: add support for optional regulators
Date:   Mon,  8 May 2023 12:45:56 +0200
Message-Id: <20230508104557.47889-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The KingFisher board has regulators. They just need to be en-/disabled,
so we can leave the handling to devm.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e80e56b2a842..b0e4834176d2 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -29,6 +29,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-rcar.h"
 
@@ -992,6 +993,14 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, host);
 
+	err = devm_regulator_get_enable_optional(dev, "vpcie3v3");
+	if (err < 0 && err != -ENODEV)
+		dev_err_probe(dev, err, "error enabling 3.3V regulator");
+
+	err = devm_regulator_get_enable_optional(dev, "vpcie1v5");
+	if (err < 0 && err != -ENODEV)
+		dev_err_probe(dev, err, "error enabling 1.5V regulator");
+
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
-- 
2.30.2

