Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E862E1C2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiKQQ2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiKQQ1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:27:42 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6BC73B8A;
        Thu, 17 Nov 2022 08:27:35 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id CC97562631;
        Thu, 17 Nov 2022 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668702454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gJcKjc3U/1ZgUtZqBtBqjQ25Ma5XTx9jmqwsXvu8sJ8=;
        b=YF2QEJksGC+YKvEzRPajXrUawr/zW5CrAmEt+nZJ80HVWBJo0fG+WOqRxUVMUPqKt7u+CY
        E7pwGQ9EGTW9/QTyCIgZfs0icZgE2wHQDsuCE2PsJiUBEvuOZFceN/5Mj5fMm0ODsri6Ln
        EWy3oCXTXbOVI70qyZ15vfhiVtBectM=
Received: from frank-G5.. (fttx-pool-80.245.75.65.bambit.de [80.245.75.65])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 40E96100501;
        Thu, 17 Nov 2022 16:27:32 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v5 00/11] Add BananaPi R3
Date:   Thu, 17 Nov 2022 17:27:17 +0100
Message-Id: <20221117162728.20608-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ef396687-64f9-4e40-a6f7-12ef3db568a6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds some Nodes to mt7986 devicetree and the BananaPi R3

This version is rebased on Matthias' DTS64 next Branch from 2022/11/11.

i included sams series for mt7986 DTS with small changes
https://patchwork.kernel.org/project/linux-mediatek/cover/20220427124741.18245->

6.2 will support dtso extension for dt overlays:

"kbuild: Allow DTB overlays to built from .dtso named source files"
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2

There is some discussion about inclusion of dt-overlays and if it is
better to support mmc also by these:

https://patchwork.kernel.org/comment/25092116/
https://patchwork.kernel.org/comment/25085681/

i had run full dtbs-check but i end up with some strange warnings in
ethernet-node that should not come up as phy-handle and sfp/managed
properties are already defined.

phy-handle made optional
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documen>

property sfp/managed (which is included for mac subnode in yaml above):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documen>

changes:
v5:
- changed usb ranges/reg/unit-adress
- added reviewd-by's except usb-part due to changes

v4:
- dropped RFC prefix
- rebase on matthias' mtk dts-next (for 6.2) branch
- added author information to overlays
- fixed sfp binding error
- added fix for moving wed_pcie node
- readded missing compatible patches

v3:
- changed mmc pull-ups
- added patch for board binding (sent separately before)
- added pcie node in mt7986 (not yet again in r3)
- added dt overlays





Frank Wunderlich (7):
  arm64: dts: mt7986: move wed_pcie node
  dt-bindings: phy: mediatek,tphy: add support for mt7986
  dt-bindings: usb: mtk-xhci: add support for mt7986
  dt-bindings: PCI: mediatek-gen3: add SoC based clock config
  dt-bindings: PCI: mediatek-gen3: add support for mt7986
  arm64: dts: mt7986: add Bananapi R3
  arm64: dts: mt7986: add BPI-R3 nand/nor overlays

Sam Shih (4):
  arm64: dts: mt7986: add spi related device nodes
  arm64: dts: mt7986: add usb related device nodes
  arm64: dts: mt7986: add mmc related device nodes
  arm64: dts: mt7986: add pcie related device nodes

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  64 ++-
 .../bindings/phy/mediatek,tphy.yaml           |   1 +
 .../bindings/usb/mediatek,mtk-xhci.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   4 +
 .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  31 ++
 .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts |  55 +++
 .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  |  69 +++
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  25 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 458 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 166 +++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 162 ++++++-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |  63 +++
 12 files changed, 1081 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi

-- 
2.34.1

