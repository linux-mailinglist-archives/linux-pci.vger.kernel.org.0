Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898C17EFE5D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Nov 2023 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjKRH4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Nov 2023 02:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRHz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Nov 2023 02:55:58 -0500
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C615A2
        for <linux-pci@vger.kernel.org>; Fri, 17 Nov 2023 23:55:55 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4GBDrwEoPODaN4GBDr1qY9; Sat, 18 Nov 2023 08:55:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700294153;
        bh=V9Th/4FKB+iHrGZuL+784CAl/VlpMqyAVTrSivrk2DI=;
        h=From:To:Cc:Subject:Date;
        b=X3Sk6OjhaTrfqzMPiplQYjmJHnUa+bh94ufi/kGIuBy5qMNbGfcBw5ssqG/2sz8yC
         o4DKWGpTEFWwB7f4Pz9YQ7hMYkrTPlnZkVVoS66drjZatrRnOTwJm7j1xep2QljbK4
         Ge6k7vO9PPnEf9p42cDStjPZ8emuC533bWXPmbllMWMlC4RwN2bKXz2jmtngMPG2SS
         ciorItkgIpTGVS0Hg+mDBQO3n+hj9a+8r4A/qP18S0e7fBUFtiwQM0i7DiMXNv5lFg
         S0XDvXegvYyrgl22lcQANdgmHYdejc6/6hpez52YehoFzCyb++pDJCK4XgWEcwvUZw
         iB80AMgC2xXog==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Nov 2023 08:55:53 +0100
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
Subject: [PATCH v2] PCI: kirin: Use devm_kasprintf()
Date:   Sat, 18 Nov 2023 08:55:48 +0100
Message-Id: <1bad6879083a7d836c8a47418a0afa22485e8f69.1700294127.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v2: Update kirin_pcie_parse_port()   [Krzysztof Wilczyński]

v1: https://lore.kernel.org/all/085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr/
---
 drivers/pci/controller/dwc/pcie-kirin.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2ee146767971..982f854bc39c 100644
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
@@ -404,7 +402,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 	struct device *dev = &pdev->dev;
 	struct device_node *parent, *child;
 	int ret, slot, i;
-	char name[32];
 
 	for_each_available_child_of_node(node, parent) {
 		for_each_available_child_of_node(parent, child) {
@@ -430,9 +427,9 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 
 			slot = PCI_SLOT(ret);
 
-			sprintf(name, "pcie_perst_%d", slot);
-			pcie->reset_names[i] = devm_kstrdup_const(dev, name,
-								GFP_KERNEL);
+			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
+							      "pcie_perst_%d",
+							      slot);
 			if (!pcie->reset_names[i]) {
 				ret = -ENOMEM;
 				goto put_node;
-- 
2.34.1

