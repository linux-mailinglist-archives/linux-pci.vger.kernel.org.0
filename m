Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124AB1F4567
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgFIRuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 13:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbgFIRuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E59EB14B;
        Tue,  9 Jun 2020 17:50:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/9] Raspberry Pi 4 USB firmware initialization rework
Date:   Tue,  9 Jun 2020 19:49:53 +0200
Message-Id: <20200609175003.19793-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
co-processor, VideoCore. This series reworks how we handle this.

The previous solution makes use of PCI quirks and exporting platform
specific functions. Albeit functional it feels pretty shoehorned. This
proposes an alternative way of handling the triggering of the xHCI chip
initialization trough means of a reset controller.

The benefits are pretty evident: less platform churn in core xHCI code,
and no explicit device dependency management in pcie-brcmstb.

Note that patch #1 depend on another series[1].

The series is based on next-20200605.

v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t

[1] https://lwn.net/ml/linux-kernel/cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech/

---

Changes since v1:
 - Rework reset controller so it's less USB centric.
 - Use correct reset controller API in xhci-pci
 - Correct typos

Nicolas Saenz Julienne (9):
  dt-bindings: reset: Add a binding for the RPi Firmware reset
    controller
  reset: Add Raspberry Pi 4 firmware reset controller
  ARM: dts: bcm2711: Add firmware usb reset node
  ARM: dts: bcm2711: Add reset controller to xHCI node
  usb: xhci-pci: Add support for reset controllers
  Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
  usb: host: pci-quirks: Bypass xHCI quirks for Raspberry Pi 4
  Revert "firmware: raspberrypi: Introduce vl805 init routine"
  Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |  21 +++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  12 ++
 drivers/firmware/Kconfig                      |   3 +-
 drivers/firmware/raspberrypi.c                |  61 ---------
 drivers/pci/controller/pcie-brcmstb.c         |  17 ---
 drivers/reset/Kconfig                         |  11 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-raspberrypi.c             | 126 ++++++++++++++++++
 drivers/usb/host/pci-quirks.c                 |  22 ++-
 drivers/usb/host/xhci-pci.c                   |   7 +
 include/soc/bcm2835/raspberrypi-firmware.h    |   7 -
 11 files changed, 188 insertions(+), 100 deletions(-)
 create mode 100644 drivers/reset/reset-raspberrypi.c

-- 
2.26.2

