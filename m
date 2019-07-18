Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4296C7E2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 05:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbfGRDaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jul 2019 23:30:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40535 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbfGRDaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jul 2019 23:30:20 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so49180421iom.7;
        Wed, 17 Jul 2019 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpfvpjmlTMPBmUuzej87maWx1PJrD6FaaDHioeLL84E=;
        b=OMCIi5Sfb5MwOLm6XsFa5rnhtGSOOmyaxgNRy1128OrPbA4eymHsdJuH+S/cOcS6vv
         54s9MBzH6ne0+skVuUYS/xzsbGxlLB8xM3/ACVJVCi/QeH10Vr956M7OPytgWs86R+Vy
         KM5+UgUzRlDHFIM/wYpyso0znxB4OfCGSt6wa8f3+7RbDe503LU6jA5ghePKI4rJd5wA
         j6mUJh6CIzk3K1xICW1FYjurwGYcKSwyiEk/UQIFFK4iIOd0ehm5xInICWDMmummmL8x
         MXdAMdkCf5ErRUrJmuHDAM+DDh91XUDHsq4Kaw0HtrkeQq/Sg6gUtbe7+ff+vHtRZank
         pyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpfvpjmlTMPBmUuzej87maWx1PJrD6FaaDHioeLL84E=;
        b=dkss6fhqXM4Awl4+iWYMajrbsChIQCsX0qnlfTvp6aFCJf19tTwS1w8SJvXJRNMGcn
         yIvyokOlP28PW/xb/AmJnCLBfx2Fk5UsEsUxkyOWcUmi4kAG0vPsZdPb6OVyt73nA8n9
         d9AyZdJ0JJxaUKyx5b2eqYbAzUVnbI+5x5YtMBkkINelymzV4mxIusfObT5wPLeNvrmH
         rUiqgPam+SlhXrbNhWnDDDmyJ6+rQ4DC6qVl/S1aeHCX192dOVyluPZ/4NEFH5N+sM7b
         Krmirdjr9PbkHOQ1NqE1KYAIVf+fHQgPbmW3jEoxeKXqN4pOrfL7+UCJf4kNF0BVAdO/
         NXJg==
X-Gm-Message-State: APjAAAXYRPzJC+bDDPWAG4/U1P2cZaQdXtpa4dfiFVc95Evs1jjxRmw0
        wxC3yZumNn94p/UVQ1kQljU=
X-Google-Smtp-Source: APXvYqyFoyIkweSohq8qL2Dg0gZNiPzsZKXbKWGVqtnjuHBK4EMWFPa9rODy9nt6w/9uZzpxJI3oFQ==
X-Received: by 2002:a05:6638:cf:: with SMTP id w15mr46423902jao.136.1563420619701;
        Wed, 17 Jul 2019 20:30:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id 20sm30853470iog.62.2019.07.17.20.30.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 20:30:18 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH] PCI: Stop exporting pci_bus_sem
Date:   Wed, 17 Jul 2019 21:29:52 -0600
Message-Id: <20190718032951.40188-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus_sem is not used by a loadable kernel module and does not need to
be exported. Remove line exporting pci_bus_sem.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/search.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 7f4e65872b8d..bade14002fd8 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -15,7 +15,6 @@
 #include "pci.h"
 
 DECLARE_RWSEM(pci_bus_sem);
-EXPORT_SYMBOL_GPL(pci_bus_sem);
 
 /*
  * pci_for_each_dma_alias - Iterate over DMA aliases for a device
-- 
2.20.1

