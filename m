Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7B7E8F08
	for <lists+linux-pci@lfdr.de>; Sun, 12 Nov 2023 08:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjKLHoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Nov 2023 02:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjKLHon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2023 02:44:43 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 23:44:40 PST
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9C830C2
        for <linux-pci@vger.kernel.org>; Sat, 11 Nov 2023 23:44:40 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 251irZ6wGaq2K251irxRYF; Sun, 12 Nov 2023 08:37:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699774628;
        bh=+SExa3iRH7Ca8gW1D0XoaD0vtMK+3bmRILeHnVgGh+c=;
        h=From:To:Cc:Subject:Date;
        b=cOrQyt1SjHP/RA29twkYAzgtIAizHd/5aONl/TDF4wKEAiQLlJW8wk4YLPbY/PD0F
         hHxsH2xuh4KI061eHKfdIJi5FCxG4jNSQYbXuf7azREDC+9FhdsiiSUpOwEMw3GvZS
         5L9I+mhhID8YdVaS2ztTjyWJSO92FgoDkz2E1LwblGAHTpK90yJ4mioJFMN/Onc0Xw
         aKZ2IXs8U755U7xLpmWa4MQGaXSCXmaRCt1Vbx7ZuhFz+NoP15doZ2V4Ze93i6fkib
         cWp1rrzEsq+K5okptKbt63zHh3aG4EMDteovYnnGEyPt9ycwMFSJ/46lpv/rLRXMiL
         hWgg4Fos297QA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Nov 2023 08:37:08 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: kirin: Use devm_kasprintf()
Date:   Sun, 12 Nov 2023 08:37:01 +0100
Message-Id: <085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use devm_kasprintf() instead of hand writing it.
This saves the need of an intermediate buffer.

There was also no reason to use the _const() version of devm_kstrdup().
The string was known be not constant.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2ee146767971..d9e3514de0a0 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -366,7 +366,6 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 				      struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	char name[32];
 	int ret, i;
 
 	/* This is an optional property */
@@ -387,9 +386,8 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 		if (pcie->gpio_id_clkreq[i] < 0)
 			return pcie->gpio_id_clkreq[i];
 
-		sprintf(name, "pcie_clkreq_%d", i);
-		pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
-							    GFP_KERNEL);
+		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
+						       "pcie_clkreq_%d", i);
 		if (!pcie->clkreq_names[i])
 			return -ENOMEM;
 	}
-- 
2.34.1

