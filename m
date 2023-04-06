Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041B86DA437
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbjDFU7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbjDFU6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB486AC;
        Thu,  6 Apr 2023 13:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D2064BDA;
        Thu,  6 Apr 2023 20:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAEBC4339C;
        Thu,  6 Apr 2023 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814718;
        bh=hPhh8oTx1kYLc913G4HIdxuV/0cdfFWp2HgdjSh+vKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uExbzvaTeBK8FlkbTfXpl+myDNnYUfc3M+u9y5qwGUKWlFphYo/+osPoZLU/y+oMl
         muWRLkrK2GuHVwNFIul5kMhjhgkkEoHmutbFJb1n5Ga/MgeVhFG4IpbrQcfXL4li7l
         kRpeUyrWe2U1g9ehZ3RDwmSzdMy70t1MZCMXsuSufSJjtAY6VQdfSupVK06PkLLn+u
         POzOU6xTsqPl1C0fARDoPfY8MproJ8TT6C4+mT0hH+2Nppwjm3RLqtJUaKGMXIQpoD
         3LRmwrvFcLyJ5p9wdRwpfY34JaAu7c43C5E2vpJ1LU5kweXBPdCK6JRYGtZYzK3DCk
         MDUccGPJH+FmQ==
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
Subject: [PATCH v1 4/4] serial: make SiFive serial drivers depend on ARCH_ symbols
Date:   Thu,  6 Apr 2023 21:57:50 +0100
Message-Id: <20230406-carnival-aspirate-fcf69a30078c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406-undertake-stowing-50f45b90413a@spud>
References: <20230406-undertake-stowing-50f45b90413a@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/uqEAT4mwA891sbEf4x2pVtUF/+D0Dq2ST7GwztNFHQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCn6Rl5R2spbv9u90F5UuaaO5erlaZvmnu/cxvSQ9Wjqm wslG1cadpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiB6sZGW4uq/Y16WEukDZk rKlvKHrFfXKHYWP422dLndbMbSgRmM7wV3K/9/yq1/9j5l+vnZulbCLz9NVmu7Mmq9/7K7892BT MxQwA
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
use of such symbols on other architectures, convert the SiFive serial
driver Kconfig entries from the SOC_ symbols to ARCH_ instead.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I hope you like the message-id Greg ;)
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 39a0078f54f6..398e5aac2e77 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -951,7 +951,7 @@ config SERIAL_OMAP_CONSOLE
 config SERIAL_SIFIVE
 	tristate "SiFive UART support"
 	depends on OF
-	default SOC_SIFIVE || SOC_CANAAN
+	default ARCH_SIFIVE || ARCH_CANAAN
 	select SERIAL_CORE
 	help
 	  Select this option if you are building a kernel for a device that
@@ -961,7 +961,7 @@ config SERIAL_SIFIVE
 config SERIAL_SIFIVE_CONSOLE
 	bool "Console on SiFive UART"
 	depends on SERIAL_SIFIVE=y
-	default SOC_SIFIVE || SOC_CANAAN
+	default ARCH_SIFIVE || ARCH_CANAAN
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.39.2

