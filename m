Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63C774247
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGXXjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40409 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfGXXjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:24 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so6750625iom.7;
        Wed, 24 Jul 2019 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/20K4zPt1+GF4yWXbg6ZLq7eeYH//zGfwHqy2zNVYY=;
        b=aOSQOn4/VbZarbVQ9TBvC/kLlR9+ig17cPc19RZAgY3ju3h9sU2E9bCLMF9aVWwhWX
         UCzDzKlfI/OLyBk29DvOA8QBmlZaBPsDSywTtd0N7XdGNezYXHh0qxRt8X5thTF+hAFs
         1k0ytUq94dd7vMi8LOFdpKiPPDUKw8U0WhMd3yERILd44+lb5vAwhd71JUbbn+8zeRoL
         vnkxsv5lLgZTQMMdliCNg/VFTX/WnmnadTsA7SGMNu/l1YoxJtOticz1d6+QM0xJz7hD
         4omTIi6ZluqqS0r+iN7mH2uV8ZezaUvyz/sri2cg4mqn8mfMxMMKoB3KF6lqXjP/PgU/
         68uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/20K4zPt1+GF4yWXbg6ZLq7eeYH//zGfwHqy2zNVYY=;
        b=ODTgvtVFfbD9y6zTyeA0fYbc7wsSFLBn69DCIL4NQi0WyiB03TMpmlmH2bWhaBfV0k
         0/6y9Rlqm162oDYXCColSJe9RGsJt4+aGxuSTM8PKt7IHsbNPxaqGu0/zXYlADip2y8F
         XwPyBKCkoB3VuwWkaGzabt/daC21caeQrflJ9lVOrPJAJ+QbFfq/Oj3gtZg5rFLr7BNm
         JGouOgzyhtOgRuAqWqJh1iq8dqjSZ6aGNTQTWKncNYa+AJlcLndXqW/tpiEf/GcQ6CP7
         PnrJ+qAjTEF+WUqQd8wcyL6Ds8aoKdnKQJN14MbpgqW+ab+X7Ld1GTWkuA6ZRS4ZkMI2
         cfvQ==
X-Gm-Message-State: APjAAAUI+Lj0UT/Ze1kgz2/wC7oHKnQpElhtCOYBDRlPwMaf4pnQE2bu
        ag02utZ2IoSigHvZfesdCzA=
X-Google-Smtp-Source: APXvYqzoL1m6fVY1SNoOjtTWL3LkMluHBuASVZZEdYjFzU72/k3CbDeS86JH/4wcaom/JIvCCwL7Qw==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr78293304iog.255.1564011563412;
        Wed, 24 Jul 2019 16:39:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:22 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 03/11] PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
Date:   Wed, 24 Jul 2019 17:38:40 -0600
Message-Id: <20190724233848.73327-4-skunberg.kelsey@gmail.com>
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

pci_get_host_bridge_device() and pci_put_host_bridge_device() are only
called within drivers/pci/pci.h. Since declarations do not need to be
visible to the rest of the kernel, move to drives/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ad1fe54ab8ee..f41dde136648 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -105,6 +105,9 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
+void pci_put_host_bridge_device(struct device *dev);
+
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
 	/* Wait 100 ms before the system can be put into a sleep state. */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e1f784de459f..cd49427e198e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -644,9 +644,6 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
-struct device *pci_get_host_bridge_device(struct pci_dev *dev);
-void pci_put_host_bridge_device(struct device *dev);
-
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.20.1

