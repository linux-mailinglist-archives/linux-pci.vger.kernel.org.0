Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1B249D27
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHSMCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:49555 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgHSMAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 08:00:30 -0400
IronPort-SDR: mE2Gm7E84XMjmpaqyfWYSPi1cbSQJPA1ML+Wc4uY4LRDJHdFSlCynpWm71NcBiNRDWyyPBe8/X
 KgsFMhl68iKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922679"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:17 -0700
IronPort-SDR: lshPPTxGcuG/kQKHKMECxhlFh8ZAVwSYXqu6z99uVxRlcrVSwBAqXEwmbI+drxC0FL/cU8UkPb
 ls9M3s1iFjiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310790"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1228F8B7; Wed, 19 Aug 2020 14:59:07 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 19/19] thunderbolt: Add runtime PM for Software CM
Date:   Wed, 19 Aug 2020 14:59:05 +0300
Message-Id: <20200819115905.59834-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds runtime PM support for the Software Connection Manager parts
of the driver. This allows to save power when either there is no device
attached at all or there is a device attached and all following
conditions are true:

  - Tunneled PCIe root/downstream ports are runtime suspended
  - Tunneled USB3 ports are runtime suspended
  - No active DisplayPort stream
  - No active XDomain connection

For the first two we take advantage of device links that were added in
previous patch. Difference for the system sleep case is that we also
enable wakes when something is geting plugged in/out of the Thunderbolt
ports.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c |  25 ++++++--
 drivers/thunderbolt/tb.c     | 116 ++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tb.h     |   2 +-
 3 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a2ebf51ac389..db63b5eb9467 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2679,23 +2679,40 @@ int tb_switch_resume(struct tb_switch *sw)
 	return 0;
 }
 
-void tb_switch_suspend(struct tb_switch *sw)
+/**
+ * tb_switch_suspend() - Put a switch to sleep
+ * @sw: Switch to suspend
+ * @runtime: Is this runtime suspend or system sleep
+ *
+ * Suspends router and all its children. Enables wakes according to
+ * value of @runtime and then sets sleep bit for the router. If @sw is
+ * host router the domain is ready to go to sleep once this function
+ * returns.
+ */
+void tb_switch_suspend(struct tb_switch *sw, bool runtime)
 {
 	unsigned int flags = 0;
 	struct tb_port *port;
 	int err;
 
+	tb_sw_dbg(sw, "suspending switch\n");
+
 	err = tb_plug_events_active(sw, false);
 	if (err)
 		return;
 
 	tb_switch_for_each_port(sw, port) {
 		if (tb_port_has_remote(port))
-			tb_switch_suspend(port->remote->sw);
+			tb_switch_suspend(port->remote->sw, runtime);
 	}
 
-	if (device_may_wakeup(&sw->dev))
-		flags = TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
+	if (runtime) {
+		/* Trigger wake when something is plugged in/out */
+		flags |= TB_WAKE_ON_CONNECT | TB_WAKE_ON_DISCONNECT;
+		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
+	} else if (device_may_wakeup(&sw->dev)) {
+		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
+	}
 
 	tb_switch_set_wake(sw, flags);
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 214e47656be6..170d1d846557 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -22,13 +23,21 @@
  *		    events and exit if this is not set (it needs to
  *		    acquire the lock one more time). Used to drain wq
  *		    after cfg has been paused.
+ * @remove_work: Work used to remove any unplugged routers after
+ *		 runtime resume
  */
 struct tb_cm {
 	struct list_head tunnel_list;
 	struct list_head dp_resources;
 	bool hotplug_active;
+	struct delayed_work remove_work;
 };
 
+static inline struct tb *tcm_to_tb(struct tb_cm *tcm)
+{
+	return ((void *)tcm - sizeof(struct tb));
+}
+
 struct tb_hotplug_event {
 	struct work_struct work;
 	struct tb *tb;
@@ -526,8 +535,13 @@ static void tb_scan_switch(struct tb_switch *sw)
 {
 	struct tb_port *port;
 
+	pm_runtime_get_sync(&sw->dev);
+
 	tb_switch_for_each_port(sw, port)
 		tb_scan_port(port);
+
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 }
 
 /**
@@ -602,6 +616,12 @@ static void tb_scan_port(struct tb_port *port)
 	if (!tcm->hotplug_active)
 		dev_set_uevent_suppress(&sw->dev, true);
 
+	/*
+	 * At the moment Thunderbolt 2 and beyond (devices with LC) we
+	 * can support runtime PM.
+	 */
+	sw->rpm = sw->generation > 1;
+
 	if (tb_switch_add(sw)) {
 		tb_switch_put(sw);
 		return;
@@ -662,6 +682,11 @@ static void tb_deactivate_and_free_tunnel(struct tb_tunnel *tunnel)
 		 * deallocated properly.
 		 */
 		tb_switch_dealloc_dp_resource(src_port->sw, src_port);
+		/* Now we can allow the domain to runtime suspend again */
+		pm_runtime_mark_last_busy(&dst_port->sw->dev);
+		pm_runtime_put_autosuspend(&dst_port->sw->dev);
+		pm_runtime_mark_last_busy(&src_port->sw->dev);
+		pm_runtime_put_autosuspend(&src_port->sw->dev);
 		fallthrough;
 
 	case TB_TUNNEL_USB3:
@@ -848,9 +873,20 @@ static void tb_tunnel_dp(struct tb *tb)
 		return;
 	}
 
+	/*
+	 * DP stream needs the domain to be active so runtime resume
+	 * both ends of the tunnel.
+	 *
+	 * This should bring the routers in the middle active as well
+	 * and keeps the domain from runtime suspending while the DP
+	 * tunnel is active.
+	 */
+	pm_runtime_get_sync(&in->sw->dev);
+	pm_runtime_get_sync(&out->sw->dev);
+
 	if (tb_switch_alloc_dp_resource(in->sw, in)) {
 		tb_port_dbg(in, "no resource available for DP IN, not tunneling\n");
-		return;
+		goto err_rpm_put;
 	}
 
 	/* Make all unused USB3 bandwidth available for the new DP tunnel */
@@ -889,6 +925,11 @@ static void tb_tunnel_dp(struct tb *tb)
 	tb_reclaim_usb3_bandwidth(tb, in, out);
 err_dealloc_dp:
 	tb_switch_dealloc_dp_resource(in->sw, in);
+err_rpm_put:
+	pm_runtime_mark_last_busy(&out->sw->dev);
+	pm_runtime_put_autosuspend(&out->sw->dev);
+	pm_runtime_mark_last_busy(&in->sw->dev);
+	pm_runtime_put_autosuspend(&in->sw->dev);
 }
 
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
@@ -1073,6 +1114,9 @@ static void tb_handle_hotplug(struct work_struct *work)
 	struct tb_switch *sw;
 	struct tb_port *port;
 
+	/* Bring the domain back from sleep if it was suspended */
+	pm_runtime_get_sync(&tb->dev);
+
 	mutex_lock(&tb->lock);
 	if (!tcm->hotplug_active)
 		goto out; /* during init, suspend or shutdown */
@@ -1096,6 +1140,9 @@ static void tb_handle_hotplug(struct work_struct *work)
 		       ev->route, ev->port, ev->unplug);
 		goto put_sw;
 	}
+
+	pm_runtime_get_sync(&sw->dev);
+
 	if (ev->unplug) {
 		tb_retimer_remove_all(port);
 
@@ -1149,10 +1196,17 @@ static void tb_handle_hotplug(struct work_struct *work)
 		}
 	}
 
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
+
 put_sw:
 	tb_switch_put(sw);
 out:
 	mutex_unlock(&tb->lock);
+
+	pm_runtime_mark_last_busy(&tb->dev);
+	pm_runtime_put_autosuspend(&tb->dev);
+
 	kfree(ev);
 }
 
@@ -1188,6 +1242,7 @@ static void tb_stop(struct tb *tb)
 	struct tb_tunnel *tunnel;
 	struct tb_tunnel *n;
 
+	cancel_delayed_work(&tcm->remove_work);
 	/* tunnels are only present after everything has been initialized */
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
 		/*
@@ -1239,6 +1294,8 @@ static int tb_start(struct tb *tb)
 	 * root switch.
 	 */
 	tb->root_switch->no_nvm_upgrade = true;
+	/* All USB4 routers support runtime PM */
+	tb->root_switch->rpm = tb_switch_is_usb4(tb->root_switch);
 
 	ret = tb_switch_configure(tb->root_switch);
 	if (ret) {
@@ -1281,7 +1338,7 @@ static int tb_suspend_noirq(struct tb *tb)
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
-	tb_switch_suspend(tb->root_switch);
+	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
 
@@ -1292,6 +1349,10 @@ static void tb_restore_children(struct tb_switch *sw)
 {
 	struct tb_port *port;
 
+	/* No need to restore if the router is already unplugged */
+	if (sw->is_unplugged)
+		return;
+
 	if (tb_enable_tmu(sw))
 		tb_sw_warn(sw, "failed to restore TMU configuration\n");
 
@@ -1376,12 +1437,62 @@ static void tb_complete(struct tb *tb)
 	mutex_unlock(&tb->lock);
 }
 
+static int tb_runtime_suspend(struct tb *tb)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+
+	mutex_lock(&tb->lock);
+	tb_switch_suspend(tb->root_switch, true);
+	tcm->hotplug_active = false;
+	mutex_unlock(&tb->lock);
+
+	return 0;
+}
+
+static void tb_remove_work(struct work_struct *work)
+{
+	struct tb_cm *tcm = container_of(work, struct tb_cm, remove_work.work);
+	struct tb *tb = tcm_to_tb(tcm);
+
+	mutex_lock(&tb->lock);
+	if (tb->root_switch) {
+		tb_free_unplugged_children(tb->root_switch);
+		tb_free_unplugged_xdomains(tb->root_switch);
+	}
+	mutex_unlock(&tb->lock);
+}
+
+static int tb_runtime_resume(struct tb *tb)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_tunnel *tunnel, *n;
+
+	mutex_lock(&tb->lock);
+	tb_switch_resume(tb->root_switch);
+	tb_free_invalid_tunnels(tb);
+	tb_restore_children(tb->root_switch);
+	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
+		tb_tunnel_restart(tunnel);
+	tcm->hotplug_active = true;
+	mutex_unlock(&tb->lock);
+
+	/*
+	 * Schedule cleanup of any unplugged devices. Run this in a
+	 * separate thread to avoid possible deadlock if the device
+	 * removal runtime resumes the unplugged device.
+	 */
+	queue_delayed_work(tb->wq, &tcm->remove_work, msecs_to_jiffies(50));
+	return 0;
+}
+
 static const struct tb_cm_ops tb_cm_ops = {
 	.start = tb_start,
 	.stop = tb_stop,
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
 	.complete = tb_complete,
+	.runtime_suspend = tb_runtime_suspend,
+	.runtime_resume = tb_runtime_resume,
 	.handle_event = tb_handle_event,
 	.approve_switch = tb_tunnel_pci,
 	.approve_xdomain_paths = tb_approve_xdomain_paths,
@@ -1403,6 +1514,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 	tcm = tb_priv(tb);
 	INIT_LIST_HEAD(&tcm->tunnel_list);
 	INIT_LIST_HEAD(&tcm->dp_resources);
+	INIT_DELAYED_WORK(&tcm->remove_work, tb_remove_work);
 
 	return tb;
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index dbcfa24caaf1..7c8f505e6818 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -639,7 +639,7 @@ struct tb_switch *tb_switch_alloc_safe_mode(struct tb *tb,
 int tb_switch_configure(struct tb_switch *sw);
 int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
-void tb_switch_suspend(struct tb_switch *sw);
+void tb_switch_suspend(struct tb_switch *sw, bool runtime);
 int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
-- 
2.28.0

