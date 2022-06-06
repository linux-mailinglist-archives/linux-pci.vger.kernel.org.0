Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A253E621
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiFFNB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiFFNB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 09:01:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17841B41C8;
        Mon,  6 Jun 2022 06:01:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGtr42wb5zjXRQ;
        Mon,  6 Jun 2022 21:00:04 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:01:21 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6] PCI: Make sure the bus bridge powered on when scanning bus
Date:   Mon, 6 Jun 2022 21:00:03 +0800
Message-ID: <20220606130003.54603-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A bridge in a non-D0 power state does not forward config accesses to
its secondary side (PCIe r6.0, sec 5.3.1). Make sure the bridge is
in D0 while we enumerate devices below it.

The case can be produced when the bridge is runtime-suspended (either
in D3hot or D3cold) like below:

$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
$ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan

0000:80:00.0 is a Root Port and it is runtime-suspended, so the
configuration space of 0000:81:00.1 is unreachable in rescan
and the device cannot be enumerated.

Power up the bridge when scanning the child bus and allow it to
suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
in pci_scan_child_bus_extend().

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Change since v5:
- Tweak the commit message suggested by Bjorn
Link: https://lore.kernel.org/linux-pci/20220525141930.GA290827@bhelgaas/

Change since v4:
- rephrase the commit suggested by Rafael
Link: https://lore.kernel.org/lkml/20220422080404.27724-1-yangyicong@hisilicon.com/

Change since v3:
- retain the pm_runtime_*() calls in pci_scan_bridge_extend() as Rafael points
  out that it's necessary when the brigde is in D3cold
Link: https://lore.kernel.org/linux-pci/20220414123736.34150-1-yangyicong@hisilicon.com/

Change since v2:
- just rebase it on v5.18-rc2
Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
- use an intermediate variable *bridge as suggested
- remove the pm_runtime_*() calls in pci_scan_bridge_extend()
Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/

 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..b108e72b6586 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devfn, fn, cmax, max = start;
+	struct pci_dev *bridge = bus->self;
 	struct pci_dev *dev;
 	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
+	/*
+	 * Make sure the bus bridge is powered on, otherwise we may not be
+	 * able to scan the devices as we may fail to access the configuration
+	 * space of subordinates.
+	 */
+	if (bridge)
+		pm_runtime_get_sync(&bridge->dev);
+
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 256; devfn += 8) {
 		nr_devs = pci_scan_slot(bus, devfn);
@@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		}
 	}
 
+	if (bridge)
+		pm_runtime_put(&bridge->dev);
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
-- 
2.24.0

