Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E816B3800
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCJIFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCJIFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA86B04BC;
        Fri, 10 Mar 2023 00:05:44 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0CBA26603055;
        Fri, 10 Mar 2023 08:05:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435542;
        bh=ctw8Xau90CJVFW0RlRvP3WtEFwDOCAAhoBzXWYLTG04=;
        h=From:To:Cc:Subject:Date:From;
        b=izGcV98nHfD5trsFvC4m1eoN6ru69aCkxCgu/Ix5XerWL2xqID0++Pi6WTJgHj5UI
         5W7Hb5j4Qv07H5x5pEuJAj+yRwIgXQCzYEIocUy2kpGxl9btqReSn+GnLlXDha0WOH
         nxKO0zIoN7p0YzqPFjWY75fwf+FuUhXaeE4fG7+/b39pzdD7tx9Lds8keQpsfTz3N0
         nMRbpbUloQYxwn7PXUpD2MPphW3mUpAZTAP9kJNQTKSAVTV1Tng/CqWM3dCVke8dQz
         ooNGDMJe5m26oJZ0ao1PqtoyeDXLx54qu7+QUZ6yzPLlJxXZ/K63HhIhd3KwcwKUca
         omviOhGOZjzUQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 0/7] Add PCIe2 support for Rockchip Boards
Date:   Fri, 10 Mar 2023 08:05:11 +0000
Message-Id: <20230310080518.78054-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am assisting with PCIe and networking bring-up for Rock Pi 5B (RK3588).
This chip uses the same GICv3 as RK356X but has fixed the previous
limitation of GIC only supporting 32-bit addresses.

We sent this RFC a few weeks back:
https://lore.kernel.org/all/CAMdYzYrmq1ftBaBj1XHVWWXUQ4Prr1VpTpunyNOQ2ha-DkXMjQ@mail.gmail.com/

The big change from that RFC to this patch series is the change from
ITS quirks to a DMA Non-Coherent flag, as sugested by Robin Murphy.

This is work based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.
Plus comments of Robin Murphy about Non-Coherent properties.

Lucas Tanure (7):
  irqchip/gic-v3: Add a DMA Non-Coherent flag
  PCI: rockchip-dwc: Add rk3588 compatible line
  dt-bindings: phy: rockchip: Add rk3588 compatible line
  phy: rockchip: Add naneng combo phy support for RK3588
  arm64: dts: rockchip: Add ITS GIC600 configuration for rk3588s
  arm64: dts: rockchip: Add PCIE2.0x1 lane @fe190000 for RK3588s
  arm64: dts: rockchip: RK3588s: Enable PCIE2.0x1 @fe190000

 .../phy/phy-rockchip-naneng-combphy.yaml      |   1 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  18 ++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  97 +++++++++
 drivers/irqchip/irq-gic-v3-its.c              |  22 +++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 184 ++++++++++++++++++
 6 files changed, 323 insertions(+)

-- 
2.39.2

