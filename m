Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A282175ED8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 16:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgCBP4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 10:56:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgCBP4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 10:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AC3EACD6;
        Mon,  2 Mar 2020 15:56:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v3 0/4] Raspberry Pi 4 VL805 firmware load support
Date:   Mon,  2 Mar 2020 16:55:24 +0100
Message-Id: <20200302155528.19505-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
VideCore. This series adds support for the later.

Note that there are a set of constraints we have to consider (some of
them I missed on v1):
 - We need to make sure the VideoCore firmware interface is up and
   running before running the VL805 firmware load call.

 - There is no way to discern RPi4's VL805 chip from other platforms',
   so we need the firmware load to happen *before* running
   quirk_usb_handoff_xhci(). Failure to do so results in an unwarranted
   5 second wait while the fixup code polls xHC's unexisting state.

As per Stefan Wahren's comments I tested the behaviour on outdated
firmware. Boards dependent on this will not boot if firmware is not
up-to-date. Older boards with outdated firmware will fail to execute the
VideoCore firmware call, but xHCI will perform reliably. I added a
warning printout in case of failure.

I'm aware that Florian Fianelli noted on the previous revision that
waiting on the VideoCore firmware interface during PCIe's probe is far
from ideal. But this was before taking into account the second
constraint mentioned above. Impact on non RPi4 boards is minimal.

---

Changes since v1:
 - Addressed Floarians comments

Nicolas Saenz Julienne (4):
  soc: bcm2835: Sync xHCI reset firmware property with downstream
  firmware: raspberrypi: Introduce vl805 init routine
  PCI: brcmstb: Wait for Raspberry Pi's firmware when present
  USB: pci-quirks: Add Raspberry Pi 4 quirk

 drivers/firmware/Kconfig                   |  1 +
 drivers/firmware/raspberrypi.c             | 38 ++++++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 15 +++++++++
 drivers/usb/host/pci-quirks.c              | 18 ++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  9 ++++-
 5 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.25.1

