Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0A74248
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfGXXjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46956 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXXjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:21 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so93239915iol.13;
        Wed, 24 Jul 2019 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTecumU7fqxzO8Ey86PtqlrVLlcCU3kye66cW/2pXC8=;
        b=eZTuYeJ8qQVvAKEkD62gzYhDny70HcUiYsdLFk+5OpmH5r+KGFYbMPfJ5/8tKLOHb9
         GiPxuuzAJPqrPH/XzeAz7GRHSaROpk21wTu8fHKu0aMKU4tpa66n37AA4gcG3ifx+wyG
         pMmHyApgoslzLo02xCPrzI5Lv204djJfuMGEVmTSWfzI03WEKWWHCVwzMCtCzmdHptAW
         svqPPB0MXdIokuerYX0Qy6o6+09hadOdMS8+JEoa1LQIjmxbh051vXTaqjcdHsvLwBwf
         X0gEbrTtB8Hp1rBTNfYcPOIYHq5/x+HIvNrW1gQlXbP9NENXGnwHDTMM2yPiOb88yRHo
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTecumU7fqxzO8Ey86PtqlrVLlcCU3kye66cW/2pXC8=;
        b=r19wPVpoeP5pxjvwSfKvVOO/1svqPCsw2QkTvrIsi+7fmZATVVFfEf96PHbVrVaAcp
         VqUflVljr7DTLT2OUm39Jw9wx04YVNbyBMpHP1l+bUVg0ykB20HizLdpBr6wUyuiV8f0
         5/SMi0zmpa9iUEDS3OxmvbRTCIv5m4RVgvX6sD46gpVyQv50W0c6TsjsonlxjYDMp7Va
         9Ny3bhfoZ/JB4YW4/NSKvTHJlrMnPy6iEck4Go+EANy4DWQBwA+ZwxQTzSjiQOEauyaP
         ZfRTbUMJ/QtixvSwegZ3NhZ9EPGje2W2h4uVA68gMxiyuuX8hRtF9ex90U/ne6b2x8Dm
         lAhQ==
X-Gm-Message-State: APjAAAW7K74kYb54Drvl/NVM+3BheQNAy+rD3GMAE/7cv/65UZmtRc2q
        grf7R/bgLQLtjLPnnqNRJe0=
X-Google-Smtp-Source: APXvYqzB+xtwPRKS3OdbQq9ob76sbkI2BqnmmjjA87AcI1j3FQyAS9p9NljtLYZMxdYHlvIThExx8w==
X-Received: by 2002:a6b:5103:: with SMTP id f3mr74779419iob.142.1564011560346;
        Wed, 24 Jul 2019 16:39:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:19 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 01/11] PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:38 -0600
Message-Id: <20190724233848.73327-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The #define PCI_PM_* lines are only used within drivers/pci/ and they do
not need to be seen by the rest of the kernel. Move #define PCI_* to
drivers/pci/pci.h

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 5 +++++
 include/linux/pci.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1be03a97cb92..708413632429 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,6 +39,11 @@ int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
+#define PCI_PM_D2_DELAY         200
+#define PCI_PM_D3_WAIT          10
+#define PCI_PM_D3COLD_WAIT      100
+#define PCI_PM_BUS_WAIT         50
+
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..238449460210 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -145,11 +145,6 @@ static inline const char *pci_power_name(pci_power_t state)
 	return pci_power_names[1 + (__force int) state];
 }
 
-#define PCI_PM_D2_DELAY		200
-#define PCI_PM_D3_WAIT		10
-#define PCI_PM_D3COLD_WAIT	100
-#define PCI_PM_BUS_WAIT		50
-
 /**
  * typedef pci_channel_state_t
  *
-- 
2.20.1

