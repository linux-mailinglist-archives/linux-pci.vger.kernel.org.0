Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF152E912
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347799AbiETJmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347807AbiETJmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 05:42:19 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5A7149AAF;
        Fri, 20 May 2022 02:42:15 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E74F51C0011;
        Fri, 20 May 2022 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653039734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9lFUeoVRYN54qYNWAM9UozSrrbHgfx0SB7tDXiiZJ5A=;
        b=Lx58oJLucHixvC8m5oLSHtXGC1hx0QawumGYKZZJb3mE6D99slrBU0s7z0MX0SpgacG6xg
        FRRgWSfzmBS/QD4ODxFmEYpbvcjbwuJW5ywPg+pfDeY+/H7vo+PvOvRo/96Shfc7ZPHQHb
        DLtH3uWstnEbXT7zDWEhQpUbpDLhlAjP9QqSN1/5BqzFnw1/+bPfmwq1e//JvOFLmKBpP+
        t/koUi8MBIs+OqreFqBmjiZVMhCg8xtoqKihu/pzSZ61QTScWDMTf7ev7Gze250uw6fSSB
        Z5giGkcdpCv0rk2Gp6hUpl8WXr8PbffVVm8ODFS52u4sYWS+2gFz/VooXhnUvA==
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
Subject: [PATCH v6 0/6] RZN1 USB Host support
Date:   Fri, 20 May 2022 11:41:49 +0200
Message-Id: <20220520094155.313784-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes v4:
- Remove patches related to PM enable and #pwower-domain-cells as they
  will be handle out of this series.
- Add Bob's reviewed-by on patch 1
- Add Geert's reviewed by on patch 1 and 6
- Rename clocks and make the 'resets' property optional on RZ/N1 family
- Reword some commit logs and titles
- Fix dst node location (sort by node names or unit addresses)
- Fix the USB PHY node name

Changes v5:
- Rename clocks ("usb_" prefix removed)
- Add Geert's reviewed-by on patch 2, 3, 4 and 5

Changes v6:
- Include schema optionnal part (ie 'if:') in a 'allOf:' block
- Modify commit log on commit 2/6

Herve Codina (6):
  dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
  dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
    r9a06g032
  PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
  ARM: dts: r9a06g032: Add internal PCI bridge node
  ARM: dts: r9a06g032: Add USB PHY DT support
  ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY

 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 --------
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 186 ++++++++++++++++++
 arch/arm/boot/dts/r9a06g032.dtsi              |  47 +++++
 drivers/pci/controller/pci-rcar-gen2.c        |   1 +
 4 files changed, 234 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

-- 
2.35.1

