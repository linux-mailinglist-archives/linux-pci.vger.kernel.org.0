Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8360A5E51E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCNQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 09:16:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34048 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCNQg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 09:16:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1255367plt.1;
        Wed, 03 Jul 2019 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yGVA8J1oVzuyxdhC58zOwyQMGcRamYPeie8LuWEVbJc=;
        b=nXbtKwlge67Worbf6RMT9WMh92tQ3gTM1oVX1HCnuxoJfjLD/UIFj/T5jhZlANKzzW
         TMKs96xvvo+Y37GM/A+hHtBi/y4oDprdPqDagwtb7ckNr8/Qgy3aHmjlbSF8Gn5fuyrQ
         yiw1wXvhksrp01MTMonqYLO5NnYyz12uWIxqXP/KcShHRreoAfVhpGD9L+wp8b+R8hCq
         oOruzraOagO0Fcx7xRfWyKWNquZqH1ye+5rBfDekfhOUW9PZFm8JjINh4aKRiiRe56zK
         0OAJzt6SKML1suwge9vzIUpc3Oh+LRoyKSPKvFu3GmX4YKkEbErZw/jnwMSvkvV7YokO
         zvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yGVA8J1oVzuyxdhC58zOwyQMGcRamYPeie8LuWEVbJc=;
        b=FfLa8VSmZ8aC5hTKCyGqpbEWnNH76cdJbrjSrYJbVwVqycHJiS5Gr77/5gZvTZjMRb
         ZQh/vfmHBXbt+jGb1LjbNKykeigNLhTPbqnWn5O2LcZTHers/O7SUZUk46MbANWw2IZV
         K9QV1NTYPq0l08eH9bNIozbTiUw1evimwlZqrgM0ZOeQ1tLD9sVQdElYIwkBcjF4xB+4
         P/NecQro//hCeRDODNlyJFits+XzZdFqyFqVX4mU4uGHCt+bWG4JegLk2rcbx9H3RCeG
         tfxFA9kW1ZVjv4+QRBSzGZVQVDV7+ex8drD5qbbBgibDYUgIKG2QRPGsNOq+pBuInk62
         LSYQ==
X-Gm-Message-State: APjAAAXisdF4q4O2yhwNikR5sIjG+8ytAgN10rBckJ5185vmAf2bAYV5
        J4hiGOg6MURJmCOeKu/rxio=
X-Google-Smtp-Source: APXvYqyN1054GnIJMN3bsrP8sV0gVT4Bjivsrqo/KBP9SmwELSDhRq6TDkYZyLC56yDgpQd3Tz7ORw==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr42559503plb.277.1562159795997;
        Wed, 03 Jul 2019 06:16:35 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q1sm2932966pfg.84.2019.07.03.06.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:16:35 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 17/30] pci: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:16:27 +0800
Message-Id: <20190703131627.25455-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/pci/hotplug/ibmphp_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 17124254d897..0e340e105c3b 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -1261,19 +1261,18 @@ static int __init ibmphp_init(void)
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	ibmphp_pci_bus = kmalloc(sizeof(*ibmphp_pci_bus), GFP_KERNEL);
-	if (!ibmphp_pci_bus) {
-		rc = -ENOMEM;
-		goto exit;
-	}
-
 	bus = pci_find_bus(0, 0);
 	if (!bus) {
 		err("Can't find the root pci bus, can not continue\n");
 		rc = -ENODEV;
 		goto error;
 	}
-	memcpy(ibmphp_pci_bus, bus, sizeof(*ibmphp_pci_bus));
+
+	ibmphp_pci_bus = kmemdup(bus, sizeof(*ibmphp_pci_bus), GFP_KERNEL);
+	if (!ibmphp_pci_bus) {
+		rc = -ENOMEM;
+		goto exit;
+	}
 
 	ibmphp_debug = debug;
 
-- 
2.11.0

