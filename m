Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5743A7EAA4A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 06:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjKNFzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 00:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNFzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 00:55:08 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4043F1BC;
        Mon, 13 Nov 2023 21:55:04 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.03,301,1694703600"; 
   d="scan'208";a="186678321"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Nov 2023 14:55:02 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F1734162940;
        Tue, 14 Nov 2023 14:55:02 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
Date:   Tue, 14 Nov 2023 14:54:55 +0900
Message-Id: <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Justin Stitt <justinstitt@google.com>

When building with clang 18 I see the following warning:
|       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
|                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);

This is due to the fact that `of_device_get_match_data` returns a void*
while `enum iproc_pcie_type` has the size of an int. This leads to
truncation and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/pcie-iproc-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index acdc583d2980..83cbc95f4384 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -52,7 +52,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
-	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
+	pcie->type = (uintptr_t) of_device_get_match_data(dev);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
-- 
2.34.1

