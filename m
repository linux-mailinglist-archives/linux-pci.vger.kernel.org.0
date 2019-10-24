Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA55E39B9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440031AbfJXRWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49494 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440024AbfJXRWJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7EDFF43597;
        Thu, 24 Oct 2019 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937726; x=1573752127; bh=YZEgwGA0LS4g1HE0WrvmpMGa003gzAp9ztH
        LsAhPHi4=; b=jZpLqN0nM7PUwMn2Zmp0U0lw5IkeZarGieh+p4ECXWbmhk5qp3p
        p7Cth6F0+w3tUNrsZd7ULLYhVcfuyKLapZNHgmkk2XPd16xCrfAFVZHR/V/9OBtf
        jlPN6TlbqXeByDtRn0IGVlUIN7KJb8zzPl6kSNol8eS0DeozDIq5mL78=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZzjsWc7ciZwJ; Thu, 24 Oct 2019 20:22:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 32C2043611;
        Thu, 24 Oct 2019 20:22:05 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:04 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 04/11] drivers: base: Make device_{add|remove}_class_symlinks() public
Date:   Thu, 24 Oct 2019 20:21:50 +0300
Message-ID: <20191024172157.878735-5-s.miroshnichenko@yadro.com>
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

When updating the /sys/devices/pci* entries affected by changes in the PCI
topology, their symlinks in /sys/bus/pci/devices/* must also be rebuilt.

Moving device_add_class_symlinks() and device_remove_class_symlinks() to a
public API allows the PCI subsystem to update the sysfs without destroying
the working affected devices.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/base/core.c    | 6 ++++--
 include/linux/device.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bd9cd366d41..23e689fc8478 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1922,7 +1922,7 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 	mutex_unlock(&gdp_mutex);
 }
 
-static int device_add_class_symlinks(struct device *dev)
+int device_add_class_symlinks(struct device *dev)
 {
 	struct device_node *of_node = dev_of_node(dev);
 	int error;
@@ -1973,8 +1973,9 @@ static int device_add_class_symlinks(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "of_node");
 	return error;
 }
+EXPORT_SYMBOL_GPL(device_add_class_symlinks);
 
-static void device_remove_class_symlinks(struct device *dev)
+void device_remove_class_symlinks(struct device *dev)
 {
 	if (dev_of_node(dev))
 		sysfs_remove_link(&dev->kobj, "of_node");
@@ -1991,6 +1992,7 @@ static void device_remove_class_symlinks(struct device *dev)
 #endif
 	sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(device_remove_class_symlinks);
 
 /**
  * dev_set_name - set a device name
diff --git a/include/linux/device.h b/include/linux/device.h
index 4d8bbc8ae73d..420228ab9c4b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -268,6 +268,8 @@ void bus_sort_breadthfirst(struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b));
 extern int bus_add_device(struct device *dev);
+extern int device_add_class_symlinks(struct device *dev);
+extern void device_remove_class_symlinks(struct device *dev);
 
 /*
  * Bus notifiers: Get notified of addition/removal of devices
-- 
2.23.0

