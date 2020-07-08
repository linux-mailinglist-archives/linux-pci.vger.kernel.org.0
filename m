Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129802181F0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGHH5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 03:57:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539CC08C5DC
        for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2020 00:57:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so17849176pls.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2020 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=z1JpNUXacNk+9Bq+2t3PM3C1yUA+NmjCTEY9rEDkJ4E=;
        b=VryziUjjJkh1lj5ESnd8PZ0GG5Dl2lWoj3AIo5zVF99Lx2JBjBLMN8f/5X0e2BsUMR
         Di98azKa0E8Mq2enSgdDvXAz8waWctGsda329KmDlO+XV9MnIAGJjjN7MFHtlEZwZ6F8
         UUaTW9O6lk/R6FzHyjVDnKhnCuoBU0htBbCk/nmsOb12hWArU4bbOKaj74OZGEv33Hw9
         QNjFe5EIApax16/jWVD9aBu0yAJLDqUi0niHhDaTZ2yaj2QzijOoDlU1mylFftPUWN8A
         wsWwD48unQX0akIlG4Kh1brT1xE7ru7uHQFPbnNeM0IM2F7vqGD3qiNmjbztBtRSFFRd
         5blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=z1JpNUXacNk+9Bq+2t3PM3C1yUA+NmjCTEY9rEDkJ4E=;
        b=UaSB69xcbowITPZ8iAyS6/w7u1Zq93QxMsihnsOLzNsFRfhg6WAWCRRjaGkFYQ9vp+
         xGm99zgTgL1zw+nau90QZvhpsNwmJwpayEqeTdKuwVP/Ut6E9BlGOWxo/KfeJU1xqhLD
         vuRUUsU/O505g3FQVKJ6B9dXTafaXDvgHUsbxKmHixtFcBZ8tpZkLVUg9SW2+pZoQn5I
         9BzjJUYlgpFitW8xJtyvFcYfNQNgo/FPbFIUVRZZ5fMULE3bIweAn7x4d97AgcqW2W74
         1Lx7ojvUI7F8vhZePRuGxxZbdwvzIBNab9bl2E9qPQwJtb2+YfpghXcLJycnQF8iiUgl
         8FCg==
X-Gm-Message-State: AOAM530tugZWhJ88cDKHZPf0emG0PSJh7Re9H5QHxSnxg757lyC0FPWc
        rpXisZj538MHgjKlz3+U3IM=
X-Google-Smtp-Source: ABdhPJxC56EbenWWDB5Zw9HbYRhzOHMn+lgeVip+kQTpYlcRnt+uKFg1qZuRSU7GjtWRUHGWkPUBxw==
X-Received: by 2002:a17:902:6941:: with SMTP id k1mr5922783plt.270.1594195053044;
        Wed, 08 Jul 2020 00:57:33 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
        by smtp.gmail.com with ESMTPSA id k26sm3027634pgt.90.2020.07.08.00.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:57:32 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] PCI: Move PCI_VENDOR_ID_REDHAT definition to pci_ids.h
Date:   Wed,  8 Jul 2020 15:59:30 +0800
Message-Id: <1594195170-11119-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of duplicating the PCI_VENDOR_ID_REDHAT definition everywhere,
move it to include/linux/pci_ids.h is better.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/gpu/drm/qxl/qxl_dev.h           | 2 --
 drivers/net/ethernet/rocker/rocker_hw.h | 1 -
 include/linux/pci_ids.h                 | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_dev.h b/drivers/gpu/drm/qxl/qxl_dev.h
index a0ee416..a7bc31f 100644
--- a/drivers/gpu/drm/qxl/qxl_dev.h
+++ b/drivers/gpu/drm/qxl/qxl_dev.h
@@ -131,8 +131,6 @@ enum SpiceCursorType {
 
 #pragma pack(push, 1)
 
-#define REDHAT_PCI_VENDOR_ID 0x1b36
-
 /* 0x100-0x11f reserved for spice, 0x1ff used for unstable work */
 #define QXL_DEVICE_ID_STABLE 0x0100
 
diff --git a/drivers/net/ethernet/rocker/rocker_hw.h b/drivers/net/ethernet/rocker/rocker_hw.h
index 59f1f8b..62fd84c 100644
--- a/drivers/net/ethernet/rocker/rocker_hw.h
+++ b/drivers/net/ethernet/rocker/rocker_hw.h
@@ -25,7 +25,6 @@ enum {
 
 #define ROCKER_FP_PORTS_MAX 62
 
-#define PCI_VENDOR_ID_REDHAT		0x1b36
 #define PCI_DEVICE_ID_REDHAT_ROCKER	0x0006
 
 #define ROCKER_PCI_BAR0_SIZE		0x2000
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0ad5769..5c709a1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2585,6 +2585,8 @@
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
 
+#define PCI_VENDOR_ID_REDHAT		0x1b36
+
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
 
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
-- 
2.7.0

