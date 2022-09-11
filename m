Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C45B4E51
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIKLXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiIKLXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 07:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6ABE1C;
        Sun, 11 Sep 2022 04:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1D460F19;
        Sun, 11 Sep 2022 11:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A256C43140;
        Sun, 11 Sep 2022 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662895313;
        bh=N7owEzP5NvZJynNI25WOpOaC2G6rhimMiBnf+C0B694=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlBYbiBxrmPCHTsiB2xysVnJRJcInnPGyfeEX9nm1//vS5/Iease/nIMxUilADOqE
         LgQNxD47K4soa0/ZdNWkC1rwNCD+zKuFWhkY5n0A+PtUMK69IiFgZ0B/bujtVVTWIL
         WzZ9GaRXYEe7kYKu+Q3Gpd6pge6TEsSZNYMVq9fetr7DkSypYl/pG+Budh9/GzOooN
         TOPEjEYKyL+YN/wf7+m69jRNXhdVI+CmirPw0HPsSNrY0piSpp2lmxtJroahvgGpHr
         Vcu3eUi58eNZpJ0FWoc5E6EfRk50oNdx9VclWb/I8VOotJQETJ8cTkj/oUDlB9od9R
         EdOEBpo41BvBQ==
Received: by pali.im (Postfix)
        id 13C16878; Sun, 11 Sep 2022 13:21:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 3/3] PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
Date:   Sun, 11 Sep 2022 13:20:24 +0200
Message-Id: <20220911112024.14304-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220911112024.14304-1-pali@kernel.org>
References: <20220911112024.14304-1-pali@kernel.org>
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

Simplify pcie-mt7621.c driver code and use new PCI_CONF1_EXT_ADDRESS()
macro for accessing PCIe config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pcie-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 33eb37a2225c..28cde116cd27 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -25,6 +25,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-conf1.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -123,8 +124,7 @@ static inline void pcie_port_write(struct mt7621_pcie_port *port,
 static inline u32 mt7621_pcie_get_cfgaddr(unsigned int bus, unsigned int slot,
 					 unsigned int func, unsigned int where)
 {
-	return (((where & 0xf00) >> 8) << 24) | (bus << 16) | (slot << 11) |
-		(func << 8) | (where & 0xfc) | 0x80000000;
+	return PCI_CONF1_EXT_ADDRESS(bus, slot, func, where);
 }
 
 static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
-- 
2.20.1

