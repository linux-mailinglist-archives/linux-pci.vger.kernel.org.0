Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912885B4E70
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIKLch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIKLcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 07:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD20357CB;
        Sun, 11 Sep 2022 04:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48B3460FE2;
        Sun, 11 Sep 2022 11:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABFFC433D6;
        Sun, 11 Sep 2022 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662895953;
        bh=Xo8ZjPAefr5xIF2eSnRkQdGzjG+G5kaePxVrEO84Flo=;
        h=From:To:Cc:Subject:Date:From;
        b=ST9WkyZ2vYypzS6Q/4dQLgFTIGxehTWmo+1yid5Hbc+UMPZEBezLSlqBMfoRZsveu
         amw67i+Q6VtauA3B/k+RZvwetNjyq/jthWVeTdRfhZ906ifwC5ceg1CTFe7tZuXsuW
         Hylk+t7aeY6C2cPftk368sxQzIRxXuy/TihL3NYmoKTRyaC7NpX0T7xyd/Eec3OFh6
         1b9KfU6GbhQ8O8KM3SL0kXvZUNfqA90cP/Js+jncE3P6qwnd4f9jcbXR2FCexTxcY2
         Pp9V4ZA0p52mnBdAFimXwxEVC8vkCh/ehlNKjOvmjjJ0296KOP6Oy7oe8B4kgSo1z3
         Ni3MR1rajQ30g==
Received: by pali.im (Postfix)
        id E7335878; Sun, 11 Sep 2022 13:32:30 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: Update comment about config space
Date:   Sun, 11 Sep 2022 13:32:16 +0200
Message-Id: <20220911113216.14892-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Like many other ARM PCIe controllers, it uses old PCI Configuration
Mechanism #1 from PCI Local Bus for accessing PCI config space.
It is not PCIe ECAM in any case.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-tegra.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8e323e93be91..5df90d183526 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -395,9 +395,11 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 }
 
 /*
- * The configuration space mapping on Tegra is somewhat similar to the ECAM
- * defined by PCIe. However it deviates a bit in how the 4 bits for extended
- * register accesses are mapped:
+ * The configuration space mapping on Tegra is somewhat similar to the Intel
+ * PCI Configuration Mechanism #1 as defined in PCI Local Bus Specification.
+ * But it is mapped directly into physical address space as opposite of the
+ * CF8/CFC indirect access, bit 31 (enable) is unset and reserved bits [27:24]
+ * are used to access extended PCIe config space registers.
  *
  *    [27:24] extended register number
  *    [23:16] bus number
-- 
2.20.1

