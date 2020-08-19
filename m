Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA3249D44
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHSMDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:03:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:31811 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: IQSHdSXZfcOWJ2HEDRWSH1vXque5nlT/GhdWsuqiIlEEp4jsHDehfiPlkfnkiUsjTEqvK6Sc8G
 dm9VJT7Qwyww==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135160295"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135160295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: Q2tBAFzBTYLZwmtUGiYdu/Dkje2Ff7CojEAcA07M6JR/2YkGOcuyLsm06vn2t2C9ROrP0r8l49
 7dOCSQaYLrqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="336938686"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8AA953D3; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 06/19] thunderbolt: No need to log an error if tb_switch_lane_bonding_enable() fails
Date:   Wed, 19 Aug 2020 14:58:52 +0300
Message-Id: <20200819115905.59834-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function already logs an error if it fails so get rid of the
duplication.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index f507815040eb..98f268a818a0 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -592,8 +592,7 @@ static void tb_scan_port(struct tb_port *port)
 	}
 
 	/* Enable lane bonding if supported */
-	if (tb_switch_lane_bonding_enable(sw))
-		tb_sw_warn(sw, "failed to enable lane bonding\n");
+	tb_switch_lane_bonding_enable(sw);
 
 	if (tb_enable_tmu(sw))
 		tb_sw_warn(sw, "failed to enable TMU\n");
@@ -1245,8 +1244,7 @@ static void tb_restore_children(struct tb_switch *sw)
 		if (!tb_port_has_remote(port))
 			continue;
 
-		if (tb_switch_lane_bonding_enable(port->remote->sw))
-			dev_warn(&sw->dev, "failed to restore lane bonding\n");
+		tb_switch_lane_bonding_enable(port->remote->sw);
 
 		tb_restore_children(port->remote->sw);
 	}
-- 
2.28.0

