Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA60164464
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 13:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgBSMjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 07:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBSMjn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Feb 2020 07:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFA58B442;
        Wed, 19 Feb 2020 12:39:41 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v2 0/4] Raspberry Pi 4 VL805 firmware load support
Date:   Wed, 19 Feb 2020 13:39:29 +0100
Message-Id: <20200219123933.2792-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
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
 - Split things into their own patches
 - Wait for mailbox interface in pcie-brcmstb
 - Move firmware load code into RPi4 platform code
 - Move firmware load to usb/pci-quirks.c
 - Fix behaviour on outdated firmware

Nicolas Saenz Julienne (4):
  soc: bcm2835: Sync xHCI reset firmware property with downstream
  firmware: raspberrypi: Introduce vl805 init routine
  PCI: brcmstb: Wait for Raspberry Pi's firmware when present
  USB: pci-quirks: Add Raspberry Pi 4 quirk

 drivers/firmware/raspberrypi.c             | 37 ++++++++++++++++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 15 +++++++++
 drivers/usb/host/pci-quirks.c              | 18 +++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  9 +++++-
 4 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.25.0

