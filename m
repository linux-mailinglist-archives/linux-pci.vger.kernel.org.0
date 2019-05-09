Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9218B77
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEIOPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfEIOPV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:21 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F37F2173C;
        Thu,  9 May 2019 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411320;
        bh=f79TibPQqB9YflXTE6MdGhUHy5WEZZV93b1du7QFJwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmxaHzxgHMhhfGT26Uh3Es6c8wPJj9cLSYnRW2j7ccJ0b2AEgtuZ2ZsXTM/K5HIWV
         L7eIwDu0XxZbesRP3ChPzWQmZE7GxmtWKdgpdVQj/bocZMnDYfpXSPhqTUtO+U79mG
         /YBdyF8708+oc1TfbzX+U3URRZZDdVEWQdr/f00E=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 10/10] PCI: pciehp: Remove pointless MY_NAME definition
Date:   Thu,  9 May 2019 09:14:56 -0500
Message-Id: <20190509141456.223614-11-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

MY_NAME is only used once and offers no benefit, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h     | 2 --
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index c206fd9cd3d7..8c51a04b8083 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -25,8 +25,6 @@
 
 #include "../pcie/portdrv.h"
 
-#define MY_NAME	"pciehp"
-
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9ce93b1034bd..bd990e3371e3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -48,7 +48,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 	/* Installs the interrupt handler */
 	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
-				      IRQF_SHARED, MY_NAME, ctrl);
+				      IRQF_SHARED, "pciehp", ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
 			 irq);
-- 
2.21.0.1020.gf2820cf01a-goog

