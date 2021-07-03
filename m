Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E73BA929
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGCPPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:15:47 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34761 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGCPPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:15:46 -0400
Received: by mail-lf1-f49.google.com with SMTP id f30so23901742lfj.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7rzTOb04LbYLPb0x72Oq3slQy7w9mF5ZvWIsm7kXic=;
        b=Ma4KViC9WgE0JmPV0gGHKcn4Uksh8CzJaSrrMe0UVIKvlvhtOCqrTCpq1lWxZo2VXr
         YulJR6v7UCezpbKf7+Or/HkU438K1jtGuimkX22WB7JGTbDNwRHNR6ipKBwvsmgEUS2I
         oL00Tvcyh+48wNMfEZEIGx7OeLDBuPGFtRbshFycF90WHXG7avzw8vbQRpm+DChHOccZ
         bkvJQbBySQTwXCQ8rmuahCEjKjxbHsKK/lKMZ8B+uDW2r8fRqm3IX21cyIdB3Afz8009
         3ASxrFGka/15Ms41w0GpEguAUuwsTndniz7EfWrdODmE/hm0JGz0Qp6VY9Yd1EnFSzyq
         i2kQ==
X-Gm-Message-State: AOAM531WKNNvApLzVB1Nj32NOiXlVaVGpWrfJBhPSwAS02x1Xy/o3Kd7
        siiAz7Yso23CfuBEuSIlgK8=
X-Google-Smtp-Source: ABdhPJzdvWD5Pic4JP8Q0qc1wxxJN3vK1g1cZUZ9XK2encPzy+iMlCGvKhk8fDEzbwF9fvSEQwa8eQ==
X-Received: by 2002:a05:6512:238c:: with SMTP id c12mr3946443lfv.317.1625325191845;
        Sat, 03 Jul 2021 08:13:11 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm715980ljj.56.2021.07.03.08.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:13:11 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/5] PCI: hotplug: Fix kernel-doc formatting and add missing documentation
Date:   Sat,  3 Jul 2021 15:13:05 +0000
Message-Id: <20210703151306.1922450-4-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703151306.1922450-1-kw@linux.com>
References: <20210703151306.1922450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting and add missing documentation for the
parameters "bus" of the get_slot_mapping() function.

Add documentation for missing "t" and remove surplus "slot" parameter of
the cpqhp_pushbutton_thread() function.

Also add missing documentation for "inband_presence_disabled" member of
the struct controller, and the "slot_list" and "pci_slot" members of the
struct hotplug_slot.

Thus, resolve build time warnings related to kernel-doc:

  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'dev_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'slot' not described in 'get_slot_mapping'

  drivers/pci/hotplug/cpqphp_ctrl.c:1887: warning: Function parameter or member 't' not described in 'cpqhp_pushbutton_thread'
  drivers/pci/hotplug/cpqphp_ctrl.c:1887: warning: Excess function parameter 'slot' description in 'cpqhp_pushbutton_thread'

  drivers/pci/hotplug/pciehp.h:110: warning: Function parameter or member 'inband_presence_disabled' not described in 'controller'

  include/linux/pci_hotplug.h:64: warning: Function parameter or member 'slot_list' not described in 'hotplug_slot'
  include/linux/pci_hotplug.h:64: warning: Function parameter or member 'pci_slot' not described in 'hotplug_slot'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 7 ++++---
 drivers/pci/hotplug/cpqphp_ctrl.c | 2 +-
 drivers/pci/hotplug/pciehp.h      | 3 +++
 include/linux/pci_hotplug.h       | 2 ++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index b8aacb41a83c..f99a7927e5a8 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -296,9 +296,10 @@ static int ctrl_slot_cleanup(struct controller *ctrl)
  *
  * Won't work for more than one PCI-PCI bridge in a slot.
  *
- * @bus_num - bus number of PCI device
- * @dev_num - device number of PCI device
- * @slot - Pointer to u8 where slot number will	be returned
+ * @bus: pointer to the PCI bus structure
+ * @bus_num: bus number of PCI device
+ * @dev_num: device number of PCI device
+ * @slot: Pointer to u8 where slot number will	be returned
  *
  * Output:	SUCCESS or FAILURE
  */
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 68de958a9be8..b881cc2b01c8 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1877,7 +1877,7 @@ static void interrupt_event_handler(struct controller *ctrl)
 
 /**
  * cpqhp_pushbutton_thread - handle pushbutton events
- * @slot: target slot (struct)
+ * @t: pointer to struct timer_list which holds all timer related callbacks
  *
  * Scheduled procedure to handle blocking stuff for the pushbuttons.
  * Handles all pending events and exits.
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 4fd200d8b0a9..ab57c11aa58a 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -47,6 +47,9 @@ extern int pciehp_poll_time;
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
  * @slot_cap: cached copy of the Slot Capabilities register
+ * @inband_presence_disabled: whether In-Band Presence Detect Disable is
+ * supported by the controller and disabled per spec recommendation
+ * (PCIe r5.0, appendix I implementation note)
  * @slot_ctrl: cached copy of the Slot Control register
  * @ctrl_lock: serializes writes to the Slot Control register
  * @cmd_started: jiffies when the Slot Control register was last written;
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7153..2dac431d94ac 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -50,6 +50,8 @@ struct hotplug_slot_ops {
 /**
  * struct hotplug_slot - used to register a physical slot with the hotplug pci core
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
+ * @slot_list: internal list used to track hotplug PCI slots
+ * @pci_slot: represents a physical slot
  * @owner: The module owner of this structure
  * @mod_name: The module name (KBUILD_MODNAME) of this structure
  */
-- 
2.32.0

