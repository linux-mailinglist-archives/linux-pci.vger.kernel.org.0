Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74074238
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfGXXj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35812 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfGXXj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:29 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so93359209ioo.2;
        Wed, 24 Jul 2019 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgONiMj8jlx3bdrKno5goCNAEVBGMf2Gp/n6CdPztZo=;
        b=YxQIlAce74J2bpdbovxttmNULI2DSygwlE7/ZgbbLfpTGD05VMjH+rir6gcjOQ70xB
         L1wtd8YUn+wznEMcUK1AMopWK5wVgU2gTGpMUhsq6MmlFCO3Z9/vD7NCf9gyeFdk/V+s
         A7w1+Sl+dqMeEEl/VJNdLdHLHNnBfS+kw0Ta7WSgOoKoRHDTzH6sTrDaiyWc38KUocHF
         PO/FmbAXG++7xFO7jvlhZNiHQbfeMrhCDPS0bC94HpJwwNpjMgfzB9Tuijsy7sLssdno
         fB+rSxupwYAuS6fUWJK06azPedjhqwfWdSSecY9hZYzgAZEWq9FMLrgxAyi9y9HU+ksb
         +weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgONiMj8jlx3bdrKno5goCNAEVBGMf2Gp/n6CdPztZo=;
        b=fSQgZavE5yEuu9hdkl+zVT2uf/TGjRAwXrZZiaMcfaR5kf1RSBr4MLh77pKeGqPNxW
         GLIavEIn3JRYc+DBYv/OZUFiGl7WWFazQllX6jIE89Ae5b8NJ1p9eL51PJLjZypxnxYy
         NDcb264lBvA34KwWz1hnlFzYyjdUdrKM9SDQP4/qKbEgHSBpOz3voPFk5Va5kOIaYvoW
         IY6VDAklbp28sxWPZAMkhNm+CA/9TBl7j50EI4s63tjHD98zhzEY7vm802R6/HP/xpPh
         K0ty3WyCFGkTkUVdNqZgLTLAKtIXLd+OPGZxXq3MZ4h/Gr2NdIaHvRP8cGHEcnfMzjiW
         4uZw==
X-Gm-Message-State: APjAAAX+VbtH4afSeCWv1Dke5mnl2tJZI45wES0n6ze+Yy8NWoA2n0mZ
        rQjJtL2h8XcL1VLGlhpm0/KXxrWfCaGjRg==
X-Google-Smtp-Source: APXvYqwa3FsRBpR42KKC5o7E9bJTkBmQlB56yz2eJgifqsLzWIKwUvLK1dCb3cpd/yFZI6ryRtXLKg==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr12151260iol.152.1564011568446;
        Wed, 24 Jul 2019 16:39:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:27 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 06/11] PCI: Move pci_bus_* declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:43 -0600
Message-Id: <20190724233848.73327-7-skunberg.kelsey@gmail.com>
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

pci_bus_* declarations are only called within drivers/pci/. Since
declarations do not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9391330805e9..3e9dfca4b661 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -274,6 +274,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
+struct pci_bus *pci_bus_get(struct pci_bus *bus);
+void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9c9554906659..af59ecf8ccff 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1282,8 +1282,6 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
-struct pci_bus *pci_bus_get(struct pci_bus *bus);
-void pci_bus_put(struct pci_bus *bus);
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
2.20.1

