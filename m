Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F29CCD9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHZJvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 05:51:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZJvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 05:51:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id c5so14987329wmb.5;
        Mon, 26 Aug 2019 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdmKhVsf2XwxhKkj21KNp57P6t/lfQgh9WrNnl0h77Q=;
        b=pjRaJmdDhBq6nrZeEPzuRis8Uk9Kz4zPHfrfq0xCRFIJorlN6KPMu6gpYzYcrN/Lxg
         bkk9FyFsaRb9RjNKLFPWjbUe/vvucGzLSWvkOLgh225dTGlezgAk3JjgTCYQRCMUait2
         F62atwh0b3M3sjEYNkGLu9DZHnhhKzD4GeZspT6pkR9uGwm9KdFu/KAuOu04GMIeVsI0
         WKbRby1S8wbq2kaG70eV71THRo/5dPmbAhDNSHAdEEGGeQ0RVWjhy6T8jVa1cjGmnVDC
         WadyLhobcN45osbOAitpxZpfbvzRnhhX6Ky2NUdAXqtCtH7IuFJ+f52UH4KiU8GDv0Vk
         AKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bdmKhVsf2XwxhKkj21KNp57P6t/lfQgh9WrNnl0h77Q=;
        b=VVOX2/V/QvInb156bwB2ZM3E//j5wAV9TLrrzgbz/kF5GHtnF6pPhSHzZpQr2ArF6K
         EprUSEtvIHnOuDGBuJfudXsT90TBBekVzsP0iJ4PqCyZionPZeHQ0EwXjloZolOmB805
         C7Pho/0bg+V0mZaGaiw0dim7UXVFAt5/HrgH54umDSu9hAzuHvLlwenwDyimNr4RP+hf
         1hVWLcO1dc6KRuNqUHV6CkI/ozRCnvev2nPypek0Iivkv6BZfO9OanhZP8w4AqplSBKq
         dgB6bs8kCbb3rLSnkZmXNt1brfpWGY25nPExOkA2tB1fTnwIq0tYMmmGpiTwe588oUF6
         j3wQ==
X-Gm-Message-State: APjAAAXE1ek8+0/DX8EHch1/RSe45/wh2e/zWhfB/7vl0k9IgAfySUlc
        T32ajMfqRyywqDmITSi8040=
X-Google-Smtp-Source: APXvYqyfSXYCXi59//fK6HqOrzjSVNVIFBBxyHN7H9vziw7LDfK15wJcF/6Ao7CJ8feIDd5iU66a3A==
X-Received: by 2002:a1c:f103:: with SMTP id p3mr19846034wmh.18.1566813105790;
        Mon, 26 Aug 2019 02:51:45 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id a17sm6121113wmm.47.2019.08.26.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:51:44 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Scott Murray <scott@spiteful.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PCI: hotplug: Remove surplus return from a void function
Date:   Mon, 26 Aug 2019 11:51:43 +0200
Message-Id: <20190826095143.21353-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary empty return statement at the end of a void
function in the following:

  - drivers/pci/hotplug/cpci_hotplug_core.c: cleanup_slots()
  - drivers/pci/hotplug/cpqphp_core.c: pci_print_IRQ_route()
  - drivers/pci/hotplug/cpqphp_ctrl.c: cpqhp_pushbutton_thread()
  - drivers/pci/hotplug/cpqphp_ctrl.c: interrupt_event_handler()
  - drivers/pci/hotplug/cpqphp_nvram.h: compaq_nvram_init()
  - drivers/pci/hotplug/rpadlpar_core.c: rpadlpar_io_init()
  - drivers/pci/hotplug/rpaphp_core.c: cleanup_slots()

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/hotplug/cpci_hotplug_core.c | 1 -
 drivers/pci/hotplug/cpqphp_core.c       | 1 -
 drivers/pci/hotplug/cpqphp_ctrl.c       | 4 ----
 drivers/pci/hotplug/cpqphp_nvram.h      | 5 +----
 drivers/pci/hotplug/rpadlpar_core.c     | 1 -
 drivers/pci/hotplug/rpaphp_core.c       | 1 -
 6 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 603eadf3d965..d0559d2faf50 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -563,7 +563,6 @@ cleanup_slots(void)
 	}
 cleanup_null:
 	up_write(&list_rwsem);
-	return;
 }
 
 int
diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 16bbb183695a..b8aacb41a83c 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -173,7 +173,6 @@ static void pci_print_IRQ_route(void)
 		dbg("%d %d %d %d\n", tbus, tdevice >> 3, tdevice & 0x7, tslot);
 
 	}
-	return;
 }
 
 
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index b7f4e1f099d9..68de958a9be8 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1872,8 +1872,6 @@ static void interrupt_event_handler(struct controller *ctrl)
 			}
 		}		/* End of FOR loop */
 	}
-
-	return;
 }
 
 
@@ -1943,8 +1941,6 @@ void cpqhp_pushbutton_thread(struct timer_list *t)
 
 		p_slot->state = STATIC_STATE;
 	}
-
-	return;
 }
 
 
diff --git a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
index 918ff8dbfe62..70e879b6a23f 100644
--- a/drivers/pci/hotplug/cpqphp_nvram.h
+++ b/drivers/pci/hotplug/cpqphp_nvram.h
@@ -16,10 +16,7 @@
 
 #ifndef CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
 
-static inline void compaq_nvram_init(void __iomem *rom_start)
-{
-	return;
-}
+static inline void compaq_nvram_init(void __iomem *rom_start) { }
 
 static inline int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl)
 {
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 182f9e3443ee..977946e4e613 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -473,7 +473,6 @@ int __init rpadlpar_io_init(void)
 void rpadlpar_io_exit(void)
 {
 	dlpar_sysfs_exit();
-	return;
 }
 
 module_init(rpadlpar_io_init);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index c3899ee1db99..18627bb21e9e 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -408,7 +408,6 @@ static void __exit cleanup_slots(void)
 		pci_hp_deregister(&slot->hotplug_slot);
 		dealloc_slot_struct(slot);
 	}
-	return;
 }
 
 static int __init rpaphp_init(void)
-- 
2.22.1

