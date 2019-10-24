Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A0E39BB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503329AbfJXRWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49496 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440028AbfJXRWJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id AC4C643611;
        Thu, 24 Oct 2019 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937726; x=1573752127; bh=eHqgWH9ZxunWE5MhXiwL2peaSl4Z3p2nDgb
        +A8AwzR8=; b=h1IYYAAhmzdEJ4iO1jxvHzRpyGgHnEb646OL1IDdL8fZL3Ot1qF
        mfAWo2xdMlh/t/ZLPI6h1etCPA0kshzS2xjav+PUNw/NhBRwrxyn77v+epozHAfr
        wTSte2ojerGHthP/YM6nf0bdswwWnw7FcVXhVZlL+qoSExKUilujG9ro=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWlc-liwhjX3; Thu, 24 Oct 2019 20:22:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 61031437F3;
        Thu, 24 Oct 2019 20:22:05 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:04 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 05/11] drivers: base: Add bus_disconnect_device()
Date:   Thu, 24 Oct 2019 20:21:51 +0300
Message-ID: <20191024172157.878735-6-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
References: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
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

Add bus_disconnect_device(), which is similar to bus_remove_device(), but
it doesn't detach the device from its driver, so it can be reconnected to
the same or another bus later.

This is a yet another preparation to hotplugging large PCIe bridges, which
may entail changes in BDF addresses of working devices due to movable bus
numbers. Changed addresses require rebuilding the affected entries in
/sys/bus/pci and /proc/bus/pci.

Using bus_disconnect_device()+bus_add_device() during PCI rescan allows the
drivers to work with their devices uninterruptedly, regardless of changes
in PCI addresses.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/base/bus.c     | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8f3445cc533e..52d77fb90218 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -497,6 +497,42 @@ void bus_probe_device(struct device *dev)
 	mutex_unlock(&bus->p->mutex);
 }
 
+/**
+ * bus_disconnect_device - disconnect device from bus,
+ * but don't detach it from driver
+ * @dev: device to be disconnected
+ *
+ * - Remove device from all interfaces.
+ * - Remove symlink from bus' directory.
+ * - Delete device from bus's list.
+ */
+void bus_disconnect_device(struct device *dev)
+{
+	struct bus_type *bus = dev->bus;
+	struct subsys_interface *sif;
+
+	if (!bus)
+		return;
+
+	mutex_lock(&bus->p->mutex);
+	list_for_each_entry(sif, &bus->p->interfaces, node)
+		if (sif->remove_dev)
+			sif->remove_dev(dev, sif);
+	mutex_unlock(&bus->p->mutex);
+
+	sysfs_remove_link(&dev->kobj, "subsystem");
+	sysfs_remove_link(&dev->bus->p->devices_kset->kobj,
+			  dev_name(dev));
+	device_remove_groups(dev, dev->bus->dev_groups);
+	if (klist_node_attached(&dev->p->knode_bus))
+		klist_del(&dev->p->knode_bus);
+
+	pr_debug("bus: '%s': remove device %s\n",
+		 dev->bus->name, dev_name(dev));
+	bus_put(dev->bus);
+}
+EXPORT_SYMBOL_GPL(bus_disconnect_device);
+
 /**
  * bus_remove_device - remove device from bus
  * @dev: device to be removed
diff --git a/include/linux/device.h b/include/linux/device.h
index 420228ab9c4b..9f098c32a4ad 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -268,6 +268,7 @@ void bus_sort_breadthfirst(struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b));
 extern int bus_add_device(struct device *dev);
+extern void bus_disconnect_device(struct device *dev);
 extern int device_add_class_symlinks(struct device *dev);
 extern void device_remove_class_symlinks(struct device *dev);
 
-- 
2.23.0

