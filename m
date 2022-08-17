Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3B596A9A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiHQHnk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Aug 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiHQHnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 03:43:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73075CF6;
        Wed, 17 Aug 2022 00:43:36 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M70L66wVTzcfh3;
        Wed, 17 Aug 2022 15:40:30 +0800 (CST)
Received: from dggpemm100006.china.huawei.com (7.185.36.196) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:43:34 +0800
Received: from canpemm500001.china.huawei.com (7.192.104.163) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:43:34 +0800
Received: from canpemm500001.china.huawei.com ([7.192.104.163]) by
 canpemm500001.china.huawei.com ([7.192.104.163]) with mapi id 15.01.2375.024;
 Wed, 17 Aug 2022 15:43:34 +0800
From:   "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        zhuangshengen <zhuangshengen@huawei.com>
Subject: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Topic: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Index: AdiyDNZvspPz1b9KT9CKr88dkJbU8g==
Date:   Wed, 17 Aug 2022 07:43:34 +0000
Message-ID: <0a8ce5714e2d4eed909cb096d4832036@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.254]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Enable SRIOV concurrently with many different PFs in userspace seems workable.
I'm trying to do it with 8 PFs(each one with 240+ VFs), but get some warnings,
here is the backtrace:

Warning 1:
---
sysfs: cannot create duplicate filename '/devices/pci0000:30/0000:30:02.0/pci_bus/0000:32'
Call Trace:
 dump_stack+0x6f/0xab
 sysfs_warn_dup+0x56/0x70
 sysfs_create_dir_ns+0x80/0x90
 kobject_add_internal+0xa0/0x2b0
 kobject_add+0x71/0xd0
 device_add+0x126/0x630
 pci_add_new_bus+0x17c/0x4b0
 pci_iov_add_virtfn+0x336/0x390
 sriov_enable+0x26e/0x450
 virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
---
The reason is that different VFs may create the same pci bus number
and try to add new bus concurrently in virtfn_add_bus.

Warning 2:
---
proc_dir_entry 'pci/33' already registered
WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360 proc_register+0xf8/0x130
Call Trace:
 proc_mkdir_data+0x5d/0x80
 pci_proc_attach_device+0xe9/0x120
 pci_bus_add_device+0x33/0x90
 pci_iov_add_virtfn+0x375/0x390
 sriov_enable+0x26e/0x450
 virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
---
The reason is that different VFs may create '/proc/bus/pci/bus_number'
directory using the same bus number in pci_proc_attach_device concurrently.

Mutex lock can avoid potential conflict. With the patch below the warnings above
are no longer appear.

My question is that any plan to support enable PCI SRIOV concurrently in kernel side?

Thanks

---
drivers/pci/iov.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..6a8a849298c4 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -16,6 +16,12 @@
 
 #define VIRTFN_ID_LEN    16
 
+static struct mutex add_bus_mutex;
+static int add_bus_mutex_initialized;
+
+static struct mutex add_device_mutex;
+static int add_device_mutex_initialized;
+
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
     if (!dev->is_physfn)
@@ -127,13 +133,24 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
     if (bus->number == busnr)
         return bus;
 
+    if (!add_bus_mutex_initialized) {
+        mutex_init(&add_bus_mutex);
+        add_bus_mutex_initialized = 1;
+    }
+    mutex_lock(&add_bus_mutex);
+
     child = pci_find_bus(pci_domain_nr(bus), busnr);
-    if (child)
+    if (child) {
+        mutex_unlock(&add_bus_mutex);
         return child;
+    }
 
     child = pci_add_new_bus(bus, NULL, busnr);
-    if (!child)
+    if (!child) {
+        mutex_unlock(&add_bus_mutex);
         return NULL;
+    }
+    mutex_unlock(&add_bus_mutex);
 
     pci_bus_insert_busn_res(child, busnr, busnr);
 
@@ -339,8 +356,16 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
     if (rc)
         goto failed1;
 
+    if (!add_device_mutex_initialized) {
+        mutex_init(&add_device_mutex);
+        add_device_mutex_initialized = 1;
+    }
+    mutex_lock(&add_device_mutex);
+
     pci_bus_add_device(virtfn);
 
+    mutex_unlock(&add_device_mutex);
+
     return 0;
 
 failed1:
---
