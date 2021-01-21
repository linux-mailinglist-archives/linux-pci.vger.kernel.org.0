Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6042FF03C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbhAUQYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbhAUQYM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:24:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28A46206D8;
        Thu, 21 Jan 2021 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611246211;
        bh=uROovJ44LLe0pdBZ9ITux1uflMtGS1qHKsqt1LSzBXA=;
        h=From:To:Cc:Subject:Date:From;
        b=afQhVqID28+G/Hp/5oipH1QBbcyCG1tF2aPrHexosB7ouHUAaYc2PkmgdjKTDCByf
         uWqBCp5gKkwcUriaebIz+rfKzXQ9dxpOjdGbWSqj59rnMDZsu/9AyUSZDz9VIGHfVh
         S8yW4UK2zvKwzCktGIWPtPIA2n4JCa8qLxX8LH5G5NWNmAty0JmcnLILdIL2FuIuCc
         uZXwqVJSFAJrOUKhC024irFtXGIogD7R67yKhO+wuWHYN3hYzclqVVEoajPyYriexU
         c1yZA3s4mQUcDy3yCrQRIZJNj6oBCo8K77rXGvEvOiXGf8mXeCzifbikUSkwOcr8MJ
         1JCHmpS+YKIqg==
Received: by wens.tw (Postfix, from userid 1000)
        id 6B2DA5FB93; Fri, 22 Jan 2021 00:23:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] arm64: rockchip: Fix PCIe ep-gpios requirement and Add Nanopi M4B
Date:   Fri, 22 Jan 2021 00:23:17 +0800
Message-Id: <20210121162321.4538-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v4 of my Nanopi M4B series.

Changes since v3 include:

  - Directly return dev_err_probe() instead of having a separate return
    statement

Changes since v2 include:

  - Replaced dev_err() with dev_err_probe() for gpiod_get_optional() error
  - Added Reviewed-by tag from Robin Murphy for patch 3

Changes since v1 include:

  - Rewrite subject of patch 1 to match existing convention and reference
    'ep-gpios' DT property instead of the 'ep_gpio' field
 
This series mainly adds support for the new Nanopi M4B, which is a newer
variant of the Nanopi M4.

The differences against the original Nanopi M4 that are common with the
other M4V2 revision include:

  - microphone header removed
  - power button added
  - recovery button added

Additional changes specific to the M4B:

  - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
    USB 2.0 ports
  - ADB toggle switch added; this changes the top USB 3.0 host port to
    a peripheral port
  - Type-C port no longer supports data or PD
  - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
    but only 1T1R (down from 2T2R) for WiFi

While working on this, I found that for the M4 family, the PCIe reset
pin (from the M.2 expansion board) was not wired to the SoC. Only the
NanoPC T4 has this wired. This ended up in patches 1 and 3.

Patch 1 makes ep_gpio in the Rockchip PCIe driver optional. This property
is optional in the DT binding, so this just makes the driver adhere to
the binding.

Patch 2 adds a new compatible string for the new board.

Patch 3 moves the ep-gpios property of the pcie controller from the
common nanopi4.dtsi file to the nanopc-t4.dts file.

Patch 4 adds a new device tree file for the new board. It includes the
original device tree for the M4, and then lists the differences.

Given that patch 3 would make PCIe unusable without patch 1, I suggest
merging patch 1 through the PCI tree as a fix for 5.11, and the rest
for 5.12 through the Rockchip tree.

Please have a look. The changes are mostly trivial.


Regards
ChenYu

Chen-Yu Tsai (4):
  PCI: rockchip: Make 'ep-gpios' DT property optional
  dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
  arm64: dts: rockchip: nanopi4: Move ep-gpios property to nanopc-t4
  arm64: dts: rockchip: rk3399: Add NanoPi M4B

 .../devicetree/bindings/arm/rockchip.yaml     |  1 +
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  1 +
 .../boot/dts/rockchip/rk3399-nanopi-m4b.dts   | 52 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  1 -
 drivers/pci/controller/pcie-rockchip.c        |  9 ++--
 6 files changed, 59 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts

-- 
2.29.2

