Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A75578BED
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGRUkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiGRUkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 16:40:20 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FD30F65;
        Mon, 18 Jul 2022 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RXK9UJTWF5fR3jaPwVuPL6tJGtAC9RFTrPqjcz+4IsY=; b=Z2uWg61+N3hv/PXqzwJpaAZFqP
        NdF5JmKU/UlQdgh/bSf8EJ76tTdi8tndssgKoYjlUOfg7kkyGQWlhFACu6vpEfl+C3WF8gqdRKQi7
        CuNJzvswNDBEL/6nBS0aOCpMca8eCVK4P8U3kZ3cc5FedvislCtg5/eN8v47/R8D5awWMlw5TOTg9
        SDxqxd2a+/uS4InUz449xTtskCZZPH0xIE4nELUCSNnrrzVOTlU/UW83hdMczs6p2QU+mQTKcTqP/
        J2JQn6CLPTYIJm/p5llXr/CDJYGEhwcJArkgwZsN4jaVTmTZUN9zVMPuECBjt4hweWnk6r5pxoaQT
        XDtFCg1A==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:56879 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oDXMr-00G7Ey-MM; Mon, 18 Jul 2022 23:29:28 +0300
Received: by localhost (sSMTP sendmail emulation); Mon, 18 Jul 2022 23:29:23 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Mon, 18 Jul 2022 23:28:40 +0300
Message-Id: <20220718202843.6766-1-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH 0/2] PCI: mvebu: add support for orion soc
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello all!

Working in close co-operation with Pali we made an initial attempt at bringing
support for orion PCIe into mvebu PCIe driver. Currently the address of
workaround memory range is hard coded and based on compatible string only. As
Pali describes in another thread, we were not able to figure out what's the
correct way to configure a configuration space. That discussion is here:
https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/T/#u

I tested this with D-Link DNS-323 rev A1 and it's working. As usual, all
comments and feedback is welcome.

Thanks,
Mauri

Mauri Sandberg (2):
  dt-bindings: PCI: mvebu: Add orion5x compatible
  PCI: mvebu: add support for orion5x

 .../devicetree/bindings/pci/mvebu-pci.txt     |  1 +
 arch/arm/mach-orion5x/common.c                | 13 ----
 drivers/pci/controller/Kconfig                |  2 +-
 drivers/pci/controller/pci-mvebu.c            | 59 +++++++++++++++++++
 4 files changed, 61 insertions(+), 14 deletions(-)


base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
--
2.25.1
