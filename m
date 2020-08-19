Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311B3249D2A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgHSL7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:49550 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: Xm7ZGRSNj94zajWBfKi4BIzHJdynwp7wB/+rlRNW5GwM8Da2AACoGquuDQ+HPbOHpizpKc8weX
 /hICI7GRNa/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922667"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: +wZIaCmcceJ/nNxrZd5PHt1REUyEaecsb4eqtyJOril7LjqKk9j8IdkSWu9cJeQ7hMHKIFHDh0
 TAOVRmQggITw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A1A3E463; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 08/19] thunderbolt: Tear down DP tunnels when suspending
Date:   Wed, 19 Aug 2020 14:58:54 +0300
Message-Id: <20200819115905.59834-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DP tunnels do not need the same kind of treatment as others because they
are created based on hot-plug events on DP adapter ports, and the
display stack does not need the tunnels to be enabled when resuming from
suspend. Also Tiger Lake Thunderbolt controller sends unplug event on D3
exit so this avoids that as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a6da2d0567ae..c35d5fec48f4 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -910,6 +910,29 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 	tb_tunnel_dp(tb);
 }
 
+static void tb_disconnect_and_release_dp(struct tb *tb)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_tunnel *tunnel, *n;
+
+	/*
+	 * Tear down all DP tunnels and release their resources. They
+	 * will be re-established after resume based on plug events.
+	 */
+	list_for_each_entry_safe_reverse(tunnel, n, &tcm->tunnel_list, list) {
+		if (tb_tunnel_is_dp(tunnel))
+			tb_deactivate_and_free_tunnel(tunnel);
+	}
+
+	while (!list_empty(&tcm->dp_resources)) {
+		struct tb_port *port;
+
+		port = list_first_entry(&tcm->dp_resources,
+					struct tb_port, list);
+		list_del_init(&port->list);
+	}
+}
+
 static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 {
 	struct tb_port *up, *down, *port;
@@ -1226,6 +1249,7 @@ static int tb_suspend_noirq(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 
 	tb_dbg(tb, "suspending...\n");
+	tb_disconnect_and_release_dp(tb);
 	tb_switch_suspend(tb->root_switch);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
-- 
2.28.0

