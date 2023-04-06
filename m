Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C776DA427
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbjDFU60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjDFU60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E861658B;
        Thu,  6 Apr 2023 13:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB18164BDB;
        Thu,  6 Apr 2023 20:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9938C433D2;
        Thu,  6 Apr 2023 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814704;
        bh=6HOP6IWi70A568L3rv60gr7BjPLNKufwgR4g363zP1s=;
        h=From:To:Cc:Subject:Date:From;
        b=Caj1g8/uojLuOyayGUhgyz1d1woHd8qEpIX8/Q4Yo7OJ1eQYccAXbUK93fHD+v1wN
         JUJeIq/gyULKxun358lE/eBExmJoLmnjpO+7ClH+PH3O32hDpb7JCmcTImc0DeB5py
         PHFQgkQ8A4ziM26UbBn8dc5gcRzzXGpLfg2bltB54DoCPNaR/1KKt/D0F+0ihsGxUn
         prqjqhJnYL6fOJEr2n20vq/nxR7gqGGyu3QaXbXXtTWiggGke4y+2ZJSqgd7ESilED
         kPiVdGaEq46SRubHXWGquQD8NTEmY77tvZWQFFZTsHuENGuUFptbkyHtupLZtwRt+/
         8hPGdf/w99RRw==
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
Subject: [PATCH v1 0/4] Convert SiFive drivers from SOC_FOO dependencies to ARCH_FOO
Date:   Thu,  6 Apr 2023 21:57:46 +0100
Message-Id: <20230406-undertake-stowing-50f45b90413a@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CGy9TNeI5BNViJ7q9RnyTEdvbyhTHwWrkTZBWg67ltk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCn6Rp7KTiwtnbOXabn3fZn7rJld5NGXqx5tDkaGToyX5 688GnKko5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOZEMHwV+BQ7DO1leeZfU/x cvxjiQ4v3hV0tORVXMN1xY9bLtmfLmX4n392xQSJgq879c9dupRc8eb7Hb2fvx+ELGC+ffCIsqZ jGBcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
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

RISC-V's SOC_FOO symbols for micro-archs are going away, and being
replaced with the more common ARCH_FOO pattern that is used by other
archs (and by vendors with a history outside of RISC-V).
I kicked the conversion off by converting the Microchip RISC-V bits to
use their replacement symbol, so here's round two: the various SiFive
drivers.

There are no dependencies here, everything can go via subsystem trees.
We've already added the replacement symbols to RISC-V's Kconfig bits.

Cheers,
Conor.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Krzysztof Wilczyński <kw@linux.com>
CC: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Conor Dooley <conor@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>
CC: linux-clk@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
CC: linux-pci@vger.kernel.org
CC: linux-serial@vger.kernel.org

Conor Dooley (4):
  clk: sifive: make SiFive clk drivers depend on ARCH_ symbols
  PCI: dwc: make SiFive's PCI driver depend on ARCH_ symbols
  soc: sifive: make SiFive's cache controller driver depend on ARCH_
    symbols
  serial: make SiFive serial drivers depend on ARCH_ symbols

 drivers/clk/sifive/Kconfig         | 6 +++---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 drivers/soc/sifive/Kconfig         | 2 +-
 drivers/tty/serial/Kconfig         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.39.2

