Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9920397D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgFVO0P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 10:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgFVO0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77FD1C1A1;
        Mon, 22 Jun 2020 14:26:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 0/9] Raspberry Pi 4 USB firmware initialization rework
Date:   Mon, 22 Jun 2020 12:38:09 +0200
Message-Id: <20200622103817.476-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
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

Note that patch #1 depends on another series[1].

The series is based on v5.8-rc2

v3: https://www.spinics.net/lists/arm-kernel/msg813612.html
v2: https://lkml.org/lkml/2020/6/9/875
v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t

[1] https://lwn.net/ml/linux-kernel/cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech/

---

Changes since v3:
 - Rework dt patch to include root bridge as a separate node
 - Update xhci-pci patch now that the xhci dev has a dt node (it was
   getting it in the past from its bus)

Changes since v2:
 - Add reset to resume routine in xhci-pci
 - Correct of refcount in pci-quirks
 - Correct typos
 - Use include file to define firmware reset IDs

Changes since v1:
 - Rework reset controller so it's less USB centric
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
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  22 ++++
 drivers/firmware/Kconfig                      |   3 +-
 drivers/firmware/raspberrypi.c                |  61 ---------
 drivers/pci/controller/pcie-brcmstb.c         |  17 ---
 drivers/reset/Kconfig                         |  11 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-raspberrypi.c             | 122 ++++++++++++++++++
 drivers/usb/host/pci-quirks.c                 |  22 ++--
 drivers/usb/host/xhci-pci.c                   |  10 ++
 drivers/usb/host/xhci.h                       |   2 +
 .../reset/raspberrypi,firmware-reset.h        |  13 ++
 include/soc/bcm2835/raspberrypi-firmware.h    |   7 -
 13 files changed, 215 insertions(+), 97 deletions(-)
 create mode 100644 drivers/reset/reset-raspberrypi.c
 create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h

-- 
2.27.0

