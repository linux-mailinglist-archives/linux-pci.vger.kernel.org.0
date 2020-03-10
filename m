Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8467F17F905
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCJMxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 08:53:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgCJMxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 21C95AC67;
        Tue, 10 Mar 2020 12:53:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        sergei.shtylyov@cogentembedded.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v5 0/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Date:   Tue, 10 Mar 2020 13:52:38 +0100
Message-Id: <20200310125243.25805-1-nsaenzjulienne@suse.de>
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

---

Changes since v4:
 - Addressed Sergei's comments
 - Fix potential warning in patch #2

Changes since v3:
 - Addressed Greg's comments

There was no v2, my bad.

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
 drivers/usb/host/pci-quirks.c              | 16 +++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  9 ++++-
 5 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.25.1

