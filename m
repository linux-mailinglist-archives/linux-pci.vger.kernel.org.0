Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F149F2B76CC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 08:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgKRHRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 02:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgKRHRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 02:17:35 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2806A2462E;
        Wed, 18 Nov 2020 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605683854;
        bh=bbEAIhpk175oqHWozTzC68bHohiYOtIa3Zj5+QlIjOM=;
        h=From:To:Cc:Subject:Date:From;
        b=OGIufOFfUeppMBAapTb2svWHqDXG9xrWw32kVvKGT+dSxAxplXLA1e9Aeee+h5qu5
         JxLUbgcQbHV7wCHoqDYGkRLQNzatm35ZVK2iGWEE2oRmMd24Lswxa5Er1YSK7PRiVD
         vF+ystZfHJcIPvxhgfUUYzMf1EV5/1SC1b21Rn2c=
Received: by wens.tw (Postfix, from userid 1000)
        id 741735FD01; Wed, 18 Nov 2020 15:17:31 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: rockchip: Fix PCIe ep-gpios requirement and Add Nanopi M4B
Date:   Wed, 18 Nov 2020 15:17:20 +0800
Message-Id: <20201118071724.4866-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of my Nanopi M4B series. Changes since v1 include:

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
merging patch 1 through the PCI tree as a fix for 5.10, and the rest
for 5.11 through the Rockchip tree.

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
 drivers/pci/controller/pcie-rockchip.c        |  2 +-
 6 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts

-- 
2.29.1

