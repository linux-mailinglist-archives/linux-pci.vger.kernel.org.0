Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C97E12CE
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 10:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKEJ3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Nov 2023 04:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjKEJ3X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Nov 2023 04:29:23 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A428DC0
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 01:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=j9pgIVNbVKA+mGdxd7ctowoNKe1CAHE+xat2Gout9gA=; b=Z8beJd
        kiUy9gUiOFHiKWuKMJF/8H8Oq8Le+4B66B//M3p52MSBXBnSyR6Z0uG4YVCgcMJq
        /MPG+DRczETc/O0hTc9dngbjyq37fVg1XZLQ/0ZRNiNKrv1kpMMjexUs5eybrhql
        LXcTC2NhNktn7RI9vzPw/r9xvdTonOpG29fMORmKB+qjLT9wLb3WmjiKNx8IWpyj
        1Nu5OemHBe9clbuY7ysQJ0pSzUY8Fvd3kjjzH7rPl9C05vXMNfHFjZDexdb2LoIM
        gwDMZhGnLcL7phoa7duUe8qEa0lYIkKwGw8bQfOHIDc89/yPaukLZJSwO45TqTZN
        H6QaxbRaVwGkbpQQ==
Received: (qmail 1670156 invoked from network); 5 Nov 2023 10:29:16 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2023 10:29:16 +0100
X-UD-Smtp-Session: l3s3148p1@B0oPX2QJdsQgAQnoAFPQANY41GnTzLIh
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 RESEND 2/2] PCI: rcar-host: add support for optional regulators
Date:   Sun,  5 Nov 2023 10:29:08 +0100
Message-Id: <20231105092908.3792-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
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

