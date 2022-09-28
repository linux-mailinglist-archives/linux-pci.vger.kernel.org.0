Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56705EDC6A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiI1MTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiI1MTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 08:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E72BE0;
        Wed, 28 Sep 2022 05:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2D39B82059;
        Wed, 28 Sep 2022 12:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5BFC433D6;
        Wed, 28 Sep 2022 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664367575;
        bh=Jtumyjp2ICK4bd1zx6iKqMwGUcwEnrzrlITtkI9G878=;
        h=From:To:Cc:Subject:Date:From;
        b=c72d9gmNSaUFWhD/p8v2ZkHevVeXX8dLQGqrm/YXkgtZI7hjg9Jwcl27ALdFyOwk2
         TFlX90wu++cFYHL4ebBhgV4amoWrU8bVnFADvpDU65O+2/kn4dEosM2SdUrMQDpT1P
         sic31pyQ8KC80fEvZRxK/04lvzLn3aba2JLox2fh1JwZ2QPER7T3qc82dDuZ6G2zcu
         reSebueM6xxFLgeaUrGArX994Y4QUgYtWfs9T1DALKM5JXFHS9u6MlpCkyOHTzi3yU
         GvuFv29GPjem5YrddqIj9td4tMtqkQxnD6W5mtz2POxaJqtUSdVyAnM2KqjwuRJlBk
         DEDZ3aip+QQPg==
Received: by pali.im (Postfix)
        id 520917DE; Wed, 28 Sep 2022 14:19:32 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Date:   Wed, 28 Sep 2022 14:19:11 +0200
Message-Id: <20220928121911.14994-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() macro
for accessing PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Please look also at this related patch:
https://patchwork.kernel.org/project/linux-pci/patch/20220911113216.14892-1-pali@kernel.org/
---
 drivers/pci/controller/pci-tegra.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 5df90d183526..c9924e75e597 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -417,13 +417,6 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  * address (access to which generates correct config transaction) falls in
  * this 4 KiB region.
  */
-static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
-					   unsigned int where)
-{
-	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
-	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
-}
-
 static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
@@ -445,7 +438,9 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 		unsigned int offset;
 		u32 base;
 
-		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
+		offset = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
+					       PCI_FUNC(devfn), where) &
+			 ~PCI_CONF1_ENABLE;
 
 		/* move 4 KiB window to offset within the FPCI region */
 		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
-- 
2.20.1

