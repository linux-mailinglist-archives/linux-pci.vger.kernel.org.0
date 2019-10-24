Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A76E39B8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440029AbfJXRWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:08 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49480 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440026AbfJXRWI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 962D843A25;
        Thu, 24 Oct 2019 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937725; x=1573752126; bh=BV8R4IRfORpUgbCeURKje8613pzvutFCWzy
        xUXSv2CY=; b=oQ8xcobw4GtdfbpWPaiLWkMbfl0U6wgzHD+h0PbDB1bYvyVrmf4
        PEq+kJi93vc9UQGr5GJ6lwZRo68DGePEe7iKTG/OHhQp2zdEo/cWoScea6OihJ2H
        VURDtJM8AQUsxFEIMYtM/0pk4sZeKyLSjQP03AkLifDeqc28IJoZ785I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id anEvidJPvd2N; Thu, 24 Oct 2019 20:22:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EC77F43597;
        Thu, 24 Oct 2019 20:22:04 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:04 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 03/11] drivers: base: Make bus_add_device() public
Date:   Thu, 24 Oct 2019 20:21:49 +0300
Message-ID: <20191024172157.878735-4-s.miroshnichenko@yadro.com>
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

Move the bus_add_device() to a public API, so it can be applied to devices
which are temporarily detached from their buses without being destroyed.

This will be used after changes in PCI topology after hotplugging a bridge:
buses may get their numbers changed, so their child devices must be
reattached and their sysfs and proc files recreated.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/base/base.h    | 1 -
 drivers/base/bus.c     | 1 +
 include/linux/device.h | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0d32544b6f91..c93d302e6345 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -110,7 +110,6 @@ extern void container_dev_init(void);
 
 struct kobject *virtual_device_parent(struct device *dev);
 
-extern int bus_add_device(struct device *dev);
 extern void bus_probe_device(struct device *dev);
 extern void bus_remove_device(struct device *dev);
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a1d1e8256324..8f3445cc533e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -471,6 +471,7 @@ int bus_add_device(struct device *dev)
 	bus_put(dev->bus);
 	return error;
 }
+EXPORT_SYMBOL_GPL(bus_add_device);
 
 /**
  * bus_probe_device - probe drivers for a new device
diff --git a/include/linux/device.h b/include/linux/device.h
index 297239a08bb7..4d8bbc8ae73d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -267,6 +267,8 @@ int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
 void bus_sort_breadthfirst(struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b));
+extern int bus_add_device(struct device *dev);
+
 /*
  * Bus notifiers: Get notified of addition/removal of devices
  * and binding/unbinding of drivers to devices.
-- 
2.23.0

