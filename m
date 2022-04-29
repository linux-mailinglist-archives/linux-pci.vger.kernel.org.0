Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57129514ACD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376303AbiD2NpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiD2NpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:45:12 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6EBCABA8;
        Fri, 29 Apr 2022 06:41:53 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0ED961BF20A;
        Fri, 29 Apr 2022 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651239712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0p3vWqJ3mIo9zlAjNUTJartwZ4v7nF0TrR4PIDRNnE=;
        b=hVgFYN/TWvmR3lWlsG3JRcG6CriujOCdvBda07Hk3jOvNODRSPM9XVXncRNN1pJfowXb0n
        Vhb+qVPtZrTWrdBpQHrw8MQTbEU7Aeeyf9UIIhdJtrLUg8hx2zKNE9rUcKq6wm+3SeNQH5
        i6VlIMqI2ilyvng/MNB4NjpLR3YB6VhZoos8ct0z2lI0eu28Epcpab2Ia2xpfZjLnTH1JC
        jcHSUQ0wvsEAM4+VOiMK6/Qx2FkyOF0D/u0gRBYnMSVwQ33aVlz1Eph42rnHEaqzSVuqdO
        N2wP9HQ52tRoni8gLDQob90EGXimlgmqI2jwJOnYhljsh/8OSruICWsWrUPNPg==
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
Subject: [PATCH v4 0/6] RZN1 USB Host support
Date:   Fri, 29 Apr 2022 15:41:37 +0200
Message-Id: <20220429134143.628428-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429134143.628428-1-herve.codina@bootlin.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
- - Add Geert's reviewed-by on patch 2, 3, 4 and 5


Herve Codina (6):
  dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
  dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
    r9a06g032
  PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
  ARM: dts: r9a06g032: Add internal PCI bridge node
  ARM: dts: r9a06g032: Add USB PHY DT support
  ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY

 .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 --------
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 188 ++++++++++++++++++
 arch/arm/boot/dts/r9a06g032.dtsi              |  47 +++++
 drivers/pci/controller/pci-rcar-gen2.c        |   1 +
 4 files changed, 236 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

-- 
2.35.1

