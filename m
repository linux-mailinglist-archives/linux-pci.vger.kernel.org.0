Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A496DA433
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjDFU6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbjDFU6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8BAD0C;
        Thu,  6 Apr 2023 13:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F3F64BDC;
        Thu,  6 Apr 2023 20:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4DC433A4;
        Thu,  6 Apr 2023 20:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814715;
        bh=GUOoSqrJ3HEphPnioWv++YNspCVNct6juRt4rZsQ5Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwqiZWFhztmW9W3iOP/4ITXmX+Joly7WG9QWptavLAFppW9wM9gEvqsIQiqAlHwex
         Uw91P1eGGLH71clAFgPvovbgcywLj7mvYplgab6i1Zwi456AjwBqpLuljm+GwPXitq
         HzE1zAVb+x3pRTaHV3njmQQhkZJHQVPuhjWkNLkK4thfmETQ2L3hIAr+RDWLyLhAFl
         xK7UYvuVDoTkrK3v5KAUa3RY1EiemOsqowy+QS++JtNEwg5/u8nesj5t0vxiaiE7gJ
         YI0zuN/7Hylh35WHhyBHjN7rMmw4JqiO0I6ywHu8y33rn8zIQ5CRd/d/Np1txcP+ZG
         zQ/WsNEyoYnIQ==
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
Subject: [PATCH v1 3/4] soc: sifive: make SiFive's cache controller driver depend on ARCH_ symbols
Date:   Thu,  6 Apr 2023 21:57:49 +0100
Message-Id: <20230406-subdued-observer-cbb0e2f72cc7@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406-undertake-stowing-50f45b90413a@spud>
References: <20230406-undertake-stowing-50f45b90413a@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9Il+wlZDZcYvFbiMxYuYNQnDgGowSqAh6MrzvX34VSo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCn6Rl7Xa0sar/bLGTzU1X7Xa/VrrZdyuYlbkKlinvGcU t8v+9d0lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCJtQYwMx2/Zz59+bt29s1w7 +s7pGE6qNclY3aGzI2hi77trW1lLWBkZNnl8Vl5dvaZRUmSO6Dbet34f3SI/f3rwcT6DxcrCfeb lvAA=
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
use of such symbols on other architectures, convert the SiFive soc
drivers to use the new ARCH_FOO symbols.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index e86870be34c9..139884addc41 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-if SOC_SIFIVE || SOC_STARFIVE
+if ARCH_SIFIVE || ARCH_STARFIVE
 
 config SIFIVE_CCACHE
 	bool "Sifive Composable Cache controller"
-- 
2.39.2

