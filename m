Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CD56A540
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiGGOVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiGGOVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 10:21:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FA1C136;
        Thu,  7 Jul 2022 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657203677; x=1688739677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCbTRZ++Y/Yub3ddPboAcWilvsoYNUAQmzlXvdxWcqw=;
  b=Yo4BqNE9hQr6MK/EAkb9rebAhDVMZMmIHcwIplTsHzWmbxXwm/P3ud8L
   UG4tMsRTF66+2gGEii2wQpWW8mC3XlOKUnlsd6F7ftKhho596MGNSU6uD
   Vp94rnEmup1BBIheyP3DHLB53ox40JTqfd2LnLXTCn4mh3lgzYCc5EFEk
   /eXcq2xmWZwwyFsZxmbpnzgZxLRQrzINxLqhutVFu2wKBLMg46UtFbfzW
   hhrQRAaYpMR96IKU9IrB5gC27LgHYTegNdlU9GE4Xej4JBsa6bgaEv90e
   jOWyITmnCPAUtdSISNtneTgNj1Vj2H5jCWgP8t8TJVuegim9cCKdIe++A
   A==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="163767505"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 07:21:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 07:21:08 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Jul 2022 07:21:05 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <soc@kernel.org>
CC:     <conor.dooley@microchip.com>, <Cyril.Jean@microchip.com>,
        <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>,
        <aou@eecs.berkeley.edu>, <arnd@arndb.de>, <bhelgaas@google.com>,
        <herbert@gondor.apana.org.au>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <lorenzo.pieralisi@arm.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <paul.walmsley@sifive.com>
Subject: [RESEND#2 PATCH v4] MAINTAINERS: add polarfire rng, pci and clock drivers
Date:   Thu, 7 Jul 2022 15:20:42 +0100
Message-ID: <20220707142041.4096246-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hardware random, PCI and clock drivers for the PolarFire SoC have been
upstreamed but are not covered by the MAINTAINERS entry, so add them.
Daire is the author of the clock & PCI drivers, so add him as a
maintainer in place of Lewis.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Resending with +CC soc@kernel.org
It's a v4 because the other patches were applied/dropped.

 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..01a7bfa49bdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17136,12 +17136,15 @@ N:	riscv
 K:	riscv
 
 RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
-M:	Lewis Hanly <lewis.hanly@microchip.com>
 M:	Conor Dooley <conor.dooley@microchip.com>
+M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
+F:	drivers/char/hw_random/mpfs-rng.c
+F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pci/controller/pcie-microchip-host.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.36.1

