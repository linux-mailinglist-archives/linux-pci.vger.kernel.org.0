Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5218B72
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEIOPU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfEIOPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:20 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F5A2173B;
        Thu,  9 May 2019 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411319;
        bh=kOMFfhOntyVJQRqygwwFSzAUSb53J3ApVLXaHoKlP1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/hw1FETQY3kE1/sq0bcFWIIPjdF1pv8MCNcgOKokZ0f5I8w0y+qwJZE/K5ddEwWU
         ysXeVybHTiqX7kN0IC7u9dKfD3Fyv09RGUAzxHZl3YbP1lOV4l+dnKD1KqNd9nQKCA
         aeqfuvOwfxiELF+Ow0wqmIjlvvUFU1CIKIoaH2l8=
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
Subject: [PATCH 09/10] PCI: pciehp: Remove pointless PCIE_MODULE_NAME definition
Date:   Thu,  9 May 2019 09:14:55 -0500
Message-Id: <20190509141456.223614-10-helgaas@kernel.org>
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

PCIE_MODULE_NAME is only used once and offers no benefit, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 1643e9aa261c..6ad0d86762cb 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -42,8 +42,6 @@ module_param(pciehp_poll_time, int, 0644);
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
 
-#define PCIE_MODULE_NAME "pciehp"
-
 static int set_attention_status(struct hotplug_slot *slot, u8 value);
 static int get_power_status(struct hotplug_slot *slot, u8 *value);
 static int get_latch_status(struct hotplug_slot *slot, u8 *value);
@@ -307,7 +305,7 @@ static int pciehp_runtime_resume(struct pcie_device *dev)
 #endif /* PM */
 
 static struct pcie_port_service_driver hpdriver_portdrv = {
-	.name		= PCIE_MODULE_NAME,
+	.name		= "pciehp",
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_HP,
 
-- 
2.21.0.1020.gf2820cf01a-goog

