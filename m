Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D38A6715
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfICLK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 07:10:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34118 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICLK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:10:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so17054164wrn.1;
        Tue, 03 Sep 2019 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYxd6voxuN3AOnqV2EKoZHgTVJ5qnR7Q8JGoro2CGRk=;
        b=ADnHg/CyiakTuAS7kEPDcC5AD7fCAAG9Uo5tsUTsQLhZtmj29di5ZaoL3ZjQKdvaCo
         0RafNf1P5VaUxLFqUN+mVwRmKn8rGpNkhlawco0VZY7A8+eKu/oHWqnvdmZBumgI1dzG
         kWCKr12VVIObZo/Cbk9hK+XziaLsK6wwaQ7jggx37JsYxkd3F3U8AnZ1p5LkO1eKDO8b
         P8XpixWB/RreHmMfM/48itnzdBI2Ut8SCBP5GzJWg0rqXOEZ3+lfXDBVceyDZq8HbwNo
         ztA6+JLuGPKJQVJ743pEAd3jAnnfA8qhRB2XRDqZh64l7w0ujhaobK80Qy85QHtCj6Uv
         yFwA==
X-Gm-Message-State: APjAAAW5o0O9iiBEzbUc2N1CcjvnlBi62E8p6kbmdvnEhIedKE179DT6
        kdNJl3XHR8HHYj1ajkpxDLNZBON9
X-Google-Smtp-Source: APXvYqzxwN3aVldTzA/VxWu0ZjGxluwpmnioYH4CasgCT4Q83CXocBbes4XmFZtxxwj5pDmEHjcGYA==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr25243954wrs.189.1567509026565;
        Tue, 03 Sep 2019 04:10:26 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id w12sm4363572wrg.47.2019.09.03.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:10:25 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Simplify PCIe hotplug indicator control
Date:   Tue,  3 Sep 2019 14:10:17 +0300
Message-Id: <20190903111021.1559-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe defines two optional hotplug indicators: a Power indicator and an
Attention indicator. Both are controlled by the same register, and each
can be on, off or blinking. The current interfaces
(pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
non-uniform and require two register writes in many cases where we could
do one.

This patchset introduces the new function pciehp_set_indicators(). It
allows one to set two indicators with a single register write. All
calls to previous interfaces (pciehp_green_led_* and
pciehp_set_attention_status()) are replaced with a new one. Thus,
the amount of duplicated code for setting indicators is reduced.

Changes in v4:
  - Changed the inputs validation in pciehp_set_indicators()
  - Moved PCI_EXP_SLTCTL_ATTN_IND_NONE, PCI_EXP_SLTCTL_PWR_IND_NONE
    to drivers/pci/hotplug/pciehp.h and set to -1 for not interfering
    with reserved values in the PCIe Base spec
  - Added set_power_indicator define

Changes in v3:
  - Changed pciehp_set_indicators() to work with existing
    PCI_EXP_SLTCTL_* macros
  - Reworked the inputs validation in pciehp_set_indicators()
  - Removed pciehp_set_attention_status() and pciehp_green_led_*()
    completely

Denis Efremov (4):
  PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
  PCI: pciehp: Switch LED indicators with a single write
  PCI: pciehp: Remove pciehp_set_attention_status()
  PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()

 drivers/pci/hotplug/pciehp.h      | 12 ++++--
 drivers/pci/hotplug/pciehp_core.c |  7 ++-
 drivers/pci/hotplug/pciehp_ctrl.c | 26 +++++------
 drivers/pci/hotplug/pciehp_hpc.c  | 72 +++++++------------------------
 include/uapi/linux/pci_regs.h     |  1 +
 5 files changed, 45 insertions(+), 73 deletions(-)

-- 
2.21.0

