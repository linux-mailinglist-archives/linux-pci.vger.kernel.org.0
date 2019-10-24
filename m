Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C77E3970
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408006AbfJXRMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:43 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48748 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405917AbfJXRMm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3FA2443A25;
        Thu, 24 Oct 2019 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937159; x=1573751560; bh=vnznP9M/yXFK8xAfMbW3HwbTFc8jiZDqHgo
        k8mI6Vk0=; b=lcHr7bQ7em0nBm6AkKQFc1v6rXOyiQS3wXP+2aMZrIH9m6NhLXA
        E8OUtS9XcCBv5KqtBpfZr3aeRPY9axoBt+DyURPP7iu7oO/QNzQN2RN4rGXVk7C+
        vcBLbQh20S1JUNvsJYOdJFuTe+PoIVv46/Sty4NyzR+IMRlbdrDBpQgk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tj-3jK_noj57; Thu, 24 Oct 2019 20:12:39 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3C40042F15;
        Thu, 24 Oct 2019 20:12:39 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:38 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Subject: [PATCH v6 01/30] PCI: Fix race condition in pci_enable/disable_device()
Date:   Thu, 24 Oct 2019 20:11:59 +0300
Message-ID: <20191024171228.877974-2-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a yet another approach to fix an old [1-2] concurrency issue, when:
 - two or more devices are being hot-added into a bridge which was
   initially empty;
 - a bridge with two or more devices is being hot-added;
 - during boot, if BIOS/bootloader/firmware doesn't pre-enable bridges.

The problem is that a bridge is reported as enabled before the MEM/IO bits
are actually written to the PCI_COMMAND register, so another driver thread
starts memory requests through the not-yet-enabled bridge:

 CPU0                                        CPU1

 pci_enable_device_mem()                     pci_enable_device_mem()
   pci_enable_bridge()                         pci_enable_bridge()
     pci_is_enabled()
       return false;
     atomic_inc_return(enable_cnt)
     Start actual enabling the bridge
     ...                                         pci_is_enabled()
     ...                                           return true;
     ...                                     Start memory requests <-- FAIL
     ...
     Set the PCI_COMMAND_MEMORY bit <-- Must wait for this

Protect the pci_enable/disable_device() and pci_enable_bridge(), which is
similar to the previous solution from commit 40f11adc7cd9 ("PCI: Avoid race
while enabling upstream bridges"), but adding a per-device mutexes and
preventing the dev->enable_cnt from from incrementing early.

CC: Srinath Mannam <srinath.mannam@broadcom.com>
CC: Marta Rybczynska <mrybczyn@kalray.eu>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>

[1] https://lore.kernel.org/linux-pci/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com/T/#u
    [RFC PATCH v3] pci: Concurrency issue during pci enable bridge

[2] https://lore.kernel.org/linux-pci/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu/T/#u
    [RFC PATCH] nvme: avoid race-conditions when enabling devices
---
 drivers/pci/pci.c   | 26 ++++++++++++++++++++++----
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..44d0d12c80cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1643,6 +1643,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int retval;
 
+	mutex_lock(&dev->enable_mutex);
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
@@ -1650,6 +1652,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
+		mutex_unlock(&dev->enable_mutex);
 		return;
 	}
 
@@ -1658,11 +1661,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_err(dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+	mutex_unlock(&dev->enable_mutex);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	struct pci_dev *bridge;
+	/* Enable-locking of bridges is performed within the pci_enable_bridge() */
+	bool need_lock = !dev->subordinate;
 	int err;
 	int i, bars = 0;
 
@@ -1678,8 +1684,13 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
 
-	if (atomic_inc_return(&dev->enable_cnt) > 1)
+	if (need_lock)
+		mutex_lock(&dev->enable_mutex);
+	if (pci_is_enabled(dev)) {
+		if (need_lock)
+			mutex_unlock(&dev->enable_mutex);
 		return 0;		/* already enabled */
+	}
 
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
@@ -1694,8 +1705,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 			bars |= (1 << i);
 
 	err = do_pci_enable_device(dev, bars);
-	if (err < 0)
-		atomic_dec(&dev->enable_cnt);
+	if (err >= 0)
+		atomic_inc(&dev->enable_cnt);
+	if (need_lock)
+		mutex_unlock(&dev->enable_mutex);
 	return err;
 }
 
@@ -1939,15 +1952,20 @@ void pci_disable_device(struct pci_dev *dev)
 	if (dr)
 		dr->enabled = 0;
 
+	mutex_lock(&dev->enable_mutex);
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
-	if (atomic_dec_return(&dev->enable_cnt) != 0)
+	if (atomic_dec_return(&dev->enable_cnt) != 0) {
+		mutex_unlock(&dev->enable_mutex);
 		return;
+	}
 
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
+
+	mutex_unlock(&dev->enable_mutex);
 }
 EXPORT_SYMBOL(pci_disable_device);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d5271a7a849..d4f21e413638 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2158,6 +2158,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->enable_mutex);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..525140e3a460 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -425,6 +425,7 @@ struct pci_dev {
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	struct mutex	enable_mutex;
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-- 
2.23.0

