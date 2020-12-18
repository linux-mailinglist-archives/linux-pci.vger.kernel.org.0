Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC892DE863
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgLRRlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:41:51 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37876 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgLRRlv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:41:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 05733413C8;
        Fri, 18 Dec 2020 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313267; x=1610127668; bh=vlhDGWs84jnDn9lker3XX/X6kdDT1STUvKr
        Mzdw7AQ0=; b=U2inflNqwtIgmlPeeDSyU5RoTBZUcUjrVs540Tuc2ntT6K25n4a
        X92sRuCyjJBeO5OwqC59Bg4iBMwxIkCab36FcGRDTwXNaTnkHF6wh/8+UZsegkx4
        i6YzxyjVbzlRiZZMqTh2Q9P6kog+Z9+vaNqCntABo9zmwql7zWy2a7Ng=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t1wUiKuRBgiS; Fri, 18 Dec 2020 20:41:07 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6D9F34137C;
        Fri, 18 Dec 2020 20:41:06 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:05 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Subject: [PATCH v9 01/26] PCI: Fix race condition in pci_enable/disable_device()
Date:   Fri, 18 Dec 2020 20:39:46 +0300
Message-ID: <20201218174011.340514-2-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a yet another approach to fix an old [1-2] concurrency issue, when:
 - two or more devices are being hot-added into a bridge which was
   initially empty;
 - a bridge with two or more devices is being hot-added;
 - the BIOS/bootloader/firmware doesn't pre-enable bridges during boot;

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

Protect the pci_enable_bridge(), similarly to the previous solution from
commit 40f11adc7cd9 ("PCI: Avoid race while enabling upstream bridges"),
but adding per-device mutexes.

To prevent false positives from the lockdep, use a lock_nested() with a
"depth" of a bridge within the PCI topology.

CC: Srinath Mannam <srinath.mannam@broadcom.com>
CC: Marta Rybczynska <mrybczyn@kalray.eu>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>

[1] https://lore.kernel.org/linux-pci/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com/T/#u
    [RFC PATCH v3] pci: Concurrency issue during pci enable bridge

[2] https://lore.kernel.org/linux-pci/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu/T/#u
    [RFC PATCH] nvme: avoid race-conditions when enabling devices
---
 drivers/pci/pci.c   | 16 ++++++++++++++++
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..076b908127fe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1844,11 +1844,25 @@ int pci_reenable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_reenable_device);
 
+#ifdef CONFIG_PROVE_LOCKING
+static int pci_bridge_depth(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+
+	if (!bridge)
+		return 0;
+
+	return 1 + pci_bridge_depth(bridge);
+}
+#endif /* CONFIG_PROVE_LOCKING */
+
 static void pci_enable_bridge(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 	int retval;
 
+	mutex_lock_nested(&dev->enable_mutex, pci_bridge_depth(dev));
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
@@ -1856,6 +1870,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
+		mutex_unlock(&dev->enable_mutex);
 		return;
 	}
 
@@ -1864,6 +1879,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_err(dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+	mutex_unlock(&dev->enable_mutex);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..2f9631287719 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2240,6 +2240,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->enable_mutex);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b32126d26997..81d54889bd51 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -455,6 +455,7 @@ struct pci_dev {
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	struct mutex	enable_mutex;
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-- 
2.24.1

