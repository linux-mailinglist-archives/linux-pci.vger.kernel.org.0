Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54850B6DF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447312AbiDVML4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447303AbiDVMLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:11:55 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94F56439;
        Fri, 22 Apr 2022 05:09:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id EEDEE24000B;
        Fri, 22 Apr 2022 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pmL6z+0b94SN7KtUORnpGXczTLqkiQjmgEiGXpj9g8g=;
        b=knEreIWuP1Cz+14fMaLukrcRIyaxiCWzce/e+wImyHspCtNkYkiHxNRU27kQPxMSIGbeqx
        MXSb6Zfu38otkoMW1qYCDDk+vCK84RcyDHbs5NNpxt4Ly1/yUrmtyo+6qsn4hDYHs62j5y
        IpV8/b/QGfXyp9bCXA1JUvdcFImIiezMZpK8MthKEvKm93aWalg9IGBNJkQxpQ5yaf8cT8
        HARCz3Fqy7PrI/wUIxqdtlfiqGxjkVAJC9/y/cQFdBu4/91Mu86qPx8kiaFQYN4Z357gUB
        ZjxKI+4RZt4RpFDfsE5cJuD5MPjw4sOgqZz/VcBRKs5R3NztM55t8M14/AzUFQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 0/8] RZN1 USB Host support
Date:   Fri, 22 Apr 2022 14:08:42 +0200
Message-Id: <20220422120850.769480-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series add support for the USB Host controllers available on
RZN1 (r9a06g032) SOC.

These USB Host controllers are PCI OHCI/EHCI controllers located
behind a bridge.

Regards,
Herve

Changes v2:
- Convert bindings to json-schema
- Update clocks description
- Remove unneeded '.compatible = "renesas,pci-r9a06g032"'

Changes v3:
- Remove the unneeded patch that calls clk_bulk_prepare_enable()
- Rework the device tree binding (conversion from .txt and RZ/N1 support)
- Use the RZ/N1 SOCs family only in the driver match compatible string.
- Enable PM and PM_GENERIC_DOMAIN for RZ/N1 and add the missing
  '#power-domain-cells' in sysctrl node.

Herve Codina (8):
  dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
  dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
    r9a06g032
  PCI: rcar-gen2: Add RZ/N1 SOCs support
  soc: renesas: rzn1: Select PM and PM_GENERIC_DOMAINS configs
  ARM: dts: r9a06g032: Add missing '#power-domain-cells'
  ARM: dts: r9a06g032: Add internal PCI bridge node
  ARM: dts: r9a06g032: Add USB PHY DT support
  ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY

 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 --------
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 187 ++++++++++++++++++
 arch/arm/boot/dts/r9a06g032.dtsi              |  48 +++++
 drivers/pci/controller/pci-rcar-gen2.c        |   1 +
 drivers/soc/renesas/Kconfig                   |   2 +
 5 files changed, 238 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

-- 
2.35.1

