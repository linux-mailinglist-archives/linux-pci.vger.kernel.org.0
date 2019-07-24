Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D509374237
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfGXXj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35806 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbfGXXj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:27 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so93359096ioo.2;
        Wed, 24 Jul 2019 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95RnMuH9NZpUhiSkY13+rMKWH0ZloCzPp9W168L3YRE=;
        b=es+L+os4CRFmEFLfuoxD6vOAhMY+SoXD2dkVv3t4i4waqyfEEMl+Xc67my6gFWi09K
         Y2DtfsH4CWWCdySWbvbpDJ9y+njJ6vXKaB1/c9TdXjqCv4yb95dJp98UIqLiVoAmek9H
         ORnRQBrcPOjMxyxsZOvyXGmR7Fa8JMwv/PScV2XllBFIYbHW8RLVjPEmYagXb1gs+YB2
         jp+y1InuQjpuyp22PeA8mTEhWEl+WctgKMX+SUzWU0NbgvIKYTA5i5m4V72ewqLU5Hst
         FhVt7BJzcTBA0UQcZp92b6dgDYdmOt45v4OZsDkqm17pgfR4cs2cftIsXpweICi44J8i
         0S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95RnMuH9NZpUhiSkY13+rMKWH0ZloCzPp9W168L3YRE=;
        b=S8wSBz+s/kGabGLATPyudKdJwV/cgQKpJ6VciOYUiEt5vhnFihbos5MzOVLDJxaPlA
         elMDR6SbSyejnw7s3ihONSkl8ioFm8P2vql53cuZITdJGFap8zrEU8BWuFYJt4OIWE96
         pjwbFzjhjBt6FRE23vnWleg7lSpSRMMzVB5bBMJ1a0t2O9qOEJwoQEH/E/LFSYxxZ3U4
         ky1b21wrFAQ789qUYfp+tkUX96b9W26BHtdTdnCV3ZVuYuueEbBjNO4bX1wrcS2vv4DL
         wyJCeCQ2ZPlffNyscZsEn1uOPflXB4X58Vs6BnlJK0quqCDVWVl4aznHz58DFNF2oLLn
         /vpQ==
X-Gm-Message-State: APjAAAW7uCFhLx865o0Vx8h/Jpsv86sp/qy+gTvaPXxvoaS0syhq0YnK
        TF0z73zKabQI2Z244p4aNlQ=
X-Google-Smtp-Source: APXvYqzGKtiG9iaWb2B4WyrjpjrrOecz14NRtWR2FJfxv4zmwKffdnApTxKY1Nr7UXrBZPwO/S218Q==
X-Received: by 2002:a6b:7909:: with SMTP id i9mr47728241iop.8.1564011566663;
        Wed, 24 Jul 2019 16:39:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:26 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 05/11] PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:42 -0600
Message-Id: <20190724233848.73327-6-skunberg.kelsey@gmail.com>
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

pci_hotplug_*_size declarations are only called within drivers/pci/pci/.
Since declarations do not need to be seen by the rest of the kernel, move
to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0eb0fb7ad353..9391330805e9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -211,6 +211,9 @@ extern const struct attribute_group *pcibus_groups[];
 extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
 
+extern unsigned long pci_hotplug_io_size;
+extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_bus_size;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1944e3e7eb2..9c9554906659 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2015,10 +2015,6 @@ extern unsigned long pci_cardbus_mem_size;
 extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
-extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
-extern unsigned long pci_hotplug_bus_size;
-
 /* Architecture-specific versions may override these (weak) */
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
-- 
2.20.1

