Return-Path: <linux-pci+bounces-44347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B080FD083BF
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E642930A5EB6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22F332EB8;
	Fri,  9 Jan 2026 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2UA7PTH8"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C550097C;
	Fri,  9 Jan 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951062; cv=none; b=uveYHUKFmXuJQvgP3HYk2Y4DXNN9t+5LMPSudkAwEL2kxRVl7Dvnn8AdavS9ppGM1ufe/moOGqQsgbpAp9EZKUmv0Hkg4RrXrF4dUV3iF2wlqIGqq7FRyGFbiw4/cWPmiIQvm05VV7JMDzWmM85az//d6UvP8bC3KCxDDiy1UgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951062; c=relaxed/simple;
	bh=QRJGco2adxD91Cq8EQFQHc7e4w+y5oAYBWbk5nhv3E8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvTnztlefnGDb+F7fIsxZuh3yoYimGV8E+wrjZ3t/mDuBrwrIFurpsL6av64zzUhduuRpzioc98exyEvNDqHJWZeejUzJmAdo65sXnenoyNTb34f9hcKzcKwQLOW+jJarRpMIwd7Tu3H56T2A89q1pi/SOqsLwz6Jj1jRgmUBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2UA7PTH8; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vZgTGmgg3ccrRgjkR3XVE7heGz25nMVz+pI3YuuZX38=;
	b=2UA7PTH8iKIYodY6r2buR5UQ2ZwxW+6qj5kKrY8VmMRyc5Ykt3UF5GsvQ0FEvfsHbk6n8kuDL
	TmpoOGW+3eU+Z2diG+QZImCRyvV3PAChYZ+lbSonEZk5yz+2WE1089ZwEJDUBlce3dftqizvGwg
	vx5l+WklM69xRRQul/Mz1pc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dnbys0DfjzKm5x;
	Fri,  9 Jan 2026 17:27:33 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B5684055B;
	Fri,  9 Jan 2026 17:30:50 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Jan 2026 17:30:49 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <okaya@kernel.org>, <keith.busch@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH] PCI: Fix AB-BA deadlock between aer_isr() and device_shutdown()
Date: Fri, 9 Jan 2026 17:56:03 +0800
Message-ID: <20260109095603.1088620-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

During system shutdown, a deadlock may occur between AER recovery process
and device shutdown as follows:

The device_shutdown path holds the device_lock throughout the entire
process and waits for the irq handlers to complete when release nodes:

  device_shutdown
    device_lock                      # A hold device_lock
    pci_device_shutdown
      pcie_port_device_remove
        remove_iter
          device_unregister
            device_del
              bus_remove_device
                device_release_driver
                  devres_release_all
                    release_nodes    # B wait for irq handlers

The aer_isr path will acquire device_lock in pci_bus_reset():

  aer_isr                            # B execute irq process
    aer_isr_one_error
      aer_process_err_devices
        handle_error_source
          pcie_do_recovery
          aer_root_reset
            pci_bus_error_reset
              pci_bus_reset          # A acquire device_lock

The circular dependency causes system hang. Fix it by using
pci_bus_trylock() instead of pci_bus_lock() in pci_bus_reset(). When the
lock is unavailable, return -EAGAIN, as in similar cases.

Fixes: c4eed62a2143 ("PCI/ERR: Use slot reset if available")
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/pci.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..7471bfa6f32e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5515,15 +5515,22 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
 	if (probe)
 		return 0;
 
-	pci_bus_lock(bus);
+	/*
+	 * Replace blocking lock with trylock to prevent deadlock during bus reset.
+	 * Same as above except return -EAGAIN if the bus cannot be locked.
+	 */
+	if (pci_bus_trylock(bus)) {
 
-	might_sleep();
+		might_sleep();
 
-	ret = pci_bridge_secondary_bus_reset(bus->self);
+		ret = pci_bridge_secondary_bus_reset(bus->self);
 
-	pci_bus_unlock(bus);
+		pci_bus_unlock(bus);
 
-	return ret;
+		return ret;
+	}
+
+	return -EAGAIN;
 }
 
 /**
-- 
2.43.0


