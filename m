Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E771BE43B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2Qrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 12:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2Qru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 12:47:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB954AD49;
        Wed, 29 Apr 2020 16:47:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 0/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Date:   Wed, 29 Apr 2020 18:47:30 +0200
Message-Id: <20200429164734.21506-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
co-processor, VideoCore. This series adds support for the later.

Note that there are a set of constraints we have to consider (some of
them I missed on v1):
 - We need to make sure the VideoCore firmware interface is up and
   running before running the VL805 firmware load call.

 - There is no way to discern RPi4's VL805 chip from other platforms',
   so we need the firmware load to happen *before* running
   quirk_usb_handoff_xhci(). Failure to do so results in an unwarranted
   5 second wait while the fixup code polls xHC's unexisting state.

By Florian's suggestion I've been spending some time exploring the device
link[1] API in order to see if that could save us from explicitly creating
probe dependencies between pcie-brcmstb and firmware/raspberrypi (patch #3).
Technically these dependencies could be inferred from DT. It turns out Saravana
Kannan has been looking at this already. A new boot mechanism, activated with
fw_devlink=on takes care of the device probe ordering on devices with
consumer/supplier relationships. For now this relationship is created based on
the usage of generic DT properties, but has no support for vendor-specifc DT
properties, which we'd be forced to use in order to create a relationship
between our two devices since our setup is highly non generic. There will
probably be at some point support for such properties, and we will then be able
to revisit some of this code.

All this is based on the work by Tim Gover in RPi's downstream
kernel[2].

[1] https://www.kernel.org/doc/html/v4.13/driver-api/device_link.html
[2] https://github.com/raspberrypi/linux/commit/9935b4c7e360b4494b4cb6e3ce797238a1ab78bd

---

Changes since v6:
 - Make rpi_firmware_init_vl805() more robust
 - Rewrite comments and patch descriptions to be more accessible to non RPi
   fluent people
 - Removed Florian's Reviewed-by in patch #2 as function changed
   substantially
 - Tested with/witout u-boot

Changes since v5:
 - Fix issues reported by Kbuild test robot

Changes since v4:
 - Addressed Sergei's comments
 - Fix potential warning in patch #2

Changes since v3:
 - Addressed Greg's comments

There was no v2, my bad.

Changes since v1:
 - Addressed Floarians comments

Nicolas Saenz Julienne (4):
  soc: bcm2835: Add notify xHCI reset property
  firmware: raspberrypi: Introduce vl805 init routine
  PCI: brcmstb: Wait for Raspberry Pi's firmware when present
  USB: pci-quirks: Add Raspberry Pi 4 quirk

 drivers/firmware/Kconfig                   |  3 +-
 drivers/firmware/raspberrypi.c             | 52 ++++++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 17 +++++++
 drivers/usb/host/pci-quirks.c              | 16 +++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  9 +++-
 5 files changed, 95 insertions(+), 2 deletions(-)

-- 
2.26.2

