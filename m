Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C35AFBD5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIGFlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 01:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIGFlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 01:41:06 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64C7A530;
        Tue,  6 Sep 2022 22:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662529250; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X1X3qs5DaixNb8/fsOtVBYiS04o+PohJB+RUMSFKVbNoMRTJsDqT0T/wqXcMcV3yWkAwwEA8ZYHlt9M13RXZgaF8qk4Np7LlgGfYYZceb9Z3RVgUXnwi4kh2GLmjcQ9qoIu3QS7i6MUOHPXuYiv3Ojovs3k4cpBxv/ykUZ0y9/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662529250; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Rcq4Bn+toMirH9/FszU0mYhD55p/yIgYD9I0ba0nhsg=; 
        b=f7BH4egKDE1oS7aMb6eNWabMEx0Hx17GDKWL0xG3s/5Xv1eCeiCgZh67iNVXyohvL/3ZfDCUCkasjh9DRQGecgVf/Yt8m6ozqfZcJGKt4VdRWfyCb9LGTzGT/Sdwt/ewiMkFsPx4nHngX/wnaDCo/TJ8/FrcO+iQ1mtTTuJa1Eg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662529250;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=Rcq4Bn+toMirH9/FszU0mYhD55p/yIgYD9I0ba0nhsg=;
        b=cl4c8PKR8V7lq2vRuBva3+emG264Hm3+zljfpCJyYo3FamDSM5aEK/D1D/uMkmM7
        bjqSnbWc1lt5bjQR0LPmKpFDFjIYDBIZa732uXqBlG0PELDTr0bjfay7zIRLL8xz4fo
        RncBVTibiZI+bUjAOfmdjUqgtdOXYX6t/pOGuyBo=
Received: from edelgard.icenowy.me (112.94.103.212 [112.94.103.212]) by mx.zohomail.com
        with SMTPS id 1662529249034989.0127040626833; Tue, 6 Sep 2022 22:40:49 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] PCI: fu740: do not use clock name when requesting clock
Date:   Wed,  7 Sep 2022 13:40:20 +0800
Message-Id: <20220907054020.745672-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DT binding of FU740 PCIe does not enforce a clock-names property,
and there exist some device tree that has a clock name that does not
stick to the one used by Linux DT (e.g. the one shipped with current
U-Boot mainline).

Drop the name in the clock request, instead just pass NULL (because
this device should have only a single clock).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 0c90583c078b..edb218a37a4f 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -315,7 +315,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
 
 	/* Fetch clocks */
-	afp->pcie_aux = devm_clk_get(dev, "pcie_aux");
+	afp->pcie_aux = devm_clk_get(dev, NULL);
 	if (IS_ERR(afp->pcie_aux))
 		return dev_err_probe(dev, PTR_ERR(afp->pcie_aux),
 					     "pcie_aux clock source missing or invalid\n");
-- 
2.37.1

