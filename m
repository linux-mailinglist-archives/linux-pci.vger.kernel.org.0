Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13C6DA42B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjDFU6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjDFU63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47367683;
        Thu,  6 Apr 2023 13:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE6C64811;
        Thu,  6 Apr 2023 20:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC87C433A4;
        Thu,  6 Apr 2023 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814707;
        bh=IKUc7m06MHBX8fQN+6StDGew/WwB4gSFHqXLMoZdc6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE6EUmXBvB/oapBU6JQz1G86QwvtKJsyIQrGqZuTbbye8d/bew9rj99Axy3eaj7iB
         SzQrJC5gnG0eGKqFFYGvUw9lBGloxOhGIjRoG+PdGj9ewEMlLWnPQjDHBnjubZzlny
         6kNb9/XkK3FwgSLtf6Lm3MRiKlcr5YxTh00BdQqANtc4HSOYKZR6rxlrOOR5P93IdG
         viQVGlPFf3lzqodvII69nW/6WoWgOySNkHYpJps7JDUI7Fwh9Dax20lcCN/uF88oxb
         gVOyGDqMyjehnSKl8RueqNEuhQq/4t8UUY0Qix0MDdNGzjUAS1D4qEaJaWxKm4UG0H
         yvX9dvGxV6kpg==
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
Subject: [PATCH v1 1/4] clk: sifive: make SiFive clk drivers depend on ARCH_ symbols
Date:   Thu,  6 Apr 2023 21:57:47 +0100
Message-Id: <20230406-groovy-trustable-15853ac0a130@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406-undertake-stowing-50f45b90413a@spud>
References: <20230406-undertake-stowing-50f45b90413a@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=sO1/UT/w7gYjWlZwOHP0tQk4JgO6l6TlBFVZlWRWj+w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCn6Rl6X+g7uXuuY+r/Cd6Lg4qlBUjfuP9/Cbrv91v1vJ xZsa63x7ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBELi9iZFgSuGedsIZ+3E+B rPCSuVOVz8UluTYt+ntqsYrClc4zPEqMDH+nqlRInzv/e3HH0tPrDrFcCZrqMFE70UK6u+5h2vS C2+wA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
use of such symbols on other architectures, convert the SiFive clk
drivers to use the new symbol.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/sifive/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index b7fde0aadfcb..2322f634a910 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -2,8 +2,8 @@
 
 menuconfig CLK_SIFIVE
 	bool "SiFive SoC driver support"
-	depends on SOC_SIFIVE || COMPILE_TEST
-	default SOC_SIFIVE
+	depends on ARCH_SIFIVE || COMPILE_TEST
+	default ARCH_SIFIVE
 	help
 	  SoC drivers for SiFive Linux-capable SoCs.
 
@@ -11,7 +11,7 @@ if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
 	bool "PRCI driver for SiFive SoCs"
-	default SOC_SIFIVE
+	default ARCH_SIFIVE
 	select RESET_CONTROLLER
 	select RESET_SIMPLE
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
-- 
2.39.2

