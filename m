Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BD7DB503
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJ3IV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJ3IV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 04:21:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E88B4
        for <linux-pci@vger.kernel.org>; Mon, 30 Oct 2023 01:21:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xNWPqRZ1MjwlwxNWPqO2Tz; Mon, 30 Oct 2023 09:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698654082;
        bh=3VXcFUM59+a6yTHwvN11t3YSHRRSpkC7ssA2S+DiK0A=;
        h=From:To:Cc:Subject:Date;
        b=ciL54POF1xrD14QUPwx63HiBkJ+cEP0l2VpgVDg3lFrzxGHyfqFCb0gB2cWTngbYn
         adEOjMR4CO+GetQgS2K7cEDJ5z6owMmJQfCiVW7UPEXE3kmCR66jnscVIhNmyXE7W1
         afgzgw4TZIYIsUbEAl2qSZAleAvmcyYcj/dbEX7nLaOcp/pmpQnby+UIoE8IAg2Rwa
         KqqVYhRcN27pRTluiVb5OLQ9yxw52kvvKtXwk+rsTJlEg0Jvyjy4z7m2tIZtv2CFbQ
         vo9CHWbhgQMT6GbDk7llatDHmUE38ivu79aqtkdjDff+648jJLi69Gvcg53Ts6IXD1
         R+H0U1u1U9LsQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 09:21:22 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: kirin: Fix an error path in kirin_pcie_probe()
Date:   Mon, 30 Oct 2023 09:21:16 +0100
Message-Id: <e2b83334ab204ee905fe36ac01cfc297a5a2a7be.1698654061.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If an error occurs after a successful kirin_pcie_power_on(),
kirin_pcie_power_off() should be called, as already done in the remove
function.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure of the Fixes tag.
---
 drivers/pci/controller/dwc/pcie-kirin.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2ee146767971..0b93de9d2d06 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -813,7 +813,15 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return dw_pcie_host_init(&pci->pp);
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret)
+		goto err_power_off;
+
+	return 0;
+
+err_power_off:
+	kirin_pcie_power_off(kirin_pcie);
+	return ret;
 }
 
 static struct platform_driver kirin_pcie_driver = {
-- 
2.34.1

