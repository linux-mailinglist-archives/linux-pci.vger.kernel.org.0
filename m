Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A464491E72
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 05:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiARESR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 23:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiARESQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 23:18:16 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A2C06173E;
        Mon, 17 Jan 2022 20:18:16 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d24so9093569qkk.5;
        Mon, 17 Jan 2022 20:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p90WUEGo/kpHlCivga9jC0a+0hAZe9bVzxQ08IV244Y=;
        b=mpPw4RRFCNUKE0sp7CYskZsGXvDB/BFWsoDmISqxdi+ddNFTmYRBPllMAGwu9Lj8r7
         7KikWKbGmJhj76V9VMN1ftHHJgWB9CTbe1fJQUbYVZrrUCuA2N8JM/X8syH+fVDbL5/M
         AOxl9CD5xvOfw4MccolXlnooyetIQhJgIWfkSn7o4Ej7WEwEoDlRRGs7m8zfPB+WRxbg
         cK8zJfbBMxZc0v/VsRFlDEpGEwzBCNbw9AmcImh73QSskVpAeetI2qxjGSOoVz+SoRZk
         8qW0FPNSjGWzvA5rfO9xkUqTrkS49fzoRe80QDDJQOUbAhsAUyh9tLkERCMO1hNQrsv3
         Ue3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p90WUEGo/kpHlCivga9jC0a+0hAZe9bVzxQ08IV244Y=;
        b=u6dY9PiAVx2wdRBOf0Ikvqio+Jlzukn7gd6kx8gDGRTbEfvjDGbIfXhMM2atKX6unW
         TgSglVl+Z6gJ0yEnW1IO4SAUPAGxJP2/k14ygXxMn1AHOhsZV29iiTz2TpOxjF2mFxTA
         svn0gMNYr6NwrCdK/xKEYRDY+NPy9x4ScRqa0Em2ILBFF2HzIHpdEvFSqjgzyRFdyJqj
         G3/ZP4JauvL836E+rP0USod64JWcKBwvfnuvFmCJyHttbZf0DXshMvUhlGsdDUD6AVYr
         Ur5gaKrFo6Z6306IbdSrGZ20Z+dYA5gg5lScckhcHmnuIfylSbha6T7ZgZFI5zHfhSHG
         htDA==
X-Gm-Message-State: AOAM530v8gTiUgsrUUgWwb78kF7O52jRLqTOnHa65uoz5vXpX8hp2y/6
        1YUWIYzUcH3j5jtYmN6BBP4=
X-Google-Smtp-Source: ABdhPJxboiDs2/xVqpQhebWlwF9r4eazIGw5GXTV+UyFbxXKTrJeKNKXXlGBU0lgXhzF7C+g34yJAg==
X-Received: by 2002:a37:8d84:: with SMTP id p126mr16366808qkd.684.1642479495372;
        Mon, 17 Jan 2022 20:18:15 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d11sm10225479qkn.96.2022.01.17.20.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 20:18:15 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH 3/3] Register auxiliary device for PCIe enclosure management
Date:   Mon, 17 Jan 2022 22:17:58 -0600
Message-Id: <a8d6c93d722271730aed9e7811591b05a8e5b0a0.1642460765.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642460765.git.stuart.w.hayes@gmail.com>
References: <cover.1642460765.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch will register an auxiliary devivce for the pcie_em driver,
allowing it to attach and provide access to PCIe enclosure management
(LEDs), if present.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ca2ee806d74b..22ff10798333 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,8 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/pcie_em.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -159,6 +161,9 @@ struct nvme_dev {
 	unsigned int nr_poll_queues;
 
 	bool attrs_added;
+
+	/* auxiliary_device for pcie_em driver (LEDs) */
+	struct auxiliary_device *pcie_em_auxdev;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2838,6 +2843,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_unfreeze(&dev->ctrl);
 	}
 
+	/*
+	 * register auxiliary device if this supports PCIe enclosure management
+	 */
+	dev->pcie_em_auxdev = register_pcie_em_auxdev(dev->dev, dev->ctrl.instance);
+
 	/*
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
@@ -3135,6 +3145,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
+	unregister_pcie_em_auxdev(dev->pcie_em_auxdev);
 	nvme_uninit_ctrl(&dev->ctrl);
 }
 
-- 
2.31.1

