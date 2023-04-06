Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0546DA42E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjDFU6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjDFU6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80869A260;
        Thu,  6 Apr 2023 13:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004A264BDB;
        Thu,  6 Apr 2023 20:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC5C433AC;
        Thu,  6 Apr 2023 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814711;
        bh=/eevk9xUiKe/1mZGgG08xIjAaIv7WJjn8F+AGiH1IgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjmHF6hwUGR/yuQH0N/dyFnQq7Rbr66z21aS+6spQezESiffNwDM6Mxq+VRMPmnny
         tFjWxZJwYroT1Lto7k9VzZZhPtDTHCuC6CX4ymH41mqTwWAsltP4Edm/hdHvDbkBst
         5SsZNTmbrY/EzXiHf8qav9t0mbU+EgFF/bZA+8XFgkQm8yy324SxZyZqcSlz3Xe6dc
         KuKlMF7TjEYjN2Nv6EtQuHynTHklrMswGaACU5rgwD3xMEYqfI51uNmYvR6upBE1a/
         x483aZntpgUzwkZ5FvPmix6/tx0BOBq66YNnfQPLWg4ZxY+Pg7BvDKd+p2ocheHp9A
         Um3km2Zxvaxaw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 2/4] PCI: dwc: make SiFive's PCI driver depend on ARCH_ symbols
Date:   Thu,  6 Apr 2023 21:57:48 +0100
Message-Id: <20230406-banshee-issue-db90fd3fafe0@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406-undertake-stowing-50f45b90413a@spud>
References: <20230406-undertake-stowing-50f45b90413a@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qmcM2Yt7tg8pV2eIGJVXVJi3kTv/CdbcEGHBnd4Yhd0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCn6Rl6bFtq8LciXemaaMsXmYB3PszarprP+0/5vOi/o2 fznj9O7jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkRzzD/+zP8q6bDX4bOPR6 z/HLOJ33vijw8Snzdee4NyswrbugJMLIMIc/3LgiKD748N4tU654OP3euKg6dnbjkfm+tU8NboR t4wUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
use of such symbols on other architectures, convert the dependency on
SOC_SIFIVE to the new symbol.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d29551261e80..7d670be44073 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -409,7 +409,7 @@ config PCIE_AL
 config PCIE_FU740
 	bool "SiFive FU740 PCIe host controller"
 	depends on PCI_MSI
-	depends on SOC_SIFIVE || COMPILE_TEST
+	depends on ARCH_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support for the SiFive
-- 
2.39.2

