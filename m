Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC7249D2F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHSMCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:49568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgHSL7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:22 -0400
IronPort-SDR: SPbFxX9AevWWWeTISxfFlxTReWpzO40IHQhbJIzQDDi+NW2/TUqtCo8O5dnh+aUeB8Dvsai+HL
 WXH4p3UPoBVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922672"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: knPXZSxeBqB46vVg835SwDONqzistVX9LP+zgOjtUm6K3bTUQD/cl/vtWwJ2EiM92V8d9ELxy/
 czDMRiZ6stcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310762"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B38634B3; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 10/19] thunderbolt: Do not change default USB4 router notification timeout
Date:   Wed, 19 Aug 2020 14:58:56 +0300
Message-Id: <20200819115905.59834-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some early stage USB4 devices do not like that any of the enumerating
router config space fields (ROUTER_CS_1 - ROUTER_CS_4) are written after
the initial enumeration for example when entering sleep states. The
default timeout by the USB4 spec is 10 ms which should be fine for the
driver to handle.

For this reason do not change the notification timeout from the default
10 ms for USB4 routers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index de186d6ed166..e1ba8215144b 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1269,7 +1269,7 @@ static int tb_plug_events_active(struct tb_switch *sw, bool active)
 	u32 data;
 	int res;
 
-	if (tb_switch_is_icm(sw))
+	if (tb_switch_is_icm(sw) || tb_switch_is_usb4(sw))
 		return 0;
 
 	sw->config.plug_events_delay = 0xff;
@@ -1277,10 +1277,6 @@ static int tb_plug_events_active(struct tb_switch *sw, bool active)
 	if (res)
 		return res;
 
-	/* Plug events are always enabled in USB4 */
-	if (tb_switch_is_usb4(sw))
-		return 0;
-
 	res = tb_sw_read(sw, &data, TB_CFG_SWITCH, sw->cap_plug_events + 1, 1);
 	if (res)
 		return res;
-- 
2.28.0

