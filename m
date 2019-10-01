Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C90C3160
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfJAK3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:29:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:22449 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbfJAK3T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:29:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="194490173"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2019 03:29:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1214F130; Tue,  1 Oct 2019 13:29:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/3] thunderbolt: Read DP IN adapter first two dwords in one go
Date:   Tue,  1 Oct 2019 13:29:03 +0300
Message-Id: <20191001102905.21680-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
References: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When we discover existing DP tunnels the code checks whether DP IN
adapter port is enabled by calling tb_dp_port_is_enabled() before it
continues the discovery process. On Light Ridge (gen 1) controller
reading only the first dword of the DP IN config space causes subsequent
access to the same DP IN port path config space to fail or return
invalid data as can be seen in the below splat:

  thunderbolt 0000:07:00.0: CFG_ERROR(0:d): Invalid config space or offset
  Call Trace:
   tb_cfg_read+0xb9/0xd0
   __tb_path_deactivate_hop+0x98/0x210
   tb_path_activate+0x228/0x7d0
   tb_tunnel_restart+0x95/0x200
   tb_handle_hotplug+0x30e/0x630
   process_one_work+0x1b4/0x340
   worker_thread+0x44/0x3d0
   kthread+0xeb/0x120
   ? process_one_work+0x340/0x340
   ? kthread_park+0xa0/0xa0
   ret_from_fork+0x1f/0x30

If both DP In adapter config dwords are read in one go the issue does
not reproduce. This is likely firmware bug but we can work it around by
always reading the two dwords in one go. There should be no harm for
other controllers either so can do it unconditionally.

Link: https://lkml.org/lkml/2019/8/28/160
Reported-by: Brad Campbell <lists2009@fnarfbargle.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 410bf1bceeee..8e712fbf8233 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -896,12 +896,13 @@ int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
  */
 bool tb_dp_port_is_enabled(struct tb_port *port)
 {
-	u32 data;
+	u32 data[2];
 
-	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+	if (tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
+			 ARRAY_SIZE(data)))
 		return false;
 
-	return !!(data & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
+	return !!(data[0] & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
 }
 
 /**
@@ -914,19 +915,21 @@ bool tb_dp_port_is_enabled(struct tb_port *port)
  */
 int tb_dp_port_enable(struct tb_port *port, bool enable)
 {
-	u32 data;
+	u32 data[2];
 	int ret;
 
-	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
+			   ARRAY_SIZE(data));
 	if (ret)
 		return ret;
 
 	if (enable)
-		data |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
+		data[0] |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
 	else
-		data &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
+		data[0] &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
 
-	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
+			     ARRAY_SIZE(data));
 }
 
 /* switch utility functions */
-- 
2.23.0

