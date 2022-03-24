Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A04E9BD3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiC1QFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiC1QFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 12:05:51 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AF131BE97;
        Mon, 28 Mar 2022 09:04:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 16B591E28C5;
        Thu, 24 Mar 2022 04:09:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 16B591E28C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648084155;
        bh=YVpd6KAsEUbbMZJf57BbrLaVjshlK01mwVdnX4r/674=;
        h=From:To:CC:Subject:Date:From;
        b=X1h7mcIUZY7pl39Vrh120xbozF9qqNx9EFw20NXmtC0ad2N90pWVXbVAHms9YvIzk
         gaXsYyJkJDXvG3bILoUEaCjGKJRW4CU4y645jQ+lE4pnj36IHENIxrQB5rwktB8uxS
         j47d9g8IwMy9i5BYUw6h1lSBd88inQrKedIL6+1o=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:09:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Date:   Thu, 24 Mar 2022 04:09:01 +0300
Message-ID: <20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is an initial one in the series created in the framework
of my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: --you are looking at it--
[2: Stalling]    PCI: dwc: Various fixes and cleanups
Link: --being submitted afterwards--
[3: Stalling]    PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: --being submitted afterwards--
[4: Stalling]    dmaengine: dw-edma: Add RP/EP local DMA controllers support
Link: --being submitted afterwards--

Since some of the patches in the later patchsets depend on modifications
introduced here @Bjorn could you please merge this series through your
PCIe subsystem repo? After getting all the required ack'es of course.

Short summary regarding this patchset. A few more modifications are
introduced here to finally finish the Baikal-T1 CCU unit support up and
prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
all it turned out I specified wrong DW xGMAC PTP reference clock divider
in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
joint xGMAC Ref and PTP clock instead of having them separately defined.
The SoC manual describes these clocks as separate fixed clock wrappers.
Finally in order to close the SoC clock/reset support up we need to add
the DDR and PCIe interfaces reset controls support. It's done in two
steps. First I've moved the reset-controls-related code into a dedicated
module. Then the DDR/PCIe reset-control functionality is added.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  clk: baikal-t1: Fix invalid xGMAC PTP clock divider
  clk: baikal-t1: Define shared xGMAC ref/ptp clocks parent
  clk: baikal-t1: Move reset-controls code into a dedicated module
  clk: baikal-t1: Add DDR/PCIe directly controlled resets support

 drivers/clk/baikal-t1/Kconfig       |  12 +-
 drivers/clk/baikal-t1/Makefile      |   1 +
 drivers/clk/baikal-t1/ccu-div.c     |   1 +
 drivers/clk/baikal-t1/ccu-div.h     |   6 +
 drivers/clk/baikal-t1/ccu-rst.c     | 373 ++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-rst.h     |  64 +++++
 drivers/clk/baikal-t1/clk-ccu-div.c | 102 ++------
 include/dt-bindings/reset/bt1-ccu.h |   9 +
 8 files changed, 482 insertions(+), 86 deletions(-)
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.h

-- 
2.35.1

