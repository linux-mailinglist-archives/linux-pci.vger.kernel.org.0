Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B07661A6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfGKW0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37918 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfGKW0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:20 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so16156840ioa.5;
        Thu, 11 Jul 2019 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ennLunQ9TkM3x4gwpKDDEDl4f5cWuKJXyPLOxDF+qM4=;
        b=nN3PEeSVF2l2B8RlLtBVwI8FPxD8xPMi++HNTi9R3R12EClqhhVzxA9PjwqnZnFyl8
         VO79EMTbnduhRPzJAyeIoWMBiJXNnfOc1VF2fkk9puHqz42ewP5O49JM35wnfoVc+bbV
         H63dIiomvbzJUlPD9AgF37G6ZzHQRecxEXs17rp1a6EOqSFAFWUpEkF9EP4ykSxg4sHR
         D89BiNJTd+zE949Q+lSk2O2gAWvLzMYFj+qqR/PHD6n57II+GaI91zozR4WAYiW7tK3N
         3ZIC7rRdTge47nqA6MweVHCDHxm8/nfCxovbPBLoy+sTnHstyw8E+NWeEnS5yWY11KH6
         49pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ennLunQ9TkM3x4gwpKDDEDl4f5cWuKJXyPLOxDF+qM4=;
        b=tGtYU6k3TdnPSlm947cTENRDBaWFBOtZeeHjI2MsXWUS8m9KwfKUFkPgbTcqzgMls2
         Yl2eTo63L7qKI/fwI01AWwn3SwxjpA/LDoX53hejTrCXbWxU8CJBtPaY5CsRhHhtEOje
         3DZ7zBUmVMSMSTGV47+OX5nEWdHFtpTXWEo3ZIy5Oemm7wZRlJ/OTbFjS2CB4xCi3Juu
         t3HT8a173kueSDRfo/AMQCHaH1+EKgDzeupAY2rSp5UZRHIg01swOzSyC0mQiI+O6mhz
         ba6jWc2BnlgAG0aeXCPYDiFSnazh6qXs39ziF/EPhaXis/GBXeWiHvFyYjWfr41komA7
         XV1A==
X-Gm-Message-State: APjAAAWSk0xdYUyaaD9DlTa41KJVjrEguuApYvL2tC0lkSO5p0PU/pFq
        ENMjeUcRohr8nH42m36KUuMTFtFre2zFwg==
X-Google-Smtp-Source: APXvYqw//z5PUYsXOOIBkVQ8XPE7Al9+P9DuHpP3uy5ZK8whRC/nhkVkTPrBhiIzeNoHUSKXrBarVA==
X-Received: by 2002:a02:b812:: with SMTP id o18mr7819714jam.64.1562883978929;
        Thu, 11 Jul 2019 15:26:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:18 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 06/11] PCI: Move pci_bus_* declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:36 -0600
Message-Id: <20190711222341.111556-7-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus_* declarations are only called within drivers/pci/. Since
declarations do not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ee7b7383e497..9b87309f5c12 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -270,6 +270,9 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 
+struct pci_bus *pci_bus_get(struct pci_bus *bus);
+void pci_bus_put(struct pci_bus *bus);
+
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
 	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ead399b8d136..54946423d901 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1233,8 +1233,6 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
-struct pci_bus *pci_bus_get(struct pci_bus *bus);
-void pci_bus_put(struct pci_bus *bus);
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
2.20.1

